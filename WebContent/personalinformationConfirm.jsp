<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<html lang="en">
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.register.frontend.util.CustomXssInputValidator"%>
<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page import="com.register.util.CryptoUtil"%>
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	<link rel="stylesheet" href="assets/css/externalreg.css">
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">
		
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>
	<script src="assets/js/registerApp.js"></script>	
	<script src="assets/js/external.js"></script>
	<script src="assets/js/external.js"></script>
	
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 
</head>

<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<%  

	if(personInformationForm == null || (personInformationForm!= null && StringUtils.isBlank(personInformationForm.getFname()))){
		throw new Exception("Invalid Access");
	}
   if (!personInformationForm.validate()) {	
%>
	<jsp:forward page="personalinformation.jsp"/>
<%
   }
%>
<style>

</style>

<script>


	$(document).ready(function() {
			headPage();
			personalConfPage();

	});
	
</script>
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
		
	ResourceBundle resource = ResourceBundle.getBundle("externalreg");
	String creditCardFlag=resource.getString("CREDIT_CARD_CHECK");

	String snumber = "";
	String mtype = "";

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
	mtype = person.getPhoneType();
	
	String cdchecked ="";
	String mchecked ="";
	String lchecked ="";
	if("MOBILE".equals(mtype)){
		mchecked="checked";
	}else if("LAND".equals(mtype)){
		lchecked="checked";
	}else{
		cdchecked="checked";
	}

	snumber=person.getSsn();
	
	String numberTrim = "";
	if(StringUtils.isNotBlank(snumber)){
		numberTrim = snumber.substring(7);	
		numberTrim = "*******"+numberTrim;
	}
	
	String cccount = "1";	
	
	
	     CryptoUtil crypto = new CryptoUtil();
	 	 String encode = crypto.encode(personInformationForm.getSsn());
         
	%>
	

<body>



