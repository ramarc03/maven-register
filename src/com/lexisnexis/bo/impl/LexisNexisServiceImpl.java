package com.lexisnexis.bo.impl;

import java.rmi.RemoteException;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.lexisnexis.bo.LexisNexisService;
import com.lexisnexis.model.PersonInformation;
import com.lexisnexis.model.ScoreInformation;
import com.lexisnexis.ns.identity_proofing._1_0.AccountType;
import com.lexisnexis.ns.identity_proofing._1_0.AddressPurposeType;
import com.lexisnexis.ns.identity_proofing._1_0.Check;
import com.lexisnexis.ns.identity_proofing._1_0.CheckGroup;
import com.lexisnexis.ns.identity_proofing._1_0.Choice;
import com.lexisnexis.ns.identity_proofing._1_0.Date;
import com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingRequest;
import com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse;
import com.lexisnexis.ns.identity_proofing._1_0.IdentityQuizAnswer;
import com.lexisnexis.ns.identity_proofing._1_0.IdentityScoreRequest;
import com.lexisnexis.ns.identity_proofing._1_0.InputAccount;
import com.lexisnexis.ns.identity_proofing._1_0.InputAccounts;
import com.lexisnexis.ns.identity_proofing._1_0.InputAddress;
import com.lexisnexis.ns.identity_proofing._1_0.InputLicense;
import com.lexisnexis.ns.identity_proofing._1_0.InputName;
import com.lexisnexis.ns.identity_proofing._1_0.InputPerson;
import com.lexisnexis.ns.identity_proofing._1_0.InputSubject;
import com.lexisnexis.ns.identity_proofing._1_0.InstantAuthenticateResponse;
import com.lexisnexis.ns.identity_proofing._1_0.InstantVerifyResponse;
import com.lexisnexis.ns.identity_proofing._1_0.LicenseType;
import com.lexisnexis.ns.identity_proofing._1_0.ProductResponse;
import com.lexisnexis.ns.identity_proofing._1_0.Question;
import com.lexisnexis.ns.identity_proofing._1_0.Questions;
import com.lexisnexis.ns.identity_proofing._1_0.VerificationSubProductResponse;
import com.lexisnexis.risk.idm.identityproofing.ws.InvokeIdentityService;
import com.lexisnexis.risk.idm.identityproofing.ws.InvokeIdentityServiceDocument;
import com.lexisnexis.risk.idm.identityproofing.ws.InvokeIdentityServiceResponse;
import com.lexisnexis.risk.idm.identityproofing.ws.InvokeIdentityServiceResponseDocument;
import com.lexisnexis.stub.IdentityProofingServiceStub;

/**
 * 
 * @author Gangadhar CTR Gouri *
 */

public class LexisNexisServiceImpl implements LexisNexisService {

	private static Logger log = Logger.getLogger(LexisNexisServiceImpl.class.getName());
	private static final String LOCAL = "en_US"; 

	final Properties props = System.getProperties();

	public String validatePersonalInformation(PersonInformation person, String lexisNexisSericeEndPoint,
			String workFlow) {
		StringBuilder builder = new StringBuilder();
		builder.append("validatePersonalInformation");
		builder.append(" , ");
		builder.append("firstName: ").append(person.getFirstName()).append(" middleName: ")  
				.append(person.getMiddleName());
		builder.append(" lastName: ").append(person.getLastName()).append(" suffixName: ")  
				.append(person.getSuffixName());
	
		builder.append(" , ");
		builder.append(" Referencecode: ").append(person.getTransactionid());
		builder.append(" , ");
		builder.append(" WorkFlow: ").append(workFlow);
		log.info(builder.toString());
		StringBuilder result = new StringBuilder();

		try {
			person.setWorkFlow(workFlow);
			IdentityProofingResponse vresponse = verificationRequest(person, lexisNexisSericeEndPoint);
			builder.append(" , ");
			if ("PASS".equals(vresponse.getStatus())) { 
				ProductResponse[] prodResponseArry = vresponse.getProductResponseArray();
				InstantVerifyResponse pResp = (InstantVerifyResponse) prodResponseArry[0];
				String lexID = pResp.getLexID();
				person.setLexID(lexID);
				result.append("PASSED:" + lexID); 
				builder.append("RESULT:PASS");
			} else {
				result.append("We are having trouble verifying your information. Please check your information and re-submit to restart the verification process.");
				if((vresponse.getStatusDescription() != null)&& (vresponse.getStatusDescription().trim().length()>0)){
					builder.append( " First Name Validation: FAIL");
				}

				boolean idResult = identityVerification(vresponse);
				if (!idResult) {
					builder.append(" Identity Verification: FAIL");
				}

				boolean ocResult = OccupancyOwnershipVerification(vresponse);
				if (!ocResult) {
					builder.append(" Occupancy Ownership Verification: FAIL");
				}
				boolean dobResult = dobVerifications(vresponse);
				if (!dobResult) {
					builder.append(" Date of Birth Verification Validation: FAIL");
				}
				builder.append(" , ");
				builder.append("RESULT:FAIL");
			}
			log.info(builder.toString());

		} catch (Exception e) {
			log.error(builder.toString() + " - RESULT: Exception " + " Error Message : " + e.getMessage());
			return "Validation Failed- Please contact FAA Help Desk."; 
		}
		return result.toString();

	}

