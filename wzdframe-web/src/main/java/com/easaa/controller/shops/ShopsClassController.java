package com.easaa.controller.shops;

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
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.ShopClassService;

/**
 * 商铺分类  
 * @author ryy
 */
@Controller
@RequestMapping("/sys/shops/class/")
public class ShopsClassController extends BaseController {

	@Autowired
	private ShopClassService businessClassService;

	/**
	 * 商铺分类列表
	 * 
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list(HttpServletResponse response, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", businessClassService.getByPage(page));
		mv.setViewName("shops/class/list");
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 跳到新增商铺分类
	 */
	@RequestMapping("editPage")
	public ModelAndView addPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = businessClassService.getById(pd.getAsInt("sc_id"));
		mv.addObject("dataModel", data);
		mv.setViewName("shops/class/edit");
		return mv;
	}

	/**
	 * 新增修改商铺分类
	 */
	@MethodLog(remark="店铺分类添加/编辑")
	@RequestMapping("save")
	public void save(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = getPageData();
			if(EAUtil.isNotEmpty(pd.getAsString("sc_id"))){
				businessClassService.edit(pd);
			}else{
				businessClassService.create(pd);
			}
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "系统异常", null, response);
		}
	}

	/**
	 * 删除商铺分类
	 */
	@MethodLog(remark="店铺分类删除")
	@RequestMapping("delete")
	public void delete(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = getPageData();
			PageData data=businessClassService.getById(pd.getAsInt("sc_id"));
			if(EAUtil.isNotEmpty(data)){
				businessClassService.delete(pd);
			}else{
				super.outJson(REQUEST_FAILS, "删除异常", null, response);
				return;
			}
			super.outJson(REQUEST_SUCCESS, "删除成功", null, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "系统异常", null, response);
		}
	}
}
