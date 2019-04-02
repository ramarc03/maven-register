package com.register.otp.bo.impl;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;

import com.lexisnexis.model.PersonInformation;
import com.register.otp.bo.OTPService;
import com.seisint.webservices.wsmfa.Address;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneBy;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneOptions;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneRequestDocument;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneResponse;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneResponseExDocument;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneResponseStatus;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneResult;
import com.seisint.webservices.wsmfa.Name;
import com.seisint.webservices.wsmfa.PhoneFinderSearchType;
import com.seisint.webservices.wsmfa.VerifyOTPOnceBy;
import com.seisint.webservices.wsmfa.VerifyOTPOnceItem;
import com.seisint.webservices.wsmfa.VerifyOTPOnceRequestDocument;
import com.seisint.webservices.wsmfa.VerifyOTPOnceResponseDocument;
import com.seisint.webservices.wsmfa.WsMFAStub;
import com.seisint.webservices.wsmfa.GenOTPOnceFor;
import com.seisint.webservices.wsmfa.GenOTPOnceOption;
import com.seisint.webservices.wsmfa.GenerateOTPOnceRequestDocument;
import com.seisint.webservices.wsmfa.GenerateOTPOnceRequestDocument.GenerateOTPOnceRequest;
import com.seisint.webservices.wsmfa.GenerateOTPOnceResponseDocument;
import com.seisint.webservices.wsmfa.GenerateOTPOnceResponseDocument.GenerateOTPOnceResponse;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneRequestDocument.MFAVerifyPhoneRequest;
import com.seisint.webservices.wsmfa.MFAVerifyPhoneResponseExDocument.MFAVerifyPhoneResponseEx;
import com.seisint.webservices.wsmfa.VerifyOTPOnceBy.OTPs;
import com.seisint.webservices.wsmfa.VerifyOTPOnceRequestDocument.VerifyOTPOnceRequest;
import com.seisint.webservices.wsmfa.VerifyOTPOnceResponseDocument.VerifyOTPOnceResponse;
import com.seisint.webservices.wsmfa.LanguageISOCodes;
import com.seisint.webservices.wsmfa.User;

/**
 * 
 * @author SY
 * https://soadev.smext.faa.gov/WsMFA/verifyphone?wsdl - used to generate stubs and XMLbeans  - lib/otp.jar.
 *
 */

public class OTPServiceImpl implements OTPService {

	private static Logger log = Logger
			.getLogger(OTPServiceImpl.class.getName());

	/**
	 * Service class provide APIs to call OTP services using
	 * various work flow types.
	 */

	/**
	 * 
	 * @param user
	 * @return
	 * @throws RemoteException
	 * @throws EspSoapFault
	 * @throws Exception
	 */

