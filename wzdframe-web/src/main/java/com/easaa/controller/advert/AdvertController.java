package com.easaa.controller.advert;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.AdvertService;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.course.service.CourseService;
import com.easaa.course.service.SubjectService;
import com.easaa.course.service.TeacherLibService;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.entity.Seller;
import com.easaa.scenicspot.service.GroupTourService;
import com.easaa.scenicspot.service.ScenicService;

@Controller
@RequestMapping("/sys/advert")
public class AdvertController extends BaseController {

	@Autowired
	private AdvertService advertService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	@Autowired
	private TeacherLibService teacherLibService;
	@Autowired
	private GroupTourService groupTourService;
	@Autowired
	private ScenicService scenicService;
	
	/**
	 * 广告位置列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "positionlist", "" })
	public ModelAndView positionlist(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.addObject("advplist", advertService.advertpositionlist(pd));
			mv.setViewName("advert/advertposition_list");
		} catch (Exception e) {
		}
		return mv;
	}

	/**
	 * 广告位置编辑添加跳转界面
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "editposition", "" })
	public ModelAndView editposition(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (EAUtil.isNotEmpty(pd.getAsString("ap_id"))) {
				List<PageData> advplist = advertService.advertpositionlist(pd);
				if (advplist != null && advplist.size() > 0) {
					mv.addObject("advplist", advplist.get(0));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("advert/advertposition_edit");
		return mv;
	}

	/**
	 * 添加广告位置
	 * 
	 * @param page
	 * @return
	 */
	@MethodLog(remark="添加广告位置")
	@RequestMapping(value = { "addadvposition", "" })
	public void addadvposition(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			super.outJson(response, REQUEST_SUCCESS, "添加成功！", advertService.addadvertposition(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "添加失败！", e.getMessage());
		}
	}

	/**
	 * 编辑广告位置
	 * 
	 * @param page
	 * @return
	 */
	@MethodLog(remark="编辑广告位置")
	@RequestMapping(value = { "updateadvposition", "" })
	public void updateadvposition(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			super.outJson(response, REQUEST_SUCCESS, "修改成功", advertService.updateadvertposition(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "修改失败", e.getMessage());
		}
	}

	/**
	 * 删除广告位置
	 * 
	 * @param page
	 * @return
	 */
	@MethodLog(remark="删除广告位置")
	@RequestMapping(value = { "deladvposition", "" })
	public void deladvposition(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			super.outJson(response, REQUEST_SUCCESS, "删除成功", advertService.deladvertposition(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "修改失败", e.getMessage());
		}
	}

	/**
	 * 广告列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "desclist", "" })
	public ModelAndView desclist(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.addObject("advertlist", advertService.selectadvertlist(pd));
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("advert/advert_list");
		return mv;
	}

	/**
	 * 广告编辑添加跳转界面
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "editadvert", "" })
	public ModelAndView editadvert(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pramPd=new PageData();
		try {
			mv.addObject("advplist", advertService.advertpositionlist(pd));
			if (!pd.getAsString("ad_id").equals("0")) {
				PageData adv = advertService.getById(pd.getAsInt("ad_id"));
				if (EAUtil.isNotEmpty(adv)) {
					mv.addObject("dataModel", adv);
					// 广告关联商品
					if (adv.getAsInt("ad_relation_type") == 1) {
						pramPd.put("goods_id", adv.getAsInt("ad_relation_id"));
						mv.addObject("goods", goodsService.getOneByMap(pramPd));
					} else if (adv.getAsInt("ad_relation_type") == 2 || adv.getAsInt("ad_relation_type") == 4) {// 广告关联门票景点
						PageData pageData=scenicService.getById(adv.getAsInt("ad_relation_id"));
						if(EAUtil.isNotEmpty(pageData)){
							pramPd.put("id", pageData.getAsString("category_id"));
							List<PageData> data = scenicService.categorySelectByMap(pramPd);
							if (EAUtil.isNotEmpty(data) && data.size() > 0) {
								pageData.put("category_name", data.get(0).getAsString("scenic_category"));
							}
							mv.addObject("scenic", pageData);
						}
					}else if(adv.getAsInt("ad_relation_type") == 3){//跟团游
						PageData pageData=groupTourService.getById(adv.getAsInt("ad_relation_id"));
						mv.addObject("grouptour", pageData);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("advert/advert_edit");
		return mv;
	}

	/**
	 * 添加编辑广告
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "addadvert")
	public ModelAndView addadvert(@RequestParam(required=false,value = "ad_display") MultipartFile file, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = this.getModelAndView();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData pd = getPageData(multipartRequest);
		try {
			if (file != null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "mallframe", "product");
				pd.put("ad_display", savePath);
			}
			if (pd.getAsString("ad_type").equals("1")) {
				pd.put("ad_relation_type", "0");
				pd.put("ad_relation_id", "0");
			} else {
				if (pd.getAsString("ad_relation_type").equals("2") || pd.getAsString("ad_relation_type").equals("4")) {
					pd.put("ad_relation_id", pd.getAsString("ad_relation_scenic_id"));
				} else if (pd.getAsString("ad_relation_type").equals("1")) {
					pd.put("ad_relation_id", pd.getAsString("ad_relation_goods_id"));
				}else if(pd.getAsString("ad_relation_type").equals("3")){
					pd.put("ad_relation_id", pd.getAsString("ad_relation_grouptour_id"));
				}
			}
			if (EAUtil.isEmpty(pd.getAsString("ad_id"))) {
				pd.put("ad_create_time", EADate.getCurrentTime());
				advertService.create(pd);
			} else {
				String ad_relation_id = pd.getAsString("ad_relation_id");
				if (ad_relation_id.startsWith(",")) {
					pd.put("ad_relation_id", ad_relation_id.substring(0, ad_relation_id.length() - 1));
				}
				pd.put("ad_create_time", EADate.getCurrentTime());
				advertService.edit(pd);
			}
			pd = new PageData();
			mv.addObject("advertlist", advertService.selectadvertlist(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "操作失败！", e.getMessage());
		}
		mv.setViewName("advert/advert_list");
		return mv;
	}

	/**
	 * 删除广告
	 * 
	 * @param page
	 * @return
	 */
	@MethodLog(remark="删除广告位置")
	@RequestMapping(value = { "deladvert", "" })
	public void deladvert(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			super.outJson(response, REQUEST_SUCCESS, "删除成功", advertService.delete(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "修改失败", e.getMessage());
		}
	}

