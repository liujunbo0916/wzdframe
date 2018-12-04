package com.easaa.controller.comm;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.session.Session;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.tool.Logger;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAWEB;
import com.easaa.core.util.Tools;
import com.easaa.core.util.WebUtils;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Admin;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.upm.upm.contants.Const;
import com.easaa.util.properties.PropertiesHelper;
import net.sf.json.JSONObject;

/**
 * @author FH Q371855779
 * 淇敼鏃堕棿锛�015銆�2銆�1
 */
public class BaseController {
	
	/**
	 *  杩斿洖瀹㈡埛绔姹傜姸鎬佺爜  
	 */
	protected static final String REQUEST_SUCCESS     =  "200";            //鎿嶄綔鎴愬姛
	protected static final String PARAM_ERROR         =  "201";            //鍙傛暟閿欒
	protected static final String REFUSE_ACCESS       =  "202";            //璁块棶琚嫆缁�
	protected static final String NO_DATA             =  "203";            //鏃犳暟鎹�
	protected static final String TO_LOGIN            =  "204";            //鍘荤櫥褰曢〉闈�
	protected static final String REQUEST_FAILS       =  "205";            //璇锋眰閿欒     鏈嶅姟鍣ㄤ細杩斿洖鐩稿簲鐨刴sg
	/**
	 * 鐧诲綍绠＄悊鍛樼殑鐪熷疄濮撳悕
	 * @return
	 */
	protected String getAdminName(){
		Session session = Jurisdiction.getSession();
		Admin admin = (Admin)session.getAttribute(Const.SESSION_USER);
		//PageData admin = (PageData) this.getSessionAttribute(getRequest(), "sessionUser");
		return admin.getNAME();
	}
	
	
	protected String getWxAppUserCardId(){
		return (String) getRequest().getSession().getAttribute("SFZHBACK");
	}
	
	
	/**
	 * 鎵嬫満绔瘡椤佃褰曟暟
	 */
	protected static final Integer PAGESIZE = 15;
	
	
	
	
	protected Logger logger = Logger.getLogger(this.getClass());

	
	/** new PageData瀵硅薄
	 * @return
	 */
	public PageData getPageData(){
		PageData pd=new PageData(this.getRequest());
		Tools.replaceEmpty(pd);
		return pd;
	}
	
	/** new PageData瀵硅薄 锛�鏂囦欢涓婁紶
	 * @return
	 */
	public PageData getPageData(MultipartHttpServletRequest multipartRequest){
		return new PageData(multipartRequest);
	}
	
	/**寰楀埌ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**寰楀埌request瀵硅薄
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	/**寰楀埌32浣嶇殑uuid
	 * @return
	 */
	public String get32UUID(){
		return EAString.get32UUID();
	}
	
	/**寰楀埌鍒嗛〉鍒楄〃鐨勪俊鎭�
	 * @return
	 */
	public Page getPage(){
		return new Page();
	}
	
	
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}
	
	public void outJsonString(HttpServletResponse response, boolean result,String msg,Object data) {
		response.setHeader("Cache-Control",
				"no-store, max-age=0, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		 /* 璁剧疆鏍煎紡涓簍ext/json    */
        response.setContentType("text/json"); 
        /*璁剧疆瀛楃闆嗕负'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 
		try {
			PrintWriter out = response.getWriter();
			JSONObject reParam = new JSONObject(false);
			reParam.put("result", result);
			reParam.put("data", data);
			reParam.put("msg", msg);
			out.write(reParam.toString());
			out.close();
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void outJson(HttpServletResponse response, String result, String msg,Object data) {
		response.setHeader("Cache-Control", "no-store, max-age=0, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		 /* 璁剧疆鏍煎紡涓簍ext/json    */
        response.setContentType("text/json"); 
        /*璁剧疆瀛楃闆嗕负'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 
		try {
			PrintWriter out = response.getWriter();
			JSONObject reParam = new JSONObject(false);
			reParam.put("result", result);
			reParam.put("data", data);
			reParam.put("msg", msg);
			out.write(reParam.toString());
			out.close();
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void outJson(HttpServletResponse response, PageData data) {
		response.setHeader("Cache-Control",
				"no-store, max-age=0, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		 /* 设置格式为text/json    */
        response.setContentType("text/json"); 
        /*设置字符集为'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 
		try {
			PrintWriter out = response.getWriter();
			out.write(data.toJson());
			out.close();
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 杈撳嚭JSON瀛楃涓插埌瀹㈡埛绔�
	 * @param result 杩斿洖鐘舵�浠ｇ爜
	 * @param msg 杩斿洖鐨勬彁绀烘秷鎭�
	 * @param data 杩斿洖鏁版嵁涓婚
	 * @param response
	 */
	public void outJson(String result, String msg,Object data,HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-store, max-age=0, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		 /* 璁剧疆鏍煎紡涓簍ext/json    */
        response.setContentType("text/json"); 
        /*璁剧疆瀛楃闆嗕负'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 
		try {
			PrintWriter out = response.getWriter();
			JSONObject reParam = new JSONObject(false);
			reParam.put("code", result);
			reParam.put("data", data);
			reParam.put("msg", msg);
			out.write(reParam.toString());
			out.close();
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unused")
	private void printAllParameter(){
		Enumeration<String> rnames=getRequest().getParameterNames();
		for (Enumeration<String> e = rnames ; e.hasMoreElements() ;) {
			String thisName=e.nextElement().toString();
		    String thisValue=getRequest().getParameter(thisName);
		    System.out.println(thisName+"-------"+thisValue);
		} 
	}
	
	
	protected String getOpenId(){
		String openId=EAWEB.getSessionAttribute(this.getRequest(),"openid")+"";
		return openId;
	}
	
	protected String getRemoteHost(HttpServletRequest request){
	    String ip = request.getHeader("x-forwarded-for");
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getRemoteAddr();
	    }
	    return ip.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":ip;
	}
	
	/**
	 * 鑾峰彇涓�釜Session灞炴�瀵硅薄
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	protected Object getSessionAttribute(HttpServletRequest request, String sessionKey) {
		Object objSessionAttribute = null;
		HttpSession session = request.getSession(false);
		if (session != null) {
			objSessionAttribute = session.getAttribute(sessionKey);
		}
		return objSessionAttribute;
	}
	
}
