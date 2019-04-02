<!DOCTYPE html>
<html lang="en">
<%@page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.register.formbeans.PersonInformationForm"%>
<%@ page import="com.register.util.CryptoUtil"%>
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
	<script src="assets/js/external.js"></script>
		
</head>
<style>

</style>
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server

	String phoneNum = "";
	if(personInformationForm.getPhonetype()!=null){
	 	if(personInformationForm.getPhonetype().trim().equals("MOBILE")){
			StringBuffer buffer = new StringBuffer();
			if((personInformationForm.getMnumber()!=null)&&(personInformationForm.getMnumber().trim().length() >0)){
			
				buffer.append("(");
				buffer.append(personInformationForm.getMnumber().replace(" ",") "));
			}
			phoneNum = buffer.toString();
			
			//phoneNum = personInformationForm.getMnumber();
		}else{
			StringBuffer buffer = new StringBuffer();
			if((personInformationForm.getPnumber()!=null)&&(personInformationForm.getPnumber().trim().length() >0)){
			
				buffer.append("(");
				buffer.append(personInformationForm.getPnumber().replace(" ",") "));
			}
			phoneNum = buffer.toString();
			//phoneNum = personInformationForm.getPnumber();
		}
	}
	String mnumber = "";
	if((personInformationForm.getMnumber()!=null)&&(personInformationForm.getMnumber().trim().length() >0)){
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getMnumber().replace(" ",") "));
		mnumber = personInformationForm.getMnumber();
	}
	String pnumber = "";
	if((personInformationForm.getPnumber()!=null)&&(personInformationForm.getPnumber().trim().length() >0)){
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getPnumber().replace(" ",") "));
		pnumber = personInformationForm.getPnumber();
	}
	
	String snumber = personInformationForm.getSsnencode();
	    
	String mtype = "";
	mtype = personInformationForm.getPhonetype();
	//System.out.println(" mtype : "+ mtype);
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
	
%>
<script>


	$(document).ready(function() {
 		focusTonext();
		headPage();
		showPhoneinfo();
	});
	
</script>
<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	

	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">
	
		<div id="myProgress">
		  <div id="myBar">
		    <div id="mylabel">40%</div>
		  </div>
		</div>

        <div class="Row">
            <p align="left">In order to validate your identity, we need to send a One Time Password to a phone registered in your name or your family's name. Please re-verify your registered phone number and click 'Next'.</p>
            <%if("LAND".equals(personInformationForm.getPhonetype())){ %>
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
        <div id="response" class="Row" style="display:none;">
           	<div class="message-box failure" >
           			 <div id="messageid">
           			 </div>
           	</div>
        </div>
 
		<div   id="rcorners2">
				      <fieldset>
				      		 <div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_mtype" class="visuallyhidden">mtype</label>
								
									<label for="personal_mtype"><font color="#B30000">* </font>Identity Verification Options</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">
										<div class="Column" style="width:20%;vertical-align: middle;">
										<input type="radio" id="personal_mtype" name="mtype" value="MOBILE"  <%=mchecked%>> Mobile Phone				
										</div>
										<div class="Column" style="width:28%;vertical-align: middle;">
										<input type="radio" id="personal_mtype" name="mtype" value="LAND"  <%=lchecked%>> Home/Landline Phone
										</div>
									</div>					
									<div class="RowSpan">
										<span class="error"></span>
									</div>
								</div>
							</div>
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
<input type="hidden" id="personal_fname" name="fname" value="<%=personInformationForm.getFname()%>" ></input>								
<input type="hidden" id="personal_mname" name="mname" value="<%=personInformationForm.getMname()%>"></input>
<input type="hidden" id="personal_lname" name="lname" value="<%=personInformationForm.getLname()%>"></input>
<input type="hidden" id="personal_suffix" name="suffix"  value="<%=personInformationForm.getSuffix()%>" ></input>
<input type="hidden" id="personal_pnumber" name="pnumber" value="<%=pnumber%>" ></input>
<input type="hidden" id="personal_mnumber" name="mnumber" value="<%=mnumber%>" ></input>
<input type="hidden" id="personal_email" name="email" value="<%=personInformationForm.getEmail()%>"></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=personInformationForm.getHaddress1()%>" ></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=personInformationForm.getHaddress2()%>" ></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=personInformationForm.getHcity()%>"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=personInformationForm.getHstate()%>"></input>	
<input type="hidden" id="personal_hzip" name="hzip" value="<%=personInformationForm.getHzip()%>"></input>
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=personInformationForm.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=personInformationForm.getAppname()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	
<input type="hidden" id="personal_lexid" name="lexid" value="<%=personInformationForm.getLexid()%>" ></input>	
<input type="hidden" id="personal_birthmonth" name="birthmonth" value="<%=personInformationForm.getBirthmonth()%>"></input>
<input type="hidden" id="personal_birthday" name="birthday" value="<%=personInformationForm.getBirthday()%>"></input>	
<input type="hidden" id="personal_birthyear" name="birthyear" value="<%=personInformationForm.getBirthyear()%>"></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=personInformationForm.getHaddress1()%>"></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=personInformationForm.getHaddress2()%>"></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=personInformationForm.getHcity()%>" size="40"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=personInformationForm.getHstate()%>"></input>								
<input type="hidden" id="personal_hzip" name="hzip" value="<%=personInformationForm.getHzip()%>"></input>
<input type="hidden" id="personal_ssn" name="ssn" value="<%=snumber%>"></input>
<input type="hidden" id="personal_license" name="license" value="<%=personInformationForm.getLicense()%>"></input>
<input type="hidden" id="personal_licensestate" name="licensestate" value="<%=personInformationForm.getLicensestate()%>"></input>
		</form>
                   <div class="Row">
                                    
                                <!-- Submit Button -->
                                <div align="center" id="personal_submit" >					
                                    <button type="button" class="roundAll">Next ></button>
                                </div>
                  </div>
		</div>
	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

