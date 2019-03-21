<?php

//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', true);
//ob_start();
//session_start();
//unset($_POST);
// https://localhost/lti_v2/assignment.php?secret=25f9e794323b453885f5181f1b624d0b
/**
 * Example xml to be pasted into Canvas.
 *
 * <?xml version="1.0" encoding="UTF-8"?>
<cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0"
    xmlns:blti = "http://www.imsglobal.org/xsd/imsbasiclti_v1p0"
    xmlns:lticm ="http://www.imsglobal.org/xsd/imslticm_v1p0"
    xmlns:lticp ="http://www.imsglobal.org/xsd/imslticp_v1p0"
    xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation = "http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd
    http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0.xsd
    http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd
    http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
    <blti:title>Assignments Test LTI</blti:title>
    <blti:description>This is LTI Assignment test </blti:description>
    <blti:icon>https://localhost/lti_v2/selector.png</blti:icon>
    <blti:launch_url>https://localhost/lti_v2/assignment.php?secret=25f9e794323b453885f5181f1b624d0b</blti:launch_url>

    <blti:extensions platform="canvas.instructure.com">
      <lticm:property name="tool_id">12345678</lticm:property>
      <lticm:property name="privacy_level">anonymous</lticm:property>
      <lticm:property name="domain">https://localhost/lti_v2/</lticm:property>
      <lticm:options name="course_navigation">
        <lticm:property name="url">https://localhost/lti_v2/assignment.php?secret=25f9e794323b453885f5181f1b624d0b</lticm:property>
        <lticm:property name="text">LTI Assignment </lticm:property>
        <lticm:property name="visibility">public</lticm:property>
        <lticm:property name="default">enabled</lticm:property>
        <lticm:property name="enabled">true</lticm:property>
      </lticm:options>
      <lticm:options name="account_navigation">
        <lticm:property name="url">https://localhost/lti_v2/assignment.php?secret=25f9e794323b453885f5181f1b624d0b</lticm:property>
        <lticm:property name="text">LTI Assignment </lticm:property>
        <lticm:property name="enabled">true</lticm:property>
      </lticm:options>
      <lticm:options name="user_navigation">
        <lticm:property name="url">https://localhost/lti_v2/assignment.php?secret=25f9e794323b453885f5181f1b624d0b</lticm:property>
        <lticm:property name="text">LTI Assignment </lticm:property>
        <lticm:property name="enabled">true</lticm:property>
      </lticm:options>
    </blti:extensions>
    <cartridge_bundle identifierref="BLTI001_Bundle"/>
    <cartridge_icon identifierref="BLTI001_Icon"/>
</cartridge_basiclti_link>
 */
require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tool_Provider_Class.php';

//print_r($_REQUEST); exit;

unset($postParams);
unset($getParams);
$postParams = $_POST;

$getParams = $_REQUEST;

$tpDBObj = new tpdatabase(); //connection to TP DB

if (isset($getParams['secret'])) {
    $consumerIdCondition = " secret = '".$getParams['secret']."'";
    $consumerIdFields = array('*');
    $result = $tpDBObj->select(LTI_CONSUMER_CANVAS, $consumerIdFields, $consumerIdCondition);

    if (empty($result)) {
        return false;
    }
}

if (isset($postParams['lis_outcome_service_url']) && isset($postParams['lis_result_sourcedid']) && isset($_POST['token'])) {
    $details = [];
    //print_r($postParams);    exit;
    //insert into db
    foreach ($postParams as $question => $answer) {
        if ($question == 'token') {
            continue;
        }

        if (preg_match('/^question/i', $question)) {
            $testDetails = [
                'user_id' => 1, // need to update later
                'question' => $question,
                'answer' => $answer,
            ];

            $details[] = $testDetails;

            $testDetails = $tpDBObj->preventXssArray($testDetails);
            //echo '<pre>';        print_r($testDetails);        exit;
            $tpDBObj->insertDataInToTP(LTI_ASSIGNMENTS, $testDetails);
        }
    }

    $fakeScore = calculateScore($details);
    $secretValue = 'secret';
    $grade = sendGradeBackToLMS($_REQUEST['lis_outcome_service_url'], $_REQUEST['lis_result_sourcedid'], $fakeScore, $_REQUEST['oauth_consumer_key'], $secretValue);

    echo '<div style="margin:15%;"><h1>Thank you. Your score '.($grade * 10).' out of 10 has been posted to Canvas.</h1><hr><h2>Click on Grades menu to see your score.</h2><div>'.print_r($details).'</div><div>';
} else {
    require_once 'resources/question1.php';
    die();
}

