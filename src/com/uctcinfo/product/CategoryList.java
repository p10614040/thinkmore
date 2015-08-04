package com.uctcinfo.product;

import java.util.List;

public class CategoryList {
	private Category category;//大类
	private List<CategoryBean> categorylist;
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public List<CategoryBean> getCategorylist() {
		return categorylist;
	}
	public void setCategorylist(List<CategoryBean> categorylist) {
		this.categorylist = categorylist;
	}
	public CategoryList(Category category, List<CategoryBean> categorylist) {
		super();
		this.category = category;
		this.categorylist = categorylist;
	}
	public CategoryList() {
	}
	
}