<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="confirompersonal" method="post" autocomplete="off">
		
		<div id="myProgress">
		  <div id="myBar">
		    <div id="mylabel">20%</div>
		  </div>
		</div>
		<div id="response" class="Row" style="display:none;">
           	<div class="message-box failure" >
           			 <div id="messageid">
           			 </div>
           	</div>
        </div>
            <div class="Row">
            	<p align="left">Please confirm if the provided personal information is correct. If all the fields are correct then click on "Next" otherwise click on "Edit" to correct the information.</p>
            </div>
			<div   id="rcorners2">
				
				      <fieldset>
									<div class="Row">
										 <div class="ColumnLabel">
											<label for="personal_fname">First Name</label>
										</div>
										 <div class="Column" style="width:60%">
			 								<div class="Row">
			 									<input type="text" id="personal_fname" name="fname" value="<%=person.getFirstName()%>" size="40" maxlength="100" readonly autofocus></input>								
											</div>
											<div class="RowSpan">
												<span class="error">This field is required</span>
											</div>							
										</div>
									</div>
									<div class="Row">
										<div class="ColumnLabel">
											<label for="personal_mname">Middle Name</label>
										</div>
										<div class="Column" style="width:60%">		
			 								<div class="Row">
			 									<input type="text" id="personal_mname" name="mname" value="<%=person.getMiddleName()%>" size="40" maxlength="100" readonly></input>
											</div>
											<div class="RowSpan">
												<span class="error"></span>
											</div>							
										</div>
									</div>
							<div class="Row">
								<div class="ColumnLabel">
									<label for="personal_lname">Last Name</label>
								</div>
								<div class="Column" style="width:60%">		
	 								<div class="Row">
		 								<input type="text" id="personal_lname" name="lname" value="<%=person.getLastName()%>" size="40" maxlength="100" readonly></input>
									</div>
									<div class="RowSpan">
										<span class="error">This field is required</span>
									</div>							
								</div>
							</div>
							<div class="Row">
								<div class="ColumnLabel">
								<label for="personal_suffix">Suffix</label>
								</div>
								<div class="Column" style="width:60%">
	 								<div class="Row">
										<input type="text" id="personal_suffix" name="suffix"  value="<%=person.getSuffixName()%>"  size="40" maxlength="100" readonly></input>
									</div>
									<div class="RowSpan">
										<span class="error"></span>
									</div>
								</div>
							</div>	
	                        
	                        <div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_idoptions">Identity verification Option</label>
								</div>
								<div class="Column" style="width:60%">
								<div class="Row">
									<%if(StringUtils.isNotBlank(creditCardFlag) && "YES".equalsIgnoreCase(creditCardFlag)){ %>
									<div class="Column" style="width:22%;vertical-align: middle;">
									<input type="radio" id="personal_card" name="mtype" value="CARD" disabled <%=cdchecked%>> Credit/Debit Card
									</div>
									<%} %>
									<div class="Column" style="width:17%;vertical-align: middle;">
									<input type="radio" id="personal_mtype" name="mtype" value="MOBILE" disabled <%=mchecked%>> Mobile Phone				
									</div>
									<div class="Column" style="width:30%;vertical-align: middle;">
									<input type="radio" id="personal_mtype" name="mtype" value="LAND" disabled <%=lchecked%>> Home/Landline Phone
									</div>
								</div>
								<div class="RowSpan">
									<span class="error">A valid option is required</span>
								</div>
								</div>
							</div>
					                        
	                        <div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_pnumber">Phone Number to verify you today</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">	
										<div class="Column" style="width:25%">
											<input type="text" id="personal_pnumber" name="pnumber" value="<%=person.getPnumber()%>" size="14" maxlength="14" readonly></input>	
										</div>
									</div>									
									<div class="RowSpan">
										<span class="error">A valid phone number is required</span>
									</div>
								</div>				
							</div>	                        
	                        
		                     	<div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_mnumber" style="margin-left:90px;">Mobile Number to reset your password in the future</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">	
										<div class="Column" style="width:25%">
											<input type="text" id="personal_mnumber" name="mnumber" value="<%=person.getMnumber()%>" size="14" maxlength="14" readonly></input>	
										</div>
									</div>									
									<div class="RowSpan">
										<span class="error">A valid Mobile number is required</span>
									</div>
								</div>				
							</div>
								<div class="Row">
									<div class="ColumnLabel">			
										<label for="personal_email">Email</label>
									</div>
									<div class="Column" style="width:60%">
		 								<div class="Row">
			 								<input type="text" id="personal_email" name="email" value="<%=person.getEmail()%>" size="40" maxlength="100" readonly></input>								
										</div>
										<div class="RowSpan">
											<span class="error">A valid email address is required</span>
										</div>							
									</div>			
								</div>

											<div class="Row">
												 <div class="ColumnLabel">
													<label for="personal_ssn">SSN</label>
												</div>
													<div class="Column" style="width:60%">
									 					<div class="Row">
									 						<input type="text" id="personal_ssnHide" name="ssnHide" value="<%=numberTrim%>" size="11" maxlength="11" readonly></input>
														</div>
														<input type="hidden" id="personal_ssn" name="ssnencode" value="<%=encode%>" size="11" maxlength="11" ></input>
														
														<div class="RowSpan">
															<span class="error">A valid SSN number is required</span>
														</div>				
													</div>
											</div>
						
											<div class="Row">
												<div class="ColumnLabel">
													<label for="personal_bdate">Date of Birth</label>
												</div>
												<div class="Column" style="width:60%">
														<div class="Column">	
															<div class="Column">	
																<input type="text" id="personal_birthmonth" name="birthmonth" placeholder="MM" value="<%=person.getDateOfBirthMonth()%>" size="2" maxlength="2" readonly></input>
															</div>
															<div class="RowSpan">
																	<span class="error">Valid birth month is required</span>
															</div>	
														</div>
														<div class="Column">	
															<div class="Column">
																<input type="text" id="personal_birthday" name="birthday" placeholder="DD"  value="<%=person.getDateOfBirthDay()%>" size="2" maxlength="2" readonly></input>	
															</div>
															<div class="RowSpan">
																	<span class="error">Valid birth day is required</span>
															</div>	
														</div>
														<div class="Column">	
															<div class="Column">
																<input type="text" id="personal_birthyear" name="birthyear" placeholder="YYYY" value="<%=person.getDateOfBirthYear()%>" size="4" maxlength="4" readonly></input>
															</div>
															<div class="RowSpan">
																	<span class="error">Valid birth year is required</span>
															</div>	
														</div>
								
												</div>
											</div>

						

   						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_haddress1">Street Address 1</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 						<input type="text" id="personal_haddress1" name="haddress1" value="<%=person.getAddressLine1()%>" size="40" maxlength="100" readonly></input>
								</div>
								<div class="RowSpan">
									<span class="error">This field is required</span>
								</div>
							</div>
			
						</div>
						 <div class="Row">
								<div class="ColumnLabel" >
									<label for="personal_haddress2">Street Address 2</label>
								</div>
								<div class="Column" style="width:60%">
				 					<div class="Row">
				 						<input type="text" id="personal_haddress2" name="haddress2" value="<%=person.getAddressLine2()%>" size="40" maxlength="100" readonly></input>
									</div>
									<div class="RowSpan">
										<span class="error"></span>
									</div>
								</div>
						</div>
						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_hcity">City</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
				 		 			<input type="text" id="personal_hcity" name="hcity" value="<%=person.getCity()%>" size="40" maxlength="100" readonly></input>
								</div>
								<div class="RowSpan">
									<span class="error">This field is required</span>
								</div>				
								</div>
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_hstate">State</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					<input type="text" id="personal_hstate" name="hstate" value="<%=person.getStateCode()%>" size="40" maxlength="100" readonly></input>								
							</div>
								<div class="RowSpan">
									<span class="error">This field is required</span>
								</div>
							</div>
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_hzip">Zip</label>
							</div>
							<div class="Column" style="width:60%">
			 					<div class="Row">
			 			 			<input type="text" id="personal_hzip" name="hzip" value="<%=person.getZip5()%>" size="5" maxlength="5" readonly></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid zip code is required</span>
								</div>
							</div>
			
						</div>
					    </fieldset>
					  
						<div class="Row">
							<br>
						</div>	
			</div>	
				
<input type="hidden" id="personal_phonetype" name="phonetype" value="<%=personInformationForm.getMtype()%>" ></input>				
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=personInformationForm.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_appanme" name="appname" value="<%=personInformationForm.getAppname()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	
<input type="hidden" id="personal_lexid" name="lexid" value="<%=personInformationForm.getLexid()%>" ></input>	
	
            <div class="bottom-container" style="display: flex;align-items: center;flex-direction: row;">
                             <div class="text-bottom" style="justify-content: flex-start; margin-top:18px;"> 
                           
            	             <strong><font color="#ff8040">If you select Edit, you may have to re-enter your SSN</font></strong>
            	             </div>
                           
                           	<div class="button-wrapper" style="margin-left:60px;">
                              
                               <div  class="Column" id="personal_edit" style= "padding-right: 10px;">					
                                   <button type="button" class="roundAll">< Edit&nbsp</button>
                               </div>
                               <div  class="Column" id="personal_continue"  style= "padding-left: 10px;">					
                                   <button type="button" class="roundAll">Next ></button>
                               </div>
                 			</div>
            </div>
	                 
      		</form>
      				    
		</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

<%!
		public String replaceValue(String value){
			//String newVal =  value.replace("'", "&#39");
			return value;
		}
 %>
