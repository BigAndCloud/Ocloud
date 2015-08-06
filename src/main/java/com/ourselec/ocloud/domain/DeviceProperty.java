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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;


@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord( versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="device_property")
public class DeviceProperty {


	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	@Column(name="user_id")
	private String user_id;


	@Column(name="device_model_id")
	private String device_model_id;
	
	@Column(name="name")
	private String name;
	
	@Column(name="alias")
	private String alias;
//	// '通道列表'
//	@Column(name="channel_list")
//	private String channel_list;
	

	//'上次数据时间',
	@Column(name="last_data_at")
	private Date last_data_at;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="updated_at")
	private Date updated_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;
	
 public static	Logger logger = LoggerFactory.getLogger(DeviceProperty.class);
	
	public  static boolean addProperty(String name,
			String alias,String user_id, 
		String device_model_id){
		boolean fale = true;
		
			try {
				DeviceProperty property = new DeviceProperty();
				
//				if (!StringUtil.isEmpty(device_id)&&device_id!=null) {
//					property.setDevice_id(device_id);
//				}if (!StringUtil.isEmpty(device_model_id)) {
//					property.setDevice_model_id(device_model_id);
//				}
				property.setDevice_model_id(device_model_id);
				property.setName(name);
				property.setAlias(alias);
				property.setUser_id(user_id);
		
				property.setCreated_at(new Date());
				property.setUpdated_at(new Date());
				property.setLast_data_at(new Date());
				property.persist();
			} catch (Exception e) {
				fale = false;
				e.printStackTrace();
				logger.error(e.getMessage());
			}
		
		return fale;
	}
	
	
	public static boolean updateDevicePropery(
			Integer id,String name,String alias,
		
			String device_model_id,String device_id){
		boolean fale = true;
		try {
			DeviceProperty property = DeviceProperty.findDeviceProperty(id);
			
			property.setName(name);
			property.setAlias(alias);

			property.setUpdated_at(new Date());
			property.setLast_data_at(new Date());
			property.setDevice_model_id(device_model_id);
			property.merge();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		
		return fale;
	}
	
	
	
	
//	public static boolean addDeviceID(Integer id,String device_id){
//		boolean fale = true;
//		try {
//			DeviceProperty property = DeviceProperty.findDeviceProperty(id);
//			property.setDevice_id(device_id);
//			property.merge();
//		} catch (Exception e) {
//			fale = false;
//			e.printStackTrace();
//		}
//		
//		return fale;
//	}
//	public static boolean addDeviceModelID(Integer id,String device_model_id,String device_id){
//		boolean fale = true;
//		try {
//			DeviceProperty property = DeviceProperty.findDeviceProperty(id);
//			property.setDevice_id(device_id);
//			property.setDevice_model_id(device_model_id);
//			property.merge();
//		} catch (Exception e) {
//			fale = false;
//			e.printStackTrace();
//		}
//		
//		return fale;
//	}
	/**
	 * 获取设备的属性列表
	 * @param property_list
	 * @return
	 */
	
	@SuppressWarnings({ "unchecked", "unused" })
	public static List<DeviceProperty> findByProperty_list(String property_list ){
		List<DeviceProperty> list = new ArrayList<DeviceProperty>();
			
		String[] prolist = property_list.split(",");
		StringBuilder param = new StringBuilder("");
	
		for (String string : prolist) {
			param.append("?,");
		}
			
			if (param.toString().endsWith(",")) {
				param.delete(param.length() - 1, param.length());
			}
			
			
		Query query = DeviceProperty.entityManager().createQuery("select o from DeviceProperty o where o.id in ("+param+")",DeviceProperty.class);
		for (int i = 0; i < prolist.length; i++) {
			query.setParameter(i, prolist[i]);
		}
		if (query.getResultList().size()==0) {
			return null;
		}
		list = query.getResultList();
		return list;
	}


	public static boolean  findBydeviceid(String device_id, String alias) {
		boolean fale = true;
		
		Query query = DeviceProperty.entityManager().createQuery("select COUNT(*) from  DeviceProperty o where o.device_id = ? and o.alias = ?",Long.class);
		query.setParameter(1, device_id);
		query.setParameter(2, alias);
		
		if (query.getFirstResult()!=0) {
			fale=false;
		}
		return fale;
		
	}
	
//	public static boolean  deleteById(Integer id) {
//		boolean fale = true;
//		try {
//			DeviceProperty property = DeviceProperty.findDeviceProperty(id);
//			property.setDeleted_at(new Date());
//			property.merge();
//		} catch (Exception e) {
//			fale=false;
//			logger.error(e.getMessage());;
//			e.printStackTrace();
//		}
//		return fale;
//		
//	}


	@SuppressWarnings("unchecked")
	public static List<DeviceProperty> findList(String user_id) {
		List<DeviceProperty> list = new ArrayList<DeviceProperty>();
		
		Query query = DeviceProperty.entityManager().createQuery("select o from DeviceProperty o where o.user_id=?",DeviceProperty.class);
		query.setParameter(1, user_id);
		list = query.getResultList();
		return query.getResultList().size()==0?null:list;
	}
	
	@SuppressWarnings("unchecked")
	public static List<DeviceProperty> findListByModel_id(String model_id){
//		device_model_id
		Query query = DeviceProperty.entityManager().createQuery("select o from DeviceProperty o where o.device_model_id=?",DeviceProperty.class);
		query.setParameter(1, model_id);
		List<DeviceProperty>	list=query.getResultList();
		return list.size()==0?null:list;
	}
	
	
	
	
}
