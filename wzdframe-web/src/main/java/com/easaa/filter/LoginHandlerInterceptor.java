package com.easaa.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.easaa.core.util.EAConst;

/**
 * 
 * 类名称：登录过滤，权限验证 类描述：
 * 
 * @author FH qq371855779[hsia] 作者单位： 联系方式： 创建时间：2015年11月2日
 * @version 1.6
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {

	@SuppressWarnings("unused")
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		if (path.matches(EAConst.NO_INTERCEPTOR_PATH)) {
			System.out.println(request.getContextPath());
			return true;
		} else {
			// 登陆过滤
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
	}

}
