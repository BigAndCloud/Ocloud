package com.ourselec.ocloud.controller.dto;


import org.springframework.roo.addon.javabean.RooJavaBean;

import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceModelAuditComment;


@RooJavaBean
public class DeviceModelCommentDTO {

	
	private DeviceModel model;
	
	
	private DeviceModelAuditComment DMAC;
}
