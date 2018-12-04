package com.easaa.controller.order;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Express;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.entity.TrackMsgEntity;
import com.easaa.log.annotation.MethodLog;
import com.easaa.order.service.OrderService;
import com.easaa.order.service.OrdersGoodsService;
import com.easaa.order.service.OrdersLogService;
import com.easaa.order.service.OrdersShippingService;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
@RequestMapping("/sys/order/orders/")
public class OrderController extends BaseController{
	@Autowired
	private OrderService  orderService;
	@Autowired
	private OrdersLogService ordersLogService;
	@Autowired
	private OrdersGoodsService ordersGoodsService; 
	@Autowired
	private OrdersShippingService ordersShippingService;
	
	/**
	 * 查询订单列表
	 * */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> varList=orderService.getByPage(page);
		if(StringUtils.isNotEmpty(pd.getAsString("start_create_time"))){
			pd.put("start_create_time", EADate.stringToDate(pd.getAsString("start_create_time"), "yyyy-MM-dd"));
		}
		if(StringUtils.isNotEmpty(pd.getAsString("end_create_time"))){
			pd.put("end_create_time", EADate.stringToDate(pd.getAsString("end_create_time"), "yyyy-MM-dd"));
		}
		mv.addObject("varList", varList);
		mv.setViewName("order/orders/ordersList");
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 查询订单详情并且查询该订单的操作日志
	 * */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id=getRequest().getParameter("id");
		PageData order = orderService.getById(EAString.stringToInt(id, 0));
		mv.addObject("dataModel", order);
		PageData invoicePd = new PageData();
		invoicePd.put("order_id", order.getAsString("order_id"));
		List<PageData> invoices = ordersShippingService.getByMap(invoicePd);
		mv.addObject("invoice",(invoices==null||invoices.size()==0)?null:invoices.get(0));
		String type = getRequest().getParameter("type");
		PageData pd = new PageData();
		pd.put("order_id", id);
		List<PageData> logList=ordersLogService.getByMap(pd);
		mv.addObject("logList",logList);
		List<PageData> goodsList = ordersGoodsService.getByOrderID(EAString.stringToInt(id,0));
		mv.addObject("goodsList",goodsList);
		if(type!=null){
			mv.setViewName("order/orders/"+type);
		}else
		mv.setViewName("order/orders/ordersEdit");
		return mv;
	}
	
	/**
	 * 保存和修改订单
	 * */
	@MethodLog(remark="修改订单")
	@RequestMapping(value = "save")
	public ModelAndView save() {
		PageData data=this.getPageData();
		PageData outData = orderService.getById(EAString.stringToInt(data.get("id").toString(), 0));
		String logType=  getRequest().getParameter("type");
		String id= null;
		if(logType!=null && !"cosInfoEdit".equals(logType) && !"personInfoEdit".equals(logType) &&!"basicInfoEdit".equals(logType)){
			id = getRequest().getParameter("id");
			data.put("logType", logType);
			if("refundFinish".equals(logType)){
				data.put("auto_note",data.get("action_note").toString());
			}else
				data.put("auto_note",getRequest().getParameter("action_note"));
			data.put("order_id", id);
		}
		ModelAndView mv = this.getModelAndView();
		if(logType!=null && !"cosInfoEdit".equals(logType) && !"personInfoEdit".equals(logType) &&!"basicInfoEdit".equals(logType)){
			orderService.edits(data);
		}else{
			data.put("order_id", data.getAsString("id"));
			orderService.edit(data);
		}
		PageData oldData = orderService.getById(EAString.stringToInt(data.get("id").toString(), 0));
		oldData.put("creator",getAdminName());
		oldData.put("auto_note",data.get("auto_note"));
		oldData.put("logType", logType);
		if("cosInfoEdit".equals(logType)){
			ordersLogService.cosInfoEdit(outData,oldData);
		}else if("personInfoEdit".equals(logType)){
			ordersLogService.personInfoEdit(outData,oldData);
		}else if(logType!=null && !"cosInfoEdit".equals(logType) && !"personInfoEdit".equals(logType) &&!"basicInfoEdit".equals(logType)){
			ordersLogService.creates(oldData);
		}else
		    ordersLogService.create(oldData);
		mv.setViewName("redirect:/sys/order/orders/edit?id="+data.getAsString("order_id"));
		return mv;
	}
	
	/**
	 * 删除订单商品并且调回并且跳回订单详情
	 * */
