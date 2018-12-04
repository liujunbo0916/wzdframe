package com.easaa.controller.upm;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EATools;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Admin;
import com.easaa.upm.entity.Menu;
import com.easaa.upm.entity.Role;
import com.easaa.upm.service.AdminService;
import com.easaa.upm.service.MenuService;
import com.easaa.upm.service.RoleService;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.upm.upm.RightsHelper;
import com.easaa.upm.upm.contants.Const;

import net.sf.json.JSONArray;
/** 
 * 类名称：RoleController 角色权限管理
 * 创建人：hsia
 * 修改时间：2015年11月6日
 * @version
 */
@Controller
@RequestMapping(value="/role/")
public class RoleController extends BaseController {
	
	String menuUrl = "role.do"; //菜单地址(权限用)
	@Resource(name="menuService")
	private MenuService menuService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="adminService")
	private AdminService adminService;
	//@Resource(name="schoolService")
	//private SchoolService schoolService;
	
	/** 进入权限首页
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			Session session = Jurisdiction.getSession();
			Admin user = (Admin)session.getAttribute(Const.SESSION_USER);
			pd = this.getPageData();
			if(pd.getString("ROLE_ID") == null || "".equals(pd.getString("ROLE_ID").trim())){
				
				/*if(StringUtils.isNotEmpty(user.getSCHOOL_ID())){
					pd.put("ROLE_ID", "2");			
				}else{*/
					pd.put("ROLE_ID", "1");										//默认列出第一组角色(初始设计系统用户和会员组不能删除)
				/*}*/
			}
			/**
			 * 获取当前管理员的信息
			 */
			PageData fpd = new PageData();
			/*if(StringUtils.isNotEmpty(user.getSCHOOL_ID())){
				fpd.put("type", user.getSCHOOL_ID());
			}
			pd.put("SCHOOL_ID", user.getSCHOOL_ID());*/
			fpd.put("ROLE_ID", "0");
			List<Role> roleList = roleService.listAllRolesByPId(fpd);		//列出学校对应的组(页面横向排列的一级组)
			List<Role> roleList_z = roleService.listAllRolesByPId(pd);		//列出此组下架角色
			pd = roleService.findObjectById(pd);							//取得点击的角色组(横排的)
			mv.addObject("pd", pd);
			mv.addObject("roleList", roleList);
			mv.addObject("roleList_z", roleList_z);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName("system/role/role_list");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**去新增页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			/*if(pd.getAsInt("parent_id")==2) {
				Session session = Jurisdiction.getSession();
				User user = (User)session.getAttribute(Const.SESSION_USER);
				if(EAUtil.isEmpty(user.getSCHOOL_ID())) {
					mv.addObject("schools", schoolService.selectForSelect(pd));
				}
			}*/
			mv.addObject("msg", "add");
			mv.setViewName("system/role/role_edit");
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**保存新增角色
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/add")
	public void add(HttpServletResponse response)throws Exception{
	/*	if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return ;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"新增角色");
		/**
		 * 获取当前登录管理员
		 */
		Session session = Jurisdiction.getSession();
		Admin user = (Admin)session.getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String parent_id = pd.getString("PARENT_ID");		//父类角色id
			pd.put("ROLE_ID", parent_id);			
			if("0".equals(parent_id)){
				pd.put("RIGHTS", "");							//菜单权限
			}else{
				String rights = roleService.findObjectById(pd).getString("RIGHTS");
				pd.put("RIGHTS", (null == rights)?"":rights);	//组菜单权限
			}
			pd.put("ROLE_ID", this.get32UUID());				//主键
			pd.put("ADD_QX", "0");	//初始新增权限为否
			pd.put("DEL_QX", "0");	//删除权限
			pd.put("EDIT_QX", "0");	//修改权限
			pd.put("CHA_QX", "0");	//查看权限
			/*if(StringUtils.isNotEmpty(user.getSCHOOL_ID())){
				pd.put("SCHOOL_ID", user.getSCHOOL_ID());
			}*/
			roleService.add(pd);
			super.outJson(response, super.REQUEST_SUCCESS,"操作成功", null);
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_FAILS,"操作失败", null);
		}
	}
	
	/**请求编辑
	 * @param ROLE_ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit( String  ROLE_ID )throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("ROLE_ID", ROLE_ID);
			pd = roleService.findObjectById(pd);
			/*if(pd.getAsInt("PARENT_ID")==2) {
				Session session = Jurisdiction.getSession();
				User user = (User)session.getAttribute(Const.SESSION_USER);
				if(EAUtil.isEmpty(user.getSCHOOL_ID())) {
					mv.addObject("schools", schoolService.selectForSelect(pd));
				}
			}*/
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
			mv.setViewName("system/role/role_edit");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**保存修改
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public void edit(HttpServletResponse response)throws Exception{
		/*if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"修改角色");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			roleService.edit(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		} catch(Exception e){
			logger.error(e.toString(), e);
		   super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	/**删除角色
	 * @param ROLE_ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void deleteRole(@RequestParam String ROLE_ID,HttpServletResponse response)throws Exception{
		/*if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"删除角色");
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		try{
			pd.put("ROLE_ID", ROLE_ID);
			List<Role> roleList_z = roleService.listAllRolesByPId(pd);		//列出此部门的所有下级
			if(roleList_z.size() > 0){
				super.outJson(response, super.REQUEST_FAILS, "该角色已被占用", null);										//下级有数据时，删除失败
			}else{
				List<PageData> userlist = adminService.listAllUserByRoldId(pd);			//此角色下的用户
				if(userlist.size() > 0 ){						//此角色已被使用就不能删除
					super.outJson(response, super.REQUEST_FAILS, "该角色已被占用", null);	
				}else{
				roleService.deleteRoleById(ROLE_ID);	//执行删除
				super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);	
				}
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);	
		}
	}
	
	/**
	 * 显示菜单列表ztree(菜单授权菜单)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/menuqx")
	public ModelAndView listAllMenu(Model model,String ROLE_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			Role role = roleService.getRoleById(ROLE_ID);			//根据角色ID获取角色对象
			String roleRights = role.getRIGHTS();					//取出本角色菜单权限
			List<Menu> menuList = menuService.listAllMenuQx("0");	//获取所有菜单
			menuList = this.readMenu(menuList, roleRights);			//根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("ROLE_ID",ROLE_ID);
			mv.setViewName("system/role/menuqx");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**保存角色菜单权限
	 * @param ROLE_ID 角色ID
	 * @param menuIds 菜单ID集合
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/saveMenuqx")
	public void saveMenuqx(@RequestParam String ROLE_ID,@RequestParam String menuIds,HttpServletResponse response)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改菜单权限");
		PageData pd = new PageData();
		try{
			if(null != menuIds && !"".equals(menuIds.trim())){
				BigInteger rights = RightsHelper.sumRights(EATools.str2StrArray(menuIds));//用菜单ID做权处理
				Role role = roleService.getRoleById(ROLE_ID);	//通过id获取角色对象
				role.setRIGHTS(rights.toString());
				roleService.updateRoleRights(role);				//更新当前角色菜单权限
				pd.put("rights",rights.toString());
			}else{
				Role role = new Role();
				role.setRIGHTS("");
				role.setROLE_ID(ROLE_ID);
				roleService.updateRoleRights(role);				//更新当前角色菜单权限(没有任何勾选)
				pd.put("rights","");
			}
				pd.put("ROLE_ID", ROLE_ID);
				roleService.setAllRights(pd);					//更新此角色所有子角色的菜单权限
			 super.outJson(response, super.REQUEST_SUCCESS, "操作成功",null);
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_SUCCESS, "操作失败", null);
		}
	}
	/**请求角色按钮授权页面(增删改查)
	 * @param ROLE_ID： 角色ID
	 * @param msg： 区分增删改查
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/b4Button")
	public ModelAndView b4Button(@RequestParam String ROLE_ID,@RequestParam String msg,Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			List<Menu> menuList = menuService.listAllMenuQx("0"); //获取所有菜单
			Role role = roleService.getRoleById(ROLE_ID);		  //根据角色ID获取角色对象
			String roleRights = "";
			if("add_qx".equals(msg)){
				roleRights = role.getADD_QX();	//新增权限
			}else if("del_qx".equals(msg)){
				roleRights = role.getDEL_QX();	//删除权限
			}else if("edit_qx".equals(msg)){
				roleRights = role.getEDIT_QX();	//修改权限
			}else if("cha_qx".equals(msg)){
				roleRights = role.getCHA_QX();	//查看权限
			}
			menuList = this.readMenu(menuList, roleRights);		//根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("ROLE_ID",ROLE_ID);
			mv.addObject("msg", msg);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		mv.setViewName("system/role/b4Button");
		return mv;
	}
	/**根据角色权限处理权限状态(递归处理)
	 * @param menuList：传入的总菜单
	 * @param roleRights：加密的权限字符串
	 * @return
	 */
	public List<Menu> readMenu(List<Menu> menuList,String roleRights){
		for(int i=0;i<menuList.size();i++){
			menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
			this.readMenu(menuList.get(i).getSubMenu(), roleRights);					//是：继续排查其子菜单
		}
		return menuList;
	}
	
	/**
	 * 保存角色按钮权限
	 */
	/**
	 * @param ROLE_ID
	 * @param menuIds
	 * @param msg
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/saveB4Button")
	public void saveB4Button(@RequestParam String ROLE_ID,@RequestParam String menuIds,@RequestParam String msg,HttpServletResponse response)throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改"+msg+"权限");
		PageData pd = this.getPageData();
		try{
			if(null != menuIds && !"".equals(menuIds.trim())){
				BigInteger rights = RightsHelper.sumRights(EATools.str2StrArray(menuIds));
				pd.put("value",rights.toString());
			}else{
				pd.put("value","");
			}
			pd.put("ROLE_ID", ROLE_ID);
			roleService.saveB4Button(msg,pd);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	
}