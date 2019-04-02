	
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
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.ResponseCodes"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.ResponseCode"%>
<%@ page import="java.util.Properties"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.log4j.Logger"%>
<%! static Logger logger = Logger.getLogger(lexisnexisssnvalidation_jsp.class); %>
<!DOCTYPE html>
<html lang="en">
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">		

	<link href="assets/js/jquery/ui/1.10.3/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />
	<script src="assets/js/registerApp.js"></script>		
	<script src="assets/js/modalpopup.min.js"></script>
	<script src="assets/js/page.min.js"></script>

	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>


</head>

<%

		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");

  		PersonInformation person = (PersonInformation)request.getSession().getAttribute("personalinformation");
		if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
  			throw new Exception("Invalid Access");
  		}
		String fname  = person.getFirstName();
		String lname  = person.getLastName();
		String mname  = person.getMiddleName();
		String mnumber  = person.getMnumber();
		String pnumber  = person.getPnumber();
		String suffix  = person.getSuffixName();
		String haddress1  = person.getAddressLine1();
		String haddress2  = person.getAddressLine2();
		String hcity  = person.getCity();
		String hstate  = person.getStateCode();
		String hzip  = person.getZip5();
		String birthday  = person.getDateOfBirthDay();
		String birthmonth  = person.getDateOfBirthMonth();
		String birthyear  = person.getDateOfBirthYear();
		String ccn  = person.getAccountNumber();
		String email  = person.getEmail();
		String ssn  = person.getSsn();
		String mtype = person.getPhoneType();
		String transactionid = person.getTransactionid();
		String appname = person.getAppname();
		
		String otpsession = person.getOtpsession();
		String otpvalidation = person.getOtpvalidation();
		String idcheck = person.getIdcheck();
		String ccvalidation = person.getCcvalidation();
		String ssndlvalidation = person.getSsndlvalidation();
		String quizcheckcount = person.getQuizcheckcount();
		String otpcheckcount = person.getOtpcheckcount();
		String result = "";
		String vStatus = "PASS";
		String ssnCheckStatus ="";
		int qizCount=0;
		int otpcount=0;
		
			String formattedSSN= ssn.replace("-", "");
			person.setSsn(formattedSSN);   //Assign the Formatted SSN before the Webservice CALL 
			IdentityProofingResponse vresponse = validateSSN(person, lexisNexisSericeEndPoint);
			person.setSsn(ssn);   //Re-Assigning the Original SSN after the Webservice CALL
			if("PASS".equals(vresponse.getStatus())){
				ssnCheckStatus = "PASS";
				logger.info("LexisNexis SSN Validation: SUCCESS - First Name: "+fname+" Middle Name: "+mname+" Last Name: "+lname);
				ProductResponse[] prodResponseArry =  vresponse.getProductResponseArray(); 
				InstantVerifyResponse pResp =   (InstantVerifyResponse) prodResponseArry[0];
				VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0); 
	 			String lexID = pResp.getLexID();
		 		person.setLexID(lexID);
		 		request.getSession().setAttribute("SSN_DL_VALIDATION", "PASS");//SSN Validation PASS
		 		request.getSession().setAttribute("personalinformation", person); //RESET all the data to SESSION
		 		
				if(StringUtils.isNotBlank(mtype) && "CARD".equals(mtype)){
				
					response.sendRedirect("lexisCCValidation.jsp");   //Call Creditcard validation if CARD is selected
				}else{
			 		response.sendRedirect("phoneInformation.jsp");   //Call OTP if Credit Check Is not Required
				}
			}else{
				ssnCheckStatus = "FAIL";
				logger.info("LexisNexis SSN Validation: FAIL - FirstName: "+fname+" MiddleName: "+mname+" LastName: "+lname);
				if(!identityVerification(vresponse)) {
					logger.info("LexisNexis IdentityVerification Validation: FAIL - FirstName: "+fname+" MiddleName: "+mname+" LastName: "+lname);				
				}
				if(!OccupancyOwnershipVerification(vresponse)){
					logger.info("LexisNexis OccupancyOwnershipVerification Validation: FAIL - FirstName: "+fname+" MiddleName: "+mname+" LastName: "+lname);				
				}
				if(!dobVerifications(vresponse)){
					logger.info("LexisNexis DOBVerification Validation: FAIL - FirstName: "+fname+" MiddleName: "+mname+" LastName: "+lname);				
				}
				
				if(!identityVerification(vresponse) && OccupancyOwnershipVerification(vresponse) && dobVerifications(vresponse)){
					response.sendRedirect("personalinformationlicense.jsp");
				}else{
					result = "Your information could not be verified.<BR>  Please click the 'Next' button to return to the Personal Information page to correct your personal information and try again.";//verificationSubProductResponse(vresponse);
					vStatus = "FAIL";
				}
			}

 %>

 
