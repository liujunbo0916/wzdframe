package logic.easaa.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.easaa.loader.SEOLoader;
import wx.easaa.controller.comm.BaseController;

/**
 * 
 * 内部接口供后台调用
 * 
 * @author liujunbo
 */
@Controller
@RequestMapping("/api/internal/")
public class InternalInterface extends BaseController {
	@Autowired
	private SEOLoader seoUtil;
	/**
	 * 清空seo 缓存数据
	 */
	@RequestMapping("/clearSeo")
	public void clearSeo(HttpServletResponse response) {
		try {
			seoUtil.clear();
			super.outJson(REQUEST_SUCCESS, "操作成功", "", response);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, "操作失败", null, response);
		}
	}
}