	/**
	 * Instant Verify user to verify the accuracy of customer-provided identity
	 * information, for example name, address, phone, Social Security number
	 * (SSN), and date of birth (DOB).
	 * 
	 * @param user
	 * @return
	 * @throws Exception
	 */

	public IdentityProofingResponse verificationRequest(PersonInformation user, String endPoint)
			throws RemoteException {

		InvokeIdentityServiceDocument serviceDocument = InvokeIdentityServiceDocument.Factory.newInstance();
		InvokeIdentityService identityService = serviceDocument.addNewInvokeIdentityService();

		IdentityProofingRequest request = identityService.addNewIdentityProofingRequest();
		request.setTransactionID(user.getTransactionid().trim());
		request.setLocale(LOCAL);
		request.setCustomerReference(user.getTransactionid().trim());
		request.setWorkFlow(user.getWorkFlow());
		InputSubject subject = request.addNewInputSubject();
		InputPerson person = subject.addNewPerson();
		InputName name = person.addNewName();
		name.setFirst(user.getFirstName());
		name.setLast(user.getLastName());

		String ssn = user.getSsn();

		if (ssn != null && !ssn.isEmpty()) {
			person.setSsn(ssn);
		}

		Date dateOfBirth = person.addNewDateOfBirth();
		dateOfBirth.setDay(user.getDateOfBirthDay());
		dateOfBirth.setMonth(user.getDateOfBirthMonth());
		dateOfBirth.setYear(user.getDateOfBirthYear());
		String licensetxt = user.getLicenseNumber();
		log.debug("License number : " + user.getLicenseNumber());
		log.debug("License State : " + user.getLicenseState());

		if (licensetxt != null && (!licensetxt.isEmpty())) {
			InputLicense license = person.addNewLicense();
			license.setType(LicenseType.DRIVERS_LICENSE);
			license.setLicenseNumber(user.getLicenseNumber());
			license.setIssuer(user.getLicenseState());
		}

		InputAddress address = person.addNewAddress();
		address.setAddressPurpose(AddressPurposeType.PRIMARY_RESIDENCE);

		String addressLine1 = user.getAddressLine1();

		if (addressLine1 != null && !addressLine1.isEmpty()) {
			address.setAddressLine1(addressLine1);
		}

		String addressLine2 = user.getAddressLine2();

		if (addressLine2 != null && !addressLine2.isEmpty()) {
			address.setAddressLine2(addressLine2);
		}

		String city = user.getCity();

		if (city != null && !city.isEmpty()) {
			address.setCity(city);

		}

		String state = user.getStateCode();

		if (state != null && !state.isEmpty()) {
			address.setStateCode(state);
		}

		String zip = user.getZip5();

		if (zip != null && !zip.isEmpty()) {
			address.setZip5(zip);
		}

		IdentityProofingServiceStub stub = new IdentityProofingServiceStub(endPoint);

		log.debug("verificationRequest SOAP request " + serviceDocument.xmlText());

		InvokeIdentityServiceResponseDocument responseDocument = stub.invokeIdentityService(serviceDocument);

		log.debug("verificationRequest SOAP response " + responseDocument.xmlText());

		InvokeIdentityServiceResponse responseService = responseDocument.getInvokeIdentityServiceResponse();
		IdentityProofingResponse response = responseService.getIdentityProofingResponse();
		
		return response;

	}

