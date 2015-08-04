<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.uctcinfo.product.UserRole" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="common.jsp"%>
	<base href="<%=basePath%>" />
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    
	<title>版本发布</title>
    
	<!-- Bootstrap -->
    <link href="components/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="components/bootstrap-3.3.4/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="components/bootstrap-3.3.4/template/dashboard/dashboard.css" rel="stylesheet">
    
    
    <!-- Bootstrap-Table -->
    <link href="components/bootstrap-table/bootstrap-table.css" rel="stylesheet" >
    
    <!-- Bootstrap validator -->
    <link href="components/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet" >
    
    <!-- Bootstrap Switch-->
    <link href="components//bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css" rel="stylesheet">
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="components/bootstrap-3.3.4/libs/html5shiv.min.js"></script>
      <script src="components/bootstrap-3.3.4/libs/respond.min.js"></script>
    <![endif]-->
    
    <!-- kindeditor 富文本编辑器 -->
    <link rel="stylesheet" href="components/kindeditor-4.1.10/themes/default/default.css" />
	<link rel="stylesheet" href="components/kindeditor-4.1.10/plugins/code/prettify.css" />
    
    <link href="css/productVersion.css" rel="stylesheet" >
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp" %>
	
    
    <!-- 表单 -->
	<div class="container-fluid" id="formDiv">
      	<div class="row">
          	<div class="col-xs-9">
          		<div class="col-xs-2"></div>
          		<div class="col-xs-10"><h3>版本发布</h3></div>
      			
          		<form class="form-horizontal" id="bsFrom" role="form" action="javascript:bsForm.add()">
          			<input type="hidden" name="productVersion.ver_Id" id="ver_Id" value="">
          			<input type="hidden" name="productVersion.product_id" id="product_id" value="">
				   	<div class="form-group">
				      	<label for="ver_code" class="col-sm-2 control-label">版本号 <sup>*</sup></label>
				      	<div class="col-sm-10">
				         	<input type="text" class="form-control" id="ver_code" 
				         		placeholder="" name="productVersion.ver_code">
				      	</div>
				   	</div>
				   	<div class="form-group">
				   		<label for="document" class="col-sm-2 control-label">文档地址 <sup>*</sup></label>
				      	<div class="col-sm-10">
				         	<input type="text" class="form-control" id="document" 
				         		placeholder="" name="productVersion.document">
				      	</div>
				   	</div>
				   	<div class="form-group">
				      	<label for="download" class="col-sm-2 control-label">下载地址 <sup>*</sup></label>
				      	<div class="col-sm-10">
							<input type="text" class="form-control" id="download" 
				         		placeholder="" name="productVersion.download">
						</div>
				   	</div>
				   	<div class="form-group">
				      	<label for="desc" class="col-sm-2 control-label">版本说明</label>
				      	<div class="col-sm-10" id="editDiv">
				      		<textarea class="editArea" id="desc" name="productVersion.desc" cols="100" rows="8" 
				      			style="width: 100%;height:200px;visibility:hidden;"></textarea>
				      	</div>
				   	</div>
				   	<div class="form-group">
				   		<div class="col-sm-2">
				   		</div>
				   		<div class="col-sm-10">
					   		<button type="button" class="btn btn-default" id="winReset" onclick="bsFormValid.reset()">重置
				            </button>
				            <button type="button" class="btn btn-default" id="winClose">关闭
				            </button>
				            <button type="submit" class="btn btn-primary" id="winSave">
				               	保存
				            </button>
			            </div>
				   	</div>
				</form><!-- /.form-horizontal -->
          	</div>
          	<div class="col-xs-3">
          	</div>
      	</div>
      	<hr>
    </div><!-- /.container-fluid -->
    
    <div class="container-fluid" id="tableDiv">
      	<div class="row">
        	<!-- 表格 -->
          	<div class="col-xs-12">
          		<table id="bsTable"></table>
          	</div>
      	</div>
    </div>
    
    <!-- 发布按钮 -->
	<div id="toolbar" class="btn-group">
		<button type="button" class="btn btn-link" onclick="backConfig();">
	        <a href="${ctx}/product/productConfig"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> 返回</a>
	    </button>
	    <button type="button" class="btn btn-primary" id="addBut" onclick="bsWin.open()">
	        <i class="glyphicon glyphicon-plus"></i> 版本发布
	    </button>
	</div>

	
	<!-- jQuery (在其它JS之前引用) -->
    <script src="components/jquery/1.9.1/jquery.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
    
    <!-- Bootstrap table -->
    <script src="components/bootstrap-table/bootstrap-table.js"></script>
	<script src="components/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
	
	<!-- Bootstrap validator -->
    <script src="components/bootstrap-validator/js/bootstrapValidator.min.js"></script>
    <script src="components/bootstrap-validator/js/language/zh_CN.js"></script>
    
    <!-- Bootstrap Core -->
    <script src="components/bootstrap-switch/js/bootstrap-switch.min.js"></script>
	
	<!-- Bootstrap 自定义插件 -->
    <script src="components/bootstrap-plugin/confirm.js"></script>
    <script src="components/bootstrap-plugin/message.js"></script>
    
    <!-- Bootstrap table 公用方法 -->
	<script src="components/bootstrap-table/common/bsTableDefault.js"></script>
	<script src="components/bootstrap-table/common/bsTableFormatter.js"></script>
	
	<!-- kindeditor 富文本编辑器 -->
	<script charset="utf-8" src="components/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="components/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="components/kindeditor-4.1.10/plugins/code/prettify.js"></script>

	
	<script src="../js/app/productVersion/productVersion.js"></script>
	
	<script type="text/javascript">
	
	<% 
		UserRole userRole = (UserRole)session.getAttribute("userRole");
		int productId = 0;
		if(request.getAttribute("product_id") != null && String.valueOf(request.getAttribute("product_id")).length() > 0){
			productId = Integer.valueOf(String.valueOf(request.getAttribute("product_id")));
		}
	%>
	
	// 全局变量
	var descEditor,
		userId = '<%=userRole.get("user_id")%>',
		roleId = '<%=userRole.get("role_id")%>',
		productId = <%=productId%>;
		
	// 产品ID赋值
	$('#product_id').val(productId);
	
	 // 富文本编辑器初始化
	 KindEditor.ready(function(K) {
		 descEditor = K.create('textarea[name="productVersion.desc"]', {
			resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : true,
			uploadJson : '${ctx}/upload',
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
		});
		prettyPrint();
	});
	 
	 // 返回产品发布页面
	 function backConfig(){
		 window.location = "${ctx}/product/productConfig";
	 }
	</script>
</body>
</html>