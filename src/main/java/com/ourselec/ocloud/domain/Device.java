package com.ourselec.ocloud.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

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

import com.ourselec.ocloud.util.RandomNumberGenerator;
import com.ourselec.ocloud.util.RangeCreateUtil;
@RooJson
@RooJavaBean
@RooToString
@RooJpaActiveRecord(versionField="", persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="device")
public class Device {

	/**
	 * `id` int(11) NOT NULL auto_increment,
  `device_id` varchar(40) NOT NULL COMMENT '设备 ID',
  `device_key` varchar(40) NOT NULL COMMENT '设备 Key',
  `device_type` tinyint(4) NOT NULL COMMENT '设备类型 0 测试设备， 1 产品设备',
  `model_id` varchar(50) NOT NULL COMMENT '设备模型 ID',
  `device_serial` varchar(50) default NULL COMMENT '设备序列号',
  `name` varchar(50) NOT NULL COMMENT '设备名称 可继承自设备模板的来源',
  `alias` varchar(50) NOT NULL COMMENT '设备别名',
  `alive_time` int(11) NOT NULL COMMENT '活跃时间',
  `timezone` int(11) NOT NULL COMMENT '设备所在时区',
  `lat` float NOT NULL COMMENT 'GPS 经度',
  `lng` float NOT NULL COMMENT 'GPS 纬度',
  `comment` varchar(200) default NULL COMMENT '设备备注',
  `is_activated` tinyint(4) NOT NULL COMMENT '是否激活 0 未激活， 1 已激活',
  `property_list` varchar(200) NOT NULL COMMENT '设备属性列表',
  `created_at` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `update_at` timestamp NULL default NULL,
  `deleted_at` timestamp NULL default NULL,
	 */
	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	private Integer id;
	
	@Column(name="device_id")
	private String device_id;
	
	@Column(name="device_key")
	private String device_key;
	
	//'设备类型 0 测试设备， 1 产品设备' 2产品原型,
	@Column(name="device_type")
	private String device_type;
	
	//'设备模型 ID' 如果是 测试设备的话 为TESTDEVICE 默认为：DEVICE 
	@Column(name="model_id")
	private String model_id;
	
	//'设备序列号'
	@Column(name="device_serial")
	private String device_serial;
	
	//'设备名称 可继承自设备模板的来源'
	@Column(name="name")
	private String name;
	//'设备别名'
	@Column(name="alias")
	private String alias;
	
