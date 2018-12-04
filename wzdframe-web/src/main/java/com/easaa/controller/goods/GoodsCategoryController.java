package com.easaa.controller.goods;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.easaa.controller.comm.BaseController;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.core.util.EAString;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.EADate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.goods.service.GoodsBrandService;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/goodsCategory/")
public class GoodsCategoryController extends BaseController {
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsBrandService goodsBrandService;
	
	/**
	 * 
	 * @description 商品分类列表
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
		page.setPd(pd);
		List<PageData> varList = goodsCategoryService.getByMap(pd);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.setViewName("goods/goodsCategory/goodsCategoryList");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * @description 商品分类编辑
	 * @author chenlt
	 * @createDate 2016-07-20
	 * @return
	 */
	@RequestMapping(value = "edit")
	public ModelAndView edit(String category_id) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String id = getRequest().getParameter("id");
		mv.addObject("category_id", category_id);
		// 获得商品类目
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		mv.addObject("dataModel", goodsCategoryService.getById(EAString.stringToInt(id, 0)));
		mv.setViewName("goods/goodsCategory/goodsCategoryEdit");
		return mv;
	}

	/**
	 * @description 商品分类保存
	 * @author chenlt
	 * @createDate 2016-07-20
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	@MethodLog(remark="新增/编辑分类")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam(required=false,value = "category_icon") MultipartFile file, HttpServletRequest request)
			throws IOException, Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		// PageData data = this.getPageData();
		/**
		 * 检测是否是叶子节点
		 */
		if (goodsCategoryService.queryCategoryIsLeaf(data)) {
			data.put("is_leaf", 1);
		} else {
			data.put("is_leaf", "0");
		}
		if (data.getAsInt("category_id") > 0) { // 如果主键category_id值大于0,说明是编辑
			if (file!=null && !file.isEmpty()) {
				String savePath = FtpUtil.upload(file, "mallframe", "product");
				data.put("category_icon", savePath);
			}
			goodsCategoryService.edit(data);
		} else { // 主键category_id值不大于0,新增
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			String savePath = FtpUtil.upload(file, "mallframe", "product");
			data.put("category_icon", savePath);
			/**
			 * 将上级的父节点改成非叶子节点
			 */
			goodsCategoryService.create(data);
			PageData parentPd = new PageData();
			parentPd.put("category_id", data.get("parent_id"));
			parentPd.put("is_leaf", "0");
			goodsCategoryService.edit(parentPd);
		}
		if (data == null || data.isEmpty()) {
			mv.setViewName("common/error");
		}
		mv.setViewName("redirect:/sys/goods/goodsCategory/listPage");
		return mv;
	}

	/**
	 * 删除类目
	 * 
	 * @param response
	 */
	@MethodLog(remark="删除类目")
	@RequestMapping("delete")
	public void delete(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			PageData gpd= new PageData();
			/**
			 * 判断删除的类目下有没有商品
			 */
			// 需判断是否为父节点，如果是需要遍历出子节点下的商品
			List<PageData> categoryList = goodsCategoryService.getByMap(gpd);
			List<Integer> category_ids = this.treeMenuList(categoryList, pd.getAsInt("category_id"));
			category_ids.add(pd.getAsInt("category_id")); // 加入父节点
			gpd.put("category_ids", category_ids);
			List<PageData> goodslist=goodsService.selectByIds(gpd);
			if(goodslist!=null && goodslist.size()>0){
				super.outJson(response, REQUEST_FAILS, "删除失败，该类目下有商品！请先删除商品！", null);
				return;
			}
			/**
			 * 判断删除的类目下有没有商品品牌
			 */
			List<PageData> goodsBrandlist	=goodsBrandService.selectByCIds(gpd);
			if(goodsBrandlist!=null && goodsBrandlist.size()>0){
				super.outJson(response, REQUEST_FAILS, "删除失败，该类目下有商品品牌！请先删除商品品牌", null);
				return;
			}
			/**
			 * 循环删除
			 */
			for (int cid : category_ids) {
				pd.put("category_id",cid);
				goodsCategoryService.delete(pd);
			}
			super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "删除失败"+e.getMessage(), null);
			e.printStackTrace();
		}

	}

	/**
	 * 根据父亲id请求下级类目
	 */
	@RequestMapping("queryCategoryByPid")
	public void queryCategoryByPid(HttpServletResponse response, String pid) {
		PageData pd = this.getPageData();
		pd.put("parent_id", pid);
		super.outJson(response, REQUEST_SUCCESS, "查询成功", goodsCategoryService.getByMap(pd));
	}

	/**
	 * 查询排序名次 最大值
	 */

	@RequestMapping("selectOrder")
	public void selectOrder(HttpServletResponse response) {
		try {
			super.outJson(response, REQUEST_SUCCESS, "查询成功", goodsCategoryService.selectOrder(this.getPageData()));
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "查询失败", null);
		}

	}

	/**
	 * 获取某个父节点下面的所有子节点
	 * 
	 * @param menuList
	 * @param pid
	 * @return
	 */
	public List<Integer> treeMenuList(List<PageData> menuList, int pid) {
		List<Integer> childMenu = new ArrayList<Integer>();
		for (PageData mu : menuList) {
			// 遍历出父id等于参数的id，add进子节点集合
			if (Integer.valueOf(mu.getAsInt("parent_id")) == pid) {
				// 递归遍历下一级
				treeMenuList(menuList, Integer.valueOf(mu.getAsInt("category_id")));
				childMenu.addAll(treeMenuList(menuList, Integer.valueOf(mu.getAsInt("category_id"))));
				childMenu.add(mu.getAsInt("category_id"));
			}
		}
		return childMenu;
	}

	/**
	 * 获取某个父节点下面的所有子节点(对象)
	 * 
	 * @param menuList
	 * @param pid
	 * @return
	 */
	public List<PageData> treeMenuPdList(List<PageData> menuList, int pid) {
		List<PageData> childMenu = new ArrayList<PageData>();
		for (PageData mu : menuList) {
			// 遍历出父id等于参数的id，add进子节点集合
			if (Integer.valueOf(mu.getAsInt("parent_id")) == pid) {
				// 递归遍历下一级
				treeMenuList(menuList, Integer.valueOf(mu.getAsInt("category_id")));
				childMenu.addAll(treeMenuPdList(menuList, Integer.valueOf(mu.getAsInt("category_id"))));
				childMenu.add(mu);
			}
		}
		return childMenu;
	}

}