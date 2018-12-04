package com.easaa.controller.scenicspot;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.dao.GuideSerMapper;
import com.easaa.scenicspot.service.ScenicService;

@RequestMapping("/sys/book/order/")
@Controller
public class BookOrderController extends BaseController{


	@Autowired
	private GuideSerMapper guideSerMapper;
	/**
	 * 保修管理
	 */
	@RequestMapping("guideOrder")
	public ModelAndView guideOrder(){
		ModelAndView mv = this.getModelAndView();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("dataModel", guideSerMapper.selectByPage(page));
		mv.setViewName("/bookService/guideOrderList");
		return mv;
	}
	/**
	 *打开编辑页面
	 */
	@RequestMapping("guideEditPage")
	public ModelAndView guideEditPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		page.setPd(pd);
		List<PageData> guides = guideSerMapper.selectByMap(page);
		mv.addObject("dataModel", (guides== null || guides.size() == 0) ? null : guides.get(0));
		mv.setViewName("/bookService/guideOrderEdit");
		return mv;
	}
	/**
	 * 受理用户反馈信息
	 */
	@RequestMapping("acceptancePage")
	public ModelAndView acceptancePage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.setViewName("/bookService/acceptance");
		return mv;
	}
	
	/**
	 * 反馈信息执行受理
	 */
	@MethodLog(remark="反馈受理")
	@RequestMapping("acceptance")
	public void acceptance(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			guideSerMapper.updateFeed(pd);
			super.outJson(super.REQUEST_SUCCESS, "受理成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "受理失败", null, response);
		}
	}
	
	@RequestMapping("guideEdit")
	public void guideEdit(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			guideSerMapper.update(pd);
			super.outJson(super.REQUEST_SUCCESS, "受理成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "受理失败", null, response);
		}
	}
	/**
	 * 删除导游服务
	 * @param response
	 */
	@MethodLog(remark="删除导游服务")
	@RequestMapping("delGuide")
	public void delGuide(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			Page page = this.getPage();
			page.setPd(pd);
			guideSerMapper.delete(page);
			super.outJson(super.REQUEST_SUCCESS, "受理成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "受理失败", null, response);
		}
	} 
	/**
	 * 删除反馈
	 * @param response
	 */
	@MethodLog(remark="删除反馈")
	@RequestMapping("delFeed")
	public void delFeed(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			guideSerMapper.deleteFeed(pd);
			super.outJson(super.REQUEST_SUCCESS, "删除成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "删除成功", null, response);
		}
	} 
	/**
	 * 反馈  保修单
	 */
	@RequestMapping("feedBackListPage")
	public ModelAndView feedBackListPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		page.setPd(pd);
		List<PageData> guides = guideSerMapper.feedBackListPage(page);
		mv.addObject("dataModel", guides);
		mv.setViewName("/bookService/feedOrderList");
		return mv;
	}
	/**
	 * 保修列表
	 */
	@RequestMapping("feedOrder")
	public ModelAndView feedOrder(){
		ModelAndView mv = this.getModelAndView();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("dataModel", guideSerMapper.selectByPage(page));
		mv.setViewName("/bookService/feedOrderList");
		return mv;
	}
	
}
