package com.easaa.controller.scenicspot;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentCategoryService;
import com.easaa.content.service.ContentService;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.FtpUtilsAbove;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.CultureService;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/culture/")
public class CultureController extends BaseController{
	@Autowired
	private CultureService cultureService;
	
	@Autowired
	private ContentCategoryService contentCategoryService;
	
	@Autowired
	private ContentService contentService;
	
	
	/**
	 * 文化分类
	 */
	@RequestMapping("category/list")
	public ModelAndView categoryList(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("varList", cultureService.categorySelectByMap(pd));
		mv.setViewName("/culture/category/list");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	 * 文化分类编辑页面
	 */
	@RequestMapping("category/editPage")
	public ModelAndView categoryEditPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		
		
		/**
		 * 查询内容类目
		 */
		PageData contentCategory = new PageData();
		contentCategory.put("DISABLED", 1);
		mv.addObject("contentCate", contentCategoryService.getByMap(contentCategory));
		if(StringUtils.isNotEmpty(pd.getAsString("id"))){
			mv.addObject("dataModel", cultureService.categorySelectOneByMap(pd));
		}
		mv.setViewName("/culture/category/edit");
		return mv;
	}
	/**
	 * 文化分类添加编辑动作
	 */
	@RequestMapping("category/editAction")
	public ModelAndView categoryEditAction(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(required=false,value = "culture_category_logo") MultipartFile file){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try{
			if(file != null && file.getSize() > 0){
				String fileName = FtpUtil.upload(file, "wzd", "culture");
				data.put("culture_category_logo", fileName);
			}
			if(StringUtils.isNotEmpty(data.getAsString("id"))){
				//编辑
				cultureService.categoryUpdate(data);
			}else{
				data.put("culture_category_status", 1);
				data.put("culture_category_time", EADate.getCurrentTime());
				//新增
				cultureService.categoryInsert(data);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		mv.setViewName("redirect:/sys/culture/category/list");
		return mv;
	}
	@RequestMapping("category/delete")
	public void categoryDelete(HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			pd.put("culture_category_status", 2);
			cultureService.categoryUpdate(pd);
			super.outJson(this.REQUEST_SUCCESS, "删除成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(this.REQUEST_FAILS, "删除失败，请联系管理员", null, response);
		}
	}
	
	@RequestMapping("resource/addPage")
	public ModelAndView  addResourcePage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
	    pd =  cultureService.categorySelectOneByMap(pd);
	    List<PageData> resouceList = null;
	    if(pd != null){
	    	if("3".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/culture/images_show");
	    		resouceList = encaResouceList(pd);
	    	}
	    	if("4".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/culture/text_show");
	    		//如果是text类型去内容表里面查询相应类目的新闻
	    		PageData contentParam = new PageData();
	    		contentParam.put("CATEGORY_CODE", pd.getAsString("culture_category_content"));
	    		resouceList = contentService.getByMap(contentParam);
	    	}
	    	if("2".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/culture/voice_show");
	    		resouceList = encaResouceList(pd);
	    	}
	    	if("1".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/culture/video_show");
	    		resouceList = encaResouceList(pd);
	    	}
	    }
	    mv.addObject("albumModel", resouceList);
	    mv.addObject("pd", pd);
		return mv;
	}
	
	private List<PageData> encaResouceList(PageData pd){
	    PageData cultureParam = new PageData();
	    cultureParam.put("category_id", pd.getAsString("id"));
	    List<PageData> resouceList = cultureService.getByMap(cultureParam);
	    /**
	     * 将音视频里面的时间 将秒转成分秒
	     */
	    for (int i = 0; i < resouceList.size(); i++) {
			if(StringUtils.isNotEmpty(resouceList.get(i).getAsString("resource_hour"))){
				int  hour = EAString.stringToInt(resouceList.get(i).getAsString("resource_hour"), 0);
				//将hour转成  分秒形式
				int sec = hour % 60;
				int min = hour / 60;
				String minStr = StringUtils.leftPad(min+"",2, "0");
				String secStr = StringUtils.leftPad(sec+"",2, "0");
				resouceList.get(i).put("resource_hour_format", minStr+":"+secStr);
			}
		}
	    return resouceList;
	}
	
	/**
	 * 图片上传
	 */
	@RequestMapping("resource/uploadImg")
	public void saveStockImg(HttpServletResponse response,HttpServletRequest request) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			MultipartFile file = multipartRequest.getFile("file");
			String filePath = "";
			if(file != null){
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				filePath = ftp.upload(file, "wzd", "images");
				data.put("resource_path", filePath);
				data.put("category_id",data.getAsString("goods_id"));
				cultureService.create(data);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}
	
	/**
	 * 跳转视频上传页面
	 */
	@RequestMapping("resource/uploadVedioPage")
	public ModelAndView goUploadVideoPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getAsString("resource_id"))){ //编辑
			pd.put("id", pd.getAsString("resource_id"));
			PageData modelData = cultureService.getOneByMap(pd);
			mv.addObject("modelData", modelData);
		}
		mv.setViewName("/culture/video_upload");
		mv.addObject("pd",pd);
		return mv;
	}
	
	
	
	/**
	 * 视频上传
	 */
	@RequestMapping("resource/uploadVedio")
	public ModelAndView uploadVedio(HttpServletResponse response,HttpServletRequest request,
			@RequestParam(value = "resource_path",required=false) MultipartFile file) {
		ModelAndView mv = this.getModelAndView();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			if(file != null){
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				String[] result  = ftp.uploadVedio(file, "wzd", "vedio");
				data.put("resource_path", result[0]);
				data.put("resource_img", result[1]);
				data.put("resource_hour", result[2]);
				data.put("category_id",data.getAsString("category_id"));
				cultureService.create(data);
			}
			if(StringUtils.isNotEmpty(data.getAsString("id")) && file == null){
				cultureService.edit(data); //更新
			}
			PrintWriter out = response.getWriter();
			out.write("<script>parent.location.reload();close();</script>");
			out.flush();
			out.close();
/*			mv.setViewName("redirect:/sys/culture/resource/addPage?id="+data.getAsString("category_id"));
*/		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/common/error");
		}
		return null;
	}
	/**
	 * 视频上传
	 */
