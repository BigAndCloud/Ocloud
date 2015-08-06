// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.ourselec.ocloud.domain;

import com.ourselec.ocloud.domain.DeviceModelAuditComment;
import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

privileged aspect DeviceModelAuditComment_Roo_Json {
    
    public String DeviceModelAuditComment.toJson() {
        return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    public String DeviceModelAuditComment.toJson(String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(this);
    }
    
    public static DeviceModelAuditComment DeviceModelAuditComment.fromJsonToDeviceModelAuditComment(String json) {
        return new JSONDeserializer<DeviceModelAuditComment>().use(null, DeviceModelAuditComment.class).deserialize(json);
    }
    
    public static String DeviceModelAuditComment.toJsonArray(Collection<DeviceModelAuditComment> collection) {
        return new JSONSerializer().exclude("*.class").serialize(collection);
    }
    
    public static String DeviceModelAuditComment.toJsonArray(Collection<DeviceModelAuditComment> collection, String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(collection);
    }
    
    public static Collection<DeviceModelAuditComment> DeviceModelAuditComment.fromJsonArrayToDeviceModelAuditComments(String json) {
        return new JSONDeserializer<List<DeviceModelAuditComment>>().use(null, ArrayList.class).use("values", DeviceModelAuditComment.class).deserialize(json);
    }
    
}
