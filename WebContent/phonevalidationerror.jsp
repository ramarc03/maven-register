<!DOCTYPE html>
<html lang="en">

<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">		
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/registerApp.js"></script>
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
</head>
<style>
 
	
	#myProgress {
	  position: relative;
	  width: 100%;
	  height: 30px;
	  background-color: #ddd;
	}
	
	#myBar {
	  position: absolute;
	  width: 25%;
	  height: 100%;
	  background-color: #4CAF50;
	}
	
	#label {
	  text-align: center;
	  line-height: 30px;
	  color: white;
	}

</style>
<script>

	// Regular expression patterns
	var phoneRegex = {
	  phone: {
	    us: /^1?(\d{3})(\d{3})(\d{4})$/,
	  }
	};
	
	var zipRegex = {
	  zip: {
	    us:  /^1?(\d{5})$/,
	  }
	};
	var ssnRegex = {
	  ssn: {
	    us:  /^1?(\d{3})(\d{2})(\d{4})$/,
	  }
	};	
	var validTextRegex = {
	  withSpace: {
		    us:  /^[a-zA-Z0-9 ,.\'-]*$/,
		  },
		  address: {
		    us:  /^[a-zA-Z0-9 ,.\'#-]*$/,
		  },
		  cityState: {
		    us:  /^[a-zA-Z0-9 ,.\'-]*$/,
		  }
	};
		
	$(document).ready(function() {
		
		  /*$('input:visible').keyup(function(){
			        if($(this).val().length==$(this).attr("maxlength")){
			        	if(($(this).attr('id')=='personal_ccn') )
		        			$(":input")[$(":input").index(document.activeElement) + 2].focus();
		        		else
			               $(":input")[$(":input").index(document.activeElement) + 1].focus();
			        	return false;
			        }
		    });*/
		    
		    $('#personal_chkShow').change(function() {
			    var isChecked = $(this).prop('checked');		
		        if (isChecked) {
					document.personalinformation.action = 'licenseerror.jsp';					
					document.personalinformation.submit();
					return true;	
		        }
			});
		
			$('#personal_hnumber').on('input', function() {
				var input=$(this);
				var value = $.trim(input.val()).replace(/\D/g, '');
				var cc='us';
				var re = phoneRegex.phone[cc];
			    var is_hnumber = value.length > 9 && re.test(value);
			  	if (is_hnumber) {
			     input.val(value.replace(re, '($1) $2-$3'));
			    }
				if(is_hnumber){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});

			$("#personal_submit button").click(function(event){	
			
			
				var form_data=$("#personal").serializeArray();
 				var error_free=true;
	 			
				for (var input in form_data){
					var element=$("#personal_"+form_data[input]['name']);
					var valid=element.hasClass("valid");
					var error_element=$("span", element.parent().parent());
					if (!valid){
						error_element.removeClass("error").addClass("error_show"); 
						error_free=false;						
					}else{
						error_element.removeClass("error_show").addClass("error");
					}
				}
				
				if (!error_free){
					event.preventDefault();
				} else {
					document.personalinformation.action = 'otpinformation.jsp';					
					document.personalinformation.submit();
					disableNextButton("personal_submit", "Please Wait.."); 
					return true;

				}

			});	
		
		});
	
</script>
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	

	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">
	
		<div id="myProgress">
		  <div id="myBar">
		    <div id="label">25%</div>
		  </div>
		</div>
    <div class="message-box failure" >
    	   <p>We were unable to validate the mobile number you have provided. The mobile number must be registered under your name for the validation to succeed.</p> 
    </div>


            <div class="Row">
            <p align="left">In order to validate your identity, please enter your home phone number.</p>
<div  class="message-box info">            
	<ul>
	<li>You will receive a call on your home phone with a One Time Password.</li>
	<li>You must be present to receive a call that will provide them with a passcode.</li>
	<li>The passcode will not be left on voicemail.</li>
	<li>You must enter the passcode on this webpage within 10 minutes of receipt.</li>
	</ul>
</div>
            </div>
 
		<div   id="rcorners2">

				
				      <fieldset>


						<div class="Row">
							<div class="ColumnLabel">	
								<label for="personal_hnumber"><font color="red">* </font>Home Phone Number</label>
							</div>
							<div class="Column" style="width:60%">
								<div class="Row">	
									<input type="text" id="personal_hnumber" name="hnumber" value="" size="14" maxlength="14" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid phone number is required.</span>
								</div>
							</div>
			
						</div>	
						
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_checkbox"></label>
							</div>
							<div class="Column" style="width:55%">
									<div class="Row">
									<div class="Column" style="width:5%">
									<input type="checkbox" id="personal_chkShow"/>
									</div>
									<div align="left">
									I do not have a home phone registered under my name.
									</div>												
								</div>
							</div>
						</div>
					    </fieldset>
					  
				<div class="Row">
				<br>
				</div>			  
					  
				    
		</div>

                   <div class="Row">
                                    
                                <!-- Submit Button -->
                                <div align="center" id="personal_submit" >					
                                    <button type="button" class="roundAll">Submit</button>
                                </div>
                  </div>

		</form>

		</div>
	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

