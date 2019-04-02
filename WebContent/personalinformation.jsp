<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.register.formbeans.PersonInformationForm"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.register.util.CryptoUtil"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<%

//TO obtain CREDIT CARD Check flag
ResourceBundle resource = ResourceBundle.getBundle("externalreg");
String creditCardFlag=resource.getString("CREDIT_CARD_CHECK");
String recaptchaCheckFlag=resource.getString("RECAPTCHA_CHECK_REQ");

%>
<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	
		String fname = "";
		String mname = "";
		String lname ="";
		String suffix ="";
		String haddress1 ="";
		String haddress2 ="";
		String hcity = "";
		String hstate = "";
		String hzip = "";
		String mnumber = "";
		String pnumber = "";
		String birthday = "";
		String birthmonth = "";
		String birthyear = "";
		String ccn = "";
		String email = "";
		String ssn = "";
		String mtype = "";
		String transactionid = "";
		String target = (String)request.getParameter("TARGET");
		//System.out.println(" target :" + target);
		String appname = "NON";
		if((personInformationForm.getAppname() != null) && (personInformationForm.getAppname().trim().length() >0)){
			appname = personInformationForm.getAppname();
		}else if((target != null) && (target.trim().length() >0 )){
		
			int startIndex = target.indexOf("//");	
			if(startIndex == -1){
				startIndex = 0;
			}else{
				startIndex = startIndex+2;
			}
			int endIndex = target.indexOf("/", startIndex+4);	
					
			if(endIndex != -1){
				target =  target.substring(startIndex, endIndex);
				//System.out.println(target + " :" + appname);
			}else{
				target =  target.substring(startIndex);
				//System.out.println(target + " :" + appname);
			}
		
			try{
				appname = resource.getString(target.trim());
				//System.out.println(target + " :" + appname);
				
			}catch(Exception e){
		
				appname="NON";
			}
		}
		//System.out.println(target + " :" + appname);
		
		if((appname != null) && (appname.trim().length() > 0)){
			personInformationForm.setAppname(appname);
		}
	
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
	   
	CryptoUtil crypto = new CryptoUtil();
 	String encodessn = crypto.encode(personInformationForm.getSsn());
    person.setSsn(encodessn);  

	person.setAppname(personInformationForm.getAppname());
	StringBuilder transactionidString = new StringBuilder();
	transactionidString.append(java.util.UUID.randomUUID());
	transactionidString.append(":");
	transactionidString.append(personInformationForm.getAppname());
	personInformationForm.setTransactionid(transactionidString.toString());
	if(!StringUtils.isNotBlank(personInformationForm.getReferencecode())){	
		personInformationForm.setReferencecode(transactionidString.toString());
	}
		
		if(person != null && !StringUtils.isBlank(person.getFirstName())){
			fname  = person.getFirstName();
			lname  = person.getLastName();
			mname  = person.getMiddleName();
			mnumber  = person.getMnumber();
			pnumber  = person.getPnumber();
			suffix  = person.getSuffixName();
			haddress1  = person.getAddressLine1();
			haddress2  = person.getAddressLine2();
			hcity  = person.getCity();
			hstate  = person.getStateCode();
			hzip  = person.getZip5();
			birthday  = person.getDateOfBirthDay();
			birthmonth  = person.getDateOfBirthMonth();
			birthyear  = person.getDateOfBirthYear();
			ccn  = person.getAccountNumber();
			email  = person.getEmail();
			ssn  = person.getSsn();
	     	mtype = person.getPhoneType();   //mtype is for Mobile, land and Credit card
  		}
		
					
		String cdchecked ="";
		String mchecked ="";
		String lchecked ="";
		if("MOBILE".equals(mtype)){
			mchecked="checked";
		}else if("LAND".equals(mtype)){
			lchecked="checked";
		}else{
			if(StringUtils.isNotBlank(creditCardFlag) && "YES".equalsIgnoreCase(creditCardFlag)){
				cdchecked="checked";
			}else{
				mchecked="checked";
			}
		}

	%>


<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<!--<script>if(top!=self){top.location=self.location;}</script>-->
	<style>html {diplay:none}</style>    
	<script>        
		if(self == top){ document.documentElement.style.display = "block";} 
		else {top.location = self.location;}    
	</script>	
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>U.S. Department of Transportation: My Access: Sign In</title>
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

