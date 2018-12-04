package com.easaa.controller.goods;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.easaa.core.util.FtpUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.DesignerService;
@Controller
@RequestMapping("/sys/goods/designer/")
public class DesginerController extends BaseController{
	@Autowired
	private DesignerService  desginerService;
	
	/**
	 * 设计师列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		page.setShowCount(9);
		List<PageData>	varList = desginerService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("goods/designer/designerList");
		return mv;
	}
	/**
	 * 编辑
	 * @return
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id=getRequest().getParameter("id");
		mv.addObject("dataModel", desginerService.getById(EAString.stringToInt(id, 0)));
		mv.setViewName("goods/designer/designerEdit");
		return mv;
	}
	
	/**
	 * 保存	
	 * @param file
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam(required=false,value="designer_img") MultipartFile file, HttpServletRequest request) throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		if(data.getAsInt("designer_id") > 0){               //如果主键brand_id值大于0,说明是编辑
			if(file  != null  && !file.isEmpty()){
				String savePath = FtpUtil.upload(file, "mallframe", "product");
				data.put("designer_img", savePath);
			}
			desginerService.edit(data);
		}else{                                        //主键brand_id值不大于0,新增
			String savePath = FtpUtil.upload(file, "mallframe", "product");
			data.put("designer_img", savePath);
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			desginerService.create(data);
		}
		if(data==null||data.isEmpty()){
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/designer/listPage");
		return mv;
	}

}