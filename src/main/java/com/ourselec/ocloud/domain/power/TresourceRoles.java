package com.ourselec.ocloud.domain.power;


import java.util.List;

import javax.persistence.EmbeddedId;
import javax.persistence.Query;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooJson
@RooJpaActiveRecord(persistenceUnit = "persistenceUnit", versionField = "", table = "tresources_roles", identifierField = "id")
public class TresourceRoles {
	
	@EmbeddedId
	private TresourceRolesCompositePK id;
	
	/**
	 * 根据角色id查找用户权限
	 * @param resId
	 * @param roleId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<TresourceRoles> findUserRoles(Integer roleId) {
		Query query = entityManager().createQuery("SELECT o FROM TresourceRoles o WHERE  o.id.roleId = ? ", TresourceRoles.class);
		query.setParameter(1, roleId);
		List<TresourceRoles> list = query.getResultList();
		if(list == null || list.size() == 0) {
			return null;
		} else {
			return list;
		}
	}
	
	/**
	 * 根据用户id查找
	 * @param userId
	 * @return
	 *//*
	public static List<TresourceRoles> findUserRoles(Integer userId) {
		TypedQuery<TresourceRoles> query = entityManager().createQuery("SELECT o FROM TresourceRoles o WHERE o.id.userId = ? ", TresourceRoles.class);
		query.setParameter(1, userId);
		return query.getResultList();
	}
	
	*//**
	 * 根据角色id查找
	 * @param userId
	 * @return
	 *//*
	public static List<TresourceRoles> findUserRolesByRoleId(Integer roleId) {
		TypedQuery<TresourceRoles> query = entityManager().createQuery("SELECT o FROM TresourceRoles o WHERE o.id.roleId = ? ", TresourceRoles.class);
		query.setParameter(1, roleId);
		return query.getResultList();
	}
	
	*//**
	 * 增加用户角色
	 * @param userId	用户id
	 * @param roleId		角色id
	 *//*
	public static void addUserRole(Integer userId, Integer roleId) {
		if(findUserRoles(userId, roleId) == null) {
			TresourceRoles TresourceRoles = new TresourceRoles();
			TresourceRoles.setId(new TresourceRolesCompositePK(userId, roleId));
			TresourceRoles.persist();
		}
	}*/
}