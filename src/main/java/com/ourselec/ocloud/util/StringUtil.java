package com.ourselec.ocloud.util;



import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;





public class StringUtil {

	public static boolean isEmpty(String str) {
		if (StringUtils.isEmpty(str))
			return true;
		if ("".equals(str.trim()))
			return true;
		return false;
	}

	public static boolean isEmpty(Character c) {
		if (null == c)
			return true;
		if ("".equals(c))
			return true;
		return false;
	}

/*	public static boolean isInt(String str) {
		return str.matches("^[0-9]*$");
	}

	// 嗖付支付传过来的金额是"分"
	public static boolean isFen(String str) {
		return str.matches("^[0-9]+$");
	}
	*/
	/**
	 * 结束时间默认为当前时间
	 * @return
	 */
	public static String getEndTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new Date());
	}
	
	public static String join(String split, String... values) {
		StringBuilder builder = new StringBuilder();
		for(String s : values) {
			builder.append(s).append(split);
		}
		if(!isEmpty(split)) {
			builder.deleteCharAt(builder.length() - 1);
		}
		return builder.toString().trim();
	}
	
	/**
	 * 正则对比email
	 * 
	 * @param str
	 * @return
	 */
/*	public static boolean isEmailRule(String  str){
		String Email = "^\\w+[-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
		String normal = Pattern.quote(Email);
		Pattern pattern = Pattern.compile(normal);
		Matcher ma= pattern.matcher(str);
		return ma.matches() ;
	}
	public static void main(String[] args) {
		
		System.out.println( StringUtil.isEmailRule("user@163.com"));
	}*/
	/**
	 * 正则对比passwd规则 
	 * @param str
	 * @return
	 */
	public static boolean isPasswdRule(String str){
		return str.matches("^[a-zA-Z\\d]{6,16}$");
	}
	
	/**
	 * 
	 * @param inPassword 需验证的密码
	 * @param passwd 用户真正的密码
	 * @param salt 盐值
	 * @return
	 */
	

	public static boolean isPassword(String inPassword,String passwd ,String salt){
		 
		
		try {
			return passwd.equals(PaySign.EncoderByMd5(inPassword,salt));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	//减法
	
	public static int subtraction(String max,String min){
	
		int JS = 0;int BJS = 0;int result = 0;
	  JS=Integer.parseInt(max);
	  BJS= Integer.parseInt(min);
	  result=JS-BJS;
	  if (BJS!=0) {
		result= result+1;
	}
		return result;
	}
	
}