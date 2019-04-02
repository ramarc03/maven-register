<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.owasp.esapi.ESAPI"%>
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">	
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<!-- reCAPTCHA Libary -->
	<script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
</head>
<style>
 	.error{
		display: none;
		height:20px;
		margin-right : 10px;
	}		
	.error_show{
		height:20px;		
		color: red;
		margin-right : 10px;
	}
	.Row
	{
	    display: table;
	    width: 90%; /*Optional*/
	    table-layout: fixed; /*Optional*/
	    border-spacing: 1px; /*Optional*/  
	    
	}
	.RowPII
	{
	    display: table;
	    width: 10%; /*Optional*/
	    table-layout: fixed; /*Optional*/
	    border-spacing: 1px; /*Optional*/  
	    
	}
	.RowSpan
	{
	   display: table;
	   height:20px;
	}
	.ColumnLabel
	{
	    display: table-cell;
	    float: right;
	    padding-right: 20px;
	    
	}
	.Column
	{
	    display: table-cell;
	    
	}
	#rcorners2 {
	    border-radius: 25px;
	    border: 2px solid #95B9C7;
	    padding-left: 1px;
	    padding-right: 20px;
	    padding-top: 10px;
	    padding-bottom: 20px;
	}
	
	#rcornersdoted {
	    border-radius: 25px;
	    border: 2px dotted  #95B9C7;
	    padding-left: 1px;
	    padding-right: 1px;
	    padding-top: 15px;
	    padding-bottom: 15px;
	}
	#personal_fname,
	#personal_lname,
	#personal_birthmonth,
	#personal_birthday,
	#personal_birthyear,
	#personal_haddress1,
	#personal_hcity,
	#personal_hstate,
	#personal_license,
	#personal_hzip,
	#personal_mname,
	#personal_haddress2,
	#personal_suffix,
	#personal_ccn,
	#personal_mnumber,
	#personal_licensestate {
	    font-size: 2em;
	    width: auto;
	    float:left;
	}
	
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
	  noSpace: {
	    us:  /^[a-zA-Z0-9]*$/,
	  }
	};
	
	$(document).ready(function() {

		{	
			var element_mname=$("#personal_hstate");
			element_mname.addClass("valid");
		
			var element_suffix=$("#personal_fname");
			element_suffix.addClass("valid");
		
			var element_mnumber=$("#personal_mname");
			element_mnumber.addClass("valid");
		
			var element_haddress2=$("#personal_lname");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_suffix");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_birthmonth");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_birthyear");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_mnumber");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_haddress1");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_haddress2");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_hcity");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_hzip");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_ccn");
			element_haddress2.addClass("valid")
			
			var element_haddress2=$("#personal_birthday");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_licensepage");
			element_haddress2.addClass("valid");
		}

		    $('#personal_chkShow').change(function() {
		
		        var isChecked = $(this).prop('checked');
			
		        if (isChecked) {
					$('#personal_nostate').css("display", "inline");
					$('#personal_nossn').css("display", "none");
					//$('#personal_nostate').addClass("message-box info");
		
		        } else {
					$('#personal_nossn').css("display", "inline");		
					$('#personal_nostate').css("display", "none");
					//$('#personal_nossn').addClass("message-box failure");
					
		        }
		
		    });

			$('#personal_license').on('input', function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc='us';
				var re = validTextRegex.noSpace[cc];
			    var is_license = (value.length > 7 && re.test(value));	
				if(is_license){
				
					input.removeClass("invalid").addClass("valid");
				}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$('#personal_licensestate').change( function() {
				var input=$(this);
				var is_hstate=input.val();
				if(is_hstate){				
					input.removeClass("invalid").addClass("valid");
				}
				else{input.removeClass("valid").addClass("invalid");}
			});
	
			$("#personal_submit button").click(function(event){			

				var form_data=$("#personal").serializeArray();
				var error_free=true;
				for (var input in form_data){
					var element=$("#personal_"+ form_data[input]['name']);
					var valid=element.hasClass("valid");
			
					var error_element=$("span", element.parent().parent());
					if (!valid){
							error_element.removeClass("error").addClass("error_show"); error_free=false;
					}
					else{error_element.removeClass("error_show").addClass("error");}
				}
				if (!error_free){
					event.preventDefault();
				}
				else{
					document.personalinformation.action = 'lexisnexisvalidationDLN.jsp';
				
					document.personalinformation.submit();
					return true;

				}

			});	
		
		});
	
