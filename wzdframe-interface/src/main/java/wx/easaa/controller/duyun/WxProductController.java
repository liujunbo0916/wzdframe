package wx.easaa.controller.duyun;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.content.service.ContentService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.goods.entity.Stock;
import com.easaa.goods.entity.data.ProductData;
import com.easaa.goods.service.GoodsCartService;
import com.easaa.goods.service.GoodsCategoryService;
import com.easaa.goods.service.GoodsCollectService;
import com.easaa.goods.service.GoodsService;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.service.DiscountTimeLimitService;
import com.easaa.user.service.UserAccountService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/product/")
public class WxProductController extends BaseController {

	@Autowired
	private ContentService contentService;
	@Autowired
	private UserService userService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsCollectService goodsCollectService;
	@Autowired
	private UserAccountService useraccountService;
	@Autowired
	private GoodsCategoryService goodsCategoryService;
	@Autowired
	private GoodsCartService goodsCartService;
	@Autowired
	private DiscountTimeLimitService discountTimeLimitService;
	
	private static List<PageData> categorylist;

	/**
	 * ##########################页面跳转集合########################## 无逻辑操作
	 * 跳转页面需要的控制器
	 */
	/**
	 * 特产列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		List<PageData> cartList = goodsCartService.selectByUserId(pd);
		int cartCount = cartList == null ? 0 : cartList.size();
		mv.addObject("cartCount", cartCount);
		mv.setViewName("/duyun/product_list");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 特产详情
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("detail")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		List<PageData> cartList = goodsCartService.selectByUserId(pd);
		int cartCount = cartList == null ? 0 : cartList.size();
		mv.addObject("cartCount", cartCount);
		mv.addObject("pd", pd);
		mv.addObject("user", getUser(request));
		mv.setViewName("/duyun/product_detail");
		return mv;
	}

	/**
	 * 商城首页
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("home")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("user_id", getUserIdFromSession(request));
		List<PageData> cartList = goodsCartService.selectByUserId(pd);
		int cartCount = cartList == null ? 0 : cartList.size();
		mv.addObject("cartCount", cartCount);
		mv.addObject("pd", pd);
		mv.setViewName("/duyun/product_home");
		return mv;
	}

	/**
	 * ##########################页面跳转集合结束##########################
	 * 
	 */
	/**
	 * ##########################Ajax请求逻辑集合##########################
	 * ajax请求的方法前面加上do
	 */
	// ajax分页请求列表数据
	@RequestMapping("doList")
	public void doList(HttpServletResponse response) {
		PageExtend page = new PageExtend();
		PageData pd = this.getPageData();
		PageData data = new PageData();
		try {
			if (pd.getAsInt("category_id") > 0) {
				// 需判断是否为父节点，如果是需要遍历出子节点下的商品
				List<PageData> categoryList = goodsCategoryService.getByMap(data);
				List<Integer> category_ids = this.treeMenuList(categoryList, pd.getAsInt("category_id"));
				category_ids.add(pd.getAsInt("category_id")); // 加入父节点
				data.put("category_ids", category_ids);
			}
			data.put("is_delete", "0"); // 是否删除
			data.put("is_on_sale", "1"); // 是否上架
			data.put("bs_id", pd.getAsString("storeId")); // 门店id
			// 销量降序
			if (!EAUtil.isEmpty(pd.getAsString("is_virtual_sales"))) {
				if (pd.getAsString("is_virtual_sales").equals("1")) {
					data.put("is_virtual_sales", 1);
				}
			}
			// 价格升降序
			if (!EAUtil.isEmpty(pd.getAsString("is_shop_price"))) {
				if (pd.getAsString("is_shop_price").equals("1")) {
					// 降序
					data.put("is_shop_price", 1);
				} else {
					// 升序
					data.put("is_shop_price", "0");
				}
			}
			page.setApp(true);
			page.setCurrentPage(EAString.stringToInt(pd.getAsString("currentPage"), 1));
			page.setShowCount(12);
			page.setPd(data);
			List<PageData> goodList = goodsService.selectGoodsList(page);
			page.setResultPd(goodList);
			// 获取一级分类
			if (EAUtil.isEmpty(categorylist)) {
				PageData dataModel = new PageData();
				dataModel.put("parent_id", "0");
				categorylist = goodsCategoryService.goodsCategoryList(dataModel);
				dataModel.clear();
			}
			page.setOtherPd(categorylist);
			page.setPrefixImg(PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", page, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	// ajax请求商品详情数据
	@RequestMapping("doDetail")
	public void doDetail(HttpServletResponse response, HttpServletRequest request) {
		PageData pd = this.getPageData();
		try {
			String user_id = StringUtils.isNotEmpty(pd.getAsString("user_id")) ? pd.getAsString("user_id")
					: getUserIdFromSession(request);
			pd.put("user_id", user_id);
			pd.put("goods_id", pd.getAsString("p_id"));
			ProductData productData = goodsService.goodsDetail(pd);
			productData.setIs_goods_like(0);
			if (!EAUtil.isEmpty(user_id)) {
				// 关联商品收藏表
				List<PageData> collectList = goodsCollectService.getByMap(pd);
				if (EAUtil.isNotEmpty(collectList)) {
					productData.setIs_goods_like(1);
				}
			}
			if(EAUtil.isNotEmpty(productData.getSku_id())){//默认属性     查询是否为折扣商品
				pd.put("stock_id", productData.getSku_id());
				pd.put("activity_status", "1");
				pd.put("currentTime", EADate.getCurrentTime());
				List<PageData> porlist = discountTimeLimitService.selectLimitGoodsByMap(pd);
				PageData skuPd=new PageData();
				skuPd.put("sku_id", productData.getSku_id());
				Stock stock= goodsService.queryStockBySkuId(skuPd);
				if(EAUtil.isNotEmpty(stock) && EAUtil.isNotEmpty(porlist) && porlist.size()==1){
					stock.setStockType("1");
					stock.setMinNum(porlist.get(0).getAsString("min_num"));
					stock.setMarket_price(stock.getPrice());
					stock.setPrice(porlist.get(0).getAsString("discount_price"));
					stock.setProId(porlist.get(0).getAsString("id"));
					productData.setGoods_stock(stock.getStock());
						if(StringUtils.isNotEmpty(porlist.get(0).getAsString("timelimit_end_time"))){
							long cutDown = (EADate.stringToDate(porlist.get(0).getAsString("timelimit_end_time")).getTime() - new Date().getTime())/1000;
							stock.setEndTime((cutDown <= 0 ? "0" : String.valueOf(cutDown)));
						}else{
							stock.setEndTime("0");
						}
					productData.setStock(stock);
				}
			}
			this.outJson(REQUEST_SUCCESS, "请求成功", productData, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	// ajax请求商品首页数据
	@RequestMapping("doHome")
	public void doHome(HttpServletResponse response, HttpServletRequest request) {
		PageData pd = this.getPageData();
		try {
			String user_id = StringUtils.isNotEmpty(pd.getAsString("user_id")) ? pd.getAsString("user_id")
					: getUserIdFromSession(request);
			pd.put("user_id", user_id);
			PageData dataModel = goodsService.goodsDuyunHomePage(pd);
			//获取首页显示折扣数据
			PageData dtPd=new PageData();
			dtPd.put("activity_status", "1");
			dtPd.put("currentTime", EADate.getCurrentTime());
			dataModel.put("discountgoods", discountTimeLimitService.selectProductByMap(dtPd));
			dataModel.put("prefixImg", PROPERTIESHELPER.getValue("imageShowPath"));
			this.outJson(REQUEST_SUCCESS, "请求成功", dataModel, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}

	/**
	 * ##########################Ajax请求逻辑集合结束##########################
	 */

	/**
	 * 商品收藏
	 * 
	 * @param response
	 */
	@RequestMapping(value = "doCollect")
	public void goodsCollect(HttpServletResponse response, HttpServletRequest request) {
		PageData pd = this.getPageData();
		try {
			String userId = getUserIdFromSession(request);
			pd.put("collect_type", "1");
			pd.put("user_id", userId);
			if (EAUtil.isNotEmpty(userId) && !"-2".equals(userId)) {
				PageData goodspg = new PageData();
				goodspg.put("goods_id", pd.getAsString("goods_id"));
				// 查询商品信息
				PageData goods = goodsService.getOneByMap(goodspg);
				if (EAUtil.isNotEmpty(goods)) {
					pd.put("goods_name", goods.getAsString("goods_name"));
					pd.put("collect_price", goods.getAsString("shop_price"));
					pd.put("collect_img", goods.getAsString("list_img"));
				}
				this.outJson(REQUEST_SUCCESS, "操作成功", goodsCollectService.updateCollect(pd), response);
			} else {
				this.outJson(REQUEST_FAILS, "操作失败", null, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}

	}

	/**
	 * 商品评论
	 */
	@RequestMapping("comments")
	public void comments(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = this.getPageData();
			pd.put("user_id", getUserIdFromSession(request));
			pd.put("content_id", pd.getAsString("CONTENT_ID"));
			// 根据用户id查询用户信息
			PageData user = getUser(request);
			if (EAUtil.isNotEmpty(user)) {
				pd.put("comment_author_logo", user.getAsString("headimgurl"));
				pd.put("comment_author", user.getAsString("nick_name"));
			} else {
				this.outJson(REQUEST_FAILS, "评论回复失败！", "用户不存在啊", response);
				return;
			}
			pd.put("comment_context_time", EADate.getCurrentTime());
			pd.put("show_time", EADate.getMMDD(pd.getAsString("comment_context_time")));
			contentService.contentComment(pd);
			super.outJson(REQUEST_SUCCESS, "评论成功", pd, response);
		} catch (Exception e) {
			super.outJson(REQUEST_FAILS, e.getMessage(), null, response);
		}
	}

	/**
	 * 商品库存
	 * 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/doGoodsStock")
	public void goodsStock(HttpServletResponse response) {
		PageData pd = this.getPageData();
		try {
			Stock stock = goodsService.findStockByAttr(pd);
			pd.put("stock_id", stock.getSku_id());
			pd.put("activity_status", "1");
			pd.put("currentTime", EADate.getCurrentTime());
			List<PageData> porlist = discountTimeLimitService.selectLimitGoodsByMap(pd);
			if(EAUtil.isNotEmpty(stock) && EAUtil.isNotEmpty(porlist) && porlist.size()==1){
				stock.setStockType("1");
				stock.setMinNum(porlist.get(0).getAsString("min_num"));
				stock.setMarket_price(stock.getPrice());
				stock.setPrice(porlist.get(0).getAsString("discount_price"));
				stock.setProId(porlist.get(0).getAsString("id"));
					if(StringUtils.isNotEmpty(porlist.get(0).getAsString("timelimit_end_time"))){
						long cutDown = (EADate.stringToDate(porlist.get(0).getAsString("timelimit_end_time")).getTime() - new Date().getTime())/1000;
						stock.setEndTime((cutDown <= 0 ? "0" : String.valueOf(cutDown)));
					}else{
						stock.setEndTime("0");
					}
			}
			this.outJson(REQUEST_SUCCESS, "查询成功", stock, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "查询失败", e.getMessage(), response);
		}
	}

	/**
	 * 商品积分抵扣
	 * @param response
	 */
	@RequestMapping(value = "/doGoodsdiscount")
	public void goodsdiscount(HttpServletResponse response, HttpServletRequest request) {
		try {
			PageData pd = getPageData();
			PageData data = new PageData();
			pd.put("user_id", getUserIdFromSession(request));// 写死
																// 后期session里面取值
			if (EAUtil.isEmpty(pd.getAsString("sku_ids"))) {
				this.outJson(REQUEST_FAILS, "库存id不能为空", null, response);
				return;
			}
			if (EAUtil.isEmpty(pd.getAsString("skuMap"))) {
				this.outJson(REQUEST_FAILS, "数量不能为空", null, response);
				return;
			}
			PageData skuMap = new PageData();
			skuMap.put(pd.getAsString("sku_ids"), pd.getAsString("skuMap"));
			// 按照积分抵扣比列返回参数
			boolean isTrue = false;
			String ds = "";
			Map<String, PageData> gdset = goodsService.selectGoodsSetting();
			if ((StringUtils.isEmpty(gdset.get("00101").getAsString("setting_value")) ? "1"
					: gdset.get("00101").getAsString("setting_value")).equals("1")) {
				isTrue = true;
			}
			ds = StringUtils.isEmpty(gdset.get("00103").getAsString("setting_value")) ? "1:10"
					: gdset.get("00103").getAsString("setting_value");

			// 查询所有商品是否能抵扣(所有商品可使用的积分)
			BigDecimal goodspoints = BigDecimal.valueOf(0);
			BigDecimal givepoints = BigDecimal.valueOf(0);
			BigDecimal zero = BigDecimal.valueOf(0);
			PageData pdids = new PageData();
			pdids.put("sku_ids", pd.getAsString("sku_ids"));
			List<PageData> goodspoint = goodsService.getGoodsPaypoint(pdids);

			for (int i = 0; i < goodspoint.size(); i++) {
				PageData goods = goodspoint.get(i);
				goodspoints = goodspoints.add(goods.getAsBigDecimal("pay_points")
						.multiply(skuMap.getAsBigDecimal(goods.getAsString("sku_id"))));
				givepoints = givepoints.add(goods.getAsBigDecimal("give_points")
						.multiply(skuMap.getAsBigDecimal(goods.getAsString("sku_id"))));
			}
			if (goodspoints.compareTo(zero) < 0) {
				goodspoints = zero;
			}
			// 积分支付开启
			if (isTrue) {
				// 查询用户可用积分
				BigDecimal userpoints = BigDecimal.valueOf(0);
				List<PageData> ucpd = useraccountService.getByMap(pd);
				if (EAUtil.isNotEmpty(ucpd)) {
					if (EAUtil.isEmpty(ucpd.get(0).getAsBigDecimal("user_points"))) {
						userpoints = zero;
					} else {
						userpoints = ucpd.get(0).getAsBigDecimal("user_points");
					}
				}
				if (userpoints.compareTo(zero) < 0) {
					userpoints = zero;
				}
				// 用户积分为0或者商品积分为0，不参与积分支付
				if (userpoints.compareTo(zero) < 1 || goodspoints.compareTo(zero) < 1) {
					data.put("pay_points", "0");
					data.put("user_points", "0");
					data.put("give_points", givepoints);
					this.outJson(REQUEST_SUCCESS, "查询成功", data, response);
					return;
				}
				String[] dsStr;
				if (EAUtil.isNotEmpty(ds)) {
					dsStr = ds.split(":");
					if (userpoints.compareTo(goodspoints) >= 0) {
						BigDecimal ds_point = goodspoints.divide(
								(new BigDecimal(dsStr[1])).multiply(new BigDecimal(dsStr[0])), 2, RoundingMode.FLOOR);
						data.put("pay_points", ds_point);
						data.put("user_points", goodspoints);
					} else {
						BigDecimal ds_point = userpoints.divide(
								(new BigDecimal(dsStr[1])).multiply(new BigDecimal(dsStr[0])), 2, RoundingMode.FLOOR);
						data.put("pay_points", ds_point);
						data.put("user_points", userpoints);
					}
				}
			} else {
				data.put("pay_points", "0");
				data.put("user_points", "0");
			}
			data.put("give_points", givepoints);
			this.outJson(REQUEST_SUCCESS, "查询成功", data, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "查询失败", null, response);
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

	// 获取用户id
	private String getUserIdFromSession(HttpServletRequest request) {
		String user_id = "-2";
		PageData user = getUser(request);
		if (user != null) {
			user_id = user.getAsString("user_id");
		}
		return user_id;
	}

	private PageData getUser(HttpServletRequest request) {
		PageData pd = new PageData();
//		pd.put("user_id", "217");
		pd.put("open_id", this.getSessionAttribute(request, "open_id"));
		PageData user = userService.getOneByMap(pd);
		if (user != null) {
			return user;
		}
		return null;
	}
}
