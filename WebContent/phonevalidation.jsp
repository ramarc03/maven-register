<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.register.otp.bo.OTPService"%>
<%@ page import="com.register.otp.bo.impl.OTPServiceImpl"%>
<%@ page import="com.register.formbeans.PersonInformationForm"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.log4j.Logger"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>

<%
	response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server	

	ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  	String verifyphone=resource.getString("VerifyphoneServiceEndPoint");
  	String generateotponce=resource.getString("GenerateotponceServiceEndPoint");
	String accountNumber = "1817165";
	PersonInformation person = new PersonInformation();
	person.setFirstName(personInformationForm.getFname());
	person.setLastName(personInformationForm.getLname());
	person.setMiddleName(personInformationForm.getMname());
	person.setSuffixName(personInformationForm.getSuffix());
	person.setPhoneType(personInformationForm.getPhonetype());   
	person.setEmail(personInformationForm.getEmail());
	person.setDateOfBirthDay(personInformationForm.getBirthday());
	person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
	person.setDateOfBirthYear(personInformationForm.getBirthyear());
	person.setAddressLine1(personInformationForm.getHaddress1());
	person.setAddressLine2(personInformationForm.getHaddress2());
	person.setCity(personInformationForm.getHcity());
	person.setStateCode(personInformationForm.getHstate());
	if(personInformationForm.getMnumber()!=null){
		String phoneNum = "";
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getMnumber().replace(" ",") "));
		phoneNum = buffer.toString();
		person.setMnumber(phoneNum);
	}
	if(personInformationForm.getPnumber()!=null){
		String phoneNum = "";
		StringBuffer buffer = new StringBuffer();
		buffer.append("(");
		buffer.append(personInformationForm.getPnumber().replace(" ",") "));
		phoneNum = buffer.toString();
		person.setPnumber(phoneNum);
	}

	person.setZip5(personInformationForm.getHzip());
	String ssn = personInformationForm.getSsn();
	if((ssn != null)&& ( ssn.trim().length() > 0)){
		person.setSsn(ssn.replace("-",""));
	}
	person.setAppname(personInformationForm.getAppname());
	person.setTransactionid(personInformationForm.getTransactionid());
	person.setReferencecode(personInformationForm.getReferencecode());
	person.setLexID(personInformationForm.getLexid());
	person.setReferencecode(personInformationForm.getReferencecode());
	person.setHnumber(personInformationForm.getHnumber());
	person.setOtpsession(personInformationForm.getOtpsession());
	person.setLicenseNumber(personInformationForm.getLicense());
	person.setLicenseState(personInformationForm.getLicensestate());
	boolean result = verifyPhone(person,accountNumber,verifyphone);
	if(result){
	
		out.println("PASSED");
	}else{
		out.println("FAILED");
	}
%>

<%!

	 public boolean verifyPhone(PersonInformation person, String accountNumber, String endPoint) throws Exception { 
		  OTPService service = new OTPServiceImpl();
		  return service.verifyPhone(person, accountNumber,endPoint);	
	 }

 %>