	@Column(name="user_id")
	private String user_id;
	//'活跃时间'
	@Column(name="alive_time")
	private Integer alive_time;
	//'设备所在时区'
	@Column(name="timezone")
	private String timezone;
	//经度
	@Column(name="lat")
	private Double lat;
	//纬度
	@Column(name="lng")
	private Double lng;
	//'设备备注'
	@Column(name="comment")
	private String comment;
	//'是否激活 0 未激活， 1 已激活'
	@Column(name="is_activated")
	private String is_activated;
	//设备属性列表
	@Column(name="range_id")
	private Integer range_id;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="updated_at")
	private Date updated_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;
	
	
	public static boolean addDevice(String name,String alias,String user_id,
			Integer alive_time,String timezone,
			Double lng,Double lat,String comment
			,String device_type,Integer vendorid, Integer developerid,String model_id,String[] porname,String[] poralias){
		boolean fale = true;
		String device_id=RandomNumberGenerator.GetDeviceId();
		try {
			Device device = new Device();
			device.setName(name);
			device.setAlias(alias);
			device.setUser_id(user_id);
			device.setAlive_time(alive_time);
			device.setTimezone(timezone);
			device.setLng(lng);
			device.setLat(lat);
//			device.setRange_id(range_id);
			device.setComment(comment);
			device.setCreated_at(new Date());
			device.setUpdated_at(new Date());
			device.setDevice_type(device_type);
			device.setIs_activated("0");
			device.setModel_id("T"+alias);
			device.setDevice_id(device_id);
			device.setDevice_key(RandomNumberGenerator.Key());
			device.persist();
		} catch (Exception e) {
			fale=false;
			e.printStackTrace();
		}
		if (fale) {
			try {
				
				if (device_type.equals("0")&&device_type=="0") {
					DeviceModel.addModel(developerid,vendorid, name, "T"+alias, device_id,null,null,null, comment);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (porname!=null&&poralias!=null) {
			if (fale) {
				try {
					for (int i = 0; i < porname.length; i++) {
						DeviceProperty.addProperty(porname[i], poralias[i], user_id, "T"+alias);	
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}	
		}
		
		

		return fale;
	}
	
	
	
	
	public static synchronized  void addDevice1(Integer num,Device d,String user_id, String model_id,DeviceModelRange range) {
		
		try {
			AtomicInteger Counter = RangeCreateUtil.getCounter(range.getRange_min());
			Integer range_width = range.getRange_width();
			for (int i = 0; i < num; i++) {
				Device device = new Device();
				device.setName(d.getName());
				device.setAlias(d.getAlias());
				device.setUser_id(user_id);
				device.setAlive_time(d.getAlive_time());
				device.setTimezone(d.getTimezone());
				device.setLng(d.getLng());
				device.setLat(d.getLat());
				device.setModel_id(model_id);
				device.setComment(d.getComment());
				device.setCreated_at(new Date());
				device.setUpdated_at(new Date());
				device.setDevice_type("1");
				device.setIs_activated("1");
				String device_serial=RangeCreateUtil.CreateNumber(range_width,Counter);
				device.setRange_id(range.getId());
				device.setDevice_serial(device_serial);
				device.setDevice_id(RandomNumberGenerator.GetDeviceId());
				device.setDevice_key(RandomNumberGenerator.Key());
				device.persist();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}




	public static boolean  updateDevice(Integer id,String name,String alias,String timezone,Integer alive_time,Double lng,Double lat,String comment) {
		boolean fale =true;
		
		try {
			Device device = Device.findDevice(id);
			device.setName(name);
			device.setAlias(alias);
			device.setTimezone(timezone);
			device.setAlive_time(alive_time);
			device.setLat(lat);
			device.setLng(lng);
			device.setComment(comment);
			device.setUpdated_at(new Date());
			device.merge();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		
		
		
		return fale;
		
	}
	
	@SuppressWarnings("unchecked")
	public static List<Device> findByUserid(String user_id){
		List<Device> list = new ArrayList<Device>();
		Query query = Device.entityManager().createQuery("select o from Device o where o.user_id = ?",Device.class);
		query.setParameter(1, user_id);
		if (query.getResultList().size()==0) {
			return null;
		}
		list = query.getResultList();
		return list;
	}
	
	
	@SuppressWarnings({ "unchecked", "unused" })
	public static List<Device> findByUserid(List<String> user_id){
		List<Device> list = new ArrayList<Device>();
		try {
			String sql = "select * from device o ";
			StringBuilder param = new StringBuilder();
		
			for (String string : user_id) {
				param.append("?,");
			}
			
				if (param.toString().endsWith(",")) {
					param.delete(param.length() - 1, param.length());
				}
				String where =" where  o.model_id='TESTDEVICE'"; 
				 where = where+" and o.user_id in("+param+") ";
			Query query = Device.entityManager().createNativeQuery(sql+where,Device.class);

			for (int i = 1; i <= user_id.size(); i++) {
				System.out.println(user_id.get(i-1));
				query.setParameter(i, user_id.get(i-1));
			}
			if (query.getResultList().size()==0) {
				return null;
			}
			list = query.getResultList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public static boolean deleteDevice(Integer id) {
		boolean fale = true;
		
			try {
				Device  device = Device.findDevice(id);
				device.setIs_activated("0");
				device.setDeleted_at(new Date());
				device.merge();
			} catch (Exception e) {
				fale=false;
				e.printStackTrace();
			}
			
			return fale;
		
	}
	public static Device findByDevice_id(String source_id) {
		Query query = Device.entityManager().createQuery("select o from Device o where o.device_id= ?",Device.class);
		query.setParameter(1, source_id);
		return (Device) (query.getResultList().size()==0?null:query.getResultList().get(0));
	}
	public static void batchPro(Integer range_id,Integer num, Integer modelid,String user_id) {
		
		try {
			DeviceModelRange range= DeviceModelRange.findDeviceModelRange(range_id);
			DeviceModel model = DeviceModel.findDeviceModel(modelid);
			Device device = Device.findByDevice_id(model.getSource_id());
			Device.addDevice1(num,device, user_id,model.getModel_id(), range);;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	
//	public static List<Device>
	
	
	
}
