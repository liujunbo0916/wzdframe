package wx.easaa.controller.duyun;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.business.service.BusinessService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Express;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.entity.TrackMsgEntity;
import com.easaa.goods.entity.Stock;
import com.easaa.goods.service.GoodsCartService;
import com.easaa.goods.service.GoodsCommentService;
import com.easaa.goods.service.GoodsService;
import com.easaa.order.service.OrderService;
import com.easaa.order.service.OrdersGoodsService;
import com.easaa.order.service.OrdersRefundService;
import com.easaa.order.service.OrdersShippingService;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.TicketOrder;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.user.service.UserAddressService;
import com.easaa.user.service.UserService;
import wx.easaa.controller.comm.BaseController;

/**
 * 微信订单
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/wx/order/")
public class WxOrderController extends BaseController {
	@Autowired
	private OrderService orderService;

	@Autowired
	private UserService userService;

	@Autowired
	private UserAddressService userAddressService;

	@Autowired
	private OrdersShippingService ordersshippingService;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private GoodsCartService goodsCartService;

	@Autowired
	private TicketOrderService ticketOrderService;

	@Autowired
	private GroupTourService groupTourService;

	@Autowired
	private GoodsCommentService goodsCommentService;

	@Autowired
	private OrdersGoodsService ordersGoodsService;

	@Autowired
	private OrdersRefundService ordersRefundService;

	private static PageData getPageData = new PageData();
	@Autowired
	private BusinessService businessService;
	/**
	 * 订单支付界面 user_id 用户ID orders_id 订单ID
	 */
	@RequestMapping(value = "/orderPayPage")
	public ModelAndView orderPayPage(HttpServletResponse response, String orders_id) {
		ModelAndView mv = this.getModelAndView();
		mv.addObject("orders_id", orders_id);
		mv.setViewName("wechat/payOrder");
		return mv;
	}

	/**
	 * 我的订单页面 /wx/order/myOrder?order_status=0
	 */
	@RequestMapping("myOrder")
	public ModelAndView myOrder(String order_status, HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.setViewName("/duyun/goodsOrder");
		return mv;
	}

	// ajax分页请求列表数据
	@RequestMapping("doOrderList")
	public void doList(HttpServletResponse response, HttpServletRequest request) {
		PageExtend page = new PageExtend();
		PageData pd = this.getPageData();
		try {
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("is_delete", "0");
			pd.put("order_status", pd.getAsString("order_status"));
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(9);
			page.setPd(pd);
			List<PageData> listHistory = orderService.selectHistory(page);
			page.setResultPd(listHistory);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 查询用户订单 user_id 用户ID currentPage 当前页数 order_status 订单状态 ，0待付款，3待发货，4,待收货
	 * 6待评价
	 * 
	 * 0为待付款，1为待确认，2为配货中， 3为待发货，4为已发货，5为已送达 6为交易成功,7已取消，8订单完成 9订单关闭
	 */
	@RequestMapping(value = "/orderlists")
	public void orderlists(HttpServletResponse response, HttpServletRequest request, String currentPage,
			String order_status) {
		try {
			// 将user_id写死
			if (EAUtil.isEmpty(currentPage)) {
				this.outJson(PARAM_ERROR, "当前页面没穿不给过", null, response);
				return;
			}
			PageData newdata = new PageData();
			Page pd = new Page();
			newdata.put("user_id", getUserIdFromSession(request));
			if (!EAUtil.isEmpty(order_status)) {
				newdata.put("order_status", order_status);
			}
			newdata.put("is_delete", "0");
			pd.setApp(true);
			pd.setCurrentPage(Integer.parseInt(currentPage));
			pd.setShowCount(15);
			pd.setPd(newdata);
			List<PageData> listHistory = orderService.selectHistory(pd);
			this.outJson(REQUEST_SUCCESS, "请求成功", listHistory, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 订单详情
	 * 
	 * @param user_id
	 *            用户id 必传
	 * @param order_id
	 *            订单id
	 * @param order_sn
	 *            订单号 订单号和订单id 可同时传，也可单传
	 */
	@RequestMapping(value = "/orderDetail")
	public ModelAndView orderDetail(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData newData = this.getPageData();
		newData.put("user_id", getUserIdFromSession(request));
		mv.setViewName("/duyun/goodsorder-information");
		mv.addObject("data", orderService.selectDetails(newData));
		mv.addObject("pd", newData);
		return mv;
	}

	/**
	 * 订单详情(积分，余额跳转使用)
	 * 
	 * @param order_sn
	 *            订单号
	 */
	@RequestMapping(value = "/orderDetails")
	public ModelAndView orderDetails(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData newData = this.getPageData();
		mv.setViewName("/wechat/wode/wode-jfyeinformation");
		mv.addObject("data", orderService.selectDetails(newData));
		mv.addObject("pd", newData);
		return mv;
	}

	/**
	 * 查看物流详情
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/orderlogistics")
	public ModelAndView orderlogistics() {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			TrackMsgEntity track = ordersshippingService.queryExpressStatus(pd);
			if (EAUtil.isNotEmpty(track)) {
				Express[] expressary = Express.values();
				for (int i = 0; i < expressary.length; i++) {
					if (expressary[i].getCode().equalsIgnoreCase(track.getShipperCode())) {
						track.setShipperName(expressary[i].getDesc());
					}
				}
			}
			mv.addObject("data", track);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("物流信息：    " + e.getMessage());
			mv.addObject("data", "");
		}
		mv.setViewName("/wechat/wode/wode-wuliu");
		return mv;
	}

	/**
	 * 申请退款
	 */
	@RequestMapping("doApplyRefund")
	public ModelAndView applyRefund() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = new PageData();
		String goodsId = pd.getAsString("goods_id");
		data.put("order_id", pd.getAsString("order_id"));
		List<PageData> goodlist = orderService.selectOrderGoods(data);
		for (PageData pageData : goodlist) {
			if (goodsId.equals(pageData.getAsString("goods_id"))) {
				mv.addObject("goods", pageData);
			}
		}
		if (!"0".equals(pd.getAsString("rebacktype"))) {
			PageData refundData = ordersRefundService.selectRefund(goodlist.get(0).getAsInt("order_goods_id"));
			mv.addObject("refundData", refundData);
		}
		mv.addObject("dataModel", pd);
		mv.setViewName("/duyun/product_reback");
		return mv;
	}

	/**
	 * 商品订单退货
	 */
	@RequestMapping(value = "/orderReturn")
	public void orderReturn(HttpServletResponse response, HttpServletRequest request) {
		PageData newData = this.getPageData();
		newData.put("user_id", getUserIdFromSession(request));
		try {
			this.outJson(REQUEST_SUCCESS, "退货申请成功！等待审核！", orderService.updateOrderReturn(newData), response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "退货申请失败！", e.getMessage(), response);
		}
	}

	/**
	 * b2c商城下单
	 */
	@RequestMapping("createB2cOrder")
	public void createB2cOrder(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			String optType = StringUtils.isEmpty(pd.getAsString("type")) ? "buyCart" : pd.getAsString("type");
			// 接受请求参数
			System.out.println("提交订单类型：" + optType.indexOf("buyNow"));
			if (optType.indexOf("buyNow") == -1 && StringUtils.isEmpty(pd.getAsString("cartIds"))) {
				throw new Exception("请传入购物车id");
			}
			if (StringUtils.isEmpty(pd.getAsString("addressId"))) {
				throw new Exception("请传入地址id");
			}
			PageData userPd = getUser(request);
			pd.put("user_id", userPd.getAsString("user_id"));
			pd.put("user_name", StringUtils.isEmpty(userPd.getAsString("user_name")) ? userPd.getAsString("nick_name")
					: userPd.getAsString("user_name"));
			PageData result = null;
			if (optType.indexOf("buyNow") != -1) {
				pd.put("goods_id", pd.getAsString("goodsId"));
				pd.put("sku_id", pd.getAsString("skuId"));
				pd.put("goods_number", pd.getAsString("goodsNumber"));
				result = orderService.createOrderForB2cBuyNow(pd);
			} else {
				result = orderService.createOrderForB2C(pd);
			}
			this.outJson(REQUEST_SUCCESS, "订单新增成功", result, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	/**
	 * b2c商城   折扣商品下单
	 * 参数：
	 * proId 
	 * goodsId
	 * skuId
	 * goodsNumber
	 * addressId
	 */
	@RequestMapping("createB2cOrderForDiscount")
	public void createB2cOrderForDiscount(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			if (StringUtils.isEmpty(pd.getAsString("addressId"))) {
				throw new Exception("请传入地址id");
			}
			PageData userPd = getUser(request);
			pd.put("user_id", userPd.getAsString("user_id"));
			List<PageData> business = businessService.getByMap(pd);
			if(EAUtil.isNotEmpty(business) && business.size()==1){
				pd.put("bs_id", business.get(0).getAsString("id"));
			}else{
				pd.put("bs_id", "");
			}
			pd.put("user_name", StringUtils.isEmpty(userPd.getAsString("user_name")) ? userPd.getAsString("nick_name")
					: userPd.getAsString("user_name"));
			pd.put("goods_id", pd.getAsString("goodsId"));
			pd.put("sku_id", pd.getAsString("skuId"));
			pd.put("goods_number", pd.getAsString("goodsNumber"));
			pd.put("pro_id", pd.getAsString("proId"));
			PageData result = orderService.createOrderForDiscountB2cBuyNow(pd);
			this.outJson(REQUEST_SUCCESS, "订单新增成功", result, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	/**
	 * 新增订单(orderAdd)
	 * 
	 * @param user_id
	 *            用户ID
	 * @param pay_by_points
	 *            使用积分支付金额
	 * @param pay_by_money
	 *            使用现金支付金额
	 * @param cart_id
	 *            购物车ID
	 * @param contact_name
	 *            联系人姓名
	 * @param contact_phone
	 *            联系人电话
	 * @param province
	 *            联系人所在省
	 * @param city
	 *            联系人所在市
	 * @param area
	 *            联系人所在区
	 * @param address
	 *            联系人详细地址
	 * @param user_note
	 *            用户备注(120字以内)
	 * @param pay_type
	 *            支付方式
	 * @param shipping_type
	 *            配送方式
	 */
	@RequestMapping(value = "/doOrder")
	public void orderAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			PageData newData = this.getPageData();
			if (getUserIdFromSession(request).equals("-2")) {
				this.outJson(REQUEST_FAILS, "未登录，请退出公众号，重新登录！", null, response);
				return;
			}
			PageData pd1 = new PageData();
			pd1.put("goods_id", newData.get("goods_id"));
			pd1.put("user_id", getUserIdFromSession(request));
			pd1.put("sku_id", newData.get("sku_id"));
			pd1.put("goods_number", newData.getAsInt("goods_number"));
			// 判断商品是否已经存在(通过商品的id和库存的id)
			List<PageData> cartList = goodsCartService.getByMap(pd1);
			if (EAUtil.isEmpty(cartList)) {
				pd1.put("create_time", EADate.getCurrentTime());
				goodsCartService.create(pd1);
			} else {
				pd1.put("cart_id", cartList.get(0).getAsInt("cart_id"));
			}
			newData.put("cart_id", pd1.getAsString("cart_id"));
			newData.put("user_id", getUserIdFromSession(request));
			newData.put("is_delete", "0");
			newData.put("create_type", "WX");
			newData.put("create_time", EADate.getCurrentTime());
			newData.put("order_status", "0");
			newData.put("pay_status", "0");
			newData.put("calFreight", "0");
			/**
			 * 以下代码为 如果微信分享不存在则查询app分享
			 */
			Object shareUser = getSessionAttribute(request, "share_openid");
			if (shareUser == null || StringUtils.isEmpty(shareUser.toString())) {
				// 如果我微信分享者为空 查询 app分享
				shareUser = getSessionAttribute(request, "share_user_id");
			}
			newData.put("recommend_user", shareUser);
			newData = orderService.createOrder(newData);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("order_id", newData.getAsString("order_id"));
			map.put("pay_by_money", newData.getAsString("pay_by_money"));
			this.outJson(REQUEST_SUCCESS, "订单新增成功", map, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	/**
	 * 确认订单接口 param ?goods_id='"+goodsId+"&skuId="+skuId+"&goodsNum=" +
	 * goodsNum;
	 * 
	 * @throws Exception
	 */
	@RequestMapping("domakeSureOrder")
	public ModelAndView makeSureOrder(HttpServletRequest request) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("0".equals(pd.getAsString("type"))) {
			pd = getPageData;
		} else {
			getPageData = pd;
		}
		System.out.println("pd<><><<>><><><" + pd + "<><>><<><>><><><" + getPageData);
		PageData user = getUser(request);
		if (EAUtil.isEmpty(user.getAsString("phone")) || user.getAsString("phone").length() != 11) {
			mv.setViewName("redirect:/wx/duyun/user/bingphone?bingType=productSureOrder");
		} else {
			pd.put("user_id", user.getAsString("user_id"));// 用户id写死
			// 查询 选择的商品
			PageData goodsData = goodsService.getById(EAString.stringToInt(pd.getAsString("goods_id"), 0));
			if (EAUtil.isNotEmpty(goodsData)) {
				Stock stock = goodsService.queryStockBySkuId(pd);
				goodsData.put("stock", stock);
			}
			goodsData.put("goods_number", pd.getAsString("goodsNum"));
			mv.addObject("dataModel", goodsData);
			// 查询默认地址
			pd.put("is_default", 1);
			List<PageData> addressList = userAddressService.getByMap(pd);
			mv.addObject("address", (addressList == null || addressList.size() == 0) ? null : addressList.get(0));
			if (user != null) {
				pd.put("withdrawPw", user.getAsString("withdraw_password"));
			}
			mv.addObject("pd", pd);
			mv.setViewName("/duyun/confirm-goodsorder");
		}
		return mv;
	}

	/**
	 * 
	 *普通单 直接购买 确认订单接口
	 */
	@RequestMapping("makeSureOrderByDirect")
	public ModelAndView makeSureOrderByDirect(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("0".equals(pd.getAsString("addressType"))) {
			pd = getPageData;
		} else {
			getPageData = pd;
		}
		List<PageData> carList = new ArrayList<PageData>();
		pd.put("user_id", getUserIdFromSession(request));
		Integer goodsNumber = StringUtils.isNotEmpty(pd.getAsString("goodsNum")) ? pd.getAsInt("goodsNum") : 1;
		PageData forgeCart = goodsCartService.selectForgeBySkuId(pd);
		forgeCart.put("goods_number", goodsNumber);
		forgeCart.put("user_id", pd.getAsString("user_id"));
		forgeCart.put("create_time", EADate.getCurrentTime());
		forgeCart.put("sales_attrs", forgeCart.getAsString("attr_json"));
		forgeCart.put("goods_price", forgeCart.getAsString("price"));
		forgeCart.put("goods_img", forgeCart.getAsString("list_img"));
		forgeCart.put("goods_name", forgeCart.getAsString("goods_name"));
		carList.add(forgeCart);
		mv.setViewName("/duyun/confirm_product_order");
		mv.addObject("pd", pd);
		mv.addObject("cartList", carList);
		pd.put("is_default", 1);
		List<PageData> addressList = userAddressService.getByMap(pd);
		mv.addObject("address", (addressList == null || addressList.size() == 0) ? null : addressList.get(0));
		return mv;
	}
	/**
	 * 显示折扣 直接购买 确认订单接口
	 */
	@RequestMapping("makeSureOrderByDisCount")
	public ModelAndView makeSureOrderByDisCount(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("0".equals(pd.getAsString("addressType"))) {
			pd = getPageData;
		} else {
			getPageData = pd;
		}
		List<PageData> carList = new ArrayList<PageData>();
		pd.put("user_id", getUserIdFromSession(request));
		Integer goodsNumber = StringUtils.isNotEmpty(pd.getAsString("goodsNum")) ? pd.getAsInt("goodsNum") : 1;
		PageData forgeCart = goodsCartService.selectForgeBySkuId(pd);
		forgeCart.put("goods_number", goodsNumber);
		forgeCart.put("user_id", pd.getAsString("user_id"));
		forgeCart.put("create_time", EADate.getCurrentTime());
		forgeCart.put("sales_attrs", forgeCart.getAsString("attr_json"));
		forgeCart.put("price", pd.getAsString("price"));
		forgeCart.put("goods_img", forgeCart.getAsString("list_img"));
		forgeCart.put("goods_name", forgeCart.getAsString("goods_name"));
		carList.add(forgeCart);
		mv.setViewName("/duyun/confirm_product_order");
		mv.addObject("pd", pd);
		mv.addObject("cartList", carList);
		pd.put("is_default", 1);
		List<PageData> addressList = userAddressService.getByMap(pd);
		mv.addObject("address", (addressList == null || addressList.size() == 0) ? null : addressList.get(0));
		return mv;
	}
	/**
	 * 加入到购物车购买
	 * 
	 * 确认订单接口 param cartIds 购物车id集合 userId 用户id
	 * 
	 * @throws Exception
	 */
	@RequestMapping("makeSureOrder")
	public ModelAndView makeSureOrderMin(HttpServletRequest request) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("0".equals(pd.getAsString("addressType"))) {
			pd = getPageData;
		} else {
			getPageData = pd;
		}
		String cartIds = pd.getAsString("cartIds");
		/*
		 * if (EAUtil.isEmpty(user.getAsString("phone")) ||
		 * user.getAsString("phone").length() != 11) { mv.setViewName(
		 * "redirect:/wx/duyun/user/bingphone?bingType=makeSureOrder"); return
		 * mv; }
		 */
		pd.put("user_id", getUserIdFromSession(request));// 用户id写死
		List<PageData> carList = new ArrayList<PageData>();
		/*
		 * if("buyNow".equalsIgnoreCase(type)){ //如果是立即购买 先加入到购物车 然后
		 * pd.put("sku_id", sku_id); PageData forgeCart =
		 * goodsCartService.selectForgeBySkuId(pd);
		 * forgeCart.put("goods_number",goodsNumber);
		 * forgeCart.put("user_id",pd.getAsString("user_id"));
		 * forgeCart.put("create_time", EADate.getCurrentTime());
		 * forgeCart.put("sales_attrs", forgeCart.getAsString("attr_json"));
		 * forgeCart.put("goods_price", forgeCart.getAsString("price"));
		 * forgeCart.put("goods_img", forgeCart.getAsString("list_img"));
		 * forgeCart.put("goods_name", forgeCart.getAsString("goods_name"));
		 * carList.add(forgeCart); pd.put("p_id",
		 * forgeCart.getAsString("goods_id")); //根据用户id和sku_id查询购物车是否存在
		 * List<PageData> carts = goodsCartService.getByMap(pd); if(carts !=
		 * null && carts.size() > 0){ cartIds =
		 * carts.get(0).getAsString("cart_id"); }else{
		 * goodsCartService.create(forgeCart); cartIds =
		 * forgeCart.getAsString("cart_id"); } }
		 */
		// 查询 选择的购物车商品
		String[] carts = cartIds.split(",");
		int[] cart_id = new int[carts.length];
		for (int i = 0; i < carts.length; i++) {
			cart_id[i] = Integer.valueOf(carts[i]);
		}
		pd.put("cart_ids", cart_id);
		carList = goodsCartService.selectByUserCartId(pd);
		mv.addObject("cartList", carList);
		// 查询默认地址
		pd.put("is_default", 1);
		List<PageData> addressList = userAddressService.getByMap(pd);
		mv.addObject("address", (addressList == null || addressList.size() == 0) ? null : addressList.get(0));
		// 查询用户优惠券
		mv.setViewName("/duyun/confirm_product_order");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 传入order_id实现逻辑删除订单
	 */
	@RequestMapping(value = "/orderDel")
	public void orderDel(HttpServletResponse response) {
		PageData newData = this.getPageData();
		int order_id = newData.getAsInt("order_id");
		int judge = orderService.deleteOrder(order_id);
		if (judge > 0) {
			this.outJson(REQUEST_SUCCESS, "订单删除成功", null, response);
		} else
			this.outJson(REQUEST_FAILS, "未知原因删除失败", null, response);
	}

	/**
	 * 取消订单
	 * 
	 * @param response
	 */
	@RequestMapping(value = "/orderCancel")
	public void orderCancel(HttpServletResponse response, HttpServletRequest request) {
		PageData newData = this.getPageData();
		if (newData.get("opType") != null && "PC".equals(newData.getAsString("opType"))) {
			Object objUser = request.getSession().getAttribute("userInfo");
			if (objUser != null) {
				newData.put("user", ((PageData) objUser).getAsString("user_id"));
			}
		} else {
			newData.put("user_id", getUserIdFromSession(request));
		}
		try {
			this.outJson(REQUEST_SUCCESS, "订单取消成功", orderService.updatecancelOrder(newData), response);
		} catch (Exception e) {
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	/**
	 * 传入用户ID和订单ID，实现签收订单
	 */
	@RequestMapping(value = "/orderSign")
	public void orderSign(HttpServletResponse response, HttpServletRequest request) {
		PageData newData = this.getPageData();
		if (newData.get("opType") != null && "PC".equals(newData.getAsString("opType"))) {
			Object objUser = request.getSession().getAttribute("userInfo");
			if (objUser != null) {
				newData.put("user", ((PageData) objUser).getAsString("user_id"));
			}
		} else {
			newData.put("user_id", getUserIdFromSession(request));
		}
		int judge = orderService.updateSignOrder(newData);
		if (judge > 0) {
			this.outJson(REQUEST_SUCCESS, "订单签收成功", null, response);
		} else {
			this.outJson(REQUEST_FAILS, "由于未知原因，导致订单签收失败", null, response);
		}
	}

	/**
	 * 课程/商品订单评价
	 * 
	 */
	@RequestMapping("addGoodsComment")
	public ModelAndView addGoodsComment() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/duyun/product_comment");
		mv.addObject("pd", this.getPageData());
		return mv;
	}

	/**
	 * 
	 * 添加课程商品订单评论
	 */
	@RequestMapping("goodsComment")
	public void goodsComment(HttpServletRequest request, HttpServletResponse response) {
		PageData pd = this.getPageData();
		PageData goodspd = new PageData();
		pd.put("user_id", getUserIdFromSession(request));
		try {
			if (goodsCommentService.setComment(pd)) {
				goodspd.put("user_id", pd.getAsString("user_id"));
				goodspd.put("order_id", pd.getAsString("order_id"));
				PageData order = orderService.getById(pd.getAsInt("order_id"));
				List<PageData> ordergoods = ordersGoodsService.getByMap(goodspd);
				List<PageData> commentAlllist = goodsCommentService.getByMap(goodspd);
				if (commentAlllist != null && commentAlllist.size() == ordergoods.size()) {
					// 全部
					order.put("order_status", "8");
					orderService.edit(order);
				}
				this.outJson(REQUEST_SUCCESS, "评论成功", null, response);
			} else {
				this.outJson(REQUEST_FAILS, "评论失败", null, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "评论失败", e.getMessage(), response);
		}
	}

	// ajax分页请求列表数据\
	/**
	 * 门票订单 /wx/order/doticketOrderList
	 */
	@RequestMapping("doticketOrderList")
	public void ticketOrderList(HttpServletResponse response, HttpServletRequest request, PageExtend page,
			@RequestParam(defaultValue = "1") Integer currentPage, @RequestParam(defaultValue = "5") Integer pageSize) {
		PageData pd = this.getPageData();
		try {
			pd.put("user_id", getUserIdFromSession(request));
			page.setApp(true);
			page.setCurrentPage(currentPage);
			page.setShowCount(pageSize);
			page.setPd(pd);
			List<TicketOrder> ticketOrders = ticketOrderService.selectEntityByPage(page);
			pd.put("resultPd", ticketOrders);
			pd.put("prefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", pd, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 门票订单详情 /wx/order/doticketOrderDetail
	 */
	@RequestMapping("doticketOrderDetail")
	public void ticketOrderDetail(HttpServletResponse response) {
		Page page = new Page();
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			List<TicketOrder> ticketOrders = ticketOrderService.selectEntityByMap(page);
			if (!ticketOrders.isEmpty() && ticketOrders.size() == 1) {
				TicketOrder dataModel = ticketOrders.get(0);
				// 退票请求票号
				PageData dataDetail = new PageData();
				// 查询票号
				dataDetail.put("order_id", dataModel.getId());
				List<PageData> traverInfo = ticketOrderService.selectTicketCodeInfo(dataDetail);
				
				int noUse = 0, alUse = 0, refundN = 0;
				if(EAUtil.isNotEmpty(traverInfo)){
					if ("1".equals(dataModel.getIsRealName())) {
						for (PageData tpd : traverInfo) {
							noUse += EAString.stringToInt(tpd.getAsString("quantity"), 0)
									- EAString.stringToInt(tpd.getAsString("used_quantity"), 0)
									- EAString.stringToInt(tpd.getAsString("refund_quantity"), 0);
							alUse += EAString.stringToInt(tpd.getAsString("used_quantity"), 0);
							refundN += EAString.stringToInt(tpd.getAsString("refund_quantity"), 0);
						}
					} else {
						PageData ticketCode = traverInfo.get(0);
						alUse = EAString.stringToInt(ticketCode.getAsString("used_quantity"), 0);
						refundN = EAString.stringToInt(ticketCode.getAsString("refund_quantity"), 0);
						noUse = EAString.stringToInt(ticketCode.getAsString("quantity"), 0) - alUse - refundN;
					}
					dataDetail.put("traverInfo", traverInfo);
				}
				
				dataDetail.put("noUseTicket", noUse < 0 ? 0 : noUse);
				dataDetail.put("refundTicket", refundN < 0 ? 0 : refundN);
				dataDetail.put("alUseTicket", alUse < 0 ? 0 : alUse);
				dataDetail.put("dataModel", dataModel);
				this.outJson(REQUEST_SUCCESS, "请求成功", dataDetail, response);
			} else {
				this.outJson(REQUEST_FAILS, "请求失败", null, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 跟团游门票订单 /wx/order/doticketOrderList
	 */
	@RequestMapping("dogroupTourOrderList")
	public void dogroupTourOrderList(HttpServletResponse response, HttpServletRequest request, PageExtend page,
			@RequestParam(defaultValue = "1") Integer currentPage, @RequestParam(defaultValue = "5") Integer pageSize) {
		PageData pd = this.getPageData();
		try {
			pd.put("user_id", getUserIdFromSession(request));
			page.setApp(true);
			page.setCurrentPage(currentPage);
			page.setShowCount(pageSize);
			page.setPd(pd);
			List<GroupTourOrder> groupOrders = groupTourService.selectEntityByPage(page);
			pd.put("resultPd", groupOrders);
			pd.put("prefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", pd, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 跟团游门票订单详情 /wx/order/doticketOrderDetail
	 */
	@RequestMapping("dogroupTourOrderDetail")
	public void dogroupTourOrderDetail(HttpServletResponse response) {
		PageData pd = this.getPageData();
		try {
			GroupTourOrder groupOrder = groupTourService.selectOrderEntity(pd);
			if (groupOrder != null) {
				this.outJson(REQUEST_SUCCESS, "请求成功", groupOrder, response);
			} else {
				this.outJson(REQUEST_FAILS, "请求失败", null, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	private String getUserIdFromSession(HttpServletRequest request) {
		String user_id = "-1";
		PageData user = getUser(request);
		if (user != null) {
			user_id = user.getAsString("user_id");
		}
		return user_id;
	}

	private PageData getUser(HttpServletRequest request) {
		PageData pd = new PageData();
//		pd.put("user_id", "217");
		pd.put("open_id", this.getSessionAttribute(request, "open_id"));
		PageData user = userService.getOneByMap(pd);
		if (user != null) {
			return user;
		}
		return null;
	}

}
