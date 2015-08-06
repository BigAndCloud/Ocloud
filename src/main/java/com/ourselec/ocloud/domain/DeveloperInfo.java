package com.ourselec.ocloud.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.TypedQuery;



import java.io.Serializable;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;

import com.ourselec.ocloud.controller.dto.DeveUserInfoDTO;

@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord(versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="developer_info")
public class DeveloperInfo  implements Serializable {

	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	private Integer id;

	
	@Column(name="vendor_id")
	private String vendor_id;
	
	/**
	 * 与 usr中的 user_id 外键
	 */
	@Column(name="developer_user")
	private String developer_user;
	
	@Column(name="is_accepted")
	private String is_accepted;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="updated_at")
	private Date updated_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;
	
	
	
	public static boolean DeveSus(String vendor_id,String developer_user){
		boolean fale = false;
		try {
			DeveloperInfo deve = new DeveloperInfo();
			
			deve.setVendor_id(vendor_id);
			deve.setDeveloper_user(developer_user);
			deve.setIs_accepted("0");
			deve.setCreated_at(new Date());
			deve.setUpdated_at(new Date());
			deve.persist();

		} catch (Exception e) {
			e.printStackTrace();
		}
		fale= true;
		
		return fale;
	}

	public static DeveloperInfo findByuserid(String developer_user) {
		TypedQuery<DeveloperInfo> query = DeveloperInfo.entityManager().createQuery("select o from DeveloperInfo o  where o.developer_user = ?",DeveloperInfo.class);
		query.setParameter(1, developer_user);
		if (query.getResultList().size()==0) {
			return null;
		}
		return  query.getResultList().size()==0?null:query.getResultList().get(0);
	}
	public static DeveUserInfoDTO findByuseridMap(String developer_user) {
			TypedQuery<DeveloperInfo> query = null;
			DeveloperInfo developerInfo = new DeveloperInfo();
			try {
				query = DeveloperInfo.entityManager().createQuery("select o from DeveloperInfo o where o.developer_user = ?",DeveloperInfo.class);
				query.setParameter(1, developer_user);
				if (query.getResultList().size()==0) {
					return null;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			developerInfo = query.getResultList().get(0);
			DeveUserInfoDTO  dto= new DeveUserInfoDTO();
			dto.setId(developerInfo.getId());
			dto.setVendor_id(developerInfo.getVendor_id());
			dto.setUpdated_at(developerInfo.getUpdated_at());
			dto.setCreated_at(developerInfo.getCreated_at());
			dto.setDeveloper_user(developerInfo.getDeveloper_user());
			dto.setIs_accepted(developerInfo.getIs_accepted());
			dto.setUsername(Users.findByUserid(developer_user).getUsername());
			return dto;
		}
	


	@SuppressWarnings("unchecked")
	public static List<DeveUserInfoDTO> findByVendorid(String vendor_id){
		List<DeveloperInfo> deves = new ArrayList<DeveloperInfo>();
		List<DeveUserInfoDTO> listDTO = new ArrayList<DeveUserInfoDTO>();
		try {
			Query query = DeveloperInfo.entityManager().createQuery("select  o from DeveloperInfo o  where o.vendor_id = ?");
			query.setParameter(1, vendor_id);
			if (query.getResultList().size()==0) {
				return null;
			}
			deves = query.getResultList();
			for (DeveloperInfo deve : deves) {
				DeveUserInfoDTO dto = new DeveUserInfoDTO();
				dto.setId(deve.getId());
				dto.setVendor_id(deve.getVendor_id());
				dto.setUpdated_at(deve.getUpdated_at());
				dto.setCreated_at(deve.getCreated_at());
				dto.setDeveloper_user(deve.getDeveloper_user());
				dto.setIs_accepted(deve.getIs_accepted());
				String username =Users.findByUserid(deve.getDeveloper_user()).getUsername();
				dto.setUsername(username);
				listDTO.add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listDTO;
	}



}
