package com.register.util;

import org.apache.commons.lang.StringEscapeUtils;


public class TestXSS {
	
	/**
	 * @param args  
	 */
	public static void mail(String[] args){
		String input  = "Select * from table"; //$NON-NLS-1$
		System.out.println(StringEscapeUtils.escapeJava(input));
	}

}
