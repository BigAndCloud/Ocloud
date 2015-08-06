// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain;

import com.ourselec.ocloud.domain.UserInfo;
import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

privileged aspect UserInfo_Roo_Json {
    
    public String UserInfo.toJson() {
        return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    public String UserInfo.toJson(String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(this);
    }
    
    public static UserInfo UserInfo.fromJsonToUserInfo(String json) {
        return new JSONDeserializer<UserInfo>().use(null, UserInfo.class).deserialize(json);
    }
    
    public static String UserInfo.toJsonArray(Collection<UserInfo> collection) {
        return new JSONSerializer().exclude("*.class").serialize(collection);
    }
    
    public static String UserInfo.toJsonArray(Collection<UserInfo> collection, String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(collection);
    }
    
    public static Collection<UserInfo> UserInfo.fromJsonArrayToUserInfoes(String json) {
        return new JSONDeserializer<List<UserInfo>>().use(null, ArrayList.class).use("values", UserInfo.class).deserialize(json);
    }
    
}
