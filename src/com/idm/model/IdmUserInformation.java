package com.idm.model;

import org.apache.log4j.Logger;


/**
 * Model object to build company information to pass Idm Service class.
 * @author Gangadhar CTR Gouri
 *
 */

public class IdmUserInformation {
	
	static Logger log = Logger.getLogger(IdmUserInformation.class.getName());
	
	private String prefixName="";
	private String firstName="";
	private String middleName="";
	private String lastName="";
	private String userid="";
	private String suffixName="";
	private String employeeNumber="";
	private String departmentNumber="";
	private String addressLine1="";
	private String addressLine2="";
	private String roomNumber="";
	private String city="";
	private String stateCode="";
	private String zip5="";
	private String countryCode="";
	private String title="";
	private String mobile="";
	private String telephoneNumber="";
	private String phoneExtension="";
	private String email="";
	private String adminId="";
	
	private String orgMembership="";
	private String lexID="";

	private String comanyName="";
	private String fax="";
	private String referencecode="";


	
	/**
	 * To get prefix of person name  (Dr, Miss, Mr etc)
	 * @return prefix of person 
	 */
	
	public String getPrefixName() {
		return prefixName;
	}
	
	/**
	 * To prefix of person name  (Dr, Miss, Mr etc)
	 * @param prefixName - prefix of name
	 */

	public void setPrefixName(String prefixName) {
		this.prefixName = prefixName;
	}
	
	/**
	 * To get first name of person name  
	 * @return first namr of person
	 */
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the userid
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * @param userid the userid to set
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	/**
	 * @return the roomNumber
	 */
	public String getRoomNumber() {
		return roomNumber;
	}

	/**
	 * @param roomNumber the roomNumber to set
	 */
	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getZip5() {
		return zip5;
	}
	public void setZip5(String zip5) {
		this.zip5 = zip5;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getStateCode() {
		return stateCode;
	}
	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}
	public String getSuffixName() {
		return suffixName;
	}
	public void setSuffixName(String suffixName) {
		this.suffixName = suffixName;
	}
	
	/**
	 * @return the employeeNumber
	 */
	public String getEmployeeNumber() {
		return employeeNumber;
	}

	/**
	 * @param employeeNumber the employeeNumber to set
	 */
	public void setEmployeeNumber(String employeeNumber) {
		this.employeeNumber = employeeNumber;
	}

	/**
	 * @return the departmentNumber
	 */
	public String getDepartmentNumber() {
		return departmentNumber;
	}

	/**
	 * @param departmentNumber the departmentNumber to set
	 */
	public void setDepartmentNumber(String departmentNumber) {
		this.departmentNumber = departmentNumber;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the mobile
	 */
	public String getMobile() {
		return mobile;
	}

	/**
	 * @param mobile the mobile to set
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	/**
	 * @return the telephoneNumber
	 */
	public String getTelephoneNumber() {
		return telephoneNumber;
	}

	/**
	 * @param telephoneNumber the telephoneNumber to set
	 */
	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}

	/**
	 * @return the phoneExtension
	 */
	public String getPhoneExtension() {
		return phoneExtension;
	}

	/**
	 * @param phoneExtension the phoneExtension to set
	 */
	public void setPhoneExtension(String phoneExtension) {
		this.phoneExtension = phoneExtension;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the adminId
	 */
	public String getAdminId() {
		return adminId;
	}

	/**
	 * @param adminId the adminId to set
	 */
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	

	/**
	 * @return the orgMembership
	 */
	public String getOrgMembership() {
		return orgMembership;
	}

	/**
	 * @param orgMembership the orgMembership to set
	 */
	public void setOrgMembership(String orgMembership) {
		this.orgMembership = orgMembership;
	}

	/**
	 * @return the lexID
	 */
	public String getLexID() {
		return lexID;
	}

	/**
	 * @param lexID the lexID to set
	 */
	public void setLexID(String lexID) {
		this.lexID = lexID;
	}

	/**
	 * @return the comanyName
	 */
	public String getComanyName() {
		return comanyName;
	}

	/**
	 * @param comanyName the comanyName to set
	 */
	public void setComanyName(String comanyName) {
		this.comanyName = comanyName;
	}

	/**
	 * @return the fax
	 */
	public String getFax() {
		return fax;
	}

	/**
	 * @param fax the fax to set
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getReferencecode() {
		return referencecode;
	}

	public void setReferencecode(String referencecode) {
		this.referencecode = referencecode;
	}

	/**
	 * returns string value of object
	 */
	public String toString(){
		
		StringBuilder builder = new StringBuilder();
		//builder.append(" prefixName: "+ this.prefixName);
		builder.append(" firstName: "+ this.firstName);
		builder.append(" middleName: "+ this.middleName);
		builder.append(" lastName: "+ this.lastName);
		//builder.append(" userid: " + this.userid);
		builder.append(" suffixName: "+ this.suffixName);
		builder.append(" Lexus id : "+ lexID);

		/*
		 builder.append(" addressLine1: "+ this.addressLine1);
		 builder.append(" addressLine2: "+ this.addressLine2);
			builder.append(" city: "+ this.city);
			builder.append(" stateCode: "+ this.stateCode);
			builder.append(" zip5: "+ this.zip5);
			builder.append(" countryCode: "+ this.countryCode);
			builder.append(" employeeNumber: "+ employeeNumber);
			builder.append(" departmentNumber: "+ departmentNumber);
			builder.append(" title: "+ title);
		*/
		return builder.toString();

	}

	

}
