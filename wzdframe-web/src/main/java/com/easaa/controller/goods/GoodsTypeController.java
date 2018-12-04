package com.easaa.controller.goods;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.core.util.EAString;
import com.easaa.core.util.Tools;
import com.easaa.core.util.EADate;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.goods.service.GoodsBrandService;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsTypeService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/goodsType")
public class GoodsTypeController extends BaseController{
	
	@Autowired
	private GoodsTypeService  goodsTypeService;
	
	@Autowired
	private GoodsBrandService goodsBrandService;
	
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	
	/**
	 * @description  商品类型列表
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList = goodsTypeService.getByPage(page);
		mv.addObject("varList", varList);
		mv.setViewName("/goods/goodsType/goodsTypeList");
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * @description  商品类型编辑
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id = getRequest().getParameter("id");
		PageData typeAtrr = goodsTypeService.getById(EAString.stringToInt(id, 0));
		StringBuffer sb = new StringBuffer();
		if(typeAtrr != null){
			String [] attr_group = typeAtrr.getAsString("attr_group").split(",");
			for(int i=0; i<attr_group.length; i++){
				sb.append(attr_group[i] + "\n");
			}
			typeAtrr.put("attr_group", sb.toString());
		}
		PageData categoryPd = new PageData();
		categoryPd.put("parent_id", "0");
		mv.addObject("category1List", goodsCategoryService.getByMap(categoryPd));
		if(StringUtils.isNotEmpty(id)){
			if(StringUtils.isNotEmpty(typeAtrr.getAsString("brand_ids")));
			mv.addObject("brands", goodsBrandService.getByIds(typeAtrr.getAsString("brand_ids")));
			if(typeAtrr.getAsInteger("category1_id") == null){
				categoryPd.put("parent_id", "-1");
			}else{
				categoryPd.put("parent_id", typeAtrr.getAsInteger("category1_id"));
			}
			/**
			 * 二级分类的列表
			 */
			mv.addObject("category2List", goodsCategoryService.getByMap(categoryPd));
			
			if(typeAtrr.getAsInteger("category2_id") == null){
				categoryPd.put("parent_id", "-1");
			}else{
				categoryPd.put("parent_id", typeAtrr.getAsInteger("category2_id"));
			}
			/**
			 * 三级分类的列表
			 */
			mv.addObject("category3List", goodsCategoryService.getByMap(categoryPd));
		}
		mv.addObject("dataModel",typeAtrr);
		mv.setViewName("/goods/goodsType/goodsTypeEdit");
		return mv;
	}
	
	/**
	 * @description  商品类型保存
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="商品类型编辑/保存")
	@RequestMapping(value = "save")
	public void save(HttpServletResponse response,String type_name) {
		try{
			PageData data = this.getPageData();
			PageData paramter = new PageData();
			data.put("type_name", type_name);
			//处理属性分组
			StringBuffer sb = new StringBuffer();
			String [] attr_group = data.getAsString("attr_group").split("\n");
			for(int i=0; i<attr_group.length; i++){
				sb.append(attr_group[i] + ",");
			}
			if(StringUtils.isEmpty(data.getAsString("type_name"))){
				super.outJson(response, super.REQUEST_FAILS, "类型名字不能为空", null);
				return;
			}
			if(!data.containsKey("category_id")){
				data.put("category_id",null);
			}
			if(!data.containsKey("category1_id")){
				data.put("category1_id",null);
			}
			if(!data.containsKey("category2_id")){
				data.put("category2_id",null);
			}
			if(!data.containsKey("category3_id")){
				data.put("category3_id",null);
			}
			data.put("attr_group", sb.toString());
			if(data.getAsInt("type_id")>0){               //如果主键type_id值大于0,说明是编辑
				data.put("is_del", "0");
				Tools.replaceEmpty(data);
				goodsTypeService.edit(data);
			}else{    
				//主键type_id值不大于0,新增
				//查询分类名字是否存在
				paramter.put("type_name", data.getAsString("type_name"));
				List<PageData> goodsTypes = goodsTypeService.getByMap(paramter);
				if(goodsTypes != null && goodsTypes.size() > 0){
					super.outJson(response, super.REQUEST_FAILS, "已存在名字为"+data.getAsString("type_name")+"的类型", null);
					return;
				}
				data.put("creator", getAdminName());
				data.put("create_time", EADate.getCurrentTime());
				data.put("is_del", "0");
				Tools.replaceEmpty(data);
				goodsTypeService.create(data);
			}
			super.outJson(response, super.REQUEST_SUCCESS, "操作成功", null);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(response, super.REQUEST_FAILS, "操作失败", null);
		}
	}
	/**
	 * @description  商品类型删除
	 * @author chenlt
	 * @createDate 2016-07-18
	 * @return
	 * @throws Exception
	 */
	
	@MethodLog(remark="商品类型删除")
	@RequestMapping(value = "delete")
	public ModelAndView delete() {
		ModelAndView mv = this.getModelAndView();
		PageData data = this.getPageData();
		data.put("is_del", 1);
		goodsTypeService.edit(data);
		mv.setViewName("redirect:/sys/goods/goodsType/listPage");
		return mv;
	}

}