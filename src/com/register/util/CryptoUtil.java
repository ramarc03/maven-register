package com.register.util;


import javax.xml.bind.DatatypeConverter;



public class CryptoUtil 
{

  	public static String encode(String encryptedData) throws Exception {
	byte[] message = encryptedData.getBytes("UTF-8");
	String encoded = DatatypeConverter.printBase64Binary(message);
	return encoded;
	}
  	
  	public static String decode(String encryptedData) throws Exception {
  	
  	    String decoded = new String(DatatypeConverter.parseBase64Binary(encryptedData));
  		return decoded;
  		}

}