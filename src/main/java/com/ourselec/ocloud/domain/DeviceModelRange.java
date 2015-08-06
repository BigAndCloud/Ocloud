package com.ourselec.ocloud.domain;

import java.io.Serializable;
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

import com.ourselec.ocloud.util.StringUtil;


@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord(versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="device_model_range")
public class DeviceModelRange implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	private Integer id;
	
	
	@Column(name="model_id")
	private Integer model_id;
	
	@Column(name="serial_type")
	private Integer serial_type;
	
	@Column(name="range_min")
	private String range_min;
	
	@Column(name="range_max")
	private String range_max;
	
	@Column(name="range_width")
	private Integer range_width;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;
	
	@Column(name="description")
	private String description;
	
	
	public static void addRange(Integer model_id,Integer serial_type
			,String range_min,String range_max,Integer range_width,String description){

			DeviceModelRange range = new DeviceModelRange();
			range.setModel_id(model_id);
			range.setSerial_type(serial_type);
			range.setRange_min(range_min);
			range.setRange_max(range_max);
			range.setRange_width(range_width);
			range.setDescription(description);
			range.setCreated_at(new Date());
			range.persist();
	}


	@SuppressWarnings("unchecked")
	public static  List<DeviceModelRange> findByModelid(Integer modelid) {

		Query query = DeviceModelRange.entityManager().createQuery("select o from DeviceModelRange o where o.model_id = ? ",DeviceModelRange.class);
		query.setParameter(1, modelid);
		if (query.getResultList().size()==0) {
			return null;
		}
		return query.getResultList();
	}


	public static  Integer countByModelidNum(Integer modelid) {

		List<DeviceModelRange> ranges = new ArrayList<DeviceModelRange>(); 
		Query query = DeviceModelRange.entityManager().createQuery("select o from DeviceModelRange o where o.model_id = ?");
		query.setParameter(1, modelid);
		if (query.getResultList().size()==0) {
			return null;
		}
		Integer result = 0;
		for (DeviceModelRange Range : ranges) {
			result=result+StringUtil.subtraction(Range.getRange_max(), Range.getRange_min());
		}
		
		return result;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public static List<DeviceModelRange> findByModelidList(Integer modelid) {
		Query query = DeviceModelRange.entityManager().createQuery("select o from DeviceModelRange o where o.model_id = ?",DeviceModelRange.class);
		query.setParameter(1, modelid);
		
		return query.getResultList().size()==0?null:query.getResultList();
	}


//	public static String findDevice_Serial(DeviceModelRange range) {
//
//		String device_serial= RangeCreateUtil.CreateNumber(range.getRange_width(), range.getRange_min());
//		
//		return device_serial;
//	}
	
}
