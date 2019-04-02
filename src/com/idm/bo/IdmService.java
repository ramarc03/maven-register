package com.idm.bo;

import java.rmi.RemoteException;

import tews6.wsdl.ImsStatusDocument;

import com.idm.EXTWSCreateUserFaultMessage;
import com.idm.model.IdmUserInformation;

public interface IdmService {
	
	public String extwsCreateUser(IdmUserInformation user, String endPoint) throws RemoteException, EXTWSCreateUserFaultMessage;

}
