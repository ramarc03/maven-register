<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,"js");})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	<link rel="stylesheet" href="assets/css/externalreg.css">
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.css"> 	
	<link rel="shortcut icon" href="favicon.ico">
	<script src="assets/js/registerApp.js"></script>
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<script src="assets/js/external.js"></script>
	</head>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<style>
</style>

<script>

	$(document).ready(function() {
	 		focusTonext();
			headPage();
			companyPage();
		
	});
	
</script>

<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
		String mnumber = "";
		if(personInformationForm.getMnumber()!=null){
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("(");
			buffer.append(personInformationForm.getMnumber().replace(" ",") "));
			mnumber = buffer.toString();
		}
		String pnumber = "";
		if(personInformationForm.getPnumber()!=null){
			
			StringBuffer buffer = new StringBuffer();
			buffer.append("(");
			buffer.append(personInformationForm.getPnumber().replace(" ",") "));
			pnumber = buffer.toString();
		}
 %>


<body>




<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div id="body">    
    	<form id="personal" NAME="personalinformation" method="post" autocomplete="off">

			
		<div id="myProgress">
		  <div id="myBar">
		    <div id="mylabel">80%</div>
		  </div>
		</div>
    
            <div class="Row">
            <p align="left">This information is optional if you do not want to provide, click Next to proceed, without entering Company information.</p>
            </div>
<div   id="rcorners2">
						<DIV align="left"> <B><a id="privacy3" href="privacy.html" style="font-size: 1.0em;">How we protect your Privacy?</a></B> </DIV>
								<div class="Row" align="center">
							         <!--   h1>My Information</h1 -->
							         </div>
				
				      <fieldset>
									<div class="Row">
										 <div class="ColumnLabel">
											<label for="personal_cname">Company Name</label>
										</div>
										 <div class="Column" style="width:60%">
			 								<div class="Row">
			 						
												<input type="text" id="personal_cname" name="cname" value="" size="40" maxlength="200" autofocus></input>
																			
											</div>
											<div class="RowSpan">
												<span class="error">A valid Company name is required</span>
											</div>							
									</div>
									</div>
									<div class="Row">
										<div class="ColumnLabel">
											<label for="personal_title">Title</label>
										</div>
										<div class="Column" style="width:60%">		
			 								<div class="Row">
			 								
												<input type="text" id="personal_title" name="title" value="" size="40" maxlength="100" ></input>
											
											</div>
											<div class="RowSpan">
												<span class="error">A valid Title is required</span>
											</div>							
										</div>
									</div>

                     	<div class="Row">
							<div class="ColumnLabel">	
								<label for="personal_cfax">Fax</label>
							</div>
							<div class="Column" style="width:60%">
								<div class="Row">	
								
								<input type="text" id="personal_cfax" name="cfax" value="" size="14" maxlength="14" ></input>
							
								</div>
								<div class="RowSpan">
												<span class="error">A valid fax number is required</span>
								</div>
							</div>
			
						</div>	 
   						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_caddress1">Street Address 1</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					
								<input type="text" id="personal_caddress1" name="caddress1" value="" size="40" maxlength="100" ></input>
								
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						 <div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_caddress2">Street Address 2</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 					
			 					<input type="text" id="personal_caddress2" name="caddress2" value="" size="40" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid street address is required</span>
								</div>
							</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel" >
								<label for="personal_ccity">City</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
			 		 			
								<input type="text" id="personal_ccity" name="ccity" value="" size="40" maxlength="100" ></input>
								</div>
								<div class="RowSpan">
									<span class="error">A valid city is required</span>
								</div>				
								</div>
			
						</div>
						<div class="Row">
							<div class="ColumnLabel">
								<label for="personal_cstate">State</label>
							</div>
								<div class="Column" style="width:60%">
			 					<div class="Row">
								<select id="personal_cstate" name="cstate" >
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
								<label for="personal_czip">Zip</label>
							</div>
							<div class="Column" style="width:60%">
			 					<div class="Row">
			 			 		 
								<input type="text" id="personal_czip" name="czip" value="" size="5" maxlength="5" ></input>
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

                  <div>
                                    
                                <!-- Submit Button -->
                                <div align="center" id="personal_submit" >					
                                    <button type="button" class="roundAll">Next ></button>
                                </div>
                  </div>	

<input type="hidden" id="personal_fname" name="fname" value="<%=personInformationForm.getFname()%>" ></input>								
<input type="hidden" id="personal_mname" name="mname" value="<%=personInformationForm.getMname()%>"></input>
<input type="hidden" id="personal_lname" name="lname" value="<%=personInformationForm.getLname()%>"></input>
<input type="hidden" id="personal_suffix" name="suffix"  value="<%=personInformationForm.getSuffix()%>" ></input>
<input type="hidden" id="personal_pnumber" name="pnumber" value="<%=personInformationForm.getPnumber()%>" ></input>
<input type="hidden" id="personal_mnumber" name="mnumber" value="<%=personInformationForm.getMnumber()%>" ></input>
<input type="hidden" id="personal_email" name="email" value="<%=personInformationForm.getEmail()%>"></input>
<input type="hidden" id="personal_haddress1" name="haddress1" value="<%=personInformationForm.getHaddress1()%>" ></input>
<input type="hidden" id="personal_haddress2" name="haddress2" value="<%=personInformationForm.getHaddress2()%>" ></input>
<input type="hidden" id="personal_hcity" name="hcity" value="<%=personInformationForm.getHcity()%>"></input>
<input type="hidden" id="personal_hstate" name="hstate" value="<%=personInformationForm.getHstate()%>"></input>	
<input type="hidden" id="personal_hzip" name="hzip" value="<%=personInformationForm.getHzip()%>"></input>
<input type="hidden" id="personal_lexid" name="lexid" value="<%=personInformationForm.getLexid()%>" ></input>	
<input type="hidden" id="personal_referencecode" name="referencecode" value="<%=personInformationForm.getReferencecode()%>" ></input>	
	


		</form>

		</div>	
				<jsp:include page="./footer.jsp" />		


</body>
</html>

