package com.easaa.wechat.common;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import org.apache.commons.codec.net.URLCodec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.entity.Template;
import com.easaa.util.properties.PropertiesHelper;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;
public final class WechatUtil {
	private static Logger log = LoggerFactory.getLogger(WechatUtil.class);
    /**
	 * 票据凭证字符串
	 */
	private static String accessToken;
	/**
	 *  最后刷新时间
	 */
	private static long lastTime;
//	  private static String myTokenUrl="http://mis.know.edu.cn/appwx/getToken";
	/**
	 * 读取token
	 * @return
	 */
	public static String getAccessToken() {
		System.out.println("读取TOKEN");
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
		System.out.println("accessToken="+accessToken);
		return accessToken;
	}
	public final static String qrcode_ticket_url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=systoken";
	/**
	 * 生产推广二维码
	 * @param scene_id
	 * @return
	 */
	public static JSONObject getQRCodeTicket(int scene_id) { 
		String data="{\"action_name\": \"QR_LIMIT_SCENE\", \"action_info\": {\"scene\": {\"scene_id\":"+scene_id+"}}}";
	    String requestUrl = qrcode_ticket_url.replace("systoken", getAccessToken());  
	    JSONObject jsonObject = httpRequest(requestUrl, "POST", data);  
	    // 如果请求成功  
	    if (null != jsonObject) {  
	        try {  
	        	return jsonObject;
	        } catch (JSONException e) {  
	        	e.printStackTrace();
	            // 获取token失败  
	            log.error("获取二维码ticket失败 errcode:{} errmsg:{}", jsonObject.getString("errcode"), jsonObject.getString("errmsg"));  
	        }  
	    }  
	    return null;  
	}
	/** 
     * 获取accessToken  微信授权登陆
     */  
    public static String readAccessTokenApp(String code) throws Exception {  
    	System.out.println("读取ACCESS——TOKEN");
        String jsonStr=HttpRequest.sendPost(Configure.getAccessTokenUrl(Configure.getAppid(), Configure.getAppSecret(),code), "");
        //String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");  
        System.out.println(jsonStr);
        JSONObject object = JSONObject.fromObject(jsonStr);  
        String accessToken=object.getString("access_token");
        return accessToken;  
    } 
	
	
	
	/** 
     * 获取accessToken 
     */  
    public static String readAccessToken() throws Exception {  
    	System.out.println("读取ACCESS——TOKEN");
        String jsonStr=HttpRequest.sendPost(Configure.getAccessTokenUrl(Configure.getAppid(), Configure.getAppSecret()), "");
        
        //String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");  
        System.out.println(jsonStr);
        JSONObject object = JSONObject.fromObject(jsonStr);  
        String accessToken=object.getString("access_token");
       
        return accessToken;  
    } 
    
    
    
    
    
