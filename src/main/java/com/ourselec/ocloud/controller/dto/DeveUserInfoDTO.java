package com.ourselec.ocloud.controller.dto;

import java.util.Date;



import org.springframework.roo.addon.javabean.RooJavaBean;



@RooJavaBean
public class DeveUserInfoDTO {

	private Integer id;
	private String username;
	
	private String vendor_id;
	
	/**
	 * 与 usr中的 user_id 外键
	 */
	private String developer_user;
	
	private String is_accepted;
	
	private Date created_at;
	
	private Date updated_at;
	
}
