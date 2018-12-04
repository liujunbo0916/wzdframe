package com.easaa.controller.travel;

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
import com.easaa.core.util.Tools;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.order.service.OrdersLogService;
import com.easaa.scenicspot.service.AgencyService;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 线路（跟团游）控制器
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/sys/grouptour/")
public class GroupTourController extends BaseController {

	@Autowired
	private GroupTourService groupTourService;
	@Autowired
	private OrdersLogService ordersLogService;
	@Autowired
	private AgencyService agencyService;
	
	/**
	 * 线路列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> hotelList = groupTourService.getByPage(page); // 列出Content列表
		mv.addObject("dataModel", hotelList);
		mv.addObject("pd", pd);
		mv.setViewName("hotel/grouptourlist");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 编辑线路
	 * 
	 * @return
	 */
	@RequestMapping(value = "editPage")
	public ModelAndView editPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = groupTourService.getById(EAString.stringToInt(pd.getAsString("grouptour_id"), 0));
		mv.addObject("dataModel", data);
		//获取旅行社
		PageData agencypd= new PageData();
		agencypd.put("agency_status", "1");
		mv.addObject("agencylist", agencyService.getByMap(agencypd));
		mv.setViewName("hotel/grouptouredit");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 保存线路
	 * 
	 * @param file
	 * @param goodsAttr
	 * @param request
	 * @return
	 */
	@MethodLog(remark="路线保存编辑")
	@RequestMapping(value = "savePage", method = RequestMethod.POST)
	public ModelAndView savePage(@RequestParam(required=false,value = "grouptour_img") MultipartFile file,
			HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try {
			if (file != null && !file.isEmpty() && file.getSize() > 0) {
				String savePath = FtpUtil.upload(file, "mallframe", "tuyun");
				data.put("grouptour_img", savePath);
			}
			Tools.replaceEmpty(data);
			data.put("create_time", EADate.getCurrentTime());
			if (data.getAsInt("grouptour_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				groupTourService.edit(data);
			} else {
				groupTourService.create(data);
			}
			mv.setViewName("redirect:/sys/grouptour/listPage");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	/**
	 * 删除线路
	 * 
	 * @param response
	 * @throws Exception
	 */
	@MethodLog(remark="路线删除")
	@RequestMapping(value = "delPage")
	public void delPage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("grouptour_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				groupTourService.delete(pd);
				super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "程序异常", null);
		}
	}

	/**
	 * 出游人列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "travelerslistPage")
	public ModelAndView typelistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> travelersList = groupTourService.selectTravelersListByPage(page); // 列出Content列表
		mv.addObject("dataModel", travelersList);
		mv.addObject("pd", pd);
		mv.setViewName("hotel/travelerslist");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 出游人编辑
	 * @return
	 */
	@RequestMapping(value = "travelerseditPage")
	public ModelAndView typeeditPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = groupTourService.selectTravelersById(EAString.stringToInt(pd.getAsString("travelers_id"), 0));
		mv.addObject("dataModel", data);
		mv.setViewName("hotel/teavelersedit");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 保存出游人
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "travelerssavePage")
	public ModelAndView typesavePage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		try {
			pd.put("create_time", EADate.getCurrentTime());
			if (pd.getAsInt("travelers_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				groupTourService.updateTravelers(pd);
			} else {
				groupTourService.insertTravelers(pd);
			}
			mv.setViewName("redirect:/sys/grouptour/travelerslistPage");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

	/**
	 * 删除出游人
	 * 
	 * @param response
	 * @throws Exception
	 */
	@MethodLog(remark="删除出游人")
	@RequestMapping(value = "travelersdelPage")
	public void typedelPage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("travelers_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				groupTourService.deleteTravelers(pd);
				super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "程序异常", null);
		}
	}

