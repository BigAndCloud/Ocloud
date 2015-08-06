package com.ourselec.ocloud.domain;


import java.util.Date;


import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;







import javax.persistence.Table;
import javax.persistence.TypedQuery;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
/*import org.springframework.roo.addon.entity.RooEntity;*/
import org.springframework.roo.addon.json.RooJson;
/*import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;*/
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.transaction.annotation.Transactional;

import com.ourselec.ocloud.util.StringUtil;




@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord( versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="USR_INFO")
public class UserInfo {

	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	private Integer id;
	
	@Column (name="user_id")
	private  String user_id;
	
	@Column (name="nick_name")
	private String nickname;
	
	@Column (name="phone_number")
	private String  mobileId;
	
	@Column (name="address")
	private String address;
	
	@Column (name="created_at")
	private Date createdAt;
	
	@Column (name="updated_at")
	private Date updatedAt;
	
	@Column (name="deleted_at")
	private Date deletedAt;


	@Transactional
	public static boolean AddUserInfo(String userid,String nickname,String mobile,String address){
		boolean fale = true;
		UserInfo user = new UserInfo();
		try {
			user.setUser_id(userid);
			if (!StringUtil.isEmpty(nickname)) {
				user.setNickname(nickname);	
			}
			if (StringUtil.isEmpty(mobile)) {
				user.setMobileId(mobile);
			}
			if (!StringUtil.isEmpty(address)) {
				user.setAddress(address);	
			}
			user.setCreatedAt(new Date());
			user.setUpdatedAt(new Date());
			user.persist();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
			
		}
		return fale;
	}

	@Transactional
	public static UserInfo findInfo(String userid){
		
		TypedQuery<UserInfo> query = entityManager().createQuery("select o from UserInfo o where o.user_id= ?",UserInfo.class);
		query.setParameter(1, userid);
		 
		 if (query.getResultList().size() ==0) {
			return null;
		}
		
		return query.getResultList().get(0);
	}
	
	@Transactional
	public static boolean UpdateUserInfo(String userid,String nickname,String mobileId,String address){
		
		boolean  fale =true;
		try {
			UserInfo user = UserInfo.findInfo(userid);
			user.setNickname(nickname);
			user.setMobileId(mobileId);
			user.setAddress(address);
			user.setUpdatedAt(new Date());
			user.merge();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		
		return fale;
	}
	
}
