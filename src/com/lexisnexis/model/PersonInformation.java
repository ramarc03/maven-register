package com.lexisnexis.model;

import org.apache.log4j.Logger;

/**
 * Model object to build person information to pass LexisNexis Service class.
 * @author Gangadhar CTR Gouri
 *
 */

public class PersonInformation {

	static Logger log = Logger.getLogger(PersonInformation.class.getName());
	private String prefixName;
	private String firstName;
	private String middleName;
	private String lastName;
	private String suffixName;
	private String LexID;
	private String ssn;
	private String dateOfBirthYear;
	private String dateOfBirthMonth;
	private String dateOfBirthDay;
	private String age;
	private String addressLine1;
	private String addressLine2;
	private String city;
	private String stateCode;
	private String zip5;
	private String countryCode;
	private String accountNumber;
	private String licenseNumber;
	private String licenseState;
	private String pnumber;
	private String hnumber;
	private String mnumber;
	private String workFlow;
	private String email;
	private String phoneType;
	private String otpsession;
	private String idcheck;
	private String ccvalidation;
	private String ssndlvalidation;
	private String otpcheckcount;
	private String quizcheckcount;
	private String otpvalidation;
	private String creditcardcheck;
	private String transactionid;
	private String referencecode;
	private String appname;

	public String getHnumber() {
		return hnumber;
	}
	public void setHnumber(String hnumber1) {
		this.hnumber = hnumber1;
	}
	
	public String getReferencecode() {
		return referencecode;
	}
	public void setReferencecode(String referencecode1) {
		this.referencecode = referencecode1;
	}

	public String getAppname() {
		return appname;
	}
	public void setAppname(String appname1) {
		this.appname = appname1;
	}
	
	/**
	 * To get prefix of person name  (Dr, Miss, Mr etc)
	 * @return prefix of person 
	 */
	
	public String getPrefixName() {
		return prefixName;
	}
	
	/**
	 * To prefix of person name  (Dr, Miss, Mr etc)
	 * @param prefixName1 - prefix of name
	 */

	public void setPrefixName(String prefixName1) {
		this.prefixName = prefixName1;
	}
	
