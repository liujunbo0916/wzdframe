package wx.easaa.controller.duyun;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.Base64;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.Traveler;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.user.service.UserService;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

/**
 * 线路（跟团游）控制器
 * @author ryy
 */
@Controller
@RequestMapping("/wx/grouptour/")
public class WxGroupTourController extends BaseController{
	@Autowired
	private GroupTourService groupTourService;
	
	@Autowired
	private UserService userService;
	/**
	 * 跟团游列表
	 * @param request
	 * @return
	 * /wx/grouptour/index?resultType=orderList
	 */
	@RequestMapping("index")
	public ModelAndView list(HttpServletRequest request,String resultType){
		PageData pd=getPageData();
		ModelAndView mv = this.getModelAndView();
		if("list".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/grouptourList");
		}else if("detail".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/grouptourdetail");
			mv.addObject("user", getUser(request));
		}else if("confirmOrder".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/grouptour_confirm_order");
		}else if("orderList".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/grouptour_orderlist");
		}else if("orderDetail".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/grouptour_orderdetail");
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
			pd.put("grouptour_state", "1"); // 是否发布
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> hotelList = groupTourService.getByPage(page);
			page.setResultPd(hotelList);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 请求跟团游详情
	 * @param response
	 */
	@RequestMapping("dodetail")
	public void dodetail(HttpServletResponse response){
		PageData pd = this.getPageData();
		try {
			PageData detail = groupTourService.getById(pd.getAsInt("grouptour_id"));
			detail.put("grouptour_img", PROPERTIESHELPER.getValue("imageShowPath")+detail.getAsString("grouptour_img"));
			this.outJson(REQUEST_SUCCESS, "请求成功", detail, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	
	/**
	 * 跟团游确认订单
	 * @param response
	 */
	@RequestMapping("doconfirmOrder")
	public void doconfirmOrder(HttpServletResponse response,HttpServletRequest request){
		PageData pd = this.getPageData();
		try {
			//检测是否绑定手机
			PageData detail = groupTourService.getById(pd.getAsInt("grouptour_id"));
			detail.put("user_id", getUserIdFromSession(request));
			this.outJson(REQUEST_SUCCESS, "请求成功", detail, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	
	/**
	 * 跳转跟团游退票界面
	 * @throws  
	 */
	@RequestMapping("doGroupOrderRefund")
	public ModelAndView grouptourRefund(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
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
		mv.setViewName("/duyun/grouptour_refund");
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
