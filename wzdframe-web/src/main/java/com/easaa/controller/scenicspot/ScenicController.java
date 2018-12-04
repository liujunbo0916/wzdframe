package com.easaa.controller.scenicspot;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import com.easaa.core.util.FtpUtilsAbove;
import com.easaa.core.util.Tools;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.ScenicLineService;
import com.easaa.scenicspot.service.ScenicService;

/**
 * 
 * 景点服务
 * 
 * @author liujunbo
 *
 */
@Controller
@RequestMapping("/sys/scenic/")
public class ScenicController extends BaseController {
	/**
	 * 分类列表
	 */
	@Autowired
	private ScenicService scenicService;
	
	@Autowired
	private ScenicLineService scenicLineService;
	
	/**
	 *涠洲岛编辑页面
	 */
	@RequestMapping("wzd")
	public ModelAndView wzd() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		pd.put("category_id", "-2");
		List<PageData> scenicList = scenicService.getByMap(pd);
		if(scenicList != null && scenicList.size() > 0){
			mv.addObject("dataModel", scenicList.get(0));
		}
		mv.setViewName("/scenic/wzd");
		return mv;
	}
	@RequestMapping("categorylist")
	public ModelAndView categoryList() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("dataModel", scenicService.categorySelectByMap(pd));
		mv.setViewName("/scenic/category/list");
		return mv;
	}

	/**
	 * 分类编辑页面
	 */
	@RequestMapping("categoryeditPage")
	public ModelAndView categoryEditPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		String id = pd.getAsString("id");
		if (EAUtil.isNotEmpty(pd) && EAUtil.isNotEmpty(id)) {
			List<PageData> data = scenicService.categorySelectByMap(pd);
			if (EAUtil.isNotEmpty(data) && data.size() > 0) {
				mv.addObject("dataModel", data.get(0));
			}
		}
		mv.setViewName("/scenic/category/edit");
		return mv;
	}

	/**
	 * 分类保存
	 */
	@MethodLog(remark="景区分类保存")
	@RequestMapping(value = "categorysave", method = RequestMethod.POST)
	public ModelAndView categoryEdit(@RequestParam(value = "scenic_logo") MultipartFile file,
			HttpServletRequest request) throws IOException, Exception {
		ModelAndView mv = this.getModelAndView();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		if (data.getAsInt("id") > 0) { // 如果主键id值大于0,说明是编辑
			if (file!=null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "wzd", "product");
				data.put("scenic_logo", savePath);
			}
			scenicService.categoryUpdate(data);
		} else { // 主键id值不大于0,新增
			data.put("scenic_create_time", EADate.getCurrentTime());
			String savePath = FtpUtil.upload(file, "wzd", "product");
			data.put("scenic_logo", savePath);
			scenicService.categoryInsert(data);
		}
		mv.setViewName("redirect:/sys/scenic/categorylist");
		return mv;
	}
	/**
	 * 分类删除
	 */
	@MethodLog(remark="景区分类删除")
	@RequestMapping(value = "delete")
	public void delete(HttpServletResponse response) {
		try {
			PageData data = getPageData();
			/**
			 * 判断有没有分类景点,再删除
			 */
			Page page = new Page();
			PageData pd = new PageData();
			pd.put("category_id", data.getAsString("category_id"));
			page.setPd(pd);
			List<PageData> list = scenicService.getByPage(page);
			if (list != null && list.size() > 0) {
				super.outJson(REQUEST_FAILS, "删除失败，当前分类有景区，请先删除景区！", null, response);
				return;
			}
			data.put("id", data.getAsString("category_id"));
			scenicService.deletecategory(data);
			super.outJson(REQUEST_SUCCESS, "删除成功!", null, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "删除失败，请联系管理员", null, response);
		}

	}
	/**
	 * 景点列表
	 */
	@RequestMapping("list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData cpd = new PageData();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> list = scenicService.getByPage(page);
		for (PageData pageData : list) {
			cpd.put("id", pageData.getAsString("category_id"));
			List<PageData> data = scenicService.categorySelectByMap(cpd);
			if (EAUtil.isNotEmpty(data) && data.size() > 0) {
				pageData.put("category_name", data.get(0).getAsString("scenic_category"));
			}
		}
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		if("1".equals(pd.getAsString("scenic_is_ticket"))){
			mv.setViewName("/ticket/scenic/list");
		}else{
			mv.setViewName("/scenic/list");
		}
		return mv;
	}
	/**
	 * 景点删除
	 * 
	 */
	@MethodLog(remark="景区删除")
	@RequestMapping("del")
	public void del(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			pd.put("id", pd.getAsString("scenic_id"));
			scenicService.delete(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "删除成功", null);
		}catch(Exception e){
			super.outJson(response, super.REQUEST_FAILS, "删除失败", null);
			e.printStackTrace();
		}
	}
	
	
	
	
	/**
	 * 景点编辑页面
	 */
	@RequestMapping("editPage")
	public ModelAndView editPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData cpd = new PageData();
		mv.addObject("categorylist", scenicService.categorySelectByMap(cpd));
		mv.addObject("dataModel", scenicService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/scenic/edit");
		return mv;
	}

	/**
	 * 景点编辑动作
	 */
	@MethodLog(remark="景区编辑")
	@RequestMapping("save")
	public ModelAndView save(@RequestParam(value = "scenic_logo") MultipartFile file, 
			@RequestParam(value="scenic_voice_path",required=false) MultipartFile voiceFile,
			@RequestParam(value="scenic_tip_resource",required=false) MultipartFile tipFile,
			HttpServletRequest request)
			throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		ModelAndView mv = this.getModelAndView();
		PageData data = getPageData(multipartRequest);
        if("-1".equals(data.getAsString("category_id"))){
        	mv.setViewName("redirect:/sys/scenic/wzd");
		}else{
			mv.setViewName("redirect:/sys/scenic/list");
		}
		if (StringUtils.isEmpty(data.getAsString("scenic_content"))) {
			data.put("scenic_content", data.getAsString("editorValue"));
		}
		if(voiceFile != null && voiceFile.getSize() > 0){
			//上传了音频文件
			FtpUtilsAbove ftpUtil = new FtpUtilsAbove();
			String[] result = ftpUtil.uploadVoice(voiceFile, "wzd", "voice");
			data.put("scenic_voice_path", result[0]);
			data.put("scenic_voice_hour", result[1]);
		}
		if(tipFile != null && tipFile.getSize() > 0){
			//上传了音频文件
			FtpUtilsAbove ftpUtil = new FtpUtilsAbove();
			String[] result = ftpUtil.uploadVoice(tipFile, "wzd", "voice");
			data.put("scenic_tip_resource", result[0]);
			data.put("scenic_tip_source_hour", result[1]);
		}
		if (StringUtils.isEmpty(data.getAsString("id"))) {
			if (file!=null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "wzd", "venue");
				data.put("scenic_logo", savePath);
			}
			data.put("scenic_create_time", EADate.getCurrentTime());
			Tools.replaceEmpty(data);
			scenicService.create(data);
		} else {
			if (file!=null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "wzd", "venue");
				data.put("scenic_logo", savePath);
			}
			Tools.replaceEmpty(data);
			scenicService.edit(data);
		}
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		return mv;
	}

	/**
	 * 景区相册详情
	 */
	@RequestMapping("albums")
	public ModelAndView albums() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("status", "1");
		List<PageData> imgs = scenicService.selectImgByMap(pd);
		mv.addObject("albumModel", imgs);
		mv.setViewName("/scenic/album");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 景区上传相册
	 */
	@MethodLog(remark="景区相册上传")
	@RequestMapping("uploadImg")
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
				data.put("img_path", filePath);
				data.put("scenic_id",data.getAsString("goods_id"));
				data.put("status","1");
				scenicService.insertImg(data);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}
	/**
	 * 删除景区图片
	 */
	@MethodLog(remark="景区图片删除")
	@RequestMapping("delImg")
	public void delStockImg(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			scenicService.deleteImgsById(pd);
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}
	/**
	 * 攻略管理
	 * 
	 */
	@RequestMapping("line")
	public ModelAndView line(){
		ModelAndView mv = this.getModelAndView();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("dataModel", scenicLineService.getByPage(page));
		mv.setViewName("/scenic/line/line-list");
		return mv;
	}
	
	/**
	 * 删除攻略
	 */
	@MethodLog(remark="攻略删除")
	@RequestMapping("deleteLine")
	public void deleteLine(HttpServletResponse response){
		try {
			PageData pd =  this.getPageData();
			scenicLineService.deleteLine(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		} catch (Exception e) {
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	
	
	
	/**
	 * 添加攻略页面
	 */
	@RequestMapping("addLinePage")
	public ModelAndView addLinePage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		int id = EAString.stringToInt(pd.getAsString("id"), 0);
		if(id != 0 ){
			pd.put("id", id);
			List<PageData> pds = scenicLineService.getByMap(pd);
			mv.addObject("dataModel", pds != null && pds.size() > 0 ?pds.get(0):null);
			/**
			 * 查询关联景点
			 */
			pd.put("line_id", pd.getAsString("id"));
			List<PageData> scenicList = scenicLineService.selectScenicByLine(pd);
			StringBuffer lineScenicStr = new StringBuffer();
			StringBuffer scenicIds = new StringBuffer();
			if(scenicList != null && scenicList.size() > 0){
				mv.addObject("scenics",scenicList );
				for(PageData tpd : scenicList){
					scenicIds.append(tpd.getAsString("id")+",");
					lineScenicStr.append(tpd.getAsString("id")+","+tpd.getAsString("line_scenic_desc"));
					lineScenicStr.append("|");
				}
				mv.addObject("lineScenicStr", lineScenicStr.substring(0, lineScenicStr.length()-1));
				mv.addObject("scenicIds", scenicIds.substring(0, scenicIds.length()-1));
			}
			
		}
		mv.setViewName("/scenic/line/edit");
		return mv;
	}
	
	/**
	 * 添加景点页面
	 */
	@RequestMapping("addLineScenicPage")
	public ModelAndView addLineScenicPage(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("categorylist", scenicService.categorySelectByMap(pd));
		mv.addObject("pd", pd);
		mv.setViewName("/scenic/line/addScenic");
		return mv;
	}
	/**
	 * 景点选择页面
	 */
	@RequestMapping("selectScenic")
	public ModelAndView selectScenic(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String excludeScenicIds = pd.getAsString("excludeScenicIds");
		if(StringUtils.isNotEmpty(excludeScenicIds)){
			pd.put("excludeScenicIds", "("+excludeScenicIds+")");
		}
		mv.addObject("dataModel", scenicService.selectExcludeLine(pd));
		mv.setViewName("/scenic/line/selectScenic");
		return mv;
	}
	
	/**
	 * 添加攻略
	 */
	@MethodLog(remark="添加攻略")
	@RequestMapping("addScenicLine")
	public ModelAndView addScenicLine(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value = "line_logo") MultipartFile file){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try{
			if(file != null && file.getSize() > 0){
				String fileName = FtpUtil.upload(file, "wzd", "line");
				data.put("line_logo", fileName);
			}
			if(StringUtils.isNotEmpty(data.getAsString("id"))){
				//编辑
				scenicLineService.editCustom(data);
			}else{
				//新增
				scenicLineService.insertCustom(data);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		mv.setViewName("redirect:/sys/scenic/line");
		return mv;
	}
	/**
	 * 删除攻略中的景点
	 */
	@RequestMapping("deleteLineScenic")
	public void deleteLineScenic(HttpServletResponse response){
		try {
			PageData pd =  this.getPageData();
			pd.put("scenicAndLine", "scenicAndLine");
			scenicLineService.deleteScenic(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		} catch (Exception e) {
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
}