/**
 * this will calculate the score.
 *
 * @param [type] $testDetails
 */
function calculateScore($testDetails)
{
    $score = 0;
    foreach ($testDetails as $values) {
        $question = $values['question'];
        $answer = $values['answer'];

        switch ($question) {
            case 'question-1-answers':
            if ($answer == 'B') {
                ++$score;
            }
            break;
            case 'question-2-answers':
            if ($answer == 'A') {
                ++$score;
            }
            break;
            case 'question-3-answers':
            if ($answer == 'C') {
                ++$score;
            }
            break;
            case 'question-4-answers':
            if ($answer == 'A') {
                ++$score;
            }
            break;
            case 'question-5-answers':
            if ($answer == 'C') {
                ++$score;
            }
            break;
        }
    }

    // grace marks
    if ($score == 0) {
        $score = 4;
    }

    return (float) ($score / 5);
}

function sendGradeBackToLMS($url, $sourceId, $grade, $key, $secretValue)
{
    $headerResponseStringData = array();
    $url = trim($url);
    $oauth_consumer_key = trim($key);
    $xmldata = getPOXGradeRequest();
    $message = uniqid();
    $grade = (float) $grade;
    $xml = str_replace(
        array('MESSAGE', 'SOURCEDID', 'GRADE'),
        array($message, $sourceId, $grade),
        $xmldata);
    $tpBodyContent = trim($xml);

    $headerResponseStringData = sendOAuthBody('POST', $url, $oauth_consumer_key, $secretValue, 'application/xml', $tpBodyContent);

    $headersArr = explode('Content-Type:', $headerResponseStringData);
    $authHeader = $headersArr[0];
    // var_dump($authHeader);
    // exit;
    $headers = array();
    $headers[] = 'Content-Type: application/xml; charset=utf-8';
    $headers[] = trim($authHeader);
    // // //$headers[] = 'Cache-Control: no-cache';
    // echo '<pre>', htmlentities($tpBodyContent), '</pre>';
    // print_r($headers);
    // exit;

    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, '<?xml version = "1.0" encoding = "UTF-8"?><imsx_POXEnvelopeRequest xmlns = "http://www.imsglobal.org/lis/oms1p0/pox"><imsx_POXHeader><imsx_POXRequestHeaderInfo><imsx_version>V1.0</imsx_version><imsx_messageIdentifier>'.$message.'</imsx_messageIdentifier></imsx_POXRequestHeaderInfo></imsx_POXHeader><imsx_POXBody><replaceResultRequest><resultRecord><sourcedGUID><sourcedId>'.$sourceId.'</sourcedId></sourcedGUID><result><resultScore><language>en</language><textString>'.$grade.'</textString></resultScore></result></resultRecord></replaceResultRequest></imsx_POXBody></imsx_POXEnvelopeRequest>');
    curl_setopt($ch, CURLOPT_POST, 1);

    // $headers = array();
    // $headers[] = 'Content-Type: application/xml; charset=utf-8';
    // $headers[] = 'Authorization:  OAuth realm="",oauth_version="1.0",oauth_nonce="3b270af7b2945935d6076c9e55d9a158",oauth_timestamp="1538313604",oauth_consumer_key="key",oauth_body_hash="TjTwb8MguSTLqvIFANv4kLbPVvQ%3D",oauth_signature_method="HMAC-SHA1",oauth_signature="LvAwmopXcWhxaA6B4dyBwqNJVbk%3D"';
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        echo 'Error:'.curl_error($ch);
    }
    curl_close($ch);

    //var_dump($result);

    $information = curl_getinfo($ch);
    //var_dump($information);

    //echo $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    return $grade;
}
