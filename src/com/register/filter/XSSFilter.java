package com.register.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Servlet Filter implementation class XSSFilter
 */
public class XSSFilter implements Filter {
	private static Logger log = Logger
			.getLogger(XSSFilter.class.getName());
	
	FilterConfig filterConfig = null;
    /**
     * Default constructor. 
     */
    public XSSFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		//need to implement
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		res.setContentType("text/html"); //$NON-NLS-1$
		res.setCharacterEncoding("UTF-8"); //$NON-NLS-1$
		//Specify the mode
		res.addHeader("X-Frame-Options", "SAMEORIGIN"); //$NON-NLS-1$ //$NON-NLS-2$
		try{
			chain.doFilter(new XSSRequestWrapper(req), res);
		}catch(Exception e){
			String refererURL=req.getHeader("referer"); //$NON-NLS-1$
			log.error(" SERVER ERROR: "+ e.getMessage()); //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
			String redirectURL="personalinformation.jsp";//?status=ERROR"); //$NON-NLS-1$
		//	String key_message ="PROCESSERROR"; //$NON-NLS-1$
		//	req.getSession().setAttribute("CODE",key_message); //$NON-NLS-1$
			res.sendRedirect(redirectURL);
			//TEST ZONE
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.filterConfig = fConfig;
	}

}
