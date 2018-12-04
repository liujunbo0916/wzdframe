package wx.easaa.controller;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentCommentService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.MD5;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.GuideSerMapper;
import com.easaa.scenicspot.service.ScenicLineService;
import com.easaa.scenicspot.service.ScenicService;
import com.easaa.scenicspot.service.SiteSetService;
import com.easaa.user.service.UserService;
import com.easaa.wechat.common.WechatUtil;

import wx.easaa.controller.comm.BaseController;

/**
 * 个人中心
 * @author liujunbo
 */
@RequestMapping("/wx/user/")
@Controller
public class WxYUserController extends BaseController {

	@Autowired
	private SiteSetService siteSetService;

	@Autowired
	private UserService userService;

	@Autowired
	private GuideSerMapper guideSerMapper;
	
	@Autowired
	private ScenicService scenicService;
	
	@Autowired
	private ContentCommentService contentCommentService;
	
	@Autowired
	private ScenicLineService scenicLineService;
	
	// 安全须知
	@RequestMapping("safeKonw")
	public ModelAndView safeKonw() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/safeKnow");
		mv.addObject("dataModel", siteSetService.selectAll());
		return mv;
	}
	// 关于我们
	@RequestMapping("aboutUs")
	public ModelAndView aboutUs() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/about_us");
		mv.addObject("dataModel", siteSetService.selectAll());
		return mv;
	}
	// 个人中心
	@RequestMapping("userCenter")
	public ModelAndView userCenter(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/gr-center");
		return mv;
	}

	// 导游服务
	@RequestMapping("guideService")
	public ModelAndView guideService() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/guideService");
		return mv;
	}

	// 导游服务订单填写页面
	@RequestMapping("guideServiceOrder")
	public ModelAndView guideServiceOrder() {
		ModelAndView mv = this.getModelAndView();
		mv.addObject("bookKnow", siteSetService.selectAll().getAsString("book_know"));
		mv.addObject("pd", this.getPageData());
		mv.setViewName("/wechat/guideApply");
		return mv;
	}
	
	/**
	 * 预定服务
	 * @param request
	 * @return
	 */
	@RequestMapping("bookService")
	public ModelAndView bookService() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/book-service");
		return mv;
	}

	// 预约服务订单提交
	@RequestMapping("bookOrderSub")
	public void bookOrderSub(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("create_time", EADate.getCurrentTime());
			pd.put("guide_status", "1");
			guideSerMapper.insert(pd);
			super.outJson(REQUEST_SUCCESS, "操作成功", null, response);
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
		mv.setViewName("/wechat/myOrder");
		mv.addObject("dataModel", guideSerMapper.selectByMap(page));
		return mv;
	}
	// 预约服务订单提交
	@RequestMapping("bookOrderDetail")
	public ModelAndView bookOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("dataModel", guideSerMapper.selectByMap(page).get(0));
		mv.addObject("bookKnow", siteSetService.selectAll().getAsString("book_know"));
		mv.setViewName("/wechat/guideOrderDetail");
		return mv;
	}
	// 我的反馈列表
	@RequestMapping("feedbackList")
	public ModelAndView feedbackList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		List<PageData> feedBacks = guideSerMapper.feedbackList(pd);
		for (PageData tempPd:feedBacks) {
			String imgs = tempPd.getAsString("imgs");
			if(imgs.indexOf(",") != -1){
				tempPd.put("first_img", imgs.substring(0, imgs.indexOf(",")));
			}else{
				tempPd.put("first_img", imgs);
			}
			String createTime =tempPd.getAsString("create_time");
			if(StringUtils.isNotEmpty(createTime)){
				createTime = tempPd.getAsString("create_time").split("\\ ")[0];
			}
			tempPd.put("create_time", createTime);
		}
		mv.addObject("dataModel", feedBacks);
		mv.setViewName("/wechat/wode-tous");
		return mv;
	}
	// 添加反馈页面
	@RequestMapping("addFeedbackPage")
	public ModelAndView addFeedbackPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("/wechat/baoxiu");
		putShareApi("/wx/user/addFeedbackPage", pd, mv, false);
		return mv;
	}
	
	// 添加反馈提交
	@RequestMapping("addFeedback")
	public void addFeedback(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("create_time", EADate.getCurrentTime());
			String mediaIds = pd.getAsString("serverIds");
			String[] mediaAry = mediaIds.split("\\,");
			StringBuffer sb = new StringBuffer();
			for(String s : mediaAry){
				String filePath = WechatUtil.getMediaInfo(s);
				sb.append(filePath+",");
			}
			pd.put("imgs", sb.substring(0, sb.length()-1));
			guideSerMapper.insertFeedBack(pd);
			super.outJson(super.REQUEST_SUCCESS, "操作成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(super.REQUEST_FAILS, "网络异常", null, response);
		}
	}
	/**
	 * 涠洲足记
	 * @param request
	 * @return
	 */
	@RequestMapping("fotoplace")
	public ModelAndView fotoplace(HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		mv.setViewName("/wechat/weizouzj");
		mv.addObject("dataModel", scenicService.fotoPlace(pd));
		return mv;
	}
	/**
	 * 用户评论
	 * @param request
	 * @return
	 */
	@RequestMapping("commentList")
	public ModelAndView commentList(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			if("scenic_index".equalsIgnoreCase(pd.getAsString("type"))){
				mv.addObject("dataModel", scenicService.commentList(pd));
			}else if("news_detail".equalsIgnoreCase(pd.getAsString("type"))){
				List<PageData> commentList = contentCommentService.getByMap(pd);
				for (PageData pageData : commentList) {
					pageData.put("headimgurl", pageData.getAsString("comment_author_logo"));
					pageData.put("scenic_comment_content", pageData.getAsString("comment_context"));
					pageData.put("nick_name", pageData.getAsString("comment_author"));
					pageData.put("comment_time", EADate.getMMDD(pageData.getAsString("comment_context_time")));
				}
				mv.addObject("dataModel", commentList);
			}else if("scenic_line".equalsIgnoreCase(pd.getAsString("type"))){
				mv.addObject("dataModel",scenicLineService.commentList(pd));
			}
			mv.setViewName("/wechat/comment");
			mv.addObject("pd", pd);
		}catch(Exception e){
			e.printStackTrace();
		}
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
	public static void main(String[] args) {
		System.out.println(MD5.md5("111111"));
		
	}
}