	private boolean identityVerification(IdentityProofingResponse response) {
		boolean valid = true;
		log.debug(" identityVerification: " + response.getStatus().toString()); 
		if ("FAIL".equals(response.getStatus().toString())) { 
			ProductResponse[] prodResponseArry = response.getProductResponseArray();
			if (prodResponseArry.length > 0) {
				InstantVerifyResponse pResp = (InstantVerifyResponse) prodResponseArry[0];
				VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0);
				CheckGroup[] checkGroupArry = vResp.getCheckGroupArray();

				for (CheckGroup checkGroup : checkGroupArry) {
					Check[] checks = checkGroup.getCheckArray();
					if (checkGroup.getGroupName().equals("Identity Verification")) { 
						for (Check c : checks) {
							if ("FAIL".equals(c.getStatus().toString())) { 
								valid = false;
							}
						}
					}
				}
			}
		}
		return valid;
	}

	private boolean OccupancyOwnershipVerification(IdentityProofingResponse response) {
		boolean valid = true;
		log.debug(" OccupancyOwnershipVerification: " + response.getStatus().toString()); 

		if ("FAIL".equals(response.getStatus().toString())) { 
			ProductResponse[] prodResponseArry = response.getProductResponseArray();
			if (prodResponseArry.length > 0) {
				InstantVerifyResponse pResp = (InstantVerifyResponse) prodResponseArry[0];
				VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0);
				CheckGroup[] checkGroupArry = vResp.getCheckGroupArray();

				for (CheckGroup checkGroup : checkGroupArry) {
					Check[] checks = checkGroup.getCheckArray();
					if (checkGroup.getGroupName().equals("Occupancy/Ownership Verification")) { 
						for (Check c : checks) {
							if ("FAIL".equals(c.getStatus().toString())) { 
								valid = false;
							}
						}
					}
				}
			}
		}
		return valid;
	}

	private boolean dobVerifications(IdentityProofingResponse response) {

		boolean valid = true;
		
		if ("FAIL".equals(response.getStatus().toString())) { 
			log.debug(" dobVerifications: " + response.getStatus().toString()); 

			ProductResponse[] prodResponseArry = response.getProductResponseArray();
			if (prodResponseArry.length > 0) {
				InstantVerifyResponse pResp = (InstantVerifyResponse) prodResponseArry[0];
				VerificationSubProductResponse vResp = pResp.getVerificationSubProductResponseArray(0);
				CheckGroup[] checkGroupArry = vResp.getCheckGroupArray();
				log.debug(" length : " + checkGroupArry.length); 

				for (CheckGroup checkGroup : checkGroupArry) {
					Check[] checks = checkGroup.getCheckArray();
					log.debug(" length 1 : " + checks.length); 
					log.debug(" GroupName : " + checkGroup.getGroupName()); 

					if (checkGroup.getGroupName().trim().equals("DOB Verifications")) { 
						log.debug(" length 2 : " + checkGroup.getGroupName()); 

						for (Check c : checks) {
							if ("FAIL".equals(c.getStatus().toString())) { 
								valid = false;
							}
						}
					}
				}
			}
		}
		return valid;
	}

	/**
	 * Instant Authenticate provides a high level of assurance that an
	 * individual is actually who he or she claims to be through the use of a
	 * knowledge-based quiz. LexisNexis generates a quiz with out-of-wallet
	 * information for the input individual. The quiz can be created from
	 * LexisNexis sources or from information that you provide.
	 * 
	 * @param user
	 * @return
	 * @throws Exception
	 */

	public IdentityProofingResponse quizRequest(PersonInformation user, String endPoint) throws RemoteException {

		StringBuilder builder = new StringBuilder();
		builder.append("quizRequest");
		builder.append(" , ");
		builder.append("firstName: ").append(user.getFirstName()).append(" middleName: ")  
				.append(user.getMiddleName());
		builder.append(" lastName: ").append(user.getLastName()).append(" suffixName: ")  
				.append(user.getSuffixName());

		builder.append(" , ");
		builder.append(" Referencecode: ").append(user.getTransactionid());
		log.info(builder.toString());

		log.debug(user.toString());

		InvokeIdentityServiceDocument serviceDocument = InvokeIdentityServiceDocument.Factory.newInstance();
		InvokeIdentityService identityService = serviceDocument.addNewInvokeIdentityService();

		IdentityProofingRequest request = identityService.addNewIdentityProofingRequest();
		request.setTransactionID(user.getTransactionid().trim());
		request.setLocale(LOCAL);
		request.setCustomerReference(user.getTransactionid().trim());
		request.setWorkFlow(user.getWorkFlow());
		InputSubject subject = request.addNewInputSubject();
		InputPerson person = subject.addNewPerson();
		InputName name = person.addNewName();
		name.setFirst(user.getFirstName());
		name.setLast(user.getLastName());
 
		String ssn = user.getSsn();
		if (ssn != null && !ssn.isEmpty()) {
			person.setSsn(ssn);
		}
		Date dateOfBirth = person.addNewDateOfBirth();
		dateOfBirth.setDay(user.getDateOfBirthDay());
		dateOfBirth.setMonth(user.getDateOfBirthMonth());
		dateOfBirth.setYear(user.getDateOfBirthYear());
		InputAddress address = person.addNewAddress();
		address.setAddressLine1(user.getAddressLine1());
		address.setAddressLine2(user.getAddressLine2());
		address.setCity(user.getCity());
		address.setStateCode(user.getStateCode());
		address.setZip5(user.getZip5());
		String licensetxt = user.getLicenseNumber();
		log.debug("License number : " + user.getLicenseNumber());
		log.debug("License State : " + user.getLicenseState());

		if (licensetxt != null && (!licensetxt.isEmpty())) {
			InputLicense license = person.addNewLicense();
			license.setType(LicenseType.DRIVERS_LICENSE);
			license.setLicenseNumber(user.getLicenseNumber());
			license.setIssuer(user.getLicenseState());
		}
		IdentityProofingServiceStub stub = new IdentityProofingServiceStub(endPoint);

		log.debug("quizRequest SOAP request " + serviceDocument.xmlText());

		InvokeIdentityServiceResponseDocument responseDocument = stub.invokeIdentityService(serviceDocument);
		log.debug("quizRequest SOAP response " + responseDocument.xmlText());

		InvokeIdentityServiceResponse responseService = responseDocument.getInvokeIdentityServiceResponse();
		IdentityProofingResponse response = responseService.getIdentityProofingResponse();
		builder.append(" , ");
		if (response != null) {
			builder.append("RESULT: ").append(response.getStatus());
		} else {
			builder.append("RESULT: ").append("response is null");
		}
		log.info(builder.toString()); 

		return response;

	}

	public IdentityProofingResponse scoreRequest(ScoreInformation score, String endPoint, PersonInformation user)
			throws RemoteException {

		StringBuilder builder = new StringBuilder();
		builder.append("scoreRequest");
		builder.append(" , ");
		builder.append("firstName: ").append(user.getFirstName()).append(" middleName: ")  
				.append(user.getMiddleName());
		builder.append(" lastName: ").append(user.getLastName()).append(" suffixName: ")  
				.append(user.getSuffixName());
	
		builder.append(" , ");
		builder.append(" Referencecode: ").append(user.getTransactionid());
		log.info(builder.toString());

		log.debug(score.toString());

		InvokeIdentityServiceDocument serviceDocument = InvokeIdentityServiceDocument.Factory.newInstance();
		InvokeIdentityService identityService = serviceDocument.addNewInvokeIdentityService();

		IdentityProofingRequest request = identityService.addNewIdentityProofingRequest();
		request.setTransactionID(score.getTransactionid().trim());
		request.setLocale(LOCAL);
		request.setCustomerReference(score.getReferencecode());
		request.setWorkFlow(score.getWorkFlow());
		IdentityScoreRequest subject = request.addNewScoreRequest();
		subject.setQuizId(score.getQuizId());
		IdentityQuizAnswer answer1 = subject.addNewAnswer();
		IdentityQuizAnswer answer2 = subject.addNewAnswer();
		IdentityQuizAnswer answer3 = subject.addNewAnswer();
		IdentityQuizAnswer answer4 = subject.addNewAnswer();

		String[] questions = score.getQuestionId();
		String[] choices = score.getChoiceId();

		log.debug("questions length :" + questions.length); 
		log.debug("choices length :" + choices.length); 

		answer1.setQuestionId(questions[0]);
		answer1.setChoiceId(choices[0]);

		answer2.setQuestionId(questions[1]);
		answer2.setChoiceId(choices[1]);

		answer3.setQuestionId(questions[2]);
		answer3.setChoiceId(choices[2]);

		answer4.setQuestionId(questions[3]);
		answer4.setChoiceId(choices[3]);

		IdentityProofingServiceStub stub = new IdentityProofingServiceStub(endPoint);

		log.info("scoreRequest SOAP request " + serviceDocument.xmlText()); 

		InvokeIdentityServiceResponseDocument responseDocument = stub.invokeIdentityService(serviceDocument);

		log.info("scoreRequest SOAP response " + responseDocument.xmlText()); 

		InvokeIdentityServiceResponse responseService = responseDocument.getInvokeIdentityServiceResponse();
		IdentityProofingResponse response = responseService.getIdentityProofingResponse();
		builder.append(" , ");
		if (response != null) {
			builder.append("RESULT: ").append(response.getStatus());
		} else {
			builder.append("RESULT: ").append("response is null");
		}
		log.info(builder.toString()); 

		return response;

	}

	public String getOutPutHtml(PersonInformation person, String lexisNexisSericeEndPoint) throws RemoteException {

		StringBuilder builder = new StringBuilder();
		person.setWorkFlow("FAA_B2B_AUTH_FLOW"); 
		IdentityProofingResponse response = null;
		try {
			response = quizRequest(person, lexisNexisSericeEndPoint);
		} catch (Exception e) {
			builder.append("<h2>"); 
			builder.append("Status: "); 
			builder.append("Service is not available at this time"); 
			builder.append("</h2>"); 
		}

		builder = getChoices(response);

		return builder.toString();
	}

	private StringBuilder getChoices(IdentityProofingResponse response) {

		StringBuilder builder = new StringBuilder();

		builder.append("<div>"); 
		if (response != null) {
			if ("PENDING".equalsIgnoreCase(response.getStatus())) { 

				ProductResponse[] prodResponseArry = response.getProductResponseArray();
				String transactionID = response.getTransactionID();
				InstantAuthenticateResponse pResp = (InstantAuthenticateResponse) prodResponseArry[0];
				Questions questions = pResp.getQuestions();

				builder.append("<input type=\"hidden\""); 
				builder.append(" id=\"quiz_transactionID"); 
				builder.append("\""); 
				builder.append(" name=\""); 
				builder.append("transactionID"); 

				builder.append("\" value=\""); 
				builder.append(transactionID);
				builder.append("\">"); 

				String quizId = questions.getQuizId();
				Question[] questionsArry = questions.getQuestionArray();

				builder.append("<input type=\"hidden\""); 
				builder.append(" id=\"quiz_"); 
				builder.append("quiz_Id" + quizId); 
				builder.append("\""); 
				builder.append(" name=\""); 
				builder.append("quiz_Id" + quizId); 

				builder.append("\" value=\""); 
				builder.append(quizId);
				builder.append("\">"); 
				int i = 1;
				for (Question question : questionsArry) {
					builder.append("<div>"); 
					builder.append("<div class=\"Row\">"); 
					builder.append("<label for=\""); 
					builder.append("quiz_quiz_qaId_" + i + "_" + question.getQuestionId());  
					builder.append("\""); 
					builder.append(">"); 
					builder.append(question.getText());
					builder.append("</label>"); 
					builder.append("</div>"); 
					builder.append("<div class=\"Row\">"); 
					builder.append("<select id=\"quiz_"); 
					builder.append("quiz_qaId_" + i + "_" + question.getQuestionId());  
					builder.append("\""); 
					builder.append(" name=\""); 
					builder.append("quiz_qaId_" + i + "_" + question.getQuestionId());  

					builder.append("\" style=\"width: 400px;\">"); 
					builder.append("<option value=\"CC\">Select Choice</option>"); 
					Choice[] choices = question.getChoiceArray();

					for (Choice c : choices) {
						builder.append("<option value="); 
						builder.append("\""); 
						builder.append(c.getChoiceId());
						builder.append("\""); 
						builder.append(">"); 
						builder.append(c.getText());
						builder.append("</option>"); 
					}

					builder.append("</select>"); 
					builder.append("</div>"); 
					builder.append("<div class=\"RowSpan\">"); 
					builder.append("<span class=\"error\">This field is required</span>"); 
					builder.append("</div>"); 
					builder.append("</div>"); 
					i++;
				}
			} else {
				builder.append("<h2>"); 
				builder.append("Status: "); 
				builder.append(response.getStatus());
				builder.append("</h2>"); 
			}
		} else {
			builder.append("<h2>"); 
			builder.append("Status: "); 
			builder.append("Service is not available at this time"); 
			builder.append("</h2>"); 
		}
		builder.append("</div>"); 
		return builder;

	}

	/**
	 * The Credit Card Account Verification (CCAV) service allows user to verify
	 * credit card account ownership. Organization can choose to submit the
	 * first 5 through 12 digits of the account number or the last 5 through 12
	 * digits of the account number.
	 * 
	 * @param user
	 * @return
	 * @throws RemoteException
	 * @throws Exception
	 */

	public String ccavRequest(PersonInformation user, String endPoint) throws RemoteException {

		if (log.isDebugEnabled()) {
			log.debug(user.toString());
		} else if (log.isInfoEnabled()) {
			StringBuilder builder = new StringBuilder();
			builder.append(" firstName: ").append(user.getFirstName()).append(" middleName: ")  
					.append(user.getMiddleName());
			builder.append(" lastName: ").append(user.getLastName()).append(" suffixName: ")  
					.append(user.getSuffixName());
			log.info(builder.toString());
		}
		InvokeIdentityServiceDocument serviceDocument = InvokeIdentityServiceDocument.Factory.newInstance();
		InvokeIdentityService identityService = serviceDocument.addNewInvokeIdentityService();

		IdentityProofingRequest request = identityService.addNewIdentityProofingRequest();
		request.setTransactionID(user.getTransactionid().trim());
		request.setLocale(LOCAL);
		request.setCustomerReference(user.getTransactionid().trim());
		request.setWorkFlow(user.getWorkFlow());
		InputSubject subject = request.addNewInputSubject();
		InputPerson person = subject.addNewPerson();
		InputName name = person.addNewName();
		name.setFirst(user.getFirstName());
		name.setLast(user.getLastName());

		InputAddress address = person.addNewAddress();
		address.setAddressPurpose(AddressPurposeType.PRIMARY_RESIDENCE);

		String addressLine1 = user.getAddressLine1();

		if (addressLine1 != null && !addressLine1.isEmpty()) {
			address.setAddressLine1(addressLine1);
		}

		String addressLine2 = user.getAddressLine2();

		if (addressLine2 != null && !addressLine2.isEmpty()) {
			address.setAddressLine2(addressLine2);
		}

		String city = user.getCity();

		if (city != null && !city.isEmpty()) {
			address.setCity(city);

		}

		String state = user.getStateCode();

		if (state != null && !state.isEmpty()) {
			address.setStateCode(state);
		}

		String zip = user.getZip5();

		if (zip != null && !zip.isEmpty()) {
			address.setZip5(zip);
		}
		InputAccounts accounts = person.addNewAccounts();
		InputAccount account = accounts.addNewInputAccount();
		log.info("AccountType CREDIT"); 
		account.setType(AccountType.CREDIT);
		account.setAccountNumber(user.getAccountNumber());
		IdentityProofingServiceStub stub = new IdentityProofingServiceStub(endPoint);

		InvokeIdentityServiceResponseDocument responseDocument = stub.invokeIdentityService(serviceDocument);

		InvokeIdentityServiceResponse responseService = responseDocument.getInvokeIdentityServiceResponse();
		IdentityProofingResponse response = responseService.getIdentityProofingResponse();

		if (response != null) {
			log.info("Response Workflow: " + response.getWorkFlow()); 
			log.info("Response status: " + response.getStatus()); 
		}

		return response.getStatus();

	}


	public boolean validateCCAV(PersonInformation person, String lexisNexisSericeEndPoint) throws Exception {

		person.setWorkFlow("FAA_B2B_CCAV_VERIF"); 
		LexisNexisService service = new LexisNexisServiceImpl();

		String status = service.ccavRequest(person, lexisNexisSericeEndPoint);

		if ("PASS".equalsIgnoreCase(status)) { 
			return true;
		} else {
			return false;
		}
	}

	/**
	 * LexisNexis Service class provide APIs to call LexisNexis using various
	 * work flow types.
	 * 
	 * @param jksFile
	 * @param trustStorePassword
	 */

	public LexisNexisServiceImpl(String jksFile, String trustStorePassword) {

	
		props.setProperty("javax.net.ssl.trustStore", jksFile); 
		props.setProperty("javax.net.ssl.keyStore", jksFile); 
		props.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword); 
		props.setProperty("javax.net.ssl.trustStoreType", "JKS");  

		System.setProperties(props);

	}

	/**
	 * LexisNexis Service class provide APIs to call LexisNexis using various
	 * work flow types.
	 */

	public LexisNexisServiceImpl() {
		log.debug(" LexisNexisService instance created"); 
	}

}