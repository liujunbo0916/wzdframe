package com.easaa.controller.rebate;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.order.service.OrderService;
import com.easaa.rebate.service.RebateConfigService;
import com.easaa.rebate.service.RebateOrderService;
import com.easaa.rebate.service.RebateStatsService;

@Controller
@RequestMapping("/sys/rebate/")
public class RebateController extends BaseController {
	@Autowired
	private RebateConfigService rebateConfigService;
	@Autowired
	private RebateOrderService rebateOrderService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private RebateStatsService rebateStatsService;
	/**
	 * 配置界面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "configPage")
	public ModelAndView configPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = rebateConfigService.getConfig();
		mv.addObject("dataModel", pd);
		mv.setViewName("rebate/configPage");
		return mv;
	}

	/**
	 * ajax保存配置
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "saveConfig")
	public void saveConfig(HttpServletResponse response) throws Exception {
		PageData data = this.getPageData();
		System.out.println("");
		rebateConfigService.updataRebateConfig(data);
		this.outJson(response, REQUEST_SUCCESS, "配置已经成功修改", data);
	}

	/**
	 * 分销订单列表
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orderList")
	public ModelAndView orderList(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> varList = rebateOrderService.getByPage(page);
		for (PageData pageData : varList) {
			PageData order = orderService.getById(pageData.getAsInt("order_id"));
			if (EAUtil.isNotEmpty(order)) {
				// rebate_status 返佣状态(佣金是否到账 0等待付款,1等待审核,2等待完成,3等待返佣,4交易失败,5已经返佣,6取消返佣)
				// order_status 订单状态0待付款  2配货中 3待发货 4已发货 5已送达 6交易成功 7已取消
				if (order.getAsInt("order_status")==0 && pageData.getAsInt("rebate_status")!=0) {
					pageData.put("rebate_status", "0");
					rebateOrderService.edit(pageData);
				}
				if (order.getAsInt("order_status")>0 &&  order.getAsInt("order_status")<6 && pageData.getAsInt("rebate_status")<2) {
					pageData.put("rebate_status", "2");
					rebateOrderService.edit(pageData);
				}
				if (order.getAsInt("order_status")==6 && pageData.getAsInt("rebate_status")<3) {
					pageData.put("rebate_status", "3");
					rebateOrderService.edit(pageData);
				}
				if (order.getAsInt("order_status")==7 && pageData.getAsInt("rebate_status")!=4) {
					pageData.put("rebate_status", "4");
					rebateOrderService.edit(pageData);
				}
			}
		}
		mv.addObject("varList", varList);
		mv.addObject("page", page);
		mv.setViewName("rebate/orderList");
		return mv;
	}
	
	
	/**
	 * 分销奉献列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "giveList")
	public ModelAndView giveList(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String month="";
		if(EAUtil.isNotEmpty(pd.getAsString("year")) && EAUtil.isNotEmpty(pd.getAsString("startmonth")) && EAUtil.isNotEmpty(pd.getAsString("endmonth"))){
			 month=pd.getAsString("year")+pd.getAsString("startmonth");
			for (int i = (pd.getAsInt("startmonth")+1); i <= pd.getAsInt("endmonth"); i++) {
				if(i<10){
					month+=","+pd.getAsInt("year")+"0"+i;
				}else{
					month+=","+pd.getAsInt("year")+i;
				}
				
			}
		}else if(EAUtil.isNotEmpty(pd.getAsString("year")) && EAUtil.isNotEmpty(pd.getAsString("startmonth")) || EAUtil.isNotEmpty(pd.getAsString("endmonth"))){
			if(EAUtil.isNotEmpty(pd.getAsString("startmonth"))){
				month=pd.getAsString("year")+pd.getAsString("startmonth");
			} 
			if(EAUtil.isNotEmpty(pd.getAsString("endmonth"))){
				month=pd.getAsString("year")+pd.getAsString("endmonth");
			}
		}else{
			pd.remove("startmonth");
			pd.remove("endmonth");
		}
		pd.put("month", month);
		page.setPd(pd);
		mv.addObject("dataModel", rebateStatsService.selectGiveBackstageByPage(page));
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		int startMonths=2010;
		List<String> months= new ArrayList<String>();
		for (int i = 0; i < 100; i++) {
			months.add(String.valueOf(startMonths+i));
		}
		mv.addObject("months", months);
		mv.setViewName("rebate/giveList");
		return mv;
	}
	
	/**
	 * 分销收益列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "incomeList")
	public ModelAndView incomeList(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(EAUtil.isNotEmpty(pd.getAsString("year")) && EAUtil.isNotEmpty(pd.getAsString("startmonth")) && EAUtil.isNotEmpty(pd.getAsString("endmonth"))){
			String month=pd.getAsString("year")+pd.getAsString("startmonth");
			for (int i = (pd.getAsInt("startmonth")+1); i <= pd.getAsInt("endmonth"); i++) {
				if(i<10){
					month+=","+pd.getAsInt("year")+"0"+i;
				}else{
					month+=","+pd.getAsInt("year")+i;
				}
				
			}
			pd.put("month", month);
		}
		page.setPd(pd);
		mv.addObject("dataModel", rebateStatsService.selectIncomeBackstageByPage(page));
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		int startMonths=2010;
		List<String> months= new ArrayList<String>();
		for (int i = 0; i < 100; i++) {
			months.add(String.valueOf(startMonths+i));
		}
		mv.addObject("months", months);
		mv.setViewName("rebate/incomeList");
		return mv;
	}
	/**
	 * 将分佣订单执行返佣
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "rakeBack")
	public void rakeBack(HttpServletResponse response) {
		// 查出订单(返佣订单)
		// 增加用户钱包
		// 增加用户积分
		// 插入钱包log
		// 插入积分log
		// 插入订单log
		PageData pd = this.getPageData();
		int id = pd.getAsInt("id");
		PageData order = rebateOrderService.getById(id);
		if (EAUtil.isEmpty(order)) {
			this.outJson(REQUEST_FAILS, "未找到返佣订单", null, response);
			return;
		}
		// 购物订单
		PageData buyOrder = orderService.getById(order.getAsInt("order_id"));
		if (EAUtil.isEmpty(buyOrder)) {
			this.outJson(REQUEST_FAILS, "未找到购物订单", null, response);
			return;
		}
		if (buyOrder.getAsInt("order_status") != 6) {// 如果订单是未完成的,那么不允许返佣;订单状态为6代表交易成功
			this.outJson(REQUEST_FAILS, "当前订单状态不允许返佣", null, response);
			return;
		}
		if (buyOrder.getAsString("rebate_status").equals("5")) {// 如果订单是未完成的,那么不允许返佣;订单状态为6代表交易成功
			this.outJson(REQUEST_FAILS, "当前订单已经存在返佣记录,请勿重复返佣", null, response);
			return;
		}
		try {
			// 更新佣金统计信息
			rebateStatsService.updaterakeback(getAdminName(), order, buyOrder);
			this.outJson(REQUEST_SUCCESS, "当前订单已成功返佣", id, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_SUCCESS, "当前订单返佣失败", e.getMessage(), response);
		}
	}

	/**
	 * 取消订单返佣
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cancelRakeBack")
	public void cancelRakeBack(int id, HttpServletResponse response) throws Exception {
		PageData order = rebateOrderService.getById(id);
		if (EAUtil.isEmpty(order)) {
			this.outJson(REQUEST_FAILS, "未找到返佣订单", null, response);
			return;
		}
		// 购物订单
		PageData buyOrder = orderService.getById(order.getAsInt("order_id"));
		if (EAUtil.isEmpty(buyOrder)) {
			this.outJson(REQUEST_FAILS, "未找到购物订单", null, response);
			return;
		}
		if (buyOrder.getAsInt("rebate_status") != 5) {// 如果订单是未完成的,那么不允许返佣;订单状态为6代表交易成功
			this.outJson(REQUEST_FAILS, "当前订单不允许取消返佣", null, response);
			return;
		}
		// 更新订单状态
		order.getAsString("order_sn");
		order.put("rebate_status", 6);
		rebateOrderService.edit(order);
		rebateStatsService.cancelRakeback(getAdminName(), order, buyOrder);
		buyOrder = new PageData();
		buyOrder.put("rebate_status", 6);
		buyOrder.put("order_id", order.getAsInt("order_id"));
		orderService.edit(buyOrder);
		this.outJson(REQUEST_SUCCESS, "当前订单已成功返佣", id, response);
	}

	@RequestMapping(value = "testOrder")
	public void testOrder(int id, HttpServletResponse response) throws Exception {
		PageData order = orderService.getById(id);
		rebateOrderService.updateOrderRebate(order);
	}

}
