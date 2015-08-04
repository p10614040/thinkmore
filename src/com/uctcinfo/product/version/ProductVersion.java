package com.uctcinfo.product.version;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

/**
 * 版本表
 * 
 * @author jinxx
 *
 */
@SuppressWarnings("serial")
public class ProductVersion extends Model<ProductVersion> {
	public static ProductVersion me = new ProductVersion();

	/**
	 * 根据product_id 查询出版本及版本下评论数量
	 * 
	 * @param product_id
	 * @return
	 */
	public List<ProductVersion> findVersionHaveComment(int product_id) {
		return find(
				"select v.* ,( select count(*) cnt from  product_comment  c where c.version_id=v.ver_Id) cnt"
						+ " from product_version v  where v.product_id=?  order by v.cTime desc",
				product_id);

	}

	public ProductVersion queryVersionAndProduct(int version_id) {
		return  findFirst(
						"select v.*,p.product_id,p.name from product p,product_version v where p.product_id=v.product_id and v.ver_Id=?",
						version_id);
	}
}
