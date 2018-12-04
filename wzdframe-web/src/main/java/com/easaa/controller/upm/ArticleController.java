package com.easaa.controller.upm;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

import net.sf.json.JSONArray;

import com.easaa.core.util.EAString;
import com.easaa.core.util.EADate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.article.service.ArticleService;

@Controller
@RequestMapping("/sys/article/article/")
public class ArticleController extends BaseController{
	
	@Autowired
	private ArticleService  articleService;
	
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList=articleService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("article/communityList");
		return mv;
	}
	
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd = articleService.getById(EAString.stringToInt(pd.getString("id"), 0));
		String content = pd.getString("content");
		//sting2json
		pd.put("content", JSONArray.fromObject(content));
		mv.addObject("dataModel", pd);
		if(getRequest().getParameter("judge")!=null&&"1".equals(getRequest().getParameter("judge"))){
			mv.setViewName("article/artileInfo");
		}else
		mv.setViewName("article/artileEdit");
		return mv;
	}
	@RequestMapping(value = "add")
	public ModelAndView add() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("article/artileAdd");
		return mv;
	}
	@RequestMapping(value = "save")
	public void save(HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		PageData data=this.getPageData();
		data.put("create_time", EADate.getCurrentTime());
		data.put("creator", getAdminName());
		data.put("content", getRequest().getParameter("content"));
		data.put("cover_drawing", getRequest().getParameter("cover_drawing"));
		if(data.getAsString("article_id")!=null&&!"".equals(data.getAsString("article_id")))
			articleService.edit(data);
		else{
			data.remove("article_id");
			articleService.create(data);
		}
		if(data==null||data.isEmpty()){
			mv.setViewName("common/error");
		}
		this.outJson(response, REQUEST_SUCCESS, "", mv);
	}
}