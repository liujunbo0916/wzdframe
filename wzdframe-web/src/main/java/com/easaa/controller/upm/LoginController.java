package com.easaa.controller.upm;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.easaa.core.tool.CaptchaUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.LoginLog;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.dao.IndexMapper;
import com.easaa.upm.entity.Admin;
import com.easaa.upm.service.AdminService;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.upm.upm.contants.Const;

@Controller
@RequestMapping("/main/")
public class LoginController  extends BaseController{

	@Resource(name="adminService")
	public AdminService adminService;


	//@Resource(name="courseService")
	//private CourseService courseService;
	
	
	//@Resource(name="schoolService")
	//private SchoolService schoolService;
	
	@Resource 
	private IndexMapper indexMapper; 
	
	
	@RequestMapping("index")
	public ModelAndView index(){
		ModelAndView mv = this.getModelAndView();
		PageData param = this.getPageData();
		Session session = Jurisdiction.getSession();
		Admin user = (Admin)session.getAttribute(Const.SESSION_USER);
		//mv.addObject("courseTable", courseService.getCourseTable(param));
		adminService.index(param,mv);
		mv.setViewName("index/index");
		return mv;
	}
	/**
	 * 登录页面
	 */
	@RequestMapping("login")
	public ModelAndView login(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("login");
		mv.addObject("system_name", "秦汉影视城后台管理系统");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value =  "loginCheckCode",method = RequestMethod.GET)
	public void loginCheckCode(HttpServletRequest request, HttpServletResponse response){
		HttpSession session =  request.getSession();
		String randomString = CaptchaUtil.getRandomString(5);
		session.setAttribute(AdminService.SESSION_CHECKCODE,randomString);
		try {
			CaptchaUtil.outputCaptcha(randomString, response);
		}catch (Exception e){
		}
	}
	/**
	 * 登录
	 */
	@LoginLog(remark = "用户登陆")
	@RequestMapping("doLogin")
	public void  doLogin(HttpServletResponse response){
		PageData pd = this.getPageData();
		try {
			adminService.doLogin(pd);
			super.outJson(response, REQUEST_SUCCESS,"登录成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	} 
	/**
	 * 进入首页后的默认页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/default")
	public ModelAndView defaultPage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData param = new PageData();
		Session session = Jurisdiction.getSession();
		Admin user = (Admin)session.getAttribute(Const.SESSION_USER);
		param.put("USERID", user.getUSER_ID());
		mv.setViewName("index/default");
		return mv;
	}
	/**
	 * 用户注销
	 * @return
	 * @throws Exception 
	 */
	@MethodLog(remark="退出登陆")
	@RequestMapping(value="/logout")
	public ModelAndView logout() throws Exception{
		String USERNAME = Jurisdiction.getUsername();	//当前登录的用户名
		logBefore(logger, USERNAME+"退出系统");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Session session = Jurisdiction.getSession();	//以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS);
		session.removeAttribute(USERNAME + Const.SESSION_allmenuList);
		session.removeAttribute(USERNAME + Const.SESSION_menuList);
		session.removeAttribute(USERNAME + Const.SESSION_QX);
		session.removeAttribute(Const.SESSION_userpds);
		session.removeAttribute(Const.SESSION_USERROL);
		//shiro销毁登录
		Subject subject = SecurityUtils.getSubject(); 
		subject.logout();
		pd = this.getPageData();
		pd.put("msg", pd.getString("msg"));
		mv.setViewName("login");
		mv.addObject("pd",pd);
		return mv;
	}
	
	
}
