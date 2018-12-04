package com.easaa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.easaa.entity.PageData;
import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;
/**
 * 容器启动拦截器   将公用的配置 拦截到application里面
 * @author Administrator
 *
 */
public class StartFilter  implements Filter{

	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	
	public void init(FilterConfig config) throws ServletException {
		PageData settingPd = null;
		if(config.getServletContext().getAttribute("SETTINGPD") != null){
			settingPd = (PageData) config.getServletContext().getAttribute("SETTINGPD");
		} else{
			settingPd = new PageData();
		}
		settingPd.put("IMAGEPATH", PROPERTIESHELPER.getValue("imageShowPath"));
		config.getServletContext().setAttribute("SETTINGPD",settingPd);
	}
	public void destroy() {
	}
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc)
			throws IOException, ServletException {
		fc.doFilter(request, response);
	}
}
