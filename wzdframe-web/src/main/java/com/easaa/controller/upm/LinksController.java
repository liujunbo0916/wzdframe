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
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.service.LinksService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 友情链接
 * @author ryy
 *
 */
@Controller
@RequestMapping("/links/")
public class LinksController extends BaseController {

	@Autowired
	private LinksService linksService;

	/**
	 * 查询所有 友情链接
	 * 
	 * @return
	 */
	@RequestMapping("getlinkslist")
	public ModelAndView getlinkslist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("linkslist", linksService.getByPage(page));
		mv.setViewName("/upm/links/links_list");
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 跳转添加编辑友情链接
	 * @return
	 */
	@RequestMapping("linksAddEdit")
	public ModelAndView linksAddEdit(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		mv.addObject("links", linksService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/upm/links/links_edit");
		return mv;
	}

	/**
	 * 插入友情链接
	 */
	@RequestMapping("insertlinks")
	public void insertlinks(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			pd.put("create_time", EADate.getCurrentTime());
			linksService.create(pd);
			super.outJson(response, REQUEST_SUCCESS, "插入成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 修改友情链接
	 */
	@RequestMapping("updatelinks")
	public void updatelinks(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			linksService.edit(pd);
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
	
	/**
	 * 删除友情链接
	 */
	@RequestMapping("deletelinks")
	public void deletelinks(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			int id=EAString.stringToInt(pd.getAsString("id"), 0);
			if(id > 0){
				linksService.delete(pd);
			}
			super.outJson(response, REQUEST_SUCCESS, "修改成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, e.getMessage(), null);
		}
	}
}
