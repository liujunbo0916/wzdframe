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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Role;
import com.easaa.upm.service.ButtonRightService;
import com.easaa.upm.service.ButtonService;
import com.easaa.upm.service.RoleService;
import com.easaa.upm.upm.Jurisdiction;
/**
 * 按钮权限管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/buttonrights/")
public class ButtonRightController extends BaseController {

	String menuUrl = "buttonrights/list.do"; //菜单地址(权限用)
	@Resource(name="buttonRightService")
	private ButtonRightService buttonrightService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="buttonService")
	private ButtonService buttonService;
	
	/**列表
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Buttonrights");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(StringUtils.isEmpty(pd.getAsString("ROLE_ID"))){
			pd.put("ROLE_ID", "1");										//默认列出第一组角色(初始设计系统用户和会员组不能删除)
		}
		PageData fpd = new PageData();
		fpd.put("ROLE_ID", "0");
		List<Role> roleList = roleService.listAllRolesByPId(fpd);			//列出组(页面横向排列的一级组)
		List<Role> roleList_z = roleService.listAllRolesByPId(pd);			//列出此组下架角色
		List<PageData> buttonlist = buttonService.listAll(pd);			//列出所有按钮
		List<PageData> roleFhbuttonlist = buttonrightService.listAll(pd);	//列出所有角色按钮关联数据
		pd = roleService.findObjectById(pd);								//取得点击的角色组(横排的)
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		mv.addObject("roleList_z", roleList_z);
		mv.addObject("buttonlist", buttonlist);
		mv.addObject("roleFhbuttonlist", roleFhbuttonlist);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		mv.setViewName("system/buttonright/buttonrights_list");
		return mv;
	}
	
	/**点击按钮处理关联表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/upRb")
	@ResponseBody
	public void updateRolebuttonrightd(HttpServletResponse response)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"分配按钮权限");
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(null != buttonrightService.findById(pd)){	//判断关联表是否有数据 是:删除/否:新增
				buttonrightService.delete(pd);		//删除
			}else{
				pd.put("RB_ID", this.get32UUID());	//主键
				buttonrightService.save(pd);		//新增
			}
			   super.outJson(response, super.REQUEST_SUCCESS, "请求成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, "请求失败", null);
		}
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
}
