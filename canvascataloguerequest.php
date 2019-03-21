<?php

ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
session_start();
include_once __DIR__ . "/library/config.php";

// http://localhost/lti_v2/canvascataloguerequest.php?secret=25f9e794323b453885f5181f1b624d0b

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
    <blti:title>LTI Canvas</blti:title>
    <blti:description>Testing LTI tool</blti:description>
    <blti:icon></blti:icon>
    <blti:launch_url>http://localhost/lti_v2/canvascataloguerequest.php?secret=25f9e794323b453885f5181f1b624d0b</blti:launch_url>
    <blti:extensions platform="canvas.instructure.com">
      <lticm:property name="tool_id">1111111111111</lticm:property>
      <lticm:property name="privacy_level">anonymous</lticm:property>
      <lticm:property name="domain">http://localhost/lti_v2/</lticm:property>
      <lticm:options name="course_navigation">
        <lticm:property name="url">http://localhost/lti_v2/canvascataloguerequest.php?secret=25f9e794323b453885f5181f1b624d0b</lticm:property>
        <lticm:property name="text">Catalog test</lticm:property>
        <lticm:property name="visibility">public</lticm:property>
        <lticm:property name="default">enabled</lticm:property>
        <lticm:property name="enabled">true</lticm:property>
      </lticm:options>
    </blti:extensions>
    <cartridge_bundle identifierref="BLTI001_Bundle"/>
    <cartridge_icon identifierref="BLTI001_Icon"/>
</cartridge_basiclti_link>
 */
require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tool_Provider_Class.php';

unset($getParams);

if ($_SERVER['REQUEST_METHOD'] == 'POST' || $_SERVER['REQUEST_METHOD'] == 'POST') {
    $postParams = null;
    $postParams = $_POST;

    // need to check and authorise from database
//    $tpDBObj = new tpdatabase(); //connection to TP DB
//    $consumerIdCondition = " secret = '".$postParams['secret']."'";
//    $consumerIdFields = array('*');
//    $result = $tpDBObj->select(LTI_CONSUMER_CANVAS, $consumerIdFields, $consumerIdCondition);
    //print_r($result);

    $url = HOST.'/lti_v2/fetchallpdfids.php?secret='.$postParams['secret'];
    $pdfResult = explode('&&&&', curlCall($url)); // &&&& to get first pdf link

    $url = HOST.'/lti_v2/fetchallvideoids.php?secret='.$postParams['secret'];
    $videoResult = curlCall($url);

    echo $result = '<script>function show(link){ document.getElementById("details").src = link; }</script><div id="right_panel" style="
    width:75%;
    height:100%;
    float:left; padding: 5px; "><iframe id="details" width="100%" height="100%" min-height="700px;" src="'.$pdfResult[1].'"></iframe></div><div id="left_panel" style="
    width:22%;
    height:100%;
    float:left; padding: 5px;">'.$pdfResult[0].$videoResult.'</div>';

    //echo '<h1>Catalogue</h1>'.$pdfResult[0].$videoResult;
}

/**
 * Undocumented function.
 *
 * @param [type] $url
 * @param [type] $token
 */
function curlCall($url)
{
    $headers = array();
    $token = x_access_token;
    $headers[] = "x-access-token: $token";
//$headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=utf-8';
    $headers[] = 'Content-Type: text/html; charset=utf-8';

    $ch = curl_init();

    //curl_setopt($ch, CURLOPT_VERBOSE, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_URL, $url);

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
        print_r($error_msg);

        return false;
    }
    $info = curl_getinfo($ch);

    curl_close($ch);

    return $result;
}
