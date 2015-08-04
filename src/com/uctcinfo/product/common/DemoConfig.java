package com.uctcinfo.product.common;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.druid.DruidStatViewHandler;
import com.jfinal.render.ViewType;
import com.uctcinfo.product.Blog;
import com.uctcinfo.product.Category;
import com.uctcinfo.product.Product;
import com.uctcinfo.product.version.ProductComment;
import com.uctcinfo.product.ProductController;
import com.uctcinfo.product.ProductTag;
import com.uctcinfo.product.User;
import com.uctcinfo.product.UserRole;
import com.uctcinfo.product.follow.ProductCollect;
import com.uctcinfo.product.follow.ProductCollectController;
import com.uctcinfo.product.index.IndexController;
import com.uctcinfo.product.version.ProductVersion;
import com.uctcinfo.product.version.VersionController;

/**
 * API引导式配置
 */
public class DemoConfig extends JFinalConfig {
	
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		// 加载少量必要配置，随后可用getProperty(...)获取值
		loadPropertyFile("a_little_config.txt");
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP); 							// 设置视图类型为Jsp，否则默认为FreeMarker
		//me.setError404View("404.html");
		//me.setError500View("500.html");
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/", IndexController.class, "/product");	// 第三个参数为该Controller的视图存放路径
		me.add("/product", ProductController.class);
		me.add("/productCollect", ProductCollectController.class, "/product");
		me.add("/version", VersionController.class,"/product");
	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin plugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		me.add(plugin);
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(plugin);
		me.add(arp);
		arp.addMapping("blog", Blog.class);	// 映射blog 表到 Blog模型
		arp.addMapping("user", User.class);
		arp.addMapping("product","product_id", Product.class);
		arp.addMapping("product_version","ver_Id", ProductVersion.class);
		arp.addMapping("product_tag", ProductTag.class);
		arp.addMapping("user_role", UserRole.class);
		arp.addMapping("category", Category.class);
		arp.addMapping("product_comment","pc_id", ProductComment.class);
		arp.addMapping("product_collect", ProductCollect.class);
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		ContextInterceptor ctx=new ContextInterceptor();//全局加上下文
		// AuthInterceptor auth=new AuthInterceptor();
		me.add(ctx);
		// me.add(auth);
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		DruidStatViewHandler dvh =  new DruidStatViewHandler("/druid");
		  me.add(dvh);
	}
	
	/**
	 * 建议使用 JFinal 手册推荐的方式启动项目
	 * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args) {
		JFinal.start("WebRoot", 80, "/", 5);
	}
}
