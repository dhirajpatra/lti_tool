<?php

?>
<!DOCTYPE html>
<html>
    <head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<style>
* {
  box-sizing: border-box;
}

body {
  background-color: #f1f1f1;
}

#regForm {
  background-color: #ffffff;
  margin: 10px auto;
  font-family: Raleway;
  padding: 20px;
  width: 90%;
  min-width: 600px;
}

h1 {
  text-align: center;  
}

input {
    float:right;
  padding: 10px;
  width: 50%;
  font-size: 17px;
  font-family: Raleway;
  border: 1px solid #aaaaaa;
}

label {
    font-weight: 800;
}
/* Mark input boxes that gets an error on validation: */
input.invalid {
  background-color: #ffdddd;
}

/* Hide all steps by default: */
.tab {
  display: none;
  width:100%;
}

button {
  background-color: #4CAF50;
  color: #ffffff;
  border: none;
  padding: 10px 20px;
  font-size: 17px;
  font-family: Raleway;
  cursor: pointer;
}

button:hover {
  opacity: 0.8;
}

#prevBtn {
  background-color: #bbbbbb;
}

/* Make circles that indicate the steps of the form: */
.step {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbbbbb;
  border: none;  
  border-radius: 50%;
  display: inline-block;
  opacity: 0.5;
}

.step.active {
  opacity: 1;
}

/* Mark the steps that are finished and valid: */
.step.finish {
  background-color: #4CAF50;
}

#error {
    margin: 10px 0 10px 0;
    color: red;
    font-weight: 600;
}

html, body, #wrapper
{
width: 960px;
height: 100%;
}
#container
{
width: 960px;
margin: 0 auto;
}
</style>
</head>
<body onload="clear();">
<div class="container">
<form id="regForm" action="assignment.php" method="POST">
  <input type="hidden" id="secret" name="secret" value="25f9e794323b453885f5181f1b624d0b">
    <input type="hidden" id="token" name="token" value="12345678">
    <input type="hidden" id="lis_outcome_service_url" name="lis_outcome_service_url" value="<?php echo $_REQUEST['lis_outcome_service_url']; ?>">
    <input type="hidden" id="ext_lti_assignment_id" name="ext_lti_assignment_id" value="<?php echo $_REQUEST['ext_lti_assignment_id']; ?>">
    <!--input type="hidden" id="lis_result_sourcedid" name="lis_result_sourcedid" value="<?php echo $_REQUEST['lis_result_sourcedid']; ?>"-->
    <input type="hidden" id="lis_result_sourcedid" name="lis_result_sourcedid" value="<?php echo $_REQUEST['lis_result_sourcedid']; ?>">
    <input type="hidden" id="resource_link_title" name="resource_link_title" value="<?php echo $_REQUEST['resource_link_title']; ?>">
    <input type="hidden" id="oauth_consumer_key" name="oauth_consumer_key" value="<?php echo $_REQUEST['oauth_consumer_key']; ?>">
    <input type="hidden" id="oauth_nonce" name="oauth_nonce" value="<?php echo $_REQUEST['oauth_nonce']; ?>">
    <input type="hidden" id="oauth_signature_method" name="oauth_signature_method" value="<?php echo $_REQUEST['oauth_signature_method']; ?>">
    <input type="hidden" id="oauth_signature" name="oauth_signature" value="<?php echo $_REQUEST['oauth_signature']; ?>">
  <h1>Test Questions:</h1>
  <div id="error"></div>
  <!-- One "tab" for each step in the form: -->
  <div class="tab">CSS Stands for...
        <div>
                <label for="question-1-answers-A">A) Computer Styled Sections </label>
                <input type="radio" name="question-1-answers" id="question-1-answers-A" value="A" />
                
            </div>
            
            <div>
                    <label for="question-1-answers-B">B) Cascading Style Sheets</label>
                <input type="radio" name="question-1-answers" id="question-1-answers-B" value="B" />
                
            </div>
            
            <div>
                    <label for="question-1-answers-C">C) Crazy Solid Shapes</label>
                <input type="radio" name="question-1-answers" id="question-1-answers-C" value="C" />
                
            </div>
            
            <div>
                    <label for="question-1-answers-D">D) None of the above</label>
                <input type="radio" name="question-1-answers" id="question-1-answers-D" value="D" />
                
            </div>
  </div>
  <div class="tab">Internet Explorer 6 was released in...
        <div>
                <label for="question-2-answers-A">A) 2001</label>
                <input type="radio" name="question-2-answers" id="question-2-answers-A" value="A" />
                
            </div>
            
            <div>
                    <label for="question-2-answers-B">B) 1998</label>
                <input type="radio" name="question-2-answers" id="question-2-answers-B" value="B" />
                
            </div>
            
            <div>
                    <label for="question-2-answers-C">C) 2006</label>
                <input type="radio" name="question-2-answers" id="question-2-answers-C" value="C" />
                
            </div>
            
            <div>
                    <label for="question-2-answers-D">D) 2003</label>
                <input type="radio" name="question-2-answers" id="question-2-answers-D" value="D" />
                
            </div>
  </div>
  <div class="tab">SEO Stand for...
        <div>
                <label for="question-3-answers-A">A) Secret Enterprise Organizations</label>
                <input type="radio" name="question-3-answers" id="question-3-answers-A" value="A" />
                
            </div>
            
            <div>
                    <label for="question-3-answers-B">B) Special Endowment Opportunity</label>
                <input type="radio" name="question-3-answers" id="question-3-answers-B" value="B" />
                
            </div>
            
            <div>
                    <label for="question-3-answers-C">C) Search Engine Optimization</label>
                <input type="radio" name="question-3-answers" id="question-3-answers-C" value="C" />
                
            </div>
            
            <div>
                    <label for="question-3-answers-D">D) Seals End Olives</label>
                <input type="radio" name="question-3-answers" id="question-3-answers-D" value="D" />
                
            </div>
  </div>
  <div class="tab">A 404 Error...
        <div>
                <label for="question-4-answers-A">A) is an HTTP Status Code meaning Page Not Found</label>
                <input type="radio" name="question-4-answers" id="question-4-answers-A" value="A" />
                
            </div>
            
            <div>
                    <label for="question-4-answers-B">B) is a good excuse for a clever design</label>
                <input type="radio" name="question-4-answers" id="question-4-answers-B" value="B" />
                
            </div>
            
            <div>
                    <label for="question-4-answers-C">C) should be monitored for in web analytics</label>
                <input type="radio" name="question-4-answers" id="question-4-answers-C" value="C" />
                
            </div>
            
            <div>
                    <label for="question-4-answers-D">D) All of the above</label>
                <input type="radio" name="question-4-answers" id="question-4-answers-D" value="D" />
                
            </div>
  </div>
  <div class="tab">Your favorite website is
        <div>
                <label for="question-5-answers-A">A) Point</label>
                <input type="radio" name="question-5-answers" id="question-5-answers-A" value="A" />
                
            </div>
            
            <div>
                    <label for="question-5-answers-B">B) CP4</label>
                <input type="radio" name="question-5-answers" id="question-5-answers-B" value="B" />
                
            </div>
            
            <div>
                    <label for="question-5-answers-C">C) LTI</label>
                <input type="radio" name="question-5-answers" id="question-5-answers-C" value="C" />
                
            </div>
            
            <div>
                    <label for="question-5-answers-D">D) Canvas</label>
                <input type="radio" name="question-5-answers" id="question-5-answers-D" value="D" />
                
            </div>
  </div>
  <div id="buttons" style="overflow:auto; margin:20px 0 0 55%;">
    <div style="float:left;">
      <button type="button" id="prevBtn" onclick="nextPrev(-1)">Previous</button>
      <button type="button" id="nextBtn" onclick="nextPrev(1)">Next</button>
    </div>
  </div>
  <!-- Circles which indicates the steps of the form: -->
  <div style="text-align:center;margin-top:40px;">
    <span class="step"></span>
    <span class="step"></span>
    <span class="step"></span>
    <span class="step"></span>
    <span class="step"></span>
  </div>
  
