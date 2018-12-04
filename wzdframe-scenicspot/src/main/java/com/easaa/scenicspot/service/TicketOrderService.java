package com.easaa.scenicspot.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EASMS;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.assembly.PayRefund;
import com.easaa.scenicspot.assembly.TicketService;
import com.easaa.scenicspot.dao.OrderExceptionMapper;
import com.easaa.scenicspot.dao.TicketMapper;
import com.easaa.scenicspot.dao.TicketOrderMapper;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.TicketOrder;
import com.easaa.scenicspot.entity.ticket.Traveler;
import com.easaa.user.dao.UserMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 订票订单操作
 * 
 * @author liujunbo
 */
@Service
public class TicketOrderService extends EABaseService {

	@Autowired
	private TicketOrderMapper ticketOrderMapper;

	@Autowired
	private TicketMapper ticketMapper;

	@Autowired
	private OrderExceptionMapper orderExceptionMapper;

	@Autowired
	private UserMapper userMapper;

	@Autowired

	private SystemConfireService systemConfireService;

	@Override
	public EADao getDao() {
		return ticketOrderMapper;
	}

	public List<TicketOrder> selectEntityByPage(Page page) {
		return ticketOrderMapper.selectEntityByPage(page);
	}

	public List<TicketOrder> selectEntityByMap(Page page) {
		return ticketOrderMapper.selectEntityByMap(page);
	}

