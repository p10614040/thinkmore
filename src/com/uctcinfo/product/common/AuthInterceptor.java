package com.uctcinfo.product.common;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;
import com.uctcinfo.product.User;

/**
 * @ClassName: AuthInterceptor.java
 * @Description: 登陆拦截器
 * 
 * @author： even.jin
 * @version： V1.0
 * @Date： 2013-12-29 下午4:06:30
 */
public class AuthInterceptor implements Interceptor {

	@Override
	public void intercept(ActionInvocation ai) {
		Controller controller = ai.getController();
		User loginUser = controller.getSessionAttr("user");
		if (loginUser != null)
			ai.invoke();
		else {
			controller.redirect("/login?next=" +ai.getActionKey());
		}
	}

}
