package com.uctcinfo.product.version;

import java.util.Date;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.uctcinfo.product.PageGrid;
import com.uctcinfo.product.Product;
import com.uctcinfo.product.User;
import com.uctcinfo.product.UserRole;
import com.uctcinfo.product.util.HtmlUtil;

public class VersionController extends Controller{
	
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 上午10:25:26
	 * @Description 版本查询
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void versionQuery(){
		// 产品ID
		String productId = getPara("productId");
		if(productId == null || productId.length() == 0 || Integer.valueOf(productId) == 0){
			return;
		}
		
		// 第几页
		int pageNumber = getParaToInt("start") / getParaToInt("limit") + 1;
		// 每页显示行数
		int pageSize = getParaToInt("limit");
		String keyword = getPara("keyword");
		StringBuffer whereSql = new StringBuffer();
		whereSql.append("from product_version p  where  p.product_id = " + productId);
		if(keyword != null && keyword.length() > 0){
			whereSql.append(" and ver_code like '%" + keyword + "%'");
		}
		whereSql.append(" order by cTime desc");
		Page<ProductVersion> pageProduct = ProductVersion.me.paginate(pageNumber, pageSize, 
				"select p.*", whereSql.toString());
		this.renderJson(new PageGrid(pageProduct.getList(), pageProduct.getTotalRow()));
	}
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 上午10:29:09
	 * @Description 版本发布
	 */
	public void versionSave(){
		ProductVersion productVersion = getModel(ProductVersion.class);
		System.out.println(productVersion.get("document"));
		if(productVersion.get("ver_Id") == null || productVersion.get("ver_Id").toString().length() == 0){
			productVersion.save();
		}else {
			productVersion.update();
		}
		this.renderJson("true");
	}
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 上午10:30:31
	 * @Description 版本删除
	 */
	public void versionDelete(){
		ProductVersion productVersion = getModel(ProductVersion.class);
		if(productVersion.get("ver_Id") != null && productVersion.get("ver_Id").toString().length() > 0){
			productVersion.delete();
		}
		this.renderJson("true");
	}
	
	
	public void index(){
		int versionId=getParaToInt();
		ProductVersion c=ProductVersion.me.queryVersionAndProduct(versionId);
		setAttr("version", c);
		//最新评论
		setAttr("commentlist", ProductComment.me.findLastComments(c.getInt("product_id")));
		//相关产品
				List<Product> productlist=Product.me.sameCateProduct(c.getInt("product_id"));
				if(productlist!=null){
					for(Product p :  productlist){
						p.set("desc", HtmlUtil.subhtml(p.getStr("desc"), 200));
					}
				}
				setAttr("productlist",productlist);
				
				List<ProductVersion> verlist= ProductVersion.me.findVersionHaveComment(c.getInt("product_id"));
				setAttr("verlist",verlist);
		render("commentDetail.jsp");
	}
	/**
	 * @author yudong
	 * @date 2015年6月12日11:43:59
	 * @Description 评论保存
	 */
	public void newComment(){
		int productid=this.getParaToInt();
		ProductVersion version=ProductVersion.me.findFirst("select * from product a,product_version b where a.product_id=b.product_id and a.product_id=? order by b.cTime desc",productid);
		   if(version==null){
			   redirect("/product/productDetail/"+productid);
			   return;
		   }
        ProductComment comment=	new ProductComment();
        comment.set("version_id", version.get("ver_Id"));
        comment.set("content",getPara("msg"));
		User user = getSessionAttr("user");
	    String userId = user.get("user_id");
		comment.set("user_id",userId);
		comment.save();
		redirect("/product/productDetail/"+productid);
	}
	/**
	 * @author yudong
	 * @date 2015年6月12日11:43:59
	 * @Description 根据ver_id查评论
	 */
	public void listComment(){
		/*UserRole userRole = getSessionAttr("userRole");
		String userId = userRole.get("user_id");
		String roleId = userRole.get("role_id");*/
		
		// 第几页
		int pageNumber = getParaToInt("start") / getParaToInt("limit") + 1;
		// 每页显示行数
		int pageSize = getParaToInt("limit");
		int ver_id = getParaToInt("ver_id");
		StringBuffer whereSql = new StringBuffer();
		whereSql.append("from product_comment where version_id="+ver_id);
		
	
		Page<ProductComment> pageProduct = ProductComment.me.paginate(pageNumber, pageSize, 
				"select *  ", whereSql.toString());
		
		this.renderJson(new PageGrid<ProductComment>(pageProduct.getList(), pageProduct.getTotalRow()));
	}
	
	

	
	
}