/*	@RequestMapping(value = "delete")
	public ModelAndView delete() {
		ModelAndView mv = new ModelAndView();
		PageData data=this.getPageData();
		ordersGoodsService.delete(data);
		mv.setViewName("redirect:/sys/order/orders/edit?id="+data.getAsString("order_id"));
		return mv;
	}*/
	
	/**
	 * 删除已被取消的订单
	 */
	@MethodLog(remark="删除已被取消的订单")
	@RequestMapping("del")
	public void del(HttpServletResponse response,String order_id){
		try{
			PageData orderPd = orderService.getById(EAString.stringToInt(order_id, 0));
			if(!"7".equalsIgnoreCase(orderPd.getAsString("order_status"))){
				super.outJson(response, REQUEST_FAILS, "非取消的订单无法删除", null);
				return;
			}
			orderService.deleteOrder(EAString.stringToInt(order_id, 0));
			super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}
	/**
	 * 跳转退货操作JSP
	 * */
	@RequestMapping(value = "selectSingle")
	public ModelAndView selectSingle(){
		ModelAndView mv = new ModelAndView();
		PageData data=this.getPageData();
		String order_id = data.getAsString("id");
		mv.addObject("order_id", order_id);
		mv.setViewName("order/orders/ordersReturn");
		return mv;
	}
	/**
	 * 去发货单页面
	 */
	@RequestMapping("genPage")
	public ModelAndView genPage(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("order/orders/waybill");
		PageData pd = this.getPageData();
		mv.addObject("order_id", pd.getAsString("order_id"));
		mv.addObject("action_note", pd.getAsString("action_note"));
		mv.addObject("companyList", Express.values());
		return mv;
	}
	
	/**
	 * 生成发货单
	 */
   @MethodLog(remark="生成发货单")
   @RequestMapping("generateDeliverBill")
   public void generateDeliverBill(HttpServletResponse response){
	   try{
		   PageData pd = this.getPageData();
			pd.put("create_time", EADate.getCurrentTime());
			PageData model = orderService.getById(EAString.stringToInt(pd.getAsString("order_id"), 0));
			pd.put("creator",getAdminName());
			//查询订单商品 将其组合成一个字符串
			List<PageData> orderGoods = ordersGoodsService.getByMap(pd);
			StringBuffer contentEX = new StringBuffer();
			
			for(PageData og :orderGoods){
				contentEX.append(og.getAsString("goods_name"));
				if(StringUtils.isNotEmpty(og.getAsString("goods_attr"))){
					contentEX.append("（");
					contentEX.append(og.getAsString("goods_attr"));
					contentEX.append("）");
				}
				contentEX.append("   ");
			}
			pd.put("ex_content", contentEX.toString());
			ordersShippingService.delete(model);
			ordersShippingService.create(pd,model);
			//更改订单公司配送费用   将订单的订单状态和配送状态更改成已发货
			model.put("shipping_fee", pd.getAsString("ex_money"));
			model.put("order_status","4");
			model.put("shipping_status","4");
			orderService.edit(model);
			model.put("logType","goCargo");
			ordersLogService.creates(model);//插入管理员操作日志
		   super.outJson(response, REQUEST_SUCCESS, "已生成发货单", null);
	   }catch(Exception e){
		   e.printStackTrace();
		   super.outJson(response, REQUEST_FAILS, "操作失败", null);
	   }
	   
	   
   }
   
   //查看物流
   @MethodLog(remark="查看物流")
   @RequestMapping("watchTrack")
   public ModelAndView watchTrack(){
	   ModelAndView mv = this.getModelAndView();
	   PageData pd = this.getPageData();
	   try {
		TrackMsgEntity trackMsg = ordersShippingService.queryExpressStatus(pd);
		mv.addObject("tracks", trackMsg);
	} catch (Exception e) {
		e.printStackTrace();
	}
	mv.setViewName("order/orders/watchTrack");
	return mv;
   }
}