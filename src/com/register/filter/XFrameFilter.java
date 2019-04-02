package com.register.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Servlet Filter implementation class XFrameFilter
 * To handle the Cross-Frame Scripting issues - X-FRAME-OPTIONS header is set to DENY
 */
public class XFrameFilter implements Filter {

	FilterConfig filterConfig = null;
    /**
     * Default constructor. 
     */
    public XFrameFilter() {
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
		
//		HttpServletResponse res = (HttpServletResponse)response;
//		if(res.getStatus()==500){
//			System.out.println("RESP Status: "+res.getStatus());
//			res.setStatus(200);	
//		}	
//		res.setContentType("text/html");
//		//Specify the mode
//		res.addHeader("X-Frame-Options", "DENY");   	

		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.filterConfig = fConfig;
	}

}
