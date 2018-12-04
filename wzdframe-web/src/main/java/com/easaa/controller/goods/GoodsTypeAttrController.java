package com.easaa.controller.goods;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.EADate;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.goods.service.GoodsAttrService;
import com.easaa.goods.service.GoodsTypeAttrService;
import com.easaa.goods.service.GoodsTypeService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/goodsTypeAttr/")
public class GoodsTypeAttrController extends BaseController {
	@Autowired
	private GoodsTypeAttrService goodsTypeAttrService;

	@Autowired
	private GoodsTypeService goodsTypeService;

	@Autowired
	private GoodsAttrService goodsAttrService;

	/**
	 * @description 属性列表
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page, String type_name) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> varList = goodsTypeAttrService.getByPage(page);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("/goods/goodsTypeAttr/goodsTypeAttrList");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * @description 获得某个类型下的所有属性
	 * @author chenlt
	 * @createDate 2016-07-21
	 * @param page
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "listAttr")
	public ModelAndView listAttr(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		/* List<PageData> varList = goodsTypeAttrService.getByMap(pd); */
		List<PageData> typeAttrs = goodsTypeAttrService.getByMap(pd); // 类型属性
		List<PageData> goodsAttrs = goodsAttrService.getByMap(pd); // 商品属性
		if (StringUtils.isEmpty(pd.getAsString("goods_id"))) {
			goodsAttrs.clear();
		}
	/*	List<PageData> ziDingYi = new ArrayList<PageData>();
		if (goodsAttrs != null && goodsAttrs.size() > 0) {
			for (PageData pd1 : goodsAttrs) {
				for (PageData pd2 : typeAttrs) {
					if (pd1.getAsString("attr_id").equals(pd2.getAsString("type_attr_id"))) {
						PageData tempPageData = new PageData();
						tempPageData.put("type_attr_id", pd2.getAsString("type_attr_id")); // 类型属性
						tempPageData.put("attr_name", pd2.getAsString("attr_name")); // 类型属性
						tempPageData.put("attr_values", pd2.getAsString("attr_values")); // 类型属性
						tempPageData.put("attr_input", pd2.getAsString("attr_input")); // 类型属性
						tempPageData.put("attr_sort", pd2.getAsString("attr_sort")); // 排序
						tempPageData.put("is_sale", pd2.getAsString("is_sale")); // 类型属性
						tempPageData.put("attr_value", pd1.getString("attr_value")); // 商品属性value
						tempPageData.put("goods_attr_id", pd1.get("goods_attr_id")); // 商品属性id
						ziDingYi.add(tempPageData);
					}
				}
			}
		} else {
			for (PageData pd2 : typeAttrs) {
				PageData tempPageData = new PageData();
				tempPageData.put("type_attr_id", pd2.getAsString("type_attr_id")); // 类型属性
				tempPageData.put("attr_name", pd2.getAsString("attr_name")); // 类型属性
				tempPageData.put("attr_values", pd2.getAsString("attr_values")); // 类型属性
				tempPageData.put("attr_input", pd2.getAsString("attr_input")); // 类型属性
				tempPageData.put("attr_sort", pd2.getAsString("attr_sort")); // 排序
				tempPageData.put("is_sale", pd2.getAsString("is_sale")); // 类型属性
				ziDingYi.add(tempPageData);
			}
		}*/
		if (goodsAttrs != null && goodsAttrs.size() > 0) {
			for (PageData pd2 : typeAttrs) {
					for (PageData pd1 : goodsAttrs) {
					if (pd1.getAsString("attr_id").equals(pd2.getAsString("type_attr_id"))) {
						pd2.put("attr_value", pd1.getString("attr_value")); // 商品属性value
						pd2.put("goods_attr_id", pd1.get("goods_attr_id")); // 商品属性id
					}
				}
			}
		}
		mv.addObject("varList", typeAttrs);
		mv.addObject("pd", pd);
		mv.setViewName("/goods/goods/attrBack");
		return mv;
	}

	/**
	 * @description 属性新增
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @param page
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@RequestMapping(value = "add")
	public ModelAndView add() throws UnsupportedEncodingException {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 直接把商品类型名称带过来
		mv.addObject("pd", pd);
		mv.setViewName("/goods/goodsTypeAttr/goodsTypeAttrAdd");
		return mv;
	}

	/**
	 * @description 属性编辑
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 表id
		String type_attr_id = getRequest().getParameter("id");
		mv.addObject("pd", pd);
		PageData typeAtrr = goodsTypeAttrService.getById(EAString.stringToInt(type_attr_id, 0));
		StringBuffer sb = new StringBuffer();
		String[] attr_values = typeAtrr.getAsString("attr_values").split(",");
		for (int i = 0; i < attr_values.length; i++) {
			sb.append(attr_values[i] + "\n");
		}
		typeAtrr.put("attr_values", sb.toString());
		mv.addObject("dataModel", typeAtrr);
		mv.setViewName("/goods/goodsTypeAttr/goodsTypeAttrEdit");
		return mv;
	}

	/**
	 * @description 属性保存
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="新增/编辑规格")
	@RequestMapping(value = "save")
	public ModelAndView save() {
		ModelAndView mv = this.getModelAndView();
		PageData data = this.getPageData();
		if (data.getAsInt("type_attr_id") > 0) { // 如果主键type_attr_id值大于0,说明是编辑
			StringBuffer sb = new StringBuffer();
			String[] attr_values = data.getAsString("attr_values").split("\r\n");
			for (int i = 0; i < attr_values.length; i++) {
				sb.append(attr_values[i] + ",");
			}
			data.put("attr_values", sb.substring(0, sb.length() - 1).toString());
			goodsTypeAttrService.edit(data);
		} else { // 主键type_attr_id值不大于0,新增
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			StringBuffer sb = new StringBuffer();
			String[] attr_values = data.getAsString("attr_values").split("\r\n");
			for (int i = 0; i < attr_values.length; i++) {
				sb.append(attr_values[i] + ",");
			}
			data.put("attr_values", sb.substring(0, sb.length() - 1).toString());
			goodsTypeAttrService.create(data);
		}
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/goodsTypeAttr/listPage?goods_type_id=" + data.getAsInteger("goods_type_id")
				+ "&type_name=" + data.getAsString("type_name"));
		return mv;
	}

	/**
	 * @description 属性删除
	 * @author chenlt
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="删除规格")
	@RequestMapping(value = "detele")
	public ModelAndView detele() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 表id
		String type_attr_id = pd.getAsString("type_attr_id");
		PageData typeAtrr = goodsTypeAttrService.getById(EAString.stringToInt(type_attr_id, 0));
		if (EAUtil.isNotEmpty(typeAtrr)) {
			goodsTypeAttrService.delete(pd);
			PageData gsaspd = new PageData();
			gsaspd.put("attr_id", pd.getAsString("type_attr_id"));
			goodsAttrService.deleteGoodAttr(gsaspd);
		}
		mv.setViewName("redirect:/sys/goods/goodsTypeAttr/listPage");
		return mv;
	}
}