<!-- SiteMinder Encoding=UTF-8; -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script src="js/ArcotAdapterIntegration.js"></script> -->
	
	<!-- reCAPTCHA Libary -->
	<script src="https://www.google.com/recaptcha/api.js"></script>
</head>
<style>

</style>

<script>
$(document).ready(function() {
		<%if("MOBILE".equals(mtype) || (StringUtils.isNotBlank(creditCardFlag) && "NO".equalsIgnoreCase(creditCardFlag) ) ){%>
			$("#pmandate").show();
		<%}else if("LAND".equals(mtype) || (StringUtils.isNotBlank(creditCardFlag) && "NO".equalsIgnoreCase(creditCardFlag) )){%>
			$("#pmandate").show();
		<%}else{%>
			$("#pmandate").hide();
		<%}%>
		 			
 		<%if(StringUtils.isNotBlank(recaptchaCheckFlag) && "NO".equalsIgnoreCase(recaptchaCheckFlag)){%>
 			$("#personal_recaptchahide").addClass("valid"); //Allow Recaptcha failure for security scanning
 		<%}%>
 		
 		focusTonext();
		headPage();
		personalPage();
		personalPageOpeartions();
	
});
</script>


<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">
	
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">
		<input type="text" id="personal_stateHide" name="stateHide" value="<%=hstate%>" style="display: none;" />
		<input type="text" id="personal_suffixhide" name="suffixhide" value="<%=suffix%>" style="display: none;"/>
		<input type="text" id="personal_recaptchahide" name="recaptchahide" value="" style="display: none;" />			 					
		
		<div id="myProgress">
		  <div id="myBar">
		  </div>
		</div>
		
		<div id="firstRowBox">
			<p class="firstRowAlignleft">Please fill out the form below.</p>
			<p class="firstRowAligncenter"><b>Please do not proceed if you are a DOT/FAA employee or contractor.</b></p>
			<p class="firstRowAlignright"><b><a id="privacy2"  href="privacy.html" style="font-size: 1.0em;">How we protect your Privacy?</a></b></p>
		</div>
		<BR>
		<BR>
		<div id="divfirstRowBox">
		<BR>
		<BR>
		</div>
		
