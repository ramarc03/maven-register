<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%> 
<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="java.util.Properties"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page import="com.register.util.CryptoUtil"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>		
	<link rel="stylesheet" href="assets/css/master.min.css">	
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 
	<link rel="stylesheet" href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" />
	<link rel="stylesheet" href="assets/css/externalreg.css">	
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/registerApp.js"></script>
	<script src="assets/js/external.js"></script>
	<script src="assets/js/modalpopup.min.js"></script>
	<script src="assets/js/page.min.js"></script>
	<script src="assets/js/external.js"></script>

</head>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
	<!-- Styles -->
	<style>
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
		label {
	      margin-left: 0px;
		}
	</style>

<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  	
		PersonInformation person = new PersonInformation();
	
		person.setFirstName(personInformationForm.getFname());
		person.setLastName(personInformationForm.getLname());
		person.setMiddleName(personInformationForm.getMname());
		person.setSuffixName(personInformationForm.getSuffix());
		person.setPhoneType(personInformationForm.getPhonetype());   
		person.setEmail(personInformationForm.getEmail());
		//person.setMnumber(personInformationForm.getMnumber());
		//person.setPnumber(personInformationForm.getPnumber());
		if(personInformationForm.getMnumber()!=null){
			String phoneNum = "";
			StringBuffer buffer = new StringBuffer();
			buffer.append("(");
			buffer.append(personInformationForm.getMnumber().replace(" ",") "));
			phoneNum = buffer.toString();
			person.setMnumber(phoneNum);
		}
		if(personInformationForm.getPnumber()!=null){
			String phoneNum = "";
			StringBuffer buffer = new StringBuffer();
			buffer.append("(");
			buffer.append(personInformationForm.getPnumber().replace(" ",") "));
			phoneNum = buffer.toString();
			person.setPnumber(phoneNum);
		}
		person.setDateOfBirthDay(personInformationForm.getBirthday());
		person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
		person.setDateOfBirthYear(personInformationForm.getBirthyear());
		person.setAddressLine1(personInformationForm.getHaddress1());
		person.setAddressLine2(personInformationForm.getHaddress2());
		person.setCity(personInformationForm.getHcity());
		person.setStateCode(personInformationForm.getHstate());
		person.setZip5(personInformationForm.getHzip());
		String ssn = personInformationForm.getSsn();
		CryptoUtil crypto = new CryptoUtil();
		String snumber = crypto.decode(ssn);
				
		 if((snumber != null)&& ( snumber.trim().length() > 0)){
			person.setSsn(snumber.replace("-",""));
		} 
		person.setAppname(personInformationForm.getAppname());
		person.setTransactionid(personInformationForm.getTransactionid());
		person.setReferencecode(personInformationForm.getReferencecode());
		person.setLexID(personInformationForm.getLexid());
		person.setLicenseNumber(personInformationForm.getLicense());
		person.setLicenseState(personInformationForm.getLicensestate());
				
		LexisNexisService service = new LexisNexisServiceImpl();
		String result = service.getOutPutHtml(person, lexisNexisSericeEndPoint);
		request.getSession().setAttribute("personalinformation", person);
		
 %>
<script>
	$(document).ready(function() {
	 	 focusTonext();
		 headPage();
		 qaPage();			
	});
</script>
<body>


<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />
	<div id="body">
		<div id="myProgress">
		  <div id="myBar">
		    <div id="mylabel">60%</div>
		  </div>
		</div>
	    <div id="response" class="Row" style="display:none;">
           	<div class="message-box failure" >
           	         <p>We were unable to validate the answers you have selected. Please answer the security questions again and click "Next".</p> 
           	</div>
        </div>
	<form id="quiz" NAME="quizvalidatetion"  method="post" autocomplete="off">
	<div align="center" >
		<div class="Row" >
			<div class="Column">
	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2">
				   	<fieldset>
				   			<div id="addresult">
				   			<div id="resultfromlexis">
				   	
										<%=result %>
							</div>
							</div>
							
					</fieldset>
				</div>
				
			</div>
			
			</div>
			<div class="Row" >	
					
			<!-- Submit Button -->
			<div id="quiz_submit" >					
				<button type="button" class="roundAll">Next ></button>
			</div>
			
			
			</div>
	
	</div>

	</div>
				<input type="hidden" id="quiz_fname" name="fname" value="<%=person.getFirstName()%>" ></input>								
				<input type="hidden" id="quiz_mname" name="mname" value="<%=person.getMiddleName()%>"></input>
				<input type="hidden" id="quiz_lname" name="lname" value="<%=person.getLastName()%>"></input>
				<input type="hidden" id="quiz_suffix" name="suffix"  value="<%=person.getSuffixName()%>" ></input>
				<input type="hidden" id="quiz_pnumber" name="pnumber" value="<%=person.getPnumber()%>" ></input>
				<input type="hidden" id="quiz_mnumber" name="mnumber" value="<%=person.getMnumber()%>" ></input>
				<input type="hidden" id="quiz_email" name="email" value="<%=person.getEmail()%>"></input>
				<input type="hidden" id="quiz_transactionid" name="transactionid" value="<%=person.getTransactionid()%>"></input>				
				<input type="hidden" id="quiz_appname" name="appname" value="<%=person.getAppname()%>"></input>				
				<input type="hidden" id="quiz_ssn" name="ssn" value="<%=person.getSsn()%>"></input>
				<input type="hidden" id="quiz_birthmonth" name="birthmonth" value="<%=person.getDateOfBirthMonth()%>" ></input>
				<input type="hidden" id="quiz_birthday" name="birthday" value="<%=person.getDateOfBirthDay()%>" ></input>	
				<input type="hidden" id="quiz_birthyear" name="birthyear" value="<%=person.getDateOfBirthYear()%>" ></input>
				<input type="hidden" id="quiz_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>" ></input>
				<input type="hidden" id="quiz_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>" ></input>
				<input type="hidden" id="quiz_hcity" name="hcity" value="<%=person.getCity()%>"></input>
				<input type="hidden" id="quiz_hstate" name="hstate" value="<%=person.getStateCode()%>"></input>	
				<input type="hidden" id="quiz_hzip" name="hzip" value="<%=person.getZip5()%>"></input>
				<input type="hidden" id="quiz_referencecode" name="referencecode" value="<%=person.getReferencecode()%>" ></input>	
				<input type="hidden" id="quiz_lexid" name="lexid" value="<%=person.getLexID()%>" ></input>	
				<input type="hidden" id="personal_license" name="license" value="<%=personInformationForm.getLicense()%>"></input>
                <input type="hidden" id="personal_licensestate" name="licensestate" value="<%=personInformationForm.getLicensestate()%>"></input>
				
		<jsp:include page="./footer.jsp" />		

		</form>

</body>
</html>


