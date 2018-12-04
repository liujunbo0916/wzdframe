package com.easaa.controller.travel;

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
import org.springframework.web.bind.annotation.RequestMethod;
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
import com.easaa.goods.entity.GoodsAttrList;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.dao.SiteSetMapper;
import com.easaa.scenicspot.service.AgencyService;
import com.easaa.scenicspot.service.SiteSetService;
import com.easaa.upm.service.LogisticsService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 旅行社，导游，月结 控制器
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/sys/travel/")
public class AgencyController extends BaseController {

	@Autowired
	private AgencyService agencyService;
	@Autowired
	private LogisticsService logisticsService;
	/**
	 * 省列表
	 */
	private static List<PageData> plist;

	/**
	 * 旅行社列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "agency/list")
	public ModelAndView agencylist(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		mv.setViewName("agency/agencylist");
		if (EAUtil.isEmpty(plist)) {
			plist = logisticsService.getProvince(pd);
		}
		mv.addObject("dataModel", agencyService.getByPage(page));
		mv.addObject("page", page);
		mv.addObject("plist", plist);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 旅行社编辑
	 */

	@RequestMapping("agency/edit")
	public ModelAndView agencyedit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if (EAUtil.isEmpty(plist)) {
			plist = logisticsService.getProvince(pd);
		}
		PageData data = agencyService.getById(EAString.stringToInt(pd.getAsString("agency_id"), 0));
		if (EAUtil.isNotEmpty(data)) {
			PageData capd = new PageData();
			if (data.getAsInt("agency_province_code") > 0) {
				capd.put("province_id", data.getAsInt("agency_province_code"));
				List<PageData> citylist = logisticsService.getCityArea(capd);
				mv.addObject("citylist", citylist);
			}
			if (data.getAsInt("agency_city_code") > 0) {
				capd.put("province_id", data.getAsInt("agency_city_code"));
				List<PageData> arealist = logisticsService.getCityArea(capd);
				mv.addObject("arealist", arealist);
			}
		}
		mv.addObject("dataModel", data);
		mv.addObject("plist", plist);
		mv.setViewName("agency/agencyedit");
		return mv;
	}

	/**
	 * 旅行社保存
	 */
	@MethodLog(remark = "旅行社添加/编辑")
	@RequestMapping(value = "agency/save", method = RequestMethod.POST)
	public ModelAndView agencysave(HttpServletResponse response,
			@RequestParam(required = false, value = "agency_logo") MultipartFile logofile,
			@RequestParam(required = false, value = "agency_license_img") MultipartFile licenseimgfile,
			HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData pd = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try {
			if (logofile != null && !logofile.isEmpty() && logofile.getSize() > 0) {
				String savePath = FtpUtil.upload(logofile, "mallframe", "tuyun");
				pd.put("agency_logo", savePath);
				try {
					String fileName = savePath.substring(savePath.lastIndexOf("/") + 1, savePath.lastIndexOf("."));
					ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(750, 601, "detail", fileName),
							new ImageFormat(226, 226, "list", fileName), new ImageFormat(328, 328, "listbig", fileName),
							new ImageFormat(238, 238, "listmiddle", fileName),
							new ImageFormat(175, 175, "listsmall", fileName) }; // 网站图片规格
					EATools.dealWithImgs(logofile, imageFormats);
					for (ImageFormat tif : imageFormats) {
						FtpUtil.upload(tif, "mallframe", "tuyun");
						if (tif.getFile().exists()) {
							tif.getFile().delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (licenseimgfile != null && !licenseimgfile.isEmpty() && licenseimgfile.getSize() > 0) {
				String savePath = FtpUtil.upload(licenseimgfile, "mallframe", "tuyun");
				pd.put("agency_license_img", savePath);
				try {
					String fileName = savePath.substring(savePath.lastIndexOf("/") + 1, savePath.lastIndexOf("."));
					ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(750, 601, "detail", fileName),
							new ImageFormat(226, 226, "list", fileName), new ImageFormat(328, 328, "listbig", fileName),
							new ImageFormat(238, 238, "listmiddle", fileName),
							new ImageFormat(175, 175, "listsmall", fileName) }; // 网站图片规格
					EATools.dealWithImgs(licenseimgfile, imageFormats);
					for (ImageFormat tif : imageFormats) {
						FtpUtil.upload(tif, "mallframe", "tuyun");
						if (tif.getFile().exists()) {
							tif.getFile().delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (pd.getAsInt("agency_id") > 0) {
				agencyService.edit(pd);
			} else {
				pd.put("agency_create_time", EADate.getCurrentTime());
				agencyService.create(pd);
			}
			mv.setViewName("redirect:/sys/travel/agency/list");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	/**
	 * 旅行社删除
	 */
	@MethodLog(remark = "旅行社删除")
	@RequestMapping(value = "agency/delete")
	public void agencydelete(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("agency_id") > 0) {
				agencyService.delete(pd);
				super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "操作失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 导游列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "guider/list")
	public ModelAndView guiderlist(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> guiderlist = agencyService.selectGuiderByListPage(page);
		mv.setViewName("agency/guiderlist");
		mv.addObject("dataModel", guiderlist);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 导游编辑
	 */
	@RequestMapping("guider/edit")
	public ModelAndView guideredit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("agency_status", "1");
		mv.addObject("agencylist", agencyService.getByMap(pd));
		PageData data = agencyService.selectGuiderById(EAString.stringToInt(pd.getAsString("guider_id"), 0));
		mv.addObject("dataModel", data);
		mv.setViewName("agency/guideredit");
		return mv;
	}

	/**
	 * 导游保存
	 */
	@MethodLog(remark = "导游添加/编辑")
	@RequestMapping(value = "guider/save", method = RequestMethod.POST)
	public ModelAndView guidersave(HttpServletResponse response,
			@RequestParam(required = false, value = "guider_logo") MultipartFile logofile,
			@RequestParam(required = false, value = "guider_bglogo") MultipartFile bglogofile,
			HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData pd = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try {
			if (StringUtils.isEmpty(pd.getAsString("guider_desc"))) {
				pd.put("guider_desc", pd.getAsString("editorValue"));
			}
			if (logofile != null && !logofile.isEmpty() && logofile.getSize() > 0) {
				String savePath = FtpUtil.upload(logofile, "mallframe", "tuyun");
				pd.put("guider_logo", savePath);
				try {
					String fileName = savePath.substring(savePath.lastIndexOf("/") + 1, savePath.lastIndexOf("."));
					ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(750, 601, "detail", fileName),
							new ImageFormat(226, 226, "list", fileName), new ImageFormat(328, 328, "listbig", fileName),
							new ImageFormat(238, 238, "listmiddle", fileName),
							new ImageFormat(175, 175, "listsmall", fileName) }; // 网站图片规格
					EATools.dealWithImgs(logofile, imageFormats);
					for (ImageFormat tif : imageFormats) {
						FtpUtil.upload(tif, "mallframe", "tuyun");
						if (tif.getFile().exists()) {
							tif.getFile().delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (bglogofile != null && !bglogofile.isEmpty() && bglogofile.getSize() > 0) {
				String savePath = FtpUtil.upload(bglogofile, "mallframe", "tuyun");
				pd.put("guider_bglogo", savePath);
				try {
					String fileName = savePath.substring(savePath.lastIndexOf("/") + 1, savePath.lastIndexOf("."));
					ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(750, 601, "detail", fileName),
							new ImageFormat(226, 226, "list", fileName), new ImageFormat(328, 328, "listbig", fileName),
							new ImageFormat(238, 238, "listmiddle", fileName),
							new ImageFormat(175, 175, "listsmall", fileName) }; // 网站图片规格
					EATools.dealWithImgs(bglogofile, imageFormats);
					for (ImageFormat tif : imageFormats) {
						FtpUtil.upload(tif, "mallframe", "tuyun");
						if (tif.getFile().exists()) {
							tif.getFile().delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (pd.getAsInt("guider_id") > 0) {
				agencyService.updateGuider(pd);
			} else {
				pd.put("guider_create_time", EADate.getCurrentTime());
				agencyService.insertGuider(pd);
			}
			mv.setViewName("redirect:/sys/travel/guider/list");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	/**
	 * 导游删除
	 */
	@MethodLog(remark = "导游删除")
	@RequestMapping(value = "guider/delete")
	public void guiderdelete(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("agency_id") > 0) {
				agencyService.delete(pd);
				super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "操作失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 旅行社导游订单
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "agency/order")
	public ModelAndView agencyorderlist(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		mv.setViewName("agency/agencyorderlist");
		mv.addObject("dataModel", null);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 获取市区域列表
	 */
	@RequestMapping(value = "getCityArea")
	public void getCityArea(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("province_id") > 0) {
				List<PageData> arealist = logisticsService.getCityArea(pd);
				super.outJson(response, REQUEST_SUCCESS, "操作成功", arealist);
			} else {
				super.outJson(response, REQUEST_FAILS, "操作失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

}
