<%@page import="com.uctcinfo.product.Category"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="common.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>首页</title>
<!-- Bootstrap -->
<link href="components/bootstrap-3.3.4/css/bootstrap.min.css"
	rel="stylesheet">
<link href="components/bootstrap-3.3.4/css/bootstrap-theme.min.css"
	rel="stylesheet">
<link href="components/bootstrap-3.3.4/template/dashboard/dashboard.css"
	rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="components/bootstrap-3.3.4/libs/html5shiv.min.js"></script>
      <script src="components/bootstrap-3.3.4/libs/respond.min.js"></script>
    <![endif]-->




<link href="css/index.css" rel="stylesheet">
<link href="components/tor/css/style.css" rel="stylesheet" />
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp"%>
	<%-- 	<%
		List<Category> cateGorys = (List<Category>) request.getAttribute("cateGorys");
		System.out.print(cateGorys);
	%> --%>
	<!-- 首页内容 -->
	<div class="container-fluid content">
		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-xs-8 col-lg-7 leftSide">
				<c:forEach var="cateGorys" items="${cateGorysSet}">
					<div class="container-fluid categorys badgeRow">
						<div class='row'>
							<h4>
								<a href="/product/productTable?productType=${cateGorys.category.category_id}">
									${cateGorys.category.category_name}</a>
							</h4>
							<c:forEach var="categoryBean" items="${cateGorys.categorylist}">
								<div class="col-xs-4">
									<a href="/product/productTable?subProductType=${categoryBean.category.category_id}">${categoryBean.category.category_name}<span
										class="badge">${categoryBean.categoryCount}</span></a>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 右层产品推荐 -->
			<div class="col-xs-4 col-lg-3">
				<!-- 标题 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-xs-8">
							<h3 style="color: #40AA53;">热门产品</h3>
						</div>
						<div class="col-xs-4" style="text-align: right;padding-top: 24px;">
							<a href='/product/productTable' class='more'>更多 &raquo;</a>
						</div>
					</div>
				</div>

				<!-- 产品列表 -->
				<div class="container-fluid">
					<c:forEach var="product" items="${hotProducts}">
						<h4>
							<a href="product/productDetail/${product.product_id}">${product.name}</a>
						</h4>

						<p class="tbconxx">${product.desc}</p>
					</c:forEach>
				</div>
			</div>
			<div class="col-lg-1"></div>
		</div>
	</div>


	<!-- jQuery (在其它JS之前引用) -->
	<script src="components/jquery/jquery-1.11.2.min.js"></script>

	<!-- Bootstrap -->
	<script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>

</body>
</html>