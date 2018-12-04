package com.easaa.controller.shops;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.ShopGradeService;
import com.easaa.scenicspot.service.ShopService;
import com.easaa.upm.service.LogisticsService;
import com.easaa.user.service.UserService;

/**
 * 商铺管理
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/sys/shops/")
public class ShopsController extends BaseController {

	@Autowired
	private ShopService businessService;
	@Autowired
	private LogisticsService logisticsService;
	@Autowired
	private ShopGradeService businessGradeService;
	@Autowired
	private UserService userService;
	@Autowired

	/**
	 * 省列表
	 */
	private static List<PageData> plist;

	/**
	 * 店铺列表
	 * 
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list(HttpServletResponse response, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", businessService.getByPage(page));
		mv.setViewName("/shops/shops/list");
		// 获取省份地址
		if (EAUtil.isEmpty(plist)) {
			plist = logisticsService.getProvince(pd);
		}
		mv.addObject("plist", plist);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("gradeData", businessGradeService.getByMap(pd));
		return mv;
	}

	/**
	 * 跳到新增店铺
	 */
	@RequestMapping("editPage")
	public ModelAndView addPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		// 获取省份地址
		if (EAUtil.isEmpty(plist)) {
			plist = logisticsService.getProvince(pd);
		}
		if (StringUtils.isNotEmpty(pd.getAsString("bs_id"))) {
			PageData data = businessService.getById(pd.getAsInt("bs_id"));
			mv.addObject("dataModel", data);
		}
		mv.addObject("plist", plist);
		mv.setViewName("/shops/shops/edit");
		return mv;
	}

	/**
	 * 新增店铺 bs_avatar bs_logo bs_banner
	 */
	@MethodLog(remark="店铺新增")
	@RequestMapping("add")
	public void add(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = getPageData();
			// 非自营店铺
			pd.put("is_own_shop", 0);
			// 根据用户名查询用户
			PageData checkPd = new PageData();
			checkPd.put("user_name", pd.getAsString("user_name"));
			List<PageData> userList = userService.getByMap(checkPd);
			if (userList != null && userList.size() > 0) {
				super.outJson(REQUEST_FAILS, "用户名已存在", null, response);
				return;
			}
			userService.insertUser(pd);
			businessService.addBusiness(pd);
			super.outJson(REQUEST_SUCCESS, "店铺创建成功", null, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "系统异常", null, response);
		}
	}

	/**
	 * 修改店铺 bs_avatar bs_logo bs_banner
	 */
	@MethodLog(remark="店铺修改")
	@RequestMapping("update")
	public ModelAndView update(@RequestParam(required=false,value = "bs_avatar") MultipartFile avatarfile,
			@RequestParam(required=false,value = "bs_logo") MultipartFile logofile,
			@RequestParam(required=false,value = "bs_banner") MultipartFile bannerfile, HttpServletResponse response,
			HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData(multipartRequest);
		try {
			try {
				if (avatarfile != null && avatarfile.getBytes() != null && avatarfile.getBytes().length > 0) {
					String avatarstr = FtpUtil.upload(avatarfile, "mallframe", "seller");
					pd.put("bs_avatar", avatarstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (logofile != null && logofile.getBytes() != null && logofile.getBytes().length > 0) {
					String logostr = FtpUtil.upload(logofile, "mallframe", "seller");
					pd.put("bs_logo", logostr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (bannerfile != null && bannerfile.getBytes() != null && bannerfile.getBytes().length > 0) {
					String bannercstr = FtpUtil.upload(bannerfile, "mallframe", "seller");
					pd.put("bs_banner", bannercstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (pd.getAsInt("bs_id") > 0) {
				businessService.updateBusiness(pd);
			} else {
				pd.put("bsj_id", "19fc09d124484dd48e1ac50f3cae0d78");
				businessService.create(pd);
			}
			mv.setViewName("redirect:/sys/shops/list");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	


	/**
	 * 修改（审核）店铺信息
	 * 
	 * @param response
	 */
	@MethodLog(remark="修改审核店铺信息")
	@RequestMapping(value = "stay/editstay")
	public ModelAndView editstay(@RequestParam(required=false,value = "business_licence_number_electronic") MultipartFile blnefile,
			@RequestParam(required=false,value = "bs_charge_handheld_cardphoto") MultipartFile bchcfile,
			@RequestParam(required=false,value = "bs_charge_front_cardphoto") MultipartFile bcfcfile,
			@RequestParam(required=false,value = "bs_charge_negative_cardphoto") MultipartFile bcncfile, HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData pd = getPageData(multipartRequest);
		try {
			try {
				if (blnefile != null && blnefile.getBytes() != null && blnefile.getBytes().length > 0) {
					String blnestr = FtpUtil.upload(blnefile, "mallframe", "seller");
					pd.put("business_licence_number_electronic", blnestr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (bchcfile != null && bchcfile.getBytes() != null && bchcfile.getBytes().length > 0) {
					String bchcstr = FtpUtil.upload(bchcfile, "mallframe", "seller");
					pd.put("bs_charge_handheld_cardphoto", bchcstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (bcfcfile != null && bcfcfile.getBytes() != null && bcfcfile.getBytes().length > 0) {
					String bcfcstr = FtpUtil.upload(bcfcfile, "mallframe", "seller");
					pd.put("bs_charge_front_cardphoto", bcfcstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (bcncfile != null && bcncfile.getBytes() != null && bcncfile.getBytes().length > 0) {
					String bcncstr = FtpUtil.upload(bcncfile, "mallframe", "seller");
					pd.put("bs_charge_negative_cardphoto", bcncstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (EAUtil.isNotEmpty(pd.getAsString("bsj_id"))) {
				businessService.updateBusinessJoin(pd);
			} else {
				pd.put("create_time", EADate.getCurrentTime());
				businessService.insertBusinessJoin(pd);
			}
			mv.setViewName("redirect:/sys/shops/stay/list");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	
}
