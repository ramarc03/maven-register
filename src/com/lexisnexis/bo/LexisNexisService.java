package com.lexisnexis.bo;

import java.rmi.RemoteException;

import com.lexisnexis.model.PersonInformation;
import com.lexisnexis.model.ScoreInformation;
import com.lexisnexis.ns.identity_proofing._1_0.IdentityProofingResponse;

/**
 * 
 * @author Gangadhar CTR Gouri
 *
 */

public interface LexisNexisService {

	/**
	 * The Credit Card Account Verification (CCAV) service allows user to verify
	 * credit card account ownership. Organization can choose to submit the
	 * first 5 through 12 digits of the account number or the last 5 through 12
	 * digits of the account number.
	 * 
	 * @param user
	 * @return Status of call - PASS or FAIL
	 * @throws RemoteException
	 */
	public String ccavRequest(PersonInformation user, String endPoint) throws RemoteException;

	/**
	 * Instant Authenticate provides a high level of assurance that an
	 * individual is actually who he or she claims to be through the use of a
	 * knowledge-based quiz. LexisNexis generates a quiz with out-of-wallet
	 * information for the input individual. The quiz can be created from
	 * LexisNexis sources or from information that you provide.
	 * 
	 * @param user
	 * @return Status of call - PASS or FAIL
	 * @throws RemoteException
	 */
	public IdentityProofingResponse quizRequest(PersonInformation user, String endPoint) throws RemoteException;


	public String validatePersonalInformation(PersonInformation person, String lexisNexisSericeEndPoint, String workFlow);
			 
	public IdentityProofingResponse verificationRequest(PersonInformation user, String endPoint) throws RemoteException;
	
	public IdentityProofingResponse scoreRequest(ScoreInformation score, String endPoint, PersonInformation user) throws RemoteException ;

	public String getOutPutHtml(PersonInformation person, String lexisNexisSericeEndPoint) throws RemoteException ;
}