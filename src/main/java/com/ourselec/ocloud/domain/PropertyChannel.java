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
@Table(name="property_channel")
public class PropertyChannel {

	/**
	 * `name` varchar(50) NOT NULL COMMENT '属性通道名称',
  `alias` varchar(50) NOT NULL COMMENT '属性通道别名',
  `description` varchar(255) NOT NULL COMMENT '属性通道描述',
  `channel_type` tinyint(4) NOT NULL COMMENT '通道类型 0 静态， 1 动态',
  `dynamic_flag` varchar(50) NOT NULL COMMENT '动态通道标识',
  `base_type` int(11) NOT NULL COMMENT '数据类型',
  `base_type_id` int(11) NOT NULL COMMENT '数据类型 ID',
	 */
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;

	@Column(name="property_id")
	private Integer property_id;
	
	@Column(name="name")
	private String name;
	
	@Column(name="alias")
	private String alias;
	
	@Column(name="description")
	private String description;
	
	@Column(name="channel_type")
	private String channel_type;
	
	@Column(name="dynamic_flag")
	private String dynamic_flag;
	
	@Column(name="base_type")
	private Integer base_type;
	
	@Column(name="base_type_id")
	private Integer base_type_id;
	
	@Column(name="created_at")
	private Date created_at;
	
	@Column(name="updated_at")
	private Date updated_at;
	
	@Column(name="deleted_at")
	private Date deleted_at;
	
	
	public static boolean addProChannel(String name,
			String alias,String description,
			String channel_type,String dynamic_flag,Integer base_type 
			,Integer base_type_id,Integer property_id
			){
		boolean fale = true;
		
		try {
			PropertyChannel channel = new PropertyChannel();
			channel.setProperty_id(property_id);
			channel.setName(name);
			channel.setAlias(alias);
			channel.setDescription(description);
			channel.setChannel_type(channel_type);
			channel.setDynamic_flag(dynamic_flag);
			channel.setBase_type(base_type);
			channel.setBase_type_id(base_type_id);
			channel.setCreated_at(new Date());
			channel.setUpdated_at(new Date());
			channel.persist();
		} catch (Exception e) {
			fale = false;
			e.printStackTrace();
		}
		return fale;
	}
	public static boolean updateProChannel(Integer id,
			String description,
			String channel_type,String dynamic_flag,Integer base_type 
			,Integer base_type_id
			){
		boolean fale = true;
		
		try {
			PropertyChannel channel = PropertyChannel.findPropertyChannel(id);
			channel.setDescription(description);
			channel.setDynamic_flag(dynamic_flag);
			channel.setBase_type(base_type);
			channel.setChannel_type(channel_type);
			channel.setBase_type_id(base_type_id);
			channel.setCreated_at(new Date());
			channel.setUpdated_at(new Date());
			channel.merge();
		} catch (Exception e) {
			fale = false;
			logger.error(e.getMessage());
		}
		return fale;
	}
	
	public static boolean deleteProChannel(Integer id){
		boolean fale = true;
		try {
			PropertyChannel  channel = PropertyChannel.findPropertyChannel(id);
			channel.setDeleted_at(new Date());
			channel.merge();
		} catch (Exception e) {
			fale=false;
			e.printStackTrace();
		}
		return fale;
		
	}
	
	/**
	 * 获取属性的 渠道列表
	 * @param channel_list
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public static List<PropertyChannel> findByProperty_list(String channel_list ){
		List<PropertyChannel> list = new ArrayList<PropertyChannel>();
			
		String[] chanlist = channel_list.split(",");
		StringBuilder param = new StringBuilder("");
	
		for (String string : chanlist) {
			param.append("?,");
		}
			
			if (param.toString().endsWith(",")) {
				param.delete(param.length() - 1, param.length());
			}
			
		Query query = PropertyChannel.entityManager().createQuery("select o from PropertyChannel o where o.id in ("+param+")",PropertyChannel.class);
		for (int i = 0; i < chanlist.length; i++) {
			query.setParameter(i, chanlist[i]);
		}
		if (query.getResultList().size()==0) {
			return null;
		}
		list = query.getResultList();
		return list;
	}
	public static Logger logger = LoggerFactory.getLogger(PropertyChannel.class);
	@SuppressWarnings("unchecked")
	public static List<PropertyChannel> findList(Integer property_id, String channel_type){
		String  where = null;
		if (property_id!= null) {
			  where = " where  o.property_id= ? and o.channel_type= ?";
		}
		List<PropertyChannel> list = new ArrayList<PropertyChannel>();
		Query query = null;
		try {
			query = PropertyChannel.entityManager().createQuery("select o from PropertyChannel o  "+where+" ",PropertyChannel.class);
			query.setParameter(1, property_id);
			query.setParameter(2, channel_type);
			
			
			
			if (query.getResultList().size()==0) {
				return null;
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		list = query.getResultList();
		return list;
	}
	@SuppressWarnings("unchecked")
	public static List<PropertyChannel> findListByPropertyid(Integer propertyid) {
		Query query = PropertyChannel.entityManager().createQuery("select o from PropertyChannel o where o.property_id=?",PropertyChannel.class);
		query.setParameter(1, propertyid);
		return query.getResultList().size()==0?null:query.getResultList();
	}
}