	public String generateOTP(PersonInformation personalinformation, String phoneNumber,String deliveryType, String accountNumber, String endPoint)
			throws Exception {
		
		StringBuilder builder = new StringBuilder();
		builder.append("generateOTP");
		builder.append(" , ");
		builder.append("firstName: ").append(personalinformation.getFirstName()).append(" middleName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getMiddleName());
		builder.append(" lastName: ").append(personalinformation.getLastName()).append(" suffixName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getSuffixName());
		//builder.append(" , ");
		//builder.append(" emaild: ").append(personalinformation.getEmail());
		builder.append(" , ");
		builder.append(" Referencecode: ").append(personalinformation.getTransactionid());
		log.info(builder.toString());
		
		try {
			GenerateOTPOnceRequestDocument requestDoc = GenerateOTPOnceRequestDocument.Factory
					.newInstance();
			GenerateOTPOnceRequest request = requestDoc
					.addNewGenerateOTPOnceRequest();
			User user = request.addNewUser();
			user.setReferenceCode(personalinformation.getReferencecode());
			user.setAccountNumber(accountNumber);
			GenOTPOnceOption options = request.addNewOptions();
			if(deliveryType!=null && deliveryType.trim().length()>0){
				if("LAND".equals(deliveryType)){ //$NON-NLS-1$
					options.setDeliveryMethod(com.seisint.webservices.wsmfa.OTPDeliveryMethod.H);
				}else if("MOBILE".equals(deliveryType)){ //$NON-NLS-1$
					options.setDeliveryMethod(com.seisint.webservices.wsmfa.OTPDeliveryMethod.T);
				}
			}		
			options.setOTPLength(5);
			options.setExpireInMinutes(10);
			short allowed = 1;
			options.setUsesAllowed(allowed);
			options.setDeliveryLanguage(LanguageISOCodes.EN);
			GenOTPOnceFor optFor = request.addNewOTPFor();
			optFor.setPhoneNumber(phoneNumber);
			WsMFAStub sub = new WsMFAStub(endPoint);
			log.debug(" request : " + requestDoc.xmlText());
			GenerateOTPOnceResponseDocument responseDocument = sub
					.generateOTPOnce(requestDoc);
			GenerateOTPOnceResponse response = responseDocument
					.getGenerateOTPOnceResponse();
			log.debug(" response : " + response.xmlText());
			builder.append(" , ");
			if(response!=null){
				builder.append("RESULT:PASS");
			}else{
					if(phoneNumber!=null && phoneNumber.length()>7){
						builder.append("RESULT:FAIL");
					}				
			}
			log.info(builder.toString());
			
			return response.getSessionId();
		} catch (Exception e) {
			log.error( builder.toString() + " - RESULT: Exception " +" Error Message : " + e.getMessage());	 
			return null;
		}

	}

	public boolean verifyPhone(PersonInformation personalinformation, String accountNumber, String endPoint) throws Exception {

		StringBuilder builder = new StringBuilder();
		builder.append("verifyPhone");
		builder.append(" , ");
		builder.append("firstName: ").append(personalinformation.getFirstName()).append(" middleName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getMiddleName());
		builder.append(" lastName: ").append(personalinformation.getLastName()).append(" suffixName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getSuffixName());
		//builder.append(" , ");
		//builder.append(" emaild: ").append(personalinformation.getEmail());
		builder.append(" , ");
		builder.append(" Referencecode: ").append(personalinformation.getTransactionid());
		log.info(builder.toString());
		
		boolean valid = false;
		try {
			
			MFAVerifyPhoneRequestDocument serviceDocument = MFAVerifyPhoneRequestDocument.Factory
					.newInstance();
			MFAVerifyPhoneRequest verifyPhoneRequest = serviceDocument.addNewMFAVerifyPhoneRequest();
			User user = verifyPhoneRequest.addNewUser();
			user.setReferenceCode(personalinformation.getReferencecode());
			user.setAccountNumber(accountNumber);
			user.setGLBPurpose("5");
			user.setDLPurpose("1");
			MFAVerifyPhoneBy  verifyPhoneBy = verifyPhoneRequest.addNewSearchBy();
			Name  name = verifyPhoneBy.addNewName();
			name.setFirst(personalinformation.getFirstName());
			name.setLast(personalinformation.getLastName());
			//String midName = personalinformation.getMiddleName();
			//if(midName != null && !midName.isEmpty()){
			//	name.setMiddle(personalinformation.getMiddleName());
			//}
			//String suffixName = personalinformation.getSuffixName();
			//if(suffixName != null && !suffixName.isEmpty()){
			//	name.setSuffix(personalinformation.getSuffixName());
			//}
			Address address = verifyPhoneBy.addNewAddress();
			address.setStreetAddress1(personalinformation.getAddressLine1());
			address.setStreetAddress2(personalinformation.getAddressLine2());
			address.setCity(personalinformation.getCity());
			address.setState(personalinformation.getStateCode());
			address.setZip5(personalinformation.getZip5());
			verifyPhoneBy.setPhoneNumber(personalinformation.getHnumber());
			MFAVerifyPhoneOptions options = verifyPhoneRequest.addNewOptions();
			options.setIncludePhoneType(true);
			options.setSearchType(PhoneFinderSearchType.ULTIMATE);
			WsMFAStub sub = new WsMFAStub(endPoint);
			log.debug(" request : " + serviceDocument.xmlText());

			MFAVerifyPhoneResponseExDocument phoneResponseExDocument = sub.verifyPhone(serviceDocument);
			log.debug(" response : " + phoneResponseExDocument.xmlText());

			builder.append(" , ");
			if(phoneResponseExDocument == null){				
				builder.append("RESULT:FAIL");	 
				return valid;
			}
			MFAVerifyPhoneResponseEx responseEx = phoneResponseExDocument.getMFAVerifyPhoneResponseEx();
			if(responseEx == null){
				builder.append("RESULT:FAIL");	 
				return valid;
			}
			MFAVerifyPhoneResponse response = responseEx.getResponse();
			if(response == null){
				builder.append("RESULT:FAIL");	 
				return valid;
			}
			MFAVerifyPhoneResult result = response.getResult();
			if(result == null){
				builder.append("RESULT:FAIL"); 
				return valid;
			}
			MFAVerifyPhoneResponseStatus phoneResponseStatus = result.getVerificationStatus();
			if(phoneResponseStatus == null){
				builder.append("RESULT:FAIL");
				return valid;
			}
			if(phoneResponseStatus!=null){
				if(phoneResponseStatus.getPhoneVerified()){
					builder.append("RESULT:PASS");

				}else{
					builder.append("RESULT:FAIL");
				}
			}
			
			valid = phoneResponseStatus.getPhoneVerified();
			log.info(builder.toString());
		}catch(Exception e){
			log.error( builder.toString() + " - RESULT: Exception " +" Error Message : " + e.getMessage());	 
		}
		return valid;

	}
	
	
	public boolean verifyOTPOnce(PersonInformation personalinformation, String otp, String accountNumber, String endPoint) throws Exception {
		boolean valid = false;
		StringBuilder builder = new StringBuilder();
		builder.append("verifyOTPOnce");
		builder.append(" , ");
		builder.append("firstName: ").append(personalinformation.getFirstName()).append(" middleName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getMiddleName());
		builder.append(" lastName: ").append(personalinformation.getLastName()).append(" suffixName: ") //$NON-NLS-1$ //$NON-NLS-2$
		.append(personalinformation.getSuffixName());
		//builder.append(" , ");
		//builder.append(" emaild: ").append(personalinformation.getEmail());
		builder.append(" , ");
		builder.append(" Referencecode: ").append(personalinformation.getTransactionid());
		log.info(builder.toString());
		try {
			VerifyOTPOnceRequestDocument requestDoc = VerifyOTPOnceRequestDocument.Factory.newInstance();
			VerifyOTPOnceRequest request = requestDoc.addNewVerifyOTPOnceRequest();
			User user = request.addNewUser();
			user.setReferenceCode(personalinformation.getReferencecode());
			user.setAccountNumber(accountNumber);
			VerifyOTPOnceBy verifyBy = request.addNewVerifyBy();
			OTPs opts = verifyBy.addNewOTPs();
			VerifyOTPOnceItem iteam = opts.addNewItem();
			iteam.setSessionId(personalinformation.getOtpsession());
			iteam.setOTP(otp);
			
			WsMFAStub sub = new WsMFAStub(endPoint);

			VerifyOTPOnceResponseDocument responseDocument = sub.verifyOTPOnce(requestDoc);
			VerifyOTPOnceResponse response = responseDocument.getVerifyOTPOnceResponse();
			builder.append(" , ");
			if((response.getSuccess()) && ("OTP is valid".equalsIgnoreCase(response.getMessage()))){ //$NON-NLS-1$
				valid = true;
				builder.append("RESULT:PASS");	 
			}else{
				builder.append("RESULT:FAIL");
			}
			log.info(builder.toString());

		}catch(Exception e){
			
			log.error( builder.toString() + " - RESULT: Exception " +" Error Message : " + e.getMessage());	 
		}
		return valid;
	}
}