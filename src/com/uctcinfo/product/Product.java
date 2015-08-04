package com.uctcinfo.product;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * Product model.
 * 
 * 将表结构放在此，消除记忆负担
 * 
 * 
 * 数据库字段名建议使用驼峰命名规则，便于与 java 代码保持一致，如字段名： userId
 */
@SuppressWarnings("serial")
public class Product extends Model<Product> {
	public static final Product me = new Product();

	/**
	 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
	 */
	public Page<Product> paginate(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *",
				"from product order by product_id asc");
	}

	/**
	 * @param CategoryId
	 *            子类产品类型
	 * @return 查询某子类产品类型 的产品有哪些
	 */
	public List<Product> findProductByCateId(int CategoryId) {
		return find("select * from  product where subtype=?", CategoryId);
	}

	/**
	 * 查询热门推荐类的产品 由用户收藏数来排名，用户收藏数高的排上面，取前5个
	 * 
	 * @return 产品类型
	 */
	public List<Product> findHotProduct() {
		return find("SELECT * FROM product a WHERE a.product_id IN "
				+ "( SELECT b.product_id FROM ( SELECT c.product_id, COUNT(*)"
				+ " count_user FROM product c LEFT JOIN product_collect d ON "
				+ "c.product_id = d.product_id GROUP BY c.product_id ) b ORDER "
				+ "BY b.count_user DESC ) LIMIT 5");
	}
	
	/**
	 * @author yudong
	 * @date 2015年6月12日11:43:59
	 * @Description 产品根据ID查询
	 */
	public 	List<Product> productQueryById(int product_id){
		return  Product.me.find("select * from product where product_id=?",
				product_id);
		
	}
	/**
	 * added by wang.jun2
	 * @param typeId 
	 * @param pageNumber
	 * @param pageSize
	 * @return 
	 * 根据大类ID分页查询产品
	 */
	public Page<Product> pageProductByTypeId(int typeId,int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *",
				"from product t  where t.type="+typeId+" order by t.product_id asc");
	}
	/**
	 * added by wang.jun2
	 * @param subTypeId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 *  根据子类ID分页查询产品
	 */
	public Page<Product> pageProductBySubTypeId(int subTypeId,int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *",
				"from product t  where t.subtype="+subTypeId+" order by t.product_id asc");
	}
	
	/**
	 * 根据product_id查询相同分类下的产品 取前5个
	 * @param product_id
	 * @return
	 */
	public List<Product> sameCateProduct(int product_id) {
		List<Product>  list=Product.me
		.find("select * from product p where p.subtype=(select b.subtype from product b where b.product_id=?)",
				product_id);
		//if(list==null)return null;
		//if(list.size()<=5) return list;
		//return list.subList(0, 5);
		return list;
	}
}
