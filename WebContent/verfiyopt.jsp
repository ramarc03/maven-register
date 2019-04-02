<%@ page import="org.owasp.esapi.ESAPI"%>
<%@ page import="com.lexisnexis.model.PersonInformation"%>
<%@ page import="com.register.otp.bo.OTPService"%>
<%@ page import="com.register.otp.bo.impl.OTPServiceImpl"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<jsp:useBean id="personInformationForm" class="com.register.formbeans.PersonInformationForm" scope="request">
    <jsp:setProperty name="personInformationForm" property="*"/>
</jsp:useBean>
<%
		String personInfo ="First Name:"+personInformationForm.getFname()+"  Last Name:"+personInformationForm.getLname();
		
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
		person.setZip5(personInformationForm.getHzip());
		person.setAppname(personInformationForm.getAppname());
		person.setTransactionid(personInformationForm.getTransactionid());
		person.setReferencecode(personInformationForm.getReferencecode());
		person.setLicenseNumber(personInformationForm.getLicense());
		person.setLicenseState(personInformationForm.getLicensestate());
		person.setOtpsession(personInformationForm.getOtpsession());
		ResourceBundle resource = ResourceBundle.getBundle("externalreg");
		String verifyOtp = resource.getString("VerifyotponceServiceEndPoint");
		String accountNumber = "1817165";		
		String otp = personInformationForm.getOtp();
		boolean result = verifyOTPOnce(person, otp, accountNumber, verifyOtp);
		out.println(result);	

	%>

<%!
	 public boolean verifyOTPOnce(PersonInformation person, String otp, String accountNumber, String verifyOtp) throws Exception { 
	 	  OTPService service = new OTPServiceImpl();
		  return service.verifyOTPOnce(person, otp, accountNumber, verifyOtp);		
	 }

 %>
