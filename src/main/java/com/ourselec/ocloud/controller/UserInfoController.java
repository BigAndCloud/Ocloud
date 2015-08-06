package com.ourselec.ocloud.controller;


import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.controller.dto.UserInfoDTO;
import com.ourselec.ocloud.domain.UserInfo;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.util.SessionUtil;
import com.ourselec.ocloud.util.StringUtil;

@RequestMapping("/userinfo")
@Controller
public class UserInfoController {

	
	Logger logger = Logger.getLogger(UserInfoController.class);
	@RequestMapping("/page")
	public ModelAndView Page(ModelAndView view,HttpServletRequest request,
			@RequestParam(value="errormsg",required=false) String errormsg){
		
		String username = SessionUtil.getUsers(request).getUsername();
		logger.info("userinfo/page");
	
		view.addObject("username", username);
		return this.findInfo(view, null, request,errormsg);
	}
	
	/**
	 * 显示用户信息
	 * @param view
	 * @param userid
	 * @param request
	 * @param errormsg
	 * @return
	 */
	
	@RequestMapping("/findInfo")
	public ModelAndView findInfo(ModelAndView view
			,@RequestParam(value="userid" ,required=false)String userid
			, HttpServletRequest request
			,	@RequestParam(value="errormsg",required=false) String errormsg
			){
			logger.info("/userInfo/finduser");
			if (errormsg==null) {
				errormsg = "查询成功";				
			}

			UserInfo userinfo = new UserInfo();
			Users user = new Users();
			UserInfoDTO dto = new UserInfoDTO();
			try {
				if (StringUtil.isEmpty(userid)) {
					user = SessionUtil.getUsers(request);
					userid = user.getUserid();	
				}
				 userinfo=	UserInfo.findInfo(userid);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (userinfo == null) {
				errormsg = "您没有完善信息请您尽快完善信息";
				view.addObject("errormsg", errormsg);
				
				view.addObject("userid", userid);
				view.setViewName("userinfo/vtuser");
				return view;
			}
		
			dto.setUserinfo(userinfo);
			dto.setUsers(user);
			view.addObject("dto", dto);
			view.addObject("errormsg",errormsg);
			view.setViewName("userinfo/findinfo");

		return view;
	}
	@RequestMapping("/vtuserPage")
	public ModelAndView vtuserPage(ModelAndView view
			,@RequestParam(value="userid")String userid ){
		
		UserInfo user= UserInfo.findInfo(userid);
		view.addObject("nickname", user.getNickname());
		view.addObject("mebileId", user.getMobileId());
		view.addObject("address", user.getAddress());
		view.addObject("userid", userid);
		view.setViewName("userinfo/vtuser");
		return view;
	}
	/**
	 * 
	 * 用户信息完善
	 * @param view
	 * @param userid
	 * @param nickname
	 * @param phonenumber
	 * @param address
	 * @return
	 */
	@RequestMapping("/vtusers")
	public ModelAndView vtuser(ModelAndView view
			,@RequestParam(value="userid",required=false)String userid 
			,@RequestParam(value="nickname",required=false)String nickname 
			,@RequestParam(value="mebileId",required=false)String mebileId 
			,@RequestParam(value="address",required=false)String address 
			){
			logger.info("/userinfo/vtuser");
			String errormsg = "已成功完善用户信息";
			
			boolean	fale = UserInfo.AddUserInfo(userid, nickname, mebileId, address);
		
		if (!fale) {
			errormsg = "完善信息提交失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("userinfo/vtuser");
			return view;
		}
		view.addObject("errormsg", errormsg);
		view.setViewName("userinfo/findInfo");
		return view;
	}
	
	
	@RequestMapping("/updateuser")
	public ModelAndView updateuser(ModelAndView view
			,@RequestParam(value="userid",required=false)String userid 
			,@RequestParam(value="nickname",required=false)String nickname 
			,@RequestParam(value="mebileId",required=false)String mebileId 
			,@RequestParam(value="address",required=false)String address, HttpServletRequest request
			){
			logger.info("/userinfo/vtuser");
			String errormsg = "已成功编辑信息";
			
			boolean	fale = UserInfo.UpdateUserInfo(userid, nickname, mebileId, address);
		
		if (!fale) {
			errormsg = "编辑用户信息失败";
			view.addObject("errormsg", errormsg);
			view.setViewName("userinfo/vtuser");
			return view;
		}
		view.addObject("userid", userid);
		view.addObject("nickname", nickname);
		view.addObject("mebileId", mebileId);
		view.addObject("address", address);
		view.addObject("errormsg", errormsg);
		view.setViewName("userinfo/updateuserinfo");
		return view;
	}

	@RequestMapping("/updateuserPage")
	public ModelAndView updateuserPage(ModelAndView view
			,@RequestParam(value="userid")String userid ){
		
		UserInfo user= UserInfo.findInfo(userid);
		view.addObject("nickname", user.getNickname());
		view.addObject("mebileId", user.getMobileId());
		view.addObject("address", user.getAddress());
		view.addObject("userid", userid);
		view.setViewName("userinfo/updateuserinfo");
		return view;
	}
	
}
