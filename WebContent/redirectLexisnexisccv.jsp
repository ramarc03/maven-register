<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import = "java.util.ResourceBundle" %>
<%

		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
		
		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
		String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
		
		String ccn = ESAPI.validator().getValidInput("ccn",request.getParameter("ccn"), "Zip", 5 ,true );
		String cccount = ESAPI.validator().getValidInput("cccount",request.getParameter("cccount"), "SafeNumeric", 11 ,true );
		
		PersonInformation person = (PersonInformation)request.getSession().getAttribute("personalinformation");
		person.setAccountNumber(ccn);
		request.getSession().setAttribute("personalinformation", person);		
		int cccountInt = Integer.parseInt(cccount);	
		cccountInt++;
		cccount = String.valueOf(cccountInt);

		if(person.getSsn()!=null && person.getSsn().trim().length()>0 ){
			response.sendRedirect("lexisnexisssnvalidation.jsp?cccount="+ cccount);
		}else{
			response.sendRedirect("lexisnexisdlnvalidation.jsp?cccount="+ cccount);
		}
 %>
 
 <%!
 
 			public boolean validateCCAV(PersonInformation person, String endPoint) throws Exception { 
			  
				person.setWorkFlow("FAA_B2B_CCAV_VERIF");
				LexisNexisService service = new LexisNexisServiceImpl();
				
				String status = service.ccavRequest(person, endPoint); 
				
				if("PASS".equalsIgnoreCase(status)){
					return true;
				}else{
					return false;
				} 
			}
  %>


