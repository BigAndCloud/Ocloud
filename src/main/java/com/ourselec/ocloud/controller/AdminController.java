package com.ourselec.ocloud.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.controller.dto.ModelDTO;
import com.ourselec.ocloud.domain.Device;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceModelAuditComment;
import com.ourselec.ocloud.domain.Messages;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.mysql.OcloudDao;
import com.ourselec.ocloud.service.AssembleDTO;
import com.ourselec.ocloud.util.StringUtil;


@Controller
@RequestMapping("/admin")
public class AdminController {

	private Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	OcloudDao dao;
	@RequestMapping("/vendorAuditPage")
	public ModelAndView vendorAuditPage(ModelAndView view
			,@RequestParam(value="audit_status",required=false)String audit_status
			,@RequestParam(value="errormsg",required=false)String errormsg
			){
		
		logger.info("/admin/vendorauditPage");
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String where  = "";
		try {
			
			if (!StringUtil.isEmpty(audit_status)) {
				where=" where o.audit_status= "+audit_status;
			}
		list=	dao.findByAudit_status(where);
//			list = Vendor.findByAudit_status(audit_status);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (list==null) {
			errormsg = "没有提交的厂商申请";
			view.addObject("errormsg", errormsg);
			view.setViewName("admin/vendorAudit");
			return view;
		}
		view.addObject("list", list);
		view.addObject("errormsg", errormsg);
		view.setViewName("admin/vendorAudit");
		return view;
	}
	/**
	 * 按条件查询申请厂商的记录
	 * @param view
	 * @param username
	 * @param audit_status
	 * @param vendor_id
	 * @param company_industry
	 * @param is_enabled
	 * @param createtime
	 * @param endtime
	 * @return
	 */
	@RequestMapping("/vendorAuditSearch")
	public ModelAndView vendorAudit(ModelAndView view
			,@RequestParam(value="username",required=false)String username
			,@RequestParam(value="audit_status",required=false)String audit_status
			,@RequestParam(value="vendor_id",required=false)String vendor_id
			,@RequestParam(value="company_industry",required=false)String company_industry
			,@RequestParam(value="is_enabled",required=false)String is_enabled
			,@RequestParam(value="createtime",required=false)String createtime
			,@RequestParam(value="endtime",required=false)String endtime
			){
		
		logger.info("/admin/vendoraudit");
		String errormsg = "";
		StringBuilder builder = new StringBuilder(" where 1=1 ");
		List<Object> param = new ArrayList<Object>();
		if (!StringUtil.isEmpty(username)) {
			builder.append(" and u.user_name = ? ");
			param.add(username);
		}
		if (!StringUtil.isEmpty(audit_status)) {
			builder.append("  and o.audit_status = ?  ");
			param.add(audit_status);
		}
		if (!StringUtil.isEmpty(vendor_id)) {
			builder.append("  and o.vendor_id = ?  ");
			param.add(vendor_id);
		}
		if (!StringUtil.isEmpty(company_industry)) {
			builder.append("  and  o.company_industry = ?  ");
			param.add(company_industry);
		}
		if (!StringUtil.isEmpty(is_enabled)) {
			builder.append("  and o.is_enabled = ?  ");
			param.add(is_enabled);
		}
		if (!StringUtil.isEmpty(createtime)) {
			builder.append("  and o.created_at >= ? ");
			param.add(createtime);
		}
		if (!StringUtil.isEmpty(endtime)) {
			builder.append("  and o.created_at <= ? ");
			param.add(endtime);
		}
		
		
		List<Map<String,Object>> list = Vendor.findList(builder.toString(),param);
		if (list==null) {
			errormsg = "没有提交的厂商申请";
			view.addObject("errormsg", errormsg);
			view.setViewName("admin/vendorAudit");
			return view;
		}
		view.addObject("list", list);
		view.addObject("errormsg", errormsg);
		view.setViewName("admin/vendorAudit");
		return view;
	}
	/**
	 * 进入审核厂商详细列表中
	 * @param view
	 * @param id 厂商的id（自动生成的id变化）
	 * @return
	 */
	@RequestMapping("/toVendorAudit")
	public ModelAndView toVendorAudit(ModelAndView view
			,@RequestParam(value="id",required= false)Integer id
			){
		logger.info("admin/toVendorAudit");
		Vendor vendor = Vendor.findVendor(id);
		Users users = Users.findByUserid(vendor.getUser_id());
		view.addObject("users", users);
		view.addObject("vendor", vendor);
		view.setViewName("admin/auditVendorInfo");
		return view;
	}
	
	@RequestMapping("/vendorAudit")
	public ModelAndView vendorAudit(ModelAndView view
		,@RequestParam(value="id",required=false)Integer vendorid
		,@RequestParam(value="audit_comments",required=false)String audit_comments
		,@RequestParam(value="user_id",required=false)String user_id
		,@RequestParam(value="audit_status",required=false)String audit_status	
		,@RequestParam(value="is_enabled",required=false)String is_enabled
		,@RequestParam(value="submit_by",required=false)String submit_by
			) {
		String errormsg="审核完成";
		if (audit_status.equals("8")) {
			audit_comments="已同意 您厂商的申请 ";
		}
		try {
			Messages.addMessages("admin", user_id, 1,audit_comments,"申请厂商");
			Vendor.updateVendorStatus(vendorid,audit_status,is_enabled);
		} catch (Exception e) {
			logger.error(e.getMessage());
			errormsg="审核失败";
		}
		view.addObject("errormsg", errormsg);
		return this.vendorAuditPage(view, null,errormsg);
	}
	
	
	
