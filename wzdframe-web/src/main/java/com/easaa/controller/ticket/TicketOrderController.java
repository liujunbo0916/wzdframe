package com.easaa.controller.ticket;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.ticket.TicketOrder;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.scenicspot.service.TicketService;

/**
 * 
 * 
 * 游客购票订单
 * 
 * 
 * @author liujunbo
 *
 */
@Controller
@RequestMapping("/sys/ticket/order/")

public class TicketOrderController extends BaseController{

	@Autowired
	private TicketOrderService ticketOrderService;
	
	@Autowired
	private TicketService ticketService;
	@Autowired
	private ScenicService scenicService;
	
	@RequestMapping("list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		List<TicketOrder> list = ticketOrderService.selectEntityByPage(page);
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		pd.put("scenic_is_ticket", "1");
		mv.addObject("scenicList", scenicService.getByMap(pd));
		mv.addObject("ticketList", ticketService.getByMap(pd));
		mv.setViewName("/ticket/order/list");
		return mv;
	}
	@RequestMapping("editPage")
	public ModelAndView editPage(){
		ModelAndView mv = this.getModelAndView();
		Page page = new Page();
		PageData pd = this.getPageData();
		page.setPd(pd);
		if(StringUtils.isNotEmpty(pd.getAsString("id"))){
			TicketOrder data = ticketOrderService.selectEntityByMap(page).get(0);
			mv.addObject("dataModel", data);
		}
		mv.setViewName("/ticket/order/edit");
		return mv;
	}
	@RequestMapping("ticketMsg")
	public ModelAndView ticketMsg(String ticketTypeId){
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", com.easaa.scenicspot.assembly.TicketService.getTicketTypes("1", "20", ticketTypeId));
		mv.setViewName("/ticket/order/ticketMsg");
		return mv;
	}
	
	
	/**
	 * 退票订单
	 */
	/**
	 * 退票列表
	 */
	@RequestMapping("/refund/list")
	public ModelAndView refundList(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> list = ticketOrderService.selectRefundByPage(page);
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("/ticket/refund/list");
		return mv;
	}
	
}
