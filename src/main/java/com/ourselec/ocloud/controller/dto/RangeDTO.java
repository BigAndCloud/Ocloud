package com.ourselec.ocloud.controller.dto;

import java.util.Date;


import org.springframework.roo.addon.javabean.RooJavaBean;

@RooJavaBean
public class RangeDTO {

	private Integer id;
	private String model_id;
	
	private Integer serial_type;
	
	private String range_min;
	
	private String range_max;
	
	private Integer range_width;
	
	private Date created_at;
	
	//接入数量
	private String ap;

}
