package pc.easaa.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentService;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EASMS;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.MD5;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsCartService;
import com.easaa.goods.service.GoodsService;
import com.easaa.loader.SEOLoader;
import com.easaa.order.service.OrderService;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.StoreInfo;
import com.easaa.scenicspot.entity.ticket.TicketOrder;
import com.easaa.scenicspot.entity.ticket.Traveler;
import com.easaa.scenicspot.service.ShopService;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.HotelService;
import com.easaa.scenicspot.service.ScenicLineService;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.SystemConfireService;
import com.easaa.scenicspot.service.TicketOrderService;
import com.easaa.upm.service.WebsiteService;
import com.easaa.user.service.UserService;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

/**
 * 内容管理
 *  文章 咨询 
 *  网站信息
 *  管理
 * 
 * 
 * @author liujunbo
 *
 */
@Controller
public class PcContentRedirectController extends BaseController{

	@Autowired
	private ContentService contentService;
	
	@Autowired
	private ScenicLineService scenicLineService;
	
	@Autowired
	private ScenicService scenicService;
	
	
	@Autowired
	private UserService userService;
	
	
	@Autowired
	private ShopService businessService;
	
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private TicketOrderService ticketOrderService;
	
	
	@Autowired
	private OrderService orderService;
	
	
	@Autowired
	private GroupTourService groupTourService;
	
	
	@Autowired
	private SystemConfireService systemConfireService;
	
	@Autowired
	private WebsiteService websiteService;

	@Autowired
	private SEOLoader seoUtil;
	
