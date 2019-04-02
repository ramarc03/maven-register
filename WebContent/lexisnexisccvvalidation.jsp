
<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%> 

<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.idm.model.IdmUserInformation"%>
<%@ page import="tews6.wsdl.ImsStatusDocument"%>
<%@ page import="tews6.wsdl.ImsStatusDocument.ImsStatus"%>
<%@ page import="com.idm.EXTWSCreateUserFaultMessage"%>
<%@ page import="com.idm.bo.IdmService"%>
<%@ page import="com.idm.bo.impl.IdmServiceImpl"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.Check"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.CheckGroup"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.Choice"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.InstantAuthenticateResponse"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.InstantVerifyResponse"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.LicenseType"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.ProductResponse"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.Question"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.Questions"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.VerificationSubProductResponse"%>
<%@ page import = "java.util.ResourceBundle" %>


<!DOCTYPE html>
<html lang="en">
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">	
	

	<link href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />
		
	<script src="assets/js/modalpopup.min.js"></script>
	<script src="assets/js/page.min.js"></script>

	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>
	<!-- reCAPTCHA Libary -->

</head>
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

<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  		
  		String fname = "";
		String mname = "";
		String lname = "";
		String suffix = "";
		String ssn = "";
		//String fivedigits = request.getParameter("fivedigits");
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
		//String lnumber = request.getParameter("lnumber");
		String email = "";
  		String license = "";
		String licensestate = "";	
		String cccount = "";
		
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
		 ssn = ESAPI.validator().getValidInput("ssn",request.getParameter("ssn"), "SSN", 11 ,true );
		 license = ESAPI.validator().getValidInput("license",request.getParameter("license"), "SafeString", 15 ,true );
		 licensestate = ESAPI.validator().getValidInput("licensestate",request.getParameter("licensestate"), "CityState", 100 ,true );
		 cccount = ESAPI.validator().getValidInput("cccount",request.getParameter("cccount"), "SafeNumeric", 11 ,true );
		
		
		
		if(suffix == null ||  (suffix!=null && suffix.equals("null")))
		{
			suffix ="";
		}
	
		String ssnHide = "";
		if(ssn == null || ssn.equals("null") || ssn.trim().length()==0)
		{
			ssn ="";
		}else{
			ssnHide = ssn.substring(7);	
			ssnHide = "*******"+ssnHide;
		}

		if(haddress2 == null)
		{
			haddress2 ="";
		}

		
		
		int cccountInt = Integer.parseInt(cccount);	
		cccountInt++;
		cccount = String.valueOf(cccountInt);
		PersonInformation person = new PersonInformation();
		person.setFirstName(fname);
		person.setLastName(lname);
		person.setMiddleName(mname);
		person.setMnumber(mnumber);
		person.setSuffixName(suffix);
		person.setAddressLine1(haddress1);
		person.setAddressLine2(haddress2);
		person.setCity(hcity);
		person.setStateCode(hstate);
		person.setZip5(hzip);
		person.setDateOfBirthDay(birthday);
		person.setDateOfBirthMonth(birthmonth);
		person.setDateOfBirthYear(birthyear);
		person.setAccountNumber(ccn);
		person.setEmail(email);
		if((ssn!= null) && (!ssn.isEmpty())){
			ssn = ssn.replaceAll("-","");
			person.setSsn(ssn);
		}
		request.getSession().setAttribute("personalinformation", person);
		
		if(!validateCCAV(person, lexisNexisSericeEndPoint)){
			if(cccountInt < 4){
				response.sendRedirect("creditcardinformation.jsp?cccount="+ cccount);
			}else{
				response.sendRedirect("creadicarderror.jsp");
				
			}
		}else{
			if(ssn!=null && ssn.trim().length()>0 ){
				response.sendRedirect("lexisnexisssnvalidation.jsp?cccount="+ cccount);
			}else{
				response.sendRedirect("personalinformationlicense.jsp");
			}
			
		}

 %>


 
<%!
			public boolean validateCCAV(PersonInformation person, String endPoint) throws Exception { 
			  
				person.setWorkFlow("FAA_B2B_CCAV_VERIF");
				LexisNexisService service = new LexisNexisServiceImpl();
				
				String status = service.ccavRequest(person, endPoint); 
				
				if("PASS".equalsIgnoreCase(status)){
					return true;
				}else{
					return false;
				} 
			}
		public String replaceValue(String value){
			String newVal = value;
			if(value != null)
				 newVal =  newVal.replace("'", "&#39");
			return newVal;
		}
%>

