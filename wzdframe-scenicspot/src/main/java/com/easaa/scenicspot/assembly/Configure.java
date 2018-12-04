package com.easaa.scenicspot.assembly;

import com.easaa.core.util.EAString;

/**
 * User: rizenguo
 * Date: 2014/10/29
 * Time: 14:40
 * 这里放置各种配置数据
 */
public class Configure {
	//都匀
	private static String appID = "wxbbbf48bf77396096";//黄道微公众号 wxd1698399bec842cf
	private static String appSecret="0a435a6272b04aab7cee6dec3258e34b";//黄道微wIMnSs3aglpb6ZFMuTu9F8be1pdGFXCRVb8Z3lQ32Bi
	private static String key = "00b38b1993b74701a8eb53c36ea98251";//都匀
	private static String mchID = "1488668502";//都匀
	//HTTPS证书的本地路径
	private static String certLocalPath = "";

	//HTTPS证书密码，默认密码等于商户号MCHID
	private static String certPassword = "";


	//3）退款API
	public static String REFUND_API = "https://api.mch.weixin.qq.com/secapi/pay/refund";

	//4）退款查询API
	public static String REFUND_QUERY_API = "https://api.mch.weixin.qq.com/pay/refundquery";

	public static String getAppID() {
		return appID;
	}

	public static void setAppID(String appID) {
		Configure.appID = appID;
	}

	public static String getAppSecret() {
		return appSecret;
	}

	public static void setAppSecret(String appSecret) {
		Configure.appSecret = appSecret;
	}

	public static String getKey() {
		return key;
	}

	public static void setKey(String key) {
		Configure.key = key;
	}

	public static String getMchID() {
		return mchID;
	}

	public static void setMchID(String mchID) {
		Configure.mchID = mchID;
	}

	public static String getCertLocalPath() {
		return certLocalPath;
	}

	public static void setCertLocalPath(String certLocalPath) {
		Configure.certLocalPath = certLocalPath;
	}

	public static String getCertPassword() {
		return certPassword;
	}

	public static void setCertPassword(String certPassword) {
		Configure.certPassword = certPassword;
	}

	public static String getREFUND_API() {
		return REFUND_API;
	}

	public static void setREFUND_API(String rEFUND_API) {
		REFUND_API = rEFUND_API;
	}

	public static String getREFUND_QUERY_API() {
		return REFUND_QUERY_API;
	}

	public static void setREFUND_QUERY_API(String rEFUND_QUERY_API) {
		REFUND_QUERY_API = rEFUND_QUERY_API;
	}


}
