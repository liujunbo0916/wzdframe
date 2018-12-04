package com.easaa.controller.content;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.content.service.ContentCategoryService;
import com.easaa.content.service.ContentService;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.model.dao.EADao;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EATools;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.FtpUtilsAbove;
import com.easaa.core.util.Tools;
import com.easaa.entity.ImageFormat;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.dao.SiteSetMapper;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.SiteSetService;
import com.easaa.scenicspot.service.TicketService;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/content/")
public class ContentController extends BaseController {

	@Autowired
	private ContentService contentService;
	@Autowired
	private ContentCategoryService contentCategoryService;
	@Autowired
	private SiteSetService siteSetService;
	@Autowired
	private GroupTourService groupTourService;
	@Autowired
	private TicketService ticketService;

	
	@RequestMapping(value = { "list", "" })
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表Content");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = contentService.getByPage(page); // 列出Content列表
		for (PageData ct : varList) {
			int state = ct.getAsInt("STATE");
			if (state == -1 || state == 3) {
				ct.put("del", 1);
			} else {
				ct.put("del", 0);
			}
		}
		pd.put("parentId", '0');
		pd.put("CATEGORY_TYPE", pd.getString("type"));
		/*
		 * List<PageData> catetList =
		 * contentCategoryService.recurseAllCategory(pd);
		 */
		mv.setViewName("content/content_list");
		mv.addObject("varList", varList);
		/* mv.addObject("catetList", catetList); */
		mv.addObject("pd", pd);
		mv.addObject("CATEGORY_TYPE", pd.getString("type"));
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 文章新增、编辑
	 */
	@RequestMapping("goEdit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData data = contentService.getById(EAString.stringToInt(pd.getAsString("CONTENT_ID"), 0));

		if(EAUtil.isNotEmpty(data)){
			if("1".equals(data.getAsString("CTYPE")) && "1".equals(data.getAsString("SUBJECT_CODE")) && StringUtils.isNotEmpty(data.getAsString("SUBJECT_ID")) ){
				data.put("relation", groupTourService.getById(EAString.stringToInt(data.getAsString("SUBJECT_ID"), 0)));
			}else if("1".equals(data.getAsString("CTYPE")) && "2".equals(data.getAsString("SUBJECT_CODE")) && StringUtils.isNotEmpty(data.getAsString("SUBJECT_ID"))){
				data.put("relation", ticketService.getById(EAString.stringToInt(data.getAsString("SUBJECT_ID"), 0)));
			}else{
				data.put("relation", "");
			}
			/**
			 * 查询相册
			 */
			if ("1".equals(data.getAsString("MODEL_TYPE"))) {
				data.put("albums", contentService.selectContentAlbums(data.getAsInt("CONTENT_ID")));
			}
		}
		mv.addObject("pd", data);
		/**
		 * 查询所有的栏目
		 */
		if (StringUtils.isNotEmpty(pd.getAsString("CONTENT_ID")) && !"0".equals(pd.getAsString("CONTENT_ID"))) {
			mv.addObject("msg", "edit");
		} else {
			mv.addObject("msg", "save");
		}
		pd.put("DISABLED", 1);
		mv.addObject("categoryList", contentCategoryService.getByMap(pd));
		mv.setViewName("content/content_edit");
		return mv;
	}

