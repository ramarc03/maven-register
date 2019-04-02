package com.register.frontend.util;

public class CustomXssInputValidator
{
  private static String badCharStr = "<>&"; //$NON-NLS-1$
  
  public String getBadCharStr()
  {
    return badCharStr;
  }
  
  public void setBadCharStr(String inputBadCharStr)
  {
    badCharStr = inputBadCharStr;
  }
  
  public static boolean containsInvalidChars(String inputStr)
  {
    boolean ret = false;
    if ((inputStr == null) || (inputStr.length() == 0)) {
      return ret;
    }
    char[] arr1 = inputStr.toCharArray();
    
    int arrlen = arr1.length;
    int i = 0;
    int j = 0;
    for (i = 0; i < arrlen; i++)
    {
      j = badCharStr.indexOf(arr1[i]);
      if (j >= 0)
      {
        ret = true;
        return ret;
      }
    }
    return ret;
  }
  
  public static boolean containsInvalidChars(String inputStr, String inputBadCharStr)
  {
    boolean ret = false;
    if ((inputStr == null) || (inputStr.length() == 0)) {
      return ret;
    }
    char[] arr1 = inputStr.toCharArray();
    
    int arrlen = arr1.length;
    int i = 0;
    int j = 0;
    for (i = 0; i < arrlen; i++)
    {
      j = inputBadCharStr.indexOf(arr1[i]);
      if (j >= 0)
      {
        ret = true;
        return ret;
      }
    }
    return ret;
  }
  
  public static boolean containsInvalidChars(String[] inputStrs)
  {
    for (int i = 0; (inputStrs != null) && (i < inputStrs.length); i++) {
      if (containsInvalidChars(inputStrs[i])) {
        return true;
      }
    }
    return false;
  }
}
