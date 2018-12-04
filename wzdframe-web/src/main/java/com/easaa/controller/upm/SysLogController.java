package com.easaa.controller.upm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.business.service.BusinessOptLogService;
import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.service.SysLogService;
/**
 * 系统日志
 * @author ryy
 *
 */
@Controller
@RequestMapping("/sys/log")
public class SysLogController extends BaseController{
	
	@Autowired
	private BusinessOptLogService  businessOptLogService;
	/**
	 * 系统日志信息
	 * @param page
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(Page page){
		PageData pd= getPageData();
		page.setPd(pd);
		ModelAndView mav=new ModelAndView();
		mav.addObject("data", businessOptLogService.getByPage(page));
		mav.addObject("pd", pd);
		mav.addObject("page", page);
		mav.setViewName("system/syslog/logList");
		return mav;
	}
	
	/**
	 * 系统异常信息
	 * @param page
	 * @return
	 */
	@RequestMapping("/exceptionlist")
	public ModelAndView exceptionlist(Page page){
		PageData pd= getPageData();
		page.setPd(pd);
		ModelAndView mav=new ModelAndView();
		mav.addObject("data", businessOptLogService.getExceptionByPage(page));
		mav.addObject("pd", pd);
		mav.addObject("page", page);
		mav.setViewName("system/syslog/exceptionList");
		return mav;
	}
	
}