	/**
	 * 文章保存
	 */
	@MethodLog(remark="内容保存")
	@RequestMapping(value = "/save")
	@ResponseBody
	public void save(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		if (StringUtils.isEmpty(pd.getAsString("CONTENT"))) {
			pd.put("CONTENT", pd.getAsString("editorValue"));
		}
		System.out.println("<><><>><<><><><>><" + pd.getAsString("ISHOT"));
		System.out.println("<><<>><><><<><>" + pd.getAsString("ISFOCUS"));
		try {
			pd.put("RECOMMEND", Boolean.parseBoolean(pd.getString("RECOMMEND")));
			pd.put("DRAFT", Boolean.parseBoolean(pd.getString("DRAFT")));
			pd.put("ISHOT", Boolean.parseBoolean(pd.getString("ISHOT")));
			pd.put("ISFOCUS", Boolean.parseBoolean(pd.getString("ISFOCUS")));
			pd.put("TOPLV", StringUtils.isNotEmpty(pd.getAsString("TOPLV")) ? pd.get("TOPLV") : 0);
			pd.put("CREATETIME", Tools.date2Str(new Date()));
			pd.put("CREATOR", Jurisdiction.getUsername());
			if ("2".equalsIgnoreCase(pd.getAsString("STATE"))) {
				pd.put("PUTTIME", EADate.getCurrentTime());
			}
			if (pd.get("MODEL_TYPE") != null && "1".equals(pd.getAsString("MODEL_TYPE"))) {
				List<PageData> albums = contentService.selectContentAlbums(pd.getAsInt("CONTENT_ID"));
				if (albums == null || albums.size() != 3) {
					super.outJsonString(response, false, "文章相册有误，请上传3张图片！", null);
					return;
				}
				pd.put("T_IMG", albums.get(0).getAsString("original_img"));
			}
			if ("0".equalsIgnoreCase(pd.getAsString("CTYPE"))) {
				pd.put("SUBJECT_CODE", "0");
				pd.put("SUBJECT_ID", "0");
			}
			contentService.create(pd);
			super.outJsonString(response, true, "操作成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJsonString(response, false, e.getMessage(), null);
		}
	}
	@MethodLog(remark="删除内容")
	@RequestMapping("delete")
	public void contentDelete(HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			if("20".equals(pd.getAsString("STATE"))){
				contentService.delete(pd);
			}else{
				contentService.edit(pd);
			}
			super.outJsonString(response, true, "操作成功", null);
		}catch(Exception e){
			super.outJsonString(response, false, e.getMessage(), null);
		}
	}
	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@MethodLog(remark="修改内容")
	@RequestMapping(value = "/edit")
	@ResponseBody
	public void edit(HttpServletResponse response) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Content");
		PageData pd = this.getPageData();
		if (StringUtils.isEmpty(pd.getAsString("CONTENT"))) {
			pd.put("CONTENT", pd.getAsString("editorValue"));
		}
		try {
			pd.put("RECOMMEND", Boolean.parseBoolean(pd.getString("RECOMMEND"))); // 创建时间
			pd.put("DRAFT", Boolean.parseBoolean(pd.getString("DRAFT"))); // 是否草稿
			pd.put("ISHOT", Boolean.parseBoolean(pd.getString("ISHOT"))); // 是否头条
			pd.put("ISFOCUS", Boolean.parseBoolean(pd.getString("ISFOCUS"))); // 是否焦点
			pd.put("OP_USER_ID", Jurisdiction.getUsername());
			pd.put("OP_REMARK", pd.get("OP_REMARK"));
			pd.put("TOPLV", (StringUtils.isEmpty(pd.getAsString("TOPLV"))) ? 0 : pd.get("TOPLV"));
			pd.put("MODIFIER", Jurisdiction.getUsername());
			if ("2".equalsIgnoreCase(pd.getAsString("STATE"))) {
				pd.put("PUTTIME", EADate.getCurrentTime());
			}
			if (pd.get("MODEL_TYPE") != null && "1".equals(pd.getAsString("MODEL_TYPE"))) {
				List<PageData> albums = contentService.selectContentAlbums(pd.getAsInt("CONTENT_ID"));
				if (albums == null || albums.size() != 3) {
					super.outJsonString(response, false, "文章相册有误，请上传3张图片！", null);
					return;
				}
				//同时修改列表图
				pd.put("T_IMG", albums.get(0).getAsString("original_img"));
			}
			if ("0".equalsIgnoreCase(pd.getAsString("CTYPE"))) {
				pd.put("SUBJECT_CODE", "0");
				pd.put("SUBJECT_ID", "0");
			}
			contentService.edit(pd);
			super.outJsonString(response, true, "操作成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJsonString(response, false, e.toString(), null);

		}
	}

