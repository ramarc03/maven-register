<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.lexisnexis.model.ScoreInformation"%>
<%@ page import = "java.util.ResourceBundle" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import="com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%

		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma","no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server
 
		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  		String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  		
  		String fname = request.getParameter("fname");								
		String mname = request.getParameter("mname");
		String lname = request.getParameter("lname");
		String suffix = request.getParameter("suffix");
		String pnumber = request.getParameter("pnumber");
		String mnumber = request.getParameter("mnumber");
		String email = request.getParameter("email");
		String ssn = request.getParameter("ssn");
		String birthmonth = request.getParameter("birthmonth");
		String birthday = request.getParameter("birthday");
		String birthyear = request.getParameter("birthyear");
		String haddress1 = request.getParameter("haddress1");
		String haddress2 = request.getParameter("haddress2");
		String hcity = request.getParameter("hcity");
		String hstate = request.getParameter("hstate");	
		String hzip = request.getParameter("hzip");
		String ccn = request.getParameter("ccn");
		String mtype = request.getParameter("mtype");
		String lexid = request.getParameter("lexid");
		String transactionid = request.getParameter("transactionid");
		String appname = request.getParameter("appname");
  		
  		PersonInformation personal = new PersonInformation();
  		
  		personal.setFirstName(fname);
		personal.setLastName(lname);
		personal.setMiddleName(mname);
		personal.setSuffixName(suffix);
		personal.setEmail(email);
		personal.setLexID(lexid);
		personal.setMnumber(mnumber);
		personal.setPnumber(pnumber);
		personal.setPhoneType(mtype);   
		personal.setDateOfBirthDay(birthday);
		personal.setDateOfBirthMonth(birthmonth);
		personal.setDateOfBirthYear(birthyear);
		personal.setAddressLine1(haddress1);
		personal.setAddressLine2(haddress2);
		personal.setCity(hcity);
		personal.setStateCode(hstate);
		personal.setZip5(hzip);
		personal.setSsn(ssn);
		personal.setAccountNumber(ccn);
		personal.setTransactionid(transactionid);
		personal.setAppname(appname);	
		personal.setOtpcheckcount("0");	
				  		
		if(personal == null || (personal != null && StringUtils.isBlank(personal.getFirstName()))){
	 		throw new Exception("Invalid Access");
	 	}
	 	
		ScoreInformation score = new ScoreInformation();
		String[] questionIds = new String[4];
		String[] choiceIds = new String[4];
		int i = 0;
		Enumeration<String> parameterNames = request.getParameterNames();
		while (parameterNames.hasMoreElements()) {
		    String paramName = parameterNames.nextElement();
		    
		   if(paramName.startsWith("transactionID")){
		    	String[] paramValues = request.getParameterValues(paramName);
		    	//score.setTransactionId(paramValues[0]);
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
		request.getSession().setAttribute("ID_CHECK", "FAIL");
		score.setQuestionId(questionIds);
		score.setChoiceId(choiceIds);
		if(scoreRequest(score, lexisNexisSericeEndPoint)){
			request.getSession().setAttribute("ID_CHECK", "SUCCESS");
			response.sendRedirect("companyinformation.jsp");
		}else{
			int qizCount = 1;
			if(StringUtils.isNotBlank(personal.getQuizcheckcount())){
				qizCount = Integer.parseInt(personal.getQuizcheckcount());
				qizCount++;
				personal.setQuizcheckcount(qizCount+"");
			}			
			response.sendRedirect("lexisnexisqavalidation.jsp");
		}
	    request.getSession().setAttribute("personalinformation", personal); //SET all the data to SESSION
		

 %>
 
 <%!
 
 	  public boolean scoreRequest(ScoreInformation score, String endPoint) throws Exception { 
	  
		 score.setWorkFlow("FAA_B2B_AUTH_FLOW");
		 LexisNexisService service = new  LexisNexisServiceImpl();	  
		 IdentityProofingResponse lnresponse = service.scoreRequest(score, endPoint);		  
		 String status = lnresponse.getStatus();
		 if("PASS".equalsIgnoreCase(status)){
				return true;	
		 }else{
				return false;
		 }
		  
	  }
  %>


