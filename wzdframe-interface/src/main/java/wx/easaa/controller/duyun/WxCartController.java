package wx.easaa.controller.duyun;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.goods.entity.Stock;
import com.easaa.goods.service.GoodsCartService;
import com.easaa.goods.service.GoodsService;
import com.easaa.user.service.UserService;

import wx.easaa.controller.comm.BaseController;

@Controller
@RequestMapping("/wx/cart")
public class WxCartController  extends BaseController{

	
	@Autowired
	private GoodsCartService goodsCartService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private UserService userService;

	/**
	 * 添加购物车
	 * @param response
	 */
	@RequestMapping(value = "/addGoodsCart")
	public void addGoodsCart(HttpServletResponse response,HttpServletRequest request){
		/**
		 * 判断用户是否绑定手机号
		 * 
		 */
		PageData userPd = getUser(request);
		
	/*	if(userPd == null || StringUtils.isEmpty(userPd.getAsString("phone"))){
			this.outJson(REQUEST_FAILS, "请前往用户中心绑定手机号", null, response);
			return;
		}*/
		PageData pd = this.getPageData();
		try {
			if (EAUtil.isEmpty(pd.getAsString("goods_id"))) {
				this.outJson(REQUEST_FAILS, "商品id不能为空", null, response);
				return;
			}
			if (EAUtil.isEmpty(pd.getAsString("sku_id"))) {
				this.outJson(REQUEST_FAILS, "库存id不能为空", null, response);
				return;
			}

			if (EAUtil.isEmpty(pd.getAsString("goods_number")) && pd.getAsInt("goods_number") < 1) {
				this.outJson(REQUEST_FAILS, "商品数量不能为空或0", null, response);
				return;
			}
			pd.put("user_id", getUserIdFromSession(request));
			PageData pd1 = new PageData();
			pd1.put("goods_id", pd.getAsInt("goods_id"));
			pd1.put("user_id", pd.getAsInt("user_id"));
			pd1.put("sku_id", pd.getAsInt("sku_id"));
			// 判断商品是否已经存在(通过商品的id和库存的id)
			List<PageData> cartList = goodsCartService.getByMap(pd1);
			if (EAUtil.isEmpty(cartList)) {
				/*Stock stock = goodsService.queryStockBySkuId(pd1);
				pd.put("create_time", EADate.getCurrentTime());
				pd.put("sales_attrs", stock.getAttr_json());
				pd.put("goods_name", stock.getGoods_name());
				pd.put("goods_price", stock.getPrice());
				pd.put("goods_img", stock.getList_img());*/
				pd.put("create_time", EADate.getCurrentTime());
				goodsCartService.create(pd);
			} else {
				int goodsNum=cartList.get(0).getAsInt("goods_number") + pd.getAsInt("goods_number");
				if(goodsNum > EAString.stringToInt(pd.getAsString("stock"), 0)){
					this.outJson(REQUEST_FAILS, "商品加购件数（含已加购件数）已超过库存", null, response);
					return;
				}
				pd.put("cart_id", cartList.get(0).getAsInt("cart_id"));
				pd.put("goods_number", goodsNum);
				goodsCartService.edit(pd);
			}
			cartList = goodsCartService.selectByUserId(pd);
			int cartCount = cartList == null ? 0 : cartList.size();
			pd.put("cartCount", cartCount);
			this.outJson(REQUEST_SUCCESS, "请求成功", pd, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 批量删除
	 * 
	 * @param response
	 */
	@RequestMapping(value = "/batchDelete")
	public void deleteBatchGoods(HttpServletResponse response) {
		PageData pd = this.getPageData();
		try {
			if (EAUtil.isEmpty(pd.getAsString("cart_ids"))) {
				this.outJson(REQUEST_FAILS, "ID不能为空", null, response);
				return;
			}
			String cart_ids = pd.getAsString("cart_ids");
			String[] carts = cart_ids.split(",");
			int[] cart_id = new int[carts.length];
			for (int i = 0; i < carts.length; i++) {
				cart_id[i] = Integer.valueOf(carts[i]);
			}
			goodsCartService.deleteBatch(cart_id);
			this.outJson(REQUEST_SUCCESS, "请求成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", e.getMessage(), response);
		}

	}
	/**
	 * 修改商品的数量
	 * 
	 * 参数idsNumJson  id映射数量 json字符串  如 [{id:1,num:12}{"id":2,"num":32}]
	 * 
	 * @param response
	 */
	@RequestMapping(value = "/batchModify")
	public void modifyNumber(HttpServletResponse response) {
		PageData pd = this.getPageData();
		try {
			// 请求参数校验
			if (EAUtil.isEmpty(pd.getAsString("idsNumJson"))) {
				this.outJson(REQUEST_SUCCESS, "请求成功", null, response);
				return;
			}
			goodsCartService.batchModify(pd);
			this.outJson(REQUEST_SUCCESS, "请求成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(REQUEST_FAILS, "请求失败", null, response);
		}
	}
	/**
	 * 购物车列表
	 * @param response
	 */
	@RequestMapping(value = "/shopCart")
	public ModelAndView cartList(HttpServletResponse response,HttpServletRequest request){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData userPd = getUser(request);
		/*if (EAUtil.isEmpty(userPd.getAsString("phone")) || userPd.getAsString("phone").length() != 11) {
			mv.setViewName("redirect:/wx/duyun/user/bingphone?bingType=shopCart");
			return mv;
		}*/
		try {
			pd.put("user_id", getUserIdFromSession(request));
			List<PageData> carSkutList = new ArrayList<PageData>();
			List<PageData> cartList = goodsCartService.selectByUserId(pd);
			for(int i = 0; i < cartList.size(); i++){
				//查询销售属性
				PageData data = cartList.get(i);
				data.put("sku_id", data.get("sku_id"));
				if(EAUtil.isNotEmpty(goodsService.queryStockBySkuId(data))){
					data.put("attr_json", goodsService.queryStockBySkuId(data).getAttr_json());
					carSkutList.add(data);
				}
			}
			if(carSkutList.size() == 0){
				mv.setViewName("duyun/shib");
			}else{
				mv.addObject("carSkutList", carSkutList);
				mv.setViewName("duyun/cart");
				mv.addObject("nav_type", "gouwuche");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mv.addObject("pd", pd);
		return mv;
	}
	private String getUserIdFromSession(HttpServletRequest request){
		String user_id = "-2";
		PageData user = getUser(request);
		if(user != null){
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
