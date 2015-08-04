<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>产品列表</title>

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
<link href="css/productTable.css" rel="stylesheet">
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!-- 产品分类导航 -->
			<div class="col-xs-3" id="myScrollspy">
				<h2>产品分类</h2>
				<c:forEach var="cateGorys" items="${cateGorysSet}">
					<div class='TopTag opened'>
						<h3>
							<a href="/product/productTable?productType=${cateGorys.category.category_id}"
								class='menuItem'>${cateGorys.category.category_name}</a>
						</h3>
						<ul id='menuItem_1'>
							<c:forEach var="categoryBean" items="${cateGorys.categorylist}">
								<li><a href="/product/productTable?subProductType=${categoryBean.category.category_id}"><em>${categoryBean.categoryCount}</em>${categoryBean.category.category_name}</a></li>
							</c:forEach>
						</ul>
					</div>
				</c:forEach>
			</div>
			<!-- 查询出的产品列表 -->
			<div class="col-xs-9">
				<h2 class='special'><eml class='specialTitle'>${cateGory.category_name}</eml></h2>
				<table id="bsTable">
				</table>
			</div>
		</div>
	</div>
	</div>

	<!-- jQuery (在其它JS之前引用) -->
	<script src="components/jquery/jquery-1.11.2.min.js"></script>

	<!-- Bootstrap -->
	<script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
	 <!-- Bootstrap table -->
    <script src="../components/bootstrap-table/bootstrap-table.js"></script>
	<script src="../components/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
	<!-- Bootstrap table 公用方法 -->
	<script src="../components/bootstrap-table/common/bsTableDefault.js"></script>
	<script src="../components/bootstrap-table/common/bsTableFormatter.js"></script>
	
	<script src="../js/app/productTable/productTable.js"></script>
	<% String productType = request.getParameter("productType"); %>
	<% String subProductType = request.getParameter("subProductType"); %>
	<script type="text/javascript">
	var ctxUrl = '${ctx}';
	var productType = <%=productType%>;
	var subProductType = <%=subProductType%>;
	</script>
</body>
</html>