package com.ourselec.ocloud.domain;


import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.persistence.TypedQuery;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;

import com.ourselec.ocloud.util.StringUtil;

@RooJavaBean
@RooJson
@RooToString
@RooJpaActiveRecord(versionField="",  persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="vendor_info")
public class Vendor {

	
	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	@Column(name="id" )
	private Integer id;
	
	@Column(name="user_id" )
	private String  user_id;
	
	//厂商自己定义的一个 特定的标识
	@Column(name="vendor_id" )
	private String  vendor_id;

	//公司名称
	@Column(name="company_name" )
	private String  company_name;
//	公司主页
	@Column(name="company_url" )
	private String  company_url;
//	所属行业
	@Column(name="company_industry" )
	private String  company_industry;
//	公司规模
	@Column(name="company_size" )
	private Integer  company_size;
//	 联系人姓名
	@Column(name="contact_name" )
	private String  contact_name;

	@Column(name="contact_number" )
	private String  contact_number;

	@Column(name="contact_email" )
	private String  contact_email;
//	项目概述
	@Column(name="project_overview" )
	private String  project_overview;
//	合作预期
	@Column(name="cooperation_prospect" )
	private String  cooperation_prospect;
//	图文资料
	@Column(name="graphic_texture_data" )
	private String  graphic_texture_data;
//	审核状态
	@Column(name="audit_status" )
	private String  audit_status;
//	是否启用
	@Column(name="is_enabled" )
	private String  is_enabled;
	
	@Column(name="created_at" )
	private Date  created_at;
	
	@Column(name="updated_at" )
	private Date  updated_at;
	
	@Column(name="deleted_at" )
	private Date  deleted_at;

	/**
	 * 提交 申请厂商
	 * @param user_id
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
	 * @return
	 */
	
	public static boolean submitAuth(String user_id, String company_name,String company_url,String vendor_id,String company_industry,
			Integer company_size,String contact_name,String contact_number,String contact_email,String project_overview,
			String cooperation_prospect,String graphic_texture_data){
		boolean fale = false;
		try {
			Vendor vendor = new Vendor();
			vendor.setUser_id(user_id);
			vendor.setVendor_id(vendor_id);
			vendor.setCompany_name(company_name);

			if (!StringUtil.isEmpty(company_url)) {
				vendor.setCompany_url(company_url);
			}
			vendor.setCompany_industry(company_industry);
			vendor.setCompany_size(company_size);
			vendor.setContact_name(contact_name);
			vendor.setContact_number(contact_number);
			vendor.setContact_email(contact_email);
			vendor.setProject_overview(project_overview);
			vendor.setCooperation_prospect(cooperation_prospect);
			vendor.setGraphic_texture_data(graphic_texture_data);
			vendor.setCreated_at(new Date());
			vendor.setUpdated_at(new Date());
			vendor.setAudit_status("0");
			vendor.setIs_enabled("0");
			vendor.persist();
		} catch (Exception e) {
			e.printStackTrace();
		}
		fale= true;
		
		return fale;
	}
	
	public static void updateVendorStatus(Integer vendorid, String audit_status, String is_enabled){
		Vendor vendor = Vendor.findVendor(vendorid);
		System.out.println("audit_status=="+audit_status+"====is_enabled==="+is_enabled);
		try {
			vendor.setAudit_status(audit_status);
			vendor.setIs_enabled(is_enabled);
			vendor.setUpdated_at(new Date());
			vendor.merge();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	public static Vendor findByuserid(String userid) {
		
		Vendor vendor = new Vendor();
		TypedQuery<Vendor> query = Vendor.entityManager().createQuery("select o from Vendor o where o.user_id = ?",Vendor.class);
		query.setParameter(1, userid);
		if (query.getResultList().size()==0) {
			return null;
		}
		vendor = query.getResultList().get(0);
		
		return vendor;
	}
	
	public static Vendor findByvendorid(String vendorid) {
		
		Vendor vendor = new Vendor();
		TypedQuery<Vendor> query = Vendor.entityManager().createQuery("select o from Vendor o where o.vendor_id = ?",Vendor.class);
		query.setParameter(1, vendorid);
		
		
		
		if (query.getResultList().size()==0) {
			return null;
		}
		vendor = query.getResultList().get(0);
		return vendor;
	}
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> findByAudit_status(String audit_status) {
		
		Query query = null;
		try {
			query = entityManager().createNativeQuery("select o.*,u.user_name from Vendor_info o inner join usr u on o.user_id= u.user_id  where o.audit_status= ?");
			query.setParameter(1, audit_status);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return query.getResultList().size()==0?null:query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> findList(String where, List<Object> params) {
		String sql = "select o.*,u.user_name from vendor_info o inner join usr u on o.user_id= u.user_id " +where;
		Query query = entityManager().createNativeQuery(sql);
		if (null != params && !params.isEmpty()) {
			int index = 1;
			for (Object param : params) {
				query.setParameter(index, param);
				index = index + 1;
			}
		}
		return query.getResultList().size()==0?null:query.getResultList();
	}
	
}
