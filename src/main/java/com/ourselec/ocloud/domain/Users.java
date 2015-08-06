package com.ourselec.ocloud.domain;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
import org.springframework.transaction.annotation.Transactional;

import com.ourselec.ocloud.domain.power.Tresources;
import com.ourselec.ocloud.domain.power.Troles;
import com.ourselec.ocloud.util.MD5;
import com.ourselec.ocloud.util.Page;
import com.ourselec.ocloud.util.PaySign;
import com.ourselec.ocloud.util.RandomNumberGenerator;


@RooJavaBean
@RooJson
@RooToString
@RooJpaActiveRecord(versionField="",  persistenceUnit="persistenceUnit",transactionManager="ocloudTransactionManager")
@Table(name="usr")
public class Users {


	
	@Id
	@GeneratedValue(strategy =GenerationType.AUTO )
	private int id;
	//'0 普通用户 1管理员 2 厂商 3代理商 4 开发者 5 维护人员'
	@Column (name="user_type")
	private Integer user_type;

	//'用户名 /邮件地址'
	@Column (name="user_name")
	private String username;
	//已加密
	@Column (name="passwd")
	private String passwd;
	//'加密方式'
	@Column (name="hasher")
	private String hasher;
	//'盐值 32位 包括 数字和字母的随机数'
	@Column (name="salt")
	private String salt;
	
	@Column (name="user_id")
	private  String userid;
	//'是否启用'
	@Column (name="is_enabled")
	private String isEnabled;
	// '是否激活'
	@Column (name="is_activated")
	private String isActivated;
	
	@Column (name="created_at")
	private Date createdAt;
	
	@Column (name="updated_at")
	private Date updateAt;
	
	@Column (name="deleted_at")
	private Date deletedAt;

	
	
	

	@Transactional
	public static boolean AddUsers(String username,String passwd){
		Users user = new Users();
		boolean fale = true;
		try {
			user.setUsername(username);
			String salt = UUID.randomUUID().toString();
		 String passwdend	= PaySign.EncoderByMd5(passwd, salt); 
			user.setPasswd(passwdend);
			user.setUserid(RandomNumberGenerator.generateNumber2());
			user.setSalt(salt);
			user.setHasher("MD5");
			user.setIsActivated("否");
			user.setIsEnabled("是");
			user.setUser_type(0);
			user.setCreatedAt(new Date());
			user.persist();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
			
		}
//		
		return fale;

	}

	
public static String testMD5(){
	
	
	String salt = UUID.randomUUID().toString();
	String passwd = "1234567";
	String endstr = "";
	try {
	endstr =	PaySign.EncoderByMd5(passwd,"5c7cb78b-f213-4eb3-853d-58ccc436494c");
	System.out.println("passwd==="+passwd);
	System.out.println("salt=====5c7cb78b-f213-4eb3-853d-58ccc436494c");
	System.out.println("endstr==="+endstr);
	System.out.println(MD5.toMd5(passwd+salt));
	} catch (NoSuchAlgorithmException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return endstr;
}

	public static void findList(String where, String orderby,
			List<Object> params, Page<Users> page) {
		TypedQuery<Users> q = Users.entityManager().createQuery(
				"SELECT o FROM Users o " + where + orderby, Users.class);
		if (null != params && !params.isEmpty()) {
			int index = 1;
			for (Object param : params) {
				q.setParameter(index, param);
				index = index + 1;
			}
		}
		q.setFirstResult(page.getPageIndex() * page.getMaxResult())
				.setMaxResults(page.getMaxResult());
		page.setList(q.getResultList());
		TypedQuery<Long> totalQ = Users.entityManager().createQuery(
				"select count(o) from Users o " + where, Long.class);
		if (null != params && !params.isEmpty()) {
			int index = 1;
			for (Object param : params) {
				totalQ.setParameter(index, param);
				index = index + 1;
			}
		}
		page.setTotalResult(totalQ.getSingleResult().intValue());
	}
	

	
	/**
	 * 根据username查询
	 * @param username
	 * @return Users
	 */
	public static Users findByusername(String username) {
		TypedQuery<Users> query = entityManager().createQuery("SELECT o FROM Users o WHERE o.username = ?", Users.class);
		query.setParameter(1, username);
		if (query.getResultList().size()==0) {
			return null;
		}
		return query.getResultList().get(0);
	}
	
	/**
	 * 根据Id查询username
	 * @param Id
	 * @return Users
	 */
	public static Users findByUserid(String userid) {
		TypedQuery<Users> query = entityManager().createQuery("SELECT o FROM Users o WHERE o.userid = ?", Users.class);
		query.setParameter(1, userid);
		if (query.getResultList().size()!=0) {
			return query.getResultList().get(0);
		}
		return null;
	}
	/**
	 * 查找所有的用户
	 * @return
	 *//*
	public static List<Users> findAll() {
		TypedQuery<Users> query = Users.entityManager().createQuery("SELECT o FROM Users o ORDER BY o.username ASC", Users.class);
		return query.getResultList();
	}
	
	
	
	/**
	 * 查找用户拥有的父菜单
	 * @param username	用户名
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public static List<Tresources> findFatherAuthorizedResources(String username) {
		Query query = entityManager().createNativeQuery("select distinct tresources.* from tresources, troles_resources where tresources. id = troles_resources.resourceid and tresources.parentid = - 100 and tresources.type = 0 and troles_resources.roleid in ( select troles. id from Users, Users_roles, troles where Users.userid = Users_roles.userid and troles. id = Users_roles.roleid and Users.username = ? ) order by tresources. sort asc", Tresources.class);
		query.setParameter(1, username);
		return query.getResultList();
	}
	
	
	
	@SuppressWarnings("unchecked")
	public static List<Tresources>  findResourceChildren(Integer parentid,String username){
		Query query=entityManager().createNativeQuery("select distinct tresources.* from tresources, troles_resources where tresources. id = troles_resources.resourceid and tresources.parentid = ? and tresources.type = 0 and troles_resources.roleid in ( select troles. id from Users, Users_roles, troles where Users.userid = Users_roles.userid and troles. id = Users_roles.roleid and Users.username = ? ) order by tresources. sort asc", Tresources.class);
		query.setParameter(1, parentid);
		query.setParameter(2, username);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public static List<Tresources>  findResourceChildren(String username){
		Query query=entityManager().createNativeQuery("select distinct tresources.* from tresources, troles_resources where tresources. id = troles_resources.resourceid  and tresources.type = 0 and troles_resources.roleid in ( select troles. id from Users, Users_roles, troles where Users.userid = Users_roles.userid and troles. id = Users_roles.roleid and Users.username = ? ) order by tresources. sort asc", Tresources.class);
		query.setParameter(1, username);
		return query.getResultList();
	}
	
	
	/**
	 * 根据用户id找到用户角色
	 * @param id	用户id
	 * @return	List<Troles>
	 */
	@SuppressWarnings("unchecked")
	public static List<Troles> findUserRoles(String id) {
		Query query = entityManager().createNativeQuery("select r.* from troles r left outer join Users_roles ur on r.id = ur.roleid where ur.userid = ?  order by r.id asc ", Troles.class);
		query.setParameter(1, id);
		return query.getResultList();
	}
	
	
}
