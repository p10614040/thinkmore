package com.uctcinfo.product.version;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;


/**
 * Blog model.

将表结构放在此，消除记忆负担
mysql>  describe product_comment;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| pc_id       | int(11)      | NO   | PRI | NULL    | auto_increment |
| version_id  | int(11)      | NO   |     | 0       |                |
| user_id     | varchar(255) | YES  |     | NULL    |                |
| create_time | datetime     | YES  |     | NULL    |                |
| content     | text         | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+


数据库字段名建议使用驼峰命名规则，便于与 java 代码保持一致，如字段名： userId
 */
@SuppressWarnings("serial")
public class ProductComment extends Model<ProductComment> {
	public static final ProductComment me = new ProductComment();
	
	
	public void productCommentSave(){
		me.save();
	}
	
	/**
	 * @author yudong
	 * @date 2015年6月12日11:43:59
	 * @Description 产品根据ID查询
	 */
	public 	List<ProductComment> commentQueryById(int product_id){
		return  ProductComment.me.find("select * from product_comment where product_id=?",
				product_id);
		
	}
	
	public List<ProductComment> findLastComments(int product_id){
		return  find("select c.*,v.ver_Id,v.ver_code from product_comment c,product_version v  where c.version_id=v.ver_Id and  v.product_id=? order by c.create_time desc",
				product_id);
	}
}
