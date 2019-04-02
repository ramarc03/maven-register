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
	<link rel="shortcut icon" href="favicon.ico">  
	<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>	
	<!-- reCAPTCHA Libary -->
	<script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
</head>
<%session.invalidate(); %>
	<!-- Styles -->
	<style>
		input.invalid, textarea.invalid{
			border: 2px solid red;
		}

		.error{
			display: none;
			height:20px;
			//color: red;
			margin-right : 10px;
		}		
		
		.error_show{
			height:20px;		
			color: red;
			margin-right : 10px;
		}
		
		.Row
		{
		    display: table;
		    width: 90%; /*Optional*/
		    table-layout: fixed; /*Optional*/
		    border-spacing: 1px; /*Optional*/
		}
		.RowPhone
		{
		    display: table;
		    width: 90%; /*Optional*/
		    table-layout: fixed; /*Optional*/
		}
		.RowSpan
		{
		   display: table;
		   height:20px;
		}
		.RowEmpty
		{
		    display: table;
		    padding:5px;
		    table-layout: fixed; /*Optional*/
		    border-spacing: 1px; /*Optional*/
		}
		.ColumnLabel
		{
		    display: table-cell;
		    float: left;
		}
		.Column
		{
		    display: table-cell;
		}
		.ColumnEmpty
		{
		    display: table-cell;
		    height:120px;
		   //background-color: red; /*Optional*/
		}
		
		#rcorners2 {
		    border-radius: 25px;
		    border: 2px solid #95B9C7;
		    padding-left: 1px;
		    padding-right: 20px;
		    padding-top: 10px;
		    padding-bottom: 20px;
		}
		#rcornersdoted {
		    border-radius: 25px;
		    border: 2px dotted  #95B9C7;
		    padding-left: 1px;
		    padding-right: 1px;
		    padding-top: 15px;
		    padding-bottom: 15px;
		}
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
		div.fixed {
		    position: absolute;
		    resize: none;
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

	</style>

<body>
<div id="htmlconverter" style="display: none;"></div>
	<jsp:include page="header.jsp" />	
	<div align="center">

	
				<!-- start  fieldset -->
				<div class="Row"  id="rcorners2">
						<img src="assets/images/unsuccess.jpg" height="50" width="50" alt="Success Logo">
						<p>We were unable to validate the online identity validation.</p>
				</div>
				
		
	
	
	</div>
				<jsp:include page="./footer.jsp" />		


</body>
</html>

