<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>

<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 
	<link rel="stylesheet" href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" />		
	<link rel="stylesheet" href="assets/css/master.min.css">	
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<!-- reCAPTCHA Libary -->
	<script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
</head>

	<!-- Styles -->
	<style>
		input.invalid, textarea.invalid{
			border: 2px solid red;
		}

		.error{
			display: none;
			height:20px;
			//color: red;
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
		.RowPhone
		{
		    display: table;
		    width: 90%; /*Optional*/
		    table-layout: fixed; /*Optional*/
		}
		.RowSpan
		{
		   display: table;
		   height:20px;
		}
		.RowEmpty
		{
		    display: table;
		    padding:5px;
		    table-layout: fixed; /*Optional*/
		    border-spacing: 1px; /*Optional*/
		}
		.ColumnLabel
		{
		    display: table-cell;
		    float: left;
		}
		.Column
		{
		    display: table-cell;
		}
		.ColumnEmpty
		{
		    display: table-cell;
		    height:120px;
		   //background-color: red; /*Optional*/
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
		input {
  			display: inline-block;
  			float: left;
		}
		label {
  			font-size: 1.0em;
  			float: left;
		}
		select {
  			display: inline-block;
  			float: left;
		}
		div.fixed {
		    position: absolute;
		    resize: none;
		}
		#myProgress {
		  position: relative;
		  width: 100%;
		  height: 30px;
		  background-color: #ddd;
		}
		
		#myBar {
		  position: absolute;
		  width: 50%;
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

<%

	PersonInformation person = (PersonInformation)session.getAttribute("personalinformation");
	if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
  		person = new PersonInformation();
  	}
%>
	
<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div align="center">
	<form id="otp" NAME="otpvalidation"  method="post" autocomplete="off">
	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2">
					<img src="assets/images/unsuccess.jpg" height="50" width="50" alt="Success Logo"> 
					<p>We were unable to generate a One Time Password for the phone number you have provided. Please click "Next" to choose another validation option or to correct your personal information.</p>
				</div>
				<div class="Row" >	
					<!-- Submit Button -->
					<div id="otp_submit" >					
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
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=person.getTransactionid()%>"></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=person.getAppname()%>"></input>					
	
	</form>
	</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

