package com.uctcinfo.product.index;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Connection.Request;
import org.jsoup.Jsoup;
import org.jsoup.Connection.Method;
import org.jsoup.Connection.Response;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.jfinal.aop.ClearInterceptor;
import com.jfinal.aop.ClearLayer;
import com.jfinal.core.Controller;
import com.jfinal.core.JFinal;
import com.jfinal.upload.UploadFile;
import com.uctcinfo.product.Category;
import com.uctcinfo.product.CategoryBean;
import com.uctcinfo.product.CategoryList;
import com.uctcinfo.product.Product;
import com.uctcinfo.product.User;
import com.uctcinfo.product.UserRole;
import com.uctcinfo.product.util.HtmlUtil;
import com.uctcinfo.product.util.MD5Util;

/**
 * IndexController
 */

public class IndexController extends Controller {

	public static final String LOGIN_URL = "http://60.174.249.206:9999/in/user.php";
	public static String LOG_ERROR = "登录错误";
	public static String LOG_NOAUTH = "抱歉，您没有权限访问该区域。";
	public static Logger log = Logger.getLogger(IndexController.class);

	/**
	 * 首页控制界面
	 */
	public void index() {
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
					CategoryBean categoryBean= new CategoryBean();
					categoryBean.setCategory(subCategory);
					// 根据子类查询该子类下的产品数量
					List<Product> products = Product.me.findProductByCateId(Integer
							.parseInt(subCategory.get("category_id").toString()));
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
		
		List<Product> hotProducts = Product.me.findHotProduct();
		if(hotProducts!=null){
			for(Product p :  hotProducts){
				p.set("desc", HtmlUtil.subhtml(p.getStr("desc"), 500));
			}
		}
		setAttr("hotProducts", hotProducts);
		// 获取每个分类的ID，根据此ID寻找子类
		render("index.jsp");

	}

	/**
	 * @author yan.liang
	 * @date 2015年6月11日 下午4:13:07
	 * @Description 登录页面
	 */
	@ClearInterceptor(ClearLayer.ALL)
	public void login() {
		render("login.jsp");
	}

	/**
	 * @author yan.liang
	 * @date 2015年6月11日 下午4:33:30
	 * @Description 登录判断
	 */
	@ClearInterceptor(ClearLayer.ALL)
	public void loginCheck() {
		String next = getPara("next");
		User temp = getModel(User.class);
		String userId = String.valueOf(temp.get("user_id"));
		String password = String.valueOf(temp.get("password"));
		
		  Map<String, String> map = new HashMap<String, String>();
		  map.put("uname", userId); map.put("pass", password); map.put("op",
		  "login" ); Connection conn = Jsoup.connect(LOGIN_URL); try { Response
		  response =
		  conn.ignoreContentType(true).method(Method.POST).data(map).
		  timeout(20000).execute(); if (response.statusCode() == 200) {
		  log.info("云网用户登录:"+userId); Document document=response.parse();
		  Elements h4 = document.select("div h4"); if
		  (!LOG_ERROR.equals(h4.get(0).text())) { log.info("云网用户登录成功:"+userId);
		  User user=new User(); user.set("user_id", userId);
		  setSessionAttr("user", user); UserRole
		 ur=UserRole.me.getRole(userId); setSessionAttr("userRole", ur); if
		  (next == null) redirect("/"); else redirect(next); return; }else{
		  setAttr("error", "用户名或密码不正确，请重新输入！");
		  
		  } }else{ log.info("云网用户登录失败:"+userId); setAttr("error",
		  "云网用户校验失败，请重试！"); } } catch (IOException e) { log.error("云网登陆失败", e);
		 setAttr("error", "云网用户校验失败，请重试！"); } render("login.jsp");
		 
		/*
		User user = User.dao.findFirst("select * from user where user_id=?",
				userId);
		if (user == null) {
			redirect("/login?next=" + next);
			return;
		} else {
			String pwd = user.get("password", "");
			if (!pwd.equals(MD5Util.string2MD5(password))) {
				redirect("/login?next=" + next);
				return;
			}
		}
		setSessionAttr("user", user);

		// 查询用户角色
		UserRole userRole = UserRole.me.findFirst(
				"select * from user_role where user_id=?", userId);
		setSessionAttr("userRole", userRole);

		if (next == null)
			redirect("/");
		else
			redirect(next);
		 */
	}

	public void logout() {
		removeSessionAttr("user");
		removeSessionAttr("userRole");
		this.getSession().invalidate();
		redirect("/");
	}
	/**
	 * 单文件上传
	 * @throws Exception
	 */
	 public void upload() throws Exception{
		 	HashMap<String, String> extMap = new HashMap<String, String>();
	        extMap.put("image", "gif,jpg,jpeg,png,bmp");
	        extMap.put("flash", "swf,flv");
	        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
	        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
	        Map<String,Object>  result = new HashMap<String,Object>();
	        String dirName = getPara("dir")==null?"image":getPara("dir");
	        String realpath = getSession().getServletContext().getRealPath("/upload");
	        UploadFile uf= getFile("imgFile",realpath);
	        String affix_id = "";
	        String affix_name = "";
	        if(uf!=null){
	            affix_name = uf.getFile().getName();
	            File file = uf.getFile();
	            //检查扩展名
	            String fileExt = affix_name.substring(affix_name.lastIndexOf(".") + 1).toLowerCase();
	            if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
	                result.put("error", 1);
	                result.put("message", "上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");
	                file.delete();
	            }else{
	                SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	                affix_id = df.format(new Date()) + "_" + new Random().nextInt(1000)+"."+fileExt;
	                File savefile = new File(new File(realpath),affix_id);
	                file.renameTo(savefile);
	                
	                result.put("error", 0);
	                result.put("url", JFinal.me().getContextPath()+"/upload/"+affix_id);
	            }
	        }else{
	            result.put("error", 1);
	            result.put("message", "请选择文件");
	        }
	        this.renderJson(result);
	    }
}
