<!DOCTYPE html>
<%@ page import="org.owasp.esapi.ESAPI"%>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="java.util.Properties"%>
<%@ page import = "org.apache.commons.lang.StringUtils" %>

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
	
	<style>

	#myProgress {
	  position: relative;
	  width: 100%;
	  height: 30px;
	  background-color: #ddd;
	}
	
	#myBar {
	  position: absolute;
	  width: 25%;
	  height: 100%;
	  background-color: #4CAF50;
	}
	
	#label {
	  text-align: center;
	  line-height: 30px;
	  color: white;
	}
	
	.iframeholder {
  		background:url(assets/images/progress.gif) center center no-repeat;
 	}

</style>
</head>
<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		PersonInformation person = (PersonInformation)request.getSession().getAttribute("personalinformation");
		if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
  			throw new Exception("Invalid Access");
  		}
  		String ssnDLChkFlag =(String) request.getSession().getAttribute("SSN_DL_VALIDATION");
		if(ssnDLChkFlag==null || (ssnDLChkFlag!=null && "FAIL".equals(ssnDLChkFlag))){
			throw new Exception("Invalid Access");
		}
		
		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String vitalcheckInitialService=resource.getString("VitalCheckCreditCardServiceInitial");
  		String vitalcheckFinalService=resource.getString("VitalCheckCreditCardServiceFinal");
  		String initialValidationAmt=resource.getString("InitValidationAmount");
		String lexisNexisCode=resource.getString("LexisNexisCode");
		String lexisNexisProductCode=resource.getString("LexisNexisProductCode");
		
		String resultStatus = request.getParameter("RESULT");
		String atmptsExceedFlg = request.getParameter("ATTEMPTS_EXCEEDED");
		if(StringUtils.isNotBlank(resultStatus) && "SUCCESS".equalsIgnoreCase(resultStatus)){
			request.getSession().setAttribute("CC_VALIDATION", "PASS");
			response.sendRedirect("lexisnexisssnvalidation.jsp");			
		}else if(StringUtils.isNotBlank(resultStatus)
				&& "ERROR".equalsIgnoreCase(resultStatus)
				&& StringUtils.isNotBlank(atmptsExceedFlg)
				&& "TRUE".equalsIgnoreCase(atmptsExceedFlg)
				){
				response.sendRedirect("phoneFinalvalidationerror.jsp?vError=CRDERR");
		}		
 %>