<%!


			public IdentityProofingResponse  validateSSN(PersonInformation person, String lexisNexisSericeEndPoint) throws Exception {
			 	String workFlow = "FAA_B2B_VERIF_SSN_FLOW";
			 	person.setWorkFlow(workFlow);
				LexisNexisService service = new LexisNexisServiceImpl();
				return service.verificationRequest(person, lexisNexisSericeEndPoint);
				
			}
		
			public boolean validateCCAV(PersonInformation person, String lexisNexisSericeEndPoint) throws Exception { 
			  
				person.setWorkFlow("FAA_B2B_CCAV_VERIF");
				LexisNexisService service = new LexisNexisServiceImpl();
				
				String status = service.ccavRequest(person, lexisNexisSericeEndPoint); 
				
				if("PASS".equalsIgnoreCase(status)){
					return true;
				}else{
					return false;
				} 
			}


		public boolean identityVerification(IdentityProofingResponse response){
			boolean valid = true;
			if("FAIL".equals(response.getStatus().toString())){
					ProductResponse[] prodResponseArry =  response.getProductResponseArray(); 
					if(prodResponseArry.length > 0){
						InstantVerifyResponse pResp =   (InstantVerifyResponse) prodResponseArry[0];
						VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0); 
						 // vResp.getLexID();
						  CheckGroup[]   checkGroupArry = vResp.getCheckGroupArray();
						  
						  for (CheckGroup checkGroup : checkGroupArry) { 
							  Check[] checks = 	  checkGroup.getCheckArray(); 
							  if(checkGroup.getGroupName().equals("Identity Verification")){						  
									for (Check c : checks) {
											if("FAIL".equals(c.getStatus().toString())){
												return false;
											} 
									}
							  }
						}
					}
				}
				return valid;
		}
		
		public boolean OccupancyOwnershipVerification(IdentityProofingResponse response){
			boolean valid = true;
			if("FAIL".equals(response.getStatus().toString())){
					ProductResponse[] prodResponseArry =  response.getProductResponseArray(); 
					if(prodResponseArry.length > 0){					
						InstantVerifyResponse pResp =   (InstantVerifyResponse) prodResponseArry[0];
						VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0); 
						 // vResp.getLexID();
						  CheckGroup[]   checkGroupArry = vResp.getCheckGroupArray();
						  
						  for (CheckGroup checkGroup : checkGroupArry) { 
							  Check[] checks = 	  checkGroup.getCheckArray(); 
							  if(checkGroup.getGroupName().equals("Occupancy/Ownership Verification")){						  
									for (Check c : checks) {
											if("FAIL".equals(c.getStatus().toString())){
												return false;
											} 
									}
							  }
						}
				  }
				}
				return valid;
		}
		
		public boolean dobVerifications(IdentityProofingResponse response){
			boolean valid = true;
			if("FAIL".equals(response.getStatus().toString())){
					ProductResponse[] prodResponseArry =  response.getProductResponseArray(); 
					if(prodResponseArry.length > 0){					
						InstantVerifyResponse pResp =   (InstantVerifyResponse) prodResponseArry[0];
						VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0); 
						 // vResp.getLexID();
						  CheckGroup[]   checkGroupArry = vResp.getCheckGroupArray();
						  
						  for (CheckGroup checkGroup : checkGroupArry) { 
							  Check[] checks = 	  checkGroup.getCheckArray(); 
							  if(checkGroup.getGroupName().equals("DOBFullVerified")){						  
									for (Check c : checks) {
											if("FAIL".equals(c.getStatus().toString())){
												return false;
											} 
									}
							  }
						}
					}
				}
				return valid;
		}
		
		
		public String replaceValue(String value){
			String newVal = value;
			//if(value != null)
				// newVal =  newVal.replace("'", "&#39");
			return newVal;
		}
%>

