package com.uctcinfo.product;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

/**
 */
@SuppressWarnings("serial")
public class ProductTag extends Model<ProductTag> {
	public static final ProductTag me = new ProductTag();
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 下午1:31:17
	 * @Description 删除标签
	 */
	public void deleteTagName(int productId){
		Db.update(" delete from product_tag where product_id = " + productId);
	}
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 下午1:38:38
	 * @Description 保存标签
	 */
	public void saveTagName(int productId, String tagName){
		Db.update(" insert into product_tag(product_id, tag_name) values(" + productId + ",'" + tagName + "')");
	}
	
}
