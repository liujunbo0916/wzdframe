package com.easaa.filter;

import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;
import com.easaa.wechat.common.WechatUtil;

import net.sf.json.JSONObject;

public class OpenIdFiler  implements Filter {
	
	/**
	 * 初始化
	 */
	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	public void init(FilterConfig fc) throws ServletException {
		fc.getServletContext().setAttribute("IMAGEPATH", PROPERTIESHELPER.getValue("imageShowPath"));
	}
	public void destroy() {
	}
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpSession session = request.getSession();
		 if(request.getServletPath().startsWith("/wx")){
			 System.out.println(request.getParameter("open_id"));
			 System.out.println("serverPath<><>><><><><><><><><><><><><><><><><><><><><><"+request.getServletPath());
		 }
		 Map<String, String[]> param = request.getParameterMap();
		 for(Entry<String, String[]> entry : param.entrySet()){
			 if("open_id".equalsIgnoreCase(entry.getKey().trim())){
				String[] strs =  entry.getValue();
				System.out.println("OpenId==微信OpenID"+strs);
				if(strs.length > 0 ){
					if(StringUtils.isNotEmpty(strs[0])){
						session.setAttribute("open_id", strs[0]);
						JSONObject jsonObj = WechatUtil.readUserInfo(strs[0]);
					    session.setAttribute("jsonObj", jsonObj);
					}
				}
			 }
		 }
		 if(StringUtils.isNotEmpty(request.getRequestURL().toString())){
			 System.out.println("<><>><<><>><><<><>><><><>><><><>"+session.getAttribute("openid"));
		 }
		chain.doFilter(req, res); // 调用下一过滤器
	}
}
