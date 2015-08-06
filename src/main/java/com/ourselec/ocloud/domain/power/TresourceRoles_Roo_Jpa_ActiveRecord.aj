// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain.power;

import com.ourselec.ocloud.domain.power.TresourceRoles;
import com.ourselec.ocloud.domain.power.TresourceRolesCompositePK;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect TresourceRoles_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext(unitName = "persistenceUnit")
    transient EntityManager TresourceRoles.entityManager;
    
    public static final EntityManager TresourceRoles.entityManager() {
        EntityManager em = new TresourceRoles().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long TresourceRoles.countTresourceRoleses() {
        return entityManager().createQuery("SELECT COUNT(o) FROM TresourceRoles o", Long.class).getSingleResult();
    }
    
    public static List<TresourceRoles> TresourceRoles.findAllTresourceRoleses() {
        return entityManager().createQuery("SELECT o FROM TresourceRoles o", TresourceRoles.class).getResultList();
    }
    
    public static TresourceRoles TresourceRoles.findTresourceRoles(TresourceRolesCompositePK id) {
        if (id == null) return null;
        return entityManager().find(TresourceRoles.class, id);
    }
    
    public static List<TresourceRoles> TresourceRoles.findTresourceRolesEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM TresourceRoles o", TresourceRoles.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void TresourceRoles.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void TresourceRoles.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            TresourceRoles attached = TresourceRoles.findTresourceRoles(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void TresourceRoles.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void TresourceRoles.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public TresourceRoles TresourceRoles.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        TresourceRoles merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}