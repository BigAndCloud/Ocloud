package com.ourselec.ocloud.util;

import org.springframework.roo.addon.tostring.RooToString;

@RooToString
public class GridJson<E> {

	/** 总记录数 */
	private Integer total = 0;
	/** 查询结果集 */
	private String rows;
	public GridJson() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}


	
}
