package com.ourselec.ocloud.controller.dto;

import java.util.List;

import org.springframework.roo.addon.javabean.RooJavaBean;

import com.ourselec.ocloud.domain.Device;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceProperty;

@RooJavaBean
public class ModelDP {

	private DeviceModel model;
	
	private Device device;
	
	private List<DeviceProperty> property;
	
}
