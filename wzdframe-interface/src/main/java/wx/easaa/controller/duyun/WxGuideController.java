package wx.easaa.controller.duyun;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.service.AgencyService;
import com.easaa.scenicspot.service.GuiderService;
import com.easaa.scenicspot.service.SiteSetService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

/**
 *	导游铺控制器
 * @author ryy
 */
@Controller
@RequestMapping("/wx/guider/")
public class WxGuideController extends BaseController{
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AgencyService agencyService;
	
	@Autowired
	private GuiderService guiderService;
	
	@Autowired
	private SiteSetService siteSetService;
	
	private static String prefixImg=PROPERTIESHELPER.getValue("imageShowPath");
	/**
	 * 导游列表
	 * @param request
	 * @return
	 * /wx/guider/index?resultType=list
	 */
	@RequestMapping("index")
	public ModelAndView list(HttpServletRequest request,String resultType){
		PageData pd=getPageData();
		ModelAndView mv = this.getModelAndView();
		if("list".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/guiderList");
		}else if("detail".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/guiderDetail");
		}
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * ##########################Ajax请求逻辑集合##########################
	 * ajax请求的方法前面加上do
	 */
	//ajax分页请求列表数据
	@RequestMapping("doList")
	public void doList(HttpServletResponse response){
	    PageExtend page = new PageExtend();
		PageData pd = this.getPageData();
		try {
			pd.put("guider_disabled", "1"); // 是否可用
			pd.put("order", "1"); // null 不排序  
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> guiderList = agencyService.selectGuiderByListPage(page);
			page.setResultPd(guiderList);
			page.setPrefixImg(prefixImg);
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	
		// ajax请求商品详情数据
		@RequestMapping("doDetail")
		public void doDetail(HttpServletResponse response, HttpServletRequest request) {
			PageData pd = this.getPageData();
			try {
				PageData storeData = agencyService.selectGuiderById(EAString.stringToInt(pd.getAsString("guiderId"), 0));
				storeData.put("PrefixImg", prefixImg);
				this.outJson(REQUEST_SUCCESS, "请求成功", storeData, response);
			} catch (Exception e) {
				e.printStackTrace();
				this.outJson(REQUEST_FAILS, "请求失败", null, response);
			}
		}
		
		// 导游服务订单填写页面
		@RequestMapping("guideServiceOrder")
		public ModelAndView guideServiceOrder() {
			ModelAndView mv = this.getModelAndView();
			PageData pd=getPageData();
			mv.addObject("bookKnow", siteSetService.selectAll().getAsString("book_know"));
			PageData agency=agencyService.selectGuiderById(EAString.stringToInt(pd.getAsString("guiderId"), 0));
			mv.addObject("prefixImg", prefixImg);
			mv.addObject("agency", agency);
			mv.setViewName("/duyun/guiderComfirmorder");
			return mv;
		}
		
		// 预约服务订单提交
		@RequestMapping("bookOrderSub")
		public void bookOrderSub(HttpServletRequest request, HttpServletResponse response) {
			try {
				PageData pd = this.getPageData();
				pd.put("order_sn", EAString.getFourSn());
				pd.put("user_id", getUserIdFromSession(request));
				pd.put("create_time", EADate.getCurrentTime());
				pd.put("guide_status", "0");
				pd.put("pay_status", "0");
				guiderService.create(pd);
				super.outJson(REQUEST_SUCCESS, "操作成功", pd, response);
			} catch (Exception e) {
				e.printStackTrace();
				super.outJson(REQUEST_FAILS, "网络异常", null, response);
			}
		}

		// 预约服务订单提交
		@RequestMapping("bookOrder")
		public ModelAndView bookOrder(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mv = this.getModelAndView();
			Page page = this.getPage();
			PageData pd = this.getPageData();
			page.setPd(pd);
			pd.put("user_id", getUserIdFromSession(request));
			mv.setViewName("/duyun/guiderOrder");
			mv.addObject("dataModel", guiderService.getByPage(page));
			return mv;
		}
		// 预约服务订单提交
		@RequestMapping("bookOrderDetail")
		public ModelAndView bookOrderDetail(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mv = this.getModelAndView();
			PageData pd = this.getPageData();
			mv.addObject("dataModel", guiderService.getById(EAString.stringToInt(pd.getAsString("id"), 0)));
			mv.addObject("bookKnow", siteSetService.selectAll().getAsString("book_know"));
			mv.addObject("prefixImg", prefixImg);
			mv.setViewName("/duyun/guiderOrderDetail");
			return mv;
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
