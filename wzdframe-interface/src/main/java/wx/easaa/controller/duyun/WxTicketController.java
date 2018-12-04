package wx.easaa.controller.duyun;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.TicketCateData;
import com.easaa.scenicspot.entity.ticket.TicketData;
import com.easaa.scenicspot.entity.ticket.TicketListData;
import com.easaa.scenicspot.entity.ticket.TicketPriceData;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.scenicspot.service.TicketService;
import com.easaa.user.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

@RequestMapping("/wx/ticket/")
@Controller
public class WxTicketController extends BaseController {

	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private TicketOrderService ticketOrderService;

	@Autowired
	private ScenicService scenicService;

	@Autowired
	private UserService userService;

	/**
	 * #################页面跳转controller############################
	 * 
	 * 不提供任何逻辑功能只提供跳转功能和参数携带功能
	 */

	/**
	 * 通过参数redirectType来获取该跳转哪一个页面
	 * 
	 * @param redirectType
	 * @return /wx/ticket/index?redirectType=list
	 */
	@RequestMapping(value = { "", "index" })
	public ModelAndView index(String redirectType,HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if ("list".equalsIgnoreCase(redirectType)) {
			mv.setViewName("/duyun/ticket_list");
			putShareApi("/wx/ticket/index?redirectType=list", this.getPageData(), mv, false);
		} else if ("detail".equalsIgnoreCase(redirectType)) {
			mv.setViewName("/duyun/ticket_detail");
			mv.addObject("pd", pd);
			mv.addObject("user", getUser(request));
		} else if ("introduce".equalsIgnoreCase(redirectType)) {
			pd.put("scenicContent", scenicService.getByMap(pd).get(0).getAsString("scenic_content"));
			mv.setViewName("/duyun/ticket_scenic_desc");
		} else if ("confirmOrder".equalsIgnoreCase(redirectType)) {
			/**
			 * 查询票务信息  数组的形式  
			 */
			Set<String> duplicateSet = new HashSet<String>();
			StringBuffer sb = new StringBuffer();
			String[] ticketIdsAry = pd.getAsString("ticketIds").split(",");
			for(String s :ticketIdsAry){
				duplicateSet.add(s);
			}
			for(String s : duplicateSet){
				sb.append(s+",");
			}
			String tempTicketIds = sb.substring(0, sb.length()-1);
			pd.put("tids", tempTicketIds);
			String ticketIds = "("+tempTicketIds+")";
			pd.put("ticketIds", ticketIds);
			List<PageData> ticketList = ticketService.selectByIdsStr(pd);
			for(PageData tempTicket : ticketList){
				if(StringUtils.isEmpty(tempTicket.getString("third_no"))){
					continue;
				}
				String ticketThirdNo = tempTicket.getString("third_no");
				String thirdJson = com.easaa.scenicspot.assembly.TicketService.getTicketTypes(null, null,
						ticketThirdNo);
				JSONObject jsonObj = JSONObject.fromObject(thirdJson);
				jsonObj = JSONObject.fromObject(jsonObj.getString("ResponseBody"));
				JSONArray jsonAry = JSONArray.fromObject(jsonObj.get("TicketTypeList"));
				jsonObj = JSONObject.fromObject(jsonAry.get(0));
				tempTicket.put("ticketDetail", jsonObj);
				tempTicket.put("user_id", getUserIdFromSession(request));
			}
			mv.addObject("ticketList", ticketList);
			mv.addObject("pd", pd);
			mv.setViewName("/duyun/ticket_confirm_order_min");
		} else if ("orderList".equalsIgnoreCase(redirectType)) {
			mv.setViewName("/duyun/ticket_orderlist");
		} else if ("orderDteail".equalsIgnoreCase(redirectType)) {
			mv.setViewName("/duyun/ticket_orderdetail");
		} else if ("reback".equalsIgnoreCase(redirectType)) {
			mv.setViewName("/duyun/ticket_reback");
		}
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * ###################页面跳转controller结束#####################################
	 */

	/**
	 * ajax 业务请求
	 */
	@RequestMapping("doList")
	public void doList(HttpServletResponse response) {
		try {
			PageExtend page = new PageExtend();
			PageData pd = this.getPageData();
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> scenicList = scenicService.selectScenicTicketByPage(page);
			page.setResultPd(scenicList);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 门票详情
	 * 
	 * @param response
	 */
	@RequestMapping("doDetail")
	public void doDetail(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			pd.put("scenic_id", pd.getAsString("t_id"));
			TicketListData ticketDataList = ticketService.selectEntityTicket(pd);
			/**
			 * 请求票务接口 获取门票信息
			 */
			for (TicketCateData tempCateData : ticketDataList.getTicketCates()) {
				for (Iterator<TicketData> it = tempCateData.getTickets().iterator(); it.hasNext();) {
					TicketData tempTicket = it.next();
					if (StringUtils.isNotEmpty(tempTicket.getThirdNo())) {
						// 如果第三方票务公司的标识为不为空则请求 否则则删除
						try {
							String thirdJson = com.easaa.scenicspot.assembly.TicketService.getTicketTypes(null, null,
									tempTicket.getThirdNo());
							JSONObject jsonObj = JSONObject.fromObject(thirdJson);
							jsonObj = JSONObject.fromObject(jsonObj.getString("ResponseBody"));
							JSONArray jsonAry = JSONArray.fromObject(jsonObj.get("TicketTypeList"));
							jsonObj = JSONObject.fromObject(jsonAry.get(0));
							// 设置票务信息
							tempTicket.setBeginSaleTime(jsonObj.getString("BeginSaleTime"));
							tempTicket.setEndSaleTime(jsonObj.getString("EndSaleTime"));
							tempTicket.setBeginValidTime(jsonObj.getString("BeginValidTime"));
							tempTicket.setEndValidTime(jsonObj.getString("EndValidTime"));
							tempTicket.setMarketPrice(Double.parseDouble(jsonObj.getString("MarketPrice")));
							tempTicket.setRetailPrice(Double.parseDouble(jsonObj.getString("RetailPrice")));
							tempTicket.setSettlementPrice(Double.parseDouble(jsonObj.getString("SettlementPrice")));
							tempTicket.setStock(EAString.stringToInt(jsonObj.getString("Stock"), 0));
							tempTicket.setMinBuyCount(EAString.stringToInt(jsonObj.getString("MinBuyCount"), 0));
							tempTicket.setMaxBuyCount(EAString.stringToInt(jsonObj.getString("MaxBuyCount"), 0));
							tempTicket
									.setAdvanceBookDays(EAString.stringToInt(jsonObj.getString("AdvanceBookDays"), 0));
							tempTicket.setPaymentMethod(EAString.stringToInt(jsonObj.getString("PaymentMethod"), 1));
							tempTicket.setRealName(jsonObj.getBoolean("IsRealName"));
							tempTicket.setLastBookTime(jsonObj.getString("LastBookTime"));
							tempTicket
									.setIdCardLimitDays(EAString.stringToInt(jsonObj.getString("IdCardLimitDays"), 0));
							tempTicket.setIdCardLimitCount(
									EAString.stringToInt(jsonObj.getString("IdCardLimitCount"), 0));
						} catch (Exception e) {
							it.remove();
						}
					} else {
						// 当前票在票务公司不存在 则删除
						it.remove();
					}
				}
			}
			this.outJson(REQUEST_SUCCESS, "请求成功", ticketDataList, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * 票务日期列表 逻辑较多 monthParam 当前查询的月份 yearParam 当前查询的年份 ticketTypeId查询的票务id
	 * endSaleTime 结束销售时间 beginSaleTime 开始销售时间
	 */
	@RequestMapping("dodateList")
	public void ticketDateList(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			String beginSaleTime = pd.getString("beginSaleTime");
			String endSaleTime = pd.getString("endSaleTime");
			String ticketTypeId = pd.getString("ticketTypeId");
			String monthParam = pd.getString("monthParam");
			String yearParam = pd.getString("yearParam");
			Date startParamDate, endParamDate;
			String disabledMinMonth = "", disabledMinYear = "", disabledMaxMonth = "", disabledMaxYear = "";
			Date currentDate = new Date();
			Date beginSaleDate = EADate.stringToDate(beginSaleTime);
			Date endSaleDate = EADate.stringToDate(endSaleTime);
			if (currentDate.getTime() < beginSaleDate.getTime()) {
				disabledMinMonth = EADate.getMonth(beginSaleDate) + "";
				disabledMinYear = EADate.getYear(beginSaleDate);
			} else {
				disabledMinMonth = EADate.getMonth(currentDate) + "";
				disabledMinYear = EADate.getYear(currentDate);
			}
			disabledMaxMonth = EADate.getMonth(endSaleDate) + "";
			disabledMaxYear = EADate.getYear(endSaleDate);
			// 客户选择的日期
			Date selectDate = EADate.getContentYearMonthDay(yearParam, monthParam, "01");
			if (selectDate.getTime() > beginSaleDate.getTime()) {
				/**
				 * 如果选择日期当月第一天 大于 开始售票日期 则将开始查询条件指向 选择日期的当月第一天
				 */
				startParamDate = selectDate;
			} else {
				/**
				 * 选择日期当月的第一天 小于 开始售票日期 则将查询条件 指向开始售票日期
				 * 
				 */
				startParamDate = beginSaleDate;
			}

			Date selectLastDate = EADate.getLastDate(startParamDate);
			if (selectLastDate.getTime() > endSaleDate.getTime()) {
				/**
				 * 如果选择的日期当月的最后一天大于 结束卖票的时间 将查询条件绑定
				 */
				endParamDate = endSaleDate;
			} else {
				/**
				 * 如果选择的日期当月的最后一天小于 结束卖票的时间 将查询条件绑定 选择日期当月的第一天
				 */
				endParamDate = selectLastDate;
			}
			/**
			 * 重置选择条件的年和月 将选择查询条件的年和月指向参数的 当前年月
			 */
			yearParam = EADate.getYear(startParamDate);
			monthParam = EADate.getMonth(startParamDate) + "";
			// 获取票务金额数据
			String dateListJson = com.easaa.scenicspot.assembly.TicketService.getTicketDailyPrice(
					EADate.getFormatTime(startParamDate, "yyyy-MM-dd HH:mm:ss"),
					EADate.getFormatTime(endParamDate, "yyyy-MM-dd HH:mm:ss"), ticketTypeId);
			JSONObject jsonObject = JSONObject.fromObject(dateListJson);
			String body = jsonObject.getString("ResponseBody");
			JSONArray retList = JSONArray.fromObject(body);
			TicketPriceData ticketPData = new TicketPriceData();
			ticketPData.setDisabledMaxMonth(disabledMaxMonth);
			ticketPData.setDisabledMinMonth(disabledMinMonth);
			ticketPData.setMonthParam(monthParam);
			ticketPData.setYearParam(yearParam);
			ticketPData.setJsonData(retList);
			ticketPData.setDisabledMaxYear(disabledMaxYear);
			ticketPData.setDisabledMinYear(disabledMinYear);
			this.outJson(REQUEST_SUCCESS, "计算成功", ticketPData, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "日期计算错误，请联系管理员", null, response);
		}
	}

	@RequestMapping("doticketorder")
	public void doticketorder(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			PageData ticketDataList = ticketService.getById(pd.getAsInt("ticketId"));
			if (EAUtil.isNotEmpty(ticketDataList)) {
				String ticketThirdNo = ticketDataList.getString("third_no");
				String thirdJson = com.easaa.scenicspot.assembly.TicketService.getTicketTypes(null, null,
						ticketThirdNo);
				JSONObject jsonObj = JSONObject.fromObject(thirdJson);
				jsonObj = JSONObject.fromObject(jsonObj.getString("ResponseBody"));
				JSONArray jsonAry = JSONArray.fromObject(jsonObj.get("TicketTypeList"));
				jsonObj = JSONObject.fromObject(jsonAry.get(0));
				ticketDataList.put("datedetail", jsonObj);
				ticketDataList.put("user_id", getUserIdFromSession(request));
			}
			this.outJson(REQUEST_SUCCESS, "请求成功", ticketDataList, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	
	/**
	 * 提交票务订单
	 * 
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("doSubmitOrder")
	public void doSubmitOrder(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			String paramStr = pd.getAsString("paramStr");
			System.out.println(paramStr);
			JSONObject paramObj = JSONObject.fromObject(paramStr);
			JSONArray ticketInfos = paramObj.getJSONArray("ticketInfo");
            String contactName = paramObj.getString("ContactName");
            String contactMobile = paramObj.getString("ContactMobile");
            String contactEmail = paramObj.getString("ContactEmail");
            String userId = getUserIdFromSession(request);
            /**
             * 创建总订单
             */
            PageData totalParam = new PageData();
            String orderSn = EAString.getFourSn()+"PW-ZDD";
            totalParam.put("order_sn", orderSn);
            totalParam.put("order_money", paramObj.get("totalMoney"));
            totalParam.put("create_time", EADate.getCurrentTime());
            totalParam.put("pay_status", 0);
            totalParam.put("pay_type", 2);
            totalParam.put("user_id",userId );
            ticketOrderService.insertAllOrder(totalParam);
			for(int i = 0 ; i < ticketInfos.size() ; i++){
				JSONObject jsonItem = ticketInfos.getJSONObject(i);
				jsonItem.put("ContactName", contactName);
				jsonItem.put("ContactMobile", contactMobile);
				jsonItem.put("ContactEmail", contactEmail);
				jsonItem.put("to_all_id", totalParam.getAsString("a_id"));
				jsonItem.put("user_id", userId);
				/**
				 * 创建分订单
				 */
				ticketOrderService.createOrder(jsonItem, request);
			}
			System.out.println(pd.getAsString("paramStr"));
			this.outJson(REQUEST_SUCCESS, "请求成功", totalParam, response);
		}catch(Exception e){
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", e.getMessage(), response);
		}
	}
	
	
	// 获取用户id
	private String getUserIdFromSession(HttpServletRequest request) {
		String user_id = "-2";
		PageData user = getUser(request);
		if (user != null) {
			user_id = user.getAsString("user_id");
		}
		return user_id;
	}

	private PageData getUser(HttpServletRequest request) {
		PageData pd = new PageData();
//		pd.put("user_id", 217);
		pd.put("open_id", this.getSessionAttribute(request, "open_id"));
		PageData user = userService.getOneByMap(pd);
		if (user != null) {
			return user;
		}
		return null;
	}
}
