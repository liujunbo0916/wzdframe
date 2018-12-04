package wx.easaa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EADate;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.ScenicLineService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/line/")
public class WxScenicLineController extends BaseController{
	@Autowired
	private ScenicLineService scenicLineService;
	@Autowired
	private UserService userService;
	/**
	 * 攻略首页
	 */
	@RequestMapping("index")
	public ModelAndView index(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("line_status", 1);
		mv.addObject("dataModel", scenicLineService.getByMap(pd));
		mv.setViewName("/wechat/scenicLine");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 攻略详情
	 */
	@RequestMapping("detail")
	public ModelAndView detail(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("id", pd.getAsString("line_id"));
		mv.addObject("Details", scenicLineService.getByMap(pd).get(0));
		List<PageData> scenicList = scenicLineService.selectScenicByLine(pd);
		
		//查询是否点赞
		pd.put("user_id", getUserIdFromSession(request));
		boolean flag = scenicLineService.selectPraiseByUser(pd);
		mv.addObject("praiseF", flag);
		mv.addObject("dataModel", scenicList);
		mv.setViewName("/wechat/scenicLineDetail");
		mv.addObject("pd", pd);
		putShareApi("/wx/line/detail", pd, mv, false);
		return mv;
	}
	/**
	 * 自助导览
	 */
	@RequestMapping("selfHelp")
	public ModelAndView selfHelp(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.setViewName("/wechat/selfHelp");
		putShareApi("/wx/line/selfHelp", this.getPageData(), mv, false);
		return mv;
	}
	/**
	 * ajax拉取评论列表
	 */
	@RequestMapping("ajaxGetComment")
	public void ajaxGetComment(HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			pd.put("limit", 6);
			super.outJson(REQUEST_SUCCESS, "操作成功", scenicLineService.selectCommentByCondition(pd), response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, "操作成功", null, response);
		}
	}
	/**
	 * 添加评论
	 */
	@RequestMapping("addComment")
	public void addComment(HttpServletResponse response,HttpServletRequest request){
		try{
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("create_time", EADate.getCurrentTime());
			pd.put("show_status", "1");
			scenicLineService.insertComment(pd);
			super.outJson(REQUEST_SUCCESS, "操作成功", scenicLineService.selectCommentByCondition(pd), response);
		}catch(Exception e){
			super.outJson(REQUEST_FAILS, "操作失败", null, response);
			e.printStackTrace();
		}
	}
	/**
	 * 点赞
	 * @param request
	 * @return
	 */
	@RequestMapping("praise")
	public void praise(HttpServletRequest request,HttpServletResponse response){
		try{
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			scenicLineService.addPraise(pd);
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
		}catch(Exception e){
			super.outJson(REQUEST_FAILS, "操作失败", null, response);
			e.printStackTrace();
		}
	}
	//获取用户id
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
//		pd.put("user_id", 217);
		pd.put("open_id", this.getSessionAttribute(request, "open_id"));
		PageData user = userService.getOneByMap(pd);
		if (user != null) {
			return user;
		}
		return null;
	}
}
