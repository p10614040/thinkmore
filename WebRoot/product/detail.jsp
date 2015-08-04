<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>${product.name }</title>

    <!-- Bootstrap -->
    <link href="components/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="components/bootstrap-3.3.4/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="components/bootstrap-3.3.4/template/dashboard/dashboard.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="components/bootstrap-3.3.4/libs/html5shiv.min.js"></script>
      <script src="components/bootstrap-3.3.4/libs/respond.min.js"></script>
    <![endif]-->
    <style>
    </style>
    <link href="css/channel.css" rel="stylesheet">
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp" %>
    
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-8">
				<div class="col-xs-12 page-header">
					<div class="productTitle"><h1>${product.name }</h1></div>
					<div class="star">
						 <button type="button" class="btn btn-default" onclick="collect(this)">
						  <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span> <span>收藏</span>  <span class="badge">0</span>
						</button>
					</div>
					
				</div>
				<div>
	          			${product.desc }
				</div>
				<div>
	          			<em ><font color="red">标签：${tag_names}</font></em>
				</div>
				<div>
	         		 <p>
	          			<c:forEach items="${verlist }" var="version" end="0">
	          		 	 <a class="btn btn-success"  role="button"  href="${version.document }" target="_blank"> 文档: ${version.ver_code } </a>  
	          			 <a class="btn btn-success"  role="button"  href="${version.download }" target="_blank"> 下载: ${version.ver_code }</a> 
	          			</c:forEach>
	          			
	          		</p>
	          		</div>
	          	<div>
	          		<h3 class="page-header">该产品发布的版本记录</h3>
	          		<div>
	          			<table class="table">
	          				<tr>
 								<th>版本名称  </th>
 								<th>发布时间 </th>
 								<th>评论 </th>
 							</tr>
 							<c:forEach items="${verlist }" var="version" end="4">
 								<tr>
 							 
 								<td><a href="/version/${version.ver_Id }">${version.ver_code }</a>  </td>
 								<td>${version.cTime }</td>
 								<td>${version.cnt } </td>
 							</tr>
 							</c:forEach>
 							
						</table> 
	          		</div>
	          	</div>
			</div>
			<div class="col-xs-4">
				<h1 class="page-header">最新评论</h1>
				<div id="DynaInfo" >
				<form id="TForm" action="/version/newComment/${product.product_id }" onkeydown="if((event.metaKey || event.ctrlKey)&amp;&amp;event.keyCode==13){submitMe();}" method="POST">
    				<textarea name="msg" placeholder="关于这款产品你有什么要说的吗？"></textarea>
					<button value="提交" type="submit"> 提交</button>   		
    			</form>
	          	<div   class="TopTweets_content">
	          		<ul class="TopTweets">
	          			
	          			<c:forEach items="${commentlist }" var="follow" end="4">
	          			
	          			<li>
	          				<span class=" ">
	          					<span class="user">
	          					<a href="javascript:void(0)">${follow.user_id }</a>对<a href="/version/${follow.ver_Id }">${follow.ver_code }</a>的评论：
	          					</span>
	          					<span class="log">
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
	          	<h2 class="page-header">共有${fn:length(userlist)}人关注</h2>
	          	<div id="">
	          		 
	          			<c:forEach items="${userlist }" var="follow">
	          			<a href="javascript:void(0)"> ${follow.user_id } </a>  
	          			</c:forEach>
	          		 
	          	</div>
			</div>
      	</div>
    </div>
    

    <!-- jQuery (在其它JS之前引用) -->
    <script src="components/jquery/jquery-1.11.2.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
    
    <script src="js/app/detail.js"></script>
    <script type="text/javascript">
    var ctxUrl = '${ctx}',
    	productId = ${product.product_id };
    </script>
</body>
</html>