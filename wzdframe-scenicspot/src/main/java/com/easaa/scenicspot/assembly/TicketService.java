package com.easaa.scenicspot.assembly;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.lang.StringUtils;

import com.easaa.core.util.Base64;
import com.easaa.core.util.EAString;
import com.easaa.core.util.MD5;
import com.easaa.entity.PageData;
import net.sf.json.JSONObject;

/**
 * 
 * 对接第三方平台的票务服务接口 所有的请求方式以http post请求方式 测试账号 ：123 测试密码：testsign
 * 
 * 加密算法 分销平台和所有合作方约定的加密规则进行加密认证，防止数据篡改和伪造； 加密方式： （1）加密方式：MD5，32位小写；
 * （2）拼接接口中的公用参数，请求内容报文RequestBody,PassWord； （3）生成签名方法：sign=
 * md5(UserName+Method+RequestBody+PassWord) ；
 * （4）平台接收到请求报文后，按照相同的签名算法进行加密，将双方的sign进行比对，如果一致，则验证通过； 传输方式 （1）接口采用http
 * post方式，RequestBody数据格式为Base64编码的字符串，字符串解密后为json格式；接口地址只有一个，
 * 根据传的Method方法名进入响应逻辑处理。 （2）统一采用utf-8编码； 1，票类查询接口 2，票类价格日历查询接口 3，下单接口， 4，退款接口
 * 
 * @author liujunbo
 * 
 *我们后台需要维护景区  票类信息，  
 *
 *如果某一景区需要添加票类信息的时候 需要先在票务平台系统添加票务信息   获取票务平台的唯一识别码
 *
 *然后再第三方平台系统添加对应的票务信息 关联到票务系统的唯一标识码。
 */
public class TicketService {

	// 票务系统分配的账号
	private static final String USERNAME = "egoal";

	// 票务系统分配的密码
	private static final String PASSWORD = "123456";

	// 票务系统请求的url
	private static final String TICKET_URL = "http://fx.szegoal.com/api/egoalv2/api/";

	// 票类型的请求方法
	private static final String GET_TICKE_TTYPE = "GetTicketTypes";
	//票价格请求方法
	private static final String TICKETTYPE_DAILYPRICE = "GetTicketTypeDailyPrice";
	//下单接口
	private static final String CREATE_ORDER = "CreateOrder";
	//退票接口
	private static final String REQUEST_REFUND = "RequestRefund";
	
	
	
	
	

	public static void main(String[] args) throws Exception {
		// String waitStr =
		// "{\"PageIndex\":\"1\",\"PageSize\":\"20\",\"TicketTypeId\":\"14242c56-d538-48fe-8bb6-3777d897a6b3\"}";
		getTicketTypes(null, null, null);
		
		//getTicketDailyPrice("2016-08-26","2016-09-26", "519f12be-d92c-4e9e-b369-2b2c05dbcce2");
	}

