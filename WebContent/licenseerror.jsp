<!DOCTYPE html>
<html lang="en">
<%@ page import="com.lexisnexis.model.PersonInformation"%>

<head>
	<script>(function(H){H.className=H.className.replace(/\bnoJS\b/,'js');})(document.documentElement);</script>
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register for MyAccess | U.S. Department of Transportation</title>
	
	<link rel="stylesheet" href="assets/css/master.min.css">
	<link rel="stylesheet" href="assets/css/externalreg.css">		
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<!-- reCAPTCHA Libary -->
	<script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
</head>

<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
		//request.getSession().invalidate();
 %>

<body>
<div id="htmlconverter" style="display: none;"></div>
	<div id="body">
	<jsp:include page="header.jsp" />	
	<div align="center">

	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2">
						<img src="assets/images/unsuccess.jpg" height="50" width="50" alt="Success Logo"> 
						<p>We were unable to complete your online identity validation.</p>
				</div>
				
		
	
	
	</div>
	</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

