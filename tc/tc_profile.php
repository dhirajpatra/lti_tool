<?php
/*
require 'tcAPI.php';
$tcObj = new tcAPI;
$userId = $_REQUEST['user_id'];
echo $tcObj->profile($userId);
*/
include('/library/database.php');
$returnData = $dbHandler->selectQuery;
print_r($returnData); die;


?>