	/**
	 * 
	 * 票类查询接口 
	 * 
	 * 
	 * 方法名字 GetTicketTypes PageIndex：查询页索引 PageSize：查询数量
	 * TicketTypeId：票类编号
	 * 
	 * 
	 * {
    "Success": true,
    "Message": "成功",
    "ResponseBody": {
        "TotalQuantity": 4,
        "TicketTypeList": [
            {
                "TicketTypeId": "6d97d933-4b22-4c5e-9892-70594f6d39db",
                "TicketTypeName": "孔庙全票",
                "BeginSaleTime": "2017-03-23 00:00:00",
                "EndSaleTime": "2018-03-23 00:00:00",
                "BeginValidTime": "2017-03-23 00:00:00",
                "EndValidTime": "2018-02-01 00:00:00",
                "MarketPrice": 60,
                "RetailPrice": 50,
                "SettlementPrice": 46,
                "Stock": 500,
                "MinBuyCount": 0,
                "MaxBuyCount": 0,
                "AdvanceBookDays": 0,
                "LastBookTime": "23:18:45",
                "PaymentMethod": 1,
                "IsRealName": false,
                "IdCardLimitDays": 0,
                "IdCardLimitCount": 0
            },
	 * 
	 */
	public static String getTicketTypes(String pageIndexStr, String pageSizeStr, String ticketTypeId) {
		JSONObject requestBody = new JSONObject();
		int pageIndex = EAString.stringToInt(pageIndexStr, 1);
		int pageSize = EAString.stringToInt(pageSizeStr, 20);
		if (StringUtils.isNotEmpty(ticketTypeId)) {
			requestBody.put("TicketTypeId", ticketTypeId);
		}
		requestBody.put("PageIndex", pageIndex);
		requestBody.put("PageSize", pageSize);
		String requestBodyStr = Base64.encode(requestBody.toString().getBytes());
		requestBody.clear();
		requestBody.put("UserName", USERNAME);
		requestBody.put("Method", GET_TICKE_TTYPE);
		requestBody.put("Sign", SendRequest.getSign(GET_TICKE_TTYPE, requestBodyStr));
		requestBody.put("RequestBody", requestBodyStr);
		String result = SendRequest.post(TICKET_URL, requestBody.toString());
		JSONObject resultObj = JSONObject.fromObject(result);
		try {
			resultObj.put("ResponseBody", new String(Base64.decode(resultObj.get("ResponseBody").toString()),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println("票务系统返回的字符串:"+resultObj.toString());
		return resultObj.toString();
	}
	/**
	 * 票类价格日历查询接口
	 * 
	 * 方法名字 GetTicketTypeDailyPrice
	 * startDate:产品价格开始时间   格式 yyyy-MM-dd
	 * endDate:产品价格结束时间        格式 yyyy-MM-dd
	 * @author liujunbo
	 * @throws Exception 
	 * 
	 * 返回参数
	 * {
	    "Success": true,
	    "Message": "成功",
	    "ResponseBody": [
	        {
	            "TicketTypeId": "519f12be-d92c-4e9e-b369-2b2c05dbcce2",
	            "Date": "2017-08-26",
	            "MarketPrice": 65,
	            "RetailPrice": 60,
	            "SettlementPrice": 50,
	            "Stock": -1
	        },
	        {
	            "TicketTypeId": "519f12be-d92c-4e9e-b369-2b2c05dbcce2",
	            "Date": "2017-08-27",
	            "MarketPrice": 65,
	            "RetailPrice": 60,
	            "SettlementPrice": 50,
	            "Stock": -1
	        }]
	   }    
	 * 
	 */
	public static String getTicketDailyPrice(String startDate,String endDate,String ticketTypeId) throws Exception{
		if(StringUtils.isEmpty(startDate)){
			throw new Exception("产品价格开始时间不能为空");
		}
		if(StringUtils.isEmpty(endDate)){
			throw new Exception("产品价格结束时间不能为空");
		}
		if(StringUtils.isEmpty(ticketTypeId)){
			throw new Exception("票类id不能为空");
		}
		JSONObject requestBody = new JSONObject();
		requestBody.put("TicketTypeId",ticketTypeId);
		requestBody.put("StartDate",startDate);
		requestBody.put("EndDate",endDate);
		String requestBodyStr = Base64.encode(requestBody.toString().getBytes());
		requestBody.clear();
		requestBody.put("UserName", USERNAME);
		requestBody.put("Method", TICKETTYPE_DAILYPRICE);
		requestBody.put("Sign", SendRequest.getSign(TICKETTYPE_DAILYPRICE, requestBodyStr));
		requestBody.put("RequestBody", requestBodyStr);
		String result = SendRequest.post(TICKET_URL, requestBody.toString());
		JSONObject resultObj = JSONObject.fromObject(result);
		resultObj.put("ResponseBody", new String(Base64.decode(resultObj.get("ResponseBody").toString()),"utf-8"));
		System.out.println(resultObj.toString());
		return resultObj.toString();
	}
	/**
	 * 下单接口
	 * 
     *  thirdOrderId	是	string	合作方订单号
		ticketTypeId	是	string	票类编号
		retailPrice	是	number	零售价(精确到2位小数;单位:元)
		settlementPrice	是	number	结算价(精确到2位小数;单位:元)
		quantity	是	int	购买数量
		travelDate	是	string	游玩日期，格式yyyy-MM-dd
		contactName	是	string	联系人姓名
		contactMobile	是	string	联系人手机号
		paymentMethod	是	int	支付方式(1在线支付，2现场支付)
		otaName	否	string	OTA名称(如果合作方对接了美团携程等其他OTA，需提供订单来自哪家OTA)
		tourists	否	object	游玩人列表	
				Name	是	string	游玩人姓名
				Mobile	是	string	游玩人手机号
				IdCardNo	否	string	游玩人身份证号码(票类IsRealName为true时必选)
	 * @throws Exception 
	 */
	public static String createOrder(JSONObject param) throws Exception{
		JSONObject requestBody = param;
		/*checkParam(param,requestBody);
		requestBody.put("ThirdOrderId", param.get("thirdOrderId"));
		requestBody.put("TicketTypeId", param.get("ticketTypeId"));
		requestBody.put("RetailPrice", param.get("retailPrice"));
		requestBody.put("SettlementPrice", param.get("settlementPrice"));
		requestBody.put("Quantity", param.get("quantity"));
		requestBody.put("TravelDate", param.get("travelDate"));
		requestBody.put("ContactName", param.get("contactName"));
		requestBody.put("ContactMobile", param.get("contactMobile"));
		requestBody.put("PaymentMethod", param.get("contactMobile"));*/
		String requestBodyStr = Base64.encode(requestBody.toString().getBytes());
		requestBody.clear();
		requestBody.put("UserName", USERNAME);
		requestBody.put("Method", CREATE_ORDER);
		requestBody.put("Sign", SendRequest.getSign(CREATE_ORDER, requestBodyStr));
		requestBody.put("RequestBody", requestBodyStr);
		String result = SendRequest.post(TICKET_URL, new String(requestBody.toString().getBytes(),"utf-8"));
		JSONObject resultObj = JSONObject.fromObject(result);
		resultObj.put("ResponseBody", new String(Base64.decode(resultObj.get("ResponseBody").toString()),"utf-8"));
		System.out.println(resultObj.toString());
		return resultObj.toString();
	}
	
	
	
	/**
	 * 退款接口
	 * 
	 * listNo  票务平台订单号
	 * 
	 * refundId  合作方（本平台）退款流水号
	 * 
	 * refundQuantity  退款票数
	 * 
	 * refundReason  退款理由
	 * @throws Exception 
	 */
	public static String refund(PageData param) throws Exception{
		JSONObject requestBody = new JSONObject();
		if(StringUtils.isEmpty(param.getAsString("listNo"))){
			throw new Exception("票务平台订单号不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("refundId"))){
			throw new Exception("退款号不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("refundQuantity"))){
			throw new Exception("退款数量不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("refundReason"))){
			throw new Exception("退款理由不能为空");
		}
		if(StringUtils.isNotEmpty(param.getAsString("ticketCodes"))){
			requestBody.put("TicketCodes", param.getAsString("ticketCodes"));
		}
		requestBody.put("ListNo", param.getAsString("listNo"));
		requestBody.put("RefundId", param.getAsString("refundId"));
		requestBody.put("RefundQuantity", param.getAsString("refundQuantity"));
		requestBody.put("RefundReason", param.getAsString("refundReason"));
		String requestBodyStr = Base64.encode(requestBody.toString().getBytes());
		requestBody.clear();
		requestBody.put("UserName", USERNAME);
		requestBody.put("Method", REQUEST_REFUND);
		requestBody.put("Sign", SendRequest.getSign(REQUEST_REFUND, requestBodyStr));
		requestBody.put("RequestBody", requestBodyStr);
		String result = SendRequest.post(TICKET_URL, requestBody.toString());
		JSONObject resultObj = JSONObject.fromObject(result);
		resultObj.put("ResponseBody", new String(Base64.decode(resultObj.get("ResponseBody").toString()),"utf-8"));
		System.out.println(resultObj.toString());
		return resultObj.toString();
	}
	/**
	 * 检测下单参数
	 * @author liujunbo
	 * @throws Exception 
	 */
	public  static void checkParam(PageData param,JSONObject requestBody) throws Exception{
		
		if(StringUtils.isEmpty(param.getAsString("thirdOrderId"))){
			throw new Exception("订单id不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("ticketTypeId"))){
			throw new Exception("票类id不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("retailPrice"))){
			throw new Exception("零售价不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("settlementPrice"))){
			throw new Exception("结算价格不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("quantity"))){
			throw new Exception("购买数量不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("travelDate"))){
			throw new Exception("游玩日期不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("contactMobile"))){
			throw new Exception("联系人手机号不能为空");
		}
		if(StringUtils.isEmpty(param.getAsString("contactName"))){
			throw new Exception("联系人姓名不能为空");
		}
		if(StringUtils.isNotEmpty(param.getAsString("otaName"))){
			requestBody.put("OtaName", param.getAsString("otaName"));
		}
		if(StringUtils.isNotEmpty(param.getAsString("tourists"))){
			requestBody.put("Tourists", param.getAsString("tourists"));
		}
	}
	
	public static class SendRequest {
		/**
		 * 签名算法 md5(UserName+Method+RequestBody+PassWord)
		 */
		public static String getSign(String method, String requestBody) {
			String signStr = USERNAME + method + requestBody + PASSWORD;
			return MD5.md5(signStr);
		}
		/**
		 * 发送post请求
		 * @param url
		 * @param param
		 * @return
		 */
		public static String post(String url, String param) {
			PrintWriter out = null;
			BufferedReader in = null;
			String result = "";
			try {
				URL realUrl = new URL(url);
				/* param=new String(param.getBytes(), "utf-8"); */
				// 打开和URL之间的连接
				HttpURLConnection conn = (HttpURLConnection) realUrl.openConnection();
				// 设置通用的请求属性
				conn.setRequestProperty("accept", "*/*");
				conn.setRequestProperty("connection", "Keep-Alive");
				conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
				conn.setRequestProperty("Accept-Charset", "utf-8");
				conn.setRequestProperty("contentType", "utf-8");
				conn.setRequestProperty("Charsert", "UTF-8");
				// 发送POST请求必须设置如下两行
				conn.setDoOutput(true);
				conn.setDoInput(true);
				out = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(), "utf-8"));
				// 发送请求参数
				out.print(param);
				// flush输出流的缓冲
				out.flush();
				// 定义BufferedReader输入流来读取URL的响应
				in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
				String line;
				while ((line = in.readLine()) != null) {
					result += line;
				}
			} catch (Exception e) {
				System.out.println("发送 POST 请求出现异常！" + e);
				e.printStackTrace();
			}
			// 使用finally块来关闭输出流、输入流
			finally {
				try {
					if (out != null) {
						out.close();
					}
					if (in != null) {
						in.close();
					}
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}
			return result;
		}
	}
}
