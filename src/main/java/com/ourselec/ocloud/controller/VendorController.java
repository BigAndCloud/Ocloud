package com.ourselec.ocloud.controller;






import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.domain.Messages;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.util.SessionUtil;


@Controller
@RequestMapping("/vendor")
public class VendorController {

	Logger logger = LoggerFactory.getLogger(VendorController.class);
	@Autowired
	MessageController mes ;
	
	@RequestMapping("/auth")
	public ModelAndView auth( ModelAndView view, HttpServletRequest request
		){
		String username = SessionUtil.getUsers(request).getUsername();
		view.addObject("username",username);
		view.setViewName("/vendor/vendorAuth");
		return view;
	}
	/**
	 * 普通用户提交厂商申请
	 * @param view
	 * @param company_name
	 * @param company_url
	 * @param vendor_id
	 * @param company_industry
	 * @param company_size
	 * @param contact_name
	 * @param contact_number
	 * @param contact_email
	 * @param project_overview
	 * @param cooperation_prospect
	 * @param graphic_texture_data
	 * @param request 
	 * @return
	 */
	
	
	@RequestMapping(value="/submitauth")
	public ModelAndView submitauth(ModelAndView view
			,@RequestParam(value="company_name",required= false)String company_name 
			,@RequestParam(value="company_url",required= false)String company_url 
			,@RequestParam(value="vendor_id",required= false)String vendor_id 
			,@RequestParam(value="company_industry",required= false)String company_industry 
			,@RequestParam(value="company_size",required= false)Integer company_size 
			,@RequestParam(value="contact_name",required= false)String contact_name 
			,@RequestParam(value="contact_number",required= false)String contact_number 
			,@RequestParam(value="contact_email",required= false)String contact_email 
			,@RequestParam(value="project_overview",required= false)String project_overview 
			,@RequestParam(value="cooperation_prospect",required= false)String cooperation_prospect 
			,@RequestParam(value="graphic_texture_data",required= false)String graphic_texture_data, HttpServletRequest request 
			){
		
		String errormsg = "审核提交成功";
		Users user= SessionUtil.getUsers(request);
			boolean fale= false;
			try {
				fale = Vendor.submitAuth(user.getUserid(),company_name,company_url,vendor_id,company_industry,company_size,contact_name,contact_number,contact_email,project_overview,cooperation_prospect,graphic_texture_data);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if (!fale) {
				errormsg = "审核提交失败";
				view.addObject("errormsg", errormsg);
				view.setViewName("vendor/success");
				return view;
			}
		
		return view;
	}
	
	@RequestMapping("/developerpage")
	public ModelAndView developerPage(ModelAndView view
			,@RequestParam(value="vendor_id",required= false)String vendor_id){
		view.setViewName("vendor/invitedeveloper");
		return view;
	}
	
	
	@SuppressWarnings({ "null" })
	@RequestMapping("/invitedeve")
	public ModelAndView inviteDeve(ModelAndView view
			,@RequestParam(value="vendor_id",required=false)String vendor_id
			,@RequestParam(value="useremail",required=false)String[] useremails
			, HttpServletRequest request
			){
		logger.info("vendor/invitedeve");
			Users users= 	SessionUtil.getUsers(request);
			String errormsg = "已发送邀请";
			StringBuilder yet=null;
			try {
				for (int i = 0; i < useremails.length; i++) {
				List<Messages> mes = Messages.getMessages(useremails[i]);
				if (mes!=null) {
					yet.append(useremails[i]+" ; ");
				}else{
					Messages.addMessages(users.getUserid(), useremails[i],1, "邀请成为开发人员","邀请成为开发人员");
				}
				
}
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		if (yet!=null) {
			errormsg = yet+"用户已经被邀请了";
			view.addObject("errormsg", errormsg);
		}
		
		return  mes.getmsg(view, request);
	}  
	
	@RequestMapping("/getvendor")
	public ModelAndView getVendor(ModelAndView view
			,@RequestParam(value="id",required=false)Integer id
			){
			Vendor vendor= Vendor.findVendor(id);
		 Users users=	Users.findByUserid(vendor.getUser_id());
		view.addObject("users", users);
		 view.addObject("vendor", vendor);
		view.setViewName("vendor/vendorInfo");
		return view;
	}
	
	/**
	 * 最主要的是修改状态 成为（audit_status  2：资料更新）
	 * @param view
	 * @param company_name
	 * @param company_url
	 * @param vendor_id
	 * @param company_industry
	 * @param company_size
	 * @param contact_name
	 * @param contact_number
	 * @param contact_email
	 * @param project_overview
	 * @param cooperation_prospect
	 * @param graphic_texture_data
	 * @param request
	 * @return
	 */
		@RequestMapping("/updateVendorAudit")
        public ModelAndView updateVendorAudit(ModelAndView view
        		,@RequestParam(value="company_name",required= false)String company_name 
    			,@RequestParam(value="company_url",required= false)String company_url 
    			,@RequestParam(value="vendor_id",required= false)String vendor_id 
    			,@RequestParam(value="company_industry",required= false)String company_industry 
    			,@RequestParam(value="company_size",required= false)Integer company_size 
    			,@RequestParam(value="contact_name",required= false)String contact_name 
    			,@RequestParam(value="contact_number",required= false)String contact_number 
    			,@RequestParam(value="contact_email",required= false)String contact_email 
    			,@RequestParam(value="project_overview",required= false)String project_overview 
    			,@RequestParam(value="cooperation_prospect",required= false)String cooperation_prospect 
    			,@RequestParam(value="graphic_texture_data",required= false)String graphic_texture_data, HttpServletRequest request 
    			){
        	
        	
        	return view;
        }

}
