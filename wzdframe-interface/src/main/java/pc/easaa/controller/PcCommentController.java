package pc.easaa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.easaa.core.util.Base64;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.upm.service.LinksService;
import com.easaa.user.service.UserAddressService;

import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

@RequestMapping("/comm/")
@Controller
public class PcCommentController  extends BaseController{

	
	@Autowired
	private UserAddressService userAddressService;
	@Autowired
	private LinksService linksService;
	
	/**
	 * 获取用户地址列表
	 */
	@RequestMapping(value = "addressList")
	public void addressList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
			
			List<PageData> addressList = userAddressService.getUserAddressList(EAString.stringToInt(userPd.getAsString("user_id"), 0));
			super.outJson(REQUEST_SUCCESS, "查询成功", addressList, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, "查询失败", null, response);
		}
	}
	
	/**
	 * 创建一条地址信息
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "createAddress")
	public void createAddress(HttpServletRequest request,HttpServletResponse response) throws Exception {
		PageData pd = getPageData();
		String paramStr = pd.getAsString("paramStr");
		String decodeStr = new String(Base64.decode(paramStr),"utf-8");
		JSONObject addressObj = JSONObject.fromObject(decodeStr);
		PageData userPd = (PageData) request.getSession().getAttribute("userInfo");
		pd.put("contact_name", addressObj.get("contact_name"));
		pd.put("contact_phone", addressObj.get("contact_phone"));
		pd.put("province_id", addressObj.get("province_id"));
		pd.put("province", addressObj.get("province"));
		pd.put("city_id", addressObj.get("city_id"));
		pd.put("city", addressObj.get("city"));
		pd.put("area_id", addressObj.get("area_id"));
		pd.put("area", addressObj.get("area"));
		pd.put("address", addressObj.get("address"));
		pd.put("is_default", addressObj.get("is_default"));
		pd.put("user_id", userPd.getAsString("user_id"));
		int row = userAddressService.create(pd);
		if (row > 0) {
			updateDefaultAddress(pd);
			this.outJson(REQUEST_SUCCESS, "地址创建成功", pd, response);
		} else {
			this.outJson(REQUEST_FAILS, "发生未知错误,地址创建失败", null, response);
		}
	}
	/**
	 * 更改默认地址
	 * @param address
	 */
	private void updateDefaultAddress(PageData address){
		if(address.getAsInt("is_default") > 0){//如果是默认地址,那么更新默认地址
			userAddressService.updateDefaultAddress(address.getAsInt("user_id"), address.getAsInt("address_id"));
		}
	}
	/**
	 * 删除地址
	 */
	
	@RequestMapping(value = "delAddress")
	public void delAddress(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			PageData pd = this.getPageData();
			String paramStr = pd.getAsString("paramStr");
			String decodeStr = new String(Base64.decode(paramStr),"utf-8");
			JSONObject addressObj = JSONObject.fromObject(decodeStr);
			pd.put("address_id", addressObj.getString("address_id"));
			userAddressService.delete(pd);
			super.outJson(REQUEST_SUCCESS, "查询成功", null, response);
		}catch(Exception e){
			e.printStackTrace();
			super.outJson(REQUEST_FAILS, "查询失败", null, response);
		}
	}
	/**
	 * 请求友情链接
	 */
	@RequestMapping("frendsLink")
	public void frendsLink(HttpServletResponse response){
		super.outJson(REQUEST_SUCCESS, "查询成功", linksService.getByMap(this.getPageData()), response);
	}
	
}
