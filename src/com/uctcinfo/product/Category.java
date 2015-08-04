package com.uctcinfo.product;


import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * Blog model.

将表结构放在此，消除记忆负担
mysql> category;
category_id	int(11)	NO	PRI		auto_increment
category_name	varchar(255)	YES			
parent_category_id	int(11)	YES			


数据库字段名建议使用驼峰命名规则，便于与 java 代码保持一致，如字段名： userId
 */
@SuppressWarnings("serial")
public class Category extends Model<Category> {
	public static final Category categoryDao = new Category();
	
	/**
	 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Page<Category> paginate(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *", "from category order by category_id asc");
	}
	/**
	 * 根据产品类型的父ID查产品类型
	 * @param 
	 * @return
	 */
	public List<Category> findCateByParentId(int ParentId) {
		return find("select * from category where parent_category_id=?",ParentId);
	}
}
