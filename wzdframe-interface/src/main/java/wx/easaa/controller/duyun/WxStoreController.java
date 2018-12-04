package wx.easaa.controller.duyun;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsService;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.service.ShopService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

/**
 * 特产店铺控制器
 * @author ryy
 */
@Controller
@RequestMapping("/wx/store/")
public class WxStoreController extends BaseController{
	@Autowired
	private ShopService businessService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GoodsService goodsService;
	/**
	 * 跟团游列表
	 * @param request
	 * @return
	 * /wx/store/index?resultType=list
	 */
	@RequestMapping("index")
	public ModelAndView list(HttpServletRequest request,String resultType){
		PageData pd=getPageData();
		ModelAndView mv = this.getModelAndView();
		if("list".equals(pd.getAsString("resultType"))){
			putShareApi("/wx/store/duyun/storeList", this.getPageData(), mv, false);
			mv.setViewName("duyun/storeList");
		}else if("detail".equals(pd.getAsString("resultType"))){
			mv.setViewName("duyun/storeDetail");
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
			pd.put("bs_state", "1"); // 是否发布
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> hotelList = businessService.selectByListPage(page);
			page.setResultPd(hotelList);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	
		// ajax请求商品详情数据
		@RequestMapping("doDetail")
		public void doDetail(HttpServletResponse response, HttpServletRequest request) {
			Page page= getPage();
			PageData pd = this.getPageData();
			try {
				PageData storeData = businessService.getById(EAString.stringToInt(pd.getAsString("storeId"), 0));
				storeData.put("PrefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
				//商品
				pd.put("is_delete", "0"); // 是否删除
				pd.put("is_on_sale", "1"); // 是否上架
				pd.put("bs_id", pd.getAsString("storeId")); //门店id
				page.setApp(true);
				page.setCurrentPage(1);
				page.setShowCount(5);
				page.setPd(pd);
				List<PageData> goodList = goodsService.selectGoodsList(page);
				storeData.put("goodList", goodList);
				this.outJson(REQUEST_SUCCESS, "请求成功", storeData, response);
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