</script>
<%

		String fname = "";
		String mname = "";
		String lname = "";
		String suffix = "";	
		String license = "";
		String licensestate = "";
		String fivedigits = request.getParameter("fivedigits");
		String haddress1 = "";
		String haddress2 = "";	
		String hcity = "";
		String hstate = "";		
		String hzip = "";
		String mnumber = "";
		String birthday = "";
		String birthmonth = "";
		String birthyear = "";
		String ccn = "";
		String email = "";
		
		fname = ESAPI.validator().getValidInput("fname",request.getParameter("fname"), "StringWithSpace", 150 ,true );	
		mname = ESAPI.validator().getValidInput("mname",request.getParameter("mname"), "StringWithSpace", 100 ,true );
		lname = ESAPI.validator().getValidInput("lname",request.getParameter("lname"), "StringWithSpace", 150 ,true );
		suffix = ESAPI.validator().getValidInput("suffix",request.getParameter("suffix"), "SafeString", 10 ,true );
		haddress1 = ESAPI.validator().getValidInput("haddress1",request.getParameter("haddress1"), "Address", 250 ,true );		
		haddress2 = ESAPI.validator().getValidInput("haddress2",request.getParameter("haddress2"), "Address", 250 ,true );
		hcity = ESAPI.validator().getValidInput("hcity",request.getParameter("hcity"), "CityState", 200 ,true );		
		hstate = ESAPI.validator().getValidInput("hstate",request.getParameter("hstate"), "CityState", 100 ,true );
		hzip = ESAPI.validator().getValidInput("hzip",request.getParameter("hzip"), "Zip", 5 ,true );
		mnumber = ESAPI.validator().getValidInput("mnumber",request.getParameter("mnumber"), "Phone", 15 ,true );
		birthday = ESAPI.validator().getValidInput("birthday",request.getParameter("birthday"), "SafeNumeric", 2 ,true );
		birthmonth = ESAPI.validator().getValidInput("birthmonth",request.getParameter("birthmonth"), "SafeNumeric", 2 ,true );
		birthyear = ESAPI.validator().getValidInput("birthyear",request.getParameter("birthyear"), "SafeNumeric", 4 ,true );
		ccn = ESAPI.validator().getValidInput("ccn",request.getParameter("ccn"), "Zip", 5 ,true );
		email = ESAPI.validator().getValidInput("email",request.getParameter("email"), "Email", 200 ,true );	
		//ssn = ESAPI.validator().getValidInput("ssn",request.getParameter("ssn"), "SSN", 11 ,true );
		license = ESAPI.validator().getValidInput("license",request.getParameter("license"), "SafeString", 15 ,true );
		licensestate = ESAPI.validator().getValidInput("licensestate",request.getParameter("licensestate"), "CityState", 100 ,true );
		//fivedigits = ESAPI.validator().getValidInput("fivedigits",request.getParameter("fivedigits"), "Zip", 5 ,true );		
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
    
            <div id="personal_nossn" class="Row" style="display:block;">
            	<div class="message-box failure" >
            	         <p>We were unable to validate the SSN provided, please enter your driver's license number below. This Information will not be saved or stored.</p> 
            	</div> 

            </div>
            <div id="personal_nostate" class="Row" style="display:none;">
            	<div class="message-box info" >
            	         <p>We were unable to validate the online identity validation.</p> 
            	</div> 

            </div>
