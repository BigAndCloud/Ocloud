package com.ourselec.ocloud.domain.power;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;
import org.springframework.roo.addon.tostring.RooToString;


@RooJson
@RooToString
@RooJavaBean
@RooJpaActiveRecord(
		versionField="",table="TROLES", 
persistenceUnit="persistenceUnit",
transactionManager="ocloudTransactionManager")
public class Troles {

	
	@Id
	@Column(name = "ID")
	private Integer id;
	
	@Column(name = "NAME")
	private String name;
	
	@Column(name = "DESCRIPTION")
	private String description;
	
	@Column(name = "ENABLE")
	private Integer enable;
	
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
		Troles other = (Troles) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	public static Troles findTrolesByName(String name) {
		return Troles.entityManager().createQuery("SELECT o FROM Troles o WHERE o.name = ?", Troles.class).setParameter(1, name).getSingleResult();
	}
	
	
	
	/**
	 * 找到角色对应的资源
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Tresources> findRoleResources(Integer id) {
		Query query = entityManager().createNativeQuery("select re.* from tresources re left outer join troles_resources rr on re.id = rr.resourceid where rr.roleid = ? ", Tresources.class);
		query.setParameter(1, id);
		return query.getResultList();
	}
	
	public static List<Troles> findList(String where, String orderby,
			List<Object> params) {
		TypedQuery<Troles> q = entityManager().createQuery("SELECT o FROM Troles o " + where + orderby, Troles.class);
		if (null != params && !params.isEmpty()) {
			int index = 1;
			for (Object param : params) {
				q.setParameter(index, param);
				index = index + 1;
			}
		}
		return q.getResultList();
	}
	
	/**
	 * 根据resource的id获取的该资源的角色列表
	 * @param resourceid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Troles> findTresourceRoles(Integer resourceid) {
		Query q = entityManager().createNativeQuery("select r.* from troles r , troles_resources rr , tresources re where r.id = rr.roleid and rr.resourceid = re.id and re.id = ? ", Troles.class);
		q.setParameter(1, resourceid);
		return q.getResultList();
	}
	
}