	@RequestMapping(value = "/saveImag")
	public void saveImag(HttpServletResponse response, HttpServletRequest request,
			@RequestParam(required = false) MultipartFile file,
			@RequestParam(value = "tname", required = false) String tname,
			@RequestParam(value = "CONTENT_ID", required = false) String CONTENT_ID,
			@RequestParam(value = "CATEGORY_TYPE", required = false) String CATEGORY_TYPE) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增资讯图片");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		file = multipartRequest.getFile(tname);
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = this.getPageData();
		pd.put("CATEGORY_TYPE", CATEGORY_TYPE);
		String path = null;
		if (null != file && !file.isEmpty()) {
			path = FtpUtil.upload(file, "wzd", "content");
			/**
			 * 对图片进行压缩处理
			 */
			try {
				String fileName = path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
				ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(234, 140, "list", fileName) }; // 网站图片规格
				EATools.dealWithImgs(file, imageFormats);
				for (ImageFormat tif : imageFormats) {
					FtpUtil.upload(tif, "wzd", "content");
					if (tif.getFile().exists()) {
						tif.getFile().delete();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			pd.put("path", path);
			pd.put("IMGLABER", tname);
			map.put("result", "true");
		} else {
			map.put("result", "false");
		}
		map.put("path", path);
		if ("TIMG".equals(tname)) {
			tname = "T_IMG";
		} else if ("CIMG".equals(tname)) {
			tname = "C_IMG";
		}
		map.put("labname", tname);
		super.outJson(response, super.REQUEST_SUCCESS, "保存成功", map);
	}

	/**
	 * 删除图片
	 * 
	 * @param response
	 */
	@RequestMapping("delImg")
	public void deleteImg(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			if ("T_IMG".equals(pd.getAsString("type"))) {
				pd.put("T_IMG", "T_IMG");
			}
			if ("C_IMG".equals(pd.getAsString("type"))) {
				pd.put("C_IMG", "C_IMG");
			}
			contentService.deleteImg(pd);
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		} catch (Exception e) {
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	@RequestMapping("selMaxLv")
	public void selMaxLv(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			try {
				PageData maxlv = contentService.selMaxLv(pd);
				super.outJson(response, super.REQUEST_SUCCESS, "查询成功", maxlv);
			} catch (Exception e) {
				e.printStackTrace();
				super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 关于我们
	 * 
	 * 安全须知
	 * 
	 * 预约须知
	 */
	@RequestMapping("sysContentDesc")
	public ModelAndView sysContentDesc() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("about_us".equalsIgnoreCase(pd.getAsString("type"))) {
			mv.setViewName("/site/aboutUs");
		} else if ("safe_know".equalsIgnoreCase(pd.getAsString("type"))) {
			mv.setViewName("/site/safeKnow");
		} else if ("book_know".equalsIgnoreCase(pd.getAsString("type"))) {
			mv.setViewName("/site/bookKnow");
		}
		mv.addObject("site", siteSetService.selectAll());
		return mv;
	}

	/**
	 * 跟新关于我们 安全须知
	 */
	@RequestMapping("sysContentUpdate")
	public void sysContentUpdate(HttpServletResponse response) {
		try {
			siteSetService.edit(this.getPageData());
			super.outJson(response, super.REQUEST_SUCCESS, "查询成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 跳转到相册界面
	 * @return
	 */
	@RequestMapping("resource/addPage")
	public ModelAndView addResourcePage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("/content/albums_show");
		pd.put("albums", contentService.selectContentAlbums(pd.getAsInt("content_id")));
		mv.addObject("albumModel", pd);
		return mv;
	}

	/**
	 * 图片删除
	 */
	@RequestMapping("resource/delete")
	public void delete(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			if ("-2".equalsIgnoreCase(pd.getAsString("album_id"))) {
				PageData allPd = new PageData();
				allPd.put("content_id", pd.getAsString("content_id"));
				contentService.deleteContentAlbums(allPd);
			} else if (StringUtils.isNotEmpty(pd.getAsString("album_id"))) {
				contentService.deleteContentAlbums(pd);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 图片上传
	 */
	@RequestMapping("resource/uploadImg")
	public void saveStockImg(HttpServletResponse response, HttpServletRequest request) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			MultipartFile file = multipartRequest.getFile("file");
			String filePath = "";
			if (file != null) {
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				filePath = ftp.upload(file, "wzd", "images");
				data.put("original_img", filePath);
				data.put("create_time", EADate.getCurrentTime());
				contentService.insertContentAlbums(data);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}
	/**
	 * 拉取相册数据
	 * @param response
	 * @param request
	 */
	@RequestMapping("resource/pushContentAlbumsData")
	public void pushContentAlbumsData(HttpServletResponse response, HttpServletRequest request){
		try {
			PageData pd=getPageData();
			List<PageData> albumslist=contentService.selectContentAlbums(pd.getAsInt("CONTENT_ID"));
			super.outJson(response, super.REQUEST_SUCCESS, "查询成功", albumslist);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, "查询失败", null);
		}
	}
	
	/**
	 * 编辑跟团游跳转
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "grouptourList")
	public ModelAndView grouptourList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		pd.put("grouptour_state", "1");
		page.setPd(pd);
		page.setShowCount(5);
		mv.addObject("SUBJECT_ID", pd.getAsString("SUBJECT_ID"));
		mv.addObject("dataModel", groupTourService.getByPage(page));
		mv.addObject("page", page);
		mv.setViewName("content/grouptour_relation");
		return mv;
	}

	/**
	 * 拉取选中跟团游数据
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "pushGrouptourByID", "" })
	public void pushGrouptourByID(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			PageData data = groupTourService.getById(EAString.stringToInt(pd.getAsString("grouptour_id"), 0));
			super.outJson(response, REQUEST_SUCCESS, "获取成功", data);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "获取失败", e.getMessage());
		}
	}

	/**
	 * 编辑普通门票跳转
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "ticketList")
	public ModelAndView ticketList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		page.setShowCount(5);
		mv.addObject("SUBJECT_ID", pd.getAsString("SUBJECT_ID"));
		List<PageData> list = ticketService.getByPage(page);
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("content/ticket_relation");
		return mv;
	}

	/**
	 * 拉取选中课程数据
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "pushTicketByID", "" })
	public void pushTicketByID(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			PageData pageData = ticketService.getById(EAString.stringToInt(pd.getAsString("t_id"), 0));
			super.outJson(response, REQUEST_SUCCESS, "获取成功", pageData);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "获取失败", e.getMessage());
		}
	}
	
}