/*	@RequestMapping("resource/uploadVedio")
	public void uploadVedio(HttpServletResponse response,HttpServletRequest request) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			MultipartFile file = multipartRequest.getFile("file");
			String filePath = "";
			if(file != null){
				*//**
				 * 更新相册
				 *//*
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				String[] result  = ftp.uploadVedio(file, "wzd", "vedio");
				data.put("resource_path", result[0]);
				data.put("resource_img", result[1]);
				data.put("category_id",data.getAsString("goods_id"));
				cultureService.create(data);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}*/
	
	/**
	 * 音频上传 开始
	 * 
	 */
	/**
	 * 跳转到音频上传页面
	 */
	@RequestMapping("resource/uploadVoicePage")
	public ModelAndView uploadVoicePage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("/culture/voice_upload");
		mv.addObject("pd",pd);
		return mv;
	}
	/**
	 * 音频文件上传
	 */
	@RequestMapping("resource/uploadVoice")
	public ModelAndView uploadVoice(HttpServletResponse response,HttpServletRequest request,
			@RequestParam(value = "resource_path",required=false) MultipartFile file,
			@RequestParam(value = "resource_img",required=false) MultipartFile imgFile) {
		ModelAndView mv = this.getModelAndView();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			if(imgFile != null && imgFile.getSize() > 0){
				String imgFilePath = FtpUtil.upload(imgFile, "wzd", "img");
				data.put("resource_img", imgFilePath);
			}
			if(file != null){
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				String[] result  = ftp.uploadVoice(file, "wzd", "voice");
				data.put("resource_path", result[0]);
				data.put("resource_hour", result[1]);
				data.put("category_id",data.getAsString("category_id"));
				cultureService.create(data);
			}
			if(StringUtils.isNotEmpty(data.getAsString("id")) && file == null){
				cultureService.edit(data); //更新
			}
			PrintWriter out = response.getWriter();
			out.write("<script>parent.location.reload();close();</script>");
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/common/error");
		}
		return null;
	}
	
	
	
	
	
	
	
	/**
	 * 图片删除
	 */
	@RequestMapping("resource/delete")
	public void delete(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			 if("-2".equalsIgnoreCase(pd.getAsString("id"))){
				 PageData allPd = new PageData();
				 allPd.put("category_id", pd.getAsString("category_id"));
				 cultureService.delete(allPd);
			}else if(StringUtils.isNotEmpty(pd.getAsString("id"))){
				cultureService.delete(pd);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}
	/**
	 * 播放视频
	 */
	@RequestMapping("resource/autoPlayVideo")
	public ModelAndView autoPlayVideo(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getAsString("id"))){
			mv.addObject("dataModel", cultureService.getOneByMap(pd));
		}
		mv.setViewName("culture/player");
		return mv;
	}
	
	/**
	 * 测试播放音频文件样式
	 */
	
	@RequestMapping("test/style")
	public ModelAndView testCss(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("culture/circle");
		return mv;
	}
	
	
	
}
