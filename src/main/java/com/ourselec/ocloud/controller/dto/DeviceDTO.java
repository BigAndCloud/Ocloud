package com.ourselec.ocloud.controller.dto;




import org.springframework.roo.addon.javabean.RooJavaBean;




@RooJavaBean
public class DeviceDTO {
	
	
	
	private Integer id;
	
	private String device_id;
	//'设备名称 可继承自设备模板的来源'
	private String name;
	//'设备别名'
	private String alias;
	
	//'是否激活 0 未激活， 1 已激活'
	private String is_activated;
	//'活跃时间'
	private Integer alive_time;
	//'设备所在时区'
	private String timezone;
	//是否有属性列表 0：没有 1：有
	private Integer pros;
	
	private String model_id;
	
	private String site;
	//'设备备注'
	private String comment;
	
	
	

	
}
