package com.ourselec.ocloud.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.controller.dto.DeviceDTO;
import com.ourselec.ocloud.controller.dto.ModelDTO;
import com.ourselec.ocloud.domain.DeveloperInfo;
import com.ourselec.ocloud.domain.Device;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceProperty;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.mysql.OcloudDao;
import com.ourselec.ocloud.service.AssembleDTO;
import com.ourselec.ocloud.util.BaiDuUtil;
import com.ourselec.ocloud.util.GridData;
import com.ourselec.ocloud.util.GridJson;
import com.ourselec.ocloud.util.SessionUtil;

@Controller
@RequestMapping("/device")
public class DeviceController {

	Logger logger = LoggerFactory.getLogger(DeviceController.class);
	
	@Autowired
	OcloudDao dao;
	
	@RequestMapping("/testdevicePage")
	public ModelAndView testdevicePage(ModelAndView view
//			,@RequestParam(value="model_id",required=false)String model_id
			){
			logger.info("/device/testdevice");
			
			view.setViewName("device/testdevice");
			return view;
	}
	
	@RequestMapping("/testdevice")
	public ModelAndView testDevice(ModelAndView view
			,@RequestParam(value="model_id",required=false)String model_id
			,@RequestParam(value="name",required=false)String name
			,@RequestParam(value="alias",required=false)String alias
			,@RequestParam(value="alive_time",required=false)Integer alive_time
			,@RequestParam(value="timezone",required=false)String timezone
			,@RequestParam(value="lat",required=false)Double lat
			,@RequestParam(value="lng",required=false)Double lng
			,@RequestParam(value="comment",required=false)String comment
			,@RequestParam(value="porname",required=false)String[] porname
			,@RequestParam(value="poralias",required=false)String[] poralias
			, HttpServletRequest request
			){
			logger.info("/device/testdeive");
			String errormsg = "添加成功";
			List<Device> list = new ArrayList<Device>();
			Users users= SessionUtil.getUsers(request);
			String user_id = users.getUserid();
			Integer vendorid =null;
			Integer developerid =null;
			
			if (users.getUser_type()==2) {
				vendorid = SessionUtil.getVendor(request).getId();
			}else if (users.getUser_type()==4) {
				 developerid= SessionUtil.getDeveloper(request).getId();				
			}
			try {
				if (porname.length!=poralias.length) {
					errormsg="您少填写了一个属性名或者属性别名，它们是同时存在";
					view.addObject("errormsg", errormsg);
					view.setViewName("device/testdevicePage");
					return view;
					
				}	
			boolean fale = Device.addDevice(name, alias,user_id, alive_time, timezone, lng, lat, comment, "0",vendorid,developerid, model_id,porname,poralias);
			if (!fale) {
				errormsg="添加失败";
				view.addObject("errormsg", errormsg);
				view.setViewName("device/testdevicePage");
				return view;
			}
				list = Device.findByUserid(user_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			view.addObject("list", list);
			view.addObject("errormsg", errormsg);
			
		
		return this.findList(view, request,errormsg);
	}
	
//	@RequestMapping("/addDeviceETPage")
//	public ModelAndView addDeviceETPage(ModelAndView view ){
//		
//		view.setViewName("device/addDeviceETP");
//		return view;
//	}
	
	
	
	@RequestMapping("/findlist")
	public ModelAndView findList(ModelAndView view, HttpServletRequest request
			,@RequestParam(value="errormsg",required=false) String errormsg
			){
		logger.info("/device/findlist");
		
		String user_id = SessionUtil.getUsers(request).getUserid();
		List<Device>  list = Device.findByUserid(user_id);
		
	//List<Map<String, Object>>	map =dao.findDevicePrototype(user_id);
			List<DeviceDTO> listdto = new ArrayList<DeviceDTO>();
	if (list!=null) {
	
		for (Device device : list) {
			DeviceDTO dto = new DeviceDTO();
			dto= AssembleDTO.assembleDeviceDTO(device);
			listdto.add(dto);
		}

	}	
		view.addObject("list", listdto);
		view.addObject("errormsg", errormsg);
		view.setViewName("device/findlist");
		return view;
	}
	
	@RequestMapping("/indevice")
	public ModelAndView inDevice(ModelAndView view
			,@RequestParam(value="id",required = false)Integer id
			){
				
		logger.info("/device/indevice");
		Device device = new Device();
		try {
			device = Device.findDevice(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String  latstr= device.getLat().toString();
		String  lngstr= device.getLng().toString();
		
		String site=	BaiDuUtil.getCity(device.getLat().toString(),device.getLng().toString());
		view.addObject("site", site);
		view.addObject("latstr",latstr);
		view.addObject("lngstr",lngstr);
		view.addObject("device", device);
		view.setViewName("device/updatedevice");
		return view;
	}
	/**
	 * 使用在审批人查看 设备详情
	 * @param view
	 * @param source_id
	 * @return
	 */
	@RequestMapping("/getdevice")
	public ModelAndView getDevice(ModelAndView view
			,@RequestParam(value="source_id",required = false)String source_id
			){
				
		logger.info("/device/indevice");
		Device device = new Device();
		try {
			device = Device.findByDevice_id(source_id);
			DeviceModel model = DeviceModel.findByDeviceId(device.getDevice_id()); 
			ModelDTO dto = AssembleDTO.assembleModelDTO(model, device);
			view.addObject("dto", dto);
			view.setViewName("device/deviceInfo");
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		return view;
	}
	
	@RequestMapping("/updatedevice")
	public ModelAndView updateDevice(ModelAndView view
			,@RequestParam(value="id",required=false) Integer id
			,@RequestParam(value="name",required=false)String name
			,@RequestParam(value="alias",required=false)String alias
			,@RequestParam(value="alive_time",required=false)Integer alive_time
			,@RequestParam(value="timezone",required=false)String timezone
			,@RequestParam(value="lat",required=false)Double lat
			,@RequestParam(value="lng",required=false)Double lng
			,@RequestParam(value="comment",required=false)String comment
			, HttpServletRequest request
			){
		logger.info("/device/updatedevice");
			String errormsg = "编辑成功";
			boolean fale=	Device.updateDevice(id, name, alias, timezone, alive_time, lng, lat,comment);
		if (!fale) {
			errormsg = "编辑失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("device/updatedevice");
		}
		view.addObject("errormsg", errormsg);
		return this.findList(view, request, errormsg);
	}
	
	
	@RequestMapping("/deletedevice")
	public ModelAndView deleteDevice(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			
			, HttpServletRequest request
			){
		logger.info("device/deletedevice");
		String errormsg= "删除成功";
		
		boolean fale=	Device.deleteDevice(id);
		if (!fale) {
			errormsg="删除失败";
			view.addObject("errormsg", errormsg);
			return this.findList(view, request, errormsg);
		}

		view.addObject("errormsg", errormsg);
		return this.findList(view, request, errormsg);
	}
	
	@RequestMapping("/getAPDevice")
	public @ResponseBody GridData<Map<String, Object>> getAPDevice(
			@RequestParam(value="model_id",required=false)String modei_id
			,@RequestParam(value="range_id",required=false)Integer range_id
			,@ModelAttribute("data") GridData<Map<String, Object>> data
			,@RequestParam(value = "pageSize", required=false) Integer pageSize
			,@RequestParam(value = "pageNumber", required=false) Integer pageNumber
			){
		if (pageSize!=null||pageNumber!=null) {
			
			data.setpageNumber(pageNumber-1);
			data.setpageSize(pageSize);	
		}
		StringBuilder builder = new StringBuilder(" where");
		List<Object> params = new ArrayList<Object>();
		builder.append(" 1=1 and");
		builder.append(" o.model_id = ? and");
		builder.append(" o.range_id = ? and");
		params.add(modei_id);
		params.add(range_id);
		if (builder.toString().endsWith("and")) {
			builder.delete(builder.length() - 3, builder.length());
		}
		if (builder.toString().endsWith("where")) {
			builder.delete(builder.length() - 5, builder.length());
		}
		String order = " order by o.created_at limit ?,?";
		try {
			dao.findByMidRid(builder.toString(),params,data,order);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return data;
	}
	@RequestMapping("/getAPDeviceTest")
	public @ResponseBody GridJson<String> getAPDeviceTest(
			@RequestParam(value="model_id",required=false)String modei_id
			,@RequestParam(value="range_id",required=false)Integer range_id
			,@ModelAttribute("data")GridJson<String> data
			,@RequestParam(value = "pageSize", required=false) Integer pageSize
			,@RequestParam(value = "pageNumber", required=false) Integer pageNumber
			){
		
		StringBuilder builder = new StringBuilder(" where");
		List<Object> params = new ArrayList<Object>();
		builder.append(" 1=1 and");
		builder.append(" o.model_id = ? and");
		builder.append(" o.range_id = ? and");
		params.add(modei_id);
		params.add(range_id);
		if (builder.toString().endsWith("and")) {
			builder.delete(builder.length() - 3, builder.length());
		}
		if (builder.toString().endsWith("where")) {
			builder.delete(builder.length() - 5, builder.length());
		}
		String order = " order by o.created_at limit ?,?";
		try {
			dao.findByMidRidTest(builder.toString(),params,data,null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return data;
	}
	
	@RequestMapping("/getDeviceDetails")
	public @ResponseBody GridData<Device> getDeviceDetails(
			@RequestParam(value = "device_id",required=false)String device_id
			,@ModelAttribute("data") GridData<Device> data
			){
		logger.info("device/getDeviceDetails");
		Device device = Device.findByDevice_id(device_id);
		List<Device> list = new ArrayList<Device>();
		list.add(device);
		System.out.println(device.getDevice_id());
		data.setRows(list);
		return data;
		
	} 
	
	
	
	
}
