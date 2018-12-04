package logic.easaa.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easaa.core.util.Base64;
import com.easaa.core.util.MD5;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;
import com.easaa.wechat.pay.PayUtil;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

/**
 * 票务系统回调接口
 * 
 * 1 订单核销通知接口
 * 2，退款结果通知接口
 * @author liujunbo
 *
 */

@Controller
@RequestMapping("/logic/ticket/")
public class TicketCallController extends BaseController{

	
	private static final String NOTICE_CONSUME = "NoticeConsume";
	private static final String NOTICE_REFUND = "NoticeRefund";
	
	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	
	@Autowired
	private TicketOrderService ticketOrderService;
	
	
	@RequestMapping("notify")
	public void notify(HttpServletResponse response,HttpServletRequest request,@RequestParam(defaultValue="")String UserName,
			@RequestParam(defaultValue="")String Method,
			@RequestParam(defaultValue="")String Sign,
			@RequestParam(defaultValue="")String RequestBody){
		PageData responseBody = new PageData();
		PageData exceptionMsg = new PageData();
		try {
			/**
		     * 校验签名
		     */
			StringBuffer  paramStr = new StringBuffer();
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
			String s = "";
			while ((s = br.readLine()) != null) {
				paramStr.append(s);
			}
			JSONObject jsonObj = JSONObject.fromObject(paramStr.toString());
			UserName = jsonObj.getString("UserName");
			Method = jsonObj.getString("Method");
			Sign = jsonObj.getString("Sign");
			RequestBody = jsonObj.getString("RequestBody");
			StringBuffer signStr = new StringBuffer();
			signStr.append(UserName).append(Method).append(RequestBody)
					.append(PROPERTIESHELPER.getValue("ticket_password"));
			if(!Sign.equalsIgnoreCase(MD5.md5(signStr.toString()))){
				responseBody.put("Success", false);
				responseBody.put("Message", "签名错误");
				responseBody.put("ResponseBody", "签名错误");
				super.outJson(response, responseBody);
				return;
			}
			//解密RequestBody
			RequestBody = new String(Base64.decode(RequestBody),"utf-8");
		    JSONObject jsonObject = JSONObject.fromObject(RequestBody);
		    PageData paramPd = new PageData();
			if(NOTICE_CONSUME.equalsIgnoreCase(Method)){
				 //订单核销通知接口
				paramPd.put("listNo", jsonObject.getString("ListNo"));
				paramPd.put("thirdOrderId", jsonObject.getString("ThirdOrderId"));
				paramPd.put("totalQuantity", jsonObject.getString("TotalQuantity"));
				paramPd.put("usedQuantity", jsonObject.getString("UsedQuantity"));
				paramPd.put("refundQuantity", jsonObject.getString("RefundQuantity"));
				paramPd.put("consumeQuantity", jsonObject.getString("ConsumeQuantity"));
				paramPd.put("consumeTime", jsonObject.getString("ConsumeTime"));
				paramPd.put("ticketCode", jsonObject.get("TicketCode"));
				paramPd.put("optType", "1");
				ticketOrderService.orderRefund(paramPd);
			}else if(NOTICE_REFUND.equalsIgnoreCase(Method)){
				//退款结果通知接口
				paramPd.put("listNo", jsonObject.getString("ListNo"));
				paramPd.put("thirdOrderId", jsonObject.getString("ThirdOrderId"));
				paramPd.put("refundId", jsonObject.getString("RefundId"));
				//退款状态(1退款申请成功；2退款成功；3退款失败)
				paramPd.put("refundStatus", jsonObject.getString("RefundStatus"));
				paramPd.put("auditMemo", jsonObject.getString("AuditMemo"));
				exceptionMsg.put("refundId", jsonObject.getString("RefundId"));
				paramPd.put("optType", "2");
				ticketOrderService.doRefundSuc(paramPd);
			}
			responseBody.put("Success", true);
			responseBody.put("Message", "成功");
			responseBody.put("ResponseBody", "");
			super.outJson(response, responseBody);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			if(exceptionMsg.get("refundId") != null){
				exceptionMsg.put("exception_msg", e.getMessage());
				exceptionMsg.put("id", exceptionMsg.get("refundId"));
				ticketOrderService.updateRefund(exceptionMsg);
			}
			e.printStackTrace();
			responseBody.put("Success", false);
			responseBody.put("Message", e.getMessage());
			responseBody.put("ResponseBody", "");
			super.outJson(response, responseBody);
		}
	
	}
	
}
