package com.ourselec.ocloud.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

//本方法md5后   (加32位随机字符串UUID)  编码
public class PaySign {
	public static String EncoderByMd5(String str,String salt) throws NoSuchAlgorithmException, UnsupportedEncodingException{
      //确定计算方法
      MessageDigest md5=MessageDigest.getInstance("MD5");
     // BASE64Encoder base64en = new BASE64Encoder();
      //加密后的字符串
     // String newstr=base64en.encode(md5.digest(str.getBytes("utf-8")));
      /**
       * 加32位随机字符串 包含数字和字母
       */
      String newstr = null;
      if (salt!=null) {

		newstr = str+salt;
      }else{
       newstr = str+UUID.randomUUID().toString();
       }
      String endstr = byteToHex(md5.digest(newstr.getBytes("utf-8")));
      return endstr;
  }
	
	
		
	
	//本方法md5后作为16进制输出
	public static String Md5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException{
      //确定计算方法
      MessageDigest md5=MessageDigest.getInstance("MD5");
      //加密后的字符串
      String newstr=byteToHex(md5.digest(str.getBytes("utf-8")));
      return newstr;
  } 
	//转换成16进制字符串
  private static String byteToHex(byte[] b) {
  	String hs="";
      String stmp="";

      for (int n=0;n<b.length;n++) {
          stmp=(java.lang.Integer.toHexString(b[n] & 0XFF));
          if (stmp.length()==1) hs=hs+"0"+stmp;
          else hs=hs+stmp;
          //if (n<b.length-1)  hs=hs+":";
      }
      return hs.toUpperCase();
  }
}
