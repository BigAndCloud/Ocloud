package com.ourselec.ocloud.controller.dto;

import org.springframework.roo.addon.javabean.RooJavaBean;

/**
 * 封装菜单
 * @author ourselec.Y.Lei
 *
 */
@RooJavaBean
public class RescourceDTO {

	
	
	private Integer id;

	private String name;
	
	private String url;
	
	//跳转位置（ url默认都跳转到context）
	private String target; 
	
	//是否隐藏 默认为false（不隐藏）
	private boolean isHidden;
}
