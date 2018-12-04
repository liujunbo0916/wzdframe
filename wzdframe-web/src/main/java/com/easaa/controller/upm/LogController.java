package com.easaa.controller.upm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.upm.service.LogService;

@Controller
@RequestMapping("/log")
public class LogController extends BaseController{
	
	@Autowired
	private LogService logService;
	
	@RequestMapping("/list")
	public ModelAndView list(Page page){
		page.setPd(getPageData());
		ModelAndView mav=new ModelAndView();
		mav.addObject("data", logService.getByPage(page));
		mav.setViewName("system/log/logList");
		return mav;
	}

}
