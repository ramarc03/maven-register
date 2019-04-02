	
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
		String CheckStatus ="";
		int qizCount=0;
		int otpcount=0;
		int qcount = Integer.parseInt(quizcheckcount);
		
		qizCount = Integer.parseInt(quizcheckcount);
		if(qizCount<3){
			result = getOutPutHtml(person, lexisNexisSericeEndPoint);
		}else{
			
			response.sendRedirect("quizerrorpage.jsp");
		}

 %>
<script>
	$(document).ready(function() {
	
	{
				var element_license=$("#quiz_license");
				element_license.addClass("valid");
				var element_licensestate=$("#quiz_licensestate");
				element_licensestate.addClass("valid");
	}

			$("#quiz_submit button").click(function(event){			
				event.preventDefault();
				
				var form_data=$("#quiz").serializeArray();
				var error_free=true;
				for (var input in form_data){

					var element=$("#quiz_"+form_data[input]["name"]);
					if(element.val()!="CC")
					{element.removeClass("invalid").addClass("valid");}
					else{element.removeClass("valid").addClass("invalid");}
					
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
					//var element_status=$("#quiz_vStatus");
					if("<%=CheckStatus%>" == "FAIL"){
						document.quizvalidatetion.action = "personalinformation.jsp";
					}else{
						document.quizvalidatetion.action = "quizvalidation.jsp";
					}
				
					document.quizvalidatetion.submit();
					disableNextButton("quiz_submit", "Please Wait.."); 
					return true;
				}
				
			});			
	});
</script>
<body>


<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />
	<div id="body">
	<% if(!vStatus.equals("FAIL")) { %>	
		<div id="myProgress">
		  <div id="myBar">
		    <div id="label">50%</div>
		  </div>
		</div>
		<% } %>
		<%if(qizCount>0){%>
	    <div class="Row" style="display:block;">
           	<div class="message-box failure" >
           	         <p>We were unable to validate the answers you have selected. Please answer the security questions again and click "Next".</p> 
           	</div>
        </div>
		<%} %>
	<form id="quiz" NAME="quizvalidatetion"  method="post" autocomplete="off">
	<div align="center" >
			<div class="Row">
			<% if(!vStatus.equals("FAIL")) { %>
			<p align="left">To validate your identity, you must answer all these security questions. </p>
			<% } else {%>
			<br>
			<%} %>
			</div>

		<div class="Row" >
			<div class="Column">
	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2">
				   	<fieldset>
										<%=result %>
							
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
				
				<input type="hidden" id="quiz_birthmonth" name="birthmonth" value="<%=person.getDateOfBirthMonth()%>" ></input>
				<input type="hidden" id="quiz_birthday" name="birthday" value="<%=person.getDateOfBirthDay()%>" ></input>	
				<input type="hidden" id="quiz_birthyear" name="birthyear" value="<%=person.getDateOfBirthYear()%>" ></input>
				<input type="hidden" id="quiz_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>" ></input>
				<input type="hidden" id="quiz_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>" ></input>
				<input type="hidden" id="quiz_hcity" name="hcity" value="<%=person.getCity()%>"></input>
				<input type="hidden" id="quiz_hstate" name="hstate" value="<%=person.getStateCode()%>"></input>	
				<input type="hidden" id="quiz_hzip" name="hzip" value="<%=person.getZip5()%>"></input>
				<input type="hidden" id="quiz_ccn" name="ccn" value="<%=person.getAccountNumber()%>"></input>
				<input type="hidden" id="quiz_phonetype" name="phonetype" value="<%=person.getPhoneType()%>"></input>	
				<input type="hidden" id="quiz_lexid" name="lexid" value="<%=person.getLexID()%>"></input>	
				<input type="hidden" id="quiz_otpsession" name="otpsession" value="<%=otpsession%>" ></input>	
				<input type="hidden" id="quiz_idcheck" name="idcheck" value="<%=idcheck%>" ></input>	
				<input type="hidden" id="quiz_ccvalidation" name="ccvalidation" value="<%=ccvalidation%>" ></input>	
				
				<input type="hidden" id="quiz_otpcheckcount" name="otpcheckcount" value="<%=otpcheckcount%>" ></input>	
				<input type="text" id="quiz_quizcheckcount" name="quizcheckcount" value="<%=quizcheckcount%>" ></input>	
				<input type="text" id="quiz_otpvalidation" name="otpvalidation" value="<%=otpvalidation%>" ></input>	
				<jsp:include page="./footer.jsp" />		

		</form>

