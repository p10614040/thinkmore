<%--
	公用页面标题导航栏，通过 <%@ include file="navbar.jsp" %> 引入
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.uctcinfo.product.User" %>
 
	<!-- 标题导航栏 -->
	<nav class="navbar navbar-default navbar-fixed-top">
      	<div class="container-fluid">
        	<div class="navbar-header">
          		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            		<span class="sr-only">Toggle navigation</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
          		</button>
          		<a class="navbar-brand" href="/">产品货架</a>
        	</div><!-- /.navbar-header -->
	        <div id="navbar" class="navbar-collapse collapse">
	        	<ul class="nav navbar-nav navbar-left">
	        		<li><a href="${ctx }">首页</a></li>
	        		<li><a href="${ctx }/product/productCollect">我的收藏</a></li>
	        		<li><a href="${ctx }/product/productConfig">产品发布</a></li>
	        		<li><a href="http://60.174.249.204:8888/in/modules/newbb/" target="_blank">论坛</a></li>
	        	</ul>
	          	<ul class="nav navbar-nav navbar-right">
		            <li class="dropdown">
		            	<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="帮助">
		            		<span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span>
		            	</a>
		            	<div class="dropdown-menu" style="width: 340px;padding-left: 15px;padding-right: 15px;">
		            		<h3>帮助</h3>
		            		<p><strong>产品审核</strong>：产品发布后由管理员进行审核。</p>
		            		<p><strong>版本发布</strong>：产品发布后需要进行版本发布才能进行评论查阅等功能。</p>
		            		<p><strong>版本号</strong>：默认显示最新的版本。</p>
		            	</div>
		            </li>
		            <li class="dropdown">
	                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="用户">
	                        ${user.user_id } <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <span class="caret"></span>
	                    </a>
	                    <ul class="dropdown-menu">
	                        <li>
	                        	<a href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> 修改资料</a>
	                        </li>
	                        <li>
	                        	<a href="#"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> 修改密码</a>
	                        </li>
	                        <li class="divider"></li>
	                        <li>
	                        	<a href="${ctx }/logout"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> 注销</a>
	                        </li>
	                    </ul>
	                    <!-- /.dropdown-user -->
	                </li>
	          	</ul>
	          	<form class="navbar-form navbar-right">
	            	<input type="text" class="form-control" placeholder="Search...">
	          	</form>
        	</div>
		</div><!-- /.container-fluid -->
    </nav><!-- /.navbar navbar-inverse navbar-fixed-top -->