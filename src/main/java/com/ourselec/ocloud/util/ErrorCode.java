package com.ourselec.ocloud.util;

import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

public enum ErrorCode {

	OK("0", "成功"), ERROR("500", "服务器错误"), PARAMTER_ERROR("501", "参数错误"), MAC_ERROR("502", "Mac生成错误"),

	UserReg_PassMD5Error("070006", "密码错误"), 
	UserReg_UserMacError("070007", "生成用户校验码错误"),
	UserReg_UserExists("0013", "用户已注册"),
	UserReg_UserPause("000012", "用户已暂停"),
	UserReg_AccountMacError("070008", "账户校验码错误"),
	UserReg_MobileIdError("0019", "手机号错误"),
	UserReg_EmailError("0020", "邮箱错误"),
	UserReg_NicknameExists("100105", "昵称已存在"),

	UserMod_UserNoEmpty("100001", "用户userno为空"),
	UserMod_UserNotExists("100002", "用户不存在"),
	UserMod_MobileidBind("100003", "用户手机号已绑定"),
	UserMod_EmailBind("100004", "用户邮箱已绑定"),
	
	UserMod_NicknameNotExists("100205", "昵称不存在"),
	UserMod_StateNotNormal("100206", "用户状态不正常");
	
	public String value;

	public String memo;

	ErrorCode(String value, String memo) {

		this.value = value;
		this.memo = memo;
	}

	private static final Map<String, ErrorCode> lookup = new HashMap<String, ErrorCode>();

	static {
		for (ErrorCode s : EnumSet.allOf(ErrorCode.class)) {
			lookup.put(s.value, s);
		}
	}

	public static ErrorCode get(String value) {
		return lookup.get(value);
	}
}