<script>
	var validTextRegex = {
	  withSpace: {
	    us:  /^[a-zA-Z0-9-]*$/,
	  },
	  address: {
	    us:  /^[a-zA-Z0-9 ,.#-]*$/,
	  },
	  cityState: {
	    us:  /^[a-zA-Z0-9 ,.-]*$/,
	  }
	};

	var xmlData = "<?xml version=\"1.0\" encoding=\"utf-8\"?><embeddedPaymentRequest><acceptChecks>false</acceptChecks><lexisNexisCode></lexisNexisCode><handlerUrl></handlerUrl><token></token><clientValidationUrl></clientValidationUrl><paymentLineItems><productLines><productAmount>0.00</productAmount><lexisNexisProductCode></lexisNexisProductCode><refField></refField><refField1></refField1><refField2/><refField3/><refField4/><refField5/></productLines></paymentLineItems><orientation>Landscape</orientation><customerInformation><addressLine1></addressLine1><addressLine2></addressLine2><city></city><email></email><firstName></firstName><lastName></lastName><phone></phone><state></state><zip></zip></customerInformation><showAddress>false</showAddress><validateionErrorMessage>this is validation error message</validateionErrorMessage></embeddedPaymentRequest>";
	var clientToken= "MyAccess12345";
	var finalXmlData= "";
	$(document).ready(function() {
		ccXmlObj = jQuery.parseXML( xmlData );
		$(ccXmlObj).find("productAmount").text("<%=initialValidationAmt%>");		
		$(ccXmlObj).find("lexisNexisCode").text("<%=lexisNexisCode%>");
		$(ccXmlObj).find("lexisNexisProductCode").text("<%=lexisNexisProductCode%>");		
		$(ccXmlObj).find("handlerUrl").text("${pageContext.request.requestURL}");
		$(ccXmlObj).find("token").text(clientToken);
		$(ccXmlObj).find("addressLine1").text("<%=person.getAddressLine1()%>");
		$(ccXmlObj).find("addressLine2").text("<%=person.getAddressLine2()%>");
		$(ccXmlObj).find("city").text("<%=person.getCity()%>");
		$(ccXmlObj).find("email").text("<%=person.getEmail()%>");
		$(ccXmlObj).find("firstName").text("<%=person.getFirstName()%>");
		$(ccXmlObj).find("lastName").text("<%=person.getLastName()%>");
		$(ccXmlObj).find("phone").text("<%=person.getPnumber().replaceAll("-","").replaceAll("\\(","").replaceAll("\\)","").replaceAll(" ","")%>");
		$(ccXmlObj).find("state").text("<%=person.getStateCode()%>");
		$(ccXmlObj).find("zip").text("<%=person.getZip5()%>");

		finalXmlData = xmlToString(ccXmlObj);
		
		$("#ORDER_XML").val(finalXmlData);
		//console.log(""+$("#ORDER_XML").val());		
		$.post("<%=vitalcheckInitialService%>", {ORDER_XML: $("#ORDER_XML").val()}, function(data) {
    		var responseStr = $.trim(data);
    		//console.log("VitalChk Response: "+responseStr);
    		var ltoken = getParamValue(responseStr, "LEXISNEXIS_TRANSACTION_TOKEN");
    		var ctoken = getParamValue(responseStr, "CUSTOMER_TRANSACTION_TOKEN");
    		var cc="us";
   			var re = validTextRegex.withSpace[cc];
		    if(ltoken.length > 0 &&  ctoken.length > 0 && re.test(ltoken) &&  re.test(ctoken)){
			    $("#LEXISNEXIS_TRANSACTION_TOKEN").val(ltoken);
	    		$("#CUSTOMER_TRANSACTION_TOKEN").val(ctoken);
		    }
    	    		
    		$("#FORM_2").attr("action", "<%=vitalcheckFinalService%>");
    		$("#FORM_2").submit();   //final submit to Vital check
    		
    		//$.post("https://demo.payments.lexisnexis.com/embeddedPay/confirm/", {LEXISNEXIS_TRANSACTION_TOKEN: ltoken,CUSTOMER_TRANSACTION_TOKEN:ctoken }, function(data) {
    			//$(".myIframe").attr("src",data);
    		//});
    		//$(".myIframe").attr("src", "https://demo.payments.lexisnexis.com/embeddedPay/confirm/"+{LEXISNEXIS_TRANSACTION_TOKEN: ltoken,CUSTOMER_TRANSACTION_TOKEN:ctoken });
    	});    	
    	
	});

	function getParamValue(responseString, paramName){
		var paramArray = responseString.split("&");
		for(i=0;i<paramArray.length;i++){
			var paramNameVal = paramArray[i];
			if($.trim(paramNameVal).length>0){
				var nameVal = paramNameVal.split("=");
				if(paramName ==$.trim(nameVal[0])){
					return $.trim(nameVal[1]);
				}			
			}else{
				return "";
			}
		}
	}
	
	function xmlToString(xmlData) { 
	    var xmlString;
    	//IE
    	if (window.ActiveXObject){
        	xmlString = xmlData.xml;
        	xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+xmlString;
    	}
    	// code for Mozilla, Firefox, Opera, etc.
    	else{
    	    xmlString = (new XMLSerializer()).serializeToString(xmlData);
    	}
    	return xmlString;
	}   
	
</script>
<body>
<div id="htmlconverter" style="display: none;"></div>
<jsp:include page="header.jsp" />	
	<div id="body">
		<div id="myProgress">
			  <div id="myBar">
			    <div id="label">25%</div>
			  </div>
		</div>
		<BR>
		 <p align="left">In order to validate your identity, please enter your Credit or Debit card details and click 'Pay Now' button.</p>
		 <div class="message-box info">
		 	<p align="left">We only use your Credit or Debit Card information to verify your identity. When you click the 'Pay Now' button, we do not charge your Credit or Debit card. Nothing will appear on your bill.</p>
		 </div>   
	 	<div id="rcorners2">
			<form ID="FORM_1" name="FORM_1" method="post" target="_blank" style="display: none;">
				<input type="text" id="ORDER_XML" name="orderXml" value="" style="display: none;">				
				<input type="submit" value="Send it" style="display: none;">
			</form>
			<fieldset>			
				<form ID="FORM_2" name="FORM_2" method="post" target="LNV_Iframe" style="display: none;">
					<input type="text" ID="LEXISNEXIS_TRANSACTION_TOKEN" name="LEXISNEXIS_TRANSACTION_TOKEN" value="" size=45  style="display: none;"><br/>
					<input type="text" ID="CUSTOMER_TRANSACTION_TOKEN" name="CUSTOMER_TRANSACTION_TOKEN"  value="" size=45  style="display: none;"><br/>
					<input type="submit" value="Confirm it"  style="display: none;">
				</form>
			</fieldset>
			<div align="center" class="iframeholder">
				<iframe name="LNV_Iframe" ID="LNV_Iframe" name="navigation" target="_parent" style="width:800px;height:480px">
					Credit or Debit Card Validation page could not be loaded! Please contact your Help Desk.
				</iframe>
			</div>
		</div>
	</div>
	<jsp:include page="./footer.jsp" />
</body>
</html>
