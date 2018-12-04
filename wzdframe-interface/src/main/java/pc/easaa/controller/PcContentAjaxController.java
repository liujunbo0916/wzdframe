package pc.easaa.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.easaa.content.service.AdvertService;
import com.easaa.content.service.ContentService;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EAString;
import com.easaa.core.util.VerifyCodeUtils;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.order.service.OrderService;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.upm.upm.contants.Const;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

@RequestMapping("/logic/")
@Controller
public class PcContentAjaxController extends BaseController {

	@Autowired
	private ScenicService scenicService;

	@Autowired
	private TicketOrderService ticketOrderService;

	@Autowired
	private ContentService contentService;

	@Autowired
	private OrderService orderService;

	/**
	 * 广告
	 */
	@Autowired
	private AdvertService advertService;

	@Autowired
	private GroupTourService groupTourService;

	/**
	 * 门票订单操作集合 id:订单id opt:操作类型 cancle取消订单(删除订单) reback 退票 orderNo:订单号 quantity
	 * ：退款数量 ticketCodes：退票票号列表
	 */
	@RequestMapping("/ticket/order/opt")
	public void ticketOrderOpt(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")), "utf-8"));
			PageData orderPd = ticketOrderService.getById(EAString.stringToInt(paramObj.getString("id"), 0));
			if (orderPd == null) {
				super.outJson(REQUEST_FAILS, "操作失败", null, response);
				return;
			}
			orderPd.put("opt", paramObj.getString("opt"));
			orderPd.put("refund_reson", paramObj.get("refund_reson"));
			orderPd.put("ticketCodes", paramObj.get("ticketCodes"));
			orderPd.put("refund_quantity", paramObj.get("refund_quantity"));
			if ("reback".equals(paramObj.getString("opt"))) {
				ticketOrderService.createRefund(orderPd);
			} else if ("cancle".equals(paramObj.getString("opt"))) {
				orderPd.put("to_status", 4);
				ticketOrderService.edit(orderPd);
			}
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	@RequestMapping("/content/hot")
	public void contentHot(HttpServletResponse response, @RequestParam(defaultValue = "6") Integer limit) {
		try {
			PageData pd = this.getPageData();
			pd.put("limit", limit);
			super.outJson(REQUEST_SUCCESS, "操作成功", contentService.getByMap(pd), response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "操作失败", null, response);
		}
	}

	/**
	 * 申请退款
	 */
	@RequestMapping("/apply/refund/money")
	public void applyRefundMoney(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			String orderId = pd.getAsString("orderNo");
			String applyReason = pd.getAsString("apply_reson");
			PageData orderPd = orderService.getById(EAString.stringToInt(orderId, 0));
			if (orderPd == null) {
				super.outJson(REQUEST_FAILS, "订单查询失败", null, response);
				return;
			}
			orderPd.put("apply_reason", applyReason);
			orderPd.put("is_refund_money", 1);
			orderPd.put("refund_result", 3);
			orderService.edit(orderPd);
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, "操作失败", null, response);
		}
	}

	/**
	 * 
	 * 旅游订单操作集合
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/travel/order/opt")
	public void travelOrderOpt(HttpServletResponse response, HttpServletRequest request)
			throws UnsupportedEncodingException {
		PageData pd = this.getPageData();
		try {
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")), "utf-8"));
			/**
			 * 查询旅游订单
			 */
			pd.put("order_id", EAString.stringToInt(paramObj.getString("order_id"), 0));
			// PageData travelOrder =
			// groupTourService.selectOrderById(EAString.stringToInt(paramObj.getString("order_id"),
			// 0));
			GroupTourOrder groupOrder = groupTourService.selectOrderEntity(pd);
			if (groupOrder == null) {
				throw new Exception("订单不存在");
			}
			// 操作类型
			String optType = paramObj.getString("optType");
			if ("reback".equalsIgnoreCase(optType)) {
				// 退款逻辑
				if("1".equals(groupOrder.getOrderState()) && "1".equals(groupOrder.getPayStatus())){
					groupTourService.doApplyRefund(groupOrder, paramObj);
				}else{
					super.outJson(REQUEST_SUCCESS, "申请失败，订单状态有误！", null, response);
					return;
				}
			}else if ("delete".equalsIgnoreCase(optType)) {
				// 订单状态 0待支付 1 待使用 2 已使用 3已取消 4退款中（所有游客都是退款中订单状态才是退款中）5已退款
				// 6订单已关闭 7 订单已删除
				// 删除订单逻辑
				if ("2".equals(groupOrder.getOrderState())||"3".equals(groupOrder.getOrderState())
						|| "5".equals(groupOrder.getOrderState()) || "6".equals(groupOrder.getOrderState())
						|| ("0".equals(groupOrder.getOrderState()) && "0".equals(groupOrder.getPayStatus()))) {
					PageData tourData= new PageData();
					tourData.put("order_id", groupOrder.getOrderId());
					groupTourService.deleteOrder(tourData);
				}else{
					super.outJson(REQUEST_SUCCESS, "删除失败，订单状态有误！", null, response);
					return;
				}
			}
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, e.getMessage(), "", response);
		}
	}

	/**
	 * 生成二维码输出流
	 * 
	 * @throws IOException
	 */
	@RequestMapping("ercode")
	public void ercode(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");
		// 生成随机字串
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
		// 存入会话session
		HttpSession session = request.getSession(true);
		// 删除以前的
		session.removeAttribute(Const.SESSION_ERCODE);
		session.setAttribute(Const.SESSION_ERCODE, verifyCode.toLowerCase());
		// 生成图片
		int w = 100, h = 50;
		VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
	}

	/**
	 * 检测二维码是否正确
	 */
	@RequestMapping("checkCode")
	public void checkCode(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			HttpSession session = request.getSession(true);
			String checkCode = (String) session.getAttribute(Const.SESSION_ERCODE);
			if (checkCode.equalsIgnoreCase(pd.getAsString("checkCode"))) {
				super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
				return;
			}
			super.outJson(REQUEST_FAILS, "验证码不正确", null, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, "验证码不正确", null, response);
		}
	}

}