	/**
	 * 线路订单列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "orderlistPage")
	public ModelAndView orderlistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> travelersList = groupTourService.selectOrderListByPage(page); // 列出Content列表
		mv.addObject("dataModel", travelersList);
		mv.addObject("pd", pd);
		mv.setViewName("hotel/travelersorderlist");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 订单编辑
	 * 
	 * @return
	 */
	@RequestMapping(value = "ordereditPage")
	public ModelAndView ordereditPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = groupTourService.selectOrderById(EAString.stringToInt(pd.getAsString("order_id"), 0));
		mv.addObject("dataModel", data);
		if (EAUtil.isNotEmpty(data)) {
			if (data.getAsInt("adult_num") > 0) {
				pd.put("travelers_id", data.getAsString("adult_ids"));
				// 查询成人出行
				List<PageData> adults = groupTourService.selectTravelersByIds(pd);
				mv.addObject("adults", adults);
			}
			if (data.getAsInt("children_num") > 0) {
				pd.put("travelers_id", data.getAsString("children_ids"));
				// 查询成人出行
				List<PageData> childrens = groupTourService.selectTravelersByIds(pd);
				mv.addObject("childrens", childrens);
			}
			//查询订单日志
			List<PageData> loglist=ordersLogService.getByMap(pd);
			mv.addObject("loglist", loglist);
		}
		mv.setViewName("hotel/travelersordersedit");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 保存订单
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="编辑订单")
	@RequestMapping(value = "ordersavePage")
	public void ordersavePage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			PageData data = groupTourService.selectOrderById(EAString.stringToInt(pd.getAsString("order_id"), 0));
			if (pd.getAsInt("order_id") > 0 && EAUtil.isNotEmpty(data)) { 
				// 设为已付款
				if ("pay".equals(pd.getAsString("type"))) {
					if (!"1".equals(data.getAsString("pay_status"))) {
						data.put("pay_status", "1");
						data.put("order_state", "0");
					}
				}
				// 设为未付款
				if ("nopay".equals(pd.getAsString("type"))) {
					if (!"0".equals(data.getAsString("pay_status"))) {
						data.put("pay_status", "0");
						data.put("order_state", "");
					}
				}
				// 设为已使用
				if ("user".equals(pd.getAsString("type"))) {
					if (!"1".equals(data.getAsString("order_state"))) {
						data.put("order_state", "1");
						data.put("pay_status", "1");
					}
				}
				// 设为未使用
				if ("nouser".equals(pd.getAsString("type"))) {
					if (!"0".equals(data.getAsString("order_state"))) {
						data.put("order_state", "0");
						data.put("pay_status", "1");
					}
				}
				// 设为已退款
				if ("back".equals(pd.getAsString("type"))) {
					if (!"4".equals(data.getAsString("pay_status"))) {
						data.put("pay_status", "4");
					}
				}
				// 设为退款中
				if ("backing".equals(pd.getAsString("type"))) {
					if (!"3".equals(data.getAsString("pay_status"))) {
						data.put("pay_status", "3");
					}
				}
				// 设为已取消
				if ("cancel".equals(pd.getAsString("type"))) {
					if (!"2".equals(data.getAsString("pay_status"))) {
						data.put("pay_status", "2");
					}
				}
				if ("pay_price".equals(pd.getAsString("type"))) {
					data.put("pay_price", pd.getAsString("pay_price"));
				}
				groupTourService.updateOrder(data);
				//插入管理员操作日志
				PageData modelLog =new PageData();
				modelLog.put("order_id", data.getAsString("order_id"));
				modelLog.put("order_status",data.getAsString("order_state"));
				modelLog.put("pay_status",data.getAsString("pay_status"));
				modelLog.put("auto_note",pd.getAsString("pay_status"));
				if ("pay_price".equals(pd.getAsString("type"))) {
					modelLog.put("log_note","跟团游订单，支付状态和订单状态对照跟团游订单! 修改了价格");
				}else{
					modelLog.put("log_note","跟团游订单，支付状态和订单状态对照跟团游订单");
				}
				modelLog.put("creator",getAdminName());
				modelLog.put("create_time",EADate.getCurrentTime());
				ordersLogService.create(modelLog);
				super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
			} else {
				super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 删除订单
	 * 
	 * @param response
	 * @throws Exception
	 */
	@MethodLog(remark="删除订单")
	@RequestMapping(value = "orderdelPage")
	public void orderdelPage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("order_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				groupTourService.deleteOrder(pd);
				super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "程序异常", null);
		}
	}

}
