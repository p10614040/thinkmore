package com.uctcinfo.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;






import org.apache.commons.lang3.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.uctcinfo.product.follow.ProductCollect;
import com.uctcinfo.product.util.HtmlUtil;
import com.uctcinfo.product.version.ProductComment;
import com.uctcinfo.product.version.ProductVersion;

/**
 * ProductController
 */
/**
 * @author YanLiang
 * 
 */
public class ProductController extends Controller {
//	private String productTypeId;
//	private String subProductTypeId;
	public static final String ADMIN_ROLE_ID = "admin";

	/**
	 * @author yan.liang
	 * @date 2015年6月11日 下午3:50:38
	 * @Description 参考页面
	 */
	public void pageIndex() {
		render("pageIndex.jsp");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月11日 下午3:50:31
	 * @Description 首页
	 */
	public void index() {
		render("index.jsp");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月11日 下午3:50:22
	 * @Description 产品详情
	 */
	public void productDetail() {
		int product_id=getParaToInt();
		User user = getSessionAttr("user");
		String user_id=user.getStr("user_id");
		Product product =Product.me.findById(product_id);//产品信息
		setAttr("product", product);
		int follow=ProductCollect.me.checkUserFollow(product_id, user_id);//当前用户是否收藏
		 
		setAttr("follow", follow);
		List<ProductVersion> verlist= ProductVersion.me.findVersionHaveComment(product_id);
		setAttr("verlist",verlist);
		//关注用户 
		setAttr("userlist", ProductCollect.me.getFollowUsers(product_id));
		//最新评论
		setAttr("commentlist", ProductComment.me.findLastComments(product_id));
		//相关产品
		List<Product> productlist=Product.me.sameCateProduct(product_id);
		if(productlist!=null){
			for(Product p :  productlist){
				p.set("desc", HtmlUtil.subhtml(p.getStr("desc"), 200));
			}
		}
		// 所属标签
		ProductTag productTag = ProductTag.me.findFirst("select group_concat(pt.tag_name) as tag_names from product_tag pt where pt.product_id = ?",
				product_id);
		setAttr("tag_names", productTag.get("tag_names"));
		setAttr("productlist",productlist);
		render("detail.jsp");
	}

	/**
	 * 产品列表
	 */
	public void productTable() {

		/**
		 * 左侧导航栏
		 */
		// 传给前台的对象
		List<CategoryList> cateGorysSet = new ArrayList<CategoryList>();
		// 产品四大分类
		List<Category> cateGorysList = Category.categoryDao
				.findCateByParentId(0);

		if (cateGorysList == null) {
			return;
		}
		for (Category category : cateGorysList) {
			List<CategoryBean> categoryBeanList = new ArrayList<CategoryBean>();
			CategoryList cateList = new CategoryList();
			cateList.setCategory(category);

			// 根据大类ID查询该大类的子类
			List<Category> subCateGorysList = Category.categoryDao
					.findCateByParentId(Integer.parseInt(category.get(
							"category_id").toString()));
			if (subCateGorysList != null && subCateGorysList.size() > 0) {
				for (Category subCategory : subCateGorysList) {
					CategoryBean categoryBean = new CategoryBean();
					categoryBean.setCategory(subCategory);
					// 根据子类查询该子类下的产品数量
					List<Product> products = Product.me
							.findProductByCateId(Integer.parseInt(subCategory
									.get("category_id").toString()));
					categoryBean.setCategoryCount(products.size());
					categoryBeanList.add(categoryBean);
				}
				cateList.setCategorylist(categoryBeanList);
			}
			cateGorysSet.add(cateList);
		}
		if (cateGorysSet != null && cateGorysSet.size() > 0) {
			setAttr("cateGorysSet", cateGorysSet);
		}
		String productTypeId = getPara("productType");
		String subProductTypeId = getPara("subProductType");
		Category category =null;
		if(productTypeId!=null && productTypeId.length()>0){
			category = Category.categoryDao.findFirst("select * from category t where t.category_id=?",productTypeId);
		}else if(subProductTypeId!=null && subProductTypeId.length()>0){
			category = Category.categoryDao.findFirst("select * from category t where t.category_id=?",subProductTypeId);
		}
		if(category!=null){
			setAttr("cateGory", category);
		}
		render("productTable.jsp");
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void productTableQuery() {
		// 第几页
		int pageNumber = getParaToInt("start") / getParaToInt("limit") + 1;
		// 每页显示行数
		int pageSize = getParaToInt("limit");
		String productTypeId = getPara("productType");
		String subProductTypeId = getPara("subProductType");
		System.out.println("父类ID为：" + productTypeId + ",子类ID为"
				+ subProductTypeId);
		Page<Product> pageProducts = null;
		if (productTypeId == null || productTypeId.length() == 0) {
			if (subProductTypeId == null || subProductTypeId.length() == 0) {
				pageProducts = Product.me.paginate(pageNumber, pageSize);
			} else {
				pageProducts = Product.me
						.pageProductBySubTypeId(
								Integer.valueOf(subProductTypeId), pageNumber,
								pageSize);
			}
		} else if (subProductTypeId == null || subProductTypeId.length() == 0) {
			pageProducts = Product.me.pageProductByTypeId(
					Integer.valueOf(productTypeId), pageNumber, pageSize);
		} else {
			return;
		}
		for (Product p : pageProducts.getList()) {
			p.set("desc", HtmlUtil.subhtml(p.getStr("desc"), 1000));
		}
		this.renderJson(new PageGrid(pageProducts.getList(), pageProducts
				.getTotalRow()));
	}
	
	
	/**
	 * 产品收藏列表
	 */
	public void productCollect() {

		/**
		 * 左侧导航栏
		 */
		// 传给前台的对象
		List<CategoryList> cateGorysSet = new ArrayList<CategoryList>();
		// 产品四大分类
		List<Category> cateGorysList = Category.categoryDao
				.findCateByParentId(0);

		if (cateGorysList == null) {
			return;
		}
		for (Category category : cateGorysList) {
			List<CategoryBean> categoryBeanList = new ArrayList<CategoryBean>();
			CategoryList cateList = new CategoryList();
			cateList.setCategory(category);

			// 根据大类ID查询该大类的子类
			List<Category> subCateGorysList = Category.categoryDao
					.findCateByParentId(Integer.parseInt(category.get(
							"category_id").toString()));
			if (subCateGorysList != null && subCateGorysList.size() > 0) {
				for (Category subCategory : subCateGorysList) {
					CategoryBean categoryBean = new CategoryBean();
					categoryBean.setCategory(subCategory);
					// 根据子类查询该子类下的产品数量
					List<Product> products = Product.me
							.findProductByCateId(Integer.parseInt(subCategory
									.get("category_id").toString()));
					categoryBean.setCategoryCount(products.size());
					categoryBeanList.add(categoryBean);
				}
				cateList.setCategorylist(categoryBeanList);
			}
			cateGorysSet.add(cateList);
		}
		if (cateGorysSet != null && cateGorysSet.size() > 0) {
			setAttr("cateGorysSet", cateGorysSet);
		}
		String productTypeId = getPara("productType");
		String subProductTypeId = getPara("subProductType");
		Category category =null;
		if(productTypeId!=null && productTypeId.length()>0){
			category = Category.categoryDao.findFirst("select * from category t where t.category_id=?",productTypeId);
		}else if(subProductTypeId!=null && subProductTypeId.length()>0){
			category = Category.categoryDao.findFirst("select * from category t where t.category_id=?",subProductTypeId);
		}
		if(category!=null){
			setAttr("cateGory", category);
		}
		render("productCollect.jsp");
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void productTableCollect() {
		User user = getSessionAttr("user");
		String user_id=user.getStr("user_id");
		// 第几页
		int pageNumber = getParaToInt("start") / getParaToInt("limit") + 1;
		// 每页显示行数
		int pageSize = getParaToInt("limit");
		System.out.println("用户ID为：" + user_id );
		Page<Product> pageProducts = null;
		if (user_id != null || user_id.length() > 0) {
			pageProducts = Product.me.paginate(pageNumber, pageSize, "select a.*",
					" from product a,product_collect b WHERE a.product_id =b.product_id and b.user_id= ?", user_id);
		}
		for (Product p : pageProducts.getList()) {
			p.set("desc", HtmlUtil.subhtml(p.getStr("desc"), 1000));
		}
		this.renderJson(new PageGrid(pageProducts.getList(), pageProducts
				.getTotalRow()));
	}
	

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 上午10:05:28
	 * @Description 产品配置
	 */
	public void productConfig() {
		render("productConfig.jsp");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 下午7:57:59
	 * @Description 版本发布页面
	 */
	public void productVersion() {
		Object product_id = getPara("productId");
		setAttr("product_id", product_id);
		render("productVersion.jsp");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 上午10:25:58
	 * @Description 产品查询
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void productQuery() {
		// 获取用户与角色ID
		UserRole userRole = getSessionAttr("userRole");
		String userId = userRole.get("user_id");
		String roleId = userRole.get("role_id");

		// 第几页
		int pageNumber = getParaToInt("start") / getParaToInt("limit") + 1;
		// 每页显示行数
		int pageSize = getParaToInt("limit");
		String keyword = getPara("keyword");
		StringBuffer whereSql = new StringBuffer();
		whereSql.append("from product p left join category c1 on p.type = c1.category_id"
				+ " left join category c2 on p.subtype = c2.category_id "
				+ " where  1 = 1 ");
		if (keyword != null && keyword.length() > 0) {
			whereSql.append(" and name like '%" + keyword + "%'");
		}
		// 管理员可以查询所有的产品，其它角色只能查看自己创建的产品
		if (!ADMIN_ROLE_ID.equals(roleId)) {
			whereSql.append(" and userid = '" + userId + "'");
		}
		whereSql.append(" order by product_id asc");
		Page<Product> pageProduct = Product.me.paginate(pageNumber, pageSize, 
				"select p.*, c1.category_name as type_name, c2.category_name as subtype_name"
				+ ",(select pv.ver_code from product_version pv where pv.product_id = p.product_id "
				+ " order by pv.cTime desc limit 1) as ver_code,"
				+ "(select group_concat(pt.tag_name) from product_tag pt where pt.product_id = p.product_id)"
				+ " as tag_names", 
				whereSql.toString());
		
		this.renderJson(new PageGrid(pageProduct.getList(), pageProduct.getTotalRow()));
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 下午4:23:50
	 * @Description 产品保存
	 */
	public void productSave() {
		Product product = getModel(Product.class);
		ProductTag productTag = getModel(ProductTag.class);
		User user = getSessionAttr("user");
		Object[] tagNames = analyTagNames(productTag.get("tag_name"));
		if(product.get("product_id") == null || product.get("product_id").toString().length() == 0){
			String userId = user.get("user_id");
			product.set("userid", userId);
			product.save();
			// 保存标签
			tagNameSave(product, tagNames);
			
		}else {
			product.update();
			
			// 更新标签
			String[] productTagAttrs = productTag.getAttrNames();
			for (String attName : productTagAttrs) {
				if("tag_name".equals(attName)){
					tagNameSave(product, tagNames);
					break;
				}
			}
		}
		this.renderJson("true");
	}
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 下午1:00:38
	 * @Description 解析标签
	 */
	public String[] analyTagNames(Object tagNames){
		if(tagNames == null || tagNames.toString().length() == 0){
			return null;
		}
		String tagNamesStr = tagNames.toString().trim();
		String[] orStrs = {",","，"};
		String OR_KEYWORD = ",";
		for (String orStr : orStrs) {
			tagNamesStr = StringUtils.replace(tagNamesStr, orStr, OR_KEYWORD);
		}
		return tagNamesStr.replaceAll(" +", OR_KEYWORD).split(OR_KEYWORD);
	}
	
	
	/**
	 * @author yan.liang
	 * @date 2015年6月13日 下午1:28:40
	 * @Description 标签保存
	 */
	@SuppressWarnings("static-access")
	public void tagNameSave(Product product, Object[] tagNames){
		// 保存前删除已有标签
		ProductTag productTagDel = getModel(ProductTag.class);
		productTagDel.set("product_id", product.get("product_id"));
		if(productTagDel.get("product_id") != null && productTagDel.get("product_id").toString().length() > 0){
			productTagDel.me.deleteTagName(Integer.valueOf(productTagDel.get("product_id").toString()));
		}
		// 保存标签
		if(tagNames != null && tagNames.length > 0){
			for (Object object : tagNames) {
				String tagName = String.valueOf(object);
				productTagDel.me.saveTagName(Integer.valueOf(productTagDel.get("product_id").toString()), 
						tagName);
			}
		}
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 下午6:11:25
	 * @Description 产品删除
	 */
	public void productDelete() {
		Product product = getModel(Product.class);
		if (product.get("product_id") != null
				&& product.get("product_id").toString().length() > 0) {
			product.delete();
		}
		this.renderJson("true");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月12日 下午2:31:37
	 * @Description 查询产品分类
	 */
	public void categoryQuery() {
		int parentId = getParaToInt("parentType");
		List<Category> listCategories = Category.categoryDao
				.findCateByParentId(parentId);
		this.renderJson(listCategories);
	}

	/**
	 * @author yudong
	 * @date 2015年6月12日11:43:59
	 * @Description 产品查询
	 */
	public void productQueryById() {
		int product_id = getParaToInt("product_id");
		List<Product> product = Product.me.productQueryById(product_id);
		this.renderJson(product);
	}

	public void productCommentQuery() {

	}

	public void commentSave() {
		ProductComment comment = this.getModel(ProductComment.class);

		UserRole userRole = getSessionAttr("userRole");
		String userId = userRole.get("user_id");
		// String roleId = userRole.get("role_id");
		comment.set("user_id", userId);
		System.out.println(getParaToInt("ProductComment.product_id"));
		comment.set("product_id", getParaToInt("ProductComment.product_id"));
		comment.set("content", getPara("ProductComment.content"));
		comment.set("title", getPara("ProductComment.title"));
		comment.set("content",getPara("ProductComment.content"));
		comment.set("create_time", new Date());
		comment.set("version_id", getParaToInt("ProductComment.version_id"));
		comment.save();
		System.out.println("保存成功！");
		this.renderJson("true");
	}

	public void commentQueryById() {
		int product_id = getParaToInt("product_id");
		List<ProductComment> commet = ProductComment.me
				.commentQueryById(product_id);
		this.renderJson(commet);
	}
	
	public void productCollectSave(){
		int product_id=getParaToInt("product_id");
		UserRole userRole = getSessionAttr("userRole");
	    String userId = userRole.get("user_id");
	    this.render("true");
	}
}
