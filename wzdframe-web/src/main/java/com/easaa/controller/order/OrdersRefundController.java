package com.easaa.controller.order;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.apache.http.client.HttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.filter.HttpUtils;
import com.easaa.goods.service.GoodsService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.order.service.OrderService;
import com.easaa.order.service.OrdersGoodsService;
import com.easaa.order.service.OrdersRefundService;

import net.sf.json.JSONObject;

/**
 * 
 * 退货说明  退货针对商品而言  对订单状态无影响   对于无理由退货的商品  后台无需审核直接退货
 * @author liujunbo
 *
 */


@Controller
@RequestMapping("/sys/order/refund/")
public class OrdersRefundController extends BaseController {
	
	@Autowired
	private OrdersRefundService ordersRefundService;
	
	@Autowired
	private OrdersGoodsService orderGoodsService;
	
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private OrderService orderService;
	
	
	/**
	 * 发货单管理
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> varList = ordersRefundService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("order/refund/list");
		return mv;
	}
	@RequestMapping(value="edit")
	public ModelAndView edit(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getAsString("refund_id")))
		{
			mv.addObject("dataModel", ordersRefundService.getById(EAString.stringToInt(pd.getAsString("refund_id"), 0)));
		}
		mv.setViewName("order/refund/edit");
		return mv;
	}
	
	/**
	 * 调起退款金额页面
	 * 
	 * 1，商品 1  价格50    可使用积分 3      商品2 价格100  可使用积分  10    用户使用了 10个积分支付该订单
	 * 1商品退货   则退还给用户 3个积分  现金  47
	 */
	@RequestMapping(value="refundMoneyPage")
	public ModelAndView refundMoneyPage(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		//根据order_id查询商品  看该商品是否支持积分支付  如果不支持积分支付  则退换商品的销售价格 
		//如果商品  支持积分支付则退换商品的最大积分  
		PageData pd = this.getPageData();
		pd.put("user_name", this.getAdminName());
		PageData orderGoods = orderGoodsService.getById(EAString.stringToInt(pd.getAsString("order_goods_id"), 0));
		PageData goods = goodsService.getById(EAString.stringToInt(orderGoods.getAsString("goods_id"), 0));
		//查询订单
	
		PageData orderPd = orderService.getById(EAString.stringToInt(orderGoods.getAsString("order_id"), 0));
		//查看订单是否使用积分支付
		BigDecimal goodsPrice = orderGoods.getAsBigDecimal("goods_price").multiply(orderGoods.getAsBigDecimal("goods_count"));
		pd.put("order_id", orderGoods.getAsString("order_id"));
		pd.put("order_sn", orderPd.getAsString("order_sn"));
		pd.put("user_id", orderPd.getAsString("user_id"));
		pd.put("goods_name", goods.getAsString("goods_name"));
		pd.put("sku_id", orderGoods.getAsString("goods_sku_id"));
		pd.put("goods_id", goods.getAsString("goods_id"));
		pd.put("returnStore", orderGoods.getAsString("goods_count"));
		pd.put("order_goods_id", orderGoods.getAsString("order_goods_id"));
		if(StringUtils.isNotEmpty(orderPd.getAsString("pay_by_points")) && Double.parseDouble(orderPd.getAsString("pay_by_points")) != 0.0){
			Map<String,PageData> setting =  goodsService.selectGoodsSetting();
			if(goods.getAsInteger("pay_points") == null || goods.getAsInteger("pay_points") == 0){
				//该商品不支持积分支付  全额退款 
				//pd.put("", value)
				pd.put("returnPoint",0);
				pd.put("returnMoney", goodsPrice);
			}else{
				//获取人民币积分比例
				 int point =  0;
				 BigDecimal pointMoney = BigDecimal.valueOf(0);
				 String settingValue = "";
				try{
				    settingValue = setting.get("00103").getAsString("setting_value");
				}catch(Exception e){
					//默认比例是1:10
					settingValue = "1:10";
				}
				String[] relat = settingValue.split(":");
			    //订单可以使用的积分个数
				point = new BigDecimal(orderPd.getAsString("pay_by_points")).multiply(new BigDecimal(relat[1])).divide(new BigDecimal(relat[0]), 2,
						RoundingMode.FLOOR).intValue(); 
				if(point > goods.getAsInteger("pay_points")){
				    	pd.put("returnPoint", goods.getAsInteger("pay_points"));
			    }else{
			    	pd.put("returnPoint",point);
			    }
				//计算积分 所抵金额
				pointMoney=  BigDecimal.valueOf(pd.getAsInteger("returnPoint"))
						     .divide(BigDecimal.valueOf(Double.parseDouble(relat[1])), 2,
										RoundingMode.FLOOR)
						     .multiply(BigDecimal.valueOf(Double.parseDouble(relat[0])));	
				BigDecimal returnMoney = goodsPrice.subtract(pointMoney);
				pd.put("returnMoney", returnMoney);
			}
			pd.put("recovery", "0");
		}else{
			pd.put("returnPoint","0");
			pd.put("returnMoney", goodsPrice);
			//如果订单没有使用积分支付  那么看商品是否有返还积分
			if(StringUtils.isNotEmpty(orderPd.getAsString("give_points")) 
					&& "0".equalsIgnoreCase(orderPd.getAsString("give_points"))){
				if(StringUtils.isNotEmpty(goods.getAsString("give_points"))){
					pd.put("recovery", goods.getAsString("give_points"));
				}else{
					pd.put("recovery", "0");
				}
			}else{
				pd.put("recovery","0");
			}
		}
		HttpSession session = request.getSession(false);
		if(session.getAttribute("returnPd") != null){
			session.removeAttribute("returnPd");
		}
		session.setAttribute("returnPd", pd);
		mv.addObject("dateModel", pd);
		mv.setViewName("order/refund/ordersReturn");
		return mv;
	}
	@RequestMapping("refundFinish")
	public void refundFinish(HttpServletRequest request,HttpServletResponse response){
		try{
			PageData returnPd = (PageData) this.getSessionAttribute(request, "returnPd");
			ordersRefundService.updateReturnAccount(returnPd);
			super.outJson(response, this.REQUEST_SUCCESS, "已退回",null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, this.REQUEST_FAILS, "请求失效",null);
		}
	}
	
	
	@MethodLog(remark="退款操作")
	@RequestMapping("refundOrder")
	public void refundOrder(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			
			pd.put("user_name", this.getAdminName());
			PageData refundOrder = ordersRefundService.getById(pd.getAsInteger("refund_id"));
			if(StringUtils.isNotEmpty(pd.getAsString("status"))){
				if(pd.getAsString("status").equalsIgnoreCase("2")){
					//拒绝退款
					//退款单日志
					//修改退货单状态为已拒绝
					PageData refundLog = new PageData();
					refundLog.put("refund_id", pd.get("refund_id"));
					refundLog.put("refund_status", 2);
					refundLog.put("creator", pd.getAsString("user_name"));
					refundLog.put("refund_remark", "管理员"+pd.getAsString("user_name")+",驳回了"+refundOrder.getAsString("goods_name")+"该商品的退款申请");
					ordersRefundService.edit(refundLog);
					//更新订单商品表里面的退款字段
					PageData orderGoods = new PageData();
					orderGoods.put("order_goods_id", refundOrder.getAsString("order_goods_id"));
					orderGoods.put("is_refund", 2);
					orderGoodsService.edit(orderGoods);
					//退货日志
					refundLog.clear();
					refundLog.put("refund_id", pd.get("refund_id"));
					refundLog.put("log_note", "管理员"+pd.getAsString("user_name")+",驳回了"+refundOrder.getAsString("goods_name")+"该商品的退款申请");
					refundLog.put("creator", pd.getAsString("user_name"));
					refundLog.put("create_time", EADate.getCurrentTime());
					ordersRefundService.insertRefundLog(refundLog);
				}else if(pd.getAsString("status").equalsIgnoreCase("3")){
					//同意退款
					pd.put("order_id", refundOrder.getAsString("order_id"));
					pd.put("order_sn", refundOrder.getAsString("order_sn"));
					pd.put("user_id", refundOrder.getAsString("user_id"));
					pd.put("goods_name", refundOrder.getAsString("goods_name"));
					pd.put("sku_id", refundOrder.getAsString("goods_sku_id"));
					pd.put("goods_id", refundOrder.getAsString("goods_id"));
					pd.put("returnStore", refundOrder.getAsString("goods_count"));
					pd.put("recovery", refundOrder.getAsString("resive_points"));
					pd.put("returnPoint", refundOrder.getAsString("refund_points"));
					pd.put("returnMoney", refundOrder.getAsString("refund_money"));
					pd.put("order_goods_id", refundOrder.getAsString("order_goods_id"));
					pd.put("reback_type", "1"); //0 退余额  1
					ordersRefundService.updateReturnAccount(pd);
					
					//请求接口调用退款方法
					PageData paramspd= new PageData();
					paramspd.put("type", "2");
					paramspd.put("refundId", refundOrder.getAsString("order_id"));
					String params=Base64.encode(JSONObject.fromObject(paramspd).toString().getBytes());
					String url="http://liujunbo.tunnel.qydev.com/pay/getRefundConfig?paramStr="+params;
					String strResult=HttpUtils.getHttpPOSTStr(url); 
					System.out.println(strResult);
				}
			}
			super.outJson(response, this.REQUEST_SUCCESS, "操作成功",null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, this.REQUEST_FAILS, "请求失效",null);
		}
	}
	
	
	
	
}
