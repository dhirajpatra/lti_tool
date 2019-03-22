<?php

ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
session_start();
//include_once __DIR__ . "/library/config.php";

// http://localhost/lti_v2/ltilaunchcanvasrequest.php?secret=25f9e794323b453885f5181f1b624d0b&service=pdf&id=1059

require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tool_Provider_Class.php';

unset($getParams);

if ($_SERVER['REQUEST_METHOD'] == 'GET' || $_SERVER['REQUEST_METHOD'] == 'get') {
    $getParams = null;
    $getParams = $_GET;
    $_SESSION['secret'] = $getParams['secret'];

    // need to check and authorise from database
    $tpDBObj = new tpdatabase(); //connection to TP DB
    $consumerIdCondition = " secret = '".$getParams['secret']."' AND service = '".$getParams['service']."'";
    $consumerIdFields = array('*');
    $result = $tpDBObj->select(LTI_CONSUMER_CANVAS, $consumerIdFields, $consumerIdCondition);

    if (!empty($result[0])) {
        switch ($result[0]['service']) {
//    if(!empty($getParams['secret'])) {
//        switch ($getParams['service']) {
            case 'pdf':
                $url = 'http://localhost/lti_v2/tp/tp_registration.php?action=course_1';
                //$api = 'http://phoenix-dev-pcc.hlrptech.com/api/v1/assets/'.$getParams['id'].'/retrievePath';
                $api = CP4_RETRIEVE_DEV_API.$getParams['id'].'/retrieve-path';
                $result = curlCall($url, $api);
                $result = json_decode($result);
                echo '<iframe src="' . $result->data->signedUrl . '" width="100%" height="100%"></iframe>';
            break;
            case 'video':
                $url = 'http://localhost/lti_v2/tp/tp_registration.php?action=course_1';
                $api = CP4_RETRIEVE_DEV_API . $getParams['id'] . '/retrieve-path';
                $result = curlCall($url, $api);

                $show = 'file not found';
                if ($result != $show) {
                    $show = '<video width="320" height="240" controls>
                    <source src="movie.mp4" type="video/mp4">
                    <source src="movie.ogg" type="video/ogg">
                    Your browser does not support the video tag.
                </video>';
                }
                echo $show;

            break;
            default:
            break;
        }
    }
}

/**
 * Undocumented function.
 *
 * @param [type] $url
 * @param [type] $token
 */
function curlCall($url, $api)
{
    $fields = [
        ['context_id' => '456434513'],
        ['context_label' => 'SI182'],
        ['context_title' => 'Design of Personal Environments'],
        ['launch_presentation_css_url' => 'http://www.imsglobal.org/developers/LTI/test/v1p1/lms.css'],
        ['launch_presentation_document_target' => 'frame'],
        ['launch_presentation_locale' => 'en-US'],
        ['launch_presentation_return_url' => $api],
        ['x_access_token' => x_access_token],
        ['lis_outcome_service_url' => 'http://www.imsglobal.org/developers/LTI/test/v1p1/common/tool_consumer_outcome.php?b64=MTIzNDU6OjpzZWNyZXQ='],
        ['lis_person_contact_email_primary' => 'user@school.edu'],
        ['lis_person_name_family' => 'Public'],
        ['lis_person_name_full' => 'Jane Q. Public'],
        ['lis_person_name_given' => 'Given'],
        ['lis_person_sourcedid' => 'school.edu:user'],
        ['lis_result_sourcedid' => 'feb-123-456-2929::28883'],
        ['lti_message_type' => 'basic-lti-launch-request'],
        ['lti_version' => 'LTI-2p0'],
        ['oauth_callback' => 'about:blank'],
        ['oauth_consumer_key' => '575179493f4f3'],
        ['oauth_nonce' => '93ac608e18a7d41dec8f7219e1bf6a17'],
        ['oauth_signature' => 'Xh3WjNP6eqZtnL1ov0YKxMP2fX4%3D'],
        ['oauth_signature_method' => 'HMAC-SHA1'],
        ['oauth_timestamp' => '1348093590'],
        ['oauth_version' => '1.0'],
        ['resource_link_description' => 'A weekly blog'],
        ['resource_link_id' => '120988f929-274612'],
        ['resource_link_title' => 'Weekly Blog'],
        ['roles' => 'Instructor'],
        ['tool_consumer_info_product_family_code' => 'ims'],
        ['tool_consumer_info_version' => '1.1'],
        ['tool_consumer_instance_description' => 'University of School (LMSng)'],
        ['tool_consumer_instance_guid' => 'lmsng.school.edu'],
        ['user_id' => '292832126'],
    ];

    $fields_string = '';
    foreach ($fields as $values) {
        foreach ($values as $key => $value) {
            $fields_string .= $key.'='.$value.'&';
        }
    }

    $fields_string = rtrim($fields_string, '&');

    $headers = array();
    $token = x_access_token;
    $headers[] = "x-access-token: $token";
//$headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=utf-8';
    $headers[] = 'Content-Type: text/html; charset=utf-8';

    $ch = curl_init();

    //curl_setopt($ch, CURLOPT_VERBOSE, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_URL, $api);

    // Receive server response ...
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13');

    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_ENCODING, '');
    header('Content-Type: text/html');

    $result = curl_exec($ch);
    if (curl_error($ch)) {
        $error_msg = curl_error($ch);
        error_log("Launch request curl failed. \n", 1, $error_msg);
        var_dump($error_msg);

        return false;
    }
    $info = curl_getinfo($ch);

    curl_close($ch);

    return $result;
}
