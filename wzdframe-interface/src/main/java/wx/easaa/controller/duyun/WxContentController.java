package wx.easaa.controller.duyun;

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
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

/**
 * 资讯控制器
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/wx/content/")
public class WxContentController extends BaseController {
	@Autowired
	private ContentService contentService;
	@Autowired
	private UserService userService;
	@Autowired
	private ContentCommentService contentCommentService;
	/**
	 * 资讯列表
	 * /wx/content/list?CATEGORY_CODE=FYmKw
	 * @param request
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest request) {
		PageData pd=getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("duyun/content_list");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * ##########################Ajax请求逻辑集合##########################
	 * ajax请求的方法前面加上do
	 */
	// ajax分页请求列表数据
	@RequestMapping("doList")
	public void doList(HttpServletResponse response) {
		PageExtend page = new PageExtend();
		PageData pd = this.getPageData();
		try {
			pd.put("STATE", "1");
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> dataList = contentService.selectAllByPage(page);
			page.setResultPd(dataList);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 新闻详情
	 * CONENT_ID 新闻id
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("dodetail")
	public ModelAndView detail(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		PageData details = contentService.contentDetails(pd);
       if(StringUtils.isNotEmpty(pd.getAsString("type"))){
    	   mv.setViewName("wechat/lsdetail");
		}else{
			mv.setViewName("duyun/contentDetail");
		}
       	if(EAUtil.isNotEmpty(details)){
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
		pd.put("content_id", details.getAsString("CONTENT_ID"));
		pd.remove("user_id");
		List<PageData> comments = contentCommentService.getByMap(pd);
		for(PageData tpd : comments){
			tpd.put("comment_context_time", EADate.getMMDD(tpd.getAsString("comment_context_time")));
		}
		mv.addObject("comment",comments);
       	}
       	mv.addObject("pd", pd);
		putShareApi("/wx/content/dodetail", pd, mv, false);
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
