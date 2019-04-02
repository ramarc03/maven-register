<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
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
<style>

</style>

<script>
	var validTextRegex = {
	  noSpace: {
	    us:  /^[a-zA-Z0-9]*$/,
	  }
	};
	function uuidv4() {
  		return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    	var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    	return v.toString(16);
  		});
	}
	$(document).ready(function() {
 		focusTonext();
		headPage();
		licensePage();
	});
	
</script>

<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
 %>

<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">
		
		<div id="myProgress">
		  <div id="myBar">
		    <div id="label">20%</div>
		  </div>
		</div>
 		<div id="response" class="Row" style="display:none;">
           	<div class="message-box failure" >
           			 <div id="messageid">
           			 </div>
           	</div>
        </div>   
            <div id="personal_nossn" class="Row" style="display:block;">
            	<div class="message-box failure" >
            	         <p>Please enter your driver's license number below. This Information will not be saved or stored.</p> 
            	</div> 

            </div>
            <div id="personal_nostate" class="Row" style="display:none;">
            	<div class="message-box info" >
            	         <p>If your state is not listed under "My State" please edit your personal information and try using your Social Security Number..</p> 
            	</div>
            </div>
            
            <p>If your Driver's License issued state is not listed in the "Issued State" list, please select the "My state is not listed" checkbox
            and click "Next" to edit your personal information and try again using your SSN.</p><BR>
            <div><b><a id="statesList" href="statesList.html" style="font-size: 1.0em;">List of states</a></b> currently supported for Driver's License validation.</div>
            <BR>
<div   id="rcorners2">
				
				      <fieldset>

						
						<div class="Row">
							 <div class="ColumnLabel">
								<label for="personal_license"><font color="red">* </font>Driver's License Number</label>
							</div>
							<div class="Column" style="width:55%">
				 					<div class="Row">			 					
										<input type="text" id="personal_license" name="license" value="" size="11" maxlength="15" autofocus></input>
									</div>
									<div class="RowSpan">
											<span class="error">A valid Driver's Licence number is required</span>
									</div>			
							</div>
						</div>
						 <div class="Row">
							<div class="ColumnLabel">
								<label for="personal_licensestate"><font color="red">* </font>Issued State</label>
							</div>
							<div class="Column" style="width:55%">
			 				  <div class="Row">
								<select id="personal_licensestate" name="licensestate" required>
								<option value="" selected="selected">Select State</option>					
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="FL">Florida</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MA">Massachusetts</option>
								<option value="MI">Michigan</option>
								<option value="MN">Minnesota</option>
								<option value="MS">Mississippi</option>
								<option value="MO">Missouri</option>
								<option value="NE">Nebraska</option>
								<option value="NV">Nevada</option>
								<option value="NH">New Hampshire</option>
								<option value="NM">New Mexico</option>
								<option value="NC">North Carolina</option>
								<option value="ND">North Dakota</option>
								<option value="OH">Ohio</option>
								<option value="SC">South Carolina</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
								</select>
							</div>
							<div class="RowSpan">
									<span class="error">Issued State is required</span>
							</div>
						</div>
					</div>
							
					<div class="Row">
							 <div class="ColumnLabel">
								<label for="personal_checkbox"></label>
							</div>
								<div class="Column" style="width:55%">
									<div class="Row">
										<div class="Column" style="width:5%">
											<input type="checkbox" id="personal_chkShow"/>
										</div>
										<div align="left">
											My state is not listed 
										</div>												
									</div>
							</div>
					</div>
			
	
					    </fieldset>
					  
				<div class="Row">
				<br>
				</div>			  
					  
				    
					</div>

<div>
<input type="hidden" id="personal_fname" name="fname" value="<%=personInformationForm.getFname()%>" ></input>								
<input type="hidden" id="personal_mname" name="mname" value="<%=personInformationForm.getMname()%>"></input>
<input type="hidden" id="personal_lname" name="lname" value="<%=personInformationForm.getLname()%>"></input>
<input type="hidden" id="personal_suffix" name="suffix"  value="<%=personInformationForm.getSuffix()%>" ></input>
<input type="hidden" id="personal_mtype" name="mtype" value="<%=personInformationForm.getMtype()%>" ></input>
<input type="hidden" id="personal_pnumber" name="pnumber" value="<%=personInformationForm.getPnumber()%>" ></input>
<input type="hidden" id="personal_mnumber" name="mnumber" value="<%=personInformationForm.getMnumber()%>" ></input>
<input type="hidden" id="personal_email" name="email" value="<%=personInformationForm.getEmail()%>"></input>
<input type="hidden" id="personal_birthmonth" name="birthmonth" value="<%=personInformationForm.getBirthmonth()%>" ></input>
<input type="hidden" id="personal_birthday" name="birthday" value="<%=personInformationForm.getBirthday()%>" ></input>	
<input type="hidden" id="personal_birthyear" name="birthyear" value="<%=personInformationForm.getBirthyear()%>" ></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=personInformationForm.getHaddress1()%>" ></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=personInformationForm.getHaddress2()%>" ></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=personInformationForm.getHcity()%>"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=personInformationForm.getHstate()%>"></input>	
<input type="hidden" id="personal_hzip" name="hzip" value="<%=personInformationForm.getHzip()%>"></input>
<input type="hidden" id="personal_phonetype" name="phonetype" value="<%=personInformationForm.getPhonetype()%>"></input>	
<input type="hidden" id="personal_lexid" name="lexid" value="<%=personInformationForm.getLexid()%>" ></input>	
<input type="hidden" id="personal_appname" name="appname" value="<%=personInformationForm.getAppname()%>" ></input>	
<input type="hidden" id="personal_transactionid" name="transactionid" value="<%=personInformationForm.getTransactionid()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	
</div>
	                  <div align="center">
                               <!-- Submit Button -->
                               <div  class="Column" align="center" id="personal_edit" style="padding-right: 10px;">					
                                   <button type="button" class="roundAll">< Edit&nbsp</button>
                               </div>
                               <div  class="Column" align="center" id="personal_continue" style="padding-left: 10px;" >					
                                   <button type="button" class="roundAll">Next ></button>
                               </div>
                 		</div>		
		</form>

		</div>	
				<jsp:include page="./footer.jsp" />		


</body>
</html>
