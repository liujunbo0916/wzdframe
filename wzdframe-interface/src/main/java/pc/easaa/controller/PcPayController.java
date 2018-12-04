package pc.easaa.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.easaa.ali.pay.AliPaySetting;
import com.easaa.core.tool.QrGena;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.order.service.OrderService;
import com.easaa.order.service.OrdersRefundService;
import com.easaa.rebate.service.RebateOrderService;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.GuiderService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.wechat.common.Configure;
import com.easaa.wechat.pay.PayUtil;
import com.google.zxing.WriterException;
import com.tencent.common.XMLParser;

import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;
import wx.easaa.controller.comm.BaseController;

/**
 * 支付相关操作
 * @author liujunbo
 *
 */
@RequestMapping("/pay/")
@Controller
public class PcPayController extends BaseController{
	@Autowired
	private OrdersRefundService ordersRefundService;
	@Autowired
	private TicketOrderService ticketOrderService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private GroupTourService groupTourService;
	
	@Autowired
	private RebateOrderService rebateOrderService;
	
	@Autowired
	private GuiderService guiderService;
	
	@RequestMapping("getPayConfig")
	public  void getPayConfirg(HttpServletResponse response,HttpServletRequest request) throws ParserConfigurationException, IOException, SAXException, AlipayApiException {
		
		PageData pd = this.getPageData();
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		String money = paramObj.getString("money");
		String type = paramObj.getString("type");
		String orderId = paramObj.getString("orderId");
		String payType = paramObj.getString("payType"); //1为支付宝支付  2为微信支付
		/**
		 * 查询订单
		 */
		PageData order = null;
		String body = "";
		String billNo  = System.currentTimeMillis()+EAString.getRandomString(4);
		if("1".equalsIgnoreCase(type)){ //票务支付
			order = ticketOrderService.getById(EAString.stringToInt(orderId, 0));
			//生成订单号
			order.put("ticket_order_no",billNo+"PW-F" );
			body = "汉唐影视城-票务支付";
			billNo = order.getAsString("ticket_order_no");
			order.put("id", orderId);
			ticketOrderService.edit(order);
		}else if("2".equalsIgnoreCase(type)){
			order = orderService.getById(EAString.stringToInt(orderId, 0));
			//商品支付
			order.put("order_sn",billNo+"SP-F" );
			body = "汉唐影视城-商品支付";
			billNo = order.getAsString("order_sn");
			orderService.edit(order);
		}else if("3".equalsIgnoreCase(type)){
			//路线支付
			order = groupTourService.selectOrderById(EAString.stringToInt(orderId, 0));
			order.put("order_sn",billNo+"GT-F" );
			body = "汉唐影视城-跟团游支付";
			billNo = order.getAsString("order_sn");
			groupTourService.updateOrder(order);
		}
		if(order == null){
			super.outJson(REQUEST_FAILS, "无订单", null, response);
		}else{
			if("1".equals(payType)){
				//支付宝支付
				//获得初始化的AlipayClient
				AlipayClient alipayClient = new DefaultAlipayClient(AliPaySetting.ALI_GATEWAYURL, AliPaySetting.ALI_PARTNER, AliPaySetting.ALI_RSA_PRIVATE, "json", AliPaySetting.ALI_CHARSET, AliPaySetting.ALI_RSA_PUBLICK_KEY, AliPaySetting.ALI_SIGN_TYPE);
				//设置请求参数
				AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
				alipayRequest.setReturnUrl(AliPaySetting.ALI_RETURN_URL);
				alipayRequest.setNotifyUrl(AliPaySetting.ALI_NOTIFY_URL);
				//商品描述，可空
				alipayRequest.setBizContent("{\"out_trade_no\":\""+ billNo +"\"," 
						+ "\"total_amount\":\""+ money +"\"," 
						+ "\"subject\":\""+ body +"\"," 
						+ "\"body\":\""+ body +"\"," 
						+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
				//若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
				//alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
				//		+ "\"total_amount\":\""+ total_amount +"\"," 
				//		+ "\"subject\":\""+ subject +"\"," 
				//		+ "\"body\":\""+ body +"\"," 
				//		+ "\"timeout_express\":\"10m\"," 
				//		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
				//请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节
				//请求
				String result = alipayClient.pageExecute(alipayRequest).getBody();
				response.setContentType("text/html;charset=utf-8"); 
				response.getWriter().write(result);
				response.getWriter().flush();
			}else{
				//微信支付
				PageData result = PayUtil.wxSignPack(money,billNo,body,(String)this.getSessionAttribute(request, "open_id"));
				result.put("timeStamp", String.valueOf(System.currentTimeMillis()/1000));
				result.put("appId", Configure.getAppid());
				super.outJson(REQUEST_SUCCESS, "查询成功", result, response);
			}
		}
	}
	
	@RequestMapping("aliPay")
	public ModelAndView aliPay(HttpServletResponse response) throws IOException, AlipayApiException{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/pc/alipay");
		return mv;
	}
	/**
	 * 微信退款接口
	 * @throws SAXException 
	 * @throws IOException 
	 * @throws ParserConfigurationException 
	 */
	@RequestMapping("getRefundConfig")
	public  void  refund(HttpServletResponse response,HttpServletRequest request) 
			throws ParserConfigurationException, IOException, SAXException{
		PageData pd = this.getPageData();
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		/**
		 * 1代表票务退款  2代表商品退款 3路线退款
		 */
		String type = paramObj.getString("type"); 
		String refundId = paramObj.getString("refundId");
		String totalFee = null,refundFee = null,outRefundNo = null;
		/**
		 * 查询订单
		 */
		PageData order = null;
		String billNo  = System.currentTimeMillis()+EAString.getRandomString(4);
		if("1".equalsIgnoreCase(type)){ //票务支付
			order = ticketOrderService.selectRefundById(EAString.stringToInt(refundId, 0));
			//生成订单号
			order.put("refund_no",billNo+"PW-R" );
			ticketOrderService.updateRefund(order);
			billNo = order.getAsString("order_no");
			outRefundNo = order.getAsString("refund_no"); 
			totalFee = order.getAsString("order_money");
			refundFee = order.getAsString("refund_money");
			 /**
			  * 请求退款接口   
			  * 只有接口请求成功才能退给用户钱
			  */
			PageData  requestRefund = new PageData();
		    try {      
		    	requestRefund.put("out_trade_no", billNo);
		    	requestRefund.put("out_refund_no", outRefundNo);
				ticketOrderService.doRefundSuc(requestRefund);
			} catch (Exception e) {
				super.outJson(REQUEST_FAILS, e.getMessage(), null, response);
				return;
			}
		}else if("2".equalsIgnoreCase(type)){
			order = ordersRefundService.getById(EAString.stringToInt(refundId, 0));
			//生成订单号
			order.put("refund_no",billNo+"SP-R" );
			ordersRefundService.edit(order);
			billNo = order.getAsString("order_sn");
			outRefundNo = order.getAsString("refund_no"); 
			totalFee = order.getAsString("order_money");
			refundFee = order.getAsString("refund_money");
		}
		if(StringUtils.isEmpty(order.getAsString("refund_type")) || "2".equals(order.getAsString("refund_type"))){
			   //微信退款
			   PageData result = PayUtil.wxRefund(totalFee, refundFee, billNo, outRefundNo);
			   if("SUCCESS".equals(result.getAsString("refund_result"))){
				   //微信退款成功
				   super.outJson(REQUEST_SUCCESS, "退款成功", result, response);
				   return;
			   }else{
				   super.outJson(REQUEST_FAILS, "退款失败", result, response);
				   return;
			   }
			
		}
	}
	/**
	 * 支付回调函数
	 * @throws IOException 
	 */
	@RequestMapping("payCallBack")
	public void  venuePayCallBack(HttpServletResponse response,HttpServletRequest request) throws IOException{
		System.out.println("###########微信回掉开始#################################");
		String turndata = ""; // 返回xml字符串
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		ServletOutputStream os = null;
		try {
			os = response.getOutputStream();
			StringBuffer sb = new StringBuffer();
			String s = "";
			while ((s = br.readLine()) != null) {
				sb.append(s);
			}
			String str = sb.toString();
			Map<String, Object> datamap = XMLParser.getMapFromXML(str);
			if ("SUCCESS".equals(datamap.get("return_code")) && "SUCCESS".equals(datamap.get("result_code"))) {
				String out_trade_no = (String) datamap.get("out_trade_no");
				/**
				 * 订单逻辑处理 活动预支付订单处理
				 */
				PageData param = new PageData();
				param.put("out_trade_no", out_trade_no);
				// 3 微信支付
				param.put("pay_type", "2");
				boolean flag = false;
				if(out_trade_no.endsWith("SP-F")){
					flag = rebateOrderService.doDuyunWechartCall(param);
				}else if(out_trade_no.endsWith("PW-F")){
					//flag = venueService.doVenueWxCall(param);
					flag = ticketOrderService.callBack(param);
				}else if(out_trade_no.endsWith("GT-F")){
					//flag = userChargeService.doWxCall(param);
					flag = groupTourService.callBack(param);
				}else if(out_trade_no.endsWith("PW-ZDD")){
					flag = ticketOrderService.callBackAllOrder(param);
				}else if(out_trade_no.endsWith("GT-F")){
					flag = guiderService.callBackAllOrder(param);
				}
				if (flag) {
					turndata = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
				} else {
					turndata = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[ERROR]]></return_msg></xml>";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			turndata = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[ERROR]]></return_msg></xml>";
		}
		try {
			os.write(turndata.getBytes());
			os.flush();
			os.close();
		} catch (IOException e) {
		}
		System.out.println("微信回调结束");
	}
	
	@RequestMapping("aliCallBack")
	public void aliCallBack(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("############支付宝回掉开始#################################");
			Map<String, String> params = new HashMap<String, String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
				}
				params.put(name, valueStr);
			}
			String pay_sn = request.getParameter("out_trade_no");
			String tradeStatus = request.getParameter("trade_status");
			String notifyId = request.getParameter("notify_id");
			System.out.println("======>> " + tradeStatus + "=========>>" + notifyId);
			if (tradeStatus.equals("TRADE_FINISHED")) {
				// 判断该笔订单是否在商户网站中已经做过处理
				// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				// 如果有做过处理，不执行商户的业务程序
				// 注意：
				// 该种交易状态只在两种情况下出现
				// 1、开通了普通即时到账，买家付款成功后。
				// 2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
			} else if (tradeStatus.equals("TRADE_SUCCESS")) {
				// 判断该笔订单是否在商户网站中已经做过处理
				// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				// 如果有做过处理，不执行商户的业务程序
				// 注意：
				// 该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
				PageData param = new PageData();
				param.put("out_trade_no", pay_sn);
				//支付方式 0微信 1支付宝 2余额
				param.put("pay_type", "1");
				if(pay_sn.endsWith("SP-F")){
					rebateOrderService.doDuyunWechartCall(param);
				}else if(pay_sn.endsWith("PW-F")){
					//flag = venueService.doVenueWxCall(param);
					ticketOrderService.callBack(param);
				}else if(pay_sn.endsWith("GT-F")){
					//flag = userChargeService.doWxCall(param);
					groupTourService.callBack(param);
				}
				System.out.println("支付成功");
				response.getWriter().write("success");
				response.getWriter().flush();
				response.getWriter().close();
			} else {// 验证失败
				System.out.println("支付严重失败 ===>> " + tradeStatus);
				response.getWriter().write("fail");
				response.getWriter().flush();
				response.getWriter().close();
			}
		} catch (Exception e) {
			try {
				response.getWriter().write("fail");
				response.getWriter().flush();
				response.getWriter().close();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("############支付宝回调结束#################################");
	}
	/**
	 * 
	 * 扫码成功回调页面
	 * 
	 */
	@RequestMapping("scanSuccess")
	public void scanSuccess(HttpServletResponse response ,HttpServletRequest request){
		PageData pd = this.getPageData();
		PageData orderInfo = null;
		try{
			String orderId = pd.getAsString("orderId");
			String type = pd.getAsString("type");
			if("ticket".equals(type)){
				orderInfo = ticketOrderService.getById(EAString.stringToInt(orderId, 0));
			}else if("product".equals(type)){
				orderInfo = orderService.getById(EAString.stringToInt(orderId, 0));
			}else if("travel".equals(type)){
				orderInfo = groupTourService.selectOrderById(EAString.stringToInt(orderId, 0));
			}
			orderInfo.put("type", type);
			this.outJson(REQUEST_SUCCESS, "请求成功", orderInfo, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 
	 * 支付宝PC支付 回调的Url
	 * 
	 * 
	 */
	@RequestMapping("/aliReturn")
	public ModelAndView aliReturnAction(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String out_trade_no = pd.getAsString("out_trade_no");
		System.out.println("进入阿里页面同步回调方法《》《》《》《》》《《》》《》《》《》订单号"+out_trade_no);
		PageData pdJson = new PageData();
		if(out_trade_no.endsWith("SP-F")){
			PageData order = orderService.selectByOrderSn(out_trade_no);
			pdJson.put("type", "product");
			pdJson.put("id", order.getAsString("order_id"));
			pdJson.put("to_contact_mobile", order.getAsString("contact_phone"));
			pdJson.put("ticket_order_no", out_trade_no);
		}else if(out_trade_no.endsWith("GT-F")){
			PageData order = groupTourService.selectByOrderSn(out_trade_no);
			pdJson.put("type", "travel");
			pdJson.put("id", order.getAsString("order_id"));
			pdJson.put("to_contact_mobile", order.getAsString("link_phone"));
			pdJson.put("ticket_order_no", out_trade_no);
		}else if(out_trade_no.endsWith("PW-F")){
			PageData order = ticketOrderService.selectByOrderNo(out_trade_no);
			pdJson.put("type", "ticket");
			pdJson.put("id", order.getAsString("id"));
			pdJson.put("to_contact_mobile", order.getAsString("to_contact_mobile"));
			pdJson.put("ticket_order_no", out_trade_no);
		}
		System.out.println("封装的支付成功对象<><><><>><><><><><><><><><><"+JSONObject.fromObject(pdJson).toString());
		mv.setViewName("redirect:/pay/paySuccess?paramStr="+Base64.encode(JSONObject.fromObject(pdJson).toString().getBytes()));
		return mv;
	}
	
	/**
	 * 
	 * 支付成功页面
	 * @throws UnsupportedEncodingException 
	 * 
	 */
	@RequestMapping("paySuccess")
	public ModelAndView paySuccess() throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String paramStr = pd.getAsString("paramStr");
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(paramStr),"utf-8"));
		mv.addObject("dataModel", paramObj);
		mv.setViewName("/pc/order.success");
		return mv;
	}
	/**
	 * 
	 * 二维码生成工具
	 * @throws IOException 
	 * @throws WriterException 
	 * 
	 * 
	 * 
	 */
	@RequestMapping("qrGen")
	public void  qrGen(HttpServletRequest request,
			String payContent,@RequestParam(defaultValue="220")Integer width,@RequestParam(defaultValue="220")Integer height,
			HttpServletResponse response) throws IOException, WriterException{
		String contentPath = request.getSession().getServletContext().getRealPath("/");
		contentPath += "\\img\\duyun\\pc\\suc_pay.png";
		File file = new File(contentPath);
		BufferedImage imge = QrGena.genBarcode(payContent, width, height, file.getAbsolutePath());
		response.setContentType("image/jpeg");// 设置相应信息的类型
	    OutputStream os = response.getOutputStream();
	    ImageIO.write(imge,"jpg",os);
		os.flush();
		os.close();
	}
}