	/**
	 * 编辑广告商品跳转
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "advertgoods")
	public ModelAndView addadvertgoods(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData goodspd = new PageData();
		goodspd.put("is_delete", "0");
		goodspd.put("is_on_sale", "1");
		page.setPd(pd);
		page.setShowCount(5);
		mv.addObject("ad_relation_id", pd.getAsString("ad_relation_id"));
		mv.addObject("goodslist", goodsService.getByPage(page));
		mv.addObject("page", page);
		mv.setViewName("advert/goods_relation");
		return mv;
	}

	/**
	 * 拉取选中商品数据
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "pushGoodsByID", "" })
	public void pushGoodsByID(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			super.outJson(response, REQUEST_SUCCESS, "获取成功", goodsService.getOneByMap(pd));
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "获取失败", e.getMessage());
		}
	}

	/**
	 * 编辑广告门票跳转
	 * scenic_is_ticket 1 门票 0景点
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "advertTicket")
	public ModelAndView advertcourses(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData cpd = new PageData();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> list = scenicService.getByPage(page);
		for (PageData pageData : list) {
			cpd.put("id", pageData.getAsString("category_id"));
			List<PageData> data = scenicService.categorySelectByMap(cpd);
			if (EAUtil.isNotEmpty(data) && data.size() > 0) {
				pageData.put("category_name", data.get(0).getAsString("scenic_category"));
			}
		}
		mv.addObject("dataModel", list);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("advert/scenic_relation");
		return mv;
	}

	/**
	 * 拉取选中景点数据
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "pushScenicDataByID", "" })
	public void pushScenicDataByID(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			PageData pageData=scenicService.getById(pd.getAsInt("id"));
			if(EAUtil.isNotEmpty(pageData)){
				pd.put("id", pageData.getAsString("category_id"));
				List<PageData> data = scenicService.categorySelectByMap(pd);
				if (EAUtil.isNotEmpty(data) && data.size() > 0) {
					pageData.put("category_name", data.get(0).getAsString("scenic_category"));
				}
			}
			super.outJson(response, REQUEST_SUCCESS, "获取成功", pageData);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "获取失败", e.getMessage());
		}
	}
	
	/**
	 * 编辑广告跟团游跳转
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "advertGrouptour")
	public ModelAndView advertGrouptour(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("grouptour_state", "1");
		page.setPd(pd);
		List<PageData> hotelList = groupTourService.getByPage(page); // 列出Content列表
		mv.addObject("dataModel", hotelList);
		mv.addObject("pd", pd);
		mv.setViewName("advert/grouptour_relation");
		return mv;
	}
	
	/**
	 * 拉取选中跟团游数据
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "pushGrouptourByID", "" })
	public void pushGrouptourByID(HttpServletResponse response) {
		try {
			PageData pd = getPageData();
			PageData pageData=groupTourService.getById(pd.getAsInt("id"));
			super.outJson(response, REQUEST_SUCCESS, "获取成功", pageData);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "获取失败", e.getMessage());
		}
	}
	
	
}
