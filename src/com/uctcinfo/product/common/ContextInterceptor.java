package com.uctcinfo.product.common;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;

public class ContextInterceptor  implements Interceptor{
	public static final String CTX="ctx";
	@Override
	public void intercept(ActionInvocation ai) {
		// TODO Auto-generated method stub
		ai.invoke();
	    HttpServletRequest request = ai.getController().getRequest();
	    request.setAttribute(CTX, request.getContextPath());
	}

}
