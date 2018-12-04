package wx.easaa.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.easaa.core.util.EAString;
import com.easaa.core.util.WebUtils;
import com.easaa.entity.PageData;
import com.easaa.user.service.UserService;
import com.easaa.util.properties.PropertiesHelper;
import com.easaa.wechat.common.Configure;
import com.easaa.wechat.common.WechatUtil;
import com.easaa.wechat.model.WXPArticle;
import com.easaa.wechat.model.WXPReceivedEventMessage;
import com.easaa.wechat.model.WXPReceivedMessage;
import com.easaa.wechat.model.WXPReceivedTextMessage;
import com.easaa.wechat.model.WXPReplyNewsMessage;
import com.easaa.wechat.model.WXPReplyTextMessage;
import com.easaa.wechat.protocol.WXMessageType;
import com.easaa.wechat.protocol.WXPReceivedMessageParser;
import com.easaa.wechat.protocol.WXPReplyMessageEncapsulator;
import com.easaa.wechatMenu.service.WeChatService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import wx.easaa.controller.comm.BaseController;

/**
 * 微信相关控制层
 * @author Administrator
 *
 */
@RequestMapping(value="/appwx/")
@Controller
public class AppWeChatController  extends BaseController{
	@Resource(name="weChatService")
	private WeChatService weChatService;
	@Resource(name="userService")
	private UserService userService;
	//private String TOKEN = "AISHANGWEIZHOUDAO"; 
	private String TOKEN = "QINHANCHENG";
	@RequestMapping(value = "/chartReply")
	public void valid(HttpServletRequest request, HttpServletResponse response) {
		// 判断是否为校验请求
		String echostr = request.getParameter("echostr");
		/*System.out.println("openid======="+request.getParameter("openid"));*/
		if (EAString.isNullStr(echostr)) {// 非校验
			try {
				parserMessage(request, response);
			} catch (Exception e) {
				this.flushMessage("error", response);
				e.printStackTrace();
			}
		} else {
			checkSignature(request, response);
		}
	}
	
//	@RequestMapping(value = "/testMsg")
//	public void testMsg(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Dto pd=new BaseDto();
//		pd.put("openid", "123");
//		pd.put("create_time", new Date());
//		memberService.subscribe(pd);
//	}
	
