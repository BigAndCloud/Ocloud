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

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.transaction.annotation.Transactional;

import com.ourselec.ocloud.util.StringUtil;

@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord(versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="device_model_audit_comment")
public class DeviceModelAuditComment {

	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	@Column(name="id" )
	private Integer id;
	
	@Column(name="device_model_id" )
	private Integer device_model_id;
	
	@Column(name="audit_comment" )
	private String audit_comment;
	
	@Column(name="submit_by" )
	private String submit_by;
	
	@Column(name="created_at" )
	private Date created_at;
	
	
	
	public static boolean addAuditComment(Integer device_model_id,
			String audit_comment, String submit_by) {
	    boolean	fale = true;
		DeviceModelAuditComment DMAC= new DeviceModelAuditComment();
		
		try {
			DMAC.setDevice_model_id(device_model_id);
			DMAC.setAudit_comment(audit_comment);
			DMAC.setSubmit_by(submit_by);
			DMAC.setCreated_at(new Date());
			DMAC.persist();
		} catch (Exception e) {
			fale= false;
			e.printStackTrace();
		}
		return fale;
		
	}
	@SuppressWarnings("unchecked")
	public static List<DeviceModelAuditComment> findList(Integer model_id){
		Query query = null;
		List<DeviceModelAuditComment> list = new ArrayList<DeviceModelAuditComment>();
		
		try {
			query = DeviceModelAuditComment.entityManager().createQuery("select o from DeviceModelAuditComment o where o.device_model_id= ?");
			query.setParameter(1,model_id);
			if (query.getResultList().size()==0) {
				return null;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		list = query.getResultList();
		return list;
	}
	
	
	
	public static void updateAuditComment(Integer id,Integer device_model_id,
			String audit_comment, String submit_by) {
			try {
				DeviceModelAuditComment DMAC= DeviceModelAuditComment.findDeviceModelAuditComment(id);
				DMAC.setDevice_model_id(device_model_id);
				DMAC.setAudit_comment(audit_comment);
				DMAC.setSubmit_by(submit_by);
				DMAC.merge();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	//使用权限 审批人 （admin在审核信息后 做的操作）
	@Transactional
	public static boolean submitAudit(Integer modelid,
			String audit_comment, String submit_by,String audit_status,String is_enabled){
		boolean fale = true;
		try {
				 DeviceModel.AuditModel(modelid,audit_status,is_enabled);
				 DeviceModelAuditComment.addAuditComment(modelid,audit_comment,submit_by);
			
		} catch (Exception e) {
			fale= false;
			e.printStackTrace();
		}
	     return fale;
	}
	//使用权限 厂商 （厂商在审批被驳回的后 再次修改的操作）
	@Transactional
	public static boolean submitAudit(String comment, String model_name,
			String model_id, String source_id, String picture, Integer id, //model自动生成的id号
			
			String audit_comment, Integer developer_id,Integer vendorid,String submit_by, String audit_status,
			String is_enabled) {
		boolean fale= true; 
		try {
			if (!StringUtil.isEmpty(audit_comment)) {
				DeviceModelAuditComment.addAuditComment(id,audit_comment,submit_by);	
			}
			if (audit_status.equals("3")) {
				audit_status="0";
			} 
			if(audit_status.equals("1")){
				audit_status="2";
			}
			DeviceModel.updateModel(id,model_name, model_id, source_id, picture, comment,audit_status,is_enabled,developer_id,vendorid);
			
			
		} catch (Exception e) {
			fale=false;
			e.printStackTrace();
		}
		return fale;
	}
	//获取最早的设备模型时间信息
	public static DeviceModelAuditComment findByModelId(Integer model_id) {
		String sql = "SELECT * FROM device_model_audit_comment o WHERE o.device_model_id= ? AND o.submit_by= 1 ORDER BY o.created_at DESC  "; 
		Query query = DeviceModelAuditComment.entityManager().createNativeQuery(sql,DeviceModelAuditComment.class);
		query.setParameter(1, model_id);
		
		return query.getResultList().size()==0?null:(DeviceModelAuditComment)query.getResultList().get(0);
	}
	
}
