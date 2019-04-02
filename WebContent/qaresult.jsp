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
   	ScoreInformation score = new ScoreInformation();
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
		    if(paramName.startsWith("transactionID")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	person.setTransactionid(paramValues[0]);
		    	score.setTransactionid(paramValues[0]);
		    }
		    if(paramName.startsWith("appname")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	person.setAppname(paramValues[0]);
		    	score.setAppname(paramValues[0]);
		    }
		    if(paramName.startsWith("referencecode")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	score.setReferencecode(paramValues[0]);
		    }
		    if(paramName.startsWith("quiz_Id")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	score.setQuizId(paramValues[0]);
		    }
		    if(paramName.startsWith("quiz_qaId_")){
		    	String qid = paramName.substring(12);
			    String[] paramValues = request.getParameterValues(paramName);
		 		questionIds[i] = qid;
		  		choiceIds[i] = paramValues[0];
		  		i++;
		    }
		}
		score.setQuestionId(questionIds);
		score.setChoiceId(choiceIds);
		out.println(scoreRequest(score, lexisNexisSericeEndPoint,person));		
		request.getSession().setAttribute("personalinformation", person);
  %>
   <%!
 
 	  public String scoreRequest(ScoreInformation score, String endPoint, PersonInformation person) throws Exception { 
	  
		 score.setWorkFlow("FAA_B2B_AUTH_FLOW");
		 LexisNexisService service = new  LexisNexisServiceImpl();	  
		 IdentityProofingResponse lnresponse = service.scoreRequest(score, endPoint, person);		  
		 String status = lnresponse.getStatus();
		 if("PASS".equalsIgnoreCase(status)){
				return "PASS";	
		 }else{
				return "Failed";
		 }
		  
	  }
  %>