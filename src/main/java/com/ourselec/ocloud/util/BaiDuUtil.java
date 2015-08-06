package com.ourselec.ocloud.util;

import net.sf.json.JSONObject;

/** 
 * 百度工具类 
 *  
 * @author Y.lei 
 
 * @date 2015-7-8  
 */  
public class BaiDuUtil {  
    public static String getCity(String lat, String lng) {  
    	System.out.println(getLocationInfo(lat, lng).get("status"));
    	System.out.println(getLocationInfo(lat, lng).get("message"));
        JSONObject obj = getLocationInfo(lat, lng).getJSONObject("result").getJSONObject("addressComponent");  
        String str = obj.getString("city")+obj.getString("district");
        return str;  
    }  
  
    public static JSONObject getLocationInfo(String lat, String lng) {  
        String url = "http://api.map.baidu.com/geocoder/v2/?location=" + lat + ","  
                + lng + "&output=json&ak=" + "61f8bd72d68aef3a7b66537761d29d82"+"&pois=0";  
        JSONObject obj = JSONObject.fromObject(BaiduHttpUtil.getRequest(url));  
        return obj;  
    }  
  
    public static void main(String[] args) {  
    	//116.328203,39.959827
        System.out.println(BaiDuUtil.getCity("39.959858", "116.328233"));  
    }  
}  
