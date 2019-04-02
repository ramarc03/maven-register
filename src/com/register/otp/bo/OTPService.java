package com.register.otp.bo;

import java.rmi.RemoteException;

import com.lexisnexis.model.PersonInformation;


/**
 * 
 * @author SY
 *
 */

public interface OTPService {
	
	
	/**
	 * To verify phone need to pass user personal information.
	 * @param user
	 * @return
	 * @throws RemoteException
	 */
	public boolean verifyPhone(PersonInformation personalinformation, String accountNumber, String endPoint) throws Exception;
	
	/**
	 * Method to Generate OTP.
	 * @param user
	 * @return
	 * @throws RemoteException
	 */
	public String generateOTP(PersonInformation personalinformation, String phoneNumber,String deliveryType, String accountNumber, String endPoint) throws Exception;

	/**
	 * Method to verify OTP.
	 * @param user
	 * @return
	 * @throws Exception 
	 * @throws RemoteException
	 */
	boolean verifyOTPOnce(PersonInformation personalinformation, String otp, String accountNumber, String endPoint) throws Exception;
}