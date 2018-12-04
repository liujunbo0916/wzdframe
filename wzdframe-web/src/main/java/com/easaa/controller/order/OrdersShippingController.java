package com.easaa.controller.order;

import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Express;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.order.service.OrderService;
import com.easaa.order.service.OrdersGoodsService;
import com.easaa.order.service.OrdersLogService;
import com.easaa.order.service.OrdersShippingService;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.EADate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/sys/order/ordersShipping/")
public class OrdersShippingController extends BaseController {
	@Autowired
	private OrdersShippingService ordersShippingService;
	/**
	 * 发货单管理
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> varList = ordersShippingService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("order/shipments/shipmentsList");
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 发货单详情
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id = getRequest().getParameter("id");
		mv.addObject("dataModel", ordersShippingService.getById(EAString.stringToInt(id, 0)));
		mv.addObject("companyList", Express.values());
		mv.setViewName("order/shipments/shipmentsCreate");
		return mv;
	}
	/**
	 * 发货单生成和订单状态的修改
	 */
	@RequestMapping(value = "save")
	public ModelAndView save() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		ordersShippingService.edit(pd);
		mv.setViewName("redirect:/sys/order/ordersShipping/listPage");
		return mv;
	}
	/**
	 * 快递查询接口  参数order_id  订单id
	 * 
	 * {
	*	"message":"ok","status":"1","state":"3","data":[
	*	  {"time":"2012-07-07 13:35:14","context":"客户已签收"},
	*	  {"time":"2012-07-07 09:10:10","context":"离开[北京石景山营业厅]派送中，递送员[温]，电话[]"},
	*	  {"time":"2012-07-06 19:46:38","context":"到达[北京石景山营业厅]"},
	*	  {"time":"2012-07-06 15:22:32","context":"离开[北京石景山营业厅]派送中，递送员[温]，电话[]"},
	*	  {"time":"2012-07-06 15:05:00","context":"到达[北京石景山营业厅]"},
	*	  {"time":"2012-07-06 13:37:52","context":"离开[北京_同城中转站]发往[北京石景山营业厅]"},
	*	  {"time":"2012-07-06 12:54:41","context":"到达[北京_同城中转站]"},
	*	  {"time":"2012-07-06 11:11:03","context":"离开[北京运转中心驻站班组] 发往[北京_同城中转站]"},
	*	  {"time":"2012-07-06 10:43:21","context":"到达[北京运转中心驻站班组]"},
	*	  {"time":"2012-07-05 21:18:53","context":"离开[福建_厦门支公司] 发往 [北京运转中心_航空]"},
	*	  {"time":"2012-07-05 20:07:27","context":"已取件，到达 [福建_厦门支公司]"}
	*	]}
    *
	 */
	@RequestMapping("queryExpressStatus")
	public void queryExpressStatus(HttpServletResponse response) {
		try {
			outJson(response, this.REQUEST_SUCCESS, "查询成功", ordersShippingService.queryExpressStatus(this.getPageData()));
		} catch (Exception e) {
			e.printStackTrace();
			outJson(response, this.REQUEST_FAILS, "查询失败",null);
		}
	}

}