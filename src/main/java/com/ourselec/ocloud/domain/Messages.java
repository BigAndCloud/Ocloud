package com.ourselec.ocloud.domain;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.TypedQuery;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.transaction.annotation.Transactional;

import com.ourselec.ocloud.util.RandomNumberGenerator;

@RooJson
@RooJavaBean
@RooToString
@Table(name="messages_info")
@RooJpaActiveRecord( versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
public class Messages {

	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	private Integer id;
	
	@Column(name="msg_id")
	private String msg_id;
	//0：普通消息 1：邀请消息
	@Column(name="msg_type")
	private Integer msg_type;
	//0 已发送 1已接受 2 已查看 3已回复
	@Column(name="msg_status")
	private Integer msg_status;
	
	@Column(name="msg_sender")
	private String msg_sender;
	
	@Column(name="msg_recipient")
	private String msg_recipient;
	
	@Column(name="send_at")
	private Date send_at;
	
	@Column(name="receive_at")
	private Date receive_at;
	
	@Column(name="delete_at")
	private Date delete_at;
	
	@Column(name="msg_theme")
	private String msg_theme;
	
	@Column(name="msg_context")
	private String msg_context;
	

	
	@Transactional
	public static List<Messages> getMessages(String username) {
		  TypedQuery<Messages> query = Messages.entityManager().createQuery("select o from Messages o where o.msg_sender = ? "
				,Messages.class); 
		  		query.setParameter(1, username);
		  		 TypedQuery<Messages> reci = Messages.entityManager().createQuery("select o from Messages o where o.msg_recipient = ? "
		 				,Messages.class); 
		 		  		reci.setParameter(1, username);
		 		  		List<Messages> sendlist =query.getResultList(); 
		 		  		List<Messages> recilist =reci.getResultList(); 
		 		  		sendlist.addAll(recilist);
		 		  		return sendlist;
	}
	@Transactional
	public static int getMsgCount(String username) {
		  TypedQuery<Long> send = Messages.entityManager().createQuery("select count(o) from Messages o where o.msg_sender = ?  "
				,Long.class); 
		  		send.setParameter(1, username);
		  		TypedQuery<Long> reci = Messages.entityManager().createQuery("select count(o) from Messages o where msg_recipient = ? "
						,Long.class); 
				  		reci.setParameter(1, username);		
		  		Integer count = send.getSingleResult().intValue()+reci.getSingleResult().intValue();
		  		return count;
	}
	
	@Transactional
	public static Messages addMessages(String msg_sender
			, String msg_recipient,Integer msg_type,String msg_context,String msg_theme) {
		Messages msg = new Messages();
			
			try {
				msg.setMsg_id("BJ"+RandomNumberGenerator.generateNumber2());
				msg.setMsg_sender(msg_sender);
				msg.setMsg_recipient(msg_recipient);
				msg.setMsg_type(msg_type);
				msg.setMsg_status(0);
				msg.setSend_at(new Date());
				msg.setMsg_context(msg_context);
				msg.setMsg_theme(msg_theme);
				msg.persist();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return msg ;
	}
	
	public static Messages findMessages(String msg_id) {
		Messages msg = new Messages();
		
		TypedQuery<Messages> query = Messages.entityManager().createQuery("select o from Messages o where o.msg_id = ?",Messages.class);
		query.setParameter(1, msg_id);
		if (query.getResultList().size()==0) {
			return null;
		}
		msg = query.getResultList().get(0);
		
		return msg;
	}
	public static boolean updateStatus(String msg_id,Integer status){
		boolean fale = true;
		try {
			Messages msg = Messages.findMessages(msg_id);
			msg.setMsg_status(status);
			if (status==3) {
				msg.setReceive_at(new Date());				
			}
			msg.merge();
		} catch (Exception e) {
			fale=false;
			e.printStackTrace();
		}
		return fale;
		
	}
	
	
	@Transactional
	public static void replyMsg(String msg_id,String deveusername, String vendorusername,Integer reply  ){
//		boolean fale = true;
		try {
			
			if (reply==0) {
				Messages.addMessages(deveusername, vendorusername, 0,deveusername+"  用户 同意了了您的开发者邀请","邀请开发者");
				Users users= Users.findByusername(deveusername);
				users.setUser_type(4);
				users.merge();
				DeveloperInfo.DeveSus(Vendor.findByuserid(vendorusername).getVendor_id(), users.getUserid());
			} else if (reply==1) {
				Messages.addMessages(deveusername, vendorusername, 0,deveusername+"  用户 拒绝了您的开发者邀请","邀请开发者");
				
			}
			Messages.updateStatus(msg_id, 3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		return fale;
		
	}
}
