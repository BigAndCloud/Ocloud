package com.ourselec.ocloud.controller.dto;



import org.springframework.roo.addon.javabean.RooJavaBean;

import com.ourselec.ocloud.domain.UserInfo;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;


/**
 * 封装用户信息 
 * @author ourselec
 *
 */
@RooJavaBean
public class UserInfoDTO {

	private Users users;
	private UserInfo userinfo;
	private Vendor vendor;
}
