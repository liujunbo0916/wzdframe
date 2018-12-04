package com.easaa.service;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.session.Session;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.easaa.business.dao.BusinessOptLogMapper;
import com.easaa.core.util.EADate;
import com.easaa.core.util.WebUtils;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.LoginLog;
import com.easaa.log.annotation.MethodLog;
import com.easaa.log.annotation.OutPutLog;
import com.easaa.scenicspot.entity.Seller;
import com.easaa.upm.entity.Admin;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.upm.upm.contants.Const;

@Aspect
public class SystemLogService {
	@Autowired
	private BusinessOptLogMapper syslogDao;
	private Long logId;
	
	private Admin sessionAdmin;

	public SystemLogService() {
		System.out.println("Aop");
	}

	/**
	 * 在Spring
	 * 2.0中，Pointcut的定义包括两个部分：Pointcut表示式(expression)和Pointcut签名(signature
	 * )。让我们先看看execution表示式的格式：
	 * 括号中各个pattern分别表示修饰符匹配（modifier-pattern?）、返回值匹配（ret
	 * -type-pattern）、类路径匹配（declaring
	 * -type-pattern?）、方法名匹配（name-pattern）、参数匹配（(param
	 * -pattern)）、异常类型匹配（throws-pattern?），其中后面跟着“?”的是可选项。
	 * 
	 * @param point
	 * @throws Throwable
	 */
	@Pointcut("@annotation(com.easaa.log.annotation.MethodLog)")
	public void methodCachePointcut() {
	}

	/**
	 * 定义打印日志
	 * 
	 */
	@Pointcut("@annotation(com.easaa.log.annotation.OutPutLog)")
	public void methodPrintPointcut() {
	}

	
	@Pointcut("@annotation(com.easaa.log.annotation.LoginLog)")
	public void loginLogPointcut(){
		
	}
	
	
	/**
	 * 方法执行之前执行 将用户行为记录到控制台
	 * 
	 * @param point
	 * @return
	 * @throws Exception
	 * @throws Throwable
	 */
	@Before("methodPrintPointcut()")
	public void excuBefore(JoinPoint joinPoint) throws Exception {
		try {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
					.getRequest();
			Seller seller = (Seller) request.getSession().getAttribute(Const.SESSION_USER);
			if (seller != null) {
				System.out.println("平台日志|||||用户" + seller.getUserName() + "访问" + getPrintRemark(joinPoint));
			} else {
				System.out.println("执行" + getPrintRemark(joinPoint) + "");
			}
		} catch (Exception e) {
			System.out.println("系统日志处理异常");
			e.printStackTrace();
		}
	}

