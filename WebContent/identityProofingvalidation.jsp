<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="java.lang.StringBuilder"%>
<%@ page import="com.lexisnexis.bo.LexisNexisService"%>
<%@ page import="com.lexisnexis.bo.impl.LexisNexisServiceImpl"%>
<%@ page import = "java.util.ResourceBundle" %>


<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<%
	ResourceBundle resource = ResourceBundle.getBundle("externalreg");
  	String lexisNexisSericeEndPoint=resource.getString("LexisNexisServiceEndPoint");
  	
	PersonInformation person = new PersonInformation();
	person.setFirstName(personInformationForm.getFname());
	person.setLastName(personInformationForm.getLname());
	// person.setMiddleName(personInformationForm.getMname());
	// person.setSuffixName(personInformationForm.getSuffix());
	person.setPhoneType(personInformationForm.getPhonetype());   
	person.setEmail(personInformationForm.getEmail());
	person.setDateOfBirthDay(personInformationForm.getBirthday());
	person.setDateOfBirthMonth(personInformationForm.getBirthmonth());
	person.setDateOfBirthYear(personInformationForm.getBirthyear());
	person.setAddressLine1(personInformationForm.getHaddress1());
	person.setAddressLine2(personInformationForm.getHaddress2());
	person.setCity(personInformationForm.getHcity());
	person.setStateCode(personInformationForm.getHstate());
	person.setZip5(personInformationForm.getHzip());
	String ssn = personInformationForm.getSsn();
	if((ssn != null)&& ( ssn.trim().length() > 0)){
		person.setSsn(ssn.replace("-",""));
	}
	person.setAppname(personInformationForm.getAppname());
	person.setTransactionid(personInformationForm.getTransactionid());
	person.setReferencecode(personInformationForm.getReferencecode());
	person.setLicenseNumber(personInformationForm.getLicense());
	person.setLicenseState(personInformationForm.getLicensestate());
	
	String workFlow = "";
	if((ssn != null)&& ( ssn.trim().length() > 0)){
		workFlow = "FAA_B2B_VERIF_SSN_FLOW";
	}else{
		workFlow = "FAA_B2B_VERIF_DLN_FLOW";
	}
	
	LexisNexisServiceImpl service = new LexisNexisServiceImpl();
	String result = service.validatePersonalInformation(person, lexisNexisSericeEndPoint, workFlow);	
	out.println(result);

 %>
 