	/**
	 * To get first name of person name  
	 * @return first namr of person
	 */
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName1) {
		this.firstName = firstName1;
	}
	public String getMiddleName() {
		if(middleName == null){
			middleName="";
		}
		return middleName;
	}
	public void setMiddleName(String middleName1) {
		this.middleName = middleName1;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName1) {
		this.lastName = lastName1;
	}
	public String getLexID() {
		return LexID;
	}
	public void setLexID(String lexID) {
		LexID = lexID;
	}
	public String getSsn() {
		if(ssn == null){
			ssn="";
		}
		return ssn;
	}
	public void setSsn(String ssn1) {
		this.ssn = ssn1;
	}
	public String getDateOfBirthYear() {
		return dateOfBirthYear;
	}
	public void setDateOfBirthYear(String dateOfBirthYear1) {
		this.dateOfBirthYear = dateOfBirthYear1;
	}
	public String getDateOfBirthMonth() {
		return dateOfBirthMonth;
	}
	public void setDateOfBirthMonth(String dateOfBirthMonth1) {
		this.dateOfBirthMonth = dateOfBirthMonth1;
	}
	public String getDateOfBirthDay() {
		return dateOfBirthDay;
	}
	public void setDateOfBirthDay(String dateOfBirthDay1) {
		this.dateOfBirthDay = dateOfBirthDay1;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age1) {
		this.age = age1;
	}
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine11) {
		this.addressLine1 = addressLine11;
	}
	public String getAddressLine2() {
		if(addressLine2 == null){
			addressLine2="";
		}
		return addressLine2;
	}
	public void setAddressLine2(String addressLine21) {
		this.addressLine2 = addressLine21;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city1) {
		this.city = city1;
	}
	public String getZip5() {
		return zip5;
	}
	public void setZip5(String zip51) {
		this.zip5 = zip51;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode1) {
		this.countryCode = countryCode1;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber1) {
		this.accountNumber = accountNumber1;
	}
	public String getStateCode() {
		return stateCode;
	}
	public void setStateCode(String stateCode1) {
		this.stateCode = stateCode1;
	}
	public String getSuffixName() {
		if(suffixName == null){
			suffixName="";
		}
		return suffixName;
	}
	public void setSuffixName(String suffixName1) {
		this.suffixName = suffixName1;
	}
	
	/**
	 * @return the licenseNumber
	 */
	public String getLicenseNumber() {
		return licenseNumber;
	}

	/**
	 * @param licenseNumber1 the licenseNumber to set
	 */
	public void setLicenseNumber(String licenseNumber1) {
		this.licenseNumber = licenseNumber1;
	}
	/**
	 * @return the mnumber
	 */
	public String getMnumber() {
		if(mnumber == null){
			mnumber="";
		}
		return mnumber;
	}

	/**
	 * @param mnumber1 the mnumber to set
	 */
	public void setMnumber(String mnumber1) {
		this.mnumber = mnumber1;
	}

	/**
	 * @return the licenseState
	 */
	public String getLicenseState() {
		return licenseState;
	}

	/**
	 * @param licenseState1 the licenseState to set
	 */
	public void setLicenseState(String licenseState1) {
		this.licenseState = licenseState1;
	}

	/**
	 * @return the workFlow
	 */
	public String getWorkFlow() {
		return workFlow;
	}

	/**
	 * @param workFlow1 the workFlow to set
	 */
	public void setWorkFlow(String workFlow1) {
		this.workFlow = workFlow1;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email1 the email to set
	 */
	public void setEmail(String email1) {
		this.email = email1;
	}
	
	/**
	 * @return the phoneType
	 */
	public String getPhoneType() {
		return phoneType;
	}

	/**
	 * @param phoneType1 the phoneType to set
	 */
	public void setPhoneType(String phoneType1) {
		this.phoneType = phoneType1;
	}
	/**
	 * @return the pnumber
	 */
	public String getPnumber() {
		if(pnumber == null){
			pnumber="";
		}
		return pnumber;
	}

	/**
	 * @param pnumber1 the pnumber to set
	 */
	public void setPnumber(String pnumber1) {
		this.pnumber = pnumber1;
	}
	public String getOtpsession() {
		return otpsession;
	}

	public void setOtpsession(String otpsession1) {
		this.otpsession = otpsession1;
	}

	public String getIdcheck() {
		return idcheck;
	}

	public void setIdcheck(String idcheck1) {
		this.idcheck = idcheck1;
	}

	public String getCcvalidation() {
		return ccvalidation;
	}

	public void setCcvalidation(String ccvalidation1) {
		this.ccvalidation = ccvalidation1;
	}

	public String getSsndlvalidation() {
		return ssndlvalidation;
	}

	public void setSsndlvalidation(String ssndlvalidation1) {
		this.ssndlvalidation = ssndlvalidation1;
	}

	public String getOtpcheckcount() {
		return otpcheckcount;
	}

	public void setOtpcheckcount(String otpcheckcount1) {
		this.otpcheckcount = otpcheckcount1;
	}

	public String getQuizcheckcount() {
		return quizcheckcount;
	}

	public void setQuizcheckcount(String quizcheckcount1) {
		this.quizcheckcount = quizcheckcount1;
	}

	public String getOtpvalidation() {
		return otpvalidation;
	}

	public void setOtpvalidation(String otpvalidation1) {
		this.otpvalidation = otpvalidation1;
	}

	public String getCreditcardcheck() {
		return creditcardcheck;
	}

	public void setCreditcardcheck(String creditcardcheck1) {
		this.creditcardcheck = creditcardcheck1;
	}
	
	public String getTransactionid() {
		return transactionid;
	}
	public void setTransactionid(String transactionid1) {
		this.transactionid = transactionid1;
	}
	@Override
	public String toString() {
		return "PersonInformation [prefixName=" + prefixName + ", firstName=" + firstName + ", middleName=" + middleName  //$NON-NLS-1$//$NON-NLS-2$ //$NON-NLS-3$
				+ ", lastName=" + lastName + ", suffixName=" + suffixName  + ", transactionid=" + transactionid //$NON-NLS-1$ //$NON-NLS-2$
				/*
				+ ", LexID=" + LexID + ", ssn=" + ssn
				+ ", dateOfBirthYear=" + dateOfBirthYear + ", dateOfBirthMonth=" + dateOfBirthMonth
				+ ", dateOfBirthDay=" + dateOfBirthDay + ", age=" + age + ", addressLine1=" + addressLine1
				+ ", addressLine2=" + addressLine2 + ", city=" + city + ", stateCode=" + stateCode + ", zip5=" + zip5
				+ ", countryCode=" + countryCode + ", accountNumber=" + accountNumber + ", licenseNumber="
				+ licenseNumber + ", licenseState=" + licenseState + ", pnumber=" + pnumber + ", hnumber=" + hnumber
				+ ", mnumber=" + mnumber + ", workFlow=" + workFlow + ", email=" + email + ", phoneType=" + phoneType
				+ ", otpsession=" + otpsession + ", idcheck=" + idcheck + ", ccvalidation=" + ccvalidation
				+ ", ssndlvalidation=" + ssndlvalidation + ", otpcheckcount=" + otpcheckcount + ", quizcheckcount="
				+ quizcheckcount + ", otpvalidation=" + otpvalidation + ", creditcardcheck=" + creditcardcheck
				+ ", transactionid=" + transactionid + ", referencecode=" + referencecode + ", appname=" + appname
				*/
				+ "]"; //$NON-NLS-1$
	}
	
	

}
