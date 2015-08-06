package com.ourselec.ocloud.controller.dto;

import java.util.Date;


import java.util.List;


import org.springframework.roo.addon.javabean.RooJavaBean;

import com.ourselec.ocloud.domain.DeviceProperty;
import com.ourselec.ocloud.domain.Vendor;

@RooJavaBean
public class ModelDTO {

	
	
	private Integer id;
	
	private Integer vendor_id;
		
	private String model_name;
	
	private String model_id;

	private String comment;
	
	private String audit_status;
	
	private Integer text_encoding_id;
	
	private Integer binary_encoding_id;

	private String is_enabled;
	
	
	private Date created_at;
	private Vendor vendor;

	private DeviceDTO device;
	
	private List<DeviceProperty> property;
}
