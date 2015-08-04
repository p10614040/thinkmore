<%--
	公用页面标题导航栏，通过 <%@ include file="navbar.jsp" %> 引入
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	        		<li><a href="/product/index">首页</a></li>
	        		<li><a href="pageTable.jsp">产品配置</a></li>
	        		<li><a href="http://60.174.249.204:8888/in/modules/newbb/" target="_blank">论坛</a></li>
	        	</ul>
	          	<ul class="nav navbar-nav navbar-right">
		            <li><a href="#" title="系统设置"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span></a></li>
		            <li><a href="#" title="帮助"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a></li>
		            <li class="dropdown">
	                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="用户">
	                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <span class="caret"></span>
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
	                        	<a href="#"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> 注销</a>
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