package com.ourselec.ocloud.controller.dto;

import java.util.Date;

import javax.persistence.Column;

import org.springframework.roo.addon.javabean.RooJavaBean;

@RooJavaBean
public class VendorDTO {


	private String  user_id;
	
	//厂商自己定义的一个 特定的标识
	private String  vendor_id;

	//公司名称
	private String  company_name;

//	审核状态
	private String  audit_status;
//	是否启用
	private String  is_enabled;
	
	private Date  created_at;
}
