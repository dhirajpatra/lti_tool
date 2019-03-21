<?php
//echo "<PRE>"; echo phpinfo(); die;
	if(isset($_REQUEST['action'])){
		//ini_set( 'error_reporting', E_ALL );
		//ini_set( 'display_errors', true ); 
		include('../tc/tcAPI.php');
		$tcObj = new tcAPI();
		$methodName = $_REQUEST['action'];
                
                $urlPath = $_SERVER['REQUEST_URI'];
                
//                $data = explode('tc.php?action=',$urlPath);
//                $queryPara = explode('&status',$data[1]);
//                $methodName = $queryPara[0];
                
		switch($methodName) {
                    case "registration" :
                            echo $tcObj->registration();
                            break;

                    case "profile" :
                            echo $tcObj->getTcProfile();
                            break;

                    case "tpregister" :
                            echo $tcObj->tcregister();
                            break;

                    case "tctoolproxycreation" :
                            $data = NULL;
                            $headerInfo = apache_request_headers();
                            $data = file_get_contents("php://input");

                            echo $tcObj->tctoolproxycreationProcess($data);
                            break;

                    case "finalReturnPath" :
                            echo $tcObj->returnurl();
                            break;
                        
//                    case "finalReturnPath" :
//                            echo $tcObj->returnurl();
//                            break;

                    default :
                            echo $tcObj->index();
		}
	}
?>
