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
curl_setopt($ch, CURLOPT_URL, CP4_DEV_API.'?contentTypeId=1');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_FAILONERROR, true);
$result = json_decode(curl_exec($ch), true);
if (curl_error($ch)) {
    $error_msg = curl_error($ch);
    error_log("Launch request curl failed. \n", 1, $error_msg);
    echo CP4_DEV_API.'?contentTypeId=1' . " Launch request curl failed. \n", 1, $error_msg;
    return false;
}

curl_close($ch);

//echo '<pre>'; print_r($result); exit;
foreach ($result['data'] as $row) {
    $goodPdfIds[] =  $row['id'];
}

//$goodPdfIds = [4866, 4859, 4826, 4819, 4818, 4817, 4800, 4759, 4758, 4757, 4756, 4743, 4674, 4673, 4672, 4671, 4670, 4669, 4668, 4667, 4666, 4665, 4562, 4552, 4547, 4540, 4539, 4538, 4537, 4536, 4535, 4534, 4533, 4532];

if (!empty($result['data'])) {
    $ids = '<hr><div style="">PDF Contents ('.count($result['data']).')<hr>';
    $flag = 0;

    foreach ($result['data'] as $value) {
        // for demo need only English content
        if (in_array($value['id'], $goodPdfIds)) {
            if ($flag == 0) {
                // take the first pdf call default
                $first_pdf_url = HOST.'/lti_v2/ltilaunchcanvasrequest.php?secret=25f9e794323b453885f5181f1b624d0b&service=pdf&id='.$value['id'];
            }

            $flag = 1;

            $ids .= '<div style="width: 200px;"><p style="margin:5px;"><a style="font-size: .8em; color:blue; text-decoration:none;" href="#" onclick = show("'.HOST.'/lti_v2/ltilaunchcanvasrequest.php?secret=25f9e794323b453885f5181f1b624d0b&service=pdf&id='.$value['id'].'"); >'.$value['assetCode'].'</a></p></div>';
        }
    }
    $ids .= '</div>&&&&'.$first_pdf_url;
}

echo $ids;
exit;
