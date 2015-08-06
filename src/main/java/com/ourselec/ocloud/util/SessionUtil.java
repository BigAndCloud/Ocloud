package com.ourselec.ocloud.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ourselec.ocloud.domain.DeveloperInfo;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;

public class SessionUtil {

	public static Users getUsers(HttpServletRequest request){
		HttpSession session = request.getSession();
		String sessionid= request.getRequestedSessionId();
		Users users = (Users) session.getAttribute("users"+sessionid);
		return users==null?null:users;
	}
	
	public static Vendor getVendor(HttpServletRequest request){
		HttpSession session = request.getSession();
		String sessionid= request.getRequestedSessionId();
		Vendor vendor = (Vendor) session.getAttribute("vendor"+sessionid);
		return vendor==null?null:vendor;
	}
	
	
	
	public static DeveloperInfo getDeveloper(HttpServletRequest request){
		HttpSession session = request.getSession();
		String sessionid= request.getRequestedSessionId();
		DeveloperInfo developer = (DeveloperInfo) session.getAttribute("developer"+sessionid);
		return developer==null?null:developer;
	}
	
}
