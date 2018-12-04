package com.easaa.controller.wechatMenu;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.HttpRequest;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;
import com.easaa.wechatMenu.service.WeChatService;
import com.easaa.wechatMenu.service.WechatMenuService;
import com.easaa.wechatMenu.service.WechatReplyService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("/sys/wechat/")
public class WechatController extends BaseController{
	@Autowired
	private WechatReplyService  wechatReplyService;
	@Autowired
	private WechatMenuService  wechatMenuService;
	@Autowired
	private WeChatService  weChatService;
	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	/**
	 * 关注时回复
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="subscribe")
	public ModelAndView subscribe() throws Exception{
		System.out.println("关注微信时回复<<<<<<<<<<<<");
		ModelAndView mv = this.getModelAndView();
		PageData dto = this.getPageData();
		try {
			dto.put("key_word","关注时回复");
			PageData data= weChatService.findByKw(dto);
			if(data==null){
				data=new PageData();
				data.put("key_word","关注时回复");
				data.put("reply_type", "0");
				data.put("reply_content","欢迎关注");
				data.put("status", 1);
				data.put("creator", getAdminName());
				data.put("crate_time", EADate.date2Str(new Date()));
				weChatService.save(data);
			}
			mv.addObject("pd", data);
			System.out.println("跳转的试图名称是<><>><><><>>><<><>:"+mv.getViewName());
			mv.setViewName("/wechat/subscribe");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mv;
	}
	
	/**
	 * 保存关注时回复
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="saveSubscribe")
	public void saveSubscribe(HttpServletResponse response) throws Exception{
		System.out.println("保存关注时回复<<<<<<<<<<<<<");
		PageData pd = new PageData();
		pd.put("key_word","关注时回复");
		PageData oldData= weChatService.findByKw(pd);
		boolean isExist=oldData!=null;
		pd = this.getPageData();
		if(oldData==null){
			oldData=new PageData();
		}
		oldData.put("key_word","关注时回复");
		oldData.put("reply_type", pd.get("reply_type"));
		oldData.put("reply_content",getRequest().getParameter("data"));
		oldData.put("status", 1);
		oldData.put("creator", getAdminName());
		oldData.put("crate_time", EADate.date2Str(new Date()));
		try {
			if(isExist){//数据库内存在
				weChatService.edit(oldData);
				this.outJson(response, REQUEST_SUCCESS, "更新成功", pd);
			}else{
				weChatService.save(oldData);
				this.outJson(response, REQUEST_SUCCESS, "更新成功", pd);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(response, REQUEST_FAILS, "数据保存时发生错误,错误信息:"+e.getMessage(), pd);
		}
		
	}
	
	/**
	 * 自动回复列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "reply_list")
	public ModelAndView replyList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList=wechatReplyService.getByPage(page);
		mv.addObject("dataList", varList);
		mv.addObject("page", page);
		mv.setViewName("/wechat/reply_list");
		return mv;
	}
	
	/**
	 * 编辑自动回复(新增也用这个方法)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "edit_reply")
	public ModelAndView editReply(ModelMap model) {
		ModelAndView mv = this.getModelAndView();
		String id=getRequest().getParameter("id");
		mv.addObject("dataModel", wechatReplyService.getById(EAString.stringToInt(id, 0)));
		if(EAString.stringToInt(id, 0)>0){
			mv.setViewName("/wechat/edit_news");
		}else{
			mv.setViewName("/wechat/create_news");
		}
		return mv;
	}
	
	/**
	 * 保存自动回复
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "save_reply")
	public void saveReply(HttpServletResponse response) {
		PageData data= this.getPageData();
		String jsonStr = getRequest().getParameter("data");
		String key_word = getRequest().getParameter("key_word");
		data.put("key_word",key_word);
		data.put("reply_type", 1);
		data.put("reply_content", jsonStr);
		data.put("status", 1);
		if(data.getAsInt("id")<=0){//编辑,而非新增
			data.put("creator", getAdminName());
			data.put("create_time", EADate.getCurrentTime());
			wechatReplyService.create(data);
			this.outJson(response, REQUEST_SUCCESS, "新增成功", data);
		}else{
			wechatReplyService.edit(data);
			this.outJson(response, REQUEST_SUCCESS, "修改成功", data);
		}
	}
	
	/**
	 * 删除回复
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="del_reply")
	public String del_reply(HttpServletResponse response) throws Exception{
		PageData pd = this.getPageData();
		wechatReplyService.delete(pd);
		return "redirect:/sys/wechat/reply_list";
	}
	
	
	/**
	 * ====================================================================================================================================
	 * 微信菜单
	 * ====================================================================================================================================
	 */
	
