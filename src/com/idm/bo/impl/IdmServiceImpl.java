package com.idm.bo.impl;

import java.rmi.RemoteException;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.idm.EXTWSCreateUserFaultMessage;
import com.idm.Tews6Stub;
import com.idm.bo.IdmService;
import com.idm.model.IdmUserInformation;

import tews6.wsdl.EXTWSCreateUserDocument;
import tews6.wsdl.EXTWSCreateUserDocument.EXTWSCreateUser;
import tews6.wsdl.EXTWSCreateUserProfileTabDocument.EXTWSCreateUserProfileTab;
import tews6.wsdl.EXTWSCreateUserTaskContextDocument;
import tews6.wsdl.EXTWSCreateUserTaskContextDocument.EXTWSCreateUserTaskContext;
import tews6.wsdl.ImsExceptionDocument.ImsException;
import tews6.wsdl.ImsStatusDocument;


public class IdmServiceImpl implements IdmService {

	private static Logger log = Logger.getLogger(IdmServiceImpl.class.getName());
	final Properties props = System.getProperties();

	public IdmServiceImpl(String jksFile, String trustStorePassword) {

	

		props.setProperty("javax.net.ssl.trustStore", jksFile);
		props.setProperty("javax.net.ssl.keyStore", jksFile);
		props.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
		props.setProperty("javax.net.ssl.trustStoreType", "JKS");

		System.setProperties(props);

	}

	public IdmServiceImpl() {
		log.debug(" LexisNexisService instance created");
	}

	public String extwsCreateUser(IdmUserInformation user, String endPoint) throws RemoteException {
		StringBuilder builder = new StringBuilder();
		builder.append("crateAccountInIDM");
		builder.append(" , ");
		builder.append("firstName: ").append(user.getFirstName()).append(" middleName: ") //$NON-NLS-1$ //$NON-NLS-2$
				.append(user.getMiddleName());
		builder.append(" lastName: ").append(user.getLastName()).append(" suffixName: ") //$NON-NLS-1$ //$NON-NLS-2$
				.append(user.getSuffixName());
		//builder.append(" , ");
		//builder.append(" emailid: ").append(user.getEmail());
		//builder.append(" , ");
		//builder.append(" LexID: ").append(user.getLexID());
		builder.append(" , ");
		builder.append(" Referencecode: "  + user.getReferencecode() );
		log.info(builder.toString());
		builder.append(" , ");

		EXTWSCreateUserDocument createUserDocument = EXTWSCreateUserDocument.Factory.newInstance();
		EXTWSCreateUser createUser = createUserDocument.addNewEXTWSCreateUser();
		EXTWSCreateUserProfileTab createUserProfileTab = createUser.addNewEXTWSCreateUserProfileTab();
		createUserProfileTab.setPCTFIRSTNAMEPCT(user.getFirstName());
		createUserProfileTab.setPCTLASTNAMEPCT(user.getLastName());

		String middleName = user.getMiddleName();
		if (middleName != null && !middleName.isEmpty()) {
			createUserProfileTab.setMiddleName(middleName);
		}
		String suffixName = user.getSuffixName();
		if (suffixName != null && !suffixName.isEmpty()) {
			createUserProfileTab.setNameSuffix(suffixName);
		}

		String fax = user.getFax();
		if (fax != null && !fax.isEmpty()) {
			createUserProfileTab.setFacsimileTelephoneNumber(fax);
		}

		String departmentNumber = user.getDepartmentNumber();
		if (departmentNumber != null && !departmentNumber.isEmpty()) {
			createUserProfileTab.setDepartmentNumber(departmentNumber);
		}
		String companyName = user.getComanyName();
		if (companyName != null && !companyName.isEmpty()) {
			createUserProfileTab.setPCTCOMPANYPCT(companyName);
		}

		String roomNumber = user.getRoomNumber();
		if (roomNumber != null && !roomNumber.isEmpty()) {
			createUserProfileTab.setRoomNumber(roomNumber);
		}
		createUserProfileTab.setPostalAddress(user.getAddressLine1());

		String adress2 = user.getAddressLine2();
		if (adress2 != null && !adress2.isEmpty()) {
			createUserProfileTab.setPostalAddress2(adress2);
		}
		createUserProfileTab.setPostalCode(user.getZip5());
		createUserProfileTab.setL(user.getCity());
		createUserProfileTab.setSt(user.getStateCode());
		;
		createUserProfileTab.setTitle(user.getTitle());
		createUserProfileTab.setPCTEMAILPCT(user.getEmail());
		createUserProfileTab.setMobile(user.getMobile());
		createUserProfileTab.setTelephoneNumber(user.getTelephoneNumber());
		createUserProfileTab.setIDentityProviderID(user.getLexID());

		EXTWSCreateUserTaskContextDocument createUserTaskContextDocument = EXTWSCreateUserTaskContextDocument.Factory
				.newInstance();
		EXTWSCreateUserTaskContext createUserTaskContext = createUserTaskContextDocument
				.addNewEXTWSCreateUserTaskContext();

		Tews6Stub stub = new Tews6Stub(endPoint);

		ImsStatusDocument statusDocuemnt = null;
		try {

			log.debug("request : " + createUserDocument.xmlText());

			statusDocuemnt = stub.eXTWSCreateUser(createUserDocument, createUserTaskContextDocument);
			if (statusDocuemnt != null) {
				log.debug("response : " + statusDocuemnt.xmlText());

				if (statusDocuemnt.getImsStatus().getTransactionId() != null) {
					builder.append("RESULT: ").append("PASS");

					return "SUCCESS";
				} else {
					builder.append("RESULT: ").append("FAIL");

					return "FAILED_ID";
				}
			} else {
				builder.append("RESULT: ").append("response is null");
				return "FAILED_NULL";
			}
		} catch (EXTWSCreateUserFaultMessage e) {
			ImsException iException = e.getFaultMessage().getImsException();
			if (e.getFaultMessage().getImsException() != null) {
				tews6.wsdl.ImsExceptionDocument.ImsException.Exception imsEX = iException.getExceptionArray(0);
				String code = imsEX.getCode();
				String description = imsEX.getDescription();
				if (("500".equals(code.trim())) && (description.contains("IdentityProviderID"))) {
					int index = description.indexOf("\"");
					int linsedx = description.lastIndexOf("\"");
					String email = description.substring(index + 1, linsedx);
					builder.append("RESULT: ").append("FAILED_LEXID_NOTUNIQUE");
					return "FAILED_LEXID_NOTUNIQUE_" + email;
				} else {
					builder.append("RESULT: ").append("FAILED_DUPLICATE");

					return "FAILED_DUPLICATE";
				}

			}
			builder.append("RESULT: ").append("FAILED_UNKNOWN");

			return "FAILED_UNKNOWN";
		} catch (Exception ex) {
			builder.append("RESULT: ").append("FAILED_UNKNOWN");

			return "FAILED_UNKNOWN";
		} finally {
			log.info(builder.toString()); // $NON-NLS-1$
		}
	}

}
