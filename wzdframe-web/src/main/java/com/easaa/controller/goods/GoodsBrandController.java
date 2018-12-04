package com.easaa.controller.goods;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.Tools;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsBrandService;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/goodsBrand/")
public class GoodsBrandController extends BaseController {
	@Autowired
	private GoodsBrandService goodsBrandService;

	@Autowired
	private GoodsCategoryService goodsCategoryService;

	@Autowired
	private GoodsService goodsService;

	/**
	 * @description 品牌列表
	 * @author chenlt
	 * @createDate 2016-07-20
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("bs_id", "0");
		page.setPd(pd);

		if (StringUtils.isNotEmpty(pd.getAsString("category2_id"))) {
			pd.put("parent_id", pd.getAsString("category1_id"));
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category2List", goodsCategoryService.getByMap(pd));
		}
		if (StringUtils.isNotEmpty(pd.getAsString("category3_id"))) {
			pd.put("parent_id", pd.getAsString("category2_id"));
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category3List", goodsCategoryService.getByMap(pd));
		}
		List<PageData> varList = goodsBrandService.getByPage(page);
		String brand_category = "";
		for (PageData pageData : varList) {
			PageData cpd = new PageData();
			if (StringUtils.isNotEmpty(pageData.getAsString("category1_id"))
					&& !"-1".equals(pageData.getAsString("category1_id"))) {
				cpd.put("category_id", pageData.getAsString("category1_id"));
				PageData model = goodsCategoryService.getOneByMap(cpd);
				if (EAUtil.isNotEmpty(model)) {
					brand_category = model.getAsString("category_name");
				}
				if (StringUtils.isNotEmpty(pageData.getAsString("category2_id"))
						&& !"-1".equals(pageData.getAsString("category2_id"))) {
					cpd.put("category_id", pageData.getAsString("category2_id"));
					PageData model2 = goodsCategoryService.getOneByMap(cpd);
					if (EAUtil.isNotEmpty(model2)) {
						brand_category += ">" + model2.getAsString("category_name");
					}
					if (StringUtils.isNotEmpty(pageData.getAsString("category3_id"))
							&& !"-1".equals(pageData.getAsString("category3_id"))) {
						cpd.put("category_id", pageData.getAsString("category3_id"));
						PageData model3 = goodsCategoryService.getOneByMap(cpd);
						if (EAUtil.isNotEmpty(model3)) {
							brand_category += ">" + model3.getAsString("category_name");
						}
					}
				}
				pageData.put("brand_category", brand_category);
			}
		}
		pd.put("parent_id", "0");
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("goods/goodsBrand/goodsBrandList");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * @description 品牌编辑
	 * @author chenlt
	 * @createDate 2016-07-20
	 * @return
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String type = getRequest().getParameter("type");
		String id = getRequest().getParameter("id");
		/**
		 * 一级分类的列表
		 */
		PageData brand = goodsBrandService.getById(EAString.stringToInt(id, 0));
		PageData categoryPd = new PageData();
		categoryPd.put("parent_id", "0");
		mv.addObject("category1List", goodsCategoryService.getByMap(categoryPd));
		if (StringUtils.isNotEmpty(id)) {
			if (brand.getAsInteger("category1_id") == null) {
				categoryPd.put("parent_id", "-1");
			} else {
				categoryPd.put("parent_id", brand.getAsInteger("category1_id"));
			}
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category2List", goodsCategoryService.getByMap(categoryPd));

			if (brand.getAsInteger("category2_id") == null) {
				categoryPd.put("parent_id", "-1");
			} else {
				categoryPd.put("parent_id", brand.getAsInteger("category2_id"));
			}
			/**
			 * 三级分类的列表
			 */
			mv.addObject("category3List", goodsCategoryService.getByMap(categoryPd));
		}
		mv.addObject("dataModel", brand);