	/**
	 * 菜单列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "menu_list")
	public ModelAndView menuList() {
		ModelAndView mv = this.getModelAndView();
		try {
			List<PageData> menus = wechatMenuService.listRootMenu();
			for(int i=0;i<menus.size();i++){
				menus.get(i).put("subMenu", wechatMenuService.listSubMenu(menus.get(i).getAsInt("id")));
			}
			mv.addObject("menus", menus);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("/wechat/menu_list");
		return mv;
	}
	
	/**
	 * 编辑菜单
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "edit_menu")
	public ModelAndView editMenu() throws Exception {
		ModelAndView mv = this.getModelAndView();
		String id=getRequest().getParameter("id");
		mv.addObject("menus", wechatMenuService.listRootMenu());
		if(!EAString.isNullStr(id)){
			mv.addObject("dataModel", wechatMenuService.getById(EAString.stringToInt(id, 0)));
		}
		mv.setViewName("/wechat/edit_menu");
		return mv;
	}
	
	/**
	 * 保存菜单
	 * @param response
	 */
	@RequestMapping(value = "save_menu")
	public void saveMenu(HttpServletResponse response) {
		PageData data= this.getPageData();
		PageData pd = new PageData();
		pd.put("parent_id", '0');
		Integer count = wechatMenuService.getCount(pd);
		if(data.getAsInt("id")>0){//编辑,而非新增
			int parent_id =Integer.parseInt(data.get("parent_id").toString()); 
			if(parent_id != 0){
				wechatMenuService.edit(data);
				this.outJson(response, REQUEST_SUCCESS, "修改成功", data);
			}else{
				if(count>3){
					this.outJson(response, REQUEST_FAILS, "修改失败，已存在三个一级菜单！！", null);
				}else{
					wechatMenuService.edit(data);
					this.outJson(response, REQUEST_SUCCESS, "修改成功", data);
				}
			}
		}else{
			int parent_id =Integer.parseInt(data.get("parent_id").toString()); 
			if(parent_id != 0){
				data.put("menu_key", "event_key_"+EAString.getSnString());
				data.put("creator", getAdminName());
				data.put("create_time", new Date());
				wechatMenuService.create(data);
				this.outJson(response, REQUEST_SUCCESS, "保存成功", data);
			}else{
				if(count>=3){
					this.outJson(response, REQUEST_FAILS, "请勿继续添加一级菜单，只能存在三个一级菜单！", null);
				}else{
					data.put("menu_key", "event_key_"+EAString.getSnString());
					data.put("creator", getAdminName());
					data.put("create_time", new Date());
					wechatMenuService.create(data);
					this.outJson(response, REQUEST_SUCCESS, "保存成功", data);
				}
			}
		}
	}
	
