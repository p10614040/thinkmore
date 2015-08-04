package com.uctcinfo.product;

public class CategoryBean {
	private Category category;//大类
	private long categoryCount;//某类下列产品的总数
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public long getCategoryCount() {
		return categoryCount;
	}
	public void setCategoryCount(long categoryCount) {
		this.categoryCount = categoryCount;
	}
	public CategoryBean(Category category, long categoryCount) {
		super();
		this.category = category;
		this.categoryCount = categoryCount;
	}
	public CategoryBean() {
	}
}
