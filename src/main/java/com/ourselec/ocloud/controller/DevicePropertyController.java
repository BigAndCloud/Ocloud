package com.ourselec.ocloud.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.controller.dto.PropertyDTO;
import com.ourselec.ocloud.domain.DeviceProperty;
import com.ourselec.ocloud.domain.PropertyChannel;
import com.ourselec.ocloud.service.AssembleDTO;
import com.ourselec.ocloud.util.GridData;
import com.ourselec.ocloud.util.SessionUtil;

@Controller
@RequestMapping("/property")
public class DevicePropertyController {

	Logger logger = LoggerFactory.getLogger(DeviceController.class);
	@RequestMapping("/addpropertyPage")
	public ModelAndView addDeviceProPage(ModelAndView view
			,@RequestParam(value="model_id",required=false)String model_id
			){
		logger.info("property/addpropertyPage");
		view.addObject("model_id", model_id);
		view.setViewName("property/addproperty");
		return view;
	}
	
	
	@RequestMapping("/addproperty")
	public ModelAndView addDevicePro(ModelAndView view
			,@RequestParam(value="name",required=false)String name
			,@RequestParam(value="alias",required=false)String alias
		
			,@RequestParam(value="model_id",required=false)String device_model_id
			
			, HttpServletRequest request
			
			){
		logger.info("property/addproperty");
		String errormsg = "添加成功";
		
		String user_id = SessionUtil.getUsers(request).getUserid();
		boolean  fale2= DeviceProperty.addProperty(name, alias,user_id, device_model_id);
		if (!fale2) {
			errormsg = "添加失败";
			
			view.addObject("errormsg", errormsg);
			view.setViewName("property/addproperty");
			return view;
		}
		view.setViewName("property/addproperty");
		return view;
	}
	
	@RequestMapping("/updatepropertyPage")
	public ModelAndView updatePropertyPage(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			){
		
		
		logger.info("property/updatepropertyPage");
		DeviceProperty property = null;// DeviceProperty.findDeviceProperty(id);
		view.addObject("property", property);
		view.setViewName("property/updateproperty");
		return view;
	}
	
	@RequestMapping("/updateproperty")
	public ModelAndView updateProperty(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			,@RequestParam(value="name",required=false)String name
			,@RequestParam(value="alias",required=false)String alias
		
			,@RequestParam(value="device_id",required=false)String device_id
			,@RequestParam(value="device_model_id",required=false)String device_model_id
			){
		String errormsg = "修改成功";
			boolean fale = DeviceProperty.updateDevicePropery(id, name, alias, device_model_id, device_id);
			if (!fale) {
				errormsg = "修改失败";
				
				view.addObject("errormsg", errormsg);
				view.setViewName("property/updateproperty");
				return view;
			}
		
		
		return view;
	}
	/**
	 * 删除属性 只是修改了一下 删除时间而已
	 * @param view
	 * @param id
	 * @return
	 */
	
	@RequestMapping("/deleteproperty")
	public ModelAndView deletePropertyPage(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			){
		
		String errormsg = "删除成功";
		logger.info("property/deletepropertyPage");
		boolean fale= false;//DeviceProperty.deleteById(id);
		if (!fale) {
			errormsg = "删除失败";
			
			view.addObject("errormsg", errormsg);
			view.setViewName("property/deleteproperty");
			return view;
		}
		view.addObject("errormsg", errormsg);
		view.setViewName("property/deleteproperty");
		return view;
	}
	

	@RequestMapping("/propertylistPage")
	public ModelAndView propertyListPage(ModelAndView view
			,@RequestParam(value="model_id",required=false)String model_id
		
			) {
		List<DeviceProperty> propertys = new ArrayList<DeviceProperty>();
		List<PropertyDTO> listdto = new ArrayList<PropertyDTO>();
		try {
		propertys= DeviceProperty.findListByModel_id(model_id);
				String errormsg = "查询成功";
				if (propertys==null) {
					errormsg = "没有数据,您可以现在添加 属性";
					view.addObject("errormsg", errormsg);
					view.setViewName("property/propertylist");
				}
				for (DeviceProperty property : propertys) {
					PropertyDTO dto =AssembleDTO.assemblePropertyDTO(property);
					listdto.add(dto);
				}
				
				
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	view.addObject("list", listdto);
	view.setViewName("property/propertylist");
		return view;
	}
	
/*	@RequestMapping("/propertylist")
	public ModelAndView propertyList(ModelAndView view
			, HttpServletRequest request
			) {
		String user_id=	SessionUtil.getUsers(request).getUserid();
			String errormsg = "查询成功";
			List<DeviceProperty> list = DeviceProperty.findList(user_id);
			
			
			if (list==null) {
				errormsg = "没有数据,您可以现在添加 属性";
				view.addObject("errormsg", errormsg);
				view.setViewName("property/propertylist");
			}
			view.addObject("list", list);
			view.setViewName("property/propertylist");
		return view;
	}*/
	
	@RequestMapping("/getProChan")
	public GridData<PropertyChannel> getProChan(
			
			@RequestParam(value="property_id",required=false)Integer property_id
			,@ModelAttribute("data")GridData<PropertyChannel> data
			){
		logger.info("/property/getProChan");
			List<PropertyChannel> list = PropertyChannel.findListByPropertyid(property_id);
			data.setRows(list);
		return data;
	}
	
}
