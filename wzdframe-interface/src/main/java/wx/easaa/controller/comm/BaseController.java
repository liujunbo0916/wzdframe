package wx.easaa.controller.comm;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.tool.Logger;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAWEB;
import com.easaa.core.util.WebUtils;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;
import com.easaa.wechat.common.WechatUtil;

import net.sf.json.JSONObject;

/**
 * @author FH Q371855779
 */
public class BaseController {
	
	/**
	 *  返回客户端请求状态码  
	 */
	protected static final String REQUEST_SUCCESS     =  "200";            //操作成功
	protected static final String PARAM_ERROR         =  "201";            //参数错误
	protected static final String REFUSE_ACCESS       =  "202";            //访问被拒绝
	protected static final String NO_DATA             =  "203";            //无数据
	protected static final String TO_LOGIN            =  "204";            //去登录页面
	protected static final String REQUEST_FAILS       =  "205";            //请求错误     服务器会返回相应的msg
	
	
	protected static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	/**
	 * 登录管理员的真实姓名
	 * @return
	 */
	protected String getAdminName(){
		PageData admin = (PageData) this.getSessionAttribute(getRequest(), "admin");
		return admin.getAsString("real_name");
	}
	/**
	 *获取微信登录用户信息
	 */
	public PageData getUserInfo(){
		PageData user = (PageData) this.getSessionAttribute(getRequest(), "userInfo");
		return user;
	}
	
	/**
	 * 手机端每页记录数
	 */
	protected static final Integer PAGESIZE = 15;
	
	protected Logger logger = Logger.getLogger(this.getClass());

	
	/** new PageData对象
	 * @return
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/** new PageData对象 ： 文件上传
	 * @return
	 */
	public PageData getPageData(MultipartHttpServletRequest multipartRequest){
		return new PageData(multipartRequest);
	}
	
	/**得到ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**得到request对象
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	
	/**
	 * 将微信分享信息添加到Model
	 * @param url 当前页面的URL 完整URL带参数
	 * @param actName 跳转页面时的Action名称
	 * @param parameter 携带参数
	 * @param model
	 * @param isAuthor 跳转的链接是否需要微信授权认证
	 */
	protected void putShareApi(String url,PageData parameter,ModelAndView model,boolean isAuthor){
		PageData pd=getShareApi(url,parameter,isAuthor);
		model.addObject("share",pd);
	}
	@SuppressWarnings("unchecked")
	protected PageData getShareApi(String url,PageData parameter,boolean isAuthor){
		String http=url.substring(0,1);
		if(isAuthor){
			url = "/appwx/shareRedirect?base_url="+url;
		}
		if("/".equals(http)){
			url=url.substring(1);
			url=PropertiesHelper.getAppRootUrl()+url;
		}else{
			http=url.substring(0,4);
			if(!"http".equalsIgnoreCase(http)){
				url=PropertiesHelper.getAppRootUrl()+url;
			}
		}
		String queryString=this.getRequest().getQueryString();
		String requestURL=this.getRequest().getRequestURL().toString();
		if(!EAString.isNullStr(queryString)){
			requestURL=requestURL+"?"+queryString;
		}
		String shareUrl="";
		String share_sn=EAString.getSn();//每次分享一个独立的序列号
		parameter.put("share_sn",share_sn);
		parameter.put("share_openid",getOpenId());
		PageData pd=new PageData();
		pd.put("shareTicket", WechatUtil.createShareTicket(requestURL));
		parameter.put("share_scene","friend");
		shareUrl=WebUtils.formatUrlByParamsMap(url, parameter);
		/*if(isAuthor){
			System.out.println("<><>><<><><><><><>"+WechatUtil.getAuthorUrl(shareUrl));
			pd.put("shareLinkFriend",WechatUtil.getAuthorUrlUserInfo(shareUrl));
		}else{*/
			pd.put("shareLinkFriend",shareUrl);
		/*}*/
		parameter.put("share_scene","timeline");
		shareUrl=WebUtils.formatUrlByParamsMap(url, parameter);
		/*if(isAuthor){
			pd.put("shareLinkTimeLine",WechatUtil.getAuthorUrlUserInfo(shareUrl));
		}else{*/
			pd.put("shareLinkTimeLine",shareUrl);
		/*}*/
		return pd;
	}
	/**得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		return EAString.get32UUID();
	}
	/**得到分页列表的信息
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
	 * 输出JSON字符串到客户端
	 * @param result 返回状态代码
	 * @param msg 返回的提示消息
	 * @param data 返回数据主题
	 * @param response
	 */
	public void outJson(String result, String msg,Object data,HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-store, max-age=0, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		 /* 设置格式为text/json    */
        response.setContentType("text/json"); 
        /*设置字符集为'UTF-8'*/
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
	/**
	 * 
	 * @param response
	 * @param result
	 * @param msg
	 * @param data
	 */
	public void outJsonStringToApp(HttpServletResponse response, String result, String msg,Object data) {
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
		String openId=EAWEB.getSessionAttribute(this.getRequest(),"open_id")+"";
		System.out.println(openId);
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
	 * 获取一个Session属性对象
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
	/**
	 * 从全局属性对象
	 * @param key
	 * @return
	 */
	protected Object getApplicationAttribute(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext application = request.getSession().getServletContext();
		return application.getAttribute(key);
	}
	
	/**
	 * 设置全局属性对象
	 * @param key
	 * @param object
	 */
	protected void setApplicationAttribute(String key,Object object){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext application = request.getSession().getServletContext();
		application.setAttribute(key, object);
	}
	
	
}
