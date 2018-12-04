package com.easaa.controller.ticket;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.TicketService;

/**
 * 票务系统
 * 
 * @author liujunbo
 *
 */
@Controller
@RequestMapping("/sys/ticket/")
public class TicketController  extends BaseController{
   
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private ScenicService scenicService;
	
	
	/**
	 * 
	 * 票类分类列表
	 */
	@RequestMapping("categoryList")
	public ModelAndView  categoryList(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("dataModel", ticketService.categorySelectByMap(pd));
		mv.setViewName("/ticket/category/list");
		return mv;
	}
	
	
	@RequestMapping("categoryEditPage")
	public ModelAndView  categoryEditPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getAsString("id"))){
			mv.addObject("dataModel", ticketService.categorySelectByMap(pd).get(0));
		}
		mv.setViewName("/ticket/category/edit");
		return mv;
	}
	@MethodLog(remark="票分类编辑")
	@RequestMapping("categoryEdit")
	public void  categoryEdit(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			if(StringUtils.isNotEmpty(pd.getAsString("id"))){
				ticketService.categoryUpdate(pd);
			}else{
				ticketService.categoryInsert(pd);
			}
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	@MethodLog(remark="票分类删除")
	@RequestMapping("categoryDel")
	public void  categoryDel(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			if(StringUtils.isNotEmpty(pd.getAsString("id"))){
				ticketService.categoryDel(pd);
			}
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	@RequestMapping("list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> list = ticketService.getByPage(page);
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("/ticket/list");
		return mv;
	}
	/**
	 * 景点删除
	 * 
	 */
	@MethodLog(remark="票类删除")
	@RequestMapping("del")
	public void del(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			ticketService.delete(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "删除成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, "删除失败", null);
			e.printStackTrace();
		}
	}
	/**
	 * 票类编辑页面
	 */
	@RequestMapping("editPage")
	public ModelAndView editPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		pd.put("scenic_is_ticket", "1");
		mv.addObject("scenicList", scenicService.getByMap(pd));
		mv.addObject("cateList", ticketService.categorySelectByMap(pd));
		mv.addObject("dataModel", ticketService.getById(EAString.stringToInt(pd.getAsString("t_id"), 0)));
		mv.setViewName("/ticket/edit");
		return mv;
	}
	@MethodLog(remark="票类编辑")
	@RequestMapping("eidt")
	public void eidt(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			if(StringUtils.isNotEmpty(pd.getAsString("id"))){
				ticketService.edit(pd);
			}else{
				pd.put("create_time", EADate.getCurrentTime());
				ticketService.create(pd);
			}
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功",null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	/**
	 * 查询第三方票务公司 票务信息
	 */
	@RequestMapping("selectTicketForThird")
	public void selectTicketForThird(HttpServletResponse response,String ticketTypeId){
		try{
			super.outJson(response, super.REQUEST_SUCCESS, "查询成功", com.easaa.scenicspot.assembly.TicketService.getTicketTypes("1", "20", ticketTypeId));
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, "查询失败", null);
		}
	}
	
	
	
	
	
	
}
