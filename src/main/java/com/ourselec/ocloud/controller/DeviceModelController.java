package com.ourselec.ocloud.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.controller.dto.DeveUserInfoDTO;
import com.ourselec.ocloud.controller.dto.DeviceDTO;
import com.ourselec.ocloud.controller.dto.DeviceModelCommentDTO;
import com.ourselec.ocloud.controller.dto.ModelDTO;
import com.ourselec.ocloud.controller.dto.PropertyDTO;
import com.ourselec.ocloud.controller.dto.RangeDTO;
import com.ourselec.ocloud.domain.DeveloperInfo;
import com.ourselec.ocloud.domain.Device;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceModelAuditComment;
import com.ourselec.ocloud.domain.DeviceModelRange;
import com.ourselec.ocloud.domain.DeviceProperty;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.mysql.OcloudDao;
import com.ourselec.ocloud.service.AssembleDTO;
import com.ourselec.ocloud.util.BaiDuUtil;
import com.ourselec.ocloud.util.GridData;
import com.ourselec.ocloud.util.SessionUtil;
import com.ourselec.ocloud.util.StringUtil;

@Controller
@RequestMapping("/deviceModel")
public class DeviceModelController {

	Logger logger = LoggerFactory.getLogger(DeviceModelController.class);

	@Autowired
	OcloudDao dao;
	
	@RequestMapping("/addmodelPage")
	public ModelAndView addModelPage(ModelAndView view, HttpServletRequest request
			){
		Users user = SessionUtil.getUsers(request);
	String user_id =	user.getUserid();
	Vendor vendor = new Vendor();
	DeveUserInfoDTO  deve=  new DeveUserInfoDTO(); 
	List<DeveUserInfoDTO> deveList = new ArrayList<DeveUserInfoDTO>();
	if (user.getUser_type()==2) {
		vendor = Vendor.findByuserid(user_id);
		deveList = DeveloperInfo.findByVendorid(vendor.getVendor_id());
	}else{
		 deve = DeveloperInfo.findByuseridMap(user_id);
		 deveList.add(deve);
		 vendor= Vendor.findByvendorid(deve.getVendor_id());
	}
//	List<Device> devices= Device.findByUserid(user_id);
	view.addObject("vendor", vendor);
	view.addObject("deveList", deveList);
	view.addObject("user_id", user_id);
	view.setViewName("deviceModel/addModel");
		return view;
	}
	
