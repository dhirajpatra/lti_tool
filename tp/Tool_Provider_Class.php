<?php

/**
 * Description of Tool_Provider_Class.
 *
 * @author srinivasu
 */
require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/util/lti_util.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Tp_Launch_Lti.php';

function __autoload($class_name)
{
    require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/library/'.$class_name.'.php';
}

class Tool_Provider_Class extends Tp_Launch_Lti
{
    //put your code here

    public $tpDBObj;
    public $oauthObj;
    public $logFilePath;

    // Class constructor method
    public function __construct()
    {
        $this->tpDBObj = new tpdatabase(); //connection to TP DB
        $this->oauthObj = new OAuthRequest('POST', HOST);
        //$this->logFilePath = "/var/www/html/lti_v2/logs/tool_registration_logs.txt";
        //$this->logFilePath = "/var/www/html/lti_v2/logs/tool_log.txt";
        $this->logFilePath = DOCUMENT_ROOT.'/logs/tool_log.txt';
        $this->resourceLaunchLogfilePath = DOCUMENT_ROOT.'/logs/resource_launch_logs.txt';
    }

    /**
     * @functionality - Will register TC with the TP.
     *
     * @param - input [array] $params - Registration posted values. output [string] status (success/failed) as a query string to
     *                                TC defined return URL.
     *
     * @copyright - (2016) Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     */
    public function toolRegisteration($postParams = array())
    {
        if (count($postParams) > 0) {
            $this->logErrorMessage(" ###### Tool Registration (TR) request initiated from URL '".$_SERVER['HTTP_REFERER']."'");
            //variable initialization
            $userprofileURL = $launchPresentationReturnURL = null;

            //Validating the mandatory fields
            $postParams = $this->tpDBObj->preventXssArray($postParams);
            $previousUrlPath = 'http://localhost/lti_v2/'; //$_SERVER['HTTP_REFERER'];
            $validationResp = $this->validateRegistrationValues($postParams, $previousUrlPath);

            if ($validationResp['status'] == 'failed') {
                $this->logErrorMessage($validationResp['message']);
                $returnArr['status'] = 'failed';
                $returnArr['message'] = $validationResp['message'];
                $returnArr['finalreturnURL'] = $validationResp['finalreturnURL'];

                return $returnArr;
            }

            //Required field validations
            $reg_key = $postParams['reg_key'];
            $reg_password = $postParams['reg_password'];
            $profileUrl = $postParams['tc_profile_url'];
            $lti_version = $postParams['lti_version'];
            $launchPresentationReturnURL = $postParams['launch_presentation_return_url'];

            // checking for the Registration request with in last one hour
            $proxyFields = array('tool_proxy_reg_date');
            $proxyCondition = " tool_proxy_reg_key ='".$reg_key."' AND tool_proxy_reg_password ='".$reg_password."' AND tool_proxy_reg_status != 'F' ORDER BY `tool_proxy_reg_id` DESC LIMIT 1 ";

            $secretRespData = null;
            $secretRespData = $this->tpDBObj->select(REGISTRATION_PROXY_TABLE, $proxyFields, $proxyCondition);

            if (isset($secretRespData) && is_array($secretRespData) && count($secretRespData) > 0) {
                $previousReg_DTS = $secretRespData[0]['tool_proxy_reg_date'];
                $previousTimeStamp = strtotime($previousReg_DTS);
                $currentTimeStamp = time();
                $timeDiff = $currentTimeStamp - $previousTimeStamp;
                $oneHour = 3600;
                // Currently session time is for one hour
                // To make sure that the same user will not try to register again with the already defined
                // credientials with in last 1 hour of successful registration
                if ($timeDiff <= $oneHour) {
                    $errorMessage = 'already registration request has been requested with the same credentials within last 60 mins';
                    $errorMessageLog = "Already registration request is requested with the registration key = '".$reg_key."' within last 60 mins";
                    $this->logErrorMessage($errorMessageLog);
                    $returnArr['status'] = 'failed';
                    $returnArr['message'] = $errorMessage;
                    $returnArr['finalreturnURL'] = $launchPresentationReturnURL;
                    unset($secretRespData);

                    return $returnArr;
                }
            }

            // variables for tool registration
            $oauth_consumer_key = $reg_key;

            //Check for URL format for passing the LTI_VERSION inthe TC profile URL as a Query String
            $queryString = parse_url($postParams['tc_profile_url'], PHP_URL_QUERY);
            if ($queryString) {
                $userprofileURL = trim($postParams['tc_profile_url']).'&amp;lti_version='.$lti_version;
            } else {
                $userprofileURL = trim($postParams['tc_profile_url']).'?lti_version='.$lti_version;
            }

            $dts = date('Y-m-d H:i:s');
            $insertArray = array(
                'lti_consumer_secret_id' => '1',
                'tool_proxy_reg_lti_version' => $lti_version,
                'tool_proxy_reg_key' => $reg_key,
                'tool_proxy_reg_password' => $reg_password,
                'tool_proxy_return_url' => $launchPresentationReturnURL,
                'tool_proxy_reg_date' => $dts,
                'tool_proxy_update_date' => $dts,
                'tool_consumer_profile' => '{
                    "@context": [
                      "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",
                      {
                        "tcp": "http://mylocal/sakai-lti-test-master/106aff6"
                      }
                    ],
                    "@type": "ToolConsumerProfile",
                    "@id": "http://mylocal/sakai-lti-test-master/106aff6",
                    "lti_version": "LTI-2p0",
                    "guid": "106aff6",
                    "product_instance": {
                      "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",
                      "product_info": {
                        "product_name": {
                          "default_value": "Sakai LTI 2.0 Test Harness",
                          "key": "product.name"
                        },
                        "product_version": "0.1",
                        "description": {
                          "default_value": "Dr. Chuck Online",
                          "key": "product.version"
                        },
                        "technical_description": {
                          "default_value": "LTI 1, 1.1 and 2.0 compliant",
                          "key": "product.technicalDescription"
                        },
                        "product_family": {
                          "code": "SakaiTestOs",
                          "vendor": {
                            "code": "www.sakaiproject.org",
                            "vendor_name": {
                              "default_value": "Sakai",
                              "key": "product.vendor.name"
                            },
                            "description": {
                              "default_value": "Sakai is an Open Source Learning Environment",
                              "key": "product.vendor.description"
                            },
                            "website": "http://www.sakaiproject.org/",
                            "timestamp": "2012-07-09T012:08:16-04:00",
                            "contact": {
                              "email": "support@sakaiproject.org"
                            }
                          }
                        }
                      },
                      "support": {
                        "email": "drchuck@gmail.com"
                      },
                      "service_owner" : {
                        "@id" : "http://state.university.edu/",
                        "timestamp" : "2012-03-28T09:08:16-04:00",
                        "service_owner_name" : {
                          "default_value" : "State University",
                          "key" : "service_owner.name"
                        },
                        "description" : {
                          "default_value" : "A fictitious university.",
                          "key" : "service_owner.description"
                        },
                        "support" : {
                          "email" : "techsupport@university.edu"
                        }
                      },
                      "service_provider" : {
                        "@id" : "http://yasp.example.com/ServiceProvider",
                        "guid" : "yasp.example.com",
                        "timestamp" : "2012-03-28T09:08:16-04:00",
                        "service_provider_name" : {
                          "default_value" : "Your Application Service Provider",
                          "key" : "service_provider.name"
                        },
                        "description" : {
                          "default_value" : "YASP is a fictitious application service provider",
                          "key" : "service_provider.description"
                        },
                        "support" : {
                          "email" : "support@yasp.example.com"
                        }
                      }
                    },
                    "capability_offered": [
                          "User.id",
                          "User.username",
                          "CourseSection.sourcedId",
                          "Person.sourcedId",
                          "Person.name.full",
                          "Membership.role",
                         "Person.name.given" ,
                         "Person.name.family" ,
                         "Person.email.primary" ,
                         "User.image" ,
                         "Result.sourcedId" ,
                         "Result.autocreate",
                         "Result.sourcedId"
                    ],
                    "service_offered": [
                      {
                        "@type": "RestService",
                        "@id": "tcp:ToolProxy.collection",
                        "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",
                        "format": ["application/vnd.ims.lti.v2.toolproxy+json"],
                        "action": [ "POST" ]
                      },
                      {
                        "@type" : "RestService",
                        "@id" : "tcp:ToolProxy.item",
                        "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",
                        "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],
                        "action" : ["GET", "PUT"]
                      },
                      {
                        "@type" : "RestService",
                        "@id" : "tcp:Result.item",
                        "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",
                        "format" : ["application/vnd.ims.lis.v2.result+json"],
                        "action" : ["GET", "PUT"]
                      },
                      {
                        "@type" : "RestService",
                        "@id" : "tcp:LtiLinkSettings",
                        "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",
                        "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],
                        "action" : ["GET", "PUT"]
                      },
                      {
                        "@type" : "RestService",
                        "@id" : "tcp:ToolProxyBindingSettings",
                        "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",
                        "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],
                        "action" : ["GET", "PUT"]
                      },
                      {
                        "@type":"RestService",
                        "@id" : "tcp:ToolProxySettings",
                        "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",
                        "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],
                        "action" : ["GET", "PUT"]
                      },
                      {
                        "@type": "RestService",
                        "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",
                        "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",
                        "format": ["application/vnd.ims.lti.v1.outcome+xml"],
                        "action": [ "POST" ]
                      }
                    ]
                  }',
                  'tool_proxy_id' => '',
                  'tool_proxy_prod_guid' => '',
                  'tool_proxy_user_guid' => '',
                  'tool_proxy_error_msg' => '',
                );

            //$insertArray = $this->tpDBObj->preventXssArray($insertArray);
            $queryRespData = $this->tpDBObj->insertDataInToTP(REGISTRATION_PROXY_TABLE, $insertArray);

//            if(isset($_SESSION['tool_proxy_reg_id'])){
//                unset($_SESSION['tool_proxy_reg_id']);
//                $_SESSION['tool_proxy_reg_id'] = $queryRespData;
//            }

            if ($queryRespData > 0) { // TC registration request info started successfully
                try {
                    // GET TC Profile Info
                    $tcProfileJSONData = $this->getToolConsumerProfileData($userprofileURL);

                    $tcProfileArrayData = json_decode($tcProfileJSONData, true);
                    if (is_array($tcProfileArrayData) && count($tcProfileArrayData) > 0) {
                        // UPDATE THE BASIC TABLE INFO
                        $productFamilyData = $tcProfileArrayData['product_instance']['product_info']['product_family']['vendor'];
                        $tcDomain = $productFamilyData['website'];
                        $tcEmail = $productFamilyData['contact']['email'];
                        if (empty($tcDomain) || empty($tcEmail)) {
                            // UPDATE the last inserted record status to F & update ERR_MESSSAGE FIELD
                            $errMsg = 'Tool consumer email & domain details missing in the Profile request';
                            $updateTable['tool_proxy_error_msg'] = $errMsg;
                            $updateTable['tool_proxy_reg_status'] = 'F';
                            $updateCondition = ' tool_proxy_reg_id = '.trim($queryRespData);
                            $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateTable, $updateCondition);

                            $this->logErrorMessage($errMsg);

                            return array('status' => 'failed', 'message' => $errMsg, 'finalreturnURL' => $launchPresentationReturnURL);
                            unset($errMsg);
                        }
                        $consumerIdCondition = " lti_consumer_email ='".$tcEmail."' AND lti_consumer_domain = '".$tcDomain."'";
                        $consumerIdFields = array('lti_consumer_secret_id');
                        $toolconsumerId = $this->tpDBObj->select(LTI_CONSUMER_SECRET, $consumerIdFields, $consumerIdCondition);

                        if (count($toolconsumerId) < 1) {
                            $msg = 'Tool consumer details not available with the system. Contact Tool Provider administrator';
                            $updateTable['tool_proxy_error_msg'] = $msg;
                            $updateTable['tool_proxy_reg_status'] = 'F';
                            $updateCondition = ' tool_proxy_reg_id = '.trim($queryRespData);
                            $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateTable, $updateCondition);

                            $logMsg = "Tool consumer details '".$tcEmail."' & "
                                    ." '".$tcDomain."'not available with the system. Contact Tool Provider administrator.";
                            $this->logErrorMessage($logMsg);

                            return array('status' => 'failed', 'message' => $msg, 'finalreturnURL' => $launchPresentationReturnURL);
                            unset($msg);
                        }

                        $secretKeyId = $toolconsumerId[0]['lti_consumer_secret_id'];
                        $updateData['tool_consumer_profile'] = $tcProfileJSONData;
                        $updateData['lti_consumer_secret_id'] = $secretKeyId;
                        $updateData['tool_proxy_update_date'] = date('Y-m-d H:i:s');
                        $updateCondition = ' tool_proxy_reg_id = '.$queryRespData;
                        $updatedStatus = $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateData, $updateCondition);
                        if (!$updatedStatus) {
                            $err_msg = 'Internal Error occured during processing the request';
                            $updateTable['tool_proxy_error_msg'] = $err_msg;
                            $updateTable['tool_proxy_reg_status'] = 'F';
                            $updateCondition = ' tool_proxy_reg_id = '.trim($queryRespData);
                            $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateTable, $updateCondition);
                            $this->logErrorMessage($err_msg);

                            return array('status' => 'failed', 'message' => $err_msg, 'finalreturnURL' => $launchPresentationReturnURL);
                            unset($err_msg);
                        }
                    } else {
                        $errmsg_info = 'No information available for tool consumer profile';
                        $updateTable['tool_proxy_error_msg'] = $errmsg_info;
                        $updateTable['tool_proxy_reg_status'] = 'F';
                        $updateCondition = ' tool_proxy_reg_id = '.trim($queryRespData);
                        $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateTable, $updateCondition);

                        $this->logErrorMessage($errmsg_info);

                        return array('status' => 'failed', 'message' => $errmsg_info, 'finalreturnURL' => $launchPresentationReturnURL);
                        unset($errmsg_info);
                    }

                    $newToolProxyRegisterURL = $this->checkCapabilitiesServicesOffered($tcProfileArrayData, $queryRespData, $secretKeyId);
                    $guid = $tcProfileArrayData['guid'];
                    $this->logErrorMessage('Validation of Capabilities and Services offered completed. GUID - '.$guid);
                    if ($newToolProxyRegisterURL['status'] == 'failed') {
                        $updateTable['tool_proxy_error_msg'] = $newToolProxyRegisterURL['message'];
                        $updateTable['tool_proxy_reg_status'] = 'F';
                        $updateCondition = ' tool_proxy_reg_id = '.trim($queryRespData);
                        $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $updateTable, $updateCondition);
                        $this->logErrorMessage($newToolProxyRegisterURL['message']);

                        return array('status' => 'failed',
                            'message' => $newToolProxyRegisterURL['message'],
                            'finalreturnURL' => $launchPresentationReturnURL, );
                    }

                    // POST THE data to the TC during NEW TOOL PROXY REGISTER process
                    // PRODUCT_INSTANCE will have one set with multiple product_info & single GUID under product_instance
                    $consumerProductInstanceGUID = $tcProfileArrayData['product_instance']['guid'];
                    $consumerGUID = $tcProfileArrayData['guid'];
                    //$tcProfileGUID = $tcProfileArrayData['guid'];
                    $consumerDomain = $tcProfileArrayData['product_instance']['product_info']['product_family']['vendor']['website'];
                    $consumerEmail = $tcProfileArrayData['product_instance']['product_info']['product_family']['vendor']['contact']['email'];
                    $newToolProxyRegisterURL = $newToolProxyRegisterURL['message'];

                    // TO-DO - to be deleted later on once we get the actual path
                    $path = $_SERVER['HTTP_REFERER'];
                    $newToolProxyRegisterURL = str_replace('tc.php?action=registration', 'tc_register.php', $path);

                    $toolProxyRegistration = $this->postToolProxyRegisterToToolConsumer($newToolProxyRegisterURL, $oauth_consumer_key, $consumerDomain, $consumerEmail);
                    $this->logErrorMessage("Posting the Tool Profile details to Tool Consumer completed. Tool registration URL : '".$newToolProxyRegisterURL."' & OAuth Consumer Key : '".$oauth_consumer_key."'");

                    $replyStatus = 'failure';
                    $tool_guid = '';
                    if (is_array($toolProxyRegistration['curlGetInfo']) && count($toolProxyRegistration['curlGetInfo']) > 0 && $toolProxyRegistration['status'] == 'success') {
                        if ($toolProxyRegistration['curlGetInfo']['http_code'] == 201) {
                            $replyStatus = 'success';
                            $tool_proxy_guidArray = explode('tool_proxy_guid', $toolProxyRegistration['message']);
                            $tool_proxy_guidData = explode('}', $tool_proxy_guidArray[1]);
                            $tool_guid = str_replace(array('":', '}', '"'), '', $tool_proxy_guidArray[1]);

                            $finalUpdateData['tool_proxy_prod_guid'] = $consumerProductInstanceGUID;
                            $finalUpdateData['tool_proxy_user_guid'] = $consumerGUID;

                            if ($tool_guid) {
                                $finalUpdateData['tool_proxy_id'] = $tool_guid;
                                $finalUpdateData['tool_proxy_reg_status'] = 'S';
                            } else {
                                $finalUpdateData['tool_proxy_reg_status'] = 'F';
                            }
                            $updateCondition = ' tool_proxy_reg_id = '.$queryRespData;
                            $updatedData = $this->tpDBObj->updateData(REGISTRATION_PROXY_TABLE, $finalUpdateData, $updateCondition);
                            if ($updatedData) {
                                $urlparameters = 'status='.$replyStatus.'&tool_guid='.$tool_guid;
                                $this->logErrorMessage('Tool Registration process completed successfully. ');

                                return array('status' => 'success', 'message' => $urlparameters, 'finalreturnURL' => $launchPresentationReturnURL);
                            }
                        } else {
                            $msg = $toolProxyRegistration['curlGetInfo']['http_code'];
                            $this->logErrorMessage($msg);

                            return array('status' => 'failed', 'message' => $msg, 'finalreturnURL' => $launchPresentationReturnURL);
                        }
                    } else {
                        $this->logErrorMessage($toolProxyRegistration['message']);

                        return array('status' => 'failed', 'message' => $toolProxyRegistration['message'], 'finalreturnURL' => $launchPresentationReturnURL);
                    }
                } catch (Exception $ex) {
                    $message = $ex->getMessage();
                    $this->logErrorMessage($message);

                    return array('status' => 'failed', 'message' => $message, 'finalreturnURL' => $launchPresentationReturnURL);
                }
            }
        } else {
            return array('status' => 'failed', 'message' => 'invalid HTTP request', 'finalreturnURL' => $_SERVER['PHP_REFERER']);
        }
    }

    /**
     * @functionality - Fecth Tool Consumer Profile using HTTP REST GET request.
     *
     * @param - input [string] $userprofileURL - TC profile URL. output [JSON-data] TC profile info
     *
     * @copyright - (2016) Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     */
    private function getToolConsumerProfileData($userprofileURL = null)
    {
        $this->logErrorMessage(" Fetching Tool Consumer profile started. URL : '".$userprofileURL."'");

        if (isset($userprofileURL)) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $userprofileURL);
            //if it is set to true, data is returned as string instead of outputting it.
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
            $output = curl_exec($ch);
            $this->logErrorMessage(" Fetching Tool Consumer profile completed.  URL : '".$userprofileURL."'");
            if ($output === false) {
                throw new Exception('Failed to retrieve tool consumer profile.');
            }

            return $output;
            curl_close($ch);
        }

        return false;
    }

    /**
     * @functionality - Cross verify the Capabilities / Services capture from the TC Profile data.
     *
     * @param - input [array] $tcProfileArrayData - TC Profile Data. output [boolean/string] URL to register tool proxy / Boolean(FALSE)
     *
     * @copyright - (2016) Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     */
    public function checkCapabilitiesServicesOffered($tcProfileArrayData = array(), $toolProxyRegID = null, $secretKeyId = null)
    {
        if (is_array($tcProfileArrayData) && count($tcProfileArrayData) > 0 && $secretKeyId > 0 && $toolProxyRegID > 0) {
            $guid = $tcProfileArrayData['guid'];
            $this->logErrorMessage('Validation of Capabilities and Services offered started. GUID - '.$guid);
            $tcCapabilityOffered = $tcProfileArrayData['capability_offered'];
            $tcServiceOffered = $tcProfileArrayData['service_offered'];
            $tcCapabilityOffered = array_map('strtolower', $tcCapabilityOffered);

            $capabilitiesMatchingFlag = $servicesOfferedMatchingFlag = false;
            // CHECKS for CAPABILITIES
            if (count($tcCapabilityOffered) > 0) {
                $tableFields = array('capability_name', 'capability_id');
                $capabilityCond = 'capability_status = '.ACTIVE;
                $dbCapabilitiesList = $this->tpDBObj->select(LTI_CAPABILITIES, $tableFields, $capabilityCond);
                if ($dbCapabilitiesList) {
                    $capabilityNameList = array();
                    foreach ($dbCapabilitiesList as $k => $v) {
                        $capabilityNameList[] = $v['capability_name'];
                        $capabilityIDList[$v['capability_name']] = $v['capability_id'];
                    }

                    $capabilitiesDifference = array_intersect($capabilityNameList, $tcCapabilityOffered);
                    //Currently NOT REQUIRED
                    //$extraCapabilitiesFromTC = array_diff($tcCapabilityOffered,$capabilityNameList);

                    // check atleast one capabilities is matching
                    if (count($capabilitiesDifference) > 0) {
                        // CAPTURE THE TOOL CONSUMER DEFINED CAPABILITES
                        $tcCapabilitiesInsertArr = array();
                        $tcCapabilitiesInsertArr['lti_tc_capability_id'] = null;
                        $tcCapabilitiesInsertArr['tool_proxy_reg_id'] = (int) $toolProxyRegID;
                        $tcCapabilitiesInsertArr['lti_consumer_secret_id'] = (int) $secretKeyId;
                        $tcCapabilitiesInsertArr['lti_tc_capability_insert_dts'] = date('Y-m-d H:i:s');
                        $loopCount = $insertCount = 0;
                        foreach ($tcCapabilityOffered as $k1 => $v1) {
                            $loopCount = $loopCount + 1;
                            $tcCapabilitiesInsertArr['capability_id'] = (int) $capabilityIDList[$v1];
                            $tcCapabilitiesInsertArr = $this->tpDBObj->preventXssArray($tcCapabilitiesInsertArr);
                            $insertId = $this->tpDBObj->insertDataInToTP(LTI_TOOLCONSUMER_CAPABILITIES, $tcCapabilitiesInsertArr);
                            if ($insertId > 0) {
                                $insertCount = $insertCount + 1;
                            }
                        }

                        if ($insertCount == $loopCount) {
                            $capabilitiesMatchingFlag = true;
                        }
                    } else {
                        return array('status' => 'failed', 'message' => 'Invalid Capabilities defined');
                    }
                }
            } else {
                return array('status' => 'failed', 'message' => 'Capabilities information is not defined');
            }

            // CHECKS for SERVICES
            if (count($tcServiceOffered) > 0 && $capabilitiesMatchingFlag) {
                $checkForValue = 'application/vnd.ims.lti.v2.toolproxy+json';
                $checkForvalueKey = 'format';
                $tcPostURL = null;
                foreach ($tcServiceOffered as $soKey => $soVal) {
                    $searchParamData = $soVal[$checkForvalueKey];

                    if (is_array($searchParamData)) {
                        if (in_array($checkForValue, $searchParamData)) {
                            if (strtoupper($soVal['action'][0]) == 'POST') {
                                $tcPostURL = $soVal['endpoint'];
                                if (isset($tcPostURL)) {
                                    // CAPTURE THE TC SERVICES DETAILS
                                    $insertTcServicesOffered['lti_tc_services_id'] = null;
                                    $insertTcServicesOffered['tool_proxy_reg_id'] = (int) $toolProxyRegID;
                                    $insertTcServicesOffered['lti_consumer_secret_id'] = (int) $secretKeyId;
                                    $insertTcServicesOffered['lti_tc_services_created_dts'] = date('Y-m-d H:i:s');
                                    $serviceInsertCount = $serviceLoopCount = 0;
                                    foreach ($tcServiceOffered as $tcsoKey => $tcsoVal) {
                                        $serviceLoopCount = $serviceLoopCount + 1;
                                        $insertTcServicesOffered['lti_tc_services_type'] = $tcsoVal['@type'];
                                        $insertTcServicesOffered['lti_tc_services_id_val'] = $tcsoVal['@id'];
                                        $insertTcServicesOffered['lti_tc_services_endpoint'] = $tcsoVal['endpoint'];
                                        $formatString = implode(' # ', $tcsoVal['format']);
                                        $actionString = implode(' & ', $tcsoVal['action']);
                                        $insertTcServicesOffered['lti_tc_services_format'] = $formatString;
                                        $insertTcServicesOffered['lti_tc_services_action'] = $actionString;
                                        $insertTcServicesOffered = $this->tpDBObj->preventXssArray($insertTcServicesOffered);
                                        $servicesInsertId = $this->tpDBObj->insertDataInToTP(LTI_TOOLCONSUMER_SERVICES, $insertTcServicesOffered);
                                        if ($servicesInsertId > 0) {
                                            $serviceInsertCount = $serviceInsertCount + 1;
                                        }
                                    }
                                    // RETURN THE URL To register a new Tool Proxy.
                                    return array('status' => 'success', 'message' => $tcPostURL);
                                } else {
                                    return array('status' => 'failed', 'message' => 'Post request to Tool Consumer URL path not defined.');
                                }
                            } else {
                                return array('status' => 'failed', 'message' => 'POST Method not found for application/vnd.ims.lti.v2.toolproxy+json in order to do tool_registration');
                            }
                        } else {
                            return array('status' => 'failed', 'message' => 'Must have an application/vnd.ims.lti.v2.toolproxy+json service available in order to do tool_registration');
                        }
                    }
                }
            } else {
                return array('status' => 'failed', 'message' => 'Services offered are not defined');
            }
        }

        return array('status' => 'failed', 'message' => 'Input params are missing in Capabilities and Services');
    }

    /**
     * @functionality - Will make a HTTP POST request to the TC defined URL by generating the oAuth_signature & other params
     *
     * @param - input [string] $newToolProxyRegisterURL - URL to post data, [string] $oauth_consumer_key - to generate oAuth,
     *                                                  [string] $consumerDomain & $consumerEmail- To identify the TC during tool proxy registration to get the secret key
     *
     * @copyright - (2016) Impelsys India Pvt. Ltd.
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     */
    public function postToolProxyRegisterToToolConsumer($newToolProxyRegisterURL = null, $oauth_consumer_key = null, $consumerDomain = null, $consumerEmail = null)
    {
        $this->logErrorMessage("Posting the Tool Profile details to Tool Consumer started. Tool registration URL : '".$newToolProxyRegisterURL."' & OAuth Consumer Key : '".$oauth_consumer_key."'");
        if (isset($newToolProxyRegisterURL) && isset($oauth_consumer_key) && $consumerDomain && $consumerEmail) {
            // FETCH THE CONSUMER SECRET KEY
            $conditionParams = array('consumerEmail' => $consumerEmail, 'consumerDomain' => $consumerDomain);
            $conditionFilteredParams = $this->tpDBObj->preventXssArray($conditionParams);

            $consumerEmail = $conditionFilteredParams['consumerEmail'];
            $consumerDomain = $conditionFilteredParams['consumerDomain'];
            $fields = array('lti_consumer_secret_key', 'tp_profile_temp_data');
            $condition = " lti_consumer_email ='".$consumerEmail."' AND lti_consumer_domain ='".$consumerDomain."' "
                    .'AND lti_consumer_status = '.ACTIVE;
            $secretRespData = $this->tpDBObj->select(LTI_CONSUMER_SECRET, $fields, $condition);

            $tpBodyContent = null;
            if (isset($secretRespData) && is_array($secretRespData) && count($secretRespData) > 0) {
                $secretValue = $secretRespData[0]['lti_consumer_secret_key'];
                $tpBodyContent = $secretRespData[0]['tp_profile_temp_data'];
            }

            try {
                unset($_SESSION['reg_key']);
                unset($_SESSION['reg_password']);
                $_SESSION['reg_key'] = $oauth_consumer_key;
                $_SESSION['reg_password'] = $secretValue;
                $headerResponseStringData = array();
                $newToolProxyRegisterURL = trim($newToolProxyRegisterURL);
                $oauth_consumer_key = trim($oauth_consumer_key);
                $secretValue = trim($secretValue);
                $tpBodyContent = trim($tpBodyContent);

                $headerResponseStringData = sendOAuthBody('POST', $newToolProxyRegisterURL, $oauth_consumer_key, $secretValue, 'application/vnd.ims.lti.v2.toolproxy+json', $tpBodyContent);

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_HEADER, true);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array($headerResponseStringData));
                curl_setopt($ch, CURLOPT_URL, $newToolProxyRegisterURL);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $tpBodyContent);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_POST, true);

                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                $proxyRegistrationResp = curl_exec($ch);

                // Get the posted header information
                //$headers = curl_getinfo($ch, CURLINFO_HEADER_OUT);
                //$information = curl_getinfo($ch,CURLINFO_HEADER_OUT);

                //If there was an error, show it
                //          if (curl_error($ch)) {
                //              die(curl_error($ch));
                //          }
                $curlGetInfo = curl_getinfo($ch);
                curl_close($ch);

                return array('status' => 'success', 'message' => $proxyRegistrationResp, 'curlGetInfo' => $curlGetInfo);
            } catch (OAuthException $E) {
                //echo "Response: ". $E->lastResponse . "";
                return array('status' => 'failed', 'message' => $E->lastResponse);
            }
        } else {
            return array('status' => 'failed', 'message' => 'Input params are missing in Tool Profile information');
        }
    }

    /**
     * @functionality - Launch the resource
     */
    public function toolLaunchRequest($params = array())
    {
        $this->logErrorMessage(' #### Tool launch request initiated. ');
        if (count($params) > 0) {
            global $basestring;
            // CHECK THE POSTED URL HAVING THE action=value {value=resourceId};

            $urlPath = $_SERVER['REQUEST_URI'];
            $token = $params['x_access_token'];

            $seperator = $_SERVER['PHP_SELF'];
            $queryParams = explode($seperator, $urlPath);
            $resourceID = str_replace('?', '', $queryParams[1]);
            $splitQryString = explode('=', $resourceID);
            if ($splitQryString[0] == 'action') {
                $resourceID = strtolower($splitQryString[1]);
            } else {
                $this->logErrorMessage("Invalid URL. FROM '".$_SERVER['HTTP_REFERER']."'");

                return array('status' => 'failure', 'message' => 'Invalid URL');
            }

            // Filter the input array with empty values.
            $getPostedArrayKeyValues = $this->simplifyPostValues($params);

            // STEP-1 Check for OAuth-key
            if (!array_key_exists('lti_version', $getPostedArrayKeyValues) && !isset($getPostedArrayKeyValues['lti_version'])) {
                $this->logErrorMessage("LTI version is missing from request - '".$_SERVER['HTTP_REFERER']."'");

                return array('status' => 'failure', 'message' => 'LTI version is missing');
            }
            if (isset($getPostedArrayKeyValues['lti_version']) && strtolower($getPostedArrayKeyValues['lti_version']) != 'lti-2p0') {
                $this->logErrorMessage("LTI version is invalid from request '".$_SERVER['HTTP_REFERER']."'");

                return array('status' => 'failure', 'message' => 'LTI version is invalid');
            }

            if (!array_key_exists('resource_link_id', $getPostedArrayKeyValues) && !isset($getPostedArrayKeyValues['resource_link_id'])) {
                $this->logErrorMessage("Resource link id is missing from request - '".$_SERVER['HTTP_REFERER']."'");

                return array('status' => 'failure', 'message' => 'Resource link id is missing');
            }

            if (array_key_exists('oauth_consumer_key', $getPostedArrayKeyValues)) {
                //CHECK FOR OAUTH PARAM is missing
                if (empty($getPostedArrayKeyValues['oauth_signature'])) {
                    $this->logErrorMessage("OAuth Signature is missing - '".$getPostedArrayKeyValues['oauth_consumer_key']."'");

                    return array('status' => 'failure', 'message' => 'OAuth Signature is missing');
                }

                // STEP-2 Get Shared Secret using oauth_conusmer_key
                $OAuthConsumerKey = $getPostedArrayKeyValues['oauth_consumer_key'];
                $checkFilds = array('lti_consumer_secret_id', 'tool_proxy_reg_id');
                $checkCondition = " tool_proxy_id ='".$OAuthConsumerKey."'";

                $sharedSecretId = $this->tpDBObj->select(REGISTRATION_PROXY_TABLE, $checkFilds, $checkCondition);

                if (is_array($sharedSecretId) && $sharedSecretId[0]['lti_consumer_secret_id'] > 0) {
                    $ltiConsumerSecretId = $sharedSecretId[0]['lti_consumer_secret_id'];
                    $toolProxyRegId = $sharedSecretId[0]['tool_proxy_reg_id'];
                    $secretFilds = array('lti_consumer_secret_key', 'lti_consumer_access_level');
                    $secreCondition = ' lti_consumer_secret_id = '.$ltiConsumerSecretId;
                    $sharedSecretVal = $this->tpDBObj->select(LTI_CONSUMER_SECRET, $secretFilds, $secreCondition);
                    //echo "<pre>"; print_r($sharedSecretVal); die;
                    if (is_array($sharedSecretVal) && isset($sharedSecretVal[0]['lti_consumer_secret_key'])) {
                        $sharedSecredValue = trim($sharedSecretVal[0]['lti_consumer_secret_key']);
                        $ltiConsumerAccessLevel = trim($sharedSecretVal[0]['lti_consumer_access_level']);
                        //STEP-3 Generate OAuth_secret_key using Shared secret & oauth_consumer_key
                        //STEP-4 Cross validate OAuth Validation with form oauth-key => is pending
                        //unset($params['oauth_signature']);
                        //$headerResponseStringData = sendOAuthBody("POST",'', $OAuthConsumerKey, $sharedSecredValue, "", $params);

                        // Verify the message signature
                        //echo "<pre>"; print_r($_SERVER); //die;
                        //echo $_SERVER['REQUEST_SCHEME']."://".$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI']; die;
                        //echo $_SERVER['REQUEST_URI']; die;

                        if ($ltiConsumerAccessLevel == 'd') {
                            // do nothing
                        } elseif ($ltiConsumerAccessLevel == 's') {
                            // validate url
                            $requestedUrlPath = $_SERVER['REQUEST_SCHEME'].'://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
                            $urlValidation = null;
                            //echo $requestedUrlPath; die;
                            $tableFields = array('lti_resource_info_id');
                            $tableCondition = " lti_resource_info_link = '".$requestedUrlPath."' AND lti_resource_info_status =".ACTIVE;
                            $urlValidation = $this->tpDBObj->select(LTI_RESOURCE_INFO, $tableFields, $tableCondition);
                            // echo "<pre>"; print_r($urlValidation); die;
                            if (is_array($urlValidation) && count($urlValidation) > 0) {
                                $ltiResourceInfoId = $urlValidation[0]['lti_resource_info_id'];
                                $fldsArr = array('lti_resource_handler_default');
                                $conditionCheck = ' lti_resource_info_id = '.$ltiResourceInfoId;
                                $specificURLCheck = $this->tpDBObj->select(LTI_RESOURCE_ACCESS, $fldsArr, $conditionCheck);
                                //echo "<pre>"; print_r($specificURLCheck); die;
                                if (isset($specificURLCheck) && count($specificURLCheck) > 0) {
                                    $resourceAccess = $specificURLCheck[0]['lti_resource_handler_default'];
                                    if ($resourceAccess > 1) {
                                        return array('status' => 'failure', 'message' => 'Do not have access to the requested URL');
                                    }
                                } else {
                                    return array('status' => 'failure', 'message' => 'Do not have access to the requested URL');
                                }
                            } else {
                                return array('status' => 'failure', 'message' => 'Do not have access to the requested URL');
                            }
                        } else {
                            // check for multiple url
                        }

                        $store = new TrivialOAuthDataStore();
                        $store->add_consumer($OAuthConsumerKey, $sharedSecredValue);
                        $server = new OAuthServer($store);
                        $method = new OAuthSignatureMethod_HMAC_SHA1();
                        $server->add_signature_method($method);
                        $request = OAuthRequest::from_request();
                        $basestring = $request->get_signature_base_string();
                        //echo "<pre>"; print_r($basestring); die;
                        $this->logErrorMessage("OAuth Signature verification process started. OAuthConsumerKey : '".$OAuthConsumerKey."' & resource id - '".$resourceID."'");
                        try {
                            // Oauth validation checks here,
                            $server->verify_request($request);
                            $this->valid = true;
                            $this->logErrorMessage("OAuth Signature verification is success. OAuthConsumerKey : '".$OAuthConsumerKey."' & resource id - '".$resourceID."'");

                            //STEP-5  validate roles (optional)
                            $rolesDefinedFlag = false;
                            //var_dump($getPostedArrayKeyValues['roles']); die;
                            if (isset($getPostedArrayKeyValues['roles'])) {
                                $tcDefinedRoleName = $getPostedArrayKeyValues['roles'];
                                $rolesFields = array('lti_user_role_name');
                                $rolesCondition = ' lti_user_role_status = '.ACTIVE;
                                $preDefinedRolesArray = $this->tpDBObj->select(LTI_USER_ROLE, $rolesFields, $rolesCondition);
                                //print_r($preDefinedRolesArray); exit;
                                if (is_array($preDefinedRolesArray) && count($preDefinedRolesArray) > 0) {
                                    foreach ($preDefinedRolesArray as $rolesKey => $rolesVal) {
                                        $preDefinedRoles[] = $rolesVal['lti_user_role_name'];
                                    }
                                }

                                $formRoles = strtolower($tcDefinedRoleName);
                                $formRolesToArr = explode(',', $formRoles);
                                $rolesArrCount = count($formRolesToArr);
                                $error = 0;

                                //STEP-6  validate roles (optional) & exists with in the system
                                if ($rolesArrCount > 1) {
                                    for ($aLoop = 0; $aLoop < $rolesArrCount; ++$aLoop) {
                                        if (!in_array($formRolesToArr[$aLoop], $preDefinedRoles)) {
                                            $error = $error + 1;
                                        }
                                    }
                                } else {
                                    if (!in_array($formRolesToArr[0], $preDefinedRoles)) {
                                        $error = $error + 1;
                                    }
                                }

                                if ($error > 0) {
                                    $this->logErrorMessage("Invalid User Roles defined. OAuthConsumerKey : '".$OAuthConsumerKey."'");

                                    return array('status' => 'failure', 'message' => 'Invalid User Roles defined');
                                }
                                $rolesDefinedFlag = true;
                            }

                            // VALIDATE THE RESOURCE HANDLERS BASED ON THE ROLES
                            if ($rolesDefinedFlag) {
                                $resourceAccessFlag = $this->validateResourceHandlers($resourceID, $tcDefinedRoleName, $OAuthConsumerKey);
                                //var_dump($resourceAccessFlag); die;
                                if (!$resourceAccessFlag) {
                                    $this->logErrorMessage("Resource not available for the defined role. OAuthConsumerKey : '".$OAuthConsumerKey."'");

                                    return array('status' => 'failure', 'message' => 'resource not available for the defined role');
                                }
                                $this->logErrorMessage("Access permissions to Resources based on role validation completed. OAuthConsumerKey : '".$OAuthConsumerKey."' and resource id : '".$resourceID."'");
                            }

                            //STEP-7  Capture form values into the DATABASE
                            /* @var $getPostedArrayKeyValues array */
                            $this->logErrorMessage("Launch request data insertion into the table started. OAuthConsumerKey : '".$OAuthConsumerKey."'");
                            $lastInsertId = $this->insertDataIntoLaunchRequest($getPostedArrayKeyValues, $toolProxyRegId);

                            if ($lastInsertId) {
                                $callBackURL = $getPostedArrayKeyValues['launch_presentation_return_url'];
                                $TpLaunchLtiObj = new Tp_Launch_Lti();

                                $this->logErrorMessage("Launch resource event initiated. Resource id : '".$resourceID."'");

                                // launching url
                                $TpLaunchLtiObj->launchResource($resourceID, $callBackURL, $token);
                            } else {
                                $this->logErrorMessage("Launch request data insertion into the table failed. Resource id : '".$resourceID."'");

                                return array('status' => 'failure', 'message' => 'Unexpected error occured during processing');
                            }
                        } catch (Exception $e) {
                            $this->message = $e->getMessage();
                            $this->logErrorMessage($this->message);

                            return array('status' => 'failure', 'message' => $this->message);
                        }
                    }
                } else {
                    $this->logErrorMessage("Invalid OAuth Consumer Key. '".$_SERVER['HTTP_REFERER']."'");

                    return array('status' => 'failure', 'message' => 'Invalid OAuth Consumer Key');
                }
            } else {
                $this->logErrorMessage("OAuth Consumer Key is missing. '".$_SERVER['HTTP_REFERER']."'");

                return array('status' => 'failure', 'message' => 'OAuth Consumer Key is missing');
            }
        }

        return array('status' => 'failure', 'message' => 'input data is missing.');
    }

    public function insertDataIntoLaunchRequest($getPostedArrayKeyValues = array(), $toolProxyRegId = null)
    {
        // Return value initialization
        $lastInsertId = 0;

        //$launchReqDetails['lti_tc_launch_id'] = null;  // this is autoincremented id no need to push manually
        $launchReqDetails['tool_proxy_reg_id'] = $toolProxyRegId;

        $launchReqDetails['lti_tc_launch_context_id'] = (isset($getPostedArrayKeyValues['context_id'])) ? $getPostedArrayKeyValues['context_id'] : null;

        $launchReqDetails['lti_tc_launch_context_label'] = (isset($getPostedArrayKeyValues['context_label'])) ? $getPostedArrayKeyValues['context_label'] : null;

        $launchReqDetails['lti_tc_launch_context_title'] = (isset($getPostedArrayKeyValues['context_title'])) ? $getPostedArrayKeyValues['context_title'] : null;

        $launchReqDetails['lti_tc_launch_context_type'] = (isset($getPostedArrayKeyValues['context_type'])) ? $getPostedArrayKeyValues['context_type'] : null;

        $launchReqDetails['lti_tc_launch_presentation_css_url'] = (isset($getPostedArrayKeyValues['launch_presentation_css_url'])) ? $getPostedArrayKeyValues['launch_presentation_css_url'] : null;

        $launchReqDetails['lti_tc_launch_presentation_document_target'] = (isset($getPostedArrayKeyValues['launch_presentation_document_target'])) ? $getPostedArrayKeyValues['launch_presentation_document_target'] : null;

        $launchReqDetails['lti_tc_launch_presentation_locale'] = (isset($getPostedArrayKeyValues['launch_presentation_locale'])) ? $getPostedArrayKeyValues['launch_presentation_locale'] : null;

        $launchReqDetails['lti_tc_launch_presentation_return_url'] = (isset($getPostedArrayKeyValues['launch_presentation_return_url'])) ? $getPostedArrayKeyValues['launch_presentation_return_url'] : null;

        $launchReqDetails['lti_tc_launch_lis_outcome_service_url'] = (isset($getPostedArrayKeyValues['lis_outcome_service_url'])) ? $getPostedArrayKeyValues['lis_outcome_service_url'] : null;

        $launchReqDetails['lti_tc_launch_lis_person_name_family'] = (isset($getPostedArrayKeyValues['lis_person_name_family'])) ? $getPostedArrayKeyValues['lis_person_name_family'] : null;

        $launchReqDetails['lti_tc_launch_lis_person_name_full'] = (isset($getPostedArrayKeyValues['lis_person_name_full'])) ? $getPostedArrayKeyValues['lis_person_name_full'] : null;

        $launchReqDetails['lti_tc_launch_lis_person_name_given'] = (isset($getPostedArrayKeyValues['lis_person_name_given'])) ? $getPostedArrayKeyValues['lis_person_name_given'] : null;

        $launchReqDetails['lti_tc_launch_lis_person_sourcedid'] = (isset($getPostedArrayKeyValues['lis_person_sourcedid'])) ? $getPostedArrayKeyValues['lis_person_sourcedid'] : null;

        $launchReqDetails['lti_tc_launch_lis_result_sourcedid'] = (isset($getPostedArrayKeyValues['lis_result_sourcedid'])) ? $getPostedArrayKeyValues['lis_result_sourcedid'] : null;

        $launchReqDetails['lti_tc_launch_lti_version'] = (isset($getPostedArrayKeyValues['lti_version'])) ? $getPostedArrayKeyValues['lti_version'] : null;

        $launchReqDetails['lti_tc_launch_oauth_callback'] = (isset($getPostedArrayKeyValues['oauth_callback'])) ? $getPostedArrayKeyValues['oauth_callback'] : null;

        $launchReqDetails['lti_tc_launch_oauth_consumer_key'] = (isset($getPostedArrayKeyValues['oauth_consumer_key'])) ? $getPostedArrayKeyValues['oauth_consumer_key'] : null;

        $launchReqDetails['lti_tc_launch_oauth_nonce'] = (isset($getPostedArrayKeyValues['oauth_nonce'])) ? $getPostedArrayKeyValues['oauth_nonce'] : null;

        $launchReqDetails['lti_tc_launch_oauth_signature'] = (isset($getPostedArrayKeyValues['oauth_signature'])) ? $getPostedArrayKeyValues['oauth_signature'] : null;

        $launchReqDetails['lti_tc_launch_oauth_signature_method'] = (isset($getPostedArrayKeyValues['oauth_signature_method'])) ? $getPostedArrayKeyValues['oauth_signature_method'] : null;

        $launchReqDetails['lti_tc_launch_oauth_timestamp'] = (isset($getPostedArrayKeyValues['oauth_timestamp'])) ? $getPostedArrayKeyValues['oauth_timestamp'] : null;

        $launchReqDetails['lti_tc_launch_oauth_version'] = (isset($getPostedArrayKeyValues['oauth_version'])) ? $getPostedArrayKeyValues['oauth_version'] : null;

        $launchReqDetails['lti_tc_launch_resource_link_description'] = (isset($getPostedArrayKeyValues['resource_link_description'])) ? $getPostedArrayKeyValues['resource_link_description'] : null;

        $launchReqDetails['lti_tc_launch_resource_link_id'] = (isset($getPostedArrayKeyValues['resource_link_id'])) ? $getPostedArrayKeyValues['resource_link_id'] : null;

        $launchReqDetails['lti_tc_launch_resource_link_title'] = (isset($getPostedArrayKeyValues['resource_link_title'])) ? $getPostedArrayKeyValues['resource_link_title'] : null;

        $launchReqDetails['lti_tc_launch_roles'] = (isset($getPostedArrayKeyValues['roles'])) ? $getPostedArrayKeyValues['roles'] : null;

        $launchReqDetails['lti_tc_launch_tc_info_product_family_code'] = (isset($getPostedArrayKeyValues['tool_consumer_info_product_family_code'])) ? $getPostedArrayKeyValues['tool_consumer_info_product_family_code'] : null;

        $launchReqDetails['lti_tc_launch_tc_info_version'] = (isset($getPostedArrayKeyValues['tool_consumer_info_version'])) ? $getPostedArrayKeyValues['tool_consumer_info_version'] : null;

        $launchReqDetails['lti_tc_launch_tc_instance_contact_email'] = (isset($getPostedArrayKeyValues['tool_consumer_instance_contact_email'])) ? $getPostedArrayKeyValues['tool_consumer_instance_contact_email'] : null;

        $launchReqDetails['lti_tc_launch_tc_instance_description'] = (isset($getPostedArrayKeyValues['tool_consumer_instance_description'])) ? $getPostedArrayKeyValues['tool_consumer_instance_description'] : null;

        $launchReqDetails['lti_tc_launch_tc_instance_guid'] = (isset($getPostedArrayKeyValues['tool_consumer_instance_guid'])) ? $getPostedArrayKeyValues['tool_consumer_instance_guid'] : null;

        $launchReqDetails['lti_tc_launch_user_id'] = (isset($getPostedArrayKeyValues['user_id'])) ? $getPostedArrayKeyValues['user_id'] : null;
        $launchReqDetails['lti_tc_launch_user_image'] = (isset($getPostedArrayKeyValues['user_image'])) ? $getPostedArrayKeyValues['user_image'] : null;

        $launchReqDetails['lti_tc_launch_lis_person_contact_email_primary'] = (isset($getPostedArrayKeyValues['lis_person_contact_email_primary'])) ? $getPostedArrayKeyValues['lis_person_contact_email_primary'] : null;

        $launchReqDetails['lti_tc_launch_lis_course_offering_sourcedid'] = (isset($getPostedArrayKeyValues['lis_course_offering_sourcedid'])) ? $getPostedArrayKeyValues['lis_course_offering_sourcedid'] : null;

        $launchReqDetails['lti_tc_launch_lis_course_section_sourcedid'] = (isset($getPostedArrayKeyValues['lis_course_section_sourcedid'])) ? $getPostedArrayKeyValues['lis_course_section_sourcedid'] : null;

        $launchReqDetails['lti_tc_launch_tc_instance_name'] = (isset($getPostedArrayKeyValues['tool_consumer_instance_name'])) ? $getPostedArrayKeyValues['tool_consumer_instance_name'] : null;

        $launchReqDetails['lti_tc_launch_tc_instance_url'] = (isset($getPostedArrayKeyValues['tool_consumer_instance_url'])) ? $getPostedArrayKeyValues['tool_consumer_instance_url'] : null;

        $launchReqDetails['lti_tc_launch_insert_dts'] = date('Y-m-d H:i:s');

        $launchReqDetails = $this->tpDBObj->preventXssArray($launchReqDetails);
        //echo '<pre>';        print_r($launchReqDetails);        exit;
        $lastInsertId = $this->tpDBObj->insertDataInToTP(LTI_TC_LAUNCH_DETAILS, $launchReqDetails);
        $this->logErrorMessage('Launch request data insertion into the table completed. ');

        return $lastInsertId;
    }

    public function validateResourceHandlers($resourceName = null, $tcDefinedRoleName = null, $OAuthConsumerKey = null)
    {
        if ($resourceName && $tcDefinedRoleName) {
            $this->logErrorMessage("Access permissions to Resources based on role validation started. OAuthConsumerKey : '".$OAuthConsumerKey."' and Resource id : '".$resourceName."'");
            $resourceId = $roleID = null;
            $RequiredRoleFlag = false;

            $tcDefinedRoleNameArr = explode(',', $tcDefinedRoleName);

            $resourceRespArr = array();
            $resourceCondition = " lti_resource_info_uniq_id = '".$resourceName."'";

            $resourceFields = array('lti_resource_info_id', 'lti_resource_info_req_role');

            $resourceRespArr = $this->tpDBObj->select(LTI_RESOURCE_INFO, $resourceFields, $resourceCondition);
            if (is_array($resourceRespArr) && count($resourceRespArr) > 0) {
                $resourceId = $resourceRespArr[0]['lti_resource_info_id'];
                $RequiredRoleStutus = $resourceRespArr[0]['lti_resource_info_req_role'];
                if ($RequiredRoleStutus == 1) {
                    $RequiredRoleFlag = true;
                }
            }

            if ($RequiredRoleFlag && $resourceId > 0) {
                if (count($tcDefinedRoleNameArr) > 1) {
                    // Multiple roles are defined
                    $successcount = $errorCount = 0;
                    for ($c = 0; $c < count($tcDefinedRoleNameArr); ++$c) {
                        $roleName = rtrim($tcDefinedRoleNameArr[$c], ',');
                        $accessResp = $this->checkResourceWithRole($roleName, $resourceId);
                        if ($accessResp) {
                            $successcount = $successcount + 1;
                        } else {
                            $errorCount = $errorCount + 1;
                        }
                    }
                    if ($errorCount > 0) {
                        return false;
                    } else {
                        return true;
                    }
                } elseif (count($tcDefinedRoleNameArr) == 1) {
                    // single role defined.
                    $roleName = rtrim($tcDefinedRoleNameArr[0], ',');

                    return $this->checkResourceWithRole($roleName, $resourceId);
                }
            }

            return true;
        } else {
            return false;
        }
    }

    public function checkResourceWithRole($roleName = null, $resourceId = null)
    {
        if ($roleName && $resourceId) {
            $roleName = strtolower($roleName);
            $roleRespArr = array();
            $roleCondition = " lti_user_role_name = '".$roleName."' OR lti_user_role_urn_name = '".$roleName."'";
            $roleFields = array('lti_user_role_id');
            $roleRespArr = $this->tpDBObj->select(LTI_USER_ROLE, $roleFields, $roleCondition);
            if (is_array($roleRespArr) && count($roleRespArr) > 0) {
                $roleID = $roleRespArr[0]['lti_user_role_id'];
            }

            $checkAccessCondition = ' lti_resource_info_id = '.$resourceId.' AND lti_user_role_id = '.$roleID; //
            //." AND lti_resource_handler_default = ".ACTIVE;
            $checkFlds = array('lti_resource_handler_id');
            $accessPermission = $this->tpDBObj->select(LTI_RESOURCE_ACCESS, $checkFlds, $checkAccessCondition);
            if (is_array($accessPermission) && count($accessPermission) > 0 && $accessPermission[0]['lti_resource_handler_id'] > 0) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public function simplifyPostValues($params = array())
    {
        if (is_array($params) && count($params) > 0) {
            foreach ($params as $arrKey => $arrVal) {
                $k = trim($arrKey);
                $v = trim($arrVal);
                if (isset($v) && strlen($v) > 0) {
                    $returnArr[$k] = $v;
                } else {
                    unset($k);
                }
            }
            $returnArr = $this->tpDBObj->preventXssArray($returnArr);

            return $returnArr;
        }

        return array();
    }

    public function validateRegistrationValues($postParams = array(), $previousUrlPath = null)
    {
        $message = '';
        $this->logErrorMessage('Tool registration required fields vaidation started. ');
        if (!isset($postParams['reg_key']) && strlen($postParams['reg_key']) < 1) {
            $message = 'reg_key value is missing';
        }

        if (!isset($postParams['reg_password']) && strlen($postParams['reg_password']) < 1) {
            $message .= 'reg_password value is missing';
        }

        if (!isset($postParams['tc_profile_url']) && strlen($postParams['tc_profile_url']) < 1) {
            $message .= 'tc_profile_url value is missing';
        }

        if (!isset($postParams['lti_version']) && strlen($postParams['lti_version']) < 1) {
            $message .= 'lti_version value is missing';
        }

        if (strtolower($postParams['lti_version']) != 'lti-2p0') {
            $message .= 'invalid lti_version value';
        }

        if (!isset($postParams['launch_presentation_return_url']) && strlen($postParams['launch_presentation_return_url']) < 1) {
            $message .= 'launch_presentation_return_url value is missing';
            $launchPresentationReturnURL = $previousUrlPath;
        } else {
            $launchPresentationReturnURL = $postParams['launch_presentation_return_url'];
        }
        $this->logErrorMessage('Tool registration required fields vaidation completed. ');
        // IF one of the input param is missing redirect back to the TC defined url with valid message
        if (strlen($message) > 1) {
            return array('status' => 'failed', 'message' => $message, 'finalreturnURL' => $launchPresentationReturnURL);
        } else {
            return array('status' => 'success', 'message' => null, 'finalreturnURL' => $launchPresentationReturnURL);
        }
    }

    private function logErrorMessage($message = null)
    {
        $logMessage = $message.' - '.date('Y-m-d H:i:s')." \n";
        error_log($logMessage, 3, $this->logFilePath);
    }

    public function __destruct()
    {
        unset($this->tpDBObj);
        unset($this->oauthObj);
        unset($TpLaunchLtiObj);
        unset($this->resourceLaunchLogfilePath);
        unset($this->logFilePath);
    }
} // END OF CLASS
