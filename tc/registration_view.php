<html>
	<head>
		<title> Tool Registration </title>
		<style>
			.main_div {padding:0px; width:75%; background-color:#ffffc0;}
			.border_div {border:1px solid skyblue; border-radius:10px; padding:15px;}
			.main-header { font-weight:bold;padding:10px; color:red; width : 25%; float:left;}
			.title {color:brown; float:left; width : 25%; text-align:left; padding-right:5px; padding:5px;}
			.main-header-right{width : 70%;float:left;}
                        .form_fields {padding:5px; }
			.req {color:red;}
			.form_fields input[type="text"] { width : 70%;}
                        .success{color:green; font-weight:bold;padding-left:20%;}
                        .failed{color:red; font-weight:bold;padding-left:20%;}
		</style>
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
                <script>
                    $(document).ready(function(){
                        $('#submitButton').click(function(){
                           var formdata = $('#myFormId').serialize(); 
                           $.ajax({
                                type: "POST",
                                dataType: "json",
                                url: "tc.php?action=tpregister", //Relative or absolute path to response.php file
                                data: formdata,
                                success: function(data) {
                                      if(data == true){
                                          $('#myFormId').submit();
                                      }
                                }
                            });
                        });
                    });
                
                
                </script>
	</head>
	
	<body>
            <?php 
            $message = "<span class='failed'> </span><br/>";
            if (!empty($_GET['status']) && strtolower($_GET['status']) == 'success') {
                $message = "<span class='success'>Success</span><br/>";
            } elseif (!empty($_GET['status'])) {
                $message = "<span class='failed'> ";
                if (isset($_GET['tool_guid']) || isset($_GET['message'])) {
                    if ($_GET['tool_guid']) {
                        $message .= urldecode($_GET['tool_guid']);
                    } else {
                        $message .= urldecode($_GET['message']);
                    }
                }
                $message .= ' </span><br/>';
            }

            ?>
		<form action="../tp/tp_registration.php" method="post" id="myFormId">
			<div class="main_div">
				<div class="border_div">
					<div class="form_content">
                                                
						<div class="title main-header">Tool registration </div>
                                                <div class="form_fields main-header-right"> <?php echo $message; ?>  </div>
					</div>
					<div class="form_content">
						<div class="title">Message type : </div>
						<div class="form_fields"><input type="text" name="lti_message_type" maxlength="100" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content" style="">
						<div class="title">LTI version : </div>
						<div class="form_fields"><input type="text" name="lti_version" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content">
						<div class="title">Registration key : </div>
						<div class="form_fields"><input type="text" name="reg_key" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content">
						<div class="title">Registration password : </div>
						<div class="form_fields"><input type="text" name="reg_password" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content">
						<div class="title">Tool Consumer Profile URL : </div>
						<div class="form_fields"><input type="text" name="tc_profile_url" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content">
						<div class="title">Return URL : </div>
						<div class="form_fields"><input type="text" name="launch_presentation_return_url" /> <span class="req">[R]</span></div>
					</div><br/>
					<div class="form_content">
						<div class="title"> <br/> </div>
						<div class="form_fields"><input type="button" id="submitButton" name="sumbit_reg" value="Register" /> </div>
					</div>
				</div>
			</div>	
		</form>
	</body>	
</html>
