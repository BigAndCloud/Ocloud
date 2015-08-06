package com.ourselec.ocloud.service;

import org.springframework.stereotype.Service;

import com.ourselec.ocloud.domain.Messages;
import com.ourselec.ocloud.domain.Users;
@Service
public class MsgService {

	
	
	public void replyMsg(String msg_id,String deve, String vender,Integer reply  ){
//		boolean fale = true;
		try {
			
			if (reply==0) {
				Messages.addMessages(deve, vender, 0,deve+"  用户 同意了您的开发者邀请","");
				Users users= Users.findByusername(deve);
				users.setUser_type(4);
				users.merge();
			} else if (reply==1) {
				Messages.addMessages(deve, vender, 0,deve+"  用户 拒绝了您的开发者邀请","");
				
			}
			Messages.updateStatus(msg_id, 3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		return fale;
		
	}
}
