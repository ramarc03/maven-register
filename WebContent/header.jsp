<%@page import="com.register.formbeans.PersonInformationForm"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<div id="header">
		<a class="logo" id="departmentid" href="http://www.dot.gov/" title="United States Department of Transportation Home" alt="United States Department of Transportation Home" >U.S. Department of Transportation</a>
		<span class="myAccess" id="accessid" title="myAccess" alt="myAccess"><b>My</b>Access</span>
		<span id="whatIsspan"><a id="whatIs" href="whatIs.html" >What is MyAccess?</a></span>
	</div> <!-- /header -->
	<!-- Added to handle Cross-Frame Scripting - starts -->
	<script> 

	$("a").focusin(function(){
        	if($(this).attr("id")=="departmentid"){
 				$("#departmentid").css('outline-color', 'Gray');
  				$('#departmentid').css('outline-style', 'dotted');
	 			$('#departmentid').css('outline-width', 'thin');
	 		}else if($(this).attr("id")=="whatIs"){	 
	 			$('#whatIs').css('outline-color', 'Gray');
  				$('#whatIs').css('outline-style', 'dotted');
	 			$('#whatIs').css('outline-width', 'thin');
	 		}else if($(this).attr("id")=="privacy2"){
	 			 			alert($(this).attr("id"));
	 		
 				$("#firstRowBox").css('outline-color', 'Gray');
  				$('#firstRowBox').css('outline-style', 'dotted');
	 			$('#firstRowBox').css('outline-width', 'thin');
	 		}else if($(this).attr("id")=="whyneed"){	 
	 			alert($(this).attr("id"));
	 			$('#whyneed').css('outline-color', 'Gray');
  				$('#whyneed').css('outline-style', 'dotted');
	 			$('#whyneed').css('outline-width', 'thin');
	 		}
    });
    $("a").focusout(function(){
        	if($(this).attr("id")=="departmentid"){
 				$('#departmentid').css('outline-color', '');
  				$('#departmentid').css('outline-style', '');
	 			$('#departmentid').css('outline-width', '');
	 		}else if($(this).attr("id")=="whatIs"){	
	 			$('#whatIs').css('outline-color', '');
  				$('#whatIs').css('outline-style', '');
	 			$('#whatIs').css('outline-width', '');
	 		}else if($(this).attr("id")=="privacy2"){
	 			 			alert($(this).attr("id"));
	 		
 				$('#firstRowBox').css('outline-color', '');
  				$('#firstRowBox').css('outline-style', '');
	 			$('#firstRowBox').css('outline-width', '');
	 		}else if($(this).attr("id")=="whyneed"){	
	 			 alert("out : "+ $(this).attr("id"));	 		
 		 		$('#whyneed').css('outline-color', '');
  				$('#whyneed').css('outline-style', '');
	 			$('#whyneed').css('outline-width', '');
	 		}
    });
	   
		if (top.location!= self.location) {
   			top.location = self.location.href;
		}
		
		(function(window) {
		  if (window.location !== window.top.location) {
		    window.top.location = window.location;
		  }
		})(this);
		
		this.top.location !== this.location && (this.top.location = this.location);  
	</script>
	<!-- Added to handle Cross-Frame Scripting - ends -->
	
	<%--Display Generic Process Error. Populated at XSS Filter--%>
	<%if(request.getSession().getAttribute("ERROR_CODE")!=null){
		String errorCode = (String)request.getSession().getAttribute("ERROR_CODE");		 
		if(StringUtils.isNotBlank(errorCode)){
			request.getSession().setAttribute("ERROR_CODE", null);//Removing from SESSION on Landing page
			if("PROCESSERROR".equalsIgnoreCase(errorCode)){
			 %>
			    <div style="padding: 10px 25px 5px;">
				<div class="message-box failure" >
			    	<p>Process Error. Please try again. This may be because of the following reasons:
						<ul>
						<li>You have used Back/Forward/Refresh button of your Browser.</li>
						<li>Multiple clicks on an option or button.</li>
						<li>Long inactive period.</li>
						</ul>
					</p>
			    </div>
			    </div>
		    <%}   
	    }
	}%>
	    
	<%--Display Personal Information page errors--%>
    <%      
   	  PersonInformationForm personInformationForm = (PersonInformationForm)request.getSession().getAttribute("personInformationForm");
	  if(personInformationForm!=null){
		  request.getSession().setAttribute("personInformationForm", null);//Removing from SESSION on Landing page
		  HashMap<String, String> errors =personInformationForm.getErrors();
	   		if(errors!=null && errors.size()>0){%>
 			<div style="padding: 10px 25px 5px;">
			<div class="message-box failure" >
		    	<%for(String eacherror: errors.values()){%>
		    		<p><%=eacherror%></p>
		    	<%} %>
		    </div>
		    </div>
	   	<%}
	  }
    %> 