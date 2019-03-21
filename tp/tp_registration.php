
<?php
                ob_start();
//		ini_set( 'error_reporting', E_ALL );
//		ini_set( 'display_errors', true );

                // basic-lti-launch-reqquest RESOURCE LAUNCH URL : http://172.16.1.55/lti_v2/tp/tp_registration.php?action=COURSE_1

                require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tool_Provider_Class.php';

                unset($postParams);

                if ($_SERVER['REQUEST_METHOD'] == 'POST' || $_SERVER['REQUEST_METHOD'] == 'post') {
                    $postParams = null;
                    $postParams = $_POST;

                    $messageType = trim($postParams['lti_message_type']);

                    if (empty($messageType)) {
                        header('Location: '.HOST.'?status=failure&message=lti_message_type_not_defined');
                    }

                    if ($messageType == 'toolproxyregistrationrequest') {
                        $ltiMessageType = $messageType;
                        $ltiVersion = trim($postParams['lti_version']);
                        $regKey = trim($postParams['reg_key']);
                        $regPassword = trim($postParams['reg_password']);
                        $tcProfileUrl = trim($postParams['tc_profile_url']);
                        $launchPresentationReturnUrl = trim($postParams['launch_presentation_return_url']);

                        if ((empty($ltiMessageType) || empty($ltiVersion) || empty($regKey) || empty($regPassword) || empty($tcProfileUrl) || empty($launchPresentationReturnUrl)) && $messageType == 'toolproxyregistrationrequest') {
                            header('Location: '.$_SERVER['HTTP_REFERER'].'?status=failure&message=input_params_missing');
                        }
                    }

                    if (count($postParams) > 0) {
                        $messageType = strtolower($messageType);
                        $tpObj = new Tool_Provider_Class();
                        if ($messageType == 'toolproxyregistrationrequest') {
                            $resp = $tpObj->toolRegisteration($postParams);
                            //var_dump($resp); die;
                            $message = $resp['message'];
                            if ($resp['status'] == 'success') {
                                $headerURL = $resp['finalreturnURL'].'?'.$message;
                            } elseif ($resp['status'] == 'failed') {
                                $headerURL = $resp['finalreturnURL'].'?status=failure&lti_errormsg='.urlencode($message);
                            }
                            header('Location: '.$headerURL);
                        } elseif ($messageType == 'basic-lti-launch-request') {
                            // Tool Launch Request handler
                            $launchResp = $tpObj->toolLaunchRequest($postParams);

                            if (isset($postParams['launch_presentation_return_url'])) {
                                $returnURL = $postParams['launch_presentation_return_url'];
                            } else {
                                $returnURL = $_SERVER['HTTP_REFERER'];
                            }

                            $message = urlencode($launchResp['message']);
                            if ($launchResp['message'] == 'success') {
                                $queryParam = 'lti_msg';
                            } else {
                                $queryParam = 'lti_errormsg';
                            }
                            $returnPathURL = $returnURL.'&status='.$launchResp['status'].'&'.$queryParam.'='.$message;
                            header('Location: '.$returnPathURL);
                        //echo "<pre>"; print_r($launchResp); die;
                        } elseif (empty($messageType)) {
                            if (isset($postParams['launch_presentation_return_url'])) {
                                $returnURL = $postParams['launch_presentation_return_url'];
                            } else {
                                $returnURL = $_SERVER['HTTP_REFERER'];
                            }
                            $message = 'lti_message_type parameters is missing';
                            $returnPathURL = $returnURL.'&status=failed&lti_errormsg='.urlencode($message);
                            header('Location: '.$returnPathURL);
                        } else {
                            if (isset($postParams['launch_presentation_return_url'])) {
                                $returnURL = $postParams['launch_presentation_return_url'];
                            } else {
                                $returnURL = $_SERVER['HTTP_REFERER'];
                            }
                            $message = 'Invalid <b>lti_message_type</b> parameters is passed';
                            $returnPathURL = $returnURL.'&status=failed&lti_errormsg='.urlencode($message);
                            header('Location: '.$returnPathURL);
                        }
                    } else {
                        $message = 'Input parameters are missing';
                        $returnURL = $_SERVER['HTTP_REFERER'];
                        $returnPathURL = $returnURL.'&status=failed&lti_errormsg='.urlencode($message);
                        header('Location: '.$returnPathURL);
                    }
                } else {
                    $message = 'Invalid HTTP request';
                    $returnURL = $_SERVER['HTTP_REFERER'];
                    $returnPathURL = $returnURL.'&status=failed&lti_errormsg='.urlencode($message);
                    header('Location: '.$returnPathURL);
                }

        include '../tp/tpAPI.php';
        $tpapiObj = new TpAPI();
        $respData = $tpapiObj->register($_POST); //die;
        if (strtolower($respData['status']) == 'success') {
            // REST API Call to get the user profile
            $userProfilePath = $respData['userProfilePath'];
            $tcProfileDataJSON = $tpapiObj->getTcprofile($userProfilePath);
            $tcProfileDataArray = json_decode($tcProfileDataJSON, true);
            $urlparams = explode('?action', $userProfilePath);

            // Needs to make an POST API CALL to the TC (endpoint URL is under services [post] method.
            // https://www.imsglobal.org/specs/ltiv2p0/implementation-guide#toc-10
            // oAuth_signature needs to be generated

            // CREATE A TOOL PROXY from TP end to TC (usually needs to send TOOL PROFILE, currently bypassing the data).
            $tempURL = $urlparams[0].'?action=tctoolproxycreation';
            $guid = $respData['guid'];
            $tcToolProxyCreationDataJSON = $tpapiObj->createToolProxyInTC($tempURL, $guid);
            //Function argument ($url) this needs to be captured from the TC profile Service URL as defined above
            $tool_proxy_guid = $respData['guid'];
            $userfinalReturnPath = $respData['finalReturnPath'].'&status=success&tool_proxy_guid='.$tool_proxy_guid;

            header('Location: '.$userfinalReturnPath);
        } elseif (strtolower($respData['status']) == 'failure') {
            echo 'Failed to register user details';
        }
        die;

                unset($tpObj);
                ob_end_flush();
?>
