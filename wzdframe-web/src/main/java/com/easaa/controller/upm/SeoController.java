package com.easaa.controller.upm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.HttpRequest;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.service.SeoService;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.util.properties.PropertiesHelper;

/**
 *	seo优化 
 * @author ryy
 *
 */
@Controller
@RequestMapping("/seo/")
public class SeoController extends BaseController {

	@Autowired
	private SeoService seoService;

	/**
	 * 查询所有 seo优化
	 * 
	 * @return
	 */
	@RequestMapping("getseolist")
	public ModelAndView getseolist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("seolist", seoService.getByPage(page));
		mv.setViewName("/upm/seo/seo_list");
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 跳转添加编辑seo优化
	 * @return
	 */
	@RequestMapping("seoAddEdit")
	public ModelAndView seoAddEdit(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		mv.addObject("seo", seoService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/upm/seo/seo_edit");
		return mv;
	}

	/**
	 * 插入seo优化
	 */
	@RequestMapping("insertseo")
	public void insertseo(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			pd.put("create_time", EADate.getCurrentTime());
			seoService.create(pd);
			if(EAUtil.isNotEmpty(pd.getAsString("id"))){
				pd.put("seo_code", "00"+pd.getAsString("id"));
				seoService.edit(pd);
			}
			HttpRequest.sendPost(PropertiesHelper.getWechatUrl()+"api/internal/clearSeo", "");
			super.outJson(response, REQUEST_SUCCESS, "插入成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 修改seo优化
	 */
	@RequestMapping("updateseo")
	public void updateseo(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			seoService.edit(pd);
			HttpRequest.sendPost(PropertiesHelper.getWechatUrl()+"api/internal/clearSeo", "");
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
	
	/**
	 * 删除seo优化
	 */
	@RequestMapping("deleteseo")
	public void deleteseo(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			int id=EAString.stringToInt(pd.getAsString("id"), 0);
			if(id > 0){
				seoService.delete(pd);
			}
			HttpRequest.sendPost(PropertiesHelper.getWechatUrl()+"api/internal/clearSeo", "");
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
}
