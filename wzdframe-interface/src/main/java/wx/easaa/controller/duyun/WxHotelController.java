package wx.easaa.controller.duyun;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.service.HotelService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;
/**
 * 酒店控制器
 * @author ryy
 */
@Controller
@RequestMapping("/wx/hotel/")
public class WxHotelController extends BaseController{
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private UserService userService;
	/**
	 * 酒店列表
	 * @param request
	 * @return
	 */
	@RequestMapping("hotellist")
	public ModelAndView list(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("duyun/hotel");
		putShareApi("/wx/hotel/duyun/hotel", this.getPageData(), mv, false);
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
			pd.put("hotel_state", "1"); // 是否上架
			// 销量降序
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(15);
			page.setPd(pd);
			List<PageData> hotelList = hotelService.selectByListPage(page);
			page.setResultPd(hotelList);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
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
		pd.put("open_id", this.getSessionAttribute(request, "open_id"));
		PageData user = userService.getOneByMap(pd);
		if (user != null) {
			return user;
		}
		return null;
	}
}
