<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>


<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	<link rel="stylesheet" href="assets/css/externalreg.css">
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 	
	<link rel="shortcut icon" href="favicon.ico">
	<script src="assets/js/registerApp.js"></script>
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<!-- reCAPTCHA Libary -->
	<script src="https://www.google.com/recaptcha/api.js?hl=en"></script>
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
	  width: 75%;
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
			
			var element_cname=$("#personal_cname");
			element_cname.addClass("valid");
			var element_title=$("#personal_title");
			element_title.addClass("valid");
			var element_cfax=$("#personal_cfax");
			element_cfax.addClass("valid");
			var element_caddress1=$("#personal_caddress1");
			element_caddress1.addClass("valid");
			var element_caddress2=$("#personal_caddress2");
			element_caddress2.addClass("valid");
			var element_ccity=$("#personal_ccity");
			element_ccity.addClass("valid");
			var element_cstate=$("#personal_cstate");
			element_cstate.addClass("valid");
			var element_czip=$("#personal_czip");
			element_czip.addClass("valid");
			
			$("#personal_cname").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.address[cc];
			    var is_cname = ((value.length==0) || (value.length > 0 && re.test(value)));				
				if(is_cname){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_title").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.address[cc];
			    var is_ctitle = ((value.length==0) || (value.length > 0 && re.test(value)));		
				if(is_ctitle){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});

			$("#personal_cfax").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val()).replace(/\D/g, "");
				var cc="us";
				var re = phoneRegex.phone[cc];
			    var is_cfax = ((value.length==0) || (value.length > 9 && re.test(value)));
			  	if (is_cfax) {
			     input.val(value.replace(re, "($1) $2-$3"));
			    }
				if(is_cfax){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_caddress1").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.address[cc];
			    var is_caddress = ((value.length==0) || (value.length > 0 && re.test(value)));
				if(is_caddress){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_caddress2").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.address[cc];
			    var is_caddress2 = ((value.length==0) || (value.length > 0 && re.test(value)));
				if(is_caddress2){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_ccity").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.cityState[cc];
			    var is_ccity = ((value.length==0) || (value.length > 0 && re.test(value)));
				if(is_ccity){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_cstate").change( function() {
				var input=$(this);
				var value = $.trim(input.val());
				var cc="us";
				var re = validTextRegex.cityState[cc];
			    var is_cstate = ((value.length==0) || (value.length > 0 && re.test(value)));
				if(is_cstate){input.removeClass("invalid").addClass("valid");
				}else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_czip").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val()).replace(/\D/g, "");
				var cc="us";
				var re = zipRegex.zip[cc];
			    var is_czip = ((value.length==0) || (value.length > 4 && re.test(value)));
			  	if (is_czip) {			  	
			     input.val(value.replace(re, "$1"));
			    }
				if(is_czip){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});
			
			$("#personal_submit button").click(function(event){
				var form_data=$("#personal").serializeArray();
				var error_free=true;
				for (var input in form_data){
					var feildName= form_data[input]["name"];
					var element=$("#personal_"+form_data[input]["name"]);
					var valid=element.hasClass("valid");
					var error_element=$("span", element.parent().parent());
		if((feildName!="fname") && (feildName!="mname")  &&  (feildName!="lname") && (feildName!="suffix") 
		&& (feildName!="email") && (feildName!="lexid") && (feildName!="pnumber") && (feildName!="mnumber")&& (feildName!="ssn")
		&& (feildName!="birthmonth")&& (feildName!="birthday")&& (feildName!="birthyear")&& (feildName!="haddress1")
		&& (feildName!="haddress2")&& (feildName!="hcity")&& (feildName!="hstate")&& (feildName!="hzip")
&& (feildName!="ccn")&& (feildName!="phonetype")&& (feildName!="otpsession")&& (feildName!="idcheck")&& (feildName!="ccvalidation")&& 
(feildName!="ssndlvalidation")&& (feildName!="otpcheckcount")&& (feildName!="quizcheckcount")&& (feildName!="otpvalidation")&& (feildName!="creditcardcheck")
){							if (!valid){
							error_element.removeClass("error").addClass("error_show"); 
							error_free=false;						
						}else{
							error_element.removeClass("error_show").addClass("error");
						}
					}
				}
				if (!error_free){
					event.preventDefault();
				} else{
					document.personalinformation.action = "createUserInIDM.jsp";
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
		//Throw error if Identity is not verified before this page
		String idChkFlag =(String) request.getSession().getAttribute("ID_CHECK");
		if(idChkFlag==null || (idChkFlag!=null && "FAIL".equals(idChkFlag))){
			response.sendError(500);
			throw new Exception("Invalid Access");
		}  		
  		PersonInformation person = (PersonInformation)request.getSession().getAttribute("personalinformation");  
  		String fname = person.getFirstName();
		String lname = person.getLastName();
		String mname = person.getMiddleName();
		String suffix = person.getSuffixName();
		String email = person.getEmail();
		String lexid = person.getLexID();
		String mnumber  = person.getMnumber();
		String pnumber  = person.getPnumber();
		String haddress1  = person.getAddressLine1();
		String haddress2  = person.getAddressLine2();
		String hcity  = person.getCity();
		String hstate  = person.getStateCode();
		String hzip  = person.getZip5();
		String birthday  = person.getDateOfBirthDay();
		String birthmonth  = person.getDateOfBirthMonth();
		String birthyear  = person.getDateOfBirthYear();
		String ccn  = person.getAccountNumber();
		String ssn  = person.getSsn();
		String phonetype = person.getPhoneType();		
		String otpsession = person.getOtpsession();
		String otpvalidation = person.getOtpvalidation();
		String idcheck = person.getIdcheck();
		String ccvalidation = person.getCcvalidation();
		String ssndlvalidation = person.getSsndlvalidation();
		String quizcheckcount = person.getQuizcheckcount();
		String otpcheckcount = person.getOtpcheckcount();
		String creditcardcheck = person.getCreditcardcheck();
 %>


<body>




<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">

			
		<div id="myProgress">
		  <div id="myBar">
		    <div id="label">75%</div>
		  </div>
		</div>
    
            <div class="Row">
            <p align="left">Company Information (Optional)</p>
            </div>
<div   id="rcorners2">
						<DIV align="left"> <B><a id="privacy3" href="privacy.html" style="font-size: 1.0em;">How we protect your Privacy?</a></B> </DIV>
								<div class="Row" align="center">
							         <!--   h1>My Information</h1 -->
							         </div>
				
				      <fieldset>
									<div class="Row">
										 <div class="ColumnLabel">
											<label for="personal_cname">Company Name</label>
										</div>
										 <div class="Column" style="width:60%">
			 								<div class="Row">
			 						
												<input type="text" id="personal_cname" name="cname" value="" size="40" maxlength="200" autofocus></input>
																			
											</div>
											<div class="RowSpan">
												<span class="error">A valid Company name is required</span>
											</div>							
									</div>
									</div>
									<div class="Row">
										<div class="ColumnLabel">
											<label for="personal_title">Title</label>
										</div>
										<div class="Column" style="width:60%">		
			 								<div class="Row">
			 								
												<input type="text" id="personal_title" name="title" value="" size="40" maxlength="100" ></input>
											
											</div>
											<div class="RowSpan">
												<span class="error">A valid Title is required</span>
											</div>							
										</div>
									</div>

                     	<div class="Row">
							<div class="ColumnLabel">	
								<label for="personal_cfax">Fax</label>
							</div>
							<div class="Column" style="width:60%">
								<div class="Row">	
								
								<input type="text" id="personal_cfax" name="cfax" value="" size="14" maxlength="14" ></input>
							
								</div>
								<div class="RowSpan">
												<span class="error">A valid fax number is required</span>
								</div>
							</div>
			
						</div>	 
   						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_caddress1">Street Address 1</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					
								<input type="text" id="personal_caddress1" name="caddress1" value="" size="40" maxlength="100" ></input>
								
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						 <div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_caddress2">Street Address 2</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					
			 					<input type="text" id="personal_caddress2" name="caddress2" value="" size="40" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_ccity">City</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 		 			
								<input type="text" id="personal_ccity" name="ccity" value="" size="40" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid city is required</span>
								</div>				
								</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_cstate">State</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
								<select id="personal_cstate" name="cstate" >
								<option value="" selected="selected">Select State</option>					
								<option value="AL">Alabama</option>
								<option value="AK">Alaska</option>
								<option value="AS">American Samoa</option>								
								<option value="AZ">Arizona</option>
								<option value="AR">Arkansas</option>
								<option value="CA">California</option>
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="DC">District Of Columbia</option>
								<option value="FM">Federated States of Micronesia</option>								
								<option value="FL">Florida</option>
								<option value="GA">Georgia</option>
								<option value="GU">Guam</option>								
								<option value="HI">Hawaii</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="IN">Indiana</option>
								<option value="IA">Iowa</option>
								<option value="KS">Kansas</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MH">Marshall Islands</option>								
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
								<option value="MP">Northern Mariana Islands</option>								
								<option value="OH">Ohio</option>
								<option value="OK">Oklahoma</option>
								<option value="OR">Oregon</option>
								<option value="PW">Palau</option>								
								<option value="PA">Pennsylvania</option>
								<option value="PR">Puerto Rico</option>								
								<option value="RI">Rhode Island</option>
								<option value="SC">South Carolina</option>
								<option value="SD">South Dakota</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="UT">Utah</option>
								<option value="VT">Vermont</option>
								<option value="VA">Virginia</option>
								<option value="VI">Virgin Islands</option>								
								<option value="WA">Washington</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
							</select>
							</div>
								<div class="RowSpan">
									<span class="error">A valid state is required</span>
								</div>
							</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_czip">Zip</label>
							</div>
							<div class="Column" style="width:60%">
			 					<div class="Row">
			 			 		 
								<input type="text" id="personal_czip" name="czip" value="" size="5" maxlength="5" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid zip code is required</span>
								</div>
							</div>
			
						</div>
					    </fieldset>
					  
				<div class="Row">
				<br>
				</div>			  
					  
			    
					</div>

                  <div>
                                    
                                <!-- Submit Button -->
                                <div align="center" id="personal_submit" >					
                                    <button type="button" class="roundAll">Next ></button>
                                </div>
                  </div>	

<input type="hidden" id="personal_fname" name="fname" value="<%=person.getFirstName()%>" ></input>								
<input type="hidden" id="personal_mname" name="mname" value="<%=person.getMiddleName()%>"></input>
<input type="hidden" id="personal_lname" name="lname" value="<%=person.getLastName()%>"></input>
<input type="hidden" id="personal_suffix" name="suffix"  value="<%=person.getSuffixName()%>" ></input>
<input type="hidden" id="personal_pnumber" name="pnumber" value="<%=person.getPnumber()%>" ></input>
<input type="hidden" id="personal_mnumber" name="mnumber" value="<%=person.getMnumber()%>" ></input>
<input type="hidden" id="personal_email" name="email" value="<%=person.getEmail()%>"></input>

<input type="hidden" id="personal_birthmonth" name="birthmonth" value="<%=person.getDateOfBirthMonth()%>" ></input>
<input type="hidden" id="personal_birthday" name="birthday" value="<%=person.getDateOfBirthDay()%>" ></input>	
<input type="hidden" id="personal_birthyear" name="birthyear" value="<%=person.getDateOfBirthYear()%>" ></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>" ></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>" ></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=person.getCity()%>"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=person.getStateCode()%>"></input>	
<input type="hidden" id="personal_hzip" name="hzip" value="<%=person.getZip5()%>"></input>
<input type="hidden" id="personal_ccn" name="ccn" value="<%=person.getAccountNumber()%>"></input>
<input type="hidden" id="personal_phonetype" name="phonetype" value="<%=person.getPhoneType()%>"></input>	
<input type="hidden" id="personal_lexid" name="lexid" value="<%=person.getLexID()%>"></input>	
<input type="hidden" id="personal_otpsession" name="otpsession" value="<%=otpsession%>" ></input>	
<input type="hidden" id="personal_idcheck" name="idcheck" value="<%=idcheck%>" ></input>	
<input type="hidden" id="personal_ccvalidation" name="ccvalidation" value="<%=ccvalidation%>" ></input>	

<input type="hidden" id="personal_otpcheckcount" name="otpcheckcount" value="<%=otpcheckcount%>" ></input>	
<input type="hidden" id="personal_quizcheckcount" name="quizcheckcount" value="<%=quizcheckcount%>" ></input>	
<input type="hidden" id="personal_otpvalidation" name="otpvalidation" value="<%=otpvalidation%>" ></input>	
<input type="hidden" id="personal_creditcardcheck" name="creditcardcheck" value="<%=creditcardcheck%>" ></input>	

		</form>

		</div>	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

