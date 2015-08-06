package com.ourselec.ocloud.domain.power;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Query;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooJson
@RooJpaActiveRecord(persistenceUnit = "persistenceUnit", table = "TRESOURCES", versionField = "",identifierField = "id")
public class Tresources  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID")
	private Integer id;
	
	@Column(name = "MEMO")
	private String memo;
	
	@Column(name = "URL")
	private String url;
		
	/**
	 * 用户等级//'0 普通用户 1管理员 2 厂商 3代理商 开发商 5 维护人员'
	 */
	@Column(name = "TYPE")
	private Integer type;
	
	@Column(name = "NAME")
	private String name;
	
	/**
	 * 这个页面那几个权限可以查看
	 */
	@Column(name = "PARENTID")
	private Integer parentId;
	
	@Column(name = "SORT")
	private Integer sort;
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Tresources other = (Tresources) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	

	/**
	 * 查找用户拥有的菜单
	 * @param username	用户名
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Tresources> findAuthorizedResources(Integer type) {
		Query query = entityManager().createQuery("SELECT o FROM Tresources o WHERE o.type= ?", Tresources.class);
		query.setParameter(1, type);
		return query.getResultList();
	}
	public static List<Tresources> findPare(Integer parenId) {
		return Tresources.entityManager().createQuery("SELECT o FROM Tresources o WHERE o.parentId = ? ", Tresources.class).setParameter(1, parenId).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public static List<Tresources> findMenu(Integer roleid){
		Query query = entityManager().createNativeQuery("SELECT t.* FROM Tresources t INNER JOIN tresources_roles tr on t.id= tr.RESOID  WHERE tr.ROLEID= ? ",Tresources.class);
		query.setParameter(1, roleid);
		if (query.getResultList().size()==0) {
			return null;
		}
		return query.getResultList();
	}
	/*
	public static Integer getMaxSort() {
		TypedQuery<Integer> query = entityManager().createQuery("SELECT MAX(o.sort) FROM Tresources o", Integer.class);
		return query.getSingleResult();
	}*/
}