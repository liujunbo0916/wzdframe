package pc.easaa.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.easaa.content.service.ContentService;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsCartService;
import com.easaa.goods.service.GoodsService;
import com.easaa.order.service.OrderService;
import com.easaa.scenicspot.assembly.TicketService;
import com.easaa.scenicspot.entity.ticket.TicketPriceData;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.ScenicLineService;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.user.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

@RequestMapping("/logic/")
@Controller
public class PcBookAjaxController extends BaseController{
	
	@Autowired
	private ScenicService scecnicService;
	
	@Autowired
	private ScenicLineService scenicLineService;
	
	@Autowired
	private ContentService contentService;
	
	@Autowired
	private GroupTourService groupTourService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private GoodsCartService goodsCartService;
	
	@Autowired
	private TicketOrderService ticketOrderService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;
	
	
	/**
	 * 获取景点列表数据
	 */
	@RequestMapping("scenicList")
	public void scenicList(HttpServletResponse response,Integer limit){
		try{
			PageData pd = this.getPageData();
			pd.put("limit", limit);
			if(StringUtils.isNotEmpty(pd.getAsString("line_id"))){
				List<PageData> scenics = scenicLineService.selectScenicByLine(pd);
				StringBuffer sb = new StringBuffer();
				sb.append("(");
				for(PageData tpd :scenics){
					sb.append(tpd.getAsString("id")+",");
				}
				String ids = sb.substring(0, sb.length()-1)+")";
				pd.put("aboutId", ids);
			}
			this.outJson(REQUEST_SUCCESS, "请求成功", scecnicService.getByMap(pd), response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 获取攻略列表数据
	 */
	@RequestMapping("raidersList")
	public void raidersList(HttpServletResponse response,Integer limit){
		try{
			PageData pd = new PageData();
			pd.put("limit", limit);
			pd.put("line_status", "1");
			this.outJson(REQUEST_SUCCESS, "请求成功", scenicLineService.getByMap(pd), response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	
	/**
	 * 请求咨询数据
	 */
	@RequestMapping("contentList")
	public void contentList(HttpServletResponse response){
		try{
			Map<String,List<PageData>> contentList = new HashMap<String,List<PageData>>();
			PageData pd = new PageData();
			pd.put("limit", 3);
			pd.put("STATE", "1");
			pd.put("CATEGORY_CODE", "3AfIn");
			contentList.put("realTimeNews", contentService.getByMap(pd));
			pd.put("CATEGORY_CODE", "FYmKw");
			contentList.put("travelNews", contentService.getByMap(pd));
			this.outJson(REQUEST_SUCCESS, "请求成功", contentList, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 热门路线
	 */
	
	@RequestMapping("hotLine")
	public void hotLine(HttpServletResponse response,Integer limit){
		try{
			PageData pd = this.getPageData();
			pd.put("grouptour_state", 1);
			pd.put("limit", limit);
			List<PageData> groupTour = groupTourService.getByMap(pd);
			this.outJson(REQUEST_SUCCESS, "请求成功", groupTour, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 商品订单提交
	 * 
	 */
	
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
	
	@RequestMapping("/product/addOrder")
	public void productAddOrder(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
			String paramStr = pd.getAsString("paramStr");
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(paramStr),"utf-8"));
//			orderService.addOrder(model);
			PageData pd1 = new PageData();
			pd1.put("goods_id", paramObj.get("goods_id"));
			pd1.put("user_id", userPd.getAsString("user_id"));
			pd1.put("sku_id", paramObj.get("sku_id"));
			pd1.put("goods_number", paramObj.getInt("goods_number"));
			// 判断商品是否已经存在(通过商品的id和库存的id)
			List<PageData> cartList = goodsCartService.getByMap(pd1);
			if (EAUtil.isEmpty(cartList)) {
				pd.put("create_time", EADate.getCurrentTime());
				goodsCartService.create(pd1);
			} else {
				pd1.put("cart_id", cartList.get(0).getAsInt("cart_id"));
			}
			PageData newData = this.getPageData();
			newData.put("cart_id", pd1.getAsString("cart_id"));
			newData.put("user_id", userPd.getAsString("user_id"));
			newData.put("is_delete", "0");
			newData.put("create_type", "PC");
			newData.put("pay_by_points", paramObj.getString("pay_by_points"));
			newData.put("pay_by_money", paramObj.get("pay_by_money"));
			newData.put("contact_name", paramObj.get("contact_name"));
			newData.put("contact_phone", paramObj.get("contact_phone"));
			newData.put("province_id", paramObj.get("province_id"));
			newData.put("province", paramObj.get("province"));
			newData.put("city_id", paramObj.get("city_id"));
			newData.put("city", paramObj.get("city"));
			newData.put("area_id", paramObj.get("area_id"));
			newData.put("area", paramObj.get("area"));
			newData.put("address", paramObj.get("address"));
			newData.put("create_time", EADate.getCurrentTime());
			newData.put("shipping_type", paramObj.get("shipping_type"));
			newData.put("shipping_money", paramObj.get("shipping_money"));
			newData.put("order_status", "0");
			newData.put("pay_status", 0);
			newData.put("calFreight", "0");
			// 创建操作 29.1100----58.2200----145.5500
			newData = orderService.createOrderForB2cBuyNow(newData);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("order_id", newData.getAsString("order_id"));
			map.put("order_sn", newData.getAsString("order_sn"));
			map.put("pay_by_money", newData.getAsString("pay_by_money"));
			this.outJson(REQUEST_SUCCESS, "订单新增成功", map, response);
		}catch(Exception e){
			this.outJson(REQUEST_FAILS, "创建订单失败，请稍后重试", null, response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 创建商品订单   单个商品购买  直接购买
	 * 
	 */
	@RequestMapping("product/createSingleOrder")
	public void createOrderBySingle(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
			String paramStr = pd.getAsString("paramStr");
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(paramStr),"utf-8"));
			String optType = paramObj.get("type") == null ? "buyCart" : paramObj.getString("type");
			//接受请求参数
			System.out.println("提交订单类型："+optType.indexOf("buyNow"));
			if(optType.indexOf("buyNow") == -1 && StringUtils.isEmpty(pd.getAsString("cartIds"))){
				throw new Exception("请传入购物车id");
			}
			pd.put("shipping_type", paramObj.get("shipping_type"));
			
			if("0".equals(pd.getAsString("shipping_type")) && paramObj.get("addressId") == null){ //如果选择快递配送  地址不能为空
				throw new Exception("请传入地址id");
			}
			pd.put("user_id", userPd.getAsString("user_id"));
			pd.put("user_name", StringUtils.isEmpty(userPd.getAsString("user_name")) ? userPd.getAsString("nick_name") : userPd.getAsString("user_name"));
			PageData result = null;
			pd.put("totalMoney", paramObj.get("totalMoney"));
			pd.put("shipping_money", paramObj.get("shipping_money"));
			pd.put("cartIds", paramObj.get("cartIds"));
			pd.put("addressId", paramObj.get("addressId"));
			pd.put("is_mer", paramObj.get("is_mer"));
			pd.put("mer_title", paramObj.get("mer_title"));
			pd.put("mer_no", paramObj.get("mer_code"));
			pd.put("type", paramObj.get("type"));
			pd.put("mer_type", paramObj.get("mer_type"));
			if(optType.indexOf("buyNow") != -1){
				pd.put("goods_id", paramObj.get("goodsId"));
				pd.put("sku_id", paramObj.get("skuId")); 
				System.out.println(paramObj.get("goodsNumber"));
				pd.put("goods_number", (paramObj.get("goodsNumber") == null || "0".equals(paramObj.get("goodsNumber").toString())) ? "1" :paramObj.get("goodsNumber").toString());
				if(paramObj.get("activeType") != null && "2".equals(paramObj.get("activeType"))){
					//购买活动商品
					pd.put("addtype", 1);
					pd.put("pro_id", paramObj.get("activeProId"));
					result = orderService.createOrderForDiscountB2cBuyNow(pd);
				}else{
					pd.put("addtype", 0);
					result = orderService.createOrderForB2cBuyNow(pd);
				}
			}else{
				result = orderService.createOrderForB2C(pd);
			}
			this.outJson(REQUEST_SUCCESS, "订单新增成功", result, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}
	/**
	 * 票务日期列表  逻辑较多  
	 * monthParam 当前查询的月份
	 * yearParam 当前查询的年份
	 * ticketTypeId查询的票务id
	 * endSaleTime 结束销售时间
	 * beginSaleTime 开始销售时间
	 * base64加密之后的字符串
	 */
	@RequestMapping("/ticket/dateList")
	public void ticketDateList(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
			String beginSaleTime = paramObj.getString("beginSaleTime");
			String endSaleTime = paramObj.getString("endSaleTime");
			String ticketTypeId = paramObj.getString("ticketTypeId");
			String monthParam = paramObj.getString("select_month");
			String yearParam = paramObj.getString("select_year");
			Date startParamDate,endParamDate;
			String disabledMinMonth="",disabledMinYear="",disabledMaxMonth="",disabledMaxYear="";
			Date currentDate = new Date();
			Date beginSaleDate = EADate.stringToDate(beginSaleTime);
			Date endSaleDate = EADate.stringToDate(endSaleTime);
			if(currentDate.getTime() < beginSaleDate.getTime()){
				disabledMinMonth = EADate.getMonth(beginSaleDate)+"";
				disabledMinYear =  EADate.getYear(beginSaleDate);
			}else{
				disabledMinMonth = EADate.getMonth(currentDate)+"";
				disabledMinYear = EADate.getYear(currentDate);
			}
			disabledMaxMonth = EADate.getMonth(endSaleDate)+"";
			disabledMaxYear = EADate.getYear(endSaleDate);
			//客户选择的日期
			Date selectDate = EADate.getContentYearMonthDay(yearParam, monthParam, "01");
			if(selectDate.getTime() > beginSaleDate.getTime()){
				/**
				 * 如果选择日期当月第一天 大于 开始售票日期
				 * 则将开始查询条件指向 选择日期的当月第一天
				 */
				startParamDate = selectDate;
			}else{
				/**
				 * 选择日期当月的第一天  小于 开始售票日期  则将查询条件 指向开始售票日期
				 * 
				 */
				startParamDate = beginSaleDate;
			}
			
			Date selectLastDate = EADate.getLastDate(startParamDate); 
			if(selectLastDate.getTime() > endSaleDate.getTime()){
				/**
				 * 如果选择的日期当月的最后一天大于 结束卖票的时间
				 * 将查询条件绑定
				 */
				endParamDate = endSaleDate;
			}else{
				/**
				 * 如果选择的日期当月的最后一天小于 结束卖票的时间
				 * 将查询条件绑定 选择日期当月的第一天
				 */
				endParamDate = selectLastDate;
			}
			/**
			 * 重置选择条件的年和月
			 *  将选择查询条件的年和月指向参数的 当前年月
			 */
			yearParam = EADate.getYear(startParamDate);
			monthParam = EADate.getMonth(startParamDate)+"";
			//获取票务金额数据
			String dateListJson = TicketService.getTicketDailyPrice(EADate.getFormatTime(startParamDate, "yyyy-MM-dd HH:mm:ss"), 
					EADate.getFormatTime(endParamDate, "yyyy-MM-dd HH:mm:ss"), ticketTypeId);
			JSONObject jsonObject = JSONObject.fromObject(dateListJson);
			String body = jsonObject.getString("ResponseBody");
			JSONArray retList = JSONArray.fromObject(body);
			Date firstElemtDate = EADate.stringToDateSimple(retList.getJSONObject(0).getString("Date"));
			Date monthFirstElemtDate =  EADate.getFirstDate(firstElemtDate);
			Date monthLastElemDate = EADate.getLastDate(firstElemtDate);
			if(!retList.getJSONObject(retList.size()-1).getString("Date").equals(EADate.date2StrSimple(monthLastElemDate))){
				Calendar monthLastCalendar = Calendar.getInstance();
				monthLastCalendar.setTime(firstElemtDate);
				for(int i = 0;i<EADate.differentDaysByMillisecond(firstElemtDate,monthLastElemDate);i++){
					monthLastCalendar.add(Calendar.DAY_OF_MONTH, 1);
					JSONObject tpd = new JSONObject();
	            	 tpd.put("Date", EADate.date2StrSimple(monthLastCalendar.getTime()));
		           	 tpd.put("dayOfMonth", monthLastCalendar.get(Calendar.DAY_OF_MONTH));
		           	 tpd.put("Stock", "0");
		           	 tpd.put("SettlementPrice", "-1");
	            	 retList.add(tpd);
				}
			}
			Calendar monthFirstCalendar = Calendar.getInstance();
			monthFirstCalendar.setTime(monthFirstElemtDate);
			retList.getJSONObject(0).put("indent", EADate.differentDaysByMillisecond(monthFirstElemtDate,firstElemtDate));
			String intent = retList.getJSONObject(0).getString("indent");
             for(int i =0;i< Integer.parseInt(intent) ; i++){
            	 JSONObject tpd = new JSONObject();
            	 if(i != 0){
            		 monthFirstCalendar.add(Calendar.DAY_OF_MONTH,1);
            	 }
            	 tpd.put("Date", EADate.date2Str(monthFirstCalendar.getTime()));
            	 tpd.put("dayOfMonth", monthFirstCalendar.get(Calendar.DAY_OF_MONTH));
            	 tpd.put("Stock", "0");
            	 tpd.put("SettlementPrice", "-1");
            	 retList.add(i, tpd);
			}
            for(int i=0;i<EADate.getWeekOfDate(monthFirstElemtDate);i++){
            	JSONObject tpd = new JSONObject();
            	 tpd.put("Date", "");
	           	 tpd.put("dayOfMonth", "0");
	           	 tpd.put("Stock", "0");
	           	 tpd.put("SettlementPrice", "-1");
            	 retList.add(i,tpd);
            }
            for(int i = 0 ; i < retList.size() ; i++){
            	if(StringUtils.isNotEmpty(retList.getJSONObject(i).getString("Date"))){
            		monthFirstCalendar.setTime(EADate.stringToDateSimple(retList.getJSONObject(i).getString("Date")));
            		retList.getJSONObject(i).put("dayOfMonth", monthFirstCalendar.get(Calendar.DAY_OF_MONTH));
            	}else{
            		retList.getJSONObject(i).put("dayOfMonth", "0");
            	}
            }
            TicketPriceData ticketPData = new TicketPriceData();
            ticketPData.setDisabledMaxMonth(disabledMaxMonth);
            ticketPData.setDisabledMinMonth(disabledMinMonth);
            ticketPData.setMonthParam(monthParam);
            ticketPData.setYearParam(yearParam);
            ticketPData.setJsonData(retList);
            ticketPData.setDisabledMaxYear(disabledMaxYear);
            ticketPData.setDisabledMinYear(disabledMinYear);
			this.outJson(REQUEST_SUCCESS, "计算成功", ticketPData, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "日期计算错误，请联系管理员", null, response);
		}
	}
	/**
	 * 
	 * 提交票务订单
	 */
	@RequestMapping("/ticket/addOrder")
	public void addTicketOrder(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
			System.out.println(paramObj);
			//判断用户是否匿名购买
			if(paramObj.get("anonymous") == null || !"1".equals(paramObj.getString("anonymous"))){
				if(paramObj.get("user_id") == null){ //微信端传来的userid
					PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
					if(userPd == null){
						//需要登陆
						this.outJson(TO_LOGIN, "需登录", pd, response);
						return;
					}else{
						paramObj.put("user_id", userPd.getAsString("user_id"));
					}
				}
			}
			pd = ticketOrderService.createOrder(paramObj,request);
			this.outJson(REQUEST_SUCCESS, "提交成功", pd, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "系统异常，请联系管理员", null, response);
		}
	}
	
	/**
	 * 
	 * 申请退款接口
	 * @throws UnsupportedEncodingException 
	 * 
	 * 1，如果实名认证   需要用户勾选退票的票号。在本系统标识勾选的用户为退票状态。 未勾选的票为可用状态。
	 *   扫码进闸的时候
	 * 
	 * 2，如果未实名认证   不需要用户勾选用户。直接输入退票数。
	 */
	@RequestMapping("applyRefund")
	public void applyRefund(HttpServletResponse response) throws UnsupportedEncodingException{
		try{
			PageData pd = this.getPageData();
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
			//退款类型
			String type = paramObj.getString("type");
			pd.put("orderNo", paramObj.get("orderNo"));
			pd.put("quantity", paramObj.get("quantity"));
			pd.put("ticketCodes", paramObj.get("ticketCodes"));
			//查询订单
			if("1".equals(type)){
				ticketOrderService.createRefund(pd);
			}
			super.outJson(super.REQUEST_SUCCESS, "申请成功，注意查收退款短信通知", "", response);
		}catch(Exception e){
			super.outJson(super.REQUEST_FAILS, "网络异常", "", response);
		}
	}
	/**
	 * 提交旅游订单
	 */
	@RequestMapping("/grouptour/createOrder")
	public void addGroupTourOrder(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
			
			if(paramObj.get("anonymous") == null || "0".equals(paramObj.getString("anonymous"))){
				if(paramObj.get("user_id") == null){ //微信端传来的userid
					PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
					if(userPd == null){
						//需要登陆
						this.outJson(TO_LOGIN, "用户未登陆", pd, response);
						return;
					}else{
						paramObj.put("user_id", userPd.getAsString("user_id"));
					}
				}
			}
			pd =groupTourService.createOrder(paramObj,request);
			this.outJson(REQUEST_SUCCESS, "提交成功", pd, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}
	/**
	 * 日期计算
	 */
	@RequestMapping("/calDate")
	public void calDate(String currentMonth,String currentYear,String childPrice,String adultPrice,HttpServletResponse response){
		try{
			List<PageData> result = new ArrayList<PageData>();
			Calendar calendar = Calendar.getInstance();
			Date selectFirstDate = EADate.stringToDateSimple(currentYear+"-"+currentMonth+"-"+"01");
			Date selectLastDate = EADate.getLastDate(selectFirstDate);
			//查询 当前选择的1月份的1号星期几
			calendar.setTime(selectFirstDate);
			int firstIntent = calendar.get(Calendar.DAY_OF_WEEK);
			//得到上月的最后一天
			calendar.add(Calendar.MONTH, -1);
			Date prevLastDate = EADate.getLastDate(calendar.getTime());
			calendar.setTime(prevLastDate);
			calendar.add(Calendar.DAY_OF_MONTH, -(firstIntent-1));
			for(int i = 1 ;i <firstIntent  ; i++){
				PageData tempPd = new PageData();
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				tempPd.put("dayOfMonth", calendar.get(Calendar.DAY_OF_MONTH));
				tempPd.put("dateStr", EADate.date2StrSimple(calendar.getTime()));
				tempPd.put("groupPrice", adultPrice);
				tempPd.put("childPrice", childPrice);
				tempPd.put("disabled", 1);
				result.add(tempPd);
			}
			calendar.setTime(selectLastDate);
			int currentDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
			calendar.setTime(selectFirstDate);
			for(int i = 0 ; i < currentDayOfMonth;i++){
				PageData tempPd = new PageData();
				tempPd.put("dayOfMonth", calendar.get(Calendar.DAY_OF_MONTH));
				tempPd.put("dateStr", EADate.date2StrSimple(calendar.getTime()));
				tempPd.put("groupPrice", adultPrice);
				tempPd.put("childPrice", childPrice);
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				tempPd.put("disabled", 0);
				result.add(tempPd);
			}
			calendar.setTime(selectLastDate);
			int lastIntent = calendar.get(Calendar.DAY_OF_WEEK);
			lastIntent = 7-lastIntent;
			for(int i = 0 ; i < lastIntent ; i++){
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				PageData tempPd = new PageData();
				tempPd.put("dayOfMonth", calendar.get(Calendar.DAY_OF_MONTH));
				tempPd.put("dateStr", EADate.date2StrSimple(calendar.getTime()));
				tempPd.put("groupPrice", adultPrice);
				tempPd.put("childPrice", childPrice);
				tempPd.put("disabled", 1);
				result.add(tempPd);
			}
			PageData json = new PageData();
			json.put("selectYear", currentYear);
			json.put("selectMonth", currentMonth);
			json.put("dataList", result);
			super.outJson(super.REQUEST_SUCCESS, "查询成功", json, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_SUCCESS, "查询失败", null, response);
		}
		
		
	}
	
	/**
	 * 查看推荐商品
	 * 人气推荐 
	 * 以虚拟销量排序
	 * 
	 * @param args
	 */
	@RequestMapping("/product/recommend")
	public void recommendProduct(String limit,HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			pd.put("limit", EAString.stringToInt(limit, 6));
			super.outJson(super.REQUEST_SUCCESS, "查询成功", goodsService.selectGoodsHeat(pd), response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_SUCCESS, "查询失败", null, response);
		}
	}
	/**
	 * 新品推荐
	 * 按照推荐值排序
	 * @param args
	 */
	 @RequestMapping("/product/newRecommend")
	 public void newRecommend(String limit,HttpServletResponse response){
			try{
				Page page = new Page();
				PageData pd = this.getPageData();
				pd.put("number", EAString.stringToInt(limit, 6));
				pd.put("is_on_sale", 1);
				pd.put("is_delete", 0);
				page.setPd(pd);
				super.outJson(super.REQUEST_SUCCESS, "查询成功", goodsService.goodsDiscounts(page), response);
			}catch(Exception e){
				e.printStackTrace();
				super.outJson(super.REQUEST_FAILS, "查询失败", null, response);
			}
		}
	

	public static void main(String[] args) {
		Calendar calendar = Calendar.getInstance();
		Date selectFirstDate = EADate.stringToDateSimple("2017-"+"09-"+"01");
		calendar.setTime(selectFirstDate);
		System.out.println(calendar.get(Calendar.DAY_OF_WEEK));
	}
}
