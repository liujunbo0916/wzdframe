package com.easaa.controller.upm;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Menu;
import com.easaa.upm.service.MenuService;
import com.easaa.upm.upm.Jurisdiction;

import net.sf.json.JSONArray;

/**
 * 系统菜单管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/menu/")
public class MenuController extends BaseController{
	
	
	@Resource(name="menuService")
	private MenuService menuService;
/*	public ModelAndView list(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/menu/menu_list");
		return mv;
	}
	*/
	
	/**
	 * 显示菜单列表
	 * @param model
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString()))?"0":pd.get("MENU_ID").toString();
			List<Menu> menuList = menuService.listSubMenuByParentId(MENU_ID);
			mv.addObject("pd", menuService.getMenuById(pd));	//传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID);
			mv.addObject("MSG", null == pd.get("MSG")?"list":pd.get("MSG").toString()); //MSG=change 则为编辑或删除后跳转过来的
			mv.addObject("menuList", menuList);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName("system/menu/menu_list");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	@RequestMapping("main")
	public ModelAndView main() throws Exception{
		ModelAndView mv = this.getModelAndView();
		String json = "";
		JSONArray arr = JSONArray.fromObject(menuService.listAllMenu("0"));
		json = arr.toString().replaceAll("target", "tags").replaceAll("MENU_NAME", "text").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked").replaceAll("MENU_URL", "href");;
		json = json.replace(",\"nodes\":[]", "");
		mv.setViewName("system/menu/menu_btree");
		mv.addObject("menuJson", json);
		return mv;
	}
	
	@RequestMapping("menuJson")
	public void menuJson(HttpServletResponse response) throws Exception{
		JSONArray arr = JSONArray.fromObject(menuService.listAllMenu("0"));
		String json = arr.toString().replaceAll("target", "tags").replaceAll("MENU_NAME", "text").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked").replaceAll("MENU_URL", "href");;
		json = json.replace(",\"nodes\":[]", "");
		super.outJson(response, super.REQUEST_SUCCESS, "查询成功", json);
	}
	/**
	 * 请求编辑菜单页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit(String id)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("MENU_ID",id);				//接收过来的要修改的ID
			pd = menuService.getMenuById(pd);	//读取此ID的菜单数据
			mv.addObject("pd", pd);				//放入视图容器
			pd.put("MENU_ID",pd.get("PARENT_ID").toString());			//用作读取父菜单信息
			mv.addObject("pds", menuService.getMenuById(pd));			//传入父菜单所有信息
			mv.addObject("MENU_ID", pd.get("PARENT_ID").toString());	//传入父菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "edit");
			pd.put("MENU_ID",id);			//复原本菜单ID
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
			mv.setViewName("system/menu/menu_edit");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	@RequestMapping(value="/edit")
	public void edit(Menu menu,HttpServletResponse response)throws Exception{
		/*if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"修改菜单");
		try{
			menuService.edit(menu);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", menu);
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	/**
	 * 请求新增菜单页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String MENU_ID = (null == pd.get("MENU_ID") || "".equals(pd.get("MENU_ID").toString()))?"0":pd.get("MENU_ID").toString();//接收传过来的上级菜单ID,如果上级为顶级就取值“0”
			pd.put("MENU_ID",MENU_ID);
			mv.addObject("pds", menuService.getMenuById(pd));	//传入父菜单所有信息
			mv.addObject("MENU_ID", MENU_ID);					//传入菜单ID，作为子菜单的父菜单ID用
			mv.addObject("MSG", "add");							//执行状态 add 为添加
			mv.setViewName("system/menu/menu_edit");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 保存菜单信息
	 * @param menu
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add")
	public void add(Menu menu,HttpServletResponse response)throws Exception{
	/*	if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"保存菜单");
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			menu.setMENU_ID(String.valueOf(Integer.parseInt(menuService.findMaxId(pd).get("MID").toString())+1));
			menu.setMENU_ICON("menu-icon fa fa-leaf black");//默认菜单图标
			menuService.saveMenu(menu); //保存菜单
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", menu);
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}
	
	
	/**
	 * 删除菜单
	 * @param MENU_ID
	 * @param out
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public void delete(@RequestParam String MENU_ID,HttpServletResponse response)throws Exception{
		/*if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
*/		logBefore(logger, Jurisdiction.getUsername()+"删除菜单");
		try{
			if(menuService.listSubMenuByParentId(MENU_ID).size() > 0){//判断是否有子菜单，是：不允许删除
				super.outJson(response, super.REQUEST_FAILS, "请先删除子菜单", null);
			}else{
				menuService.deleteMenuById(MENU_ID);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
			super.outJson(response, super.REQUEST_SUCCESS, e.getMessage(), null);
		}
		super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
	}
	
	
	
	
}
