package com.ourselec.ocloud.util;

import java.util.HashMap;
import java.util.Map;




import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.DeserializationConfig.Feature;

import com.ourselec.ocloud.exception.OurselecException;

import flexjson.JSONDeserializer;

/**
 * JSON转换工具类
 */
public class JsonUtil {

	private static ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * json字符串转换为Map<String,Object>格式
	 * 
	 * @param json
	 * @return
	 */
	public static Map<String, Object> transferJson2Map(String json) {
		if (StringUtils.isBlank(json)) {
			return new HashMap<String, Object>();
		}
		Map<String, Object> result = new JSONDeserializer<Map<String, Object>>().use(null,
				new HashMap<String, Object>().getClass()).deserialize(json);
		return result;
	}

	public static String toJson(Object obj) {
		try {
			return objectMapper.writeValueAsString(obj);
		} catch (Exception e) {
			throw new OurselecException("OrderRequest.toJson error", e);
		}
	}

	public static <T> T fromJsonToObject(String body, Class<T> clazz) {
		try {
			objectMapper.configure(Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			return objectMapper.readValue(body, clazz);
		} catch (Exception e) {
			throw new OurselecException("OrderRequest.fromJsonToOrderRequest error", e);
		}
	}

/*	public static String escapeJavaScript(String s) {
		return StringEscapeUtils.(s);
	}
	
	public static String escapeHTML(String s) {
		return StringEscapeUtils.escapeHtml3(s);
	}*/
}
