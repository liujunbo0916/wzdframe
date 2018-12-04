package com.easaa.controller.upm;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.template.service.TemplateItemService;
import com.easaa.template.service.TemplateService;
@Controller
@RequestMapping("/sys/upm/template/")
public class TemplateController extends BaseController{
	@Autowired
	private TemplateService  templateService;
	@Autowired
	private TemplateItemService  templateItemService;
	
	/**
	 * 模块列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateList")
	public ModelAndView templateList(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList=templateService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("upm/template/templateList");
		return mv;
	}
	/**
	 * 模块编辑
	 * @return
	 */
	@RequestMapping(value = "templateEdit")
	public ModelAndView templateEdit() {
		ModelAndView mv = this.getModelAndView();
		String id = getRequest().getParameter("id");
		mv.addObject("dataModel", templateService.getById(EAString.stringToInt(id, 0)));
		mv.setViewName("upm/template/templateEdit");
		return mv;
	}
	/**
	 * 模块保存
	 * @return
	 * @throws Exception 
	 * @throws IOException 
	 */
	@RequestMapping(value = "templateSave", method = RequestMethod.POST)
	public ModelAndView templateSave(@RequestParam(value = "files") MultipartFile [] files, HttpServletRequest request) throws IOException, Exception {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		if(EAUtil.isEmpty(data.get("template_id"))){
			data.put("template_title_img", FtpUtil.upload(files[0], "mallframe", "upm"));
			data.put("template_background_img", FtpUtil.upload(files[1], "mallframe", "upm"));
			data.put("is_enable", 1);
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			templateService.create(data);
		}else{
			if(!files[0].isEmpty()){
				data.put("template_title_img", FtpUtil.upload(files[0], "mallframe", "upm"));
			}
			if(!files[1].isEmpty()){
				data.put("template_background_img", FtpUtil.upload(files[1], "mallframe", "upm"));
			}
			templateService.edit(data);
		}
		if(data==null||data.isEmpty()){
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/upm/template/templateList");
		return mv;
	}
	/**
	 * @description  模块启用
	 * @author chenlt
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateUpdate")
	public ModelAndView templateUpdate() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(pd.getAsInt("type")==1){
			pd.put("is_enable", 1);
		}else if(pd.getAsInt("type")==0){
			pd.put("is_enable", 0);
		}
		templateService.edit(pd);
		mv.setViewName("redirect:/sys/upm/template/templateList");
		return mv;
	}
	
	/**
	 * @description  模块删除(物理)
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateDelete")
	public void templateDelete(HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		PageData data = this.getPageData();
		int i = templateService.delete(data);
		if(i==1){
			super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
		}else{
			super.outJson(response, REQUEST_FAILS, "删除失败", null);
		}
		/*mv.setViewName("redirect:/sys/upm/template/templateList");
		return mv;*/
	}
	
	/**
	 * 模块内容列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateItemList")
	public ModelAndView templateItemList(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList = templateItemService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("templateList", templateService.getByMap(pd));
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("upm/template/templateItemList");
		return mv;
	}
	/**
	 * 模块内容编辑
	 * @return
	 */
	@RequestMapping(value = "templateItemEdit")
	public ModelAndView templateItemEdit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		String id=getRequest().getParameter("id");
		mv.addObject("dataModel", templateItemService.getById(EAString.stringToInt(id, 0)));
		mv.addObject("templateList", templateService.getByMap(pd));
		mv.setViewName("upm/template/templateItemEdit");
		return mv;
	}
	/**
	 * 模块内容保存
	 * @return
	 * @throws Exception 
	 * @throws IOException 
	 */
	@RequestMapping(value = "templateItemSave", method = RequestMethod.POST)
	public ModelAndView templateItemSave(@RequestParam(value = "files") MultipartFile [] files, HttpServletRequest request) throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		if(EAUtil.isEmpty(data.get("item_id"))){
			data.put("item_icon", FtpUtil.upload(files[0], "mallframe", "upm"));
			data.put("item_img", FtpUtil.upload(files[1], "mallframe", "upm"));
			data.put("is_enable", 1);
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			templateItemService.create(data);
		}else{
			if(!files[0].isEmpty()){
				data.put("item_icon", FtpUtil.upload(files[0], "mallframe", "upm"));
			}
			if(!files[1].isEmpty()){
				data.put("item_img", FtpUtil.upload(files[1], "mallframe", "upm"));
			}
			templateItemService.edit(data);
		}
		if(data==null||data.isEmpty()){
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/upm/template/templateItemList");
		return mv;
	}
	
	/**
	 * @description  模块内容启用
	 * @author chenlt
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateItemUpdate")
	public ModelAndView templateItemUpdate() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(pd.getAsInt("type")==1){
			pd.put("is_enable", 1);
		}else if(pd.getAsInt("type")==0){
			pd.put("is_enable", 0);
		}
		templateItemService.edit(pd);
		mv.setViewName("redirect:/sys/upm/template/templateItemList");
		return mv;
	}
	
	/**
	 * @description  模块内容删除
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "templateItemDelete")
	public void templateItemDelete(HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		PageData data = this.getPageData();
		int i = templateItemService.delete(data);
		if(i==1){
			super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
		}else{
			super.outJson(response, REQUEST_FAILS, "删除失败", null);
		}
		/*mv.setViewName("redirect:/sys/upm/template/templateItemList");
		return mv;*/
	}
	
}