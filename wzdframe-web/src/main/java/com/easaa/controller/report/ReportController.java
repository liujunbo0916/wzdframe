package com.easaa.controller.report;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.log.annotation.MethodLog;
import com.easaa.order.service.OrderService;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.ticket.TicketOrder;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 报表控制器
 * 
 * 
 * 
 * @author liujunbo
 */
@RequestMapping("/sys/report/")
@Controller
public class ReportController extends BaseController{
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private TicketOrderService ticketOrderService;
	
	@Autowired
	private GroupTourService groupTourService;
	
	/**
	 * 商品报表
	 * @return
	 */
	@MethodLog(remark="商品报表")
	@RequestMapping("product")
	public ModelAndView productList(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		/**
		 * 报表加上查询参数
		 */
		pd.put("order_status","8");
		if(StringUtils.isNotEmpty(pd.getAsString("start_create_time"))){
			pd.put("start_create_time", EADate.stringToDate(pd.getAsString("start_create_time"), "yyyy-MM-dd"));
		}
		if(StringUtils.isNotEmpty(pd.getAsString("end_create_time"))){
			pd.put("end_create_time", EADate.stringToDate(pd.getAsString("end_create_time"), "yyyy-MM-dd"));
		}
		page.setPd(pd);
		List<PageData> varList=orderService.getByPage(page);
		BigDecimal totalMoney=BigDecimal.ZERO;
		for (PageData pageData : varList) {
			totalMoney.add(pageData.getAsBigDecimal("order_money"));
		}
		mv.addObject("totalMoney", totalMoney);
		mv.addObject("varList", varList);
		mv.setViewName("report/product");
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	/**
	 * 票务报表
	 */
	@MethodLog(remark="票务报表")
	@RequestMapping("ticket/list")
	public ModelAndView ticketList(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("to_status","3");
		if(StringUtils.isNotEmpty(pd.getAsString("start_create_time"))){
			pd.put("start_create_time", EADate.stringToDate(pd.getAsString("start_create_time"), "yyyy-MM-dd"));
		}
		if(StringUtils.isNotEmpty(pd.getAsString("end_create_time"))){
			pd.put("end_create_time", EADate.stringToDate(pd.getAsString("end_create_time"), "yyyy-MM-dd"));
		}
		page.setPd(pd);
		List<TicketOrder> ticketList = ticketOrderService.selectEntityByPage(page);
		BigDecimal totalMoney=BigDecimal.ZERO;
		for (TicketOrder pageData : ticketList) {
			totalMoney.add(BigDecimal.valueOf(Double.valueOf(pageData.getOrderMoney())));
		}
		mv.addObject("totalMoney", totalMoney);
		mv.addObject("ticketList", ticketList);
		mv.setViewName("report/ticket");
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 跟团游报表
	 */
	@MethodLog(remark="跟团游报表")
	@RequestMapping("grouptour/list")
	public ModelAndView grouptourList(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("order_state","2");
		if(StringUtils.isNotEmpty(pd.getAsString("start_create_time"))){
			pd.put("start_create_time", EADate.stringToDate(pd.getAsString("start_create_time"), "yyyy-MM-dd"));
		}
		if(StringUtils.isNotEmpty(pd.getAsString("end_create_time"))){
			pd.put("end_create_time", EADate.stringToDate(pd.getAsString("end_create_time"), "yyyy-MM-dd"));
		}
		page.setPd(pd);
		List<GroupTourOrder> grouptourList = groupTourService.selectEntityByPage(page);
		BigDecimal totalMoney=BigDecimal.ZERO;
		for (GroupTourOrder pageData : grouptourList) {
			totalMoney.add(BigDecimal.valueOf(Double.valueOf(pageData.getTotalPrice())));
		}
		mv.addObject("totalMoney", totalMoney);
		mv.addObject("grouptourList", grouptourList);
		mv.setViewName("report/grouptour");
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
}
