package com.uctcinfo.product;

import com.jfinal.plugin.activerecord.Model;

/**
数据库字段名建议使用驼峰命名规则，便于与 java 代码保持一致，如字段名： userId
 */
@SuppressWarnings("serial")
public class UserRole extends Model<UserRole> {
	
	public static final UserRole me = new UserRole();
	
	/**
	 * 按用户查找角色，若没有则自动授权为普通用户
	 * @param userId
	 * @return
	 */
	public UserRole getRole(String userId){
		UserRole ur=	UserRole.me.findFirst("select * from user_role where user_id=?", userId);
		if(ur==null){
			ur=new UserRole();
			ur.set("user_id", userId);
			ur.set("role_id", "normal");
			ur.save();
		}
		return ur;
	}
}
