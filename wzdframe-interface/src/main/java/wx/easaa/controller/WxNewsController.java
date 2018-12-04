package wx.easaa.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentCommentService;
import com.easaa.content.service.ContentService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/news/")
public class WxNewsController extends BaseController{

	@Autowired
	private ContentService contentService;
	
	@Autowired
	private ContentCommentService contentCommentService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		pd.put("limit", 1); //先限制成1条
		PageData result = contentService.topNewsLimit(pd);
		pd.put("exclude", result.getAsString("exclude"));
		List<PageData> contents = contentService.newsListPage(pd,true);
		result.put("news",contents);
		mv.addObject("dataModel", result);
		mv.setViewName("/wechat/news");
		return mv;
	}
	/**
	 * ajax 请求列表数据
	 * @return
	 */
	@RequestMapping("listAjax")
	public void listAjax(HttpServletResponse response,HttpServletRequest request){
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		try{
			super.outJson(super.REQUEST_SUCCESS, "查询成功", contentService.newsListPage(pd,true), response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, e.getMessage(), null, response);
		}
	}
	/**
	 * 新闻详情
	 * CONENT_ID 新闻id
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("detail")
	public ModelAndView detail(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		PageData details = contentService.contentDetails(pd);
       if(StringUtils.isNotEmpty(pd.getAsString("type"))){
    	   mv.setViewName("wechat/lsdetail");
		}else{
			mv.setViewName("wechat/newDetail");
		}
		/**
		 * 增加点击量
		 */
		details.put("CLICKS", EAString.stringToInt(details.getAsString("CLICKS"), 0) + 1);
		contentService.edit(details);
		mv.addObject("details", details);
		if (EAUtil.isNotEmpty(details.getAsString("CATEGORY_CODE"))) {
			List<PageData> contentList = contentService.recommendContent(details.getAsString("CATEGORY_CODE"));
			for (Iterator<PageData> it = contentList.iterator(); it.hasNext();) {
				PageData value = it.next();
				if (value.getAsString("CONTENT_ID").equals(pd.getAsString("CONTENT_ID"))) {
					it.remove();
				}
			}
			mv.addObject("recommends", contentList);
		}
		/**
		 * 查询评论
		 */
		pd.put("limit", 6);
		//pd.put("user_id", getUserIdFromSession(request));
		pd.put("content_id", details.getAsString("CONTENT_ID"));
		pd.remove("user_id");
		List<PageData> comments = contentCommentService.getByMap(pd);
		for(PageData tpd : comments){
			tpd.put("comment_context_time", EADate.getMMDD(tpd.getAsString("comment_context_time")));
		}
		mv.addObject("comment",comments);
		putShareApi("/wx/news/detail", pd, mv, false);
		return mv;
	}
	/**
	 * 新闻点赞
	 * 每一个人只能点一次赞
	 */
	@RequestMapping("thumbsup")
	public void thumbsup(HttpServletResponse response,HttpServletRequest request){
		try {
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("content_id", pd.getAsString("CONTENT_ID"));
			contentService.givethumbsUp(pd);
			super.outJson(super.REQUEST_SUCCESS, "点赞成功",null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, e.getMessage(), null, response);
		}
	}
	
	/**
	 * 商品评论
	 */
	@RequestMapping("comments")
	public void comments(HttpServletResponse response,HttpServletRequest request){
		try {
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("content_id", pd.getAsString("CONTENT_ID"));
			// 根据用户id查询用户信息
			PageData user =getUser(request);
			if (EAUtil.isNotEmpty(user)) {
				pd.put("comment_author_logo",user.getAsString("headimgurl") );
				pd.put("comment_author", user.getAsString("nick_name"));
			} else {
				this.outJson(REQUEST_FAILS, "评论回复失败！", "用户不存在啊", response);
				return;
			}
			pd.put("comment_context_time", EADate.getCurrentTime());
			pd.put("show_time", EADate.getMMDD(pd.getAsString("comment_context_time")));
			contentService.contentComment(pd);
			super.outJson(super.REQUEST_SUCCESS, "评论成功",pd, response);
		} catch (Exception e) {
			super.outJson(super.REQUEST_FAILS, e.getMessage(), null, response);
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
