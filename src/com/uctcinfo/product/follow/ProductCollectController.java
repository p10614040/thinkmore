package com.uctcinfo.product.follow;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.uctcinfo.product.User;

public class ProductCollectController extends Controller{
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 下午5:07:53
	 * @Description 查询用户产品收藏情况和已收藏总数统计
	 */
	@SuppressWarnings("static-access")
	public void followQuery(){
		int productId = getParaToInt();
		User user = getSessionAttr("user");
		ProductCollect pc=new ProductCollect();
		List<ProductCollect> pcList = pc.me.find(
				"select * from product_collect where product_id=? and user_id=? ", 
				productId, user.get("user_id"));
		

		ProductCollect pcTotal = pc.me.findFirst(
				"select count(*) as total from product_collect where product_id=? ", 
				productId);
		Map<String, Object> mpList = new HashMap<String, Object>();
		mpList.put("userCollect", pcList);
		mpList.put("totalList", pcTotal);
		this.renderJson(mpList);
	}
	
	/**
	 * 收藏
	 */
	public void follow(){
		int productId=getParaToInt();
		User user=getSessionAttr("user");
		ProductCollect pc=new ProductCollect();
		pc.set("product_id", productId);
		pc.set("user_id", user.get("user_id"));
		pc.save();
		this.renderJson("true");
	}
	/**
	 * 取消收藏
	 */
	public void unfollow(){
		int productId=getParaToInt();
		User user=getSessionAttr("user");
		Db.update("delete from  product_collect where product_id=? and user_id=?" ,productId,user.get("user_id"));
		this.renderJson("true");
	}
}
