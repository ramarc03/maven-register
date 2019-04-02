<!DOCTYPE html>
<html lang="en">
<%@page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.register.formbeans.PersonInformationForm"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 
	<link rel="stylesheet" href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" />
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
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	
	PersonInformation person = (PersonInformation)session.getAttribute("personalinformation");
	if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
 		throw new Exception("Invalid Access");
 	}
 	String ssnDLChkFlag =(String) request.getSession().getAttribute("SSN_DL_VALIDATION");
	if(ssnDLChkFlag==null || (ssnDLChkFlag!=null && "FAIL".equals(ssnDLChkFlag))){
		throw new Exception("Invalid Access");
	}
	int otpChkCount = 0;
	if(StringUtils.isNotBlank(person.getOtpcheckcount())){
		otpChkCount = Integer.parseInt(person.getOtpcheckcount());
	   	if(otpChkCount >= 3){
			response.sendRedirect("phoneFinalvalidationerror.jsp?vError=OTPERR");
		}
	}
	
	String phoneNum = "";
	if(person.getPnumber()!=null){
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(person.getPnumber().replace(" ",") "));
		phoneNum = buffer.toString();
	}
%>
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
			<%--if("checked".equals(mchecked)){%>
				$("#mobileInfo").show();
				$("#landLineInfo").hide();
			<%}else if("checked".equals(lchecked)){%>
				$("#mobileInfo").hide();
				$("#landLineInfo").show();
			<%}else{%>
				$("#mobileInfo").hide();
				$("#landLineInfo").hide();
			<%}
			
			var element_mtype=$("#personal_mtype");
			element_mtype.addClass("valid");
			var element_ptype=$("#personal_ptype");
			element_ptype.addClass("valid");
			
			 $("#personal_mtype").change(function() {
			    var isChecked = $(this).prop("checked");		
		        if (isChecked) {
					$("#mobileInfo").show();
					$("#landLineInfo").hide();
		        }
			});
			$("#personal_ptype").change(function() {
			    var isChecked = $(this).prop("checked");		
		        if (isChecked) {
					$("#landLineInfo").show();
					$("#mobileInfo").hide();
		        }
			});
		    $("#personal_chkShow").change(function() {
			    var isChecked = $(this).prop("checked");		
		        if (isChecked) {
					document.personalinformation.action = "licenseerror.jsp";					
					document.personalinformation.submit();
					return true;
		        }
			});
		--%>
			if($("#personal_hnumber").val()!=""){
				$("#personal_hnumber").addClass("valid");
			}
		
			$("#personal_hnumber").on("input", function() {
				var input=$(this);
				var value = $.trim(input.val()).replace(/\D/g, "");
				var cc="us";
				var re = phoneRegex.phone[cc];
			    var is_hnumber = value.length > 9 && re.test(value);
			  	if (is_hnumber) {
			     input.val(value.replace(re, "($1) $2-$3"));
			    }
				if(is_hnumber){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
			});

			$("#personal_submit button").click(function(event){	
			
			
				var form_data=$("#personal").serializeArray();
 				var error_free=true;
	 			
				for (var input in form_data){
					var feildName= form_data[input]["name"];
					if(feildName=="hnumber"){
						var element=$("#personal_"+form_data[input]["name"]);
						var valid=element.hasClass("valid");
						var error_element=$("span", element.parent().parent().parent().parent());
						if (!valid){
							error_element.removeClass("error").addClass("error_show"); 
							error_free=false;						
						}else{
							error_element.removeClass("error_show").addClass("error");
						}
					}
				}
				
				if (!error_free){
					event.preventDefault();
				} else {
					document.personalinformation.action = "otpinformation.jsp";					
					document.personalinformation.submit();
					disableNextButton("personal_submit", "Please Wait.."); 
					return true;

				}

			});	
		
		});
	
</script>
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

        <div class="Row">
            <p align="left">In order to validate your identity, we need to send a One Time Password to a phone registered in your name or your family's name. Please re-verify your registered phone number and click 'Next'.</p>
            <%if("LAND".equals(person.getPhoneType())){ %>
			<div  id="landLineInfo" class="message-box info">            
				<b><font color="#0833a1">You will receive a call with a One Time Password on your Landline phone provided for Identity Verification.</font></b>
				<ul>				
				<li>You must be present to receive a call that will provide them with a passcode.</li>
				<li>The passcode will not be left on voicemail.</li>
				<li>You must enter the passcode on this webpage within 10 minutes of receipt.</li>
				</ul>
			</div>
			<%}else{ %>
			<div  id="mobileInfo" class="message-box info">
			 <b><font color="#0833a1">You will receive a One Time Password on your mobile phone provided for Identity Verification.</font></b>
			  <ul>				
				<li>You must enter the passcode on this webpage within 10 minutes of receipt.</li>
			  </ul>
			</div>
			<%} %>          

        </div>
 
		<div   id="rcorners2">

				
				      <fieldset>


						<div class="Row">
							<div class="ColumnLabel">	
								<label for="personal_hnumber"><font color="red">* </font>Phone Number</label>
							</div>
							<div class="Column" style="width:60%">
								<div class="Row">
									<div class="Column" style="width:25%">
										<input type="text" id="personal_hnumber" name="hnumber" value="<%=phoneNum %>" size="15" maxlength="14" autofocus></input>										
									</div>
								</div>
								<div class="RowSpan">
									<span class="error">A valid phone number is required.</span>
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
<input type="hidden" id="personal_ssn" name="ssn" value="<%=person.getSsn()%>"></input>
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
<input type="hidden" id="personal_otpsession" name="otpsession" value="<%=person.getOtpsession()%>" ></input>	
<input type="hidden" id="personal_idcheck" name="idcheck" value="<%=person.getIdcheck()%>" ></input>	
<input type="hidden" id="personal_ccvalidation" name="ccvalidation" value="<%=person.getCcvalidation()%>" ></input>	
<input type="hidden" id="personal_ssndlvalidation" name="ssndlvalidation" value="<%=person.getSsndlvalidation()%>" ></input>	
<input type="hidden" id="personal_otpcheckcount" name="otpcheckcount" value="<%=person.getOtpcheckcount()%>" ></input>	
<input type="hidden" id="personal_quizcheckcount" name="quizcheckcount" value="<%=person.getQuizcheckcount()%>" ></input>	
<input type="hidden" id="personal_otpvalidation" name="otpvalidation" value="<%=person.getOtpvalidation()%>" ></input>	
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=person.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=person.getAppname()%>" ></input>	

		</form>

		</div>
	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

