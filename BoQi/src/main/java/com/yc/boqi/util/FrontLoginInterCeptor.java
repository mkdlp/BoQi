package com.yc.boqi.util;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class FrontLoginInterCeptor extends MethodFilterInterceptor {
	private static final long serialVersionUID = 1L;

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		Object obj = session.get("loginUser");
		if(obj == null){
			session.put("errorMsg", "请先登录");
			return "login";
		}
		return invocation.invoke();
	}
}
