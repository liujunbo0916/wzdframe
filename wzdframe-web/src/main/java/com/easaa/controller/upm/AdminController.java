package com.easaa.controller.upm;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.MD5;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Role;
import com.easaa.upm.service.AdminService;
import com.easaa.upm.service.MenuService;
import com.easaa.upm.service.RoleService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 系统管理
 * @author Administrator
 */
@RequestMapping("/user/")
@Controller
public class AdminController extends BaseController {

	String menuUrl = "user/listUsers.do"; //菜单地址(权限用)
	@Resource(name="adminService")
	private AdminService adminService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="menuService")
	private MenuService menuService;
	
	//@Resource(name="schoolService")
	//private SchoolService schoolService;
	/**显示用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listUsers")
	public ModelAndView listUsers(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getString("keywords"))){
			pd.put("keywords", pd.getString("keywords").trim());
		}
		String lastLoginStart = pd.getString("lastLoginStart");	//开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd");		//结束时间
		pd.put("type", "system"); //系统用户
		if(StringUtils.isNotEmpty(lastLoginStart)){
			pd.put("lastLoginStart", lastLoginStart+" 00:00:00");
		}
		if(StringUtils.isNotEmpty(lastLoginEnd) ){
			pd.put("lastLoginEnd", lastLoginEnd+" 00:00:00");
		} 
		pd.put("role", pd.getAsString("ROLE_ID"));
		page.setPd(pd);
		List<PageData>	userList = adminService.listUsers(page);	//列出用户列表
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
		mv.setViewName("system/user/user_list");
		mv.addObject("userList", userList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		System.out.println(Jurisdiction.getHC());
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**删除用户
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除user");
		PageData pd  = this.getPageData();
		adminService.deleteU(pd);
		super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
	}
	/**
	 * 去新增用户页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddU")
	public ModelAndView goAddU()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd =  this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);//列出所有系统用户角色
		//List<PageData> schoolList = schoolService.getByMap(new PageData()); //列出所有的学校
		//mv.addObject("allSchools", schoolList);
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	/**保存用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveU")
	public void saveU(HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return;} //校验权限
		try{
			logBefore(logger, Jurisdiction.getUsername()+"新增user");
			PageData pd = this.getPageData();
			pd.put("USER_ID", this.get32UUID());	//ID 主键
			pd.put("LAST_LOGIN", "");				//最后登录时间
			pd.put("IP", "");						//IP
			pd.put("STATUS", "0");					//状态
			pd.put("SKIN", "default");
			pd.put("RIGHTS", "");		
//			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());	//密码加密
			pd.put("PASSWORD", MD5.md5(pd.getAsString("PASSWORD")));
			adminService.saveU(pd); 	//执行保存
			super.outJson(response, super.REQUEST_SUCCESS,"操作成功", pd);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}
	/**判断用户名，邮箱，编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasExist")
	public void hasExist(HttpServletResponse response){
		PageData pd = null;
		try{	
			pd = this.getPageData();
			if(StringUtils.isNotEmpty(pd.getAsString("t_number"))){
				pd.put("NUMBER", pd.getAsString("t_number"));
			}
			List<PageData> results = adminService.getUserByCondition(pd); 
			if( results != null && results.size() > 0 ){
				super.outJson(response, super.REQUEST_FAILS, "已存在", null);
			}else{
				super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
			}
		} catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
		
	}
	/**去修改用户页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditU")
	public ModelAndView goEditU() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd  = this.getPageData();
		String fx = pd.getString("fx");//顶部修改个人资料
		if("head".equals(fx)){
			mv.addObject("fx", "head");
		}else{
			mv.addObject("fx", "user");
		}
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = adminService.getUserInfo(pd);								//根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	
	/**查看用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public ModelAndView view() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = adminService.getUserInfo(pd);						//根据ID读取
		mv.setViewName("system/user/user_view");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	
	/**去修改用户页面(在线管理页面打开)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditUfromOnline")
	public ModelAndView goEditUfromOnline() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = adminService.getUserInfo(pd);						//根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}
	/**
	 * 修改用户
	 */
	@RequestMapping(value="/editU")
	public void editU(HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		try{
			logBefore(logger, Jurisdiction.getUsername()+"修改ser");
			PageData pd  = this.getPageData();
			if(pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))){
//				pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
				pd.put("PASSWORD", MD5.md5(pd.getAsString("PASSWORD")));
			}
			adminService.editU(pd);	//执行修改
		   super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}
	/**
	 * 批量删除
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAllU")
	public void deleteAllU(HttpServletResponse response) throws Exception {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除user");
		PageData pd = this.getPageData();
		String USER_IDS = pd.getString("USER_IDS");
		if( StringUtils.isNotEmpty(USER_IDS)){
			String ArrayUSER_IDS[] = USER_IDS.split(",");
			adminService.deleteBatch(ArrayUSER_IDS);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		}else{
			super.outJson(response, super.PARAM_ERROR, "参数不能为空", null);
		}
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
