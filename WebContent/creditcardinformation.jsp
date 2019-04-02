<!DOCTYPE html>
<%@ page import="org.owasp.esapi.ESAPI"%>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>

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

	$(document).ready(function() {
			{
				var element_cccount=$("#personal_cccount");
				element_cccount.addClass("valid");
			}
			$('#personal_ccn').on('input', function() {

				var input=$(this);
				var value=$.trim(input.val());
				var regex = /[0-9][0-9][0-9][0-9][0-9]|\./;
				var is_ccn = value.length > 4 && regex.test(value);
				
				if(is_ccn){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});	
			$("#personal_submit button").click(function(event){
					event.preventDefault();				
					var form_data=$("#personal").serializeArray();
			 		var error_free=true;	 			 			
					for (var input in form_data){
						var element=$("#personal_"+form_data[input]['name']);
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
			
					document.personalinformation.action = 'redirectLexisnexisccv.jsp';
				
					document.personalinformation.submit();
					disableNextButton("personal_submit", "Please Wait..");  
					return true;

				}

			})
		
		});
	
</script>
<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		//ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		//String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  		
	
		PersonInformation person = (PersonInformation)request.getSession().getAttribute("personalinformation");
		if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
  			throw new Exception("Invalid Access");
  		}
		String cccount = ESAPI.validator().getValidInput("cccount",request.getParameter("cccount"), "SafeNumeric", 10 ,true );
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
		String creditcardcheck = person.getCreditcardcheck();
		
		String otpsession = (String)request.getSession().getAttribute("OTP_SESSION");
		String otpvalidation = (String)request.getSession().getAttribute("OTP_VALIDATION");
		String idcheck = (String)request.getSession().getAttribute("ID_CHECK");
		String ccvalidation = (String)request.getSession().getAttribute("CC_VALIDATION");
		String ssndlvalidation = (String)request.getSession().getAttribute("SSN_DL_VALIDATION");
		String quizcheckcount = (String)request.getSession().getAttribute("QUIZ_CHECK_COUNT");
		String otpcheckcount = (String)request.getSession().getAttribute("OTP_CHECK_COUNT");
		
		
 %>


<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">
	<input type="text" id="personal_cccount" name="cccount" value="<%=cccount%>"  style="display: none;" />
	
		
	<div id="myProgress">
		  <div id="myBar">
		    <div id="label">25%</div>
		  </div>
		</div>
    <br>
    <div id="personal_nossn" class="Row" style="display:block;">
    	<div class="message-box failure" >
    	         <p>We were unable to validate the credit card number provided. Please re-enter your credit card info and click "Next" again.</p> 
    	</div> 

    </div>
 
<div   id="rcorners2">
				
				      <fieldset>


						<div class="Row">
							 <div class="ColumnLabel">
								<label for="personal_ccn"><font color="red">* </font>First 5 digits of credit card</label>
							</div>
								<div class="Column" style="width:60%">
				 					<div class="Row">
	
												<input type="text" id="personal_ccn" name="ccn" value="" placeholder="XXXXX" size="5" maxlength="5" autofocus></input>
											
									</div>
									<div class="RowSpan">
										<span class="error">A valid credit card number is required</span>
									</div>				
								</div>
						</div>

					    </fieldset>
			  
					  
				    
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
