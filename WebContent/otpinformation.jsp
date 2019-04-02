<!DOCTYPE html>
<html lang="en">
<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.register.otp.bo.OTPService"%>
<%@ page import="com.register.otp.bo.impl.OTPServiceImpl"%>
<%@ page import="com.register.formbeans.PersonInformationForm"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.log4j.Logger"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">		
	<link rel="shortcut icon" href="favicon.ico">
	<script src="assets/js/registerApp.js"></script>  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<script src="assets/js/external.js"></script>
	
</head>
<style>

</style>

<script>
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server	

	ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  	String verifyphone=resource.getString("VerifyphoneServiceEndPoint");
  	String generateotponce=resource.getString("GenerateotponceServiceEndPoint");
	String accountNumber = "1817165";
	PersonInformation person = new PersonInformation();
	person.setFirstName(personInformationForm.getFname());
	person.setLastName(personInformationForm.getLname());
	person.setMiddleName(personInformationForm.getMname());
	person.setSuffixName(personInformationForm.getSuffix());
	person.setPhoneType(personInformationForm.getMtype());  
	//System.out.println(personInformationForm.getMtype()); 
	person.setEmail(personInformationForm.getEmail());
	person.setDateOfBirthDay(personInformationForm.getBirthday());
	person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
	person.setDateOfBirthYear(personInformationForm.getBirthyear());
	person.setAddressLine1(personInformationForm.getHaddress1());
	person.setAddressLine2(personInformationForm.getHaddress2());
	person.setCity(personInformationForm.getHcity());
	person.setStateCode(personInformationForm.getHstate());
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

	person.setZip5(personInformationForm.getHzip());
	String ssn = personInformationForm.getSsn();
	if((ssn != null)&& ( ssn.trim().length() > 0)){
		person.setSsn(ssn.replace("-",""));
	}
	person.setAppname(personInformationForm.getAppname());
	person.setTransactionid(personInformationForm.getTransactionid());
	person.setReferencecode(personInformationForm.getReferencecode());
	person.setLexID(personInformationForm.getLexid());
	person.setReferencecode(personInformationForm.getReferencecode());
	person.setHnumber(personInformationForm.getHnumber());
	person.setOtpsession(personInformationForm.getOtpsession());
	String personInfo ="First Name:"+person.getFirstName()+"  Last Name:"+person.getLastName();
	String sessionid = generateOTP(person, person.getHnumber(),person.getPhoneType(), accountNumber, generateotponce);
	//System.out.println(" sessionid :"+ sessionid);  
	if(sessionid == null){
		response.sendRedirect("generateotpcodeerror.jsp");
	}else{
		person.setOtpsession(sessionid);
	}		    	
	person.setLicenseNumber(personInformationForm.getLicense());
	person.setLicenseState(personInformationForm.getLicensestate());
%>

	$(document).ready(function() {
		focusTonext();
		headPage();
		optInfo();	
	});
	
</script>

<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">

		<input type="text" id="personal_sessionid" name="sessionid" value="<%=person.getOtpsession()%>" style="display: none;" />	

				
		<div id="myProgress">
		  <div id="myBar">
		    <div id="mylabel">50%</div>
		  </div>
		</div>
 		<div id="response" class="Row" style="display:none;">
           	<div class="message-box failure" >
           			 <div id="messageid">
           			 </div>
           	</div>
        </div>  
		    <div id="personal_nossn" class="Row" style="display:none;">
            	<div class="message-box failure" >
            	         <p>We were unable to validate the One Time password provided. Please re-enter the valid password.</p> 
            	</div> 

            </div>
            <div class="Row">
            <%if("MOBILE".equals(person.getPhoneType())){%>
            <p align="left">A One Time Password has been sent to your mobile phone. Please enter the password you received.</p>
            <%}else{ %>
            <p align="left">A One Time Password has been sent to your Landline phone. Please enter the password you received.</p>
            <%} %>
            </div>
		<div  id ="initmessage" class="message-box info">
		  <p>You must enter the passcode on this webpage within 10 minutes of receipt.</p>
		</div>
		<div   id="rcorners2">
				
				      <fieldset>


						<div class="Row">
							<div class="ColumnLabel">							 	
								<label for="personal_otp"><font color="red">* </font>One Time Password</label>
							</div>
							<div class="Column" style="width:60%">
				 					<div class="Row">
									<input type="text" id="personal_otp" name="otp" value="" placeholder="XXXXX" size="5" maxlength="5" autofocus></input>
									</div>
									<div class="RowSpan">
										<span class="error">A valid One Time Password is required.</span>
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
                                    <button type="button" class="roundAll">Submit</button>
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
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=person.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=person.getAppname()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=person.getReferencecode()%>" ></input>	
<input type="hidden" id="personal_otpsession" name="otpsession" value="<%=person.getOtpsession()%>" ></input>	
<input type="hidden" id="personal_birthmonth" name="birthmonth" value="<%=person.getDateOfBirthMonth()%>"></input>
<input type="hidden" id="personal_birthday" name="birthday" value="<%=person.getDateOfBirthDay()%>"></input>	
<input type="hidden" id="personal_birthyear" name="birthyear" value="<%=person.getDateOfBirthYear()%>"></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>"></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>"></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=person.getCity()%>" size="40"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=person.getStateCode()%>"></input>								
<input type="hidden" id="personal_hzip" name="hzip" value="<%=person.getZip5()%>"></input>
<input type="hidden" id="personal_ssn" name="ssn" value="<%=person.getSsn()%>"></input>
<input type="hidden" id="personal_license" name="license" value="<%=person.getLicenseNumber()%>"></input>
<input type="hidden" id="personal_licensestate" name="licensestate" value="<%=person.getLicenseState()%>"></input>


		</form>

		</div>	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

<%!

	 public String  generateOTP(PersonInformation person, String phoneNumber,String deliveryType, String accountNumber, String endPoint) throws Exception { 
	 
		  OTPService service = new OTPServiceImpl();
	  
		  return service.generateOTP(person, phoneNumber,deliveryType, accountNumber,endPoint); 	  
	 }
 %>