	/**
	 * 票务平台调用我们平台接口待续
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void orderRefund(PageData param) throws Exception {

		String out_order_no = param.getAsString("thirdOrderId");
		PageData orderInfo = ticketOrderMapper.selectByOrderNo(out_order_no);
		/**
		 * 查询票号订单
		 */
		PageData waitUpdate = new PageData();
		param.put("order_id", orderInfo.getAsString("id"));
		List<PageData> ticketCodes = ticketOrderMapper.selectTicketCodeByCondition(param);
		if (StringUtils.isNotEmpty(param.getAsString("ticketCode"))) {
			for (PageData tempPd : ticketCodes) {
				if (param.getAsString("ticketCode").equals(tempPd.getAsString("ticket_code"))) {
					waitUpdate = tempPd;
					break;
				}
			}
		} else {
			if (ticketCodes != null && ticketCodes.size() == 1) {
				waitUpdate = ticketCodes.get(0);
			}
		}
		int used_quantity = EAString.stringToInt(ticketCodes.get(0).getAsString("used_quantity"), 0)
				+ param.getAsInt("consumeQuantity");
		// 如果核销数量大于总数量
		if (used_quantity > EAString.stringToInt(ticketCodes.get(0).getAsString("quantity"), 0)) {
			used_quantity = EAString.stringToInt(ticketCodes.get(0).getAsString("quantity"), 0);
		}
		waitUpdate.put("used_quantity", used_quantity);
		ticketOrderMapper.updateTicketCode(waitUpdate);
		// 更新订单 部分使用 全部使用
		boolean partUse = false;
		for (PageData tempPd : ticketCodes) {
			if (EAString.stringToInt(tempPd.getAsString("used_quantity"), 0) != EAString
					.stringToInt(tempPd.getAsString("quantity"), 0)) {
				partUse = true;
			}
		}
		if (partUse) {
			orderInfo.put("to_status", "5");
		} else {
			orderInfo.put("to_status", "3");
		}
		ticketOrderMapper.update(orderInfo);
	}

	/**
	 * 下单接口 线上用户购票
	 * 
	 * 下单等待支付
	 * 
	 * @throws Exception
	 * 
	 */
	public PageData createOrder(JSONObject paramJson, HttpServletRequest request) throws Exception {
		Page page = new Page();
		PageData pd = new PageData();

		String thirdId = paramJson.getString("TicketTypeId");
		pd.put("third_no", thirdId);
		List<PageData> ticketList = ticketMapper.selectByMap(page);
		if (ticketList == null || ticketList.size() == 0) {
			throw new Exception("所请求的票务信息不存在");
		}
		/**
		 * 判断是否为匿名购买 如果匿名购买用联系人手机号 查询用户信息 如果存在 将这条订单 放在该用户下面
		 * 
		 * 如果查不出来创建用户信息
		 */
		if (paramJson.get("anonymous") != null && "1".equals(paramJson.getString("anonymous"))) {
			if (paramJson.get("ContactMobile") == null || StringUtils.isEmpty(paramJson.getString("ContactMobile"))) {
				throw new Exception("联系人手机号不能为空");
			}
			PageData userInfo = userMapper.selectByUserName(paramJson.getString("ContactMobile"));
			if (userInfo == null) {
				// 创建用户
				userInfo = new PageData();
				userInfo.put("phone", paramJson.getString("ContactMobile"));
				userInfo.put("user_name", paramJson.getString("ContactMobile"));
				userInfo.put("register_channel", 4);
				userInfo.put("register_time", EADate.getCurrentTime());
				userInfo.put("user_money", 0);
				userInfo.put("user_points", 0);
				userInfo.put("is_validated", 0);
				userInfo.put("is_buyer", 1);
				userInfo.put("is_loginer", 1);
				userInfo.put("user_type", 1);
				userMapper.insert(userInfo);
			}
			paramJson.put("user_id", userInfo.getAsString("user_id"));
			request.getSession().setAttribute("userInfo", userInfo);
		}
		PageData ticketPd = ticketList.get(0);
		pd.put("to_scenic_id", ticketPd.get("scenic_id"));
		pd.put("to_scenic_name", ticketPd.get("scenic_name"));
		pd.put("to_ticket_name", ticketPd.get("ticket_name"));
		pd.put("to_cate_name", ticketPd.get("cate_name"));
		pd.put("to_ticket_id", ticketPd.get("id"));
		pd.put("to_travel_date", paramJson.get("TravelDate"));
		pd.put("to_create_time", EADate.getCurrentTime());
		pd.put("to_quantity", paramJson.get("Quantity"));
		pd.put("to_settlement_price", paramJson.get("SettlementPrice"));
		pd.put("to_retail_price", paramJson.get("RetailPrice"));
		pd.put("ticket_third_no", paramJson.get("TicketTypeId"));
		pd.put("to_contact_name", paramJson.get("ContactName"));
		pd.put("to_contact_mobile", paramJson.get("ContactMobile"));
		pd.put("to_pay_method", paramJson.get("PaymentMethod"));
		BigDecimal settlementPrice = BigDecimal.valueOf(Double.parseDouble(pd.getAsString("to_settlement_price")));
		BigDecimal quantity = BigDecimal.valueOf(Double.parseDouble(pd.getAsString("to_quantity")));
		pd.put("to_order_money", settlementPrice.multiply(quantity));
		pd.put("to_status", 1);
		pd.put("to_pay_status", 2);
		pd.put("user_id", paramJson.get("user_id"));
		if (paramJson.getBoolean("isRealName")) {
			pd.put("to_is_realname", "1");
		} else {
			pd.put("to_is_realname", "0");
		}
		pd.put("ticket_order_no", EAString.getFourSn());
		pd.put("to_all_id", paramJson.get("to_all_id"));
		ticketOrderMapper.insert(pd);
		JSONArray jsonAry = paramJson.getJSONArray("Tourists");
		List<PageData> traveler = new ArrayList<PageData>();
		Set<String> idcards = new HashSet<String>();
		Set<String> phones = new HashSet<String>();
		if (jsonAry.size() > 0) {
			PageData tempPd = null;
			for (int i = 0; i < jsonAry.size(); i++) {
				tempPd = new PageData();
				idcards.add(jsonAry.getJSONObject(i).getString("IdCardNo"));
				phones.add(jsonAry.getJSONObject(i).getString("Mobile"));
				tempPd.put("to_id", pd.getAsString("o_id"));
				tempPd.put("to_name", jsonAry.getJSONObject(i).get("Name"));
				tempPd.put("to_phone", jsonAry.getJSONObject(i).get("Mobile"));
				tempPd.put("to_idcard", jsonAry.getJSONObject(i).get("IdCardNo"));
				traveler.add(tempPd);
			}
			ticketOrderMapper.insertTraver(traveler);
		}
		if (idcards.size() < traveler.size()) {
			throw new Exception("一张身份证只能订一张票");
		}
		if (phones.size() < traveler.size()) {
			throw new Exception("手机号重复");
		}
		return pd;
	}

	public List<PageData> orderList(PageExtend page) {
		return ticketOrderMapper.selectByPage(page);
	}

	/**
	 * 票务总订单支付回调逻辑
	 * @throws Exception 
	 * 
	 * 
	 */
	public boolean callBackAllOrder(PageData param) throws Exception {
		// 封装异常信息
		PageData exceptionPd = new PageData();
		exceptionPd.put("exception_type", 1);
		exceptionPd.put("exception_time", EADate.getCurrentTime());
		exceptionPd.put("deal_status", 0);
		PageData pd = new PageData();
		PageData totalOrder = ticketOrderMapper.selectByAllOrderNo(param.getAsString("out_trade_no"));
		/**
		 * 检测总订单状态 如果已支付 则返回true以免微信多次回调
		 * 
		 */
		if(totalOrder == null){
			throw new Exception("微信回调异常。未找到微信回调的订单号");
		}
		if("1".equals(totalOrder.getAsString("pay_status"))){
			return true;
		}
		Page page = new Page();
		pd.put("to_all_id", totalOrder.getAsString("id"));
		page.setPd(pd);
		List<TicketOrder> ticketOrders = ticketOrderMapper.selectEntityByMap(page);
		StringBuffer smsContent = new StringBuffer();
		if (ticketOrders != null && ticketOrders.size() > 0) {
			for (TicketOrder orderInfo : ticketOrders) {
				try {
					if ("1".equals(orderInfo.getStatus()) && "2".equals(orderInfo.getStatus())) {
						continue;
					}
					// 封装第三方票务数据发送请求
					JSONObject responseBody = new JSONObject();
					responseBody.put("ThirdOrderId", orderInfo.getOrderNo());
					responseBody.put("TicketTypeId", orderInfo.getThirdNo());
					responseBody.put("RetailPrice", orderInfo.getRetailPrice());
					responseBody.put("SettlementPrice", orderInfo.getSettlementPrice());
					responseBody.put("Quantity", orderInfo.getQuantity());
					responseBody.put("TravelDate", orderInfo.getTravelDate());
					responseBody.put("ContactName", orderInfo.getContactName());
					responseBody.put("ContactMobile", orderInfo.getContactMobile());
					responseBody.put("PaymentMethod", "1");
					List<Traveler> travelers = orderInfo.getTraveler();
					if (travelers != null && travelers.size() > 0) {
						JSONArray array = new JSONArray();
						for (int i = 0; i < travelers.size(); i++) {
							JSONObject tempObj = new JSONObject();
							tempObj.put("Name", travelers.get(i).getName());
							tempObj.put("Mobile", travelers.get(i).getPhone());
							tempObj.put("IdCardNo", travelers.get(i).getIdCard());
							array.add(tempObj);
						}
						responseBody.put("Tourists", array.toString());
					}
					// 发送请求{"Success":true,"Message":"成功","ResponseBody":{"ListNo":"DS17091400000001","ThirdOrderId":"1505392981896uX4rPW-F","QRCodeAddress":"http://fx.szegoal.com/Mpa/Orders/Barcode/7223aaad-3dda-420e-839b-91173671df89","TicketCodes":
					// [{"TicketCode":"DS0000023803452","TotalQuantity":1,"UsedQuantity":0,"RefundQuantity":0}]}}
					String thirdStr = TicketService.createOrder(responseBody);
					JSONObject responseJson = JSONObject.fromObject(thirdStr);
					responseJson = responseJson.getJSONObject("ResponseBody");
					String ListNo = responseJson.getString("ListNo");
					String QRCodeAddress = responseJson.getString("QRCodeAddress");
					JSONArray ticketCodes = responseJson.getJSONArray("TicketCodes");
					for (int i = 0; i < ticketCodes.size(); i++) {
						PageData ticketCodePd = new PageData();
						ticketCodePd.put("order_id", orderInfo.getId());
						ticketCodePd.put("ticket_code", ticketCodes.getJSONObject(i).get("TicketCode"));
						ticketCodePd.put("quantity", ticketCodes.getJSONObject(i).get("TotalQuantity"));
						ticketCodePd.put("used_quantity", ticketCodes.getJSONObject(i).get("UsedQuantity"));
						ticketCodePd.put("refund_quantity", ticketCodes.getJSONObject(i).get("RefundQuantity"));
						ticketCodePd.put("id_cardno", ticketCodes.getJSONObject(i).get("IdCardNo"));
						smsContent.append(ticketCodes.getJSONObject(i).get("TicketCode") + ",");
						ticketOrderMapper.insertTicketCode(ticketCodePd);
					}
					// 更新订单状态
					pd.put("to_pay_status", "1");
					/*
					 * pd.put("to_pay_type",
					 * "1".equals(param.getAsString("payType"))?"支付宝":"微信");
					 */
					pd.put("to_pay_type", param.getAsString("payType"));
					pd.put("to_status", "2");
					pd.put("ticket_third_order_no", ListNo);
					pd.put("to_qrcode", QRCodeAddress);
					pd.put("id", orderInfo.getId());
					ticketOrderMapper.update(pd);
					/**
					 * 发送短信
					 */
					String conName = orderInfo.getContactName();
					String phone = orderInfo.getContactMobile();
					String tmpContent = systemConfireService.getSmsTplByCode("002").getAsString("tpl_content");
					try {
						tmpContent = tmpContent.replaceAll("{{1}}", conName);
						tmpContent = tmpContent.replaceAll("{{2}}", orderInfo.getCreateTime());
						tmpContent = tmpContent.replaceAll("{{3}}",
								orderInfo.getQuantity() + "张" + orderInfo.getTicketName());
						String ticketContent = "（出行日期：" + orderInfo.getTravelDate() + "，票号："
								+ smsContent.substring(0, smsContent.length() - 1) + "）";
						tmpContent = tmpContent.replaceAll("{{4}}", ticketContent);
						EASMS.sendSms2(phone, tmpContent);
					} catch (Exception e) {
						System.err.println("短信发送异常," + "异常信息");
						exceptionPd.put("order_no", orderInfo.getOrderNo());
						exceptionPd.put("exception_msg", "短信发送异常" + "异常信息：" + e.getMessage());
						exceptionPd.put("exception_time", EADate.getCurrentTime());
						orderExceptionMapper.insert(exceptionPd);
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
					if (!"系统无法查询支付回调的票务订单号".equals(e.getMessage())) {
						// 如果订单号可以查询到订单
						exceptionPd.put("pay_money", orderInfo.getSettlementPrice());
						exceptionPd.put("order_no", orderInfo.getOrderNo());
					}
					exceptionPd.put("exception_msg", e.getMessage());
					exceptionPd.put("exception_time", EADate.getCurrentTime());
					orderExceptionMapper.insert(exceptionPd);
					return false;
				}
			}
		}
		
		/**
		 * 更新总订单状态
		 */
		totalOrder.put("pay_status", "1");
		ticketOrderMapper.updateAllOrder(totalOrder);
		return true;
	}

	/**
	 * 1505390996564s2QWPW-F 票务支付回调逻辑
	 * 
	 * @param param
	 */
	public boolean callBack(PageData param) {
		// 封装异常信息
		PageData exceptionPd = new PageData();
		exceptionPd.put("exception_type", 1);
		exceptionPd.put("exception_time", EADate.getCurrentTime());
		exceptionPd.put("deal_status", 0);
		PageData pd = new PageData();
		Page page = new Page();
		TicketOrder orderInfo = null;
		String orderNo = param.getAsString("out_trade_no");
		pd.put("ticket_order_no", orderNo);
		page.setPd(pd);
		List<TicketOrder> ticketOrders = ticketOrderMapper.selectEntityByMap(page);
		StringBuffer smsContent = new StringBuffer();
		try {
			// 查询票务订单
			if (ticketOrders == null || ticketOrders.size() == 0) {
				throw new Exception("系统无法查询支付回调的票务订单号");
			}
			orderInfo = ticketOrders.get(0);
			if ("1".equals(orderInfo.getStatus()) && "2".equals(orderInfo.getStatus())) {
				return true;
			}
			// 封装第三方票务数据发送请求
			JSONObject responseBody = new JSONObject();
			responseBody.put("ThirdOrderId", orderInfo.getOrderNo());
			responseBody.put("TicketTypeId", orderInfo.getThirdNo());
			responseBody.put("RetailPrice", orderInfo.getRetailPrice());
			responseBody.put("SettlementPrice", orderInfo.getSettlementPrice());
			responseBody.put("Quantity", orderInfo.getQuantity());
			responseBody.put("TravelDate", orderInfo.getTravelDate());
			responseBody.put("ContactName", orderInfo.getContactName());
			responseBody.put("ContactMobile", orderInfo.getContactMobile());
			responseBody.put("PaymentMethod", "1");
			List<Traveler> travelers = orderInfo.getTraveler();
			if (travelers != null && travelers.size() > 0) {
				JSONArray array = new JSONArray();
				for (int i = 0; i < travelers.size(); i++) {
					JSONObject tempObj = new JSONObject();
					tempObj.put("Name", travelers.get(i).getName());
					tempObj.put("Mobile", travelers.get(i).getPhone());
					tempObj.put("IdCardNo", travelers.get(i).getIdCard());
					array.add(tempObj);
				}
				responseBody.put("Tourists", array.toString());
			}
			// 发送请求{"Success":true,"Message":"成功","ResponseBody":{"ListNo":"DS17091400000001","ThirdOrderId":"1505392981896uX4rPW-F","QRCodeAddress":"http://fx.szegoal.com/Mpa/Orders/Barcode/7223aaad-3dda-420e-839b-91173671df89","TicketCodes":
			// [{"TicketCode":"DS0000023803452","TotalQuantity":1,"UsedQuantity":0,"RefundQuantity":0}]}}
			String thirdStr = TicketService.createOrder(responseBody);
			JSONObject responseJson = JSONObject.fromObject(thirdStr);
			responseJson = responseJson.getJSONObject("ResponseBody");
			String ListNo = responseJson.getString("ListNo");
			String QRCodeAddress = responseJson.getString("QRCodeAddress");
			JSONArray ticketCodes = responseJson.getJSONArray("TicketCodes");
			for (int i = 0; i < ticketCodes.size(); i++) {
				PageData ticketCodePd = new PageData();
				ticketCodePd.put("order_id", orderInfo.getId());
				ticketCodePd.put("ticket_code", ticketCodes.getJSONObject(i).get("TicketCode"));
				ticketCodePd.put("quantity", ticketCodes.getJSONObject(i).get("TotalQuantity"));
				ticketCodePd.put("used_quantity", ticketCodes.getJSONObject(i).get("UsedQuantity"));
				ticketCodePd.put("refund_quantity", ticketCodes.getJSONObject(i).get("RefundQuantity"));
				ticketCodePd.put("id_cardno", ticketCodes.getJSONObject(i).get("IdCardNo"));
				smsContent.append(ticketCodes.getJSONObject(i).get("TicketCode") + ",");
				ticketOrderMapper.insertTicketCode(ticketCodePd);
			}
			// 更新订单状态
			pd.put("to_pay_status", "1");
			/*
			 * pd.put("to_pay_type",
			 * "1".equals(param.getAsString("payType"))?"支付宝":"微信");
			 */
			pd.put("to_pay_type", param.getAsString("payType"));
			pd.put("to_status", "2");
			pd.put("ticket_third_order_no", ListNo);
			pd.put("to_qrcode", QRCodeAddress);
			pd.put("id", orderInfo.getId());
			ticketOrderMapper.update(pd);
			/**
			 * 发送短信
			 */
			String conName = orderInfo.getContactName();
			String phone = orderInfo.getContactMobile();
			String tmpContent = systemConfireService.getSmsTplByCode("002").getAsString("tpl_content");
			try {
				tmpContent = tmpContent.replaceAll("参数1", conName);
				tmpContent = tmpContent.replaceAll("参数2", orderInfo.getCreateTime());
				tmpContent = tmpContent.replaceAll("参数3", orderInfo.getQuantity() + "张" + orderInfo.getTicketName());
				String ticketContent = "（出行日期：" + orderInfo.getTravelDate() + "，票号："
						+ smsContent.substring(0, smsContent.length() - 1) + "）";
				tmpContent = tmpContent.replaceAll("参数4", ticketContent);
				EASMS.sendSms2(phone, tmpContent);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// SmsUtil.sendSms1(mobile, code);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if (!"系统无法查询支付回调的票务订单号".equals(e.getMessage())) {
				// 如果订单号可以查询到订单
				exceptionPd.put("pay_money", orderInfo.getSettlementPrice());
				exceptionPd.put("order_no", orderInfo.getOrderNo());
			}
			exceptionPd.put("exception_msg", e.getMessage());
			exceptionPd.put("exception_time", EADate.getCurrentTime());
			orderExceptionMapper.insert(exceptionPd);
		}
		return false;
	}
	/**
	 * 
	 * 根据订单号查询订单
	 * 
	 */
	public PageData selectByOrderNo(String orderNo) {
		return ticketOrderMapper.selectByOrderNo(orderNo);
	}

	/**
	 * 根据id查询退票订单
	 * 
	 * 
	 */

	public PageData selectRefundById(Integer id) {
		return ticketOrderMapper.selectRefundById(id);
	}

	public PageData getAllOrderById(String id) {
		return ticketOrderMapper.selectAllOrderById(id);
	}

	/**
	 * 创建总订单
	 */
	public void insertAllOrder(PageData pd) {
		ticketOrderMapper.insertAllOrder(pd);
	}

	/**
	 * 分页查询退票单
	 * 
	 * 
	 * @param pd
	 */
	public List<PageData> selectRefundByPage(Page page) {
		return ticketOrderMapper.selectRefundByPage(page);
	}

	public void updateRefund(PageData pd) {
		ticketOrderMapper.updateRefund(pd);
	}

	public List<PageData> selectTicketCodeInfo(PageData pd) {
		return ticketOrderMapper.selectTicketCodeInfo(pd);
	}

	/**
	 * 生成退票订单
	 * 
	 * @throws Exception
	 * 
	 */
	public void createRefund(PageData pd) throws Exception {

		if (pd.getAsInt("refund_quantity") > pd.getAsInt("to_quantity")) {
			throw new Exception("退票数量超出了购买数量");
		}
		PageData ticketInfo = ticketMapper.selectById(EAString.stringToInt(pd.getAsString("to_ticket_id"), 0));
		if (ticketInfo == null) {
			throw new Exception("票类信息不存在");
		}
		if (StringUtils.isNotEmpty(ticketInfo.getAsString("ticket_isrefund"))
				&& "0".equals(ticketInfo.getAsString("ticket_isrefund"))) {
			throw new Exception("该票无法退票");
		}
		if ("3".equals(pd.getAsString("to_status"))) {
			throw new Exception("该票已经使用无法退票");
		}
		if ("1".equals(pd.getAsString("to_is_realname"))) {
			if (pd.get("ticketCodes") == null || StringUtils.isEmpty(pd.getAsString("ticketCodes"))) {
				throw new Exception("请选择需要退的门票");
			}
		}
		BigDecimal settlementPrice = BigDecimal.valueOf(pd.getAsDouble("to_settlement_price"));
		BigDecimal refundMoney = settlementPrice.multiply(BigDecimal.valueOf(pd.getAsInt("refund_quantity")));
		// 生成退票订单
		PageData refundPd = new PageData();
		refundPd.put("order_no", pd.getAsString("ticket_order_no"));
		refundPd.put("order_id", pd.getAsString("id"));
		refundPd.put("order_money", pd.getAsString("to_order_money"));
		refundPd.put("refund_no", EAString.getFourSn());
		refundPd.put("refund_phone", pd.getAsString("to_contact_mobile"));
		refundPd.put("refund_money", refundMoney);
		refundPd.put("refund_time", EADate.getCurrentTime());
		refundPd.put("refund_status", "2");
		refundPd.put("refund_num", pd.getAsInt("refund_quantity"));
		refundPd.put("refund_type", (pd.getAsString("to_pay_type").indexOf("微信") != -1) ? 2 : 1);
		refundPd.put("refund_reson", pd.getAsString("refund_reson"));
		ticketOrderMapper.insertRefund(refundPd);
		/**
		 * 如果是实名制退票
		 * 
		 */
		JSONArray ticketCodes = new JSONArray();
		if (pd.get("to_is_realname") != null && "1".equals(pd.get("to_is_realname"))) {
			JSONArray jsonArray = JSONArray.fromObject(pd.getAsString("ticketCodes"));
			for (int i = 0; i < jsonArray.size(); i++) {
				PageData refundTicketCode = new PageData();
				refundTicketCode.put("order_id", pd.getAsString("id"));
				refundTicketCode.put("refund_id", refundPd.getAsString("refund_id"));
				refundTicketCode.put("ticket_code", jsonArray.get(i));
				refundTicketCode.put("ticket_quantity", 1);
				ticketCodes.add(jsonArray.get(i));
				ticketOrderMapper.insertRefundTicketCode(refundTicketCode);
				/**
				 * 更改票号的状态 申请中的数量为1
				 */
				/**
				 * 查询票号 验证是否可以退票
				 */
				PageData checkTicketCode = ticketOrderMapper.selectTicketCodeByCondition(refundTicketCode).get(0);
				if ("1".equals(checkTicketCode.getAsString("used_quantity"))) {
					throw new Exception("票号为" + checkTicketCode.getAsString("ticket_code") + ",已经使用无法退票");
				}
				if ("1".equals(checkTicketCode.getAsString("refund_quantity"))) {
					throw new Exception("票号为" + checkTicketCode.getAsString("ticket_code") + "，已经退票，无法再次退票");
				}
				if ("1".equals(checkTicketCode.getAsString("apply_refund_quantity"))) {
					throw new Exception("票号为" + checkTicketCode.getAsString("ticket_code") + "，正在申请中，无法再次申请");
				}
				refundTicketCode.remove("ticket_quantity");
				refundTicketCode.remove("refund_id");
				refundTicketCode.put("apply_refund_quantity", 1);
				ticketOrderMapper.updateTicketCode(refundTicketCode);
			}
		} else {
			// 非实名认证
			PageData refundTicketCode = new PageData();
			refundTicketCode.put("order_id", pd.getAsString("id"));
			PageData checkTicketCode = ticketOrderMapper.selectTicketCodeByCondition(refundTicketCode).get(0);
			int aviation = EAString.stringToInt(checkTicketCode.getAsString("quantity"), 0)
					- (EAString.stringToInt(checkTicketCode.getAsString("used_quantity"), 0)
							+ EAString.stringToInt(checkTicketCode.getAsString("refund_quantity"), 0)
							+ EAString.stringToInt(checkTicketCode.getAsString("apply_refund_quantity"), 0));
			if (aviation < pd.getAsInt("refund_quantity")) {
				throw new Exception("所在环境存在安全异常，请退出重新进入");
			}
			refundTicketCode.put("apply_refund_quantity", pd.getAsInt("refund_quantity"));
			ticketOrderMapper.updateTicketCode(refundTicketCode);
			/**
			 * 插入退款票号
			 */
			refundTicketCode.put("order_id", pd.getAsString("id"));
			refundTicketCode.put("refund_id", refundPd.getAsString("refund_id"));
			refundTicketCode.put("ticket_code", checkTicketCode.getAsString("ticket_code"));
			refundTicketCode.put("ticket_quantity", pd.getAsInt("refund_quantity"));
			ticketOrderMapper.insertRefundTicketCode(refundTicketCode);
		}
		/**
		 * 更改订单退票状态 为申请退票
		 * 
		 */
		pd.put("to_refund_status", 4);
		ticketOrderMapper.update(pd);
		// 请求第三方退票接口
		PageData thirdRefund = new PageData();
		thirdRefund.put("listNo", pd.getAsString("ticket_third_order_no"));
		thirdRefund.put("refundId", refundPd.getAsString("refund_no"));
		thirdRefund.put("refundQuantity", refundPd.getAsString("refund_num"));
		thirdRefund.put("refundReason", refundPd.getAsString("refund_reson"));
		thirdRefund.put("ticketCodes", ticketCodes.toString());
		String responseResult = TicketService.refund(thirdRefund);
		JSONObject jsonObj = JSONObject.fromObject(responseResult);
		try {
			jsonObj = jsonObj.getJSONObject("ResponseBody");
		} catch (Exception e) {
			throw new Exception(jsonObj.getString("Message"));
		}
		String refundStatus = jsonObj.getString("RefundStatus");
		if (!"1".equals(refundStatus)) {
			// 抛异常让上面更改的东西全部回滚
			throw new Exception("申请退票失败，请稍后重试");
		}
	}

	/**
	 * 
	 * 退款成功逻辑
	 * 
	 * @throws Exception
	 */
	public void doRefundSuc(PageData param) throws Exception {
		String out_order_no = param.getAsString("thirdOrderId");
		PageData orderInfo = ticketOrderMapper.selectByOrderNo(out_order_no);
		PageData refundInfo = ticketOrderMapper.selectRefundByOrderNo(param.getAsString("refundId"));
		String phone = orderInfo.getAsString("to_contact_mobile");
		if ("2".equals(param.getAsString("refundStatus"))) {
			if (EAString.stringToInt(refundInfo.getAsString("refund_status"), 0) != 2) {
				return;
			}
			// 退款成功
			/*
			 * PageData callRefund = new PageData();
			 * callRefund.put("out_order_no", out_order_no);
			 * callRefund.put("out_refund_no", param.getAsString("RefundId"));
			 */
			PageData ticketCodeParam = new PageData();
			ticketCodeParam.put("order_id", orderInfo.getAsString("id"));
			List<PageData> ticketCodes = ticketOrderMapper.selectTicketCodeByCondition(ticketCodeParam);
			if (StringUtils.isNotEmpty(orderInfo.getAsString("to_is_realname"))
					&& "1".equals(orderInfo.getAsString("to_is_realname"))) {
				// 如果是实名认证购买 退款也需实名认证
				List<PageData> refundTicketCodes = ticketOrderMapper
						.selectRefundTicketCode(refundInfo.getAsString("id"));
				for (int i = 0; i < refundTicketCodes.size(); i++) {
					PageData editTicketCode = new PageData();
					editTicketCode.put("ticket_code", refundTicketCodes.get(i).getAsString("ticket_code"));
					editTicketCode.put("order_id", orderInfo.getAsString("id"));
					editTicketCode.put("refund_quantity", 1);
					editTicketCode.put("apply_refund_quantity", 0 + "");
					ticketOrderMapper.updateTicketCode(editTicketCode);
				}
			} else {
				PageData ticketCodesParam = new PageData();
				ticketCodesParam.put("order_id", orderInfo.getAsString("id"));
				PageData waitUpdateTicketCode = ticketCodes.get(0);
				// 非实名认证购买
				Integer refundNum = refundInfo.getAsInt("refund_num");
				if (waitUpdateTicketCode.getAsInt("apply_refund_quantity") <= 0) {
					return;
				}
				if (waitUpdateTicketCode.getAsInt("apply_refund_quantity") - refundNum < 0) {
					waitUpdateTicketCode.put("apply_refund_quantity", 0 + "");
				} else {
					waitUpdateTicketCode.put("apply_refund_quantity",
							(waitUpdateTicketCode.getAsInt("apply_refund_quantity") - refundNum) + "");
				}
				waitUpdateTicketCode.put("refund_quantity",
						refundNum + waitUpdateTicketCode.getAsInt("refund_quantity"));
				if (waitUpdateTicketCode.getAsInt("refund_quantity") > waitUpdateTicketCode.getAsInt("quantity")) {
					waitUpdateTicketCode.put("refund_quantity", waitUpdateTicketCode.getAsInt("quantity"));
				}
				ticketOrderMapper.updateTicketCode(waitUpdateTicketCode);
			}
			boolean isAllRefund = true;
			/**
			 * 更改订单状态 全部退款 部分退款
			 */
			for (PageData tempCode : ticketCodes) {
				if (EAString.stringToInt(tempCode.getAsString("refund_quantity"), 0) != EAString
						.stringToInt(tempCode.getAsString("quantity"), 0)) {
					isAllRefund = false;
				}
			}
			ticketCodeParam.put("id", orderInfo.getAsString("id"));
			if (isAllRefund) {
				ticketCodeParam.put("to_refund_status", 3);
			} else {
				ticketCodeParam.put("to_refund_status", 2);
			}
			ticketOrderMapper.update(ticketCodeParam);
			/**
			 * 更新退款单状态
			 */
			refundInfo.put("refund_status", 1);
			ticketOrderMapper.updateRefund(refundInfo);

			if ("2".equals(refundInfo.getAsString("refund_type"))) {
				// 调用微信退款接口
				PageData refundResult = PayRefund.wxRefund(refundInfo.getAsString("order_money"), "0.01",
						orderInfo.getAsString("ticket_order_no"), refundInfo.getAsString("refund_no"));
				if (!"SUCCESS".equals(refundResult.getAsString("refund_result"))) {
					// 微信退款失败
					throw new Exception("微信退款失败");
				}
			} else if ("1".equals(refundInfo.getAsString("refund_type"))) {
				// 支付宝退款接口
			}
			// 发送短信
			try {
				// 不能因为短信发送异常造成退款失败
				String tmpContent = systemConfireService.getSmsTplByCode("003").getAsString("tpl_content");
				tmpContent = tmpContent.replaceAll("参数1", phone);
				tmpContent = tmpContent.replaceAll("参数2", refundInfo.getAsString("refund_time"));
				EASMS.sendSms2(phone, tmpContent);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("3".equals(param.getAsString("refundStatus"))) {
			/**
			 * 更改票务订单 申请中的数量
			 */
			List<PageData> refundTicketCodes = ticketOrderMapper
					.selectRefundTicketCode(refundInfo.getAsString("refund_no"));
			for (PageData tempTc : refundTicketCodes) {
				tempTc.put("order_id", orderInfo.getAsString("id"));
				List<PageData> tempTicketCodes = ticketOrderMapper.selectTicketCodeByCondition(tempTc);
				if (tempTicketCodes != null && tempTicketCodes.size() != 0) {
					int quantity = EAString.stringToInt(tempTicketCodes.get(0).getAsString("apply_refund_quantity"), 0)
							- EAString.stringToInt(tempTc.getAsString("ticket_quantity"), 0);
					quantity = quantity < 0 ? 0 : quantity;
					tempTicketCodes.get(0).put("apply_refund_quantity", quantity + "");
					ticketOrderMapper.updateTicketCode(tempTicketCodes.get(0));
				}
			}
			/**
			 * 更改退票单
			 */
			refundInfo.put("refund_status", "3");
			ticketOrderMapper.updateRefund(refundInfo);
			// 退款失败 无需更改订单状态 发短信通知用户退款失败
			String errorMsg = param.getAsString("auditMemo");
			if (StringUtils.isNotEmpty(phone)) {
				String tmpContent = systemConfireService.getSmsTplByCode("001").getAsString("tpl_content");
				if (StringUtils.isNotEmpty(tmpContent)) {
					// 尊敬的{{1}}，您于{{2}}日提交的退票申请已被驳回（驳回理由：{{3}}）。详情请咨询人工客户，退票单号{{4}}。
					tmpContent = tmpContent.replaceAll("参数1", phone);
					tmpContent = tmpContent.replaceAll("参数2", refundInfo.getAsString("refund_time"));
					tmpContent = tmpContent.replaceAll("参数3", StringUtils.isNotEmpty(errorMsg) ? errorMsg : "无驳回理由");
					tmpContent = tmpContent.replaceAll("参数4", refundInfo.getAsString("refund_no"));
					EASMS.sendSms2(phone, tmpContent);
				}
			}
		}
	}
}
