// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain;

import com.ourselec.ocloud.domain.Users;
import java.util.Date;

privileged aspect Users_Roo_JavaBean {
    
    public int Users.getId() {
        return this.id;
    }
    
    public void Users.setId(int id) {
        this.id = id;
    }
    
    public Integer Users.getUser_type() {
        return this.user_type;
    }
    
    public void Users.setUser_type(Integer user_type) {
        this.user_type = user_type;
    }
    
    public String Users.getUsername() {
        return this.username;
    }
    
    public void Users.setUsername(String username) {
        this.username = username;
    }
    
    public String Users.getPasswd() {
        return this.passwd;
    }
    
    public void Users.setPasswd(String passwd) {
        this.passwd = passwd;
    }
    
    public String Users.getHasher() {
        return this.hasher;
    }
    
    public void Users.setHasher(String hasher) {
        this.hasher = hasher;
    }
    
    public String Users.getSalt() {
        return this.salt;
    }
    
    public void Users.setSalt(String salt) {
        this.salt = salt;
    }
    
    public String Users.getUserid() {
        return this.userid;
    }
    
    public void Users.setUserid(String userid) {
        this.userid = userid;
    }
    
    public String Users.getIsEnabled() {
        return this.isEnabled;
    }
    
    public void Users.setIsEnabled(String isEnabled) {
        this.isEnabled = isEnabled;
    }
    
    public String Users.getIsActivated() {
        return this.isActivated;
    }
    
    public void Users.setIsActivated(String isActivated) {
        this.isActivated = isActivated;
    }
    
    public Date Users.getCreatedAt() {
        return this.createdAt;
    }
    
    public void Users.setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date Users.getUpdateAt() {
        return this.updateAt;
    }
    
    public void Users.setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }
    
    public Date Users.getDeletedAt() {
        return this.deletedAt;
    }
    
    public void Users.setDeletedAt(Date deletedAt) {
        this.deletedAt = deletedAt;
    }
    
}
