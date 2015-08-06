package com.ourselec.ocloud.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.consts.ResponseData;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceModelRange;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.util.SessionUtil;

@Controller
@RequestMapping("/range")
public class DeviceModelRangeController {

	
	Logger logger = LoggerFactory.getLogger(DeviceModelRangeController.class);
	
	@RequestMapping("/addRangePage")
	public ModelAndView addRangePage(ModelAndView view
			, HttpServletRequest request){
		logger.info("range/addRangepage");
		
		try {
			Vendor vendor =  SessionUtil.getVendor(request);
			List<DeviceModel> model = DeviceModel.findListByVenId(vendor.getId());
			view.addObject("model", model);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		view.setViewName("devicerange/addRange");
		return view;
	}
	
	
	@RequestMapping("/addRange")
	public ModelAndView addRange(ModelAndView view
			,@RequestParam(value="model_id",required=false) Integer model_id
			,@RequestParam(value="serial_type",required=false) Integer serial_type
			,@RequestParam(value="range_min",required=false) String range_min
			,@RequestParam(value="range_max",required=false) String range_max
			,@RequestParam(value="range_width",required=false) Integer range_width
			,@RequestParam(value="description",required=false) String description
			, HttpServletRequest request
			){
		
		logger.info("/range/addRange");
		String errormsg="添加设备序列号范围成功";
		try {
			DeviceModelRange.addRange(model_id, serial_type, range_min, range_max, range_width, description);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		Vendor vendor =  SessionUtil.getVendor(request);
		List<DeviceModel> model = DeviceModel.findListByVenId(vendor.getId());
		view.addObject("model", model);
		view.addObject("errormsg", errormsg);
		view.setViewName("range/addRange");
		return view;
	}
	@RequestMapping("/getRangs")
	public @ResponseBody ResponseData getRangs(@RequestParam(value="modelid",required=false)Integer modelid){
		logger.info("/getRanges");
		ResponseData rd = new ResponseData();
		List<DeviceModelRange> ranges = new ArrayList<DeviceModelRange>();
		String errorCode ="0";
		try {
			ranges = DeviceModelRange.findByModelid(modelid);
		} catch (Exception e) {
			errorCode="1";
			e.printStackTrace();
		}
		rd.setErrorCode(errorCode);
		rd.setValue(ranges);
		return rd;
	}
}
