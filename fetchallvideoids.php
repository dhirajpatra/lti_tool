<?php

ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
session_start();

// http://localhost/lti_v2/ltilaunchcanvasrequest.php?secret=25f9e794323b453885f5181f1b624d0b&service=pdf&id=1059

//require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tool_Provider_Class.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/library/config.php';

$headers = array();
$token = x_access_token;
$headers[] = "x-access-token: $token";
//$headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=utf-8';
$headers[] = 'Content-Type: text/html; charset=utf-8';
$ch = curl_init();

curl_setopt($ch, CURLOPT_VERBOSE, true);
curl_setopt($ch, CURLOPT_URL, CP4_DEV_API.'?contentTypeId=8');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_FAILONERROR, true);
$result = json_decode(curl_exec($ch), true);
if (curl_error($ch)) {
    $error_msg = curl_error($ch);
    error_log("Launch request curl failed. \n", 1, $error_msg);

    return false;
}

curl_close($ch);

//echo '<pre>'; print_r($result); exit;
foreach ($result['data'] as $row) {
    $goodVideoIds[] =  $row['id'];
}
//$goodVideoIds = [1217, 1213, 1181, 1150];

if (!empty($result['data'])) {
    $ids = '<div style="">Video Contents ('.count($result['data']).')<hr>';
    foreach ($result['data'] as $value) {
        // for demo need only English content
        if (in_array($value['id'], $goodVideoIds)) {
            $ids .= '<div style="width: 200px;"><p style="margin:5px;"><a style="font-size: .8em; color:blue; text-decoration:none;" href="#" onclick = show("'.HOST.'/lti_v2/ltilaunchcanvasrequest.php?secret=25f9e794323b453885f5181f1b624d0b&service=video&id='.$value['id'].'"); >'.$value['assetCode'].'</a></p></div>';
        }
    }
    $ids .= '</div>';
}

echo $ids;
exit;
