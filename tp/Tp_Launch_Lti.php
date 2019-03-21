<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/lti_v2/tp/Resource_Handler_Class.php';

class Tp_Launch_Lti extends Resource_Handler_Class
{
    public $logpath = '/var/www/html/lti_v2/logs/resource_launch_logs.txt';

    /**
     * this function will show the content in ifrane after reading from CP4.
     *
     * @param [type] $resourceID
     * @param [type] $callBackURL
     * @param [type] $token
     */
    public function launchResource($resourceID, $callBackURL, $token)
    {
        // REMOVE BELOW LINE.
        error_log("Launch request is successful. \n", 3, $logpath);

        if ($resourceID && $callBackURL) {
            //$file = './resources/'.$resourceID.'.pdf';
            //$path = '../resources/course_1.pdf';
            $result = $this->curlCall($callBackURL, $token);
            $signedUrl = !empty($result['data']) ? $result['data']['signedUrl'] : '';

            // header('Content-Length: '.filesize($signedUrl));
            // header('Content-type: application/html');
            // header('Content-disposition: inline; filename='.basename($path));
            // header('Expires: 0');
            // header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
            ob_clean();
            flush();
            //readfile($path);
            echo '<iframe SRC="'.$signedUrl.'" width="100%" height="100%" 
framespacing=0 frameborder=no border=0 scrolling=auto></iframe>';
        }
    }

    /**
     * This function will call cp4 via curl.
     *
     * @param [type] $url
     */
    private function curlCall($url, $token)
    {
        $headers = array();
        $headers[] = "x-access-token: $token";
        //$headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=utf-8';
        $headers[] = 'Content-Type: text/html; charset=utf-8';
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_FAILONERROR, true);
        $result = json_decode(curl_exec($ch), true);
        if (curl_error($ch)) {
            $error_msg = curl_error($ch);
            error_log("Launch request curl failed. \n", 1, $error_msg);

            return false;
        }

        //extract data from the post
        //set POST variables

        //url-ify the data for the POST
        // foreach ($fields as $key => $value) {
        //     $fields_string .= $key.'='.$value.'&';
        // }
        // rtrim($fields_string, '&');

        // //open connection
        // $ch = curl_init();

        // //set the url, number of POST vars, POST data
        // curl_setopt($ch, CURLOPT_URL, $url);
        // curl_setopt($ch, CURLOPT_POST, count($fields));
        // curl_setopt($ch, CURLOPT_POSTFIELDS, $fields_string);

        // //execute post
        // $result = curl_exec($ch);

        //close connection
        curl_close($ch);

        return $result;
    }
}
