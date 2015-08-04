package com.uctcinfo.product.follow;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

@SuppressWarnings("serial")
public class ProductCollect extends Model<ProductCollect>{
	public static ProductCollect me=new ProductCollect();

	/*
	 * 按product_id查询关注的用户
	 */
	public List<ProductCollect> getFollowUsers(int product_id){
		return this.find("select * from product_collect where product_id=?",product_id);
	}
	/**
	 * 判断用户是否收藏,0:未收藏，1收藏
	 * @param user_id
	 * @return
	 */
	public int checkUserFollow(int product_id,String user_id){
		List<ProductCollect> list= this.find("select * from product_collect where product_id=? and user_id=?",product_id,user_id);
		if(list==null||list.size()==0)return 0 ;else return 1;
	}
}
