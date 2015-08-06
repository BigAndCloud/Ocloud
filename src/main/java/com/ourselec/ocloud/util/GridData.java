package com.ourselec.ocloud.util;


import java.util.List;

import org.springframework.roo.addon.tostring.RooToString;


@RooToString
public class GridData<E> {

	/** 开始记录行数FirstResult */
	private Integer pageNumber =0;
	/** 总页数 */
	@SuppressWarnings("unused")
	private Integer totalPage;
	/** 每页显示记录数pageSize */
	private Integer pageSize = 10;
	/** 总记录数 */
	private Integer total = 0;
	/** 查询结果集 */
	private List<E> rows;


	public GridData() {
		super();
	}

	public GridData(int pageNumber,int pageSize) {
		super();
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
	}

	public GridData(Integer pageNumber, Integer pageSize) {
		super();
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
	}

	public GridData(Integer pageNumber, Integer pageSize, Integer total, List<E> rows) {
		super();
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
		this.total = total;
		this.rows = rows;
	}
	
	/**
	 * 当前页数
	 */
	public Integer getCurrentPageNo() {
		if (pageNumber == null || pageSize == null || pageSize == 0) {
			return 1;
		}
		return pageNumber/pageSize+1;
	}

	public Integer getpageNumber() {

		return null == pageNumber ? 0 : pageNumber;
	}

	public void setpageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Integer getTotalPage() {

		return total % getpageSize() == 0 ? total / getpageSize() : total / getpageSize() + 1;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getpageSize() {
		return null == pageSize ? 10 : pageSize;
	}

	public void setpageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public List<E> getRows() {
		return rows;
	}

	public void setRows(List<E> rows) {
		this.rows = rows;
	}
	public Integer gettotal() {
		return total;
	}

	public void settotal(Integer total) {
		this.total = total;
	}
}
