/**
 * 
 * @Title PageGrid.java
 * @Package com.uctcinfo.product
 * @Description TODO(用一句话描述该文件做什么)
 * @author yan.liang
 * @date 2015年6月12日 上午11:01:36
 * @copyright USTCINFO
 */
package com.uctcinfo.product;

import java.io.Serializable;
import java.util.List;

/**
 * @author YanLiang
 *
 */
public class PageGrid<T> implements Serializable {

	private static final long serialVersionUID = -8427960251081877462L;
	
	private List<T> rows;				// list result of this page
	private int total;				// total row
	
	
	/**
	 * @param list
	 * @param rows
	 * @param total
	 */
	public PageGrid(List<T> rows, int total) {
		this.rows = rows;
		this.total = total;
	}


	/**
	 * @return the rows
	 */
	public List<T> getRows() {
		return rows;
	}


	/**
	 * @param rows the rows to set
	 */
	public void setRows(List<T> rows) {
		this.rows = rows;
	}


	/**
	 * @return the total
	 */
	public int getTotal() {
		return total;
	}


	/**
	 * @param total the total to set
	 */
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
