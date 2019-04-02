package com.register.filter;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.owasp.esapi.ESAPI;
 
public class XSSRequestWrapper extends HttpServletRequestWrapper {
 

    public static final String SQL_TYPES =
            "TABLE, TABLESPACE, PROCEDURE, FUNCTION, TRIGGER, KEY, VIEW, MATERIALIZED VIEW, LIBRARY" + //$NON-NLS-1$
            "DATABASE LINK, DBLINK, INDEX, CONSTRAINT, TRIGGER, USER, SCHEMA, DATABASE, PLUGGABLE DATABASE, BUCKET, " + //$NON-NLS-1$
            "CLUSTER, COMMENT, SYNONYM, TYPE, JAVA, SESSION, ROLE, PACKAGE, PACKAGE BODY, OPERATOR" + //$NON-NLS-1$
            "SEQUENCE, RESTORE POINT, PFILE, CLASS, CURSOR, OBJECT, RULE, USER, DATASET, DATASTORE, " + //$NON-NLS-1$
            "COLUMN, FIELD, OPERATOR"; //$NON-NLS-1$
    
    public XSSRequestWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }
    @Override
    public String[] getParameterValues(String parameter) {
        String[] values = super.getParameterValues(parameter);
        if (values == null) {
            return null;
        }
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = stripXSS(values[i]);
        }
        return encodedValues;
    }
 
    @Override
    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);

        return stripXSS(value);
    }

    @Override
    public String getHeader(String name) {
        String value = super.getHeader(name);
       return stripXSS(value);
    }

    private String stripXSS(String value) {

        if (value != null) {
            value = ESAPI.encoder().canonicalize(value);
            // Avoid null characters
            value = value.replaceAll("", ""); //$NON-NLS-1$ //$NON-NLS-2$
            //value = value.replaceAll("null", "");
            // Avoid anything between script tags
            Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            
            scriptPattern = Pattern.compile("<img>(.*?)</img>", Pattern.CASE_INSENSITIVE); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            
            // Avoid anything in a src='...' type of expression
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Remove any lonesome </script> tag
            scriptPattern = Pattern.compile("</script>", Pattern.CASE_INSENSITIVE); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Remove any lonesome <script ...> tag
            scriptPattern = Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            scriptPattern = Pattern.compile("<img(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Avoid eval(...) expressions
            scriptPattern = Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Avoid expression(...) expressions
            scriptPattern = Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Avoid javascript:... expressions
            scriptPattern = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
           // Avoid vbscript:... expressions
            scriptPattern = Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            // Avoid onload= expressions
            scriptPattern = Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL); //$NON-NLS-1$
            value = scriptPattern.matcher(value).replaceAll(""); //$NON-NLS-1$
            
    		value = value.replaceAll("(?i)<script.*?>.*?<script.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)<script.*?>.*?</script.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)<.*?javascript:.*?>.*?</.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)<.*?\\s+on.*?>.*?</.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("<script>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("</script>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)<.*?>.*?<.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)<.*?>", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		
    		value = value.replaceAll("<", "").replaceAll(">", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
    		value = value.replaceAll("\\(", "").replaceAll("\\)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
    		//value = value.replaceAll("'", "");
    		value = value.replaceAll("eval\\((.*)\\)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("window\\.location", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("window\\.parent", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("parent\\.document", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("document\\.location", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("top\\.location", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("self\\.location", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+SELECT(\\b)+\\s.*(\\b)+FROM(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+INSERT(\\b)+\\s.*(\\b)+INTO(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+UPDATE(\\b)+\\s.*(.*)",""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+DELETE(\\b)+\\s.*(\\b)+FROM(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+UPSERT(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+SAVEPOINT(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+CALL(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+ROLLBACK(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+KILL(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+DROP(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+CREATE(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+ALTER(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+TRUNCATE(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+LOCK(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+UNLOCK(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+RELEASE(\\b)+(\\s)*(" + SQL_TYPES.replaceAll(",", "|") + ")(\\b)+\\s.*(.*)", ""); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$ //$NON-NLS-5$
    		value = value.replaceAll("(?i)(.*)(\\b)+DESC(\\b)+(\\w)*\\s.*(.*)",""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(?i)(.*)(\\b)+DESCRIBE(\\b)+(\\w)*\\s.*(.*)",""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(.*)(/\\*|\\*/|;){1,}(.*)",""); //$NON-NLS-1$ //$NON-NLS-2$
    		value = value.replaceAll("(.*)(-){2,}(.*)",""); //$NON-NLS-1$ //$NON-NLS-2$
        }
        return value;
    }
    
    public String escapeHTML(String s) {
        StringBuilder out = new StringBuilder(Math.max(16, s.length()));
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c > 127 || c == '"' || c == '<' || c == '>' || c == '&') {
                out.append("&#"); //$NON-NLS-1$
                out.append((int) c);
                out.append(';');
            } else {
                out.append(c);
            }
        }
        return out.toString();
    }
}

