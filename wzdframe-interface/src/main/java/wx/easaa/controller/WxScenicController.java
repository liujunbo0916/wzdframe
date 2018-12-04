package wx.easaa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpUtils;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.user.service.UserService;
import com.easaa.wechat.common.WechatUtil;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

/**
 * 
 * 
 * 
 * 
 * 
 * @author liujunbo
 *
 */



@Controller
@RequestMapping("/wx/scenic/")
public class WxScenicController  extends BaseController{

	
	@Autowired
	private ScenicService scenicService;
	
	@Autowired
	private UserService userService;
	
	
	
	@RequestMapping("wzgk")
	public ModelAndView wzgk(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		pd.put("category_id", "-2");
		List<PageData> scenicList = scenicService.getByMap(pd);
		if(scenicList != null && scenicList.size() > 0){
			pd = scenicList.get(0);
			PageData dataModel = scenicService.scenicDetail(pd);
			dataModel.put("scenic_click", pd.getAsInteger("scenic_click")+1);
			scenicService.edit(dataModel);
			mv.addObject("dataModel",dataModel);
		}else{
			mv.addObject("dataModel",null);
		}
		mv.setViewName("/wechat/weizougk");
		return mv;
	}
	/**
	 * 景点首页
	 */
	@RequestMapping("index")
	public ModelAndView scenicIndex(){
		ModelAndView mv = this.getModelAndView();
		//查询类目
		PageData pd = this.getPageData();
		pd.put("scenic_status", 1);
		List<PageData> categoryList = scenicService.categorySelectByMap(pd);
		//查询第一个类目的内容
		if(StringUtils.isEmpty(pd.getAsString("category_id")) 
				&& categoryList != null && categoryList.size() > 0){
			PageData contentPd  = new PageData();
			contentPd.put("category_id", categoryList.get(0).getAsString("id"));
			pd.put("category_id", categoryList.get(0).getAsString("id"));
			mv.addObject("contentList", scenicService.getByMap(contentPd));
		}else{
			mv.addObject("contentList", scenicService.getByMap(pd));
		}
		mv.addObject("category",categoryList);
		mv.addObject("pd", pd);
		mv.setViewName("/wechat/scenic_index");
		return mv;
	}
	/**
	 * 所有景点  
	 */
	@RequestMapping("allScenic")
	public  void allScenic(HttpServletResponse response){
		try {
			PageData pd = this.getPageData();
			pd.put("category_scenic_status", "1");
			pd.put("scenic_status", "1");
			List<PageData> scenics = scenicService.getByMap(pd);
			PageData waitPd = null; 
			for(PageData tpd : scenics){
				if("-2".equals(tpd.getAsString("category_id"))){
					waitPd = tpd;
				}else{
					if(StringUtils.isNotEmpty(tpd.getAsString("scenic_voice_hour"))){
						int  hour = EAString.stringToInt(tpd.getAsString("scenic_voice_hour"), 0);
						if(StringUtils.isNotEmpty(tpd.getAsString("scenic_tip_source_hour"))){
							hour +=	EAString.stringToInt(tpd.getAsString("scenic_tip_source_hour"), 0);
						}
						//将hour转成  分秒形式
						int sec = hour % 60;
						int min = hour / 60;
						String minStr = StringUtils.leftPad(min+"",2, "0");
						String secStr = StringUtils.leftPad(sec+"",2, "0");
						tpd.put("voice_hour",  minStr+":"+secStr);
					}
				}
			}
			if(waitPd != null){
				scenics.remove(waitPd);
			}
			super.outJson(super.REQUEST_SUCCESS, "查询成功",scenics , response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "查询失败", null, response);
		}
	}
	/**
	 * 自助导览 请求景点的详情
	 */
	@RequestMapping("ajaxSimpleScenic")
	public void ajaxSimpleScenic(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			scenicService.findScenicByLngLat(pd);
		/*	if(detail != null){
				if(StringUtils.isNotEmpty(detail.getAsString("scenic_voice_hour"))){
					int  hour = EAString.stringToInt(detail.getAsString("scenic_voice_hour"), 0);
					//将hour转成  分秒形式
					int sec = hour % 60;
					int min = hour / 60;
					String minStr = StringUtils.leftPad(min+"",2, "0");
					String secStr = StringUtils.leftPad(sec+"",2, "0");
					detail.put("voice_hour",  minStr+":"+secStr);
				}
				super.outJson(super.REQUEST_SUCCESS, "查询成功", detail, response);
			}else{
				super.outJson(super.REQUEST_SUCCESS, "查询成功", null, response);
			}*/
			super.outJson(super.REQUEST_SUCCESS, "请求成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "查询失败", null, response);
		}
	}
	/**
	 * 关注列表
	 */
	@RequestMapping("collectList")
	public ModelAndView collectList(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		//查询类目
		PageData pd = this.getPageData();
		pd.put("scenic_status", 1);
		List<PageData> categoryList = scenicService.categorySelectByMap(pd);
		pd.put("user_id", getUserIdFromSession(request));
		//查询第一个类目的内容
		if(StringUtils.isEmpty(pd.getAsString("category_id")) 
				&& categoryList != null && categoryList.size() > 0){
			PageData contentPd  = new PageData();
			contentPd.put("category_id", categoryList.get(0).getAsString("id"));
			pd.put("category_id", categoryList.get(0).getAsString("id"));
			mv.addObject("contentList", scenicService.collectList(contentPd));
		}else{
			mv.addObject("contentList", scenicService.collectList(pd));
		}
		mv.addObject("category",categoryList);
		mv.addObject("pd", pd);
		mv.setViewName("/wechat/collectList");
		return mv;
	}
	/**
	 * 景点详情
	 */
	@RequestMapping("detail")
	public ModelAndView scenicDetail(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		PageData dataModel = scenicService.scenicDetail(pd);
		try{
			dataModel.getAsPageData("detail").put("scenic_click", dataModel.getAsPageData("detail").getAsInteger("scenic_click")+1);
			scenicService.edit(dataModel.getAsPageData("detail"));
		}catch(Exception e){
		}
		mv.addObject("dataModel",dataModel);
		mv.addObject("pd", pd);
		mv.setViewName("/wechat/scenic_detail");
		putShareApi("/wx/scenic/detail", pd, mv, false);
		return mv;
	}
	/**
	 * 添加景点评论
	 * @param request
	 * @return
	 */
	@RequestMapping("addComment")
	public void addComment(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			PageData userPd = getUser(request);
			pd.put("comment_author_logo", userPd.getAsString("headimgurl"));
			pd.put("comment_author", userPd.getAsString("nick_name"));
			if(StringUtils.isNotEmpty(userPd.getAsString("user_id"))){
				pd.put("user_id", userPd.getAsString("user_id"));
				scenicService.addComment(pd);
			}
			super.outJson(super.REQUEST_SUCCESS, "添加成功", pd, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "操作失败", null, response);
		}
	}
	
	@RequestMapping("praise")
	public void praise(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			String user_id = getUserIdFromSession(request);
			if(StringUtils.isNotEmpty(user_id)){
				pd.put("user_id", user_id);
				scenicService.praise(pd);
			}
			super.outJson(super.REQUEST_SUCCESS, "添加成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "操作失败", null, response);
		}
	}
	/**
	 * 收藏
	 */
	@RequestMapping("collect")
	public void collect(HttpServletRequest request,HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			String user_id = getUserIdFromSession(request);
			if(StringUtils.isNotEmpty(user_id) && !"-2".equals(user_id)){
				pd.put("user_id", user_id);
				pd.put("create_time", EADate.getCurrentTime());
				scenicService.insertCollect(pd);
			}
			super.outJson(super.REQUEST_SUCCESS, "添加成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "操作失败", null, response);
		}
	}
	/**
	 * 讲解列表  查询所有 带有音频的 景点  按照距离远近的排序
	 * 参数
	 * 当前lat lng 经纬度
	 * @param request
	 * @return
	 */
	@RequestMapping("explainList")
	public ModelAndView explainList(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if("choose".equalsIgnoreCase(pd.getAsString("type"))){
			mv.setViewName("/wechat/chooseScenic");
		}else{
			mv.setViewName("/wechat/jingjieliebiao");
		}
		mv.addObject("dataModel", scenicService.explainList(pd));
		return mv;
	}
	
	/**
	 * 
	 * 景点导航
	 * 
	 * @param request
	 * @return
	 * 腾讯地图开发者key Z4XBZ-EYHK6-3ORSJ-MH7QW-DLX25-KPB3F
	 * 
	 */
	@RequestMapping("navigation")
	public ModelAndView navigation(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("/wechat/navigation");
		mv.addObject("pd", pd);
		putShareApi("/wx/scenic/navigation", pd, mv, false);
		return mv;
	}
	/**
	 * 腾讯经纬度地址转换成 百度的地址经纬度
	 * @param request
	 * @return
	 */
/*	@RequestMapping("translate")
	public void translate(HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			JSONObject jsonObject = WechatUtil.translateLatLngYanue(pd.getAsString("lat"),pd.getAsString("lng"));
			super.outJson(super.REQUEST_SUCCESS, "转换成功", jsonObject, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "转换失败", null, response);
		}
		// http://apis.map.qq.com/ws/coord/v1/translate?type=3&locations=22.542405,113.979479&key=Z4XBZ-EYHK6-3ORSJ-MH7QW-DLX25-KPB3F
	}*/
	
	
	
	
	
	
	private String getUserIdFromSession(HttpServletRequest request){
		String user_id = "-2";
		PageData user = getUser(request);
		if(user != null){
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
