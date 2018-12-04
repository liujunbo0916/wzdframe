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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.business.service.BusinessService;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.FtpUtilsAbove;
import com.easaa.core.util.Tools;
import com.easaa.course.service.DeviceService;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.entity.Comment;
import com.easaa.goods.entity.GoodsAttrList;
import com.easaa.goods.entity.Stock;
import com.easaa.goods.entity.StockList;
import com.easaa.goods.service.GoodsAlbumService;
import com.easaa.goods.service.GoodsAttrService;
import com.easaa.goods.service.GoodsBrandService;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsCommentService;
import com.easaa.goods.service.GoodsRebateService;
import com.easaa.goods.service.GoodsService;
import com.easaa.goods.service.GoodsTypeAttrService;
import com.easaa.goods.service.GoodsTypeService;
import com.easaa.log.annotation.MethodLog;
import com.easaa.upm.upm.Jurisdiction;

@Controller
@RequestMapping("/sys/goods/goods/")
public class GoodsController extends BaseController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	@Autowired
	private GoodsBrandService goodsBrandService;
	@Autowired
	private GoodsTypeService goodsTypeService;
	@Autowired
	private GoodsAttrService goodsAttrService;
	@Autowired
	private GoodsTypeAttrService goodsTypeAttrService;
	@Autowired
	private GoodsRebateService goodsRebateService;
	@Autowired
	private GoodsAlbumService goodsAlbumService;
	@Autowired
	private DeviceService deviceService;
	@Autowired
	private GoodsCommentService goodsCommentService;
	@Autowired
	private BusinessService  businessService;
	public PageData temppd=new PageData();

	/**
	 * @description商品列表
	 * @author chenlt
	 * @createDate 2016-07-24
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="商品列表")
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("is_delete", "0");
		page.setPd(pd);
		List<PageData> varList = goodsService.getByPage(page);
		mv.addObject("varList", varList);
		// 获得商品类型
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		pd.put("parent_id", "0");
		mv.addObject("categoryListParent", goodsCategoryService.getByMap(pd));
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
			 * 三级分类的列表
			 */
			mv.addObject("category3List", goodsCategoryService.getByMap(pd));
		}
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("goods/goods/goodsList");
		mv.addObject("QX", Jurisdiction.getHC());
		return mv;
	}

	/**
	 * @description商品编辑
	 * @author chenlt
	 * @createDate 2016-07-28
	 * @return
	 */
	@MethodLog(remark="编辑商品页")
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String goods_id = getRequest().getParameter("id");
		pd.put("goods_id", goods_id);
		PageData goodsModle = goodsService.getOneByMap(pd);
		// 判断商品是不是设备
		if (EAUtil.isNotEmpty(goodsModle.getAsString("is_device")) && goodsModle.getAsInt("is_device") == 1) {
			PageData dvpd = new PageData();
			dvpd.put("dv_device_id", goods_id);
			List<PageData> dvdata = deviceService.getByMap(dvpd);
			if (EAUtil.isNotEmpty(dvdata) && dvdata.size() > 0
					&& EAUtil.isNotEmpty(dvdata.get(0).getAsString("dv_venue_id"))
					&& dvdata.get(0).getAsInt("dv_venue_id") != 0) {
				goodsModle.put("is_Null", "1");
			} else {
				goodsModle.put("is_Null", "2");
			}
		} else {
			goodsModle.put("is_Null", "0");
		}
		pd.put("goods_type_id", goodsModle.get("goods_type_id"));
		pd.put("goods_id", goods_id);
		mv.addObject("dataModel", goodsModle);
		PageData categoryPd = new PageData();
		categoryPd.put("parent_id", "0");
		/**
		 * 一级分类的列表
		 */
		mv.addObject("category1List", goodsCategoryService.getByMap(categoryPd));

		if (goodsModle.getAsInteger("category1_id") == null) {
			categoryPd.put("parent_id", "-1");
		} else {
			categoryPd.put("parent_id", goodsModle.getAsInteger("category1_id"));
		}
		/**
		 * 二级分类的列表
		 */
		mv.addObject("category2List", goodsCategoryService.getByMap(categoryPd));

		if (goodsModle.getAsInteger("category2_id") == null) {
			categoryPd.put("parent_id", "-1");
		} else {
			categoryPd.put("parent_id", goodsModle.getAsInteger("category2_id"));
		}
		/**
		 * 三级分类的列表
		 */
		mv.addObject("category3List", goodsCategoryService.getByMap(categoryPd));
		// 获得商品类型
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		// 获得商品品牌
		pd.put("is_del", 0);
		pd.put("bs_id", "0");
		mv.addObject("brandList", goodsBrandService.getByMap(pd));
		mv.addObject("typeList", goodsTypeService.getByMap(pd));
		//获取店铺列表
		PageData bsPd= new PageData();
		bsPd.put("bs_state", "1");
		mv.addObject("bsList", businessService.getByMap(bsPd));
		/*
		 * //关联设计师 mv.addObject("designerList", designerService.getByMap(pd));
		 * mv.addObject("designerGoods",
		 * designerGoodsService.getByGoodsId(Integer.parseInt(goods_id)));
		 */
		// 分销,根据商品的goods_id获取
		mv.addObject("rebateModel", goodsRebateService.getById(EAString.stringToInt(goods_id, 0)));
		//
		List<PageData> typeAttrs = goodsTypeAttrService.getByMap(pd); // 类型属性
		List<PageData> goodsAttrs = goodsAttrService.getByMap(pd); // 商品属性
		/*List<PageData> ziDingYi = new ArrayList<PageData>();
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
		mv.addObject("varAllList", typeAttrs);
		mv.setViewName("goods/goods/goodsEdit");
		return mv;
	}

	/**
	 * @description商品新增
	 * @author chenlt
	 * @createDate 2016-07-27
	 * @return
	 */
	@MethodLog(remark="新增商品页")
	@RequestMapping(value = "add")
	public ModelAndView add() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String id = getRequest().getParameter("id");
		mv.addObject("dataModel", goodsService.getById(EAString.stringToInt(id, 0)));
		// 获得商品类型
		PageData categoryPd = new PageData();
		categoryPd.put("parent_id", "0");
		/**
		 * 一级分类的列表
		 */
		mv.addObject("category1List", goodsCategoryService.getByMap(categoryPd));
		// 获得商品品牌
		pd.put("is_del", "0");
		pd.put("bs_id", "0");
		mv.addObject("brandList", goodsBrandService.getByMap(pd));
		mv.addObject("typeList", goodsTypeService.getByMap(pd));
		//获取店铺列表
		mv.addObject("bsList", businessService.getByMap(new PageData()));
		mv.setViewName("goods/goods/goodsAdd");
		return mv;
	}

	/**
	 * 
	 * @description商品保存
	 * @author chenlt
	 * @createDate 2016-07-28
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	@MethodLog(remark="保存商品")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public ModelAndView save(@RequestParam(value = "list_img",required=false) MultipartFile file, GoodsAttrList goodsAttr,
			HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		System.out.println("<>><<>><<>><><><" + data.getAsString("category_id"));
		ModelAndView mv = this.getModelAndView();
		try {
			if (StringUtils.isEmpty(data.getAsString("goods_desc"))) {
				data.put("goods_desc", data.getAsString("editorValue"));
			}
			if (data.getAsInt("goods_id") > 0) { // 如果主键goods_id值大于0,说明是编辑
				Tools.replaceEmpty(data);
				data.put("create_time", EADate.getCurrentTime());
				goodsService.update(data, file, goodsAttr);
			} else {
				data.put("creator", getAdminName());
				data.put("create_time", EADate.getCurrentTime());
				Tools.replaceEmpty(data);
				goodsService.insert(data, file, goodsAttr);
			}
			mv.setViewName("redirect:/sys/goods/goods/listPage");
		} catch (Exception e) {
			e.printStackTrace();
			if (e.getMessage().equals("DV0001")) {
				mv.setViewName("common/error2");
			} else {
				mv.setViewName("common/error");
			}
		}
		return mv;
	}

	/**
	 * 跳转商品相册
	 */
	@MethodLog(remark="访问商品相册")
	@RequestMapping("album")
	public ModelAndView album() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("albumModel", goodsAlbumService.getByMap(pd));
		mv.addObject("pd", pd);
		mv.setViewName("/goods/goods/album");
		return mv;
	}

	/**
	 * 跳转到设置库存页面
	 * 
	 * @throws Exception
	 */
	@MethodLog(remark="访问库存页")
	@RequestMapping(value = "toSetStock")
	public ModelAndView toSetStock(HttpServletResponse response, HttpServletRequest request) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		List<Stock> stocks = goodsService.findStockNoDefault(pd);
		/*
		 * if(stocks == null || stocks.size() == 0){ List<Stock> defaultStock =
		 * goodsService.queryDefaultStock(pd);
		 * mv.addObject("defaultStock",defaultStock); }else{
		 * mv.addObject("stocks",stocks); }
		 */
		mv.addObject("stocks", stocks);
		mv.setViewName("goods/goods/set_stock");
		return mv;
	}

	/**
	 * 设置库存动作
	 * 
	 * @throws Exception
	 * 
	 */
	@MethodLog(remark="设置商品库存")
	@RequestMapping(value = "setStock")
	@ResponseBody
	public void setStockAction(HttpServletResponse response, HttpServletRequest request, StockList stocks)
			throws Exception {
		try {
			goodsService.updateStockByPid(stocks);
			super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", e.getMessage());
		}
	}

	/**
	 * @description上传图片
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public void upload(@RequestParam(required=false,value = "fileupload") MultipartFile[] file, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			data.put("create_time", EADate.getCurrentTime());
			// 图片路径
			StringBuffer savePath = new StringBuffer();
			for (int i = 0; i < file.length; i++) {
				if (file[0].getSize() > 0) {
					savePath.append(FtpUtil.upload(file[i], "mallframe", "product") + ",");
				}
			}
			if (savePath.indexOf("mallframe") != -1) {
				super.outJson(response, REQUEST_SUCCESS, "请求成功",
						savePath.substring(0, savePath.length() - 1).toString());
			} else {
				super.outJson(response, REQUEST_SUCCESS, "没有图片上传", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * @description百度插件上传图片
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "uploadPugin")
	public void uploadPugin(HttpServletRequest request, HttpServletResponse response) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			MultipartFile file = multipartRequest.getFile("file");
			String filePath = "";
			if (file != null) {
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				filePath = ftp.upload(file, "mallframe", "product");
				data.put("original_img", filePath);
				goodsAlbumService.create(data);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 删除图片
	 * 
	 * @param response
	 */
	@RequestMapping("deleteImg")
	public void deleteImg(HttpServletResponse response) {
		PageData pd = new PageData();
		String album_id = getRequest().getParameter("album_id");
		pd.put("album_id", album_id);
		int i = goodsAlbumService.delete(pd);
		if (i == 1) {
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} else {
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}

	}

	/**
	 * 上架商品
	 * 
	 * @param response
	 */
	@RequestMapping("saleGoods")
	public void saleGoods(HttpServletResponse response) {
		PageData pd = this.getPageData();
		if (pd.getAsInt("type") == 1) {
			pd.put("is_on_sale", "0");
		} else {
			pd.put("is_on_sale", "1");
		}
		// 校验 列表图，库存是否为空
		PageData data = goodsService.getById(pd.getAsInt("goods_id"));
		if (EAString.isNullStr(data.getAsString("list_img"))) {
			super.outJson(response, REQUEST_FAILS, "列表图片不能为空", null);
			return;
		}
		if (EAString.isNullStr(data.getAsString("goods_stock"))) {
			super.outJson(response, REQUEST_FAILS, "库存不能为空", null);
			return;
		}
		/**
		 * 检查库存 如果商品有销售属性 查看是否有设置库存 如果没有则不能上架商品
		 */
		if (pd.getAsString("is_on_sale").equals("1")) {
			List<Stock> stocks = goodsService.queryStockByGoodsId(data);
			for (Stock s : stocks) {
				if (StringUtils.isEmpty(s.getStock())) {
					super.outJson(response, REQUEST_FAILS, "请设置商品销售属性的库存", null);
					return;
				}
			}
		}
		int i = goodsService.edit(pd);
		if (i == 1) {
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} else {
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 删除商品
	 * 
	 * @param response
	 */
	@MethodLog(remark="删除商品")
	@RequestMapping("deleteGoods")
	public void deleteGoods(HttpServletResponse response) {
		PageData pd = this.getPageData();
		pd.put("is_delete", "1");
		int i = goodsService.edit(pd);
		if (i == 1) {
			super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
		} else {
			super.outJson(response, REQUEST_FAILS, "删除失败", null);
		}

	}

	/**
	 * @description商品回收站列表
	 * @author chenlt
	 * @createDate 2016-07-24
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@MethodLog(remark="商品回收站")
	@RequestMapping(value = "recyclePage")
	public ModelAndView recyclePage(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("is_delete", "1");
		page.setPd(pd);
		List<PageData> varList = goodsService.getByPage(page);
		mv.addObject("varList", varList);
		// 获得商品类型
		mv.addObject("categoryList", goodsCategoryService.getByMap(pd));
		mv.addObject("pd", pd);
		mv.addObject("page", page);
		mv.setViewName("goods/goods/goodsRecycle");
		return mv;
	}

	/**
	 * 回收商品
	 * 
	 * @param response
	 */
	@MethodLog(remark="商品回收")
	@RequestMapping("recycleGoods")
	public void recycleGoods(HttpServletResponse response) {
		PageData pd = this.getPageData();
		pd.put("is_delete", "0");
		int i = goodsService.edit(pd);
		if (i == 1) {
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} else {
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 商品详情预览页面
	 */
	@RequestMapping("preview")
	public ModelAndView preview(String id) {
		ModelAndView mv = this.getModelAndView();
		if (StringUtils.isNotEmpty(id)) {
			mv.addObject("dataModel", goodsService.getById(Integer.parseInt(id)));
			mv.addObject("type", "goods");
		}
		mv.setViewName("/course/teacherLib/preview");
		return mv;
	}

	/**
	 * 根据分类查询品牌和类型
	 */
	@RequestMapping("findBAndTByCategory")
	public void findBAndTByCategory(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			PageData result = new PageData(), typePd = new PageData();
			if (StringUtils.isNotEmpty(pd.getAsString("category2_id"))
					&& !"-1".equals(pd.getAsString("category2_id"))) {
				typePd.put("category2_id", pd.getAsString("category2_id"));
			} else if (StringUtils.isNotEmpty(pd.getAsString("category3_id"))
					&& !"-1".equals(pd.getAsString("category3_id"))) {
				typePd.put("category3_id", pd.getAsString("category3_id"));
			} else {
				typePd.put("category1_id", pd.getAsString("category1_id"));
			}
			pd.put("bs_id", "0");
			result.put("brands", goodsBrandService.recursion(pd));
			result.put("types", goodsTypeService.addRecursion(typePd)); // 查询本级和上级类型
			super.outJson(response, REQUEST_SUCCESS, "请求成功", result);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 上传商品库存图片
	 */
	@MethodLog(remark="上传商品库存图片")
	@RequestMapping("toUploadStockImg")
	public ModelAndView toUploadStockImg(HttpServletResponse response) {

		ModelAndView mv = this.getModelAndView();

		PageData pd = this.getPageData();
		Stock stockPd = goodsService.queryStockBySkuId(pd);
		if (stockPd != null && StringUtils.isNotEmpty(stockPd.getImg_ary())) {
			mv.addObject("albumModel", stockPd.getImg_ary().split(","));
		}
		mv.addObject("pd", pd);
		mv.setViewName("/goods/goods/stock_album");
		return mv;
	}

	/**
	 * 保存商品图片到数据库
	 */
	@RequestMapping("saveStockImg")
	public void saveStockImg(HttpServletResponse response, HttpServletRequest request) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			PageData data = getPageData(multipartRequest);
			MultipartFile file = multipartRequest.getFile("file");
			String filePath = "";
			if (file != null) {
				/**
				 * 更新相册
				 */
				FtpUtilsAbove ftp = new FtpUtilsAbove();
				filePath = ftp.upload(file, "mallframe", "product");
				/**
				 * 查询库存根据库存id
				 */
				data.put("sku_id", data.getAsString("goods_id"));
				Stock stockPd = goodsService.queryStockBySkuId(data);
				if (stockPd != null && StringUtils.isNotEmpty(stockPd.getImg_ary())) {
					stockPd.setImg_ary(stockPd.getImg_ary() + "," + filePath);
				} else {
					stockPd.setImg_ary(filePath);
				}
				goodsService.updateStockByPid(stockPd);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", filePath);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 删除库存图片
	 */
	@MethodLog(remark="删除商品库存图片")
	@RequestMapping("delStockImg")
	public void delStockImg(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			Stock stockPd = goodsService.queryStockBySkuId(pd);
			if (stockPd != null && StringUtils.isNotEmpty(stockPd.getImg_ary())) {
				if (stockPd.getImg_ary().indexOf(pd.getAsString("imgPath") + ",") != -1) {
					// 判断是否包含
					stockPd.setImg_ary(stockPd.getImg_ary().replace(pd.getAsString("imgPath") + ",", ""));
				}
				if (stockPd.getImg_ary().indexOf("," + pd.getAsString("imgPath")) != -1) {
					// 判断是否包含
					stockPd.setImg_ary(stockPd.getImg_ary().replace("," + pd.getAsString("imgPath"), ""));
				}
				if (stockPd.getImg_ary().indexOf(pd.getAsString("imgPath")) != -1) {
					// 判断是否包含
					stockPd.setImg_ary(stockPd.getImg_ary().replace(pd.getAsString("imgPath"), ""));
				}
				goodsService.updateStockByPid(stockPd);
			}
			super.outJson(response, REQUEST_SUCCESS, "请求成功", null);
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "请求失败", null);
		}
	}

	/**
	 * 
	 * 商品复制
	 * 
	 */
	@MethodLog(remark="商品复制")
	@RequestMapping("copyGoods")
	public void copyGoods(HttpServletResponse response) {
		try {
			Integer goodsId = goodsService.addCopyGoods(this.getPageData());
			super.outJson(response, REQUEST_SUCCESS, "操作成功", goodsId);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 彻底删除商品
	 */
	@RequestMapping("thoroughDel")
	public void thoroughDel(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			goodsService.thoroughDel(pd);
			super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}

	}

	/**
	 * 根据货号 查询商品 selectGoodsBySN
	 */
	@RequestMapping("selectGoodsBySN")
	public void selectGoodsBySN(HttpServletRequest request, HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			List<PageData> result = goodsService.getByMap(pd);
			if (result != null && result.size() > 0) {
				super.outJson(response, REQUEST_FAILS, "操作失败", null);
			} else {
				super.outJson(response, REQUEST_SUCCESS, "操作成功", result);
			}
		} catch (Exception e) {
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 查询商品库存
	 */
	@RequestMapping("stockById")
	public void stockById(HttpServletResponse response) {
		try {
			PageData pd = this.getPageData();
			super.outJson(response, REQUEST_SUCCESS, "操作成功", goodsService.queryStockBySkuId(pd));
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", null);
		}
	}

	/**
	 * 商品/课程 评论列表
	 */
	@MethodLog(remark="评论列表")
	@RequestMapping("goodsComments")
	public ModelAndView goodsComments(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if (EAUtil.isNotEmpty(temppd)) {
			if (EAUtil.isNotEmpty(temppd.getAsString("goods_id"))) {
				temppd.put("comment_type", "1");
			} else if (EAUtil.isNotEmpty(temppd.getAsString("course_id"))) {
				temppd.put("comment_type", "2");
			}
			temppd.remove("comment_id");
			page.setPd(temppd);
		} else {
			page.setPd(pd);
		}
		try {
			List<Comment> clists = goodsCommentService.goodsCommentList(page);
			mv.addObject("commentlist", clists);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("commentType", pd.getAsString("comment_type"));
		mv.addObject("page", page);
		mv.setViewName("/goods/goods/goods_comment");
		mv.addObject("QX", Jurisdiction.getHC());
		if (EAUtil.isNotEmpty(temppd)) {
			temppd.clear();
		}
		return mv;
	}

	/**
	 * 删除评论
	 */
	@MethodLog(remark="删除评论")
	@RequestMapping("delGoodsComments")
	public ModelAndView delGoodsComments() {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			temppd = pd;
			goodsCommentService.delete(pd);
			mv.setViewName("redirect:/sys/goods/goods/goodsComments");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}

}