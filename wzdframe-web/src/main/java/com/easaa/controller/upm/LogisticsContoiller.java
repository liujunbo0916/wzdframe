package com.easaa.controller.upm;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.entity.Logistics;
import com.easaa.upm.service.LogisticsService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 物流管理
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/logistics/")
public class LogisticsContoiller extends BaseController {

	@Resource(name = "logisticsService")
	LogisticsService logisticsService;

	/**
	 * 显示物流列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView logisticslist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		//区域物流列表
		List<Logistics> areaList = logisticsService.selectArea();
		mv.addObject("areaList", areaList);
		mv.setViewName("system/logistics/logistics_list");
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 区域列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/arealist")
	public ModelAndView arealist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		List<Logistics> areaList = logisticsService.selectArea();
		mv.setViewName("system/logistics/area_list");
		mv.addObject("areaList", areaList);
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}

	/**
	 * 区域设置跳转
	 * 
	 * @param page
	 * @return
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setarea")
	public ModelAndView setarea(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 查出所有省份列表
		List<PageData> plist = logisticsService.getProvince(pd);
		List<PageData> areadata = logisticsService.selectAreaByID(pd);
		mv.setViewName("system/logistics/area_edit");
		mv.addObject("plist", plist);
		if ( EAUtil.isNotEmpty(pd.getAsString("area_id")) && areadata != null && areadata.size() > 0) {
			String[] pstr = areadata.get(0).getAsString("province_id").split(",");
			areadata.get(0).put("provinces", Arrays.asList(pstr));
			mv.addObject("areadata", areadata.get(0));
		}
		return mv;
	}

	/**
	 * 保存区域设置
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savearea")
	public void savearea(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.setArea(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 删除区域设置
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delarea")
	public void delarea(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.delArea(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, super.REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 编辑区域设置
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatearea")
	public void updatearea(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.updateArea(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "修改成功", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}
	/**
	 * 续重添加跳转
	 * @param page
	 * @return
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setcontnuheavy")
	public ModelAndView setcontnuheavy(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pda= new PageData();
		PageData pd = this.getPageData();
		
		List<PageData> arealist = logisticsService.selectArea(pda);
		mv.addObject("arealist", arealist);
		
		List<PageData> chlist = logisticsService.selectContnuheavyById(pd);
		if (chlist!=null && chlist.size()>0 ) {
			mv.addObject("contnuheavy", chlist.get(0));
		}
		mv.setViewName("system/logistics/contnuheavy_edit");
		return mv;
	}
	
	
	
	/**
	 * 续重列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chlist")
	public ModelAndView chlist(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		List<PageData> chlist = logisticsService.selectContnuheavy(pd);
		mv.addObject("chlist", chlist);
		mv.setViewName("system/logistics/contnuheavy_list");
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	
	
	/**
	 * 续重添加
	 * @param page
	 * @return
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savecontnuheavy")
	public void addcontnuheavy(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.addcontnuheavy(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	
	/**
	 * 删除续重
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delcontnuheavy")
	public void delcontnuheavy(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.deleteContnuheavy(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, super.REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}

	/**
	 * 编辑续重
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateContnuheavy")
	public void updateContnuheavy(HttpServletResponse response) throws Exception {
		try {
			PageData pd = this.getPageData();
			if (logisticsService.updateContnuheavy(pd)) {
				super.outJson(response, super.REQUEST_SUCCESS, "修改成功", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, e.getMessage(), null);
		}
	}
	
}
