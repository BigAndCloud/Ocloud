// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain.power;

import com.ourselec.ocloud.domain.power.Troles;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Troles_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext(unitName = "persistenceUnit")
    transient EntityManager Troles.entityManager;
    
    public static final EntityManager Troles.entityManager() {
        EntityManager em = new Troles().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Troles.countTroleses() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Troles o", Long.class).getSingleResult();
    }
    
    public static List<Troles> Troles.findAllTroleses() {
        return entityManager().createQuery("SELECT o FROM Troles o", Troles.class).getResultList();
    }
    
    public static Troles Troles.findTroles(Integer id) {
        if (id == null) return null;
        return entityManager().find(Troles.class, id);
    }
    
    public static List<Troles> Troles.findTrolesEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Troles o", Troles.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional("ocloudTransactionManager")
    public void Troles.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional("ocloudTransactionManager")
    public void Troles.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Troles attached = Troles.findTroles(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional("ocloudTransactionManager")
    public void Troles.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional("ocloudTransactionManager")
    public void Troles.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional("ocloudTransactionManager")
    public Troles Troles.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Troles merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}