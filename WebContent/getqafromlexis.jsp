<%@ page import="java.util.Enumeration"%>
<%@ page import="java.lang.StringBuilder"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.lexisnexis.model.ScoreInformation"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
 <% 
 	ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  	String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  	PersonInformation person = new PersonInformation();
   	StringBuilder finalString = new StringBuilder();
	String[] questionIds = new String[4];
	String[] choiceIds = new String[4];
	int i = 0;
		Enumeration<String> parameterNames = request.getParameterNames();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			if(paramName.startsWith("fname")){
				person.setFirstName(request.getParameter("fname"));			
			}
			if(paramName.startsWith("mname")){
				person.setMiddleName(request.getParameter("mname"));
			}
			if(paramName.startsWith("lname")){ 
				person.setLastName(request.getParameter("lname"));	
			}
			if(paramName.startsWith("suffix")){ 
				person.setSuffixName(request.getParameter("suffix"));
			}
			if(paramName.startsWith("pnumber")){
				person.setPnumber(request.getParameter("pnumber"));
			}
			if(paramName.startsWith("mnumber")){
				person.setMnumber(request.getParameter("mnumber"));
			}
			if(paramName.startsWith("email")){ 
				person.setEmail(request.getParameter("email"));
			}
			if(paramName.startsWith("ssn")){ 
				person.setSsn(request.getParameter("ssn"));
			}
			if(paramName.startsWith("birthmonth")){ 
				person.setDateOfBirthMonth(request.getParameter("birthmonth"));
			}
			if(paramName.startsWith("birthday")){ 
				person.setDateOfBirthDay(request.getParameter("birthday"));
			}
			if(paramName.startsWith("birthyear")){ 
				person.setDateOfBirthYear(request.getParameter("birthyear"));
			}
			if(paramName.startsWith("haddress1")){ 
				person.setAddressLine1(request.getParameter("haddress1"));
			}
			if(paramName.startsWith("haddress2")){ 
				person.setAddressLine2(request.getParameter("haddress2"));
			}
			if(paramName.startsWith("hcity")){ 
				person.setCity(request.getParameter("hcity"));
			}
			if(paramName.startsWith("hstate")){ 
				person.setStateCode(request.getParameter("hstate"));
			}
			if(paramName.startsWith("hzip")){ 
				person.setZip5(request.getParameter("hzip"));
			}

		    if(paramName.startsWith("appname")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	person.setAppname(paramValues[0]);
		    	StringBuilder transactionid = new StringBuilder();
				transactionid.append(java.util.UUID.randomUUID());
				transactionid.append(":");
				transactionid.append(paramValues[0]);
		    	person.setTransactionid(transactionid.toString());
		    }
		    if(paramName.startsWith("referencecode")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	person.setReferencecode(paramValues[0]);
		    }
		}
		LexisNexisService service = new LexisNexisServiceImpl();
		String result = service.getOutPutHtml(person, lexisNexisSericeEndPoint);
		out.println("<div id='resultfromlexis'>");
		out.println(result);
		out.println("</div>");	

  %>
  