</form>
</div>
<script>
var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the crurrent tab

// to clear error message when check
function clear(){ 
    var radios = document.getElementsByTagName("input");
    for(i=0; i < radios.length; i++){
        radios[i].addEventListener('click', function() {            
            document.getElementById("error").innerHTML = '';
          });
    }
   
}

function showTab(n) {
  // This function will display the specified tab of the form...
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  //... and fix the Previous/Next buttons:
  if (n == 0) {
    document.getElementById("prevBtn").style.display = "none";
  } else {
    document.getElementById("prevBtn").style.display = "inline";
  }
  if (n == (x.length - 1)) {
    document.getElementById("nextBtn").innerHTML = "Submit";
  } else {
    document.getElementById("nextBtn").innerHTML = "Next";
  }
  //... and run a function that will display the correct step indicator:
  fixStepIndicator(n)
}

function nextPrev(n) {
  // This function will figure out which tab to display
  var x = document.getElementsByClassName("tab");
  // Exit the function if any field in the current tab is invalid:
  if (n == 1 && !validateForm()) return false;
  // Hide the current tab:
  x[currentTab].style.display = "none";
  // Increase or decrease the current tab by 1:
  currentTab = currentTab + n;
  // if you have reached the end of the form...
  if (currentTab >= x.length) {
    document.getElementById("buttons").style.display = "none";
    // ... the form gets submitted:
    document.getElementById("regForm").submit();
    return false;
  }
  // Otherwise, display the correct tab:
  showTab(currentTab);
}

function validateForm() { 
  // This function deals with validation of the form fields
  var x, y, i, valid = false;
  x = document.getElementsByClassName("tab");
  radios = x[currentTab].getElementsByTagName("input"); 
  // A loop that checks every input field in the current tab:
  for (i = 0; i < radios.length; i++) {
    if (radios[i].checked) {
        //alert("Selected Value = " + radios[i].value);
        valid = true; // checked
    }
  }
  // If the valid status is true, mark the step as finished and valid:
  if (valid) {
    document.getElementsByClassName("step")[currentTab].className += " finish";
  }else{
    document.getElementById("error").innerHTML = 'You have to select at least one option to move to next step';
  }
  return valid; // return the valid status
}

function fixStepIndicator(n) {
  // This function removes the "active" class of all steps...
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(" active", "");
  }
  //... and adds the "active" class on the current step:
  x[n].className += " active";
}
</script>

</body>
</html>