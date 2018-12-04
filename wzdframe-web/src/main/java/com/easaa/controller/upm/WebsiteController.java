package com.easaa.controller.upm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.service.WebsiteService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 网站信息
 * 
 * @author ryy
 *
 */
@Controller
@RequestMapping("/website/")
public class WebsiteController extends BaseController {

	@Autowired
	private WebsiteService websiteService;

	/**
	 * 查询所有 网站信息
	 * 
	 * @return
	 */
	@RequestMapping("getWebSitelist")
	public ModelAndView getWebSitelist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("websitelist", websiteService.getByPage(page));
		mv.setViewName("/upm/website/website_list");
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 跳转添加编辑网站信息
	 * 
	 * @return
	 */
	@RequestMapping("webSiteAddEdit")
	public ModelAndView webSiteAddEdit(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		mv.addObject("webSite", websiteService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/upm/website/website_edit");
		return mv;
	}

	/**
	 * 插入网站信息
	 */
	@RequestMapping("insertWebSite")
	public ModelAndView insertWebSite(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if (EAUtil.isEmpty(pd.getAsString("website_abstract")) && EAUtil.isNotEmpty(pd.getAsString("editorValue"))) {
			pd.put("website_abstract", pd.getAsString("editorValue"));
		}
		pd.put("create_time", EADate.getCurrentTime());
		websiteService.create(pd);
		mv.setViewName("redirect:/website/getWebSitelist");
		return mv;
	}

	/**
	 * 修改网站信息
	 */
	@RequestMapping("updateWebSite")
	public ModelAndView updateWebSite(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if (EAUtil.isEmpty(pd.getAsString("website_abstract")) && EAUtil.isNotEmpty(pd.getAsString("editorValue"))) {
			pd.put("website_abstract", pd.getAsString("editorValue"));
		}
		websiteService.edit(pd);
		mv.setViewName("redirect:/website/getWebSitelist");
		return mv;
	}

	/**
	 * 删除网站信息
	 */
	@RequestMapping("deleteWebSite")
	public void deleteWebSite(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			int id = EAString.stringToInt(pd.getAsString("id"), 0);
			if (id > 0) {
				websiteService.delete(pd);
			}
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
}
