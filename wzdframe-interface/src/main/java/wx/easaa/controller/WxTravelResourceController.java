package wx.easaa.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentService;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.service.CultureService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/travel/")
public class WxTravelResourceController  extends BaseController{
	/**
	 * 特色文化首页
	 */
	@Autowired
	private CultureService cultureService;
	
	@Autowired
	private  ContentService contentService;
	
	@RequestMapping("index")
	public ModelAndView specialCulture(){
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("/wechat/culture_index");
		PageData pd = this.getPageData();
		pd.put("culture_category_status", 1);
		mv.addObject("dataModel", cultureService.categorySelectByMap(pd));
		return mv;
	}
	/**
	 * 资源列表
	 */
	@RequestMapping("resource/list")
	public ModelAndView resourceList(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
	    pd =  cultureService.categorySelectOneByMap(pd);
	    List<PageData> resouceList = null;
	    if(pd != null){
	    	if("3".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/wechat/xiangpianj");
	    		resouceList = encaResouceList(pd);
	    	}
	    	if("4".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/wechat/wzls");
	    		//如果是text类型去内容表里面查询相应类目的新闻
	    		PageData contentParam = new PageData();
	    		contentParam.put("CATEGORY_CODE", pd.getAsString("culture_category_content"));
	    		contentParam.put("STATE", 1);
	    		resouceList = contentService.getByMap(contentParam);
	    	}
	    	if("2".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/wechat/gequxs");
	    		resouceList = encaResouceList(pd);
	    	}
	    	if("1".equalsIgnoreCase(pd.getAsString("culture_category_type"))){
	    		mv.setViewName("/wechat/shipingxs");
	    		resouceList = encaResouceList(pd);
	    	}
	    }
	    mv.addObject("albumModel", resouceList);
	    mv.addObject("dataModel", pd);
	    return mv;
	}
	private List<PageData> encaResouceList(PageData pd){
	    PageData cultureParam = new PageData();
	    cultureParam.put("category_id", pd.getAsString("id"));
	    List<PageData> resouceList = cultureService.getByMap(cultureParam);
	    /**
	     * 将音视频里面的时间 将秒转成分秒
	     */
	    for (int i = 0; i < resouceList.size(); i++) {
			if(StringUtils.isNotEmpty(resouceList.get(i).getAsString("resource_hour"))){
				int  hour = EAString.stringToInt(resouceList.get(i).getAsString("resource_hour"), 0);
				//将hour转成  分秒形式
				int sec = hour % 60;
				int min = hour / 60;
				String minStr = StringUtils.leftPad(min+"",2, "0");
				String secStr = StringUtils.leftPad(sec+"",2, "0");
				resouceList.get(i).put("resource_hour_format", minStr+":"+secStr);
			}
		}
	    return resouceList;
	}
	/**
	 * 视频播放页面
	 * @return
	 */
	@RequestMapping("/resource/player")
	public ModelAndView autoPlayVideo(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(StringUtils.isNotEmpty(pd.getAsString("id"))){
			mv.addObject("dataModel", cultureService.getOneByMap(pd));
		}
		mv.setViewName("/wechat/player");
		return mv;
	}
	
}