	/**
	 * 操作权限 （开发者、厂商）
	 * @param view
	 * @param developer_id
	 * @param vendor_id
	 * @param comment
	 * @param model_name
	 * @param model_id  相当于 模型别名 是String类型
	 * @param source_id ==device_id (特指开发者接入的测试设备)
	 * @param picture
	 * @param request 
	 * @return
	 */
	@RequestMapping("/addmodel")
	public ModelAndView addModel(ModelAndView view 
			,@RequestParam(value="developer_id",required=false)Integer developer_id	
			,@RequestParam(value="vendor_id",required=false)Integer vendor_id	
			,@RequestParam(value="comment",required=false)String comment
			,@RequestParam(value="model_name",required=false)String model_name
			,@RequestParam(value="model_id",required=false)String model_id
//			,@RequestParam(value="source_id",required=false)String source_id
			,@RequestParam(value="company_name",required=false)String company_name
			,@RequestParam(value="text_encoding_id",required=false)Integer text_encoding_id
			,@RequestParam(value="binary_encoding_id",required=false)Integer binary_encoding_id
			,@RequestParam(value="picture",required=false)String picture, HttpServletRequest request
			
			){
		
		String errormsg = "已生成模板";
		
		boolean fale = DeviceModel.addModel(developer_id,vendor_id,model_name,model_id,null,text_encoding_id,binary_encoding_id,picture,comment);
		
		if (!fale) {
			errormsg="生成模板失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("deviceModel/addmodel");
			return view;
		}

		view.addObject("errormsg", errormsg);
		return this.modelListVendor(view, request,errormsg);
	}
	
	
	
	
	//操作权限 厂商 可以提交审批
	@RequestMapping("/modelListVendor")
	public ModelAndView modelListVendor(ModelAndView view, HttpServletRequest request
			,@RequestParam(value="errormsg",required=false)String errormsg
			){
		logger.info("/devicemdoel/modelListVendor");

		Integer vendorid= SessionUtil.getVendor(request).getId();
	
		List<DeviceModel>  list= DeviceModel.findListByVenId(vendorid);
		List<DeviceModelCommentDTO> listDTO = new ArrayList<DeviceModelCommentDTO>();
		try {
			
			for (DeviceModel model : list) {
				DeviceModelAuditComment DMAC = DeviceModelAuditComment.findByModelId(model.getId());
				
				DeviceModelCommentDTO dto = new DeviceModelCommentDTO();
				dto.setModel(model);
				if (DMAC==null) {
					dto.setDMAC(null);
				}else {
					dto.setDMAC(DMAC);
				}
				
				listDTO.add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (list==null) {
			errormsg="没有生成的模型";
			view.addObject("errormsg", errormsg);
			view.setViewName("deviceModel/modelListVendor");
		}
		
		view.addObject("list", listDTO);
		view.addObject("errormsg", errormsg);
		view.setViewName("deviceModel/modelListVendor");
		
		return view;
	}
	
	//操作权限 开发者 不可以提交审批
		@RequestMapping("/modelListDeve")
		public ModelAndView modelListDeve(ModelAndView view, HttpServletRequest request
				){
			logger.info("/devicemdoel/modelListDeve");
			String errormsg= "";
			Integer deveid= SessionUtil.getDeveloper(request).getId();
			List<DeviceModel> list= DeviceModel.findListByDeveId(deveid);
			if (list==null) {
				errormsg="没有生成的模型";
				view.addObject("errormsg", errormsg);
				view.setViewName("deviceModel/modelListDeve");
					
			}
			view.addObject("list", list);
			view.addObject("errormsg", errormsg);
			view.setViewName("deviceModel/modelListDeve");
			
			return view;
		}
			//进入需要提交的设备模型详细信息页面
		
		
		//提交已生成的设备模型申请
		
		
		
		
		/**
		 * 权限：厂商
		 * 进入 需要审核的信息详情页面
		 * @param view
		 * @param id
		 * @return
		 */
		@RequestMapping("/toupdateModelSubmitAudit")
		public ModelAndView toupdateModelSubmitAudit(ModelAndView view
				,@RequestParam(value="id",required=false)Integer id	
				){
			
			DeviceModel model = DeviceModel.findDeviceModel(id);
			Vendor vendor = Vendor.findVendor(model.getVendor_id());
			List<DeveUserInfoDTO> deveList = new ArrayList<DeveUserInfoDTO>();
			deveList = DeveloperInfo.findByVendorid(vendor.getVendor_id());
			List<String> deveUsername = new ArrayList<String>(); 
			for (DeveUserInfoDTO DTO : deveList) {
				deveUsername.add(DTO.getDeveloper_user());
			}
			deveUsername.add(vendor.getUser_id());
			List<Device> devices= Device.findByUserid(deveUsername);
			List<DeviceModelAuditComment> DMAC = DeviceModelAuditComment.findList(id);
			if (DMAC==null) {
				view.addObject("DMAC", null);
			}else{
				view.addObject("DMAC", DMAC);
			}
			view.addObject("deveList", deveList);
			view.addObject("devices", devices);
			view.addObject("vendor", vendor);
			view.addObject("model", model);
			view.setViewName("deviceModel/submitModelInfo");
			return view;
		}
		
	/**
	 * 使用权限 厂商
	 * 修改设备模型信息并提交审核
	 * @param view
	 * @param modelid
	 * @param audit_status
	 * @param audit_comment
	 * @param request,errormsg 
	 * @param is_enabled
	 * @param submit_by
	 * @return
	 */

	@RequestMapping("/updateModelSubmitAudit")
	public ModelAndView updateModelAudit(ModelAndView view
			,@RequestParam(value="comment",required=false)String comment
			,@RequestParam(value="model_name",required=false)String model_name
			,@RequestParam(value="model_id",required=false)String model_id
			,@RequestParam(value="source_id",required=false)String source_id
			,@RequestParam(value="picture",required=false)String picture
			,@RequestParam(value="id",required=false)Integer device_model_id	
			,@RequestParam(value="audit_status",required=false)String audit_status	
			,@RequestParam(value="developer_id",required=false)Integer developer_id
			,@RequestParam(value="vendorid",required=false)Integer vendorid
			,@RequestParam(value="audit_comments",required=false)String audit_comment, HttpServletRequest request
			
			){
		
		logger.info("deviceModel/updateModelSubmitAudit");
		String errormsg = "提交成功";
		boolean fale = DeviceModelAuditComment.submitAudit( comment,model_name,model_id,source_id,picture,device_model_id, audit_comment,developer_id,vendorid, "0", audit_status, "0");
		if (!fale) {
			errormsg = "提交失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("deviceModel/submitModelInfo");
		}
		view.addObject("errormsg", errormsg);
		view.setViewName("deviceModel/submitModelInfo");
		return this.modelListVendor(view, request,errormsg);
	}
	
	
	@RequestMapping("/batchProductionPage")
	public ModelAndView batchProductionPage(ModelAndView view
			, HttpServletRequest request
			
			){
	 Vendor vendor=	SessionUtil.getVendor(request);
	 List<DeviceModel> model = DeviceModel.findListByVenId(vendor.getId());
//	 List<DeviceModelRange> ranges = DeviceModelRange.findByModelid(model.get(0).getId());
	 	view.addObject("model", model);
		view.setViewName("AP/batchProduction");
		return view;
	}
	
	
	/**
	 * 添加接入设备
	 * @param request 
	 */
	
	@RequestMapping("/batchProduction")
	public ModelAndView batchProduction(ModelAndView view
			,@RequestParam(value="num",required=false)Integer num
			,@RequestParam(value="ranges",required=false)Integer rangeid
			,@RequestParam(value="model_id",required=false)Integer modelid, HttpServletRequest request
			){
		String user_id= SessionUtil.getUsers(request).getUserid();
			try {
				Device.batchPro(rangeid,num,modelid, user_id);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		view.setViewName("AP/batchProduction");
		return view;
	}
	
	/**
	 * 进入审核成功的设备模板详情列表
	 * @param request 
	 */
	@RequestMapping("/sucmodelListPage")
	public ModelAndView sucmodelListPage(ModelAndView view, HttpServletRequest request
			){
		
		logger.info("deviceModel/sucmodelListPage");
	Vendor vendor = SessionUtil.getVendor(request);
	List<DeviceModel> list = DeviceModel.findListByVenIdSuc(vendor.getId());
	List<ModelDTO> models = new ArrayList<ModelDTO>(); 
	try {
		for (DeviceModel model : list) {
			Device device = Device.findByDevice_id(model.getSource_id());
			ModelDTO modeldto = AssembleDTO.assembleModelDTO(model,device);
			
			models.add(modeldto);
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	view.addObject("list", models);
	view.setViewName("deviceModel/sucmodelList");
		return view;
	}
	@RequestMapping("/sucdetailsListPage")
	public ModelAndView sucdetailsListPage(ModelAndView view
			,@RequestParam(value="model_id",required= false)String model_id
			) {
		String errormsg="查询成功";
		logger.info("deviceModel/sucdetailsListPage");
		try {
			Map<String, Object> list = dao.findSucModel_id(model_id);
			if (list==null) {
				errormsg="没有数据";
				view.addObject("errormsg", errormsg);
				view.setViewName("deviceModel/sucdetailsList");
				return view;
			}
			String lng= list.get("lng").toString();
			String lat= list.get("lat").toString();
			String site = BaiDuUtil.getCity(lat, lng);
			
			Integer modelid = DeviceModel.findByModel_id(model_id).getId();
			Integer result= DeviceModelRange.countByModelidNum(modelid);
			Integer num = dao.countDeviceByModel_idAll(model_id);

			List<DeviceModelRange> deviceranges = DeviceModelRange.findByModelidList(modelid);
			if (deviceranges==null) {
				errormsg="没有数据";
				view.addObject("errormsg", errormsg);
				view.setViewName("deviceModel/sucdetailsList");
				return view;
			}
			List<RangeDTO> ranges = new ArrayList<RangeDTO>();
			for (DeviceModelRange deviceModelRange : deviceranges) {
					RangeDTO dto = new RangeDTO();
					String max = deviceModelRange.getRange_max();
					String min = deviceModelRange.getRange_min();
					Integer temp = StringUtil.subtraction(max, min);
					Integer temp1=  dao.countDeviceByModel_id(model_id,deviceModelRange.getId());
					dto.setAp(temp1+" / "+temp);
					dto.setCreated_at(deviceModelRange.getCreated_at());
					dto.setId(deviceModelRange.getId());
					dto.setModel_id(model_id);
					dto.setRange_max(max);
					dto.setRange_min(min);
					dto.setRange_width(deviceModelRange.getRange_width());
					dto.setSerial_type(deviceModelRange.getSerial_type());
					ranges.add(dto);
					
			}			
			view.addObject("site", site);
			view.addObject("model_id", model_id);
			view.addObject("ranges", ranges);
			view.addObject("num", num);
			view.addObject("result",result);
			view.addObject("list", list);
			view.addObject("errormsg", errormsg);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		view.setViewName("deviceModel/sucdetailsList");
		return view;
	}
	
	@RequestMapping("/modelListTestPage")
	public ModelAndView modelListTestPage(ModelAndView view
			, HttpServletRequest request){
		logger.info("deviceModel/modelListTestPage");
		String errormsg = "查询成功";
		Users users= SessionUtil.getUsers(request);
	List<Device> list=	Device.findByUserid(users.getUserid());
	
	if (list==null) {
		errormsg="没有生成的模型";
		view.addObject("errormsg", errormsg);
		view.setViewName("deviceModel/modelListTest");
		return view;
	}

	view.setViewName("deviceModel/modelListTest");
		return view;
	}

	/**
	 * 普通用户 添加device后自动生成的model
	 * @param request 
	 * @param view
	 * @return
	 */
	@RequestMapping("/mdp")
	public @ResponseBody GridData<ModelDTO> mdp(
			@ModelAttribute("data") GridData<ModelDTO> data, HttpServletRequest request
			){
		logger.info("deviceModel/mdp");
	
		Users users= SessionUtil.getUsers(request);
		List<Device> list=	Device.findByUserid(users.getUserid());
		
		List<ModelDTO> listdto = new ArrayList<ModelDTO>();
	
		
		
		try {
			for (Device device : list) {
				ModelDTO dto = new ModelDTO();
				DeviceModel model =DeviceModel.findByModel_id(device.getModel_id());
				dto.setId(model.getId());
				dto.setAudit_status(model.getAudit_status());
				dto.setComment(model.getComment());
				dto.setCreated_at(model.getCreated_at());
				dto.setIs_enabled(model.getIs_enabled());
				dto.setModel_id(model.getModel_id());
				dto.setModel_name(model.getModel_name());
				DeviceDTO devicedto = AssembleDTO.assembleDeviceDTO(device);
				dto.setDevice(devicedto);
				dto.setProperty(DeviceProperty.findListByModel_id(model.getModel_id()));
				listdto.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		data.setRows(listdto);
		return data;
	}
	
	@RequestMapping("/getPro")
	public @ResponseBody GridData<DeviceProperty> getPro(
			@RequestParam(value="model_id",required=false)String model_id
			,@ModelAttribute("data")GridData<DeviceProperty> data
			){
		logger.info("deviceModel/getPro");
		try {
			DeviceModel model =DeviceModel.findByModel_id(model_id);
			
			data.setRows(DeviceProperty.findListByModel_id(model.getModel_id()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	@RequestMapping("/modelInfo")
	public ModelAndView modelInfo(ModelAndView view
			,@RequestParam(value="model_id",required=false)String model_id){
		logger.info("/deviceModel/modelInfo");
		DeviceModel model = DeviceModel.findByModel_id(model_id);
		
		Device device = Device.findByDevice_id(model.getSource_id());
		ModelDTO dto = AssembleDTO.assembleModelDTO(model,device);
		view.addObject("dto", dto);
		view.setViewName("deviceModel/modelInfo");
		return view;
	}
	@RequestMapping("/addModelsuccess")
	public ModelAndView addModelsuccess(ModelAndView view,HttpServletRequest req, HttpServletResponse resp){
		logger.info("deviceModel/addModelsuccess");
		String user_id= req.getParameter("user_id");
		System.out.println(user_id);
		view.setViewName("deviceModel/success");
		return view;
	}
}
