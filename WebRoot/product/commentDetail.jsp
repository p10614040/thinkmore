<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="common.jsp"%>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>${version.ver_code }</title>

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

<!-- Bootstrap-Table -->
<link href="components/bootstrap-table/bootstrap-table.css"
	rel="stylesheet">
<!-- Bootstrap validator -->
<link
	href="components/bootstrap-validator/css/bootstrapValidator.min.css"
	rel="stylesheet">
<!-- Bootstrap Switch-->
<link
	href="components//bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css"
	rel="stylesheet">
<!-- kindeditor 富文本编辑器 -->
<link rel="stylesheet"
	href="components/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet"
	href="components/kindeditor-4.1.10/plugins/code/prettify.css" />
<link href="css/productConfig.css" rel="stylesheet">
 <link href="css/channel.css" rel="stylesheet">
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-8">
				<div class="page-header">
					<h3>
						${version.ver_code} <small><a
							href="/product/productDetail/${version.product_id}">${version.name}</a></small>
					</h3>
				</div>
				<div>${version.desc }</div>
				<div>
					<p>
						<a class="btn btn-success" role="button"
							href="${version.document }" target="_blank"> 文档:
							${version.ver_code } </a> <a class="btn btn-success" role="button"
							href="${version.download }" target="_blank"> 下载:
							${version.ver_code }</a>
					</p>
				</div>
<div>

<h1 class="page-header">最新评论</h1>
				<div id="DynaInfo" >
	          	<div   class="TopTweets_content">
	          		<ul class="TopTweets">
	          			
	          			<c:forEach items="${commentlist }" var="follow" end="4">
	          			
	          			<li>
	          				<span class=" ">
	          					<span class="user">
	          					<a href="javascript:void(0)">${follow.user_id }</a>对<a href="/version/${follow.ver_Id }">${follow.ver_code }</a>的评论：
	          					</span>
	          					<span  >
	          					${follow.content }
	          					</span>
	          					<span class="time">
	          					<a href="#"> ${follow.create_time } </a>  
	          					</span> 
	          				</span>
	          				<div class="clear"></div>
	          			</li>
	          			</c:forEach>
	          		</ul>
	          			
	          	</div>
	          	</div>
</div>





			</div>
			<!-- 右层产品推荐 -->
			<div class="col-xs-4  ">
			 	<div    ><h2 class="page-header">最新版本</h2></div>
			 	<div   class="TopTweets_content">
	          		<ul  class="TopTweets">
	          			
	          			<c:forEach items="${verlist }" var="version" end="4">
	          			
	          			<li>
	          				<a href="/version/${version.ver_Id }">${version.ver_code }</a>  
	          				<p  >${version.desc }</p>
	          				 
	          				<span class="time">
	          					 ${version.cTime } 
	          					</span> 
	          			</li>
	          			</c:forEach>
	          		</ul>
	          		</div>	
	          	
	           
	          	
	          	<div class="RightBlock RightProjectList">
	          	<div    ><h2 class="page-header">相关产品</h2></div>
	          		<ul  >
	          			
	          			<c:forEach items="${productlist }" var="product" end="4">
	          			
	          			<li>
	          				<a href="/product/productDetail/${product.product_id }"> ${product.name } </a>  
	          				<p  >${product.desc }</p>
	          			</li>
	          			</c:forEach>
	          		</ul>
	          			
	          	
	          	</div>
			
			</div>

		</div>
	</div>


	<!-- jQuery (在其它JS之前引用) -->
    <script src="components/jquery/jquery-1.11.2.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
</body>
</html>