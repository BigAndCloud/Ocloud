package com.ourselec.ocloud.consts;

import java.util.LinkedHashMap;
import java.util.Map;

public enum DataType {
	
	 basetext("文本",0),binary("二进制",1),bool("布尔",2),
	 baseenum("枚举",3),baseint("整型",4),basedecimal("小数型",5),
	 extendnilvalue("扩展数据零值",6),extendtime("扩展数据时间型",7),
	 extendmatrix("扩展二维矩阵型",8),extendspace("扩展三维空间矢量型",9);
	 

	private String type;
	private Integer index;
	 
	 private DataType(String type,Integer index){
		 
		 this.type=type;
		 this.index=index;
	 }
	 public static String getType(Integer index){
		 for (DataType type : DataType.values()) {
			if (type.getIndex() == index) {
				return type.type;
			}
		}
		 return null;
	 
	 }
	 
	 public static int getIndex(String type){
		 for (DataType t : DataType.values()) {
			if (t.getType() == type) {
				return t.index;
			}
		}
		 return 00;
	 }
	 public static Map<String, String> getValues(){
		 Map<String, String> map = new LinkedHashMap<String, String>();
		 for (DataType type : DataType.values()) {
				map.put(type.getIndex().toString(), type.getType().toString());
			}
		 return map;
	 }
	 
	 public static void main(String[] args) {
		
		 Map<String, String> list = DataType.getValues();
		 System.out.println(list.toString());
		
	}
	 
	 public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getIndex() {
		return index;
	}
	public void setIndex(Integer index) {
		this.index = index;
	}
}
