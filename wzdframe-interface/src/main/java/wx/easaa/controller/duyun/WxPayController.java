package wx.easaa.controller.duyun;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xml.sax.SAXException;

import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.order.service.OrderService;
import com.easaa.rebate.service.RebateOrderService;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.GuiderService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.wechat.common.Configure;
import com.easaa.wechat.pay.PayUtil;
import com.tencent.common.XMLParser;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/duyun/pay/")
public class WxPayController extends BaseController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private TicketOrderService ticketOrderService;
	
	@Autowired
	private GroupTourService groupTourService;
	
	@Autowired
	private RebateOrderService rebateOrderService;
	
	@Autowired
	private GuiderService guiderService;
	/**
	 * 
	 * 获取支付的配置 money 支付金额 type =1   商品支付   2 门票 3 跟团游 4   5导游预约
	 * @throws SAXException 
	 * @throws IOException 
	 * @throws ParserConfigurationException 
	 */
	@RequestMapping("dogetPayConfig")
	public  void getPayConfirg(String money, String type,String orderId,HttpServletResponse response,HttpServletRequest request) throws ParserConfigurationException, IOException, SAXException {
		/**
		 * 查询订单
		 */
		PageData order = null;
		String body = "";
		String billNo  = System.currentTimeMillis()+EAString.getRandomString(4);
		if("1".equalsIgnoreCase(type)){
			//商品支付
			order = orderService.getById(EAString.stringToInt(orderId, 0));
			order.put("order_sn", billNo+"SP-F");
			orderService.edit(order);
			billNo = order.getAsString("order_sn");
			body = "汉唐影视城-商品支付";
		}
		if("2".equalsIgnoreCase(type)){
			//门票支付
			order = ticketOrderService.getById(EAString.stringToInt(orderId, 0));
			order.put("ticket_order_no", billNo+"PW-F");
			ticketOrderService.edit(order);
			billNo = order.getAsString("ticket_order_no");
			body = "汉唐影视城-票务支付";
		}
		if("3".equalsIgnoreCase(type)){
			//跟团游支付
			order = groupTourService.selectOrderById(EAString.stringToInt(orderId, 0));
			order.put("order_sn", billNo+"GT-F");
			groupTourService.updateOrder(order);
			billNo = order.getAsString("order_sn");
			body = "汉唐影视城-跟团游支付";
		}
		if("4".equalsIgnoreCase(type)){
			order = ticketOrderService.getAllOrderById(orderId);
			billNo = order.getAsString("order_sn");
			body = "汉唐影视城-票务支付";
		}
		if("5".equalsIgnoreCase(type)){
			//导游支付
			order = guiderService.getById(EAString.stringToInt(orderId, 0));
			order.put("order_sn", billNo+"GU-F");
			guiderService.edit(order);
			billNo = order.getAsString("order_sn");
			body = "汉唐影视城-导游预约支付";
		}
		if(order == null){
			super.outJson(super.REQUEST_FAILS, "无订单", null, response);
		}else{
			PageData result = PayUtil.wxSignJsApi(money,billNo,body,(String)this.getSessionAttribute(request, "open_id"));
			result.put("timeStamp", String.valueOf(System.currentTimeMillis()/1000));
			result.put("appId", Configure.getAppid());
			super.outJson(super.REQUEST_SUCCESS, "查询成功", result, response);
		}
	}
	/**
	 * 商品支付回调函数
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
				// 3 公众号微信支付
				param.put("pay_type", "3");
				boolean flag = false;
				if(out_trade_no.endsWith("SP")){
					flag = rebateOrderService.doDuyunWechartCall(param);
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
	
}
