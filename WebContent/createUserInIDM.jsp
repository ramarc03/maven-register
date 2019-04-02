
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
<%@ page import="com.lexisnexis.model.ScoreInformation"%>
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
<%@ page import="java.util.Properties"%>
<%@ page import = "java.util.ResourceBundle" %>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>

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

		#myProgress {
		  position: relative;
		  width: 100%;
		  height: 30px;
		  background-color: #ddd;
		}
		
		#myBar {
		  position: absolute;
		  width: 100%;
		  height: 100%;
		  background-color: #3D5F11;
		}
		
		#label {
		  text-align: center;
		  line-height: 30px;
		  color: white;
		}
		
		#rcorners2 {
		  padding-right: 0px;
		}

	</style>


<%

		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String idmServiceEndPoint=resource.getString("IDMServiceEndPoint");
  		
 		String mnumber = "";
		if(personInformationForm.getMnumber()!=null){
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("(");
			buffer.append(personInformationForm.getMnumber().replace(" ",") "));
			mnumber = buffer.toString();
		}

		IdmUserInformation user = new IdmUserInformation();
		user.setUserid(java.util.UUID.randomUUID().toString());
		user.setFirstName(personInformationForm.getFname());
		user.setMiddleName(personInformationForm.getMname());
		user.setLastName(personInformationForm.getLname());
		user.setPrefixName(personInformationForm.getSuffix());
		user.setLexID(personInformationForm.getLexid());
		user.setEmail(personInformationForm.getEmail());
			
		user.setMobile(mnumber);
		user.setComanyName(personInformationForm.getCname());
		user.setTitle(personInformationForm.getTitle());
		user.setAddressLine1(personInformationForm.getCaddress1());
		user.setAddressLine2(personInformationForm.getCaddress2());		
		user.setCity(personInformationForm.getCcity());
		user.setStateCode(personInformationForm.getCstate());
		user.setZip5(personInformationForm.getCzip());
		user.setFax(personInformationForm.getCfax());
		user.setReferencecode(personInformationForm.getReferencecode());

			//user.toString();
 %>

<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />
	<div id="body">
	<form id="createUser" NAME="createuseridm" method="post" autocomplete="off">
		<div id="myProgress">
		  <div id="myBar">
		    <div id="label">100%</div>
		  </div>
		</div>
		<br>
	<div align="center" >

	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2" style="padding:10px;">
					
										<%=createUserInIDM(user, idmServiceEndPoint) %>
										
				</div>
				
		
	
	
	</div>

		</form>
		</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

 
<%!
	
		
		public String createUserInIDM(IdmUserInformation user, String endPoint) throws Exception {
			
		    IdmService service = new IdmServiceImpl();
		    StringBuilder builder = new StringBuilder();
		    String MESSAGE_UNKNOWN = "In attempting to create your MyAccess account an unknown error has been encountered, please try again or contact MyIT Service Center at 1-844-FAA-MyIT (322-6948) or go to helpdesk@FAA.gov";
			String MESSAGE_DUPLICATE = "The email you provided already exists.  Please try again using a unique email address.";
			String MESSAGE_LEXID_NOTUNIQUE = "Our records indicate you have already registered for a MyAccess credential. The email address you have previously registered is: ";
			builder.append("<div>");
		    try{
		    	String message = "";
				String result = service.extwsCreateUser(user, endPoint);
				if(result.equals("SUCCESS")){
					builder.append("<img src=\"assets/images/success.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">"); 
				
					message= 	"You have successfully initiated your MyAccess registration. An email has been sent to <font color=\"blue\"/>"+ user.getEmail() + "</font> with steps to complete the MyAccess registration process.";
				}else if(result.equals("FAILED_ID")){
					builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
				
					message= MESSAGE_UNKNOWN;
				}else if(result.equals("FAILED_NULL")){
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
				
						message= MESSAGE_UNKNOWN;
				
				}else if(result.equals("FAILED_DUPLICATE")){
			
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
				
						message= MESSAGE_DUPLICATE;	
						
										
				}else if(result.startsWith("FAILED_LEXID_NOTUNIQUE")){
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
						int index = result.lastIndexOf("_");
						message= MESSAGE_LEXID_NOTUNIQUE + "<font color=\"blue\"/>"+ result.substring(index+1) + "</font>";					
				
				}
				else if(result.equals("FAILED_UNKNOWN")){
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
				
						message= MESSAGE_UNKNOWN;
				
				}else {
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
						
						message= MESSAGE_UNKNOWN;
				
				}

				
					builder.append("<h1>");
					builder.append(message);
					builder.append("</h1>");
					
				}catch(Exception e){
						e.printStackTrace();
						builder.append("<img src=\"assets/images/unsuccess.jpg\" height=\"50\" width=\"50\" alt=\"Success Logo\">");
						
						builder.append("<h1>");
						builder.append(MESSAGE_UNKNOWN);
						builder.append("</h1>");
				}
			builder.append("</div>");
			return builder.toString();
	
		}

%>

