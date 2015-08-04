<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>登录</title>
    <!-- Bootstrap -->
    <link href="components/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="components/bootstrap-3.3.4/css/bootstrap-theme.min.css" rel="stylesheet">
    
    <link href="components/bootstrap-3.3.4/css/signin.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="components/bootstrap-3.3.4/libs/html5shiv.min.js"></script>
      <script src="components/bootstrap-3.3.4/libs/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<div class="container">

      	<form id="loginForm" class="form-signin" action="loginCheck" method="post">
	      	<input type="hidden" value="${ param.next }" name="next">
	        <h2 class="form-signin-heading">产品货架</h2>
	        <label for="inputUserId" class="sr-only">用户名</label>
	        <input type="text" id="inputUserId" name="user.user_id" class="form-control" placeholder="用户名" required autofocus>
	        <label for="inputPassword" class="sr-only">密码</label>
	        <input type="password" id="inputPassword" name="user.password" class="form-control" placeholder="密码" required>
	        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
	        <p id="message" style="color: red;">${error}</p>
      	</form>

    </div> <!-- /container -->
    

    <!-- jQuery (在其它JS之前引用) -->
    <script src="components/jquery/jquery-1.11.2.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
    
    <script src="js/app/login/login.js"></script>
</body>
</html>