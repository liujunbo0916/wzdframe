package wx.easaa.controller.duyun;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentService;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/home")
public class WxHomeController extends BaseController {

	@Autowired
	private ContentService contentService;
	@Autowired
	private UserService userService;
	@Autowired
	private GroupTourService groupTourService;
	/**
	 * ##########################页面跳转集合########################## 无逻辑操作
	 * 跳转页面需要的控制器
	 */
	/**
	 * 首页
	 * @param request
	 * @return
	 * /wx/home/duyunhome
	 */
	@RequestMapping(value={"duyunhome","","index"})
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/duyun/duyunhome");
		return mv;
	}
	/**
	 * ##########################页面跳转集合结束##########################
	 * 
	 */
	/**
	 * ##########################Ajax请求逻辑集合##########################
	 * ajax请求的方法前面加上do
	 */
	

	// ajax请求商品详情数据
	@RequestMapping("doDetail")
	public void doDetail(HttpServletResponse response, HttpServletRequest request) {
		PageData pd = this.getPageData();
		try {
			PageData data= new PageData();
			pd.put("STATE", 1);
			//实时资讯
			pd.put("CTYPE", "0");
			pd.put("limit", 2);
			data.put("news", contentService.topLimit(pd));
			//旅游资讯
			pd.put("CTYPE", 1);
			pd.put("limit", 4);
			data.put("tourism", contentService.topLimit(pd));
			//猜你喜欢
			pd.put("limit", 2);
			data.put("grouptour", groupTourService.getByMap(pd));
			data.put("prefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", data, response);
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
