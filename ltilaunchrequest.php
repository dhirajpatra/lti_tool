<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
\session_start();
include_once "library/config.php";
?>

<form action="<?php echo HOST; ?>/lti_v2/tp/tp_registration.php?action=course_1" name="ltiLaunchForm" method="post"
encType="application/x-www-form-urlencoded">
context_id : <input type="text" name="context_id" value="456434513"/>
<br/>
context_label : <input type="text" name="context_label" value="SI182"/>
<br/>
context_title : <input type="text" name="context_title" value="Design of Personal Environments"/>
<br/>
launch_presentation_css_url : <input type="text" name="launch_presentation_css_url" value="http://www.imsglobal.org/developers/LTI/test/v1p1/lms.css"/>
<br/>
launch_presentation_document_target : <input type="text" name="launch_presentation_document_target" value="frame"/>
<br/>
launch_presentation_locale :<input type="text" name="launch_presentation_locale" value="en-US"/>
<br/>
launch_presentation_return_url : <input type="text" name="launch_presentation_return_url" value="http://www.imsglobal.org/developers/LTI/test/v1p1/lms_return.php"/>
<br/>
x-access-token : <textarea name="x_access_token" id="x_access_token"></textarea>
<br/>
lis_outcome_service_url : <input type="text" name="lis_outcome_service_url" value="http://www.imsglobal.org/developers/LTI/test/v1p1/common/
tool_consumer_outcome.php?b64=MTIzNDU6OjpzZWNyZXQ="/>
<br/>
lis_person_contact_email_primary : <input type="text" name="lis_person_contact_email_primary" value="user@school.edu"/>
<br/>
lis_person_name_family : <input type="text" name="lis_person_name_family" value="Public"/>
<br/>
lis_person_name_full: <input type="text" name="lis_person_name_full" value="Jane Q. Public"/>
<br/>
lis_person_name_given : <input type="text" name="lis_person_name_given" value="Given"/>
<br/>
lis_person_sourcedid : <input type="text" name="lis_person_sourcedid" value="school.edu:user"/>
<br/>
lis_result_sourcedid : <input type="text" name="lis_result_sourcedid" value="feb-123-456-2929::28883"/>
<br/>
lti_message_type: <input type="text" name="lti_message_type" value="basic-lti-launch-request"/>
<br/>
lti_version: <input type="text" name="lti_version" value="LTI-2p0"/>
<br/>
oauth_callback: <input type="text" name="oauth_callback" value="about:blank"/>
<br/>
oauth_consumer_key: <input type="text" name="oauth_consumer_key" value="575179493f4f3"/>
<br/>
oauth_nonce : <input type="text" name="oauth_nonce" value="93ac608e18a7d41dec8f7219e1bf6a17"/>

<br/>
oauth_signature : <input type="text" name="oauth_signature" value="Xh3WjNP6eqZtnL1ov0YKxMP2fX4%3D"/>
<br/>
oauth_signature_method <input type="text" name="oauth_signature_method" value="HMAC-SHA1"/>
<br/>
oauth_timestamp : <input type="text" name="oauth_timestamp" value="1348093590"/>
<br/>
oauth_version : <input type="text" name="oauth_version" value="1.0"/>
<br/>
resource_link_description <input type="text" name="resource_link_description" value="A weekly blog."/>
<br/>
resource_link_id <input type="text" name="resource_link_id" value="120988f929-274612"/>
<br/>
resource_link_title <input type="text" name="resource_link_title" value="Weekly Blog"/>
<br/>
roles : <input type="text" name="roles" value="Instructor"/>
<br/>
tool_consumer_info_product_family_code : <input type="text" name="tool_consumer_info_product_family_code" value="ims"/>
<br/>
tool_consumer_info_version : <input type="text" name="tool_consumer_info_version" value="1.1"/>
<br/>
tool_consumer_instance_description : <input type="text" name="tool_consumer_instance_description" value="University of School (LMSng)"/>
<br/>
tool_consumer_instance_guid : <input type="text" name="tool_consumer_instance_guid" value="lmsng.school.edu"/>
<br/>
user_id : <input type="text" name="user_id" value="292832126"/>
<br/><br/>
<input type="submit" value="Press to continue to external tool"/>

</form>

<script language="javascript">

//document.ltiLaunchForm.submit();

</script>
