package com.ourselec.ocloud.consts;

public enum OType {

	suc(0,"用户 同意了您的开发者邀请"),fail(1,"用户 拒绝了您的开发者邀请");
	
	
	public Integer type;

	public String memo;
	OType(Integer type, String memo) {

		this.type = type;
		this.memo = memo;
	}
	public String getMemo(Integer type) {
		return memo;
	}
}