	/**
	 * 解析消息
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void parserMessage(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String receivedMessage = readStringFromInputStream(request);
		WXPReceivedMessageParser wmp = new WXPReceivedMessageParser();
		String msgType = wmp.parseWXPReceivedMessageType(receivedMessage);
		if (WXMessageType.TEXT.equals(msgType)) {
			WXPReceivedTextMessage message = wmp.parseWXPReceivedTextMessage(receivedMessage);
			textMessageHandler(message, response);
		} else if (WXMessageType.EVENT.equals(msgType)) {
			WXPReceivedEventMessage message = wmp.parseWXPReceivedEventMessage(receivedMessage);
			this.eventMessageHandler(message, response,request);
		} else {
			System.out.println("未知消息类型!");
		}
		
	}
	
	/**
	 * 文本消息处理
	 * 
	 * @param message
	 * @param response
	 * @throws Exception 
	 */
	private void textMessageHandler(WXPReceivedTextMessage sourceMessage,HttpServletResponse response) throws Exception {
		PageData dto = weChatService.getResultByKeyWord(sourceMessage.getContent());
		pushMessage(sourceMessage,response,dto);
	}
	/** 
	 * 事件消息处理
	 * 
	 * @param message
	 * @param response
	 * @throws Exception 
	 */
	private void eventMessageHandler(WXPReceivedEventMessage message,HttpServletResponse response,HttpServletRequest request) throws Exception {
		String open_id=message.getFromUserId();
		if(message.getEvent().equalsIgnoreCase(WXMessageType.EVENT_VIEW)){
			return ;
		}
		if(message.getEvent().equalsIgnoreCase(WXMessageType.EVENT_SCAN)){
			return ;
		}
		if(message.getEvent().equalsIgnoreCase(WXMessageType.EVENT_UNSUBSCRIBE)){
			userService.unsubscribe(open_id); 
			return ;
		}
		PageData result = null;
		if (message.getEvent().equalsIgnoreCase(WXMessageType.EVENT_SUBSCRIBE)) {//关注账号
			PageData pd=new PageData();
			pd.put("open_id", open_id);
			
			
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	String subtime = sdf.format(new Date(message.getCreateTime()*1000L));
	    	pd.put("subscribe_time", subtime);
	    	JSONObject jsonObj = WechatUtil.readUserInfo(StringUtils.trim(pd.getAsString("open_id")));
	    	pd.put("jsonObj", jsonObj);
	    	userService.subscribe(pd,request);
			result = weChatService.getResultByKeyWord("关注时回复");
			pushMessage(message,response,result);
		} else if (message.getEvent().equalsIgnoreCase(WXMessageType.EVENT_CLICK)) {//点击菜单事件
//			pushMessage(message,response,message.getEventKey());
			PageData menu=weChatService.findMenuByKey(message.getEventKey());
			result = new PageData();
			int menuType=menu.getAsInt("menu_type");//0回复文字 1跳转链接 2回复图文
			result.put("reply_type",menuType);
			result.put("reply_content",menu.get("menu_content"));
			pushMessage(message,response,result);
		}
	}
	/**
	 * 消息回發
	 * @param message
	 * @param response
	 * @param key
	 * @throws Exception
	 */
	private void pushMessage(WXPReceivedMessage message,HttpServletResponse response,PageData dto)throws Exception {
		if(dto!=null){
			if(dto.getAsInt("reply_type")==1){
				List<WXPArticle> articles = new ArrayList<WXPArticle>();
				JSONArray jArray=JSONArray.fromObject(dto.get("reply_content"));
				for(int i=0;i<jArray.size();i++){
					WXPArticle at=new WXPArticle();
					JSONObject json=jArray.getJSONObject(i);
					at.setTitle(json.getString("title"));
					at.setPictureURL(json.getString("img"));
					at.setDesciprtion(json.getString("desc"));
					int author=EAString.stringToInt(json.getString("author"), -1);
					String url=json.getString("url");
					url=url.trim();
					if(author==1){//需要微信授权认证
						at.setArticleURL(WechatUtil.getAuthorUrl(url));
					}else{
						String[] arrSplit=url.split("[?]");
						if(arrSplit.length>1){
							at.setArticleURL(url+"&OpenId="+message.getFromUserId());
						}else{
							at.setArticleURL(url+"?OpenId="+message.getFromUserId());
						}
					}
					articles.add(at);
				}
				pushNewsMessage(message, response, articles);
			}else if(dto.getAsInt("reply_type")==0){
				pushTextMessage(message, response, dto.getAsString("reply_content"));
			}
		}else{
			
		}
	}
	
