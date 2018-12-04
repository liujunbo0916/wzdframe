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
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.CouponService;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/coupon/")
public class CouponController extends BaseController {
	@Autowired
	private CouponService couponService;

	/**
	 * 优惠劵列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> couponList = couponService.getByPage(page);
		mv.addObject("dataModel", couponList);
		mv.addObject("page", page);
		mv.setViewName("goods/coupon/couponList");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 编辑
	 * 
	 * @return
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id = getRequest().getParameter("id");
		mv.addObject("dataModel", couponService.getById(EAString.stringToInt(id, 0)));
		mv.setViewName("goods/coupon/couponEdit");
		return mv;
	}

	/**
	 * 保存
	 * @param file
	 * @param request
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam(required=false,value = "cash_img") MultipartFile file, HttpServletRequest request)
			throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		if (EAUtil.isNotEmpty(data.getAsString("id")) && data.getAsInt("id") > 0) { // 如果主键brand_id值大于0,说明是编辑
			if (file != null  && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "mallframe", "product");
				data.put("cash_img", savePath);
			}
			couponService.edit(data);
			if (EAUtil.isNotEmpty(data.getAsString("cash_status")) && data.getAsString("cash_status").equals("0")) {
				/**
				 * 查询该优惠劵所有领取记录
				 */
				PageData model = new PageData();
				model.put("cash_id", data.getAsString("id"));
				List<PageData> record = couponService.selectrecord(model);
				for (PageData pageData : record) {
					/**
					 * 使用状态（0未使用，1已使用，2 失效） 将所有未使用该优惠劵的数据修改
					 */
					int user_status = pageData.getAsInt("user_status");
					if (user_status == 0) {
						model.put("user_status", 2);
						couponService.editrecord(model);
					}
				}
			}
		} else { // 主键brand_id值不大于0,新增
			String savePath = FtpUtil.upload(file, "mallframe", "product");
			data.put("cash_img", savePath);
			data.put("create_time", EADate.getCurrentTime());
			data.remove("id");
			couponService.create(data);
		}
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/coupon/listPage");
		return mv;
	}

	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "del")
	public ModelAndView del(HttpServletRequest request) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData data = getPageData();
		if (EAUtil.isNotEmpty(data.getAsString("id")) && data.getAsInt("id") > 0) {
			data.put("cash_status", "3");
			couponService.edit(data);
		}
		mv.setViewName("redirect:/sys/goods/coupon/listPage");
		return mv;
	}

}