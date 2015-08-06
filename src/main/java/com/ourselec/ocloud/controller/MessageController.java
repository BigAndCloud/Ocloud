package com.ourselec.ocloud.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.domain.Messages;
import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.service.MsgService;
import com.ourselec.ocloud.util.SessionUtil;

@Controller
@RequestMapping("/msg")
public class MessageController extends HttpServlet{

	
	@Autowired
	MsgService service;
	Logger logger = LoggerFactory.getLogger(MessageController.class);
	@RequestMapping("/getmsg")
	public ModelAndView getmsg(ModelAndView view, HttpServletRequest request
			) {
		logger.info("/msg/getmsg");
		Users users= SessionUtil.getUsers(request);
	List<Messages> msg = new ArrayList<Messages>();;
//	String errormsg = "";
	try {
		msg = Messages.getMessages(users.getUsername());
	} catch (Exception e) {
		e.printStackTrace();
	}
	
		view.addObject("msg", msg);
		view.setViewName("msg/msglist");
		return view;
	}

	/**
	 * 获取消息列表
	 * @param view
	 * @param msg_id
	 * @param msg_type 消息类型
	 * @param msg_sender 发送人（username）
	 * @param msg_recipient 接收人（username）
	 * @return
	 */
	@RequestMapping("/inmsg")
	public ModelAndView inmsg(ModelAndView view
			,@RequestParam(value="msg_id",required= false) String msg_id
			,@RequestParam(value="msg_type",required=false)Integer msg_type
			,@RequestParam(value="msg_sender",required=false)String msg_sender
			,@RequestParam(value="msg_recipient",required=false)String msg_recipient
			){
		logger.info("msg/inmsg");
		try {
			Users users = Users.findByusername(msg_sender);
			Vendor vendor =  Vendor.findByvendorid(users.getUserid());
			Messages msg = Messages.findMessages(msg_id);
			//1 代表邀请信息
			if (msg_type==1&&vendor!=null) {
				
				view.addObject("msg_sender", msg_sender);
				view.addObject("vendor", vendor);
				view.addObject("msg_recipient", msg_recipient);
				view.addObject("msg_id", msg_id);
				view.setViewName("msg/invitedmsg");
				return view;
			}
			view.addObject("msg", msg);
			view.setViewName("msg/msgdetails");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return view;
	}
	@RequestMapping("/replyinvit")
	public ModelAndView replyInvit(ModelAndView view
			,@RequestParam(value="msg_id",required=false)String msg_id
			,@RequestParam(value="msg_sender",required=false)String vender
			,@RequestParam(value="msg_recipient",required=false)String deve
			,@RequestParam(value="reply",required= false)Integer reply
			){
		//reply 0 表示：接受 1表示：拒绝
		String errormsg = "回复邮件";
		try {
			Messages.replyMsg(msg_id, deve, vender, reply);
			
			if (reply==0) {
				errormsg = "您已成为开发者，请您重新登录，进入开发者页面";
				view.addObject("deve", deve);
				view.addObject("errormsg", errormsg);
				
				view.setViewName("msg/invitSuc");
				
			} else if (reply==1) {
				view.setViewName("msg/invitfail");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return view;
	}
	
	
}
