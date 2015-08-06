package com.ourselec.ocloud.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.domain.PropertyChannel;
import com.ourselec.ocloud.util.StringUtil;

@Controller
@RequestMapping("/channel")
public class PropertyChannelController {

	Logger logger = LoggerFactory.getLogger(PropertyChannelController.class);
	@RequestMapping("/addchannelPage")
	public ModelAndView addChannelPage(ModelAndView view 
			,@RequestParam(value="channel_type",required=false)String channel_type
			,@RequestParam(value="property_id",required=false)Integer property_id
			){
		logger.info("/channel/addchannelPage");
		view.addObject("channel_type", channel_type);
		view.addObject("property_id", property_id);
		view.setViewName("channel/addchannel");
		return view;
	}
	

	
	
	@RequestMapping("/addchannel")
	public ModelAndView addChannel(ModelAndView view
			,@RequestParam(value="name",required=false)String name
			,@RequestParam(value="alias",required=false)String alias
			,@RequestParam(value="description",required=false)String description
			,@RequestParam(value="base_type",required=false)Integer base_type
			,@RequestParam(value="base_type_id",required=false)Integer base_type_id
			,@RequestParam(value="dynamic_flag",required=false)String dynamic_flag
			,@RequestParam(value="channel_type",required=false)String channel_type
			,@RequestParam(value="property_id",required=false)Integer property_id
			){
			String errormsg = "添加成功";
		
			boolean fale= PropertyChannel.addProChannel(name, alias, description,
					channel_type, dynamic_flag, base_type, base_type_id,property_id);
			
				if (!fale) {
					errormsg = "添加失败";
					view.addObject("errormsg", errormsg);
					view.setViewName("channel/addchannel");
				}
				view.addObject("errormsg", errormsg);
//				view.setViewName("channel/channellist");
			
				return this.channelList(view, property_id,errormsg);
	}
	
	@RequestMapping("/channellist")
	public ModelAndView channelList(ModelAndView view
			,@RequestParam(value="property_id",required=false)Integer property_id 
			,@RequestParam(value="errormsg",required=false)String errormsg
			) {
		if (StringUtil.isEmpty(errormsg)) {
			 errormsg = "查询成功";	
		}
			List<PropertyChannel> channel1 = PropertyChannel.findList(property_id,"0");
			List<PropertyChannel> channel2 = PropertyChannel.findList(property_id,"1");
			if (channel1==null&&channel2==null) {
				errormsg = "没有数据";
				view.addObject("property_id", property_id);
				view.addObject("errormsg", errormsg);
				view.setViewName("channel/channellist");
				return view;
			}

			view.addObject("property_id", property_id);
			view.addObject("channel1", channel1);
			view.addObject("channel2", channel2);
			view.setViewName("channel/channellist");
		return view;
	}
	
	@RequestMapping("/updatechannelPage")
	public ModelAndView updateChannelPage(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			){
		logger.info("channel/updateChannelPage");
		PropertyChannel channel = PropertyChannel.findPropertyChannel(id);
		view.addObject("channel",channel);
		view.setViewName("channel/updatechannel");
		return view;
	}
	
	@RequestMapping("/updatechannel")
	public ModelAndView updateChannel(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			,@RequestParam(value="description",required=false)String description
			,@RequestParam(value="base_type",required=false)Integer base_type
			,@RequestParam(value="base_type_id",required=false)Integer base_type_id
			,@RequestParam(value="dynamic_flag",required=false)String dynamic_flag
			,@RequestParam(value="channel_type",required=false)String channel_type
			,@RequestParam(value="property_id",required=false)Integer property_id
			){
			String errormsg = "修改成功";
		
			boolean fale= PropertyChannel.updateProChannel(id, description, channel_type, dynamic_flag, base_type, base_type_id);
			
				if (!fale) {
					errormsg = "修改失败";
					view.addObject("errormsg", errormsg);
					view.setViewName("channel/addchannel");
				}
				PropertyChannel channel = PropertyChannel.findPropertyChannel(id);
				view.addObject("channel", channel);
				view.addObject("errormsg", errormsg);
				view.setViewName("channel/channellist");
				return view;
	}
	
	@RequestMapping("/deletechannel")
	public ModelAndView deleteChannel(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			){
		String errormsg="删除成功";
		PropertyChannel channel = PropertyChannel.findPropertyChannel(id);
			boolean fale = PropertyChannel.deleteProChannel(id);
			if (!fale) {
				errormsg="删除失败";
				view.addObject("errormsg", errormsg);
				view.setViewName("/channel/channellist");
				return this.channelList(view, channel.getProperty_id(),errormsg);
			}
			
		return this.channelList(view, channel.getProperty_id(),errormsg);
	}
	
	
}
