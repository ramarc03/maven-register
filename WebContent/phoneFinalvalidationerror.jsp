<!DOCTYPE html>
<html lang="en">
<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>

<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 
	<link rel="stylesheet" href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" />	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">		
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>
	<script src="assets/js/registerApp.js"></script>
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

	$(document).ready(function() {
			$("#otp_submit button").click(function(event){
				document.otpvalidation.action = 'personalinformation.jsp';
				document.otpvalidation.submit();
				disableNextButton("otp_submit", "Please Wait.."); 
				return true;
			});			
	});
</script>
<body>
<%
	PersonInformation person = new PersonInformation();
	person.setFirstName(personInformationForm.getFname());
	person.setLastName(personInformationForm.getLname());
	person.setMiddleName(personInformationForm.getMname());
	person.setSuffixName(personInformationForm.getSuffix());
	
	if(StringUtils.isNotBlank(personInformationForm.getMnumber())){
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getMnumber().replace(" ",") "));
		person.setMnumber(buffer.toString());
		//person.setMnumber(personInformationForm.getMnumber());
	}else{
		person.setMnumber("");
	}
	if(StringUtils.isNotBlank(personInformationForm.getPnumber())){	
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getPnumber().replace(" ",") "));
		person.setPnumber(buffer.toString());	
		//person.setPnumber(personInformationForm.getPnumber());	
	}else{
		person.setPnumber("");
	}
	person.setPhoneType(personInformationForm.getMtype());   //This will also contain  CRAD along with MOBILE and LAND
	person.setEmail(personInformationForm.getEmail());
	person.setDateOfBirthDay(personInformationForm.getBirthday());
	person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
	person.setDateOfBirthYear(personInformationForm.getBirthyear());
	person.setAddressLine1(personInformationForm.getHaddress1());
	person.setAddressLine2(personInformationForm.getHaddress2());
	person.setCity(personInformationForm.getHcity());
	person.setStateCode(personInformationForm.getHstate());
	person.setZip5(personInformationForm.getHzip());
	person.setSsn(personInformationForm.getSsn());
%>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />
	<div id="body">
	<form id="otp" NAME="otpvalidation"  method="post" autocomplete="off">
		<!-- start  fieldset -->
		<div class="Row"  id="rcorners2" style="padding-right:0px;">	
			<div align="center">				
				<img src="assets/images/unsuccess.jpg" height="50" width="50" alt="Success Logo"> 
					<p>We were unable to validate the Phone number you have provided. The Phone number must be registered under your name or your family's name for the validation to succeed. Please click "Next" to choose another validation option or to correct your personal information.</p>
			    	<div class="Row" >	
					<!-- Submit Button -->
					<div id="otp_submit" >					
						<button type="button" class="roundAll">Next ></button>
					</div>
				</div>		
			</div>
		</div>
<input type="hidden" id="personal_fname" name="fname" value="<%=person.getFirstName()%>" ></input>								
<input type="hidden" id="personal_mname" name="mname" value="<%=person.getMiddleName()%>"></input>
<input type="hidden" id="personal_lname" name="lname" value="<%=person.getLastName()%>"></input>
<input type="hidden" id="personal_suffix" name="suffix"  value="<%=person.getSuffixName()%>" ></input>
<input type="hidden" id="personal_pnumber" name="pnumber" value="<%=person.getPnumber()%>" ></input>
<input type="hidden" id="personal_mnumber" name="mnumber" value="<%=person.getMnumber()%>" ></input>
<input type="hidden" id="personal_email" name="email" value="<%=person.getEmail()%>"></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>" ></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>" ></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=person.getCity()%>"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=person.getStateCode()%>"></input>	
<input type="hidden" id="personal_hzip" name="hzip" value="<%=person.getZip5()%>"></input>
<input type="hidden" id="personal_phonetype" name="phonetype" value="<%=person.getPhoneType()%>"></input>	
<input type="hidden" id="personal_lexid" name="lexid" value="<%=person.getLexID()%>"></input>		
<input type="hidden" id="personal_appname" name="appname" value="<%=personInformationForm.getAppname()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	
<input type="hidden" id="personal_ssn" name="ssn" value="<%=personInformationForm.getSsn()%>"></input>	
<input type="hidden" id="personal_birthmonth" name="birthmonth" value="<%=personInformationForm.getBirthmonth()%>" ></input>
<input type="hidden" id="personal_birthday" name="birthday" value="<%=personInformationForm.getBirthday()%>" ></input>	
<input type="hidden" id="personal_birthyear" name="birthyear" value="<%=personInformationForm.getBirthyear()%>" ></input>
	
	</form>
</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