	@RequestMapping("/deviceModelAuditPage")
	public ModelAndView deviceModelAuditPage(ModelAndView view
		,@RequestParam(value="audit_status",required=false)String audit_status
		,@RequestParam(value="errormsg",required=false)String errormsg
		){
			
		logger.info("/admin/vendoraudit");
	

		List<ModelDTO> modeldto = new ArrayList<ModelDTO>();
		try {
			List<DeviceModel> list = DeviceModel.findByAudit_status(audit_status);
			if (list==null) {
				errormsg = "没有提交的设备模型申请";
				view.addObject("errormsg", errormsg);
				view.setViewName("admin/devicemodelAudit");
				return view;
			}
			for (DeviceModel model : list) {
				Device device = Device.findByDevice_id(model.getSource_id());
				ModelDTO dto = AssembleDTO.assembleModelDTO(model, device);
				modeldto.add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		view.addObject("list", modeldto);
		view.addObject("errormsg", errormsg);
		view.setViewName("admin/devicemodelAudit");
		return view;
	}
	
	@RequestMapping("/deviceModelAudit")
	public ModelAndView deviceModelAudit(ModelAndView view
		,@RequestParam(value="audit_status",required=false)String audit_status
		,@RequestParam(value="vendor_id",required=false)Integer vendor_id
		,@RequestParam(value="model_name",required=false)String model_name
		,@RequestParam(value="is_enabled",required=false)String is_enabled
		,@RequestParam(value="createtime",required=false)String createtime
		,@RequestParam(value="endtime",required=false)String endtime
			){
			
		logger.info("/admin/vendoraudit");
		String errormsg = "";
		List<Object> param = new ArrayList<Object>();
		StringBuilder builder = new StringBuilder(" where 1=1 ");
	
		if (!StringUtil.isEmpty(audit_status)) {
			builder.append("  and o.audit_status = ?  ");
			param.add(audit_status);
		}
		if (vendor_id!=null) {
			builder.append("  and o.vendor_id = ?  ");
			param.add(vendor_id);
		}
		if (!StringUtil.isEmpty(model_name)) {
			builder.append("  and  o.model_name = ?  ");
			param.add(model_name);
		}
		if (!StringUtil.isEmpty(is_enabled)) {
			builder.append("  and o.is_enabled = ?  ");
			param.add(is_enabled);
		}
		if (!StringUtil.isEmpty(createtime)) {
			builder.append("  and o.created_at >= ? ");
			param.add(createtime);
		}
		if (!StringUtil.isEmpty(endtime)) {
			builder.append("  and o.created_at <= ? ");
			param.add(endtime);
		}
		
		
		List<DeviceModel> list = DeviceModel.findList(builder.toString(),param);
		if (list==null) {
			errormsg = "没有提交的设备模型申请";
			view.addObject("errormsg", errormsg);
			view.setViewName("admin/vendorAudit");
			return view;
		}
		view.addObject("list", list);
		view.addObject("errormsg", errormsg);
		view.setViewName("admin/devicemodelAudit");
		return view;
	}
	
	
	@RequestMapping("/toupdateModelAudit")
	public ModelAndView toupdateModelAudit(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id	
			){
		
		DeviceModel model = DeviceModel.findDeviceModel(id);
		Vendor vendor = Vendor.findVendor(model.getVendor_id());
		List<DeviceModelAuditComment> DMAC = DeviceModelAuditComment.findList(id);
		view.addObject("DMAC", DMAC);
		view.addObject("vendor", vendor);
		view.addObject("model", model);
		view.setViewName("admin/auditModelInfo");
		return view;
	}
	//	updateModelAudit?device_model_id=${model.model_id}
	//&audit_comment=${param.audit_comment}&audit_status=1&is_enabled=0&submit_by=1">	
	@RequestMapping("/updateModelAudit")
	public ModelAndView updateModelAudit(ModelAndView view
			,@RequestParam(value="device_model_id",required=false)Integer modelid	
			,@RequestParam(value="audit_comments",required=false)String audit_comments
			,@RequestParam(value="audit_status",required=false)String audit_status	
			,@RequestParam(value="is_enabled",required=false)String is_enabled
			,@RequestParam(value="submit_by",required=false)String submit_by
			){
		//audit_status=8&is_enabled=1&submit_by=1
		String errormsg = "审核提交";
		if (audit_status.equals("8")) {
			audit_comments="已经审核通过";
			DeviceModel model = DeviceModel.findDeviceModel(modelid);
			Device device = Device.findByDevice_id(model.getSource_id());
			device.setModel_id(model.getModel_id());
			device.merge();
		}
		boolean fale = DeviceModelAuditComment.submitAudit(modelid, audit_comments, submit_by, audit_status, is_enabled);
		if (!fale) {
			errormsg = "审核提交失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("admin/auditModelInfo");
		}
		
		return this.deviceModelAuditPage(view, audit_status, errormsg);
	}
}
