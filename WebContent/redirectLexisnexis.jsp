<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.lang.StringBuilder"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.register.util.CryptoUtil"%>
<%! static Logger logger = Logger.getLogger(redirectLexisnexis_jsp.class); %>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	
	PersonInformation person = new PersonInformation();
	person.setFirstName(personInformationForm.getFname());
	person.setLastName(personInformationForm.getLname());
	person.setMiddleName(personInformationForm.getMname());
	person.setSuffixName(personInformationForm.getSuffix());
	person.setPhoneType(personInformationForm.getPhonetype());   //This will also contain  CRAD along with MOBILE and LAND
	person.setEmail(personInformationForm.getEmail());
	person.setDateOfBirthDay(personInformationForm.getBirthday());
	person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
	person.setDateOfBirthYear(personInformationForm.getBirthyear());
	person.setAddressLine1(personInformationForm.getHaddress1());
	person.setAddressLine2(personInformationForm.getHaddress2());
	person.setCity(personInformationForm.getHcity());
	person.setStateCode(personInformationForm.getHstate());
	person.setZip5(personInformationForm.getHzip());
	person.setSsn(personInformationForm.getSsn());

	person.setAppname(personInformationForm.getAppname());
	if((personInformationForm.getReferencecode() != null) && (personInformationForm.getReferencecode().trim().length() >0)){
		person.setReferencecode(personInformationForm.getReferencecode());
	
	}else{
		StringBuilder transactionid = new StringBuilder();
		transactionid.append(java.util.UUID.randomUUID());
		transactionid.append(":");
		transactionid.append(personInformationForm.getAppname());
		//transactionid.append(CryptoUtil.encrypt(personInformationForm.getEmail()));
		person.setTransactionid(transactionid.toString());
		person.setReferencecode(transactionid.toString());
	}

	if(StringUtils.isNotBlank(personInformationForm.getMnumber())){		
		person.setMnumber(personInformationForm.getMnumber());
	}else{
		person.setMnumber("");
	}
	if(StringUtils.isNotBlank(personInformationForm.getPnumber())){		
		person.setPnumber(personInformationForm.getPnumber());
	}else{
		person.setPnumber("");
	}
	
	person.setOtpsession(personInformationForm.getOtpsession());
	person.setIdcheck(personInformationForm.getIdcheck());
	person.setCcvalidation(personInformationForm.getCcvalidation());
	person.setSsndlvalidation(personInformationForm.getSsndlvalidation());
	person.setOtpcheckcount(personInformationForm.getOtpcheckcount());
	person.setQuizcheckcount(personInformationForm.getQuizcheckcount());
	person.setOtpvalidation(personInformationForm.getOtpvalidation());
	
	request.getSession().setAttribute("personalinformation", person);
	if(person == null || (person != null && StringUtils.isBlank(person.getFirstName()))){
 		throw new Exception("Invalid Access");
 	}
	String fname  = person.getFirstName();
	String lname  = person.getLastName();
	String mname  = person.getMiddleName();
	
	String cccount ="1";
	if(StringUtils.isNotBlank(request.getParameter("cccount"))){
		cccount = ESAPI.validator().getValidInput("cccount",request.getParameter("cccount"), "SafeNumeric", 11 ,true );
	} 
	if(StringUtils.isNotBlank(person.getSsn())){
		response.sendRedirect("lexisnexisssnvalidation.jsp");
	}else{
		logger.info("Redirecting to DL Validation as SSN is Not provided by the User - First Name: "+fname+" Middle Name: "+mname+" Last Name: "+lname);
		response.sendRedirect("personalinformationlicense.jsp");
	}
 %>
 

<%!
		public String replaceValue(String value){
			String newVal =  value.replace("'", "&#39");
			return newVal;
		}
 %>

