package com.easaa.controller.upm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.service.SysConfigService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 系统设置控制器
 * @author Administrator
 *
 */

@Controller
@RequestMapping("/cfg/")
public class SysConfigController  extends BaseController{

	@Autowired
	private SysConfigService sysConfigService;
	@RequestMapping("index")
	public ModelAndView index(){
		
		ModelAndView mv = this.getModelAndView();
		try{
			mv.setViewName("/system/config/setting");
			mv.addObject("config",sysConfigService.getSysConfig(this.getPageData()));
		}catch(Exception e){
		}
		return mv;
	}
	
	/**
	 * 更新配置表
	 */
	@RequestMapping("update")
	public void update(HttpServletResponse response,HttpServletRequest request){
		try {
			//更新系统配置
			sysConfigService.updateSys(this.getPageData(),request);
			super.outJson(response,super.REQUEST_SUCCESS, "更新成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS,e.getMessage(), null);
		}
	}
	
	/**
	 * 查询所有短信模板
	 * 
	 * @return
	 */
	@RequestMapping("getSmsTpllist")
	public ModelAndView getSmsTpllist(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("smsTpllist", sysConfigService.selectAllSmsTpl(pd));
		mv.setViewName("/system/config/smstpl_list");
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 跳转添加编辑短信
	 * @return
	 */
	@RequestMapping("smsTplAddEdit")
	public ModelAndView SmsTplAddEdit(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		if(EAUtil.isNotEmpty(pd.getAsString("id"))){
			List<PageData> pddata=sysConfigService.selectAllSmsTpl(pd);
			if(EAUtil.isNotEmpty(pddata) && pddata.size()==1){
				mv.addObject("smsTpl", pddata.get(0));
			}
		}
		mv.setViewName("/system/config/smstpl_edit");
		return mv;
	}

	/**
	 * 插入短信数据
	 */
	@RequestMapping("insertSmsTpl")
	public void insertSmsTpl(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			sysConfigService.insertSmsTpl(pd);
			pd.put("tpl_var", "00"+pd.getAsString("id"));
			sysConfigService.updateSmsTpl(pd);
			super.outJson(response, REQUEST_SUCCESS, "插入成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 修改短信数据
	 */
	@RequestMapping("updateSmsTpl")
	public void updateSmsTpl(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			sysConfigService.updateSmsTpl(pd);
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
	
}
