package wx.easaa.controller.duyun;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.easaa.content.service.AdvertService;
import com.easaa.core.util.EADate;
import com.easaa.entity.PageData;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/advert/")
public class WxAdvertController extends BaseController {

	@Autowired
	private AdvertService advertService;

	/**
	 * 广告列表
	 * ad_apid 广告位置ID
	 */
	@RequestMapping(value = "/selectadvertlist")
	public void selectContentlist(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			pd.put("datetime", EADate.getCurrentTime());
			List<PageData>	datalist=advertService.selectadvertlist(pd);
			pd.put("datalist", datalist);
			pd.put("prefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "查询成功！", pd, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 广告位置
	 */
	@RequestMapping(value = "/advertpositionlist")
	public void selectadvertpositionlist(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			this.outJson(REQUEST_SUCCESS, "查询成功！", advertService.advertpositionlist(pd), response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 广告浏览
	 */
	@RequestMapping(value = "/advertbrowse")
	public void advertbrowse(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			this.outJson(REQUEST_SUCCESS, "查询成功！", advertService.advertbrowse(pd), response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
