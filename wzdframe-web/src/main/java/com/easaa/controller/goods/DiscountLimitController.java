package com.easaa.controller.goods;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.DiscountTimeLimitService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 限时折扣
 * 
 * @author renyy
 *
 */
@Controller
@RequestMapping("/sys/activity/discount/")
public class DiscountLimitController extends BaseController {
	@Autowired
	private DiscountTimeLimitService activityTimeLimitService;
	@Autowired
	private GoodsService goodsService;

	/**
	 * 折扣活动列表
	 * 
	 * @param page
	 * @param currentPage
	 * @param request
	 * @return
	 */
	@MethodLog(remark = "获取折扣活动列表")
	@RequestMapping("/list")
	public ModelAndView list(Page page, @RequestParam(defaultValue = "1") Integer currentPage) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setCurrentPage(currentPage);
		page.setPd(pd);
		mv.addObject("dataModel", activityTimeLimitService.getByPage(page));
		mv.setViewName("/goods/limit/List");
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 添加活动，编辑活动跳转
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@MethodLog(remark = "添加，编辑折扣活动跳转")
	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request) throws IOException, Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd=getPageData();
		mv.addObject("dataModel", activityTimeLimitService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/goods/limit/add");
		return mv;
	}

	/**
	 * 添加折扣活动
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@MethodLog(remark = "修改保存折扣活动信息")
	@RequestMapping("doEdit")
	public ModelAndView doEdit(HttpServletRequest request) throws IOException, Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		if (EAUtil.isNotEmpty(pd.getAsString("id"))) {
			activityTimeLimitService.edit(pd);
		} else {
			pd.put("create_time", EADate.getCurrentTime());
			activityTimeLimitService.create(pd);
		}
		mv.setViewName("redirect:/sys/activity/discount/list");
		return mv;
	}

	/**
	 * 管理折扣活动商品
	 * 
	 * @return
	 */
	@MethodLog(remark = "管理折扣活动商品")
	@RequestMapping("prolist")
	public ModelAndView proList(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("dataGoods",
				activityTimeLimitService.limitAllProList(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.addObject("dataModel", activityTimeLimitService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
		mv.setViewName("/goods/limit/editgoods");
		return mv;
	}

	/**
	 * 拉取折扣商品
	 * 
	 * @return
	 */
	@RequestMapping("getprolist")
	public void getprolist(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			this.outJson(response, REQUEST_SUCCESS, "",
					activityTimeLimitService.limitAllProList(EAString.stringToInt(pd.getAsString("id"), 0)));
		} catch (Exception e) {
			this.outJson(response, REQUEST_FAILS, "操作失败", "");
		}
	}

	/**
	 * 拉取所有商品
	 * 
	 * @return
	 */
	@RequestMapping("getGoodslist")
	public void getGoodslist(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			this.outJson(response, REQUEST_SUCCESS, "操作成功", goodsService.queryStockAll(pd));
			this.outJson(response, REQUEST_SUCCESS, "无数据", "");
		} catch (Exception e) {
			this.outJson(response, REQUEST_FAILS, "操作失败", "");
		}
	}

	/**
	 * 删除活动列表
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@MethodLog(remark = "删除折扣活动")
	@RequestMapping("doDel")
	public ModelAndView doDel(HttpServletRequest request) throws IOException, Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		if (EAUtil.isNotEmpty(pd.getAsString("id"))) {
			PageData propd = new PageData();
			propd.put("limit_id", pd.getAsString("id"));
			activityTimeLimitService.deleteLimitGoods(propd);
			activityTimeLimitService.delete(pd);
		}
		mv.setViewName("redirect:/sys/activity/discount/list");
		return mv;
	}

	/**
	 * 删除活动商品
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@MethodLog(remark = "删除折扣活动商品")
	@RequestMapping("doProDel")
	public void doProDel(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			if (EAUtil.isNotEmpty(pd.getAsString("id"))) {
				activityTimeLimitService.deleteLimitGoods(pd);
				this.outJson(response, REQUEST_SUCCESS, "", "");
			} else {
				this.outJson(response, REQUEST_FAILS, "ID不能为空", "");
			}
		} catch (Exception e) {
			this.outJson(response, REQUEST_FAILS, "操作失败", "");
		}

	}

	/**
	 * 修改价格跳转
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@MethodLog(remark = "修改折扣活动商品价格跳转")
	@RequestMapping("priceChange")
	public ModelAndView pricechagge(HttpServletRequest request) throws IOException, Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData data = activityTimeLimitService.selectLimitGoodsByID(EAString.stringToInt(pd.getAsString("id"), 0));
		if (EAUtil.isEmpty(data)) {
			data = new PageData();
			data.put("goods_price", pd.getAsString("goods_price"));
		}
		mv.addObject("dataModel", data);
		mv.addObject("dataPd", pd);
		mv.setViewName("/goods/limit/editprice");
		return mv;
	}

	/**
	 * 修改价格
	 * 
	 * @param request
	 */
	@MethodLog(remark = "修改折扣活动商品价格")
	@RequestMapping("doPrice")
	public void doPrice(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			if (EAUtil.isNotEmpty(pd) && EAUtil.isNotEmpty(pd.getAsString("id"))) {
				BigDecimal discount = pd.getAsBigDecimal("discount_price").divide(pd.getAsBigDecimal("goods_price"), 2,
						RoundingMode.FLOOR);
				pd.put("discount", discount);
				activityTimeLimitService.updateLimitGoods(pd);
			} else {
				/**
				 * 校验商品是否参加折扣活动
				 */
				List<PageData> datalist = activityTimeLimitService.selectLimitGoodsByMap(pd);
				if (EAUtil.isNotEmpty(datalist) && datalist.size() > 0) {
					this.outJson(response, REQUEST_FAILS, "该属性商品已添加该活动，请不要重复添加", "");
					return;
				}
				BigDecimal discount = pd.getAsBigDecimal("discount_price").divide(pd.getAsBigDecimal("goods_price"), 2,
						RoundingMode.FLOOR);
				pd.put("discount", discount);
				pd.put("create_time", EADate.getCurrentTime());
				activityTimeLimitService.insertLimitGoods(pd);
			}
			this.outJson(response, REQUEST_SUCCESS, "", "");
		} catch (Exception e) {
			this.outJson(response, REQUEST_FAILS, "操作失败", "");
		}
	}
}
