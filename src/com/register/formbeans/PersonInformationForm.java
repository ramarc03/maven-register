package com.register.formbeans;

import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.owasp.esapi.ESAPI;

public class PersonInformationForm {
	private String fname="";
	private String mname="";
	private String lname="";
	private String suffix="";
	private String haddress1="";
	private String haddress2="";
	private String hcity="";
	private String hstate="";
	private String hzip="";
	private String mnumber="";
	private String pnumber="";
	private String hnumber="";
	private String birthday="";
	private String birthmonth="";
	private String birthyear="";
	private String ccn="";
	private String email="";
	private String ssn ="";
	private String ssnencode= "";
	private String mtype="";
	private String lexid="";
	private String successPage="";
	private String errorPage="";
	private String otpsession="";
	private String idcheck="";
	private String ccvalidation="";
	private String ssndlvalidation="";
	private String otpcheckcount="";
	private String quizcheckcount="";
	private String otpvalidation="";
	private String creditcardcheck="";
	private String phonetype="";
	private String transactionid="";
	private String referencecode="";
	private String appname="";
	private String otp="";
	private String license="";
	private String title="";
	private String caddress1="";
	private String caddress2="";
	private String ccity="";	
	private String cstate="";
	private String czip="";		
	private String cfax="";
	private String cname="";
	private String licensestate="";
	
	public String getCname() {
		return cname;
	}
	public void setCname(String cname1) {
		this.cname = cname1;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title1) {
		this.title = title1;
	}
	public String getCaddress1() {
		return caddress1;
	}
	public void setCaddress1(String caddress11) {
		this.caddress1 = caddress11;
	}
	public String getCaddress2() {
		return caddress2;
	}
	public void setCaddress2(String caddress21) {
		this.caddress2 = caddress21;
	}
	public String getCcity() {
		return ccity;
	}
	public void setCcity(String ccity1) {
		this.ccity = ccity1;
	}
	public String getCstate() {
		return cstate;
	}
	public void setCstate(String cstate1) {
		this.cstate = cstate1;
	}
	public String getCzip() {
		return czip;
	}
	public void setCzip(String czip1) {
		this.czip = czip1;
	}
	public String getCfax() {
		return cfax;
	}
	public void setCfax(String cfax1) {
		this.cfax = cfax1;
	}