		if (EAUtil.isNotEmpty(type) && type.equals("1")) {
			mv.setViewName("shops/band/bsbandedit");
		} else {
			mv.setViewName("goods/goodsBrand/goodsBrandEdit");
		}
		return mv;
	}

	/**
	 * @description 品牌保存
	 * @author chenlt
	 * @createDate 2016-07-20
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	@MethodLog(remark="品牌保存")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam(required=false,value = "brand_icon") MultipartFile file, HttpServletRequest request)
			throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		if (data.getAsInt("brand_id") > 0) { // 如果主键brand_id值大于0,说明是编辑
			if (file!=null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "mallframe", "product");
				data.put("brand_icon", savePath);
			}
			Tools.replaceEmpty(data);
			goodsBrandService.edit(data);
		} else {
			// 主键brand_id值不大于0,新增
			String savePath = FtpUtil.upload(file, "mallframe", "product");
			data.put("brand_icon", savePath);
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			Tools.replaceEmpty(data);
			data.put("bs_id", "0");
			data.put("band_state", "2");
			goodsBrandService.create(data);
		}
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/goodsBrand/listPage");
		return mv;
	}

	/**
	 * 删除品牌
	 * 
	 * @param response
	 */
	@MethodLog(remark="品牌删除")
	@RequestMapping("delete")
	public void delete(HttpServletResponse response) {
		PageData pd = this.getPageData();
		/**
		 * 查询品牌有没有关联的商品
		 */
		List<PageData> goodslist = goodsService.selectByBandId(pd.getAsInt("brand_id"));
		if (goodslist != null && goodslist.size() > 0) {
			super.outJson(response, REQUEST_FAILS, "删除失败,该品牌有商品！请先删除商品！", null);
			return;
		}
		if (goodsBrandService.delete(pd) > 0) {
			super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
		} else {
			super.outJson(response, REQUEST_FAILS, "删除失败", null);
		}
	}

	/**
	 * 选择品牌
	 */
	@RequestMapping("selectBrand")
	public ModelAndView selectBrand(String brandIds) {
		ModelAndView mv = this.getModelAndView();
		mv.addObject("allBrand", goodsBrandService.selectByGroup(this.getPageData()));
		if (StringUtils.isNotEmpty(brandIds)) {
			mv.addObject("brandIds", brandIds.split(","));
		}
		mv.setViewName("goods/goodsType/selectBrand");
		return mv;
	}

	/**
	 * 返回所有品牌
	 */
	@RequestMapping("selectByIds")
	public void allBrand(HttpServletResponse response, String ids) {
		try {
			super.outJson(response, REQUEST_SUCCESS, "查询成功", goodsBrandService.getByIds(ids));
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "查询失败", null);
		}
	}

	/**
	 * @description 商家品牌申请列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "sqlistPage")
	public ModelAndView sqlistPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("type", "0");
		page.setPd(pd);

		if (StringUtils.isNotEmpty(pd.getAsString("category2_id"))) {
			pd.put("parent_id", pd.getAsString("category1_id"));
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category2List", goodsCategoryService.getByMap(pd));
		}
		if (StringUtils.isNotEmpty(pd.getAsString("category3_id"))) {
			pd.put("parent_id", pd.getAsString("category2_id"));
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category3List", goodsCategoryService.getByMap(pd));
		}
		List<PageData> varList = goodsBrandService.selectlSQByPage(page);
		String brand_category = "";
		for (PageData pageData : varList) {
			PageData cpd = new PageData();
			if (StringUtils.isNotEmpty(pageData.getAsString("category1_id"))
					&& !"-1".equals(pageData.getAsString("category1_id"))) {
				cpd.put("category_id", pageData.getAsString("category1_id"));
				PageData model = goodsCategoryService.getOneByMap(cpd);
				if (EAUtil.isNotEmpty(model)) {
					brand_category = model.getAsString("category_name");
				}
				if (StringUtils.isNotEmpty(pageData.getAsString("category2_id"))
						&& !"-1".equals(pageData.getAsString("category2_id"))) {
					cpd.put("category_id", pageData.getAsString("category2_id"));
					PageData model2 = goodsCategoryService.getOneByMap(cpd);
					if (EAUtil.isNotEmpty(model2)) {
						brand_category += ">" + model2.getAsString("category_name");
					}
					if (StringUtils.isNotEmpty(pageData.getAsString("category3_id"))
							&& !"-1".equals(pageData.getAsString("category3_id"))) {
						cpd.put("category_id", pageData.getAsString("category3_id"));
						PageData model3 = goodsCategoryService.getOneByMap(cpd);
						if (EAUtil.isNotEmpty(model3)) {
							brand_category += ">" + model3.getAsString("category_name");
						}
					}
				}
				pageData.put("brand_category", brand_category);
			}
		}
		pd.put("parent_id", "0");
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("/shops/band/bsbandList");
		return mv;
	}

	/**
	 * @description 商家品牌审核
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	@RequestMapping(value = "savesqband")
	public ModelAndView savesqband(HttpServletRequest request) throws IOException, Exception {
		PageData data = getPageData();
		ModelAndView mv = this.getModelAndView();
		if(EAUtil.isEmpty(data.getAsString("remark"))){
			data.put("remark", "");
		}
		goodsBrandService.edit(data);
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/goodsBrand/sqlistPage");
		return mv;
	}

}