	//用户登陆
	@RequestMapping("doLogin")
	public void doLogin(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		String userName = pd.getAsString("username");
		String password = MD5.md5(pd.getAsString("password"));
		pd.put("KEYDATA", userName+",ea,"+password);
		try {
			userService.doLogin(pd, request);
			super.outJson(super.REQUEST_SUCCESS, "登陆成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	//用户登陆
	@RequestMapping("doLoginByCode")
	public void doLoginByCode(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		try {
			userService.doLoginByCode(pd, request);
			super.outJson(REQUEST_SUCCESS, "登陆成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}
	
	
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("param", pd);
		mv.setViewName("/pc/login.min");
		mv.addObject("pageType", "login");
		//生成pc授权登陆的链接
		//mv.addObject("pcAuth", WechatUtil.getPcAuthorUrl(PropertiesHelper.getWechatUrl()+"/wx/loginCallBack"));
		return mv;
	}
	@RequestMapping("logout")
	public ModelAndView logout(HttpServletRequest reServletRequest){
		ModelAndView mv = this.getModelAndView();
		reServletRequest.getSession().removeAttribute("userInfo");
		mv.setViewName("redirect:/");
		return mv;
	}
	
	//用户注册
	@RequestMapping("register")
	public ModelAndView register(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/pc/register");
		mv.addObject("pageType", "login");
		return mv;
	}
	/**
	 * 用户注册 （设备ID、手机号码、验证码、密码）
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/userRegedit")
	public void userRegedit(HttpServletResponse response,HttpServletRequest request) throws Exception {
		PageData para = this.getPageData();
		String phone = para.getAsString("phone");
		// 请求数据校验
		if (EAUtil.isEmpty(phone)) {
			this.outJson(PARAM_ERROR, "请输入正确的手机号!", null, response);
			return;
		}
		String code = para.getAsString("smsCode");
		Object serverCode =  getSessionAttribute(request, "smsCode");
		if (EAUtil.isEmpty(serverCode)) {
			this.outJson(PARAM_ERROR, "验证码已过期!", null, response);
			return;
		}
		if (!serverCode.toString().equalsIgnoreCase(code)) {
			this.outJson(PARAM_ERROR, "验证码不正确!", null, response);
			return;
		}
		// 数据库校验
		PageData pd = new PageData();
		pd.put("phone", para.get("phone"));
		PageData user = userService.getOneByMap(pd);
		if (EAUtil.isNotEmpty(user)) {
			this.outJson(REQUEST_FAILS, "注册失败,手机号码已存在", null, response);
			return;
		}
		// 插入用户
		user = new PageData();
		user.put("phone", para.get("phone"));
		user.put("user_name",  para.get("phone"));
		user.put("nick_name", para.get("phone"));// 注册时使用用户名作为别名
		user.put("password", MD5.md5(para.get("password").toString()));
		user.put("register_channel", "2");
		user.put("register_time", EADate.getCurrentTime());
		user.put("user_money", "0");
		user.put("user_points", "0");
		user.put("is_validated", "0");
		user.put("status", 1);
		user.put("is_buyer", 1);
		user.put("is_loginer", "1");
		user.put("is_commenter", "1");
		user.put("user_type", "1");
		userService.createUser(user);
		/**
		 * 查询是否是老师
		 */
		this.outJson(REQUEST_SUCCESS, "注册成功", user, response);
	}
	//获取短信验证码
	@RequestMapping(value = "/sendCode")
	public void sendCode(String phone, String codetype, String user_id, HttpServletResponse response,HttpServletRequest reServletRequest) throws Exception {
		PageData pd = getPageData();
		pd.put("phone", phone);
		String code = EAString.getRandNumber();
		System.out.println(code);
		// 其他验证码
		if (EAUtil.isNotEmpty(codetype)) {
			reServletRequest.getSession().setAttribute("smsCode", code);
			//String str = EASMS.sendSms2(phone, code, "4");
			String tmpContent = systemConfireService.getSmsTplByCode("004").getAsString("tpl_content");
			tmpContent = tmpContent.replace("参数1", code);
			String str = EASMS.sendSms2(phone, tmpContent);
			if (str.equals("2")) {
				this.outJson(REQUEST_SUCCESS, "验证码已发送到手机",
						"{\"code\":\"" + code + "\",\"product\":\"秦汉影视城\"}", response);
			} else {
				this.outJson(REQUEST_FAILS, "短信验证有误，请联系管理员！", "", response);
				return;
			}
			//注册验证码
		} 
		this.outJson(REQUEST_SUCCESS, "发送成功", "", response);
	}
	//新闻列表
	@RequestMapping("/content/list")
	public ModelAndView contentList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="7")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("STATE", 2);
		page.setShowCount(pageSize);
		page.setCurrentPage(currentPage);
		page.setPd(pd);
		mv.setViewName("/pc/news.list");
		//查询头条 4
		PageData result = contentService.topNewsLimit(pd);
		pd.put("exclude", result.getAsString("exclude"));
		List<PageData> contentList =  contentService.selectByPutimePage(page);
		page.setResultPd(contentList);
		mv.addObject("page", page);
		mv.addObject("topContent", result.get("tops"));
		mv.addObject("pageType", "content");
		try{
			mv.addObject("SEO", seoUtil.getSeoCode("007"));
		}catch(Exception e){
		}
		return mv;
	}
	//新闻详情
	@RequestMapping("/content/detail")
	public ModelAndView contentDetail(String CONTENT_ID){
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", contentService.getById(CONTENT_ID));
		mv.setViewName("/pc/news.detail");
		mv.addObject("pageType", "content");
		return mv;
	}
	//攻略列表
	@RequestMapping("/guide/list")
	public ModelAndView guideList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="5")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setCurrentPage(currentPage);
		page.setShowCount(pageSize);
		page.setPd(pd);
		List<PageData> result = scenicLineService.selectByPcPage(page);
		page.setResultPd(result);
		mv.setViewName("/pc/strategy.list");
		mv.addObject("pageType", "guide");
		mv.addObject("page", page);
		try{
			mv.addObject("SEO", seoUtil.getSeoCode("007"));
		}catch(Exception e){
		}
		return mv;
	}
	//攻略详情 line_id 路线id
	@RequestMapping("/guide/detail")
	public ModelAndView guideDetail(Integer line_id){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("id", line_id);
		List<PageData> lines = scenicLineService.getByMap(pd);
		mv.addObject("lineDetail", lines.get(0));
		mv.addObject("dataModel", scenicLineService.selectScenicByLine(pd));
		mv.setViewName("/pc/strategy.detail");
		mv.addObject("pageType", "guide");
		return mv;
	}
	//景点列表
	@RequestMapping("/scenic/list")
	public ModelAndView scenicList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,@RequestParam(defaultValue="12")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setCurrentPage(currentPage);
		page.setShowCount(pageSize);
		page.setPd(pd);
		List<PageData> result = scenicService.selectByPcPage(page);
		page.setCurrentSize(result.size());
		page.setResultPd(result);
		mv.setViewName("/pc/scenic.list");
		mv.addObject("page", page);
		mv.addObject("pageType", "scenic");
		try{
			mv.addObject("SEO", seoUtil.getSeoCode("004"));
		}catch(Exception e){
		}
		return mv;
	}
	//景点详情
	@RequestMapping("/scenic/detail")
	public ModelAndView scenicDetail() throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		pd.put("id", paramObj.get("id"));
		List<PageData> scenicList = scenicService.getByMap(pd);
		mv.addObject("dataModel", scenicList.get(0));
		mv.setViewName("/pc/scenic.detail");
		mv.addObject("pageType", "scenic");
		return mv;
	}
	//店铺列表
	@RequestMapping("/store/list")
	public ModelAndView storeList(PageExtend page,HttpServletRequest request,
			@RequestParam(defaultValue = "1")Integer currentPage,
			@RequestParam(defaultValue="9")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setShowCount(pageSize);
		page.setCurrentPage(currentPage);
		page.setPd(pd);
		List<StoreInfo> result = businessService.businessInfoByPage(page);
		mv.addObject("page", page);
		mv.addObject("dataModel", result);
		mv.setViewName("/pc/store.list");
		mv.addObject("pageType", "store");
		try{
			mv.addObject("SEO", seoUtil.getSeoCode("008"));
		}catch(Exception e){
		}
		return mv;
	}
	//店铺详情
	@RequestMapping("/store/detail")
	public ModelAndView storeDetail() throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		mv.addObject("dataModel", businessService.getById(EAString.stringToInt(paramObj.getString("bs_id"), 0)));
		/**
		 * 查询商品列表
		 */
		pd.put("bs_id", paramObj.get("bs_id"));
		pd.put("limit", 9);
		List<PageData> goodsList = goodsService.getByMap(pd);
		int currentSize = goodsList.size();
		if(currentSize > 0){
			currentSize = currentSize -1;
		}
		mv.addObject("currentSize", currentSize / 3);
		mv.addObject("goodsList", goodsList);
		mv.setViewName("/pc/store.detail");
		mv.addObject("pageType", "store");
		return mv;
	}
	/**
	 * 酒店列列表
	 */
	@RequestMapping("/hotel/list")
	public ModelAndView hotelList(PageExtend page,HttpServletRequest request,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="12")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("hotel_state", "1"); // 是否上架
		// 销量降序
		page.setApp(true);
		page.setCurrentPage(currentPage);
		page.setShowCount(15);
		page.setPd(pd);
		List<PageData> hotelList = hotelService.selectByListPage(page);
		page.setCurrentSize(hotelList.size());
		page.setResultPd(hotelList);
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		mv.setViewName("/pc/hotel.list");
		try{
			mv.addObject("SEO", seoUtil.getSeoCode("005"));
		}catch(Exception e){
		}
		return mv;
	}
	/**
	 * 商品订单列表
	 * 
	 */
	@RequestMapping("/order/list")
	public ModelAndView orderList(PageExtend page,HttpServletRequest request,@RequestParam(defaultValue="1")Integer currentPage,@RequestParam(defaultValue="5")Integer pageSize){
		ModelAndView mv = this.getModelAndView();
		PageData pd  = this.getPageData();
		page.setCurrentPage(currentPage);
		page.setShowCount(pageSize);
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		page.setPd(pd);
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
		}else{
			pd.put("user_id", userPd.getAsString("user_id"));
			pd.put("is_delete", "0");
			page.setPd(pd);
			List<PageData> listHistory = orderService.selectHistory(page);
			for (int i = 0; i < listHistory.size(); i++) {
				
				//如果是未支付的订单
				if("0".equals(listHistory.get(i).getAsString("order_status"))){
					String createTime = listHistory.get(i).getAsString("create_time");
					//得到1小时之后的时间
					long oneHourAfter  = EADate.getAfterDate(EADate.stringToDate(createTime), 2, 1).getTime();
					if(new Date().getTime() > oneHourAfter){
						listHistory.get(i).put("order_status", 9);
					}
				}
			}
			page.setResultPd(listHistory);
			mv.setViewName("/pc/order.product.list");
			mv.addObject("page", page);
		}
		mv.addObject("pd", pd);
		return mv;
	}
	/***
	 * 商品订单详情
	 */
	@RequestMapping("/order/detail")
	public ModelAndView orderDetail(){
		ModelAndView mv = this.getModelAndView();
		PageData pd  = this.getPageData();
		mv.addObject("data", orderService.selectDetails(pd));
		mv.setViewName("/pc/order.product.detail");
		return mv;
	}
	/**
	 * 跟团订单
	 * 
	 * 
	 */
	@RequestMapping("/order/travel/list")
	public ModelAndView grouptourOrderList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="9")Integer pageSize,HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
		}else{
			pd.put("user_id", userPd.getAsString("user_id"));
			page.setApp(true);
			page.setCurrentPage(currentPage);
			page.setShowCount(pageSize);
			page.setPd(pd);
			List<GroupTourOrder> groupOrders = groupTourService.selectEntityByPage(page);
			mv.addObject("dataModel", groupOrders);
			mv.addObject("page", page);
			mv.setViewName("/pc/order.travel.list");
		}
		return mv;
	}
	/**
	 * 跟团订单详情
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/order/travel/detail")
	public ModelAndView grouptourOrderDetail(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
		}else{
			JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
			pd.put("order_id", paramObj.get("order_id"));
			GroupTourOrder groupOrder = groupTourService.selectOrderEntity(pd);
			if(groupOrder != null){
			   mv.addObject("dataModel", groupOrder);	
			}
			mv.setViewName("/pc/order.travel.detail");
		}	
		return mv;
	}
	/**
	 * 旅游订单申请退款
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/order/traval/refund")
	public ModelAndView grouptourRefund() throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		pd.put("order_id", paramObj.get("order_id"));
		GroupTourOrder groupOrder = groupTourService.selectOrderEntity(pd);
		if(groupOrder != null ){
			List<Traveler> travelers = groupOrder.getTraveler();
			int showSize =  travelers.size();
			int showRow = showSize/2;
			if(showSize % 2 != 0){
				showRow++;
			}
			mv.addObject("showRow", showRow);
		    mv.addObject("orderInfo",groupOrder);	
		}
		mv.setViewName("/pc/travel.refund");
		return mv;
	}
	/**
	 * 旅游订单退款列表
	 */
	@RequestMapping("/order/travel/refundList")
	public ModelAndView refundList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setCurrentPage(currentPage);
		page.setShowCount(9);
		page.setPd(pd);
		PageData userPd =  request.getSession().getAttribute("userInfo") == null 
				? new PageData()
				: (PageData)request.getSession().getAttribute("userInfo");
		if(StringUtils.isEmpty(userPd.getAsString("user_id"))){
			mv.setViewName("redirect:/login");
			return mv;
		}		
		pd.put("user_id",userPd.getAsString("user_id"));
		List<PageData> dataModel = groupTourService.selectTravelRefundByPage(page);
		mv.addObject("dataModel", dataModel);
		mv.addObject("page", page);
		mv.setViewName("/pc/order.travel.refund");
		return mv;
	}
	/**
	 * 门票订单
	 */
	@RequestMapping("/order/ticket/list")
	public ModelAndView ticketOrderList(PageExtend page,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="5")Integer pageSize,
			HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
		}else{
			pd.put("user_id", userPd.getAsString("user_id"));
			page.setShowCount(pageSize);
			page.setCurrentPage(currentPage);
			page.setPd(pd);
			List<TicketOrder> ticketOrders = ticketOrderService.selectEntityByPage(page);
			mv.addObject("dataModel", ticketOrders);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.setViewName("/pc/order.ticket.list");
		}
		return mv;
	}
	
	/**
	 * 门票订单详情
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/order/ticket/detail")
	public ModelAndView ticketOrderDetail(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
			return mv;
		}		
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		PageData orderInfo = ticketOrderService.getById(EAString.stringToInt(paramObj.getString("id"), 0));
		orderInfo.put("order_id", orderInfo.getAsString("id"));
		List<PageData>  traverInfo = ticketOrderService.selectTicketCodeInfo(orderInfo);
		int showSize =  traverInfo.size();
		int showRow = showSize/2;
		if(showSize % 2 != 0){
			showRow++;
		}
		int noUse= 0 ,alUse = 0,refundN = 0;
		if("1".equals(orderInfo.getAsString("to_is_realname"))){
			for(PageData tpd : traverInfo){
				noUse += EAString.stringToInt(tpd.getAsString("quantity"), 0) 
				- EAString.stringToInt(tpd.getAsString("used_quantity"), 0)
				- EAString.stringToInt(tpd.getAsString("refund_quantity"), 0);
				alUse += EAString.stringToInt(tpd.getAsString("used_quantity"), 0);
				refundN += EAString.stringToInt(tpd.getAsString("refund_quantity"), 0);
			}
		}else{
			PageData ticketCode = traverInfo.get(0);
			alUse = EAString.stringToInt(ticketCode.getAsString("used_quantity"), 0);
			refundN = EAString.stringToInt(ticketCode.getAsString("refund_quantity"), 0);
			noUse = EAString.stringToInt(ticketCode.getAsString("quantity"), 0) - alUse - refundN;
		}
		orderInfo.put("noUseTicket", noUse<0?0:noUse);
		orderInfo.put("refundTicket", refundN<0?0:refundN);
		orderInfo.put("alUseTicket", alUse<0?0:alUse);
		mv.addObject("showRow", showRow);
		mv.addObject("orderInfo", orderInfo);
		mv.addObject("traverInfo", traverInfo);
		mv.setViewName("/pc/order.ticket.detail");
		return mv;
	}
	/**
	 * 跳转退票页面
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/ticket/refund")
	public ModelAndView ticketRefund(HttpServletRequest request) throws UnsupportedEncodingException{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
			return mv;
		}	
		JSONObject paramObj = JSONObject.fromObject(new String(Base64.decode(pd.getAsString("paramStr")),"utf-8"));
		String orderId = paramObj.getString("id");
		PageData orderInfo = ticketOrderService.getById(EAString.stringToInt(orderId, 0));
		orderInfo.put("order_id", orderInfo.getAsString("id"));
		List<PageData>  traverInfo = ticketOrderService.selectTicketCodeInfo(orderInfo);
		mv.addObject("orderInfo", orderInfo);
		if(!"1".equals(orderInfo.getAsString("to_is_realname"))){
			int noUse = EAString.stringToInt(traverInfo.get(0).getAsString("quantity"), 0) -
					EAString.stringToInt(traverInfo.get(0).getAsString("used_quantity"), 0) - 
					EAString.stringToInt(traverInfo.get(0).getAsString("refund_quantity"), 0) - 
					EAString.stringToInt(traverInfo.get(0).getAsString("apply_refund_quantity"), 0)
					;
			orderInfo.put("no_use_quantity", noUse<0?0:noUse);
		}
		int showSize =  traverInfo.size();
		int showRow = showSize/2;
		if(showSize % 2 != 0){
			showRow++;
		}
		mv.addObject("showRow", showRow);
		mv.addObject("traverInfo", traverInfo);
		//查询票号列表
		mv.setViewName("/pc/ticket.refund");
		return mv;
	}
	/**
	 * 退票单
	 */
	@RequestMapping("/ticket/refund/order")
	public ModelAndView ticketRefundOrder(HttpServletResponse response,HttpServletRequest request
			,@RequestParam(defaultValue="1")Integer currentPage,
			@RequestParam(defaultValue="9")Integer pageSize,PageExtend page){
		ModelAndView mv = this.getModelAndView();
		PageData userPd = getSessionAttribute(request, "userInfo") == null 
				? new PageData() : (PageData)getSessionAttribute(request, "userInfo");
		if(userPd.get("user_id") == null){
			mv.setViewName("redirect:/login");
			return mv;
		}	
		page.setCurrentPage(currentPage);
		page.setShowCount(pageSize);
		PageData param = this.getPageData();
		page.setPd(param);
		List<PageData> resultPd = ticketOrderService.selectRefundByPage(page);
		page.setResultPd(resultPd);
		mv.addObject("dataModel",page);
		mv.setViewName("/pc/order.refund.ticket");
		return mv;
	}
	/**
	 * 网站信息跳转
	 */
	@RequestMapping("/companyInfo")
	public ModelAndView companyInfo(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		List<PageData>  pds = websiteService.getByMap(pd);
		if(pds != null && pds.size() > 0){
			mv.addObject("dataModel", pds.get(0));
		}
		mv.setViewName("/pc/website/companyPro");
		return mv;
	}
}