</body>
</html>

 
<%!
		
	        public String getOutPutHtml(PersonInformation person, String lexisNexisSericeEndPoint){
		
				String outputhtml="";
				try{
					IdentityProofingResponse response = quizRequest(person, lexisNexisSericeEndPoint);
					
					if(response != null){
					
						outputhtml = getChoices(response);
						
					}
						
				}catch(Exception e){
					e.printStackTrace();
				}
				return outputhtml;
			}

			public String getChoices(IdentityProofingResponse response){
			
				StringBuilder builder = new StringBuilder();
			
				builder.append("<div>");
	
			
				if("PENDING".equalsIgnoreCase(response.getStatus())){
				
				ProductResponse[] prodResponseArry = response.getProductResponseArray();
				String transactionID = response.getTransactionID();
				String appname = response.getTransactionID();
				InstantAuthenticateResponse pResp = (InstantAuthenticateResponse) prodResponseArry[0];
				Questions questions = pResp.getQuestions();
				
				
				builder.append("<input type=\"hidden\"");
				builder.append(" id=\"quiz_transactionID");
				builder.append("\"");
				builder.append(" name=\"");
				builder.append("transactionID");
				
				builder.append("\" value=\"");
				builder.append(transactionID);
				builder.append("\">");
				
					String quizId = questions.getQuizId();
					Question[] questionsArry = questions.getQuestionArray();			
	
								
					builder.append("<input type=\"hidden\"");
					builder.append(" id=\"quiz_");
					builder.append("quiz_Id"+quizId);
					builder.append("\"");
					builder.append(" name=\"");
					builder.append("quiz_Id"+quizId);
					
					builder.append("\" value=\"");
					builder.append(quizId);
					builder.append("\">"); 
					int i = 1;
					for (Question question : questionsArry) {
						builder.append("<div>");
						builder.append("<div class=\"Row\">");
						builder.append("<label for=\"");
						builder.append(question.getQuestionId());
						builder.append("\"");
						builder.append(">");
						builder.append(question.getText());
						builder.append("</label>");
						builder.append("</div>");
						builder.append("<div class=\"Row\">");
						builder.append("<select id=\"quiz_");
						builder.append("quiz_qaId_"+i+"_"+question.getQuestionId());
						builder.append("\"");
						builder.append(" name=\"");
						builder.append("quiz_qaId_"+i+"_"+question.getQuestionId());
			
						builder.append("\" style=\"width: 400px;\">");
						builder.append("<option value=\"CC\">Select Choice</option>");
						Choice[] choices = question.getChoiceArray();
						
						for (Choice c : choices) {
							builder.append("<option value=");
							builder.append("\"");
							builder.append(c.getChoiceId());
							builder.append("\"");
							builder.append(">");
							builder.append( c.getText());
							builder.append("</option>");
						}
						
						builder.append("</select>");
						builder.append("</div>");
						builder.append("<div class=\"RowSpan\">");
						builder.append("<span class=\"error\">This field is required</span>");
						builder.append("</div>");
						builder.append("</div>");
						i++;
					}
				}else {
					builder.append("<h2>");
					builder.append("Status: ");
					builder.append(response.getStatus());
					builder.append("</h2>");
				}
				builder.append("</div>");
				return builder.toString();
		
			}


			public IdentityProofingResponse quizRequest(PersonInformation person, String lexisNexisSericeEndPoint) throws Exception {
				LexisNexisService service = new LexisNexisServiceImpl();
				person.setWorkFlow("FAA_B2B_AUTH_FLOW");
				IdentityProofingResponse response = service.quizRequest(person, lexisNexisSericeEndPoint);
				return 	response;	
			}


		
		public String replaceValue(String value){
			String newVal = value;
			//if(value != null)
				// newVal =  newVal.replace("'", "&#39");
			return newVal;
		}
%>