<div   id="rcorners2">
<fieldset>
	<div id="rcornersdoted">
	        <div class="Row">            
            	Registration Page for a Department of Transportation MyAccess account.
            </div>
            <div class="Row">            
            	<strong><font color="#ff8040">Law Enforcement and Applicants who have Opted out of Public Data will not be able to validate their identity, until they Opt in.</font></strong>
            </div>
            <BR>
					      <!-- First name start -->
										<div class="Row">
											 <div class="ColumnLabel">
												<label for="personal_fname"><font color="#B30000">* </font>First Name</label>
											</div>
											 <div class="Column" style="width:60%">
				 								<div class="Row">
				 									<input type="text" id="personal_fname"  name="fname" value="<%=fname%>" size="35" maxlength="100" autofocus></input>												
				 								</div>
												<div class="RowSpan">
													<span class="error">A valid First name is required</span>
												</div>							
										</div>
							 		</div>
							<!-- First name end -->
										
							<!-- Mid name name start -->
							
										<div class="Row">
											<div class="ColumnLabel">
												<label for="personal_mname">Middle Name</label>
											</div>
											<div class="Column" style="width:60%">		
				 								<div class="Row">
													<input type="text" id="personal_mname"  name="mname" value="<%=mname%>" size="35" maxlength="100" ></input>
												</div>
												<div class="RowSpan">
													<span class="error">A valid Middle name is required</span>
												</div>							
											</div>
										</div>
						<!-- Mid name  end -->
						<!--  Last name start -->
					
										<div class="Row">
											<div class="ColumnLabel">
												<label for="personal_lname"><font color="#B30000">* </font>Last Name</label>
											</div>
											<div class="Column" style="width:60%">		
				 								<div class="Row">
													<input type="text" id="personal_lname" name="lname" value="<%=lname%>" size="35" maxlength="100" ></input>					 						
												</div>
												<div class="RowSpan">
													<span class="error">A valid Last name is required</span>
												</div>							
											</div>
										</div>
				<!-- Last name end -->
				<!-- Suffix name start -->
				
										<div class="Row">
											 <div class="ColumnLabel">
												<label for="personal_suffix">Suffix</label>
											</div>
											 <div class="Column" style="width:60%">
				 								<div class="Row">
											 
											<select id="personal_suffix" name="suffix"  style="width:60px">
												<option value=""> </option>
												<option value="sr">Sr</option>
												<option value="jr">Jr</option>
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
											</select>
									
											</div>
										<div class="RowSpan">
													<span class="error"></span>
										</div>	
									</div>
							</div>
							
							<div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_mtype1" class="visuallyhidden">mtype</label>  
								
									<label for="personal_mtype"><font color="#B30000">* </font>Identity Verification Options</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">
										<%if(StringUtils.isNotBlank(creditCardFlag) && "YES".equalsIgnoreCase(creditCardFlag)){ %>
										<div class="Column" style="width:24%;vertical-align: middle;">
										<input type="radio" id="personal_card" name="card" value="CARD" <%=cdchecked%>> Credit/Debit Card
										</div>
										<%} %>
										<div class="Column" style="width:20%;vertical-align: middle;">
										<input type="radio" id="personal_mtype1" name="mtype" value="MOBILE"  <%=mchecked%>> Mobile Phone				
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
									<label for="personal_pnumber">
										<font ID="pmandate" color="#B30000">* </font>Phone Number  to verify you today</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">	
										<div class="Column" style="width:35%">
											<input type="text" id="personal_pnumber" name="pnumber"  value="<%=pnumber%>" size="14" maxlength="14" ></input>
										</div>
										<div class="Column" id="DSK_phnMsg" style="width:70%;vertical-align:top;">
											<div id="phnMsg" class="message-box info">
					          	   				<p class="valid">A phone account in your name is used for Identity Validation. If you are unable to validate on the number you enter, please try again with another account in your name, such as a landline. Upcoming enhancements will include the ability for the phone account to be in a family name.</p> 
					          				</div>
				          				</div>
									</div>
									<div class="RowSpan">
										<span class="error">A valid phone number is required</span>
									</div>
									
								</div>
				
							</div>
							<div class="Row" id="MOB_phnMsg">
								<div id="phnMsg" class="message-box info">
		          	   				<p class="valid">Provide a Mobile or Landline Number. This will be used for Identity Validation, and must be in your name. Upcoming enhancements will include the ability for the phone account to be in a family name.</p> 
		          				</div>
				          	</div>
							<div class="Row">
								<div class="ColumnLabel">	
									<label for="personal_mnumber" id="mnumberId">Mobile Number to reset your password in the future</label>
								</div>
								<div class="Column" style="width:60%">
									<div class="Row">	
										<div class="Column" style="width:35%">
											<input type="text" id="personal_mnumber" name="mnumber"  value="<%=mnumber%>" size="14" maxlength="14" ></input>	
										</div>
										<div class="Column" id="DSK_mobMsg" style="width:70%;vertical-align:top;">
											<div id="mobMsg" class="message-box info">
				          	   					 <p class="valid">We recommend you submit your mobile number because you can reset your password with a text message. It can be registered in any name.</p> 
				          					</div>
			          					</div>
									</div>
									
									<div class="RowSpan">
										<span class="error">A valid mobile number is required</span>
									</div>
									
								</div>
				
							</div>
							<div class="Row" id="MOB_mobMsg">
								<div id="mobMsg" class="message-box info">
				          	   		 <p class="valid">We recommend you submit your mobile number because you can reset your password with a text message. It can be registered in any name.</p> 
				          		</div>
				          	</div>
							<div class="Row">
				
								<div class="ColumnLabel">			
									<label for="personal_email"><font color="#B30000">* </font>Email</label>
								</div>
								<div class="Column" style="width:60%">
	 								<div class="Row">
	 									<div class="Column" style="width:50%">
	 		 								<input type="email" id="personal_email" name="email"  value="<%=email%>" size="35" maxlength="100"></input>
										</div>
										<div class="Column" id="DSK_emlMsg" style="width:35%;vertical-align:top;">
											<div id="emlMsg" class="message-box info">
				        						<p class="valid">This will be your username.</p> 
				          					</div>
										</div>					
									</div>
									<div class="RowSpan">
										<span class="error">A valid email address is required. This registration process is intended for non Department of Transportation (DOT) and non Federal Aviation Administration (FAA) employees </span>
									</div>
														
								</div>
								
						</div>
						<div class="Row" id="MOB_emlMsg">
							<div id="emlMsg" class="message-box info">
	        					<p class="valid">This will be your username.</p> 
	          				</div>
				        </div>
						
														
		</div>
		<div class="Row" align="center">
			<BR>
		</div>
        <div id="rcornersdotedImp">
					 <div align="left">
						<div style="float:left;">
							<SPAN style="font-size: 1.5em;color: #1e2e61;"><b>Identity Authentication</b></SPAN>							
							<BR>
							<span style="font-size: 1.1em;color: #0076c0;">
								<b>We use these fields to authenticate your identity.</b>
							</span>
							<div><b><a id="privacy1" href="privacyIdentity.html" style="font-size: 1.0em;">How we protect your Privacy?</a></b></div>
						</div>		
					</div>
					
					<div align="right">						
						<div  style="float:right;"><b><a id="whyneed" href="whyneed.html" style="font-size: 1.0em;">Why do we need this?</a></b></div>  						 				 
                    </div>
                       	 
                    <BR><BR><BR>
				   <!-- ssn name start -->
						<div class="Row">
							 <div class="ColumnLabel">
								<label for="personal_ssn">SSN</label>
								<!-- <label for="personal_txtssn" class="visuallyhidden">txtssn</label> -->
							</div>
								<div class="Column" style="width:60%">
				 					<div class="Row">
					 					<div class="Column" style="width:35%">
					 					<input type="password" id="personal_ssn" name="ssn"    size="11" maxlength="11" ></input>
      									
										</div>
										<div class="Column" id="DSK_ssnMsg" style="width:80%;vertical-align:top;">
											<div id="ssnMsg" class="message-box info">
		          	   					 		<p class="valid">While not required, not providing this information may result in our inability to confirm your identity, thereby preventing you from gaining access to the system. Leave this blank to use an alternate identification method.</p> 
		          							</div>
	          							</div>
									</div>
									<div class="Row">
									
										<div class="Column" style="width:5%">
											<label for="personal_chkshow" class="visuallyhidden">chkshow</label>										
											<input type="checkbox" id="personal_chkshow" />									
										</div>	
										<div align="left">Show</div>
									</div>
									<div class="RowSpan">
										<span class="error">A valid SSN is required</span>
									</div>	

							</div>
						</div>
						<div  id="MOB_ssnMsg" class="Row">
							<div id="ssnMsg" class="message-box info">
     	   						<p class="valid">While not required, not providing this information may result in our inability to confirm your identity, thereby preventing you from gaining access to the system. Leave this blank to use an alternate identification method.</p> 
     						</div>
						</div>		
														 
					<!-- ssn name end -->

						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_DateofBirth"><font color="#B30000">* </font>Date of Birth</label>
							</div>
							<div class="Column" style="width:60%">
									<div class="Column">	
										<div class="Column">	
											<label for="personal_birthmonth" class="visuallyhidden">birthmonth</label>
										
											<input type="text" id="personal_birthmonth" name="birthmonth"  placeholder="MM" value="<%=birthmonth%>" size="2" maxlength="2" ></input>
										</div>
										<div class="RowSpan">
												<span class="error">A valid birth month is required</span>
										</div>	
									</div>
									<div class="Column">	
										<div class="Column">
											<label for="personal_birthday" class="visuallyhidden">birthday</label>										
											<input type="text" id="personal_birthday" name="birthday"  placeholder="DD"  value="<%=birthday%>" size="2" maxlength="2" ></input>
										</div>
										<div class="RowSpan">
												<span class="error">A valid birth day is required</span>
										</div>	
									</div>
									<div class="Column">	
										<div class="Column">
											<label for="personal_birthyear" class="visuallyhidden">birthyear</label>
											<input type="text" id="personal_birthyear" name="birthyear"  placeholder="YYYY" value="<%=birthyear%>" size="4" maxlength="4" ></input>
										</div>
										<div class="RowSpan">
												<span class="error">A valid birth year is required</span>
										</div>	
									</div>
			
							</div>
						</div>
						
						
						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_haddress1"><font color="#B30000">* </font><b>Home</b> Address 1</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					<div class="Column" style="width:50%">
			 						<input type="text" id="personal_haddress1" name="haddress1"  value="<%=haddress1%>" size="35" maxlength="100" ></input>
								</div>
								
								<div class="Column" id="DSK_AddMsg" style="width:50%;vertical-align:top;">
											<div id="ssnMsg" class="message-box info" style="width:200px;margin-left:16px;">
		          	   					 		<p class="valid">Identity Validation will not succeed with your work address ( e.g 1234 First Ave).</p> 
		          							</div>
	          					</div>
	          						
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						 <div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_haddress2"><b>Home</b> Address 2</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 						<input type="text" id="personal_haddress2" name="haddress2"  value="<%=haddress2%>" size="35" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_hcity"><font color="#B30000">* </font><b>Home</b> City</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 						<input type="text" id="personal_hcity" name="hcity"  value="<%=hcity%>" size="35" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid city is required</span>
								</div>				
								</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_hstate"><font color="#B30000">* </font><b>Home</b> State</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
								<select id="personal_hstate" name="hstate"  required>
								<option value="" selected="selected">Select State</option>					
								<option value="AL">Alabama</option>
								<option value="AK">Alaska</option>
								<option value="AS">American Samoa</option>								
								<option value="AZ">Arizona</option>
								<option value="AR">Arkansas</option>
								<option value="CA">California</option>
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="DC">District Of Columbia</option>
								<option value="FM">Federated States of Micronesia</option>								
								<option value="FL">Florida</option>
								<option value="GA">Georgia</option>
								<option value="GU">Guam</option>								
								<option value="HI">Hawaii</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="IN">Indiana</option>
								<option value="IA">Iowa</option>
								<option value="KS">Kansas</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MH">Marshall Islands</option>								
								<option value="MD">Maryland</option>								
								<option value="MA">Massachusetts</option>
								<option value="MI">Michigan</option>
								<option value="MN">Minnesota</option>
								<option value="MS">Mississippi</option>
								<option value="MO">Missouri</option>
								<option value="MT">Montana</option>
								<option value="NE">Nebraska</option>
								<option value="NV">Nevada</option>
								<option value="NH">New Hampshire</option>
								<option value="NJ">New Jersey</option>
								<option value="NM">New Mexico</option>
								<option value="NY">New York</option>
								<option value="NC">North Carolina</option>
								<option value="ND">North Dakota</option>
								<option value="MP">Northern Mariana Islands</option>								
								<option value="OH">Ohio</option>
								<option value="OK">Oklahoma</option>
								<option value="OR">Oregon</option>
								<option value="PW">Palau</option>								
								<option value="PA">Pennsylvania</option>
								<option value="PR">Puerto Rico</option>								
								<option value="RI">Rhode Island</option>
								<option value="SC">South Carolina</option>
								<option value="SD">South Dakota</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="UT">Utah</option>
								<option value="VT">Vermont</option>
								<option value="VA">Virginia</option>
								<option value="VI">Virgin Islands</option>								
								<option value="WA">Washington</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
							</select>
							</div>
								<div class="RowSpan">
									<span class="error">A valid state is required</span>
								</div>
							</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_hzip"><font color="#B30000">* </font><b>Home</b> Zip</label>
							</div>
							<div class="Column" style="width:60%">
			 					<div class="Row">
			 			 			<input type="text" id="personal_hzip" name="hzip"  value="<%=hzip%>" size="5" maxlength="5" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid zip code is required</span>
								</div>
							</div>
			
						</div>

		</div>
		<div class="Row"> <br> </div>
	 
   						
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_g-recaptcha-response"></label>
							</div>
							<div class="Column" style="width:60%">
			 					<div class="Row">
										<div class="g-recaptcha" data-sitekey="6LevJSoTAAAAAE7rrqVx1-rcjUJsnLijUDJ3xRDn" data-callback="correctCaptcha" ></div>
								</div>
								<div class="RowSpan">
									<span class="error">Please verify that you are not a robot.</span>
								</div>
							</div>
						</div>
					    </fieldset>
				    
					</div>

                  <div>
                                    
                                <!-- Submit Button -->
                                <div align="center" id="personal_submit" >					
                                    <button type="button"   class="roundAll">Next ></button>
                                </div>
                  </div>	
                  
	
		</div>
		
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=personInformationForm.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=personInformationForm.getAppname()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	

</form>	
<jsp:include page="./footer.jsp" />		


</body>
</html>
