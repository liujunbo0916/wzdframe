package com.easaa.scenicspot.assembly;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.KeyStore;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.xml.sax.SAXException;

import com.easaa.core.util.MD5;
import com.easaa.entity.PageData;
import com.tencent.WXPay;
import com.tencent.common.RandomStringGenerator;
import com.tencent.common.XMLParser;
public class PayRefund {
	public static  PageData wxRefund(String totalFee,String refundFee ,String billNo,String outRefundNo) throws ParserConfigurationException, IOException, SAXException{
		PageData resultParam = new PageData();
		List<NameValuePair> signParams = new LinkedList<NameValuePair>();
		WXPay.initSDKConfiguration(null, Configure.getAppID(), Configure.getMchID(), null, null, null);
		String totalmoney = String.format("%.0f",
				BigDecimal.valueOf(Double.parseDouble(totalFee)).doubleValue() * 100); // 订单总金额（元）
		String refundMoney = String.format("%.0f",
				BigDecimal.valueOf(Double.parseDouble(refundFee)).doubleValue() * 100); // 退款总金额（元）
		signParams.add(new BasicNameValuePair("appid", Configure.getAppID())); // 应用ID
		signParams.add(new BasicNameValuePair("mch_id", Configure.getMchID())); // 商户号
		String nonce_str = RandomStringGenerator.getRandomStringByLength(32);
		signParams.add(new BasicNameValuePair("nonce_str", nonce_str)); // 随机字符串
		signParams.add(new BasicNameValuePair("out_refund_no", outRefundNo)); // 商户退款单号
		signParams.add(new BasicNameValuePair("out_trade_no", billNo)); // 商户订单号
		signParams.add(new BasicNameValuePair("refund_fee", refundMoney)); // 退款金额
		signParams.add(new BasicNameValuePair("total_fee", totalmoney)); // 总金额
		String sign = PayRefund.genPackageSign(signParams);
		signParams.add(new BasicNameValuePair("sign", sign)); // 签名
		String result=null;
		try {
			result = doRefund(Configure.REFUND_API,PayRefund.toXml(signParams));
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> mapdata = XMLParser.getMapFromXML(result);
		if (mapdata != null && "SUCCESS".equals(mapdata.get("return_code"))) {
			resultParam.put("out_trade_no", mapdata.get("out_trade_no"));
			resultParam.put("out_refund_no", mapdata.get("out_refund_no"));
			resultParam.put("refund_id", mapdata.get("refund_id"));
			resultParam.put("refund_fee", mapdata.get("refund_fee"));
			resultParam.put("total_fee", mapdata.get("total_fee"));
			resultParam.put("cash_fee", mapdata.get("cash_fee"));
			resultParam.put("refund_result", "SUCCESS");
			return resultParam;
		}
		resultParam.put("refund_result", "FAIL");
		return resultParam;
	}
	
	
	/**
	 * 退款调用证书
	 */
	public static String doRefund(String url, String data) throws Exception {
        KeyStore keyStore = KeyStore.getInstance("PKCS12");
        FileInputStream is = new FileInputStream(new File("C:/apiclient_cert.p12"));
        try {
            keyStore.load(is, Configure.getMchID().toCharArray());// 这里写密码..默认是你的MCHID
        } finally {
            is.close();
        }
        SSLContext sslcontext = SSLContexts.custom()
                .loadKeyMaterial(keyStore, Configure.getMchID().toCharArray())// 这里也是写密码的
                .build();
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext, new String[] { "TLSv1" }, null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom()
                .setSSLSocketFactory(sslsf).build();
        try {
            HttpPost httpost = new HttpPost(url); // 设置响应头信息
            httpost.addHeader("Connection", "keep-alive");
            httpost.addHeader("Accept", "*/*");
            httpost.addHeader("Content-Type",
                    "application/x-www-form-urlencoded; charset=UTF-8");
            httpost.addHeader("Host", "api.mch.weixin.qq.com");
            httpost.addHeader("X-Requested-With", "XMLHttpRequest");
            httpost.addHeader("Cache-Control", "max-age=0");
            httpost.addHeader("User-Agent",
                    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
            httpost.setEntity(new StringEntity(data, "UTF-8"));
            CloseableHttpResponse response = httpclient.execute(httpost);
            try {
                HttpEntity entity = response.getEntity();

                String jsonStr = EntityUtils.toString(response.getEntity(),
                        "UTF-8");
                EntityUtils.consume(entity);
                return jsonStr;
            } finally {
                response.close();
            }
        } finally {
            httpclient.close();
        }
    }
	
	public static String toXml(List<NameValuePair> params) throws UnsupportedEncodingException {
		StringBuilder sb = new StringBuilder();
		sb.append("<xml>");
		for (int i = 0; i < params.size(); i++) {
			sb.append("<" + params.get(i).getName() + ">");
			sb.append(params.get(i).getValue());
			sb.append("</" + params.get(i).getName() + ">");
		}
		sb.append("</xml>");
		System.out.println("xml<><><><><><><>><><><>" + sb.toString());
		return sb.toString();
	}
	/**
	 * 微信签名
	 * @param params
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String genPackageSign(List<NameValuePair> params) throws UnsupportedEncodingException {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < params.size(); i++) {
			sb.append(params.get(i).getName());
			sb.append('=');
			sb.append(params.get(i).getValue());
			sb.append('&');
			System.out.println("key:" + params.get(i).getName() + "    value:" + params.get(i).getValue());
		}
		sb.append("key=");
		sb.append(Configure.getKey());
		System.out.println(Configure.getKey());
		String sign =  MD5.MD5Encode(sb.toString(), "utf-8").toUpperCase();
		System.out.println(sign);
		return sign;
	}
	
}
