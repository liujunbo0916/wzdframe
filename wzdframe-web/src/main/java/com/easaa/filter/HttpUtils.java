package com.easaa.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Set;

public class HttpUtils {

    private static HttpUtils _instance;

    private HttpUtils() {

    }

    public static HttpUtils getInstance() {
        if (_instance == null) {
            _instance = new HttpUtils();
        }
        return _instance;
    }

    /**
     * 发送网络请求，获取返回的Json格式字符串
     *
     * @param url
     * @param params
     * @return
     */

    public static String getHttpStr(String url, Map<String, Object> params) {
        try {
            url = new String(url.getBytes(), "utf-8");
            URL _url = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) _url.openConnection();
            conn.setConnectTimeout(20000);
            conn.setRequestMethod("POST");
            if (params != null) {
                StringBuilder sb = new StringBuilder();
                Set<String> keys = params.keySet();
                for (String string : keys) {
                    sb.append(string).append("=").append(params.get(string))
                            .append("&");
                }

                System.out.print("请求" + sb.toString());
                OutputStream os = conn.getOutputStream();
                os.write(sb.toString().getBytes());
                os.flush();
                os.close();
            }
            // if(conn.getResponseCode()==200){
            StringBuilder resultData = new StringBuilder("");
            InputStreamReader isr = new InputStreamReader(conn.getInputStream());
            // 使用缓冲一行行的读入，加速InputStreamReader的速度
            BufferedReader buffer = new BufferedReader(isr);
            String inputLine = null;

            while ((inputLine = buffer.readLine()) != null) {
                resultData.append(inputLine);
                resultData.append("\n");
            }
            buffer.close();
            isr.close();
            conn.disconnect();
            return resultData.toString();
            // }else{
            // return null;
            // }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return null;
    }

    public static String getHttpPOSTStr(String url) {
        try {
            url = new String(url.getBytes(), "utf-8");
            System.out.println("url=" + url);
            URL _url = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) _url.openConnection();
            conn.setConnectTimeout(20000);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Accept-Charset", "UTF-8");
            if (conn.getResponseCode() == 200) {
                StringBuilder resultData = new StringBuilder("");
                InputStreamReader isr = new InputStreamReader(
                        conn.getInputStream());
                // 使用缓冲一行行的读入，加速InputStreamReader的速度
                BufferedReader buffer = new BufferedReader(isr);
                String inputLine = null;

                while ((inputLine = buffer.readLine()) != null) {
                    resultData.append(inputLine);
                    resultData.append("\n");
                }
                buffer.close();
                isr.close();
                conn.disconnect();
                return resultData.toString();
            } else {
                return null;
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
