package com.easaa.controller.comm;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.entity.Page;

@Controller
@RequestMapping("/sys/")
public class SYSController extends BaseController {
	@RequestMapping(value="/index")
	public ModelAndView testpage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("index/index");
		return mv;
	}
	
	
}
