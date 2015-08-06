// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain;

import com.ourselec.ocloud.domain.UserInfo;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect UserInfo_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext(unitName = "persistenceUnit")
    transient EntityManager UserInfo.entityManager;
    
    public static final EntityManager UserInfo.entityManager() {
        EntityManager em = new UserInfo().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long UserInfo.countUserInfoes() {
        return entityManager().createQuery("SELECT COUNT(o) FROM UserInfo o", Long.class).getSingleResult();
    }
    
    public static List<UserInfo> UserInfo.findAllUserInfoes() {
        return entityManager().createQuery("SELECT o FROM UserInfo o", UserInfo.class).getResultList();
    }
    
    public static UserInfo UserInfo.findUserInfo(Integer id) {
        if (id == null) return null;
        return entityManager().find(UserInfo.class, id);
    }
    
    public static List<UserInfo> UserInfo.findUserInfoEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM UserInfo o", UserInfo.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional("ocloudTransactionManager")
    public void UserInfo.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional("ocloudTransactionManager")
    public void UserInfo.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            UserInfo attached = UserInfo.findUserInfo(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional("ocloudTransactionManager")
    public void UserInfo.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional("ocloudTransactionManager")
    public void UserInfo.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional("ocloudTransactionManager")
    public UserInfo UserInfo.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        UserInfo merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}