	public String getHnumber() {
		return hnumber;
	}
	public void setHnumber(String hnumber1) {
		this.hnumber = hnumber1;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String licenseNumber1) {
		this.license = licenseNumber1;
	}
	public String getLicensestate() {
		return licensestate;
	}
	public void setLicensestate(String licenseState1) {
		this.licensestate = licenseState1;
	}


	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp1) {
		this.otp = otp1;
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
	private HashMap<String, String> errors = new HashMap<String, String>();
	
	public String getLexid() {
		return lexid;
	}
	public void setLexid(String lexid1) {
		this.lexid = lexid1;
	}
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname1) {
		this.fname = fname1;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname1) {
		this.mname = mname1;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname1) {
		this.lname = lname1;
	}
	public String getSuffix() {
		return suffix;
	}
	public void setSuffix(String suffix1) {
		this.suffix = suffix1;
	}
	public String getHaddress1() {
		return haddress1;
	}
	public void setHaddress1(String haddress11) {
		this.haddress1 = haddress11;
	}
	public String getHaddress2() {
		return haddress2;
	}
	public void setHaddress2(String haddress21) {
		this.haddress2 = haddress21;
	}
	public String getHcity() {
		return hcity;
	}
	public void setHcity(String hcity1) {
		this.hcity = hcity1;
	}
	public String getHstate() {
		return hstate;
	}
	public void setHstate(String hstate1) {
		this.hstate = hstate1;
	}
	public String getHzip() {
		return hzip;
	}
	public void setHzip(String hzip1) {
		this.hzip = hzip1;
	}
	public String getMnumber() {
		return mnumber;
	}
	public void setMnumber(String mnumber1) {
		this.mnumber = mnumber1;
	}
	public String getPnumber() {
		return pnumber;
	}
	public void setPnumber(String pnumber1) {
		this.pnumber = pnumber1;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday1) {
		this.birthday = birthday1;
	}
	public String getBirthmonth() {
		return birthmonth;
	}
	public void setBirthmonth(String birthmonth1) {
		this.birthmonth = birthmonth1;
	}
	public String getBirthyear() {
		return birthyear;
	}
	public void setBirthyear(String birthyear1) {
		this.birthyear = birthyear1;
	}
	public String getCcn() {
		return ccn;
	}
	public void setCcn(String ccn1) {
		this.ccn = ccn1;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email1) {
		this.email = email1;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn1) {
		this.ssn = ssn1;
	}
	public String getSsnencode() {
		return ssnencode;
	}
	public void setSsnencode(String ssnencode) {
		this.ssnencode = ssnencode;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype1) {
		this.mtype = mtype1;
	}
	
	public HashMap<String, String> getErrors() {
		return errors;
	}
	public void setErrors(HashMap<String, String> errors1) {
		this.errors = errors1;
	}
	
	public String getSuccessPage() {
		return "";
	}
	public void setSuccessPage(String successPage1) {
		this.successPage = successPage1;
	}
	public String getErrorPage() {
		return "personalinformation.jsp"; //$NON-NLS-1$
	}
	public void setErrorPage(String errorPage1) {
		this.errorPage = errorPage1;
	}
	public boolean validate() {
		boolean validForm =true;
		if(StringUtils.isBlank(this.fname) 
				||  (StringUtils.isNotBlank(this.fname) && !ESAPI.validator().isValidInput("fname", this.fname, "StringWithSpace",150, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("fname", "Please enter a valid First Name");  //$NON-NLS-1$//$NON-NLS-2$
			validForm = false;
		}
		if((StringUtils.isNotBlank(this.mname) && !ESAPI.validator().isValidInput("mname", this.mname, "StringWithSpace",100, true))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("mname", "Please enter a valid \"Middle Name\""); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.lname) 
				||  (StringUtils.isNotBlank(this.lname) && !ESAPI.validator().isValidInput("lname", this.lname, "StringWithSpace",150, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("lname", "Please enter a valid Last Name"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if((StringUtils.isNotBlank(this.suffix) && !ESAPI.validator().isValidInput("suffix", this.suffix, "SafeString",10, true))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("suffix", "Please enter a valid Suffix"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.haddress1) 
				||  (StringUtils.isNotBlank(this.haddress1) && !ESAPI.validator().isValidInput("haddress1", this.haddress1, "Address",250, false))){ //$NON-NLS-1$
			this.errors.put("haddress1", "Please enter a valid Address Line 1"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if((StringUtils.isNotBlank(this.haddress2) && !ESAPI.validator().isValidInput("haddress2", this.haddress2, "Address",250, true))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("haddress2", "Please enter a valid Address Line 2"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.hcity) 
				||  (StringUtils.isNotBlank(this.hcity) && !ESAPI.validator().isValidInput("hcity", this.hcity, "CityState",200, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("hcity", "Please enter a valid City"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.hstate) 
				||  (StringUtils.isNotBlank(this.hstate) && !ESAPI.validator().isValidInput("hstate", this.hstate, "CityState",200, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("hstate", "Please enter a valid State"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.hzip) 
				||  (StringUtils.isNotBlank(this.hzip) && !ESAPI.validator().isValidInput("hzip", this.hzip, "Zip",5, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("hzip", "Please enter a valid zip"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if((StringUtils.isNotBlank(this.mnumber) && !ESAPI.validator().isValidInput("mnumber", this.mnumber, "Phone",15, true))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("mnumber", "Please enter a valid Mobile number"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if((StringUtils.isNotBlank(this.pnumber) && !ESAPI.validator().isValidInput("pnumber", this.pnumber, "Phone",15, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("pnumber", "Please enter a valid Phone number"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.birthday) 
				||  (StringUtils.isNotBlank(this.fname) && !ESAPI.validator().isValidInput("birthday", this.birthday, "SafeNumeric",2, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("birthday", "Please enter a valid Birth Day"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		
		if(StringUtils.isBlank(this.birthmonth) 
				||  (StringUtils.isNotBlank(this.birthmonth) && !ESAPI.validator().isValidInput("birthmonth", this.birthmonth, "SafeNumeric",2, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("birthmonth", "Please enter a valid Birth Month"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.birthyear) 
				||  (StringUtils.isNotBlank(this.birthyear) && !ESAPI.validator().isValidInput("birthyear", this.birthyear, "SafeNumeric",4, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("birthyear", "Please enter a valid Birth Year"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		if(StringUtils.isBlank(this.email) 
				||  (StringUtils.isNotBlank(this.email) && !ESAPI.validator().isValidInput("email", this.email, "Email",200, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("email", "Please enter a valid Email"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}

		if((StringUtils.isNotBlank(this.ssn) && !ESAPI.validator().isValidInput("ssn", this.ssn, "SSN",11, false))){ //$NON-NLS-1$ //$NON-NLS-2$
			this.errors.put("ssn", "Please enter a valid SSN"); //$NON-NLS-1$ //$NON-NLS-2$
			validForm = false;
		}
		
		return validForm;
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

	public String getCreditcardcheck() {
		return creditcardcheck;
	}
	public void setCreditcardcheck(String creditcardcheck1) {
		this.creditcardcheck = creditcardcheck1;
	}
	public String getOtpvalidation() {
		return otpvalidation;
	}
	public void setOtpvalidation(String otpvalidation1) {
		this.otpvalidation = otpvalidation1;
	}
	public String getPhonetype() {
		return phonetype;
	}
	public void setPhonetype(String phoneType) {
		this.phonetype = phoneType;
	}
	
	public String getTransactionid() {
		return transactionid;
	}
	public void setTransactionid(String transactionid1) {
		this.transactionid = transactionid1;
	}
	@Override
	public String toString() {
		return "PersonInformationForm [fname=" + fname + ", mname=" + mname + ", lname=" + lname + ", suffix=" + suffix //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
				/**
				+ ", haddress1=" + haddress1 + ", haddress2=" + haddress2 + ", hcity=" + hcity + ", hstate=" + hstate
				+ ", hzip=" + hzip + ", mnumber=" + mnumber + ", pnumber=" + pnumber + ", hnumber=" + hnumber
				+ ", birthday=" + birthday + ", birthmonth=" + birthmonth + ", birthyear=" + birthyear + ", ccn=" + ccn
				+ ", email=" + email + ", ssn=" + ssn + ", mtype=" + mtype + ", lexid=" + lexid + ", successPage="
				+ successPage + ", errorPage=" + errorPage + ", otpsession=" + otpsession + ", idcheck=" + idcheck
				+ ", ccvalidation=" + ccvalidation + ", ssndlvalidation=" + ssndlvalidation + ", otpcheckcount="
				+ otpcheckcount + ", quizcheckcount=" + quizcheckcount + ", otpvalidation=" + otpvalidation
				+ ", creditcardcheck=" + creditcardcheck + ", phonetype=" + phonetype + ", transactionid="
				+ transactionid + ", referencecode=" + referencecode + ", appname=" + appname + ", otp=" + otp
				+ ", licenseNumber=" + licenseNumber + ", licenseState=" + licenseState
				**/
				 + ", errors=" + errors + "]"; //$NON-NLS-1$ //$NON-NLS-2$
	}

	
}
