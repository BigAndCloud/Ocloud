package com.ourselec.ocloud.exception;

import com.ourselec.ocloud.util.ErrorCode;

public class OurselecException  extends RuntimeException {

		private static final long serialVersionUID = 1L;

		private ErrorCode errorCode;
		
		public OurselecException(String msg) {
			super(msg);
		}
		
		public OurselecException(String msg, Throwable e) {
			super(msg, e);
		}
		
		public OurselecException(ErrorCode errorCode) {
			super(errorCode.memo);
			this.errorCode = errorCode;
		}
		
		public ErrorCode getErrorCode() {
			return errorCode;
		}

		public void setErrorCode(ErrorCode errorCode) {
			this.errorCode = errorCode;
		}
	}