    /**
     * 读取会员列表
     * @param accessToken
     * @throws Exception
     */
    public static JSONObject readUserList(String next_openid) throws Exception {
    	 System.out.println("读取readUserList");
    	try{
    		String jsonStr=new String(HttpRequest.sendPost(Configure.getUserListUrl(getAccessToken(),next_openid),"").getBytes(),"utf-8");  
		    System.out.println(jsonStr);
    		JSONObject object = JSONObject.fromObject(jsonStr);  
		    System.out.println(object);
		    return object;
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
    	return null;
    	
    }
    /**
     * 读取会员基础信息
     * @param accessToken
     * @param openId
     * @throws Exception
     */
    public static JSONObject readUserInfo(String openId) {
		String jsonStr = "";
		try {
			jsonStr = new String(com.easaa.core.util.HttpRequest.sendGet(Configure.getUserInfoUrl(getAccessToken(), openId), "").getBytes("ISO8859-1"),
					"UTF-8"); // 更改字符串编码
			JSONObject object = JSONObject.fromObject(jsonStr);
			System.out.println(object);
			String nickName = EAUtil.isEmpty(object.getString("nickname")) ? "GSF" + System.currentTimeMillis()
					: object.getString("nickname");
			//object.put("nickname", Base64.encodeBase64String(nickName.getBytes()));
			object.put("nickname", nickName);
			// 如果名称中有表情符 则去掉表情符
			/*if(containsEmoji(nickName)){
				nickName = filterEmoji(nickName);
				object.put("nickname", new String(nickName));
			}*/
		/*	if (nickName != null) {
				byte[] exclude_text = nickName.getBytes();
				for (int i = 0; i < exclude_text.length; i++) {
					if ((exclude_text[i] & 0xF8) == 0xF0) {
						for (int j = 0; j < 4; j++) {
							exclude_text[i + j] = 0x30;
						}
						i += 3;
					}
				}
				object.put("nickname", new String(exclude_text));
			}*/
			return object;
		} catch (Exception e) {
			// 防止昵称乱码 将符号 乱掉
			String[] jsonAry = jsonStr.split(",");
			StringBuffer sb = new StringBuffer();
			for (String s : jsonAry) {
				if (s.indexOf("nickname") != -1) {
					s = s + "\"";
				}
				sb.append(s + ",");
			}
			jsonStr = sb.subSequence(0, sb.length() - 1).toString();
			System.out.println("异常之后的用户信息：《》》《》《》《》"+jsonStr);
			JSONObject object = JSONObject.fromObject(jsonStr);
			String nickName = EAUtil.isEmpty(object.getString("nickname")) ? "GSF" + System.currentTimeMillis()
					: object.getString("nickname");
			
			object.put("nickname", nickName);
			//object.put("nickname", Base64.encodeBase64String(nickName.getBytes()));
			// 如果名称中有表情符 则去掉表情符
			/*if(containsEmoji(nickName)){
				nickName = filterEmoji(nickName);
				object.put("nickname", new String(nickName));
			}*/
			/*	if (nickName != null) {
				byte[] exclude_text = nickName.getBytes();
				for (int i = 0; i < exclude_text.length; i++) {
					if ((exclude_text[i] & 0xF8) == 0xF0) {
						for (int j = 0; j < 4; j++) {
							exclude_text[i + j] = 0x30;
						}
						i += 3;
					}
				}
				object.put("nickname", new String(exclude_text));
			}*/
			return object;
		}
	}
    /**
     * JSAPI凭证
     * @return
     */
    public static String getJsapiTicket() {
		try {
			String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket";
			String jsonStr = HttpRequest.sendGet(url,"access_token="+getAccessToken()+"&type=jsapi");  
			JSONObject object = JSONObject.fromObject(jsonStr);
			System.out.println("读取getJsapiTicket==" + jsonStr);
			return object.getString("ticket");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
    /**
     * 创建一个用于微信浏览器的票据对象
     * @param url
     * @return
     */
    public static Map<String, String> createShareTicket(String url) {
    	String access_token=getAccessToken();
		String jsapi_ticket=getJsapiTicket();
		Map<String, String> api=new HashMap<String, String>();
		api.put("access_token", access_token);
		api.put("jsapi_ticket", jsapi_ticket);
		Map<String, String> ret = sign(jsapi_ticket,url);//);
		api.put("timestamp",ret.get("timestamp"));
		api.put("nonceStr",ret.get("nonceStr"));
		api.put("signature",ret.get("signature"));
		api.put("appId",Configure.getAppid());
		System.out.println("创建微信API，微信分享：：：：："+api);
		System.out.println("创建微信API，微信分享链接地址：：：：："+url);
		return api;
    }
    /**
	 * 网页授权获取用户OpenID
	 */
	public static String getOpenId(String code) {
		try {
			String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
					+ Configure.getAppid()
					+ "&secret="
					+ Configure.getAppSecret()
					+ "&code="
					+ code
					+ "&grant_type=authorization_code";
			String jsonStr = HttpRequest.sendPost(url, "");
			JSONObject object = JSONObject.fromObject(jsonStr);
			System.out.println("读取OPEN-ID==" + jsonStr);
			return object.getString("openid");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "-1";
	}
	 /** 
     * 创建菜单 
     */  
    public static String createMenu(String params) throws Exception {  
        String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/menu/create?access_token=" + getAccessToken(), params);  
        JSONObject object = JSONObject.fromObject(jsonStr);  
        return object.getString("errmsg");  
    }
    
    /** 
     * 查询设置的行业信息
     */  
    public static String getIndustryInfo() throws Exception {  
        String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/template/get_industry?access_token=" + getAccessToken(),"");  
        return jsonStr;  
    }
    
    /** 
     * 根据模板编号查询模板Id并添加编号对应的模板
     */  
//    public static String getAddTemplate(String template_id_short) throws Exception {  
//    	StringBuffer buffer = new StringBuffer();  
//        buffer.append("{");
//        buffer.append(String.format("\"template_id_short\":\"%s\"", template_id_short));
//        buffer.append("}");
//        String jsonStr = "https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token=" + getAccessToken();  
//        JSONObject jsonResult=httpRequest(jsonStr, "POST", buffer.toString());
//        return jsonResult.getString("template_id");  
//    }
    
    /** 
     * 查询所有模板列表
     */  
    public static String getPtemplateInfo() throws Exception {  
        String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/template/get_all_private_template?access_token=" + getAccessToken(),"");  
        return jsonStr;  
    }
    
    /**
     * 发送模板消息
     * @param token
     * @param template
     * @return
     */
    public static boolean sendTemplateMsg(Template template){  
    	try {
    		boolean flag=false;  
            
            String jsonStr = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + getAccessToken();
            JSONObject jsonResult=httpRequest(jsonStr, "POST", template.toJSON());  
            if(jsonResult!=null){  
                int errorCode=jsonResult.getInt("errcode");  
                String errorMessage=jsonResult.getString("errmsg");  
                if(errorCode==0){  
                    flag=true;  
                }else{  
                    System.out.println("模板消息发送失败:"+errorCode+","+errorMessage);  
                    flag=false;  
                }  
            }  
            return flag;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
            
    }  
    
    public static void main(String[] args) throws Exception {
//    	String ss = "{\"button\":[{\"name\":\"个人中心\",\"sub_button\":[{\"name\":\"活动\",\"type\":\"click\",\"key\":\"event_key_6977165\"}]},{\"name\":\"图文\",\"type\":\"click\",\"key\":\"event_key_8051873\"}]}";
//    	String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/menu/create?access_token=" + getAccessToken(),ss);  
//    	System.out.println(jsonStr);
    	
    	//调用发送模板消息方法
    /*	Template tem=new Template();  
    	tem.setTemplateId("ZoePAAjmnxfuwcapMkXmlUcx6rZRFMUfjUJuwVZ4rts"); 
    	tem.setToUser("oVHxjwSJIR4NpKa9BM99VzWYT8Ao");  
    	tem.setUrl("http://szsee.tunnel.2bdata.com/wechat/activity/actList");  
    	          
    	List<TemplateParam> paras=new ArrayList<TemplateParam>();  
    	paras.add(new TemplateParam("first","我们已收到您的货款，开始为您打包商品，请耐心等待: )","#FF3333"));  
    	paras.add(new TemplateParam("time",""+EADate.date2Str(new Date()),"#0044BB"));  
    	paras.add(new TemplateParam("ip","￥999.9","#0044BB")); 
    	paras.add(new TemplateParam("reason","感谢你对我们商城的支持!!!!","#AAAAAA"));   
    	          
    	tem.setTemplateParamList(paras);  
    	          
    	boolean result=sendTemplateMsg(tem);  */
    	//System.out.println(EAString.base64Decode("aHR0cDovL2xpdWp1bmJvLnR1bm5lbC5xeWRldi5jb20vd3gvdXNlci91c2VyQ2VudGVy"));
    	
    	//{"subscribe":1,"openid":"o6ZmsxPx9R4pWsQup13kY_ZIgQW0","nickname":"碎碎�?,"sex":1,
    	//"language":"zh_CN","city":"Shenzhen","province":"Guangdong","country":"China",
    	//"headimgurl":"http:\/\/wx.qlogo.cn\/mmopen\/1vXBaLCyoh7vGY92N6siacDkwOw3Dh6vTDe0K5ECMPrGYCpGu0aglQrALwnGUghc5Ujib9BpsFrgcyIE0ZQNDyEg\/0",
    	//"subscribe_time":1491379541,"remark":"","groupid":0,"tagid_list":[]}
    	//调用根据模板编号查询模板Id并添加编号对应的模板方法
//    	String s = getAddTemplate("TM00202");
//    	System.out.println(s);
    	
    	//JSONObject obj = getQRCodeTicket(123);
    	//System.out.println(obj);
    	
    	//System.out.println(URLEncoder.encode("http://www.qhysctrip.cn/wx/loginCallBack"));
        String jsonStr=HttpRequest.sendPost(Configure.getAccessTokenUrl("wx23b97d10c773bffa", "76810a3525fe95611edca10492ff815a"), "");
        //String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");  
        System.out.println(jsonStr);
        JSONObject object = JSONObject.fromObject(jsonStr);  
        String accessToken=object.getString("access_token");
        System.out.println(accessToken);
    	
	}
    
    /** 
     * 查询菜单 
     */  
    public static String getMenuInfo() throws Exception {  
        String jsonStr = HttpRequest.sendPost("https://api.weixin.qq.com/cgi-bin/menu/get?access_token=" + getAccessToken(),"");  
        return jsonStr;  
    }
    /**
     * 签名
     * @param jsapi_ticket
     * @param url
     * @return
     */
    public static Map<String, String> sign(String jsapi_ticket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";
        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + url;
        System.out.println("微信签名字符串::::::::"+string1);
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);

        return ret;
    }
    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
    /**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl 请求地址
	 * @param requestMethod 请求方式（GET、POST）
	 * @param outputStr 提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();
			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			System.out.println("JSON Source String="+buffer);
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
//			log.error("https request error:{}", e);
			e.printStackTrace();
		}
		return jsonObject;
	}
	
	/**
	 * 将map转换成url
	 * @param map
	 * @return
	 */
	public static String getUrlParamsByMap(Map<String, Object> map) {
		if (map == null) {
			return "";
		}
		StringBuffer sb = new StringBuffer();
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			sb.append("%26");
			sb.append(entry.getKey() + "=" + entry.getValue());
		}
		String s = sb.toString();
		if (s.endsWith("&")) {
			s = org.apache.commons.lang.StringUtils.substringBeforeLast(s, "&");
		}
		return s;
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
    	String wxUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+Configure.getAppid()+"&redirect_uri=";
    	if(EAString.isNullStr(redirect_uri)){
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2";
    	}else{
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2?zcurl="+url+"%26dengHaoShu="+dc;
    	}
    	wxUrl=wxUrl+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
		System.out.println("《》《》《》得到微信的url："+wxUrl);
    	return wxUrl;
    }
	/**
	 * 重写微信认证url
	 * 
	 */
	public static String getAuthorUrlUserInfo(String redirect_uri){
		redirect_uri=EAString.base64Encode(redirect_uri);
		int dc=EAString.countOccurrencesOf(redirect_uri, "=");
		String url=EAString.delete(redirect_uri, "=");
    	String wxUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+Configure.getAppid()+"&redirect_uri=";
    	if(EAString.isNullStr(redirect_uri)){
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2";
    	}else{
    		wxUrl=wxUrl+PropertiesHelper.getWechatUrl()+"appwx/oauth2?zcurl="+url+"%26dengHaoShu="+dc;
    	}
    	wxUrl=wxUrl+"&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
		System.out.println("《》《》《》得到微信的url："+wxUrl);
    	return wxUrl;
    }
	
	/**
	 * pc授权登陆
	 * 
	 */
	public static String getPcAuthorUrl(String redirect_uri){
		redirect_uri = URLEncoder.encode(redirect_uri);
    	String wxUrl=Configure.QRCONNECT+"?appid="+Configure.getAppid()+"&redirect_uri="+redirect_uri;
    	wxUrl=wxUrl+"&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
    	return wxUrl;
	}
	/**
	 * 获取需要认证的URL,重定向URI会被执行Base64编码,
	 * @param redirect_uri
	 * @return
	 */
	public static String getRedirectUrl(String redirect_uri,int dengHaoShu){
		for(int i=0;i<dengHaoShu;i++){
			redirect_uri=redirect_uri+"=";
		}
		redirect_uri=EAString.base64Decode(redirect_uri);
		return redirect_uri;
    }
	/**
	 * 根据url获取指定的参数
	 * 
	 */
	public static PageData getParamValueByUrl(String redirectUrl) {
		String paramUrl = redirectUrl.substring(redirectUrl.indexOf("?")+1, redirectUrl.length());
		String[] paramAry = paramUrl.split("&");
		PageData paramMap = new PageData();
		for(String s : paramAry){
			String[] singleParam = s.split("=");
			paramMap.put(singleParam[0], singleParam[1]);
		}
		return paramMap;
	}
	public static String getMediaInfo(String s) {
		String url = "https://api.weixin.qq.com/cgi-bin/media/get?access_token="+getAccessToken()+"&media_id="+s;
		return HttpRequest.sendGetForMedia(url, null);
	}
	
	
	
}
