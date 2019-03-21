<?php

include '../library/tcdatabase.php';
use TcDatabase;

/**
     * @class-defination - Used to perform the different actions related to the Tool-Consumer (TC).
     *
     * @copyright(s) - (2016) Impelsys India Pvt. Ltd.
     *
     * @author Srinivasu M <srinivasu.m@impelsys.com>
     *
     * @created-dts - 17-May-2016.
     */
    class TcAPI
    {
        public function __construct()
        {
            //echo "TEST";
        }

        public function index()
        {
            return 'Invalid request<br/>';
        }

        /**
         * @functionality - Will load the registration form to register Tool Proxy
         *
         * @copyright (c) 2016, Impelsys India Pvt. Ltd.
         * @author Srinivasu M <srinivasu.m@impelsys.com>
         */
        public function registration()
        {
            include 'registration_view.php';
        }

        /**
         * @functionality - Will save the registeration into the TC portal, auto submit the form details to the TP defined URL
         *
         * @copyright (c) 2016, Impelsys India Pvt. Ltd.
         * @author Srinivasu M <srinivasu.m@impelsys.com>
         */
        public function tcregister()
        {
            if (count($_POST) > 0) {
                //variable initialization
                $userprofileURL = $launchPresentationReturnURL = null;
                $tcDBObj = new TcDatabase(); //connection to TP DB

                $reg_key = "'".trim($_POST['reg_key'])."'";
                $reg_password = "'".trim($_POST['reg_password'])."'";
                // CURL POST PARAMS
                $message_type = trim($_POST['lti_message_type']);
                $lti_version = trim($_POST['lti_version']);
                $reg_key_val = trim($_POST['reg_key']);
                $reg_password_val = trim($_POST['reg_password']);
                $tc_profile_url = trim($_POST['tc_profile_url']);
                $launch_presentation_return_url = trim($_POST['launch_presentation_return_url']);

                $insertArray = array('tc_proxy_reg_key' => $reg_key, 'tc_proxy_reg_password' => $reg_password, 'tc_oauth_signature' => '', 'tc_oauth_consumer_key' => '', 'tool_proxy_guid' => '');

                $queryRespData = $tcDBObj->insertDataInToTC('tc_proxy_credentials', $insertArray);

                if ($queryRespData > 0) {
                    return true;
                } else {
                    return false;
                }
            } else {
                echo 'Invalid HTTP request';
                die;
            }
        }

        /**
         * @functionality - Register the Tool Proxy in the TC end
         *
         * @copyright (c) 2016, Impelsys India Pvt. Ltd.
         * @author Srinivasu M <srinivasu.m@impelsys.com>
         */
        public function tctoolproxycreationProcess($data = null)
        {
            if ($data) {
                //variable initialization

                $headerInfo = null;

                if (function_exists('apache_request_headers')) {
                    $headerInfo = apache_request_headers();
                }
                //echo "<pre>"; print_r($headerInfo); die;
                $headerInfo = implode('$', $headerInfo);
                $postParams = $data;
                //echo "<pre>"; print_r($headerInfo); die;
                $tablename = 'temp_tbale';
                $insertArr = array('id' => '', 'headerdata' => $headerInfo, 'postdata' => $postParams);
                //var_dump(mail('srinivasu.m@impelsys.com', 'tool proxy registration data', $insertArr)); die;
                        //return var_dump($insertArr);
                        $tcDBObj = new TcDatabase(); //connection to TP DB
                        $resp = $tcDBObj->insertDataInToTC($tablename, $insertArr);

                return var_dump($resp);
                //return $resp;
                        /*
                        $oauth_consumer_key = $headerInfo['oauth_consumer_key'];
                        $oauth_signature    = $headerInfo['oauth_signature'];

                        $postItemParams = $_POST;


                        $oauth_signature = trim($postItemParams['oauth_signature']);
                        $oauth_consumer_key = trim($postItemParams['oauth_consumer_key']);
                        $updateArray = array('tc_oauth_signature'=>$oauth_signature,'tc_oauth_consumer_key'=>$oauth_consumer_key);
                        $updateCond = ' tc_proxy_cred_id >= 1 ';
                        $queryRespData = $tcDBObj->updateDataInToTC('tc_proxy_credentials',$updateArray,$updateCond);
                        return $queryRespData;
                         *
                         */
            }
        }

        /**
         * @functionality - Provide the TC user profile details
         *
         * @copyright (c) 2016, Impelsys India Pvt. Ltd.
         * @author Srinivasu M <srinivasu.m@impelsys.com>
         */
        public function getTcProfile()
        {
            $tcdbObj = new tcdatabase();
            $queryRespData = $tcdbObj->selectquery('tc_user');
            echo $queryRespData['tc_user_profile'];
        }

        public function returnurl()
        {
            include 'registration_view.php';
        }

        public function __destruct()
        {
            unset($tcdbObj);
        }
    } // END OF CLASS - TcAPI