<div   id="rcorners2">
				
				      <fieldset>
						 <div class="Row">
						
								<div class="Column" style="width:35%">
			 					<div class="Row">
								<select id="personal_validationoption" name="validationoption" >
								<option value="SS">--select method of validation--</option>					
								<option value="ssnoption">Validate with a Social Security Number (SSN)</option>
								<option value="dloption">Validate with a Driver's License Number</option>
							</select>
							</div>
								<div class="RowSpan">
									<span class="error">Issued State is required</span>
								</div>
							</div>
							<div class="Column" style="width:20%">
									<div class="Row">
									<div class="Column" style="width:10%">
									<input type="checkbox" id="personal_chkShow"/>
									</div>
									<div class="Column">
									My state is not listed </div>
									</div>
							</div>
			
						</div>
						
						<div class="Row">
							 <div class="ColumnLabel">
								<label for="personal_license"><font color="red">* </font>Driver's License Number</label>
							</div>
								<div class="Column" style="width:55%">
				 					<div class="RowPII">
				 					
				 					<%	
	 								if((license != null) && (!license.isEmpty())){
	 							     %>						
										<input type="text" id="personal_license" name="license" value='<%=license%>' size="11" maxlength="11" ></input>
									<%
	 								}
									else{
									%>
										<input type="text" id="personal_license" name="license" value="" size="11" maxlength="11" ></input>
									<%
	 								}
									
									%>
				
									</div>
										<div class="RowSpan">
											<span class="error">This field is required</span>
										</div>			
								</div>
						</div>
						 <div class="Row">
							<div class="ColumnLabel">
								<label for="personal_licensestate"><font color="red">* </font>Issued State</label>
							</div>
								<div class="Column" style="width:35%">
			 					<div class="Row">
								<select id="personal_licensestate" name="licensestate" >
								<option value="SS">Select State</option>					
								<option value="AL">Alabama</option>
								<option value="AK">Alaska</option>
								<option value="AZ">Arizona</option>
								<option value="AR">Arkansas</option>
								<option value="CA">California</option>
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="DC">District Of Columbia</option>
								<option value="FL">Florida</option>
								<option value="GA">Georgia</option>
								<option value="HI">Hawaii</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="IN">Indiana</option>
								<option value="IA">Iowa</option>
								<option value="KS">Kansas</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MD">Maryland</option>
								<option value="MA">Massachusetts</option>
								<option value="MI">Michigan</option>
								<option value="MN">Minnesota</option>
								<option value="MS">Mississippi</option>
								<option value="MO">Missouri</option>
								<option value="MT">Montana</option>
								<option value="NE">Nebraska</option>
								<option value="NV">Nevada</option>
								<option value="NH">New Hampshire</option>
								<option value="NJ">New Jersey</option>
								<option value="NM">New Mexico</option>
								<option value="NY">New York</option>
								<option value="NC">North Carolina</option>
								<option value="ND">North Dakota</option>
								<option value="OH">Ohio</option>
								<option value="OK">Oklahoma</option>
								<option value="OR">Oregon</option>
								<option value="PA">Pennsylvania</option>
								<option value="RI">Rhode Island</option>
								<option value="SC">South Carolina</option>
								<option value="SD">South Dakota</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="UT">Utah</option>
								<option value="VT">Vermont</option>
								<option value="VA">Virginia</option>
								<option value="WA">Washington</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
								<option value="AS">American Samoa</option>

							</select>
							</div>
								<div class="RowSpan">
									<span class="error">Issued State is required</span>
								</div>
							</div>
							<div class="Column" style="width:20%">
									<div class="Row">
									<div class="Column" style="width:10%">
									<input type="checkbox" id="personal_chkShow"/>
									</div>
									<div class="Column">
									My state is not listed </div>
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
                                    <button type="button" class="roundAll">Next</button>
                                </div>
                  </div>

		</form>

		</div>	
				<jsp:include page="./footer.jsp" />		


</body>
</html>
