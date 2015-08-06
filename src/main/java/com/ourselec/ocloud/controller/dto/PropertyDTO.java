package com.ourselec.ocloud.controller.dto;

import java.util.Date;


import java.util.List;

import org.springframework.roo.addon.javabean.RooJavaBean;

import com.ourselec.ocloud.domain.PropertyChannel;

@RooJavaBean
public class PropertyDTO {

	private Integer id;
	
	private String device_model_id;
	
	private String name;
	
	private String alias;
	
	//是否有通道 0：没有 1：有
	private Integer chans;
	
	private Date created_at;
	
	private List<PropertyChannel> channellist;
	
	
	
}