	/**
	 * 发布菜单
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="releaseMenu")
	public void releaseMenu(HttpServletResponse response){
		JSONArray jArray=new JSONArray();
		try {
			List<PageData> menus=wechatMenuService.listRootMenu();
			for(int i=0;i<menus.size();i++){
				menus.get(i).put("subMenu", wechatMenuService.listSubMenu(menus.get(i).getAsInt("id")));
			}
			for(int i=0;i<menus.size();i++){
				PageData rootMenu=menus.get(i);
				List<PageData> subMenus=rootMenu.getAsList("subMenu");
				JSONObject json=new JSONObject();
				json.put("name", rootMenu.get("menu_name"));
				if(subMenus!=null&&subMenus.size()>0){
					JSONArray sms=new JSONArray();
					for(int j=0;j<subMenus.size();j++){
						sms.add(getJson(subMenus.get(j)));
					}
					json.put("sub_button", sms);
				}else{
					json=getJson(rootMenu);
				}
				jArray.add(json);
			}
			JSONObject button=new JSONObject();
			button.put("button", jArray);
			String msg=createMenu(button.toString());
			if(EAString.equals(msg, "OK")){
				this.outJson(response, REQUEST_SUCCESS, "菜单已成功发布到微信", button.toString());
			}else{
				this.outJson(response, REQUEST_SUCCESS, "菜单发布到微信时发生错误,错误信息:"+msg, button.toString());
			}
		} catch (Exception e) {
			this.outJson(response, REQUEST_FAILS, "菜单发布到微信时发生错误,错误信息:"+e.getMessage(), null);
			e.printStackTrace();
		}
	}
	 /** 
     * 创建菜单 
     */  
    public static String createMenu(String params) throws Exception {  
    	//从接口项目获取accessToken
    	String accessToken = HttpRequest.sendPost(PropertiesHelper.getAccessTokenUrl(), "");
        String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/menu/create?access_token=" + accessToken, params);  
        JSONObject object = JSONObject.fromObject(jsonStr);  
        return object.getString("errmsg");  
    }
	/**
	 * 获取需要认证的URL,重定向URI会被执行Base64编码,
	 * @param redirect_uri
	 * @return
	 */
	public static String getAuthorUrl(String redirect_uri){
		redirect_uri=EAString.base64Encode(redirect_uri);
		int dc=EAString.countOccurrencesOf(redirect_uri, "=");
		String url=EAString.delete(redirect_uri, "=");
    	String wxUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+PROPERTIESHELPER.getValue("APPID")+"&redirect_uri=";
    	if(EAString.isNullStr(redirect_uri)){
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2";
    	}else{
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2?zcurl="+url+"%26dengHaoShu="+dc;
    	}
    	wxUrl=wxUrl+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
    	System.out.println("得到的微信的url为：《》《》》《》《《》》《::::::"+wxUrl);
    	return wxUrl;
    }
	/**
	 * 序列化一个菜单为json
	 * @param pd
	 * @return
	 */
	private JSONObject getJson(PageData pd){
		JSONObject json=new JSONObject();
		json.put("name", pd.get("menu_name"));
		//0回复文字 1跳转链接 2回复图文
		if(pd.getAsInt("menu_type")==2){//跳转地址
			json.put("type","view");
			if(pd.getAsInt("author")==0){
				json.put("url", pd.getAsString("menu_content"));
			}else{
				json.put("url", getAuthorUrl(pd.getAsString("menu_content")));
			}
		}else{
			json.put("type","click");
			json.put("key", pd.getAsString("menu_key"));
		}
		return json;
	}
	
	/**
	 * 删除菜单
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="delMenu")
	public void delMenu(HttpServletResponse response) throws Exception{
		PageData pd = this.getPageData();
		try {
			List<PageData> subMenus = wechatMenuService.listSubMenu(pd.getAsInt("id"));
			if(subMenus!=null && subMenus.size()>0){
				this.outJson(response, REFUSE_ACCESS, "失败,菜单下有子菜单,请先移除所有子菜单", pd);
			}else{
				wechatMenuService.delete(pd);
				this.outJson(response, REQUEST_SUCCESS, "菜单已从微信端移除", pd);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.outJson(response, REQUEST_FAILS, "菜单从微信端移除时发生错误,错误信息:"+e.getMessage(), null);
		}
	}
	
	

}