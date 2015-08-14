package com.ourselec.ocloud.domain;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

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
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;


@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord( versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="device_model")
public class DeviceModel {
/**
 * id` int(11) NOT NULL auto_increment,
  `developer_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  `model_id` varchar(50) NOT NULL,
  `source_id` varchar(50) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `audit_status` tinyint(4) NOT NULL COMMENT '0 初次提交， 1 驳回申请， 2重新提交， 8 审核通过',
  `is_enabled` tinyint(4) NOT NULL COMMENT '1 启用， 0 禁用',
  `created_at` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL default NULL,
  `deleted_at` timestamp NULL default NULL,
 */
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	@Column(name="developer_id")
	private Integer developer_id;
	
	@Column(name="vendor_id")
	private Integer vendor_id;
	
	
	@Column(name="model_name")
	private String model_name;
	
	@Column(name="model_id")
	private String model_id;
	//device_id
	@Column(name="source_id")
	private String source_id;
	
	@Column(name="comment")
	private String comment;
	
	@Column(name="picture")
	private String picture;
	
//	'文本编码方法',（默认）
	@Column(name="text_encoding_id")
	private Integer text_encoding_id;
	 // '二进制编码方法',
	@Column(name="binary_encoding_id")
	private Integer binary_encoding_id;
	
	
	@Column(name="audit_status")
	private String audit_status;
	
	@Column(name="is_enabled")
	private String is_enabled;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="updated_at")
	private Date updated_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;

	@SuppressWarnings("unchecked")
	public static List<DeviceModel> findByAudit_status(String audit_status) {
		String where = "where o.audit_status !=3 ";
		if (audit_status!=null) {
			 where = "where o.audit_status="+audit_status;
		}
		Query query = DeviceModel.entityManager().createQuery("select  o from DeviceModel o "+where,DeviceModel.class);
		return query.getResultList().size()==0?null:query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public static List<DeviceModel> findList(String where, List<Object> params) {

		String sql = "select o from DeviceModel o " +where;
		Query query = entityManager().createQuery(sql,DeviceModel.class);
		if (params!=null&&!params.isEmpty()) {
			int index=1;
			for (Object param : params) {
				query.setParameter(index, param);
				index=index+1;
			}
		}
		
		return query.getResultList().size()==0?null:query.getResultList();
	}

	public static void AuditModel(Integer modelid, String audit_status,
			String is_enabled) {
		try {
			DeviceModel model = DeviceModel.findDeviceModel(modelid);
			model.setAudit_status(audit_status);
			model.setIs_enabled(is_enabled);
			model.merge();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static boolean addModel(Integer developer_id, Integer vendor_id,
			String model_name, String model_id, String source_id,Integer text_encoding_id,Integer binary_encoding_id,
			String picture, String comment) {
		boolean fale = true;
		DeviceModel model = new DeviceModel();
		try {
			model.setDeveloper_id(developer_id);
			model.setVendor_id(vendor_id);
			model.setModel_name(model_name);
			model.setModel_id(model_id);
			model.setSource_id(source_id);
			model.setText_encoding_id(text_encoding_id);
			model.setBinary_encoding_id(binary_encoding_id);
			model.setPicture(picture);
			model.setComment(comment);
			model.setAudit_status("3");
			model.setIs_enabled("0");
			model.setCreated_at(new Date());
			model.setUpdated_at(new Date());
			model.persist();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		return fale;
	}
	public static boolean updateModel(Integer id,
			String model_name, String model_id, String source_id,
			String picture, String comment, String audit_status, String is_enabled,Integer developer_id, Integer vendorid) {
		boolean fale = true;
		DeviceModel model = DeviceModel.findDeviceModel(id);
		try {
			model.setDeveloper_id(developer_id);
			model.setModel_name(model_name);
			model.setModel_id(model_id);
			model.setSource_id(source_id);
			model.setPicture(picture);
			model.setComment(comment);
			model.setAudit_status(audit_status);
			model.setIs_enabled(is_enabled);
			model.setVendor_id(vendorid);
			model.setUpdated_at(new Date());
			model.merge();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		return fale;
	}

	@SuppressWarnings("unchecked")
	public static List<DeviceModel> findListByVenId(Integer vendorid) {
		Query query = DeviceModel.entityManager().createQuery("select o from DeviceModel o where o.vendor_id= ?",DeviceModel.class);
		query.setParameter(1, vendorid);
		
		return query.getResultList().size()==0?null:query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public static List<DeviceModel> findListByVenIdSuc(Integer vendorid) {
		Query query = DeviceModel.entityManager().createQuery("select o from DeviceModel o where o.vendor_id= ? and o.audit_status = 8",DeviceModel.class);
		query.setParameter(1, vendorid);
		
		return query.getResultList().size()==0?null:query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public static List<DeviceModel> findListByDeveId(Integer deveid) {
		Query query = DeviceModel.entityManager().createQuery("select o from DeviceModel o where o.developer_id= ?",DeviceModel.class);
		query.setParameter(1, deveid);
		
		return query.getResultList().size()==0?null:query.getResultList();
	}
	public static DeviceModel findByDeviceId(String device_id) {
		Query query = DeviceModel.entityManager().createQuery("select o from DeviceModel o where o.source_id= ?",DeviceModel.class);
		query.setParameter(1, device_id);
		
		return (DeviceModel) (query.getResultList().size()==0?null:query.getResultList().get(0));
	}

	public static DeviceModel findByModel_id(String model_id) {
		TypedQuery<DeviceModel> query = DeviceModel.entityManager().createQuery("select o from DeviceModel o where o.model_id = ?",DeviceModel.class);
		query.setParameter(1, model_id);
		
		
		return query.getResultList().size()==0?null:query.getResultList().get(0);
	}

	@Async
	public Future<String> addModel(Map<String, Object> map) {
		String errormsg=" The Model addition success";
		try {
			
				String name= (String)map.get("name");
				String alias= (String)map.get("alias");
				String user_id=	(String)map.get("user_id");
				Integer alive_time= Integer.valueOf((String)map.get("alive_time"));
				String timezone= (String)map.get("timezone");
				Double lng= Double.valueOf((String)map.get("lng"));
				Double lat= Double.valueOf((String)map.get("lat"));
				String comment= (String)map.get("devicecomment");
				Integer vendor_id= Integer.valueOf((String)map.get("vendor_id"));
				Integer developer_id= Integer.valueOf((String)map.get("developer_id"));
				String model_id= (String)map.get("model_id");
				String model_name=	(String)map.get("model_name");
				Integer text_encoding_id=	Integer.valueOf((String)map.get("text_encoding_id"));
				Integer  binary_encoding_id = Integer.valueOf((String)map.get("binary_encoding_id"));
				String picture= (String)map.get("picture");
				String modelconmment= (String)map.get("modelcomment");
			 boolean fale=	Device.addDevice(name, alias, user_id, alive_time, timezone, lng, lat, comment, "3", vendor_id, developer_id, model_id, null, null);
			 if (fale) {
				
				String source_id=  Device.findModel_id(model_id).getDevice_id();
				boolean fale1=	addModel(developer_id, vendor_id, model_name, model_id, source_id, text_encoding_id, binary_encoding_id, picture, modelconmment);
				if (!fale1) {
					
					errormsg="The DeviceModel addition failed!";
				}
			}else {
				errormsg = "The Device addition failed!";
			}
			
  
		} catch (Exception e) {
			errormsg=" The Model addition failed！"+e.getMessage();
			e.printStackTrace();
		}
		  return new AsyncResult<String>(errormsg);
	}
}