	@After("loginLogPointcut()")
	public void excuLoginLog(JoinPoint joinPoint) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		String ip = WebUtils.getIpAddr(request);
		Session session = Jurisdiction.getSession();
		Admin admin = (Admin)session.getAttribute(Const.SESSION_USER);
		sessionAdmin = admin;
		String loginName;
		if (admin != null) {
			loginName = admin.getUSERNAME();
		} else {
			loginName = "匿名用户";
		}
		String monthRemark = getMthodRemark(joinPoint);
		if (admin != null && StringUtils.isNotEmpty(monthRemark)) {
			PageData sysLog = new PageData();
			sysLog.put("log_time", EADate.getCurrentTime());
			sysLog.put("log_seller_id", admin.getUSER_ID());
			sysLog.put("log_seller_name", loginName);
			sysLog.put("log_seller_ip", ip);
			sysLog.put("log_url", request.getRequestURI());
			sysLog.put("log_state", 1);
			sysLog.put("log_content", monthRemark);
			// 这里有点纠结 就是不好判断第一个object元素的类型 只好通过 方法描述来 做一一 转型感觉 这里 有点麻烦 可能是我对
			// aop不太了解 希望懂的高手在回复评论里给予我指点
			// 有没有更好的办法来记录操作参数 因为参数会有 实体类 或者javabean这种参数怎么把它里面的数据都解析出来?
			syslogDao.insert(sysLog);
			logId = sysLog.getAsLong("log_id");
		}
		
	}
	/**
	 * 方法执行之后执行
	 * 
	 * @param point
	 * @return
	 * @throws Exception
	 * @throws Throwable
	 */
	@Before("methodCachePointcut()")
	public void excuAfter(JoinPoint joinPoint) throws Exception {
		try {
			System.out.println("<><>><<>><<><>><<>><><<>><><><><><><我是来试试水的");
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
					.getRequest();
			String ip = WebUtils.getIpAddr(request);
			Session session = Jurisdiction.getSession();
			Admin admin = (Admin)session.getAttribute(Const.SESSION_USER);
			sessionAdmin = admin;
			String loginName;
			if (admin != null) {
				loginName = admin.getUSERNAME();
			} else {
				loginName = "匿名用户";
			}
			String monthRemark = getMthodRemark(joinPoint);
			if (admin != null && StringUtils.isNotEmpty(monthRemark)) {
				PageData sysLog = new PageData();
				sysLog.put("log_time", EADate.getCurrentTime());
				sysLog.put("log_seller_id", admin.getUSER_ID());
				sysLog.put("log_seller_name", loginName);
				sysLog.put("log_seller_ip", ip);
				sysLog.put("log_url", request.getRequestURI());
				sysLog.put("log_state", 1);
				sysLog.put("log_content", monthRemark);
				// 这里有点纠结 就是不好判断第一个object元素的类型 只好通过 方法描述来 做一一 转型感觉 这里 有点麻烦 可能是我对
				// aop不太了解 希望懂的高手在回复评论里给予我指点
				// 有没有更好的办法来记录操作参数 因为参数会有 实体类 或者javabean这种参数怎么把它里面的数据都解析出来?
				syslogDao.insert(sysLog);
				logId = sysLog.getAsLong("log_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("系统日志处理异常");
		}
	}

	// // @Before("execution(* com.wssys.controller.*(..))")
	// public void logAll(JoinPoint point) throws Throwable {
	// System.out.println("打印========================");
	// }
	// // @After("execution(* com.wssys.controller.*(..))")
	// public void after() {
	// System.out.println("after");
	// }
	// 方法执行的前后调用
	// @Around("execution(* com.wssys.controller.*(..))||execution(*
	// com.bpm.*.web.account.*.*(..))")
	// @Around("execution(* com.wssys.controller.*(..))")
	// @Around("execution(*
	// org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.handle(..))")
	// @Around("methodCachePointcut()")
	/*
	 * @Around(value=
	 * "* com.easaa.controller.seller.LoginController.doLogin(...)")
	 */
	/*
	 * public Object around(ProceedingJoinPoint point) throws Throwable {
	 * HttpServletRequest request = ((ServletRequestAttributes)
	 * RequestContextHolder .getRequestAttributes()).getRequest(); String ip =
	 * WebUtils.getIpAddr(request); Seller seller = (Seller)
	 * request.getSession().getAttribute(Const.SESSION_USER); String loginName;
	 * if (seller != null) { loginName = seller.getUserName(); } else {
	 * loginName = "匿名用户"; } String monthRemark = getMthodRemark(point); String
	 * packages = point.getThis().getClass().getName(); if
	 * (packages.indexOf("$$EnhancerByCGLIB$$") > -1) { // 如果是CGLIB动态生成的类 try {
	 * packages = packages.substring(0, packages.indexOf("$$")); } catch
	 * (Exception ex) { ex.printStackTrace(); } } Object[] method_param = null;
	 * Object object; try { method_param = point.getArgs(); //获取方法参数 // String
	 * param=(String) point.proceed(point.getArgs()); object = point.proceed();
	 * } catch (Exception e) { // 异常处理记录日志..log.error(e); throw e; } if(seller
	 * != null){ PageData sysLog = new PageData(); sysLog.put("log_time",
	 * EADate.getCurrentTime()); sysLog.put("log_seller_id",
	 * seller.getSellerId()); sysLog.put("log_seller_name", loginName);
	 * sysLog.put("log_seller_ip", ip); sysLog.put("log_store_id",
	 * seller.getBusiness().getBsId()); sysLog.put("log_url",
	 * request.getRequestURI()); sysLog.put("log_state",1);
	 * sysLog.put("log_content",monthRemark); //这里有点纠结 就是不好判断第一个object元素的类型 只好通过
	 * 方法描述来 做一一 转型感觉 这里 有点麻烦 可能是我对 aop不太了解 希望懂的高手在回复评论里给予我指点 //有没有更好的办法来记录操作参数
	 * 因为参数会有 实体类 或者javabean这种参数怎么把它里面的数据都解析出来? syslogDao.insert(sysLog); }
	 * return object; }
	 */
	/**
	 * 方法调用出现了异常信息时执行 监控所有的控制器 将异常信息入库
	 * 
	 * @param ex
	 */
	@AfterThrowing(pointcut = "methodCachePointcut()", throwing = "ex")
	public void afterThrowing(Exception ex) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		String ip = WebUtils.getIpAddr(request);
		Session session = Jurisdiction.getSession();
		Admin admin = (Admin)session.getAttribute(Const.SESSION_USER);
		String loginName;
		if (sessionAdmin != null) {
			admin = sessionAdmin;
		} 
		if(admin == null) {
			loginName = "匿名用户";
		}else{
			loginName = admin.getUSERNAME();
		}
		System.out.println("afterThrowing");
		PageData exceptionMsg = new PageData();
		exceptionMsg.put("exception_url", request.getRequestURI());
		exceptionMsg.put("log_time", EADate.getCurrentTime());
		exceptionMsg.put("opter", loginName);
		exceptionMsg.put("exception_msg", ex.getMessage());
		exceptionMsg.put("ip", ip);
		if (logId != null) {
			exceptionMsg.put("log_id", logId);
			syslogDao.update(exceptionMsg);
		}
		syslogDao.insertExcetion(exceptionMsg);
	}
	
	
	
	
	
	

	// 获取方法的中文备注____用于记录用户的操作日志描述
	public static String getMthodRemark(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();

		Class targetClass = Class.forName(targetName);
		Method[] method = targetClass.getMethods();
		String methode = "";
		for (Method m : method) {
			if (m.getName().equals(methodName)) {
				Class[] tmpCs = m.getParameterTypes();
				if (tmpCs.length == arguments.length) {
					MethodLog methodCache = m.getAnnotation(MethodLog.class);
					if (methodCache != null) {
						methode = methodCache.remark();
					}else{
						LoginLog loginLog = m.getAnnotation(LoginLog.class);
						
						if(loginLog != null ){
							methode = loginLog.remark();
						}
					}
					break;
				}
			}
		}
		return methode;
	}

	// 获取打印标记的中文备注
	public static String getPrintRemark(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();

		Class targetClass = Class.forName(targetName);
		Method[] method = targetClass.getMethods();
		String methode = "";
		for (Method m : method) {
			if (m.getName().equals(methodName)) {
				Class[] tmpCs = m.getParameterTypes();
				if (tmpCs.length == arguments.length) {
					OutPutLog methodCache = m.getAnnotation(OutPutLog.class);
					if (methodCache != null) {
						methode = methodCache.remark();
					}
					break;
				}
			}
		}
		return methode;
	}
}