	/**
	 * 回发图文消息
	 * @param sourceMessage
	 * @param response
	 * @param articles
	 */
	private void pushNewsMessage(WXPReceivedMessage sourceMessage,HttpServletResponse response,List<WXPArticle> articles) {
		WXPReplyNewsMessage message = new WXPReplyNewsMessage();
		message.setFromUserId(sourceMessage.getToUserId());
		message.setToUserId(sourceMessage.getFromUserId());
		message.setArticleAmount(1);
		message.setCreateTime(System.currentTimeMillis());
		message.setFuncFlag(1);
		message.setArticles(articles);
		WXPReplyMessageEncapsulator wme = new WXPReplyMessageEncapsulator();
		String messageStr = wme.getNewsXml(message);
		System.out.println("===微信===开始回发====图文========");
		flushMessage(messageStr, response);
	}
	/**
	 * 回发文本信息
	 * @param sourceMessage
	 * @param response
	 * @param contenStr
	 */
	private void pushTextMessage(WXPReceivedMessage sourceMessage,HttpServletResponse response, String contenStr) {
		WXPReplyTextMessage message = new WXPReplyTextMessage();
		message.setFromUserId(sourceMessage.getToUserId());
		message.setToUserId(sourceMessage.getFromUserId());
		message.setCreateTime(System.currentTimeMillis());
		message.setFuncFlag(1);
		message.setMessageType("transfer_customer_service");
		message.setContent(contenStr);
		WXPReplyMessageEncapsulator wme = new WXPReplyMessageEncapsulator();
		String messageStr = wme.getTextXml(message);
		System.out.println("===微信===开始回发=====文本======="+messageStr);
		flushMessage(messageStr, response);
	}
	
	
	/**
	 * 向请求端发送返回数据
	 * 
	 * @param content
	 */
	public void flushMessage(String content, HttpServletResponse response) {
		try {
			System.out.println("输出数据:::::" + content);
			response.setHeader("Content-type", "text/html;charset=UTF-8");
			response.getWriter().print(content);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 分享链接如果需要用到用户的openid 将分享链接指向这个链接
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("shareRedirect")
	public void shareRedirect(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String share_openid = request.getParameter("share_openid");
		System.out.println("doGet share_openid=" + share_openid);
		String code = request.getParameter("code");
		String productid = request.getParameter("goods_id");
		String baseUrl = request.getParameter("base_url");
		String backUri = PropertiesHelper.getWechatUrl()+"appwx/oauth2?share_openid=" + share_openid
				+ "&productid=" + productid+"&base_url="+baseUrl;
		if (null == code || "".equals(code)) {
			backUri = URLEncoder.encode(backUri);
			String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + "appid=" + Configure.getAppid() + "&redirect_uri="
					+ backUri + "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
			response.sendRedirect(url);
		}
	}
	@RequestMapping(value="oauthPc")
	public void oauthPc(){
		System.out.println("<><><>><><><><oauthPc");
	}
	/**
	 * 微信接口URL跳转
	 * @param actName
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "oauth2", method = RequestMethod.GET)
	public String wechatCallBack(HttpServletRequest request) throws Exception {
		try{
			PageData dto=this.getPageData();
			System.out.println("回调参数：：：："+dto); 
			String code = request.getParameter("code");//
			String openId=WechatUtil.getOpenId(code);//拿到用户的OpenId;
			String shareOpendId = request.getParameter("share_openid"); //分享人的opendid
			System.out.println("OpenId=="+openId);
			/**
			 * 将openid存到数据库
			 */
			PageData pd = new PageData();
			pd.put("open_id", openId);
			
			JSONObject jsonObj = WechatUtil.readUserInfo(StringUtils.trim(openId));
			pd.put("jsonObj", jsonObj);
			if(StringUtils.isNotEmpty(shareOpendId)){ //说明是分享链接 且需要认证的分享链接
				String baseUrl = request.getParameter("base_url");
				String productid = request.getParameter("productid");
				return "redirect:"+baseUrl+"?goods_id="+productid+"&share_openid="+shareOpendId+"&open_id="+openId;
			}else{
				dto.remove("code");
				dto.remove("state");
				dto.remove("actName");
				dto.remove("isappinstalled");
				dto.put("open_id", openId);
				String redirectUrl=WechatUtil.getRedirectUrl(dto.getAsString("zcurl"), dto.getAsInt("dengHaoShu"));//      getActUri("-----------",dto);
				System.out.println("跳转到链接：：：："+redirectUrl);
				dto.remove("zcurl");
				dto.remove("dengHaoShu");
				redirectUrl=getActUri(redirectUrl,dto);
				System.out.println("跳转到链接------"+redirectUrl);
				return "redirect:"+redirectUrl;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	 /**
	 * 票据凭证字符串
	 */
	private static String accessToken;
	/**
	 *  最后刷新时间
	 */
	private static long lastTime;
	@RequestMapping(value = "getToken", method = RequestMethod.GET)
	public void getToken(HttpServletResponse response) throws Exception {
		if(System.currentTimeMillis()-lastTime>7100000){
			try {
				accessToken=WechatUtil.readAccessToken();
				lastTime=System.currentTimeMillis();
			} catch (Exception e) {
				accessToken="";
				e.printStackTrace();
			}
		}
		if(EAString.isNullStr(accessToken)){
			try {
				accessToken=WechatUtil.readAccessToken();
				lastTime=System.currentTimeMillis();
			} catch (Exception e) {
				accessToken="";
				e.printStackTrace();
			}
		}
		flushMessage(accessToken+"##"+lastTime,response);
	}
	
	
	
	/**
	 * 得到认证URL
	 * @param actName
	 * @param dto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String getActUri(String url,PageData dto){
		String[] arrSplit=url.split("[?]");
		if(arrSplit.length>1){
			url =  url+"&"+WebUtils.getUrlParamsByMap(dto);
			return url;
		}else{
			return url+"?"+WebUtils.getUrlParamsByMap(dto);
		}
	}
	
	/**
	 * 校验接口
	 * 
	 * @param request
	 * @param response
	 */
	private void checkSignature(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String signature = request.getParameter("signature");
			String timestamp = request.getParameter("timestamp");
			String nonce = request.getParameter("nonce");
			String echostr = request.getParameter("echostr");
			String[] tmpArr = { TOKEN, timestamp, nonce };
			Arrays.sort(tmpArr);
			String tmpStr = EAString.ArrayToString(tmpArr);
			tmpStr = EAString.SHA1Encode(tmpStr);
			if (tmpStr.equalsIgnoreCase(signature)) {
				this.flushMessage(echostr, response);
			} else {
				this.flushMessage("error", response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			flushMessage("error", response);
		}
	}
	/**
	 * 读出接受到的消息
	 * 
	 * @return
	 * @throws Exception
	 */
	private String readStringFromInputStream(HttpServletRequest request)
			throws Exception {
		// 得到HTTP输入流
		InputStream is = request.getInputStream();
		// 取HTTP请求流长度
		int size = request.getContentLength();
		// 用于缓存每次读取的数据
		byte[] buffer = new byte[size];
		// 用于存放结果的数组
		byte[] xmldataByte = new byte[size];
		int count = 0;
		int rbyte = 0;
		// 循环读取
		while (count < size) {
			// 每次实际读取长度存于rbyte中
			rbyte = is.read(buffer);
			for (int i = 0; i < rbyte; i++) {
				xmldataByte[count + i] = buffer[i];
			}
			count += rbyte;
		}
		is.close();
		// 解析为xml对象
		String requestStr = new String(xmldataByte, "UTF-8");
		return requestStr;
	}
	
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value = "updateUserList", method = RequestMethod.GET)
//	public ModelAndView updateUserList() throws Exception {
//		 JSONObject object=WechatUtil.readUserList("");
//		 int total=object.getInt("total");
//		 int count=object.getInt("count");
//		 JSONObject data=object.getJSONObject("data");
//		 JSONArray openid=data.getJSONArray("open_id");
//		 for(int i=0;i<openid.size();i++){
//			 memberService.saveWXUser(openid.get(i)+"");
//		 }
//		 ModelAndView mv = this.getModelAndView();
//		 mv.addObject("info", object);
//		 mv.setViewName("wechat/info");
//		return mv;
//	}
	
	@RequestMapping(value = "readShareConfig")
	public void readShareConfig(HttpServletResponse response) throws Exception {
		PageData pd=this.getPageData();
		String url=(String) pd.remove("url");
		outJson(response,getShareApi(url,pd,false));
	}
	
	
	@RequestMapping("getAccessToken")
	public void getAccessToken(HttpServletRequest request,HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		out.write(WechatUtil.getAccessToken());
		out.flush();
		out.close();
	}
	
	/**
	 * 提供一个外部访问用户信息的接口
	 * @param args
	 * @throws IOException 
	 */
	@RequestMapping("getUserInfoForMis")
	public void getUserInfoForMis(HttpServletRequest request,HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		String openId = (String) request.getAttribute("openid");
		out.write(WechatUtil.readUserInfo(openId).toString());
		out.flush();
		out.close();
	}
	
	
	public static void main(String[] args) {
		try {
			System.out.println();
			/*System.out.println( WechatUtil.readUserInfo("olnp-wATbstoTu2zusmdxjgqLLSs"));
			System.out.println(Math.round(7.5));
			String url = "http://www.baidu.com/index?share_openid=E8UHEOO9903DNC&uu=12&type=oi";
			String url1 = url.substring(url.indexOf("?")+1, url.length());
			String[] paramAry = url.split("&");
			System.out.println(url+"<><>><<>"+url1);*/
			//System.out.println(EAString.base64Decode("aHR0cDovL3N6c2VlLnR1bm5lbC5xeWRldi5jb213eC9nb29kcy9kZXRhaWw/Z29vZHNfaWQ9MTI1"));
			System.out.println(EAString.base64Encode("http://liujunbo.tunnel.qydev.com/appwx/oauthPc"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
