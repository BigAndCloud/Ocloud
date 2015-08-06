package com.ourselec.ocloud.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.consts.ResponseData;
import com.ourselec.ocloud.controller.dto.RescourceDTO;
import com.ourselec.ocloud.domain.DeveloperInfo;
import com.ourselec.ocloud.domain.Messages;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.domain.power.Tresources;
import com.ourselec.ocloud.util.JsonUtil;
import com.ourselec.ocloud.util.PaySign;
import com.ourselec.ocloud.util.SessionUtil;
import com.ourselec.ocloud.util.StringUtil;

@Controller
public class IndexController {

	
	
	
	Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@RequestMapping("/indexs")
public ModelAndView index(ModelAndView view
		, HttpServletRequest request){
		
		logger.info("index");
		Users users = SessionUtil.getUsers(request);
		view.addObject("users", users);
//		Users users = SessionUtil.getUsers(request);
		view.setViewName("/index");
		return view;
	}
	
	@RequestMapping(value = "/frame/header")
	public ModelAndView header(ModelAndView view
			, HttpServletRequest request
			){
		logger.info("/header");
		Users users = SessionUtil.getUsers(request);
		int count = 0;
		try {
			count = Messages.getMsgCount(users.getUsername());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		view.addObject("count",count);
		view.addObject("users", users);
		view.setViewName("/header");
		return view;
	}
	@RequestMapping(value = "/frame/left")
	public ModelAndView left(ModelAndView view
			, HttpServletRequest request
			){
		logger.info("/left");		
		String errormsg = "信息匹配成功";
		Users user=	SessionUtil.getUsers(request);
	
			List<RescourceDTO> reDTOList = new ArrayList<RescourceDTO>();
		try {
			List<Tresources> tres= Tresources.findMenu(user.getUser_type());
			if (tres==null) {
				errormsg="没有菜单";
				view.addObject("errormsg", errormsg);
				return view;
			}
			
			for (Tresources res : tres) {
			RescourceDTO rdto = new RescourceDTO();
			rdto.setId(res.getId());	
			rdto.setName(res.getName());
			rdto.setUrl(res.getUrl());
			rdto.setTarget("context");
			reDTOList.add(rdto);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (reDTOList.size()!=0) {
			String json =	JsonUtil.toJson(reDTOList);
			view.addObject("resources", json);
			System.out.println(json);
		}else{
		String json =	JsonUtil.toJson(reDTOList);
		view.addObject("resources", json);
		System.out.println(json);
		}
		view.addObject("errormsg", errormsg);
		
		view.setViewName("left");
		return view;	
		
	}
		
	

	
	@RequestMapping(value="/login")
	public @ResponseBody  ResponseData login(
			@RequestParam(value="username",required=true)String username ,
			@RequestParam(value="password",required=true)String password
			, HttpServletRequest request){
		
		
		logger.info("login");
			ResponseData rd = new ResponseData();
		
		Users user=	Users.findByusername(username);
		if (user == null) {
			rd.setErrorCode("100002");
			rd.setValue("没有这个用户 请重新确认！");
		}
		 if (!StringUtil.isPassword(password, user.getPasswd(),user.getSalt())) {
			rd.setErrorCode("070006");
			rd.setValue("密码错误 请重新确认！");
     }else{ 
		 if (user.getUser_type()==2) {
			 request.getSession().setAttribute("vendor"+request.getRequestedSessionId(), Vendor.findByuserid(user.getUserid()));
		}else if(user.getUser_type()==4){
			request.getSession().setAttribute("developer"+request.getRequestedSessionId(), DeveloperInfo.findByuserid(user.getUserid()));
		}
		 request.getSession().setAttribute("users"+request.getRequestedSessionId(), Users.findByusername(username));
		 
			rd.setErrorCode("0");
			rd.setValue(user);
     }
		return rd;
	}
	
	@RequestMapping("/changepassword")
    public ModelAndView changepassword(
                    @RequestParam(value = "oldpassowrd", required = false) String oldpassowrd,
                    @RequestParam(value = "newpassowrd", required = false) String newpassowrd,
                    @RequestParam(value = "confirmpassowrd", required = false) String confirmpassowrd,
                    @RequestParam(value = "username",required = false) String username,
                    HttpSession session, ModelAndView view) {
            String errormsg = "修改成功";
            try {
                    Users users =  Users.findByusername(username);
                    String salt = users.getSalt();
                    users.getPasswd();
                  
                    if (null == oldpassowrd || !users.getPasswd().equals(PaySign.EncoderByMd5(oldpassowrd,salt))) {
                            throw new RuntimeException("旧密码错误");
                    }
                    if (null == newpassowrd || !newpassowrd.equals(confirmpassowrd)) {
                            throw new RuntimeException("两次密码不一致辞");
                    }
                    users = Users.findByUserid(users.getUserid());
                    users.setPasswd(PaySign.EncoderByMd5(newpassowrd,null));
                    users.merge();
                    session.setAttribute("user", users);
            } catch (Exception e) {
                    logger.error("/changepassword error", e);
                    errormsg = e.getMessage();
            }
            view.addObject("errormsg", errormsg);
            view.setViewName("changepassword");
            return view;
    }
	
}
