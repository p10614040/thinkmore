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
    
	<title>产品发布</title>
    
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
    
    <link href="css/productConfig.css" rel="stylesheet" >
    
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp" %>
	
    
    <!-- 表单 -->
	<div class="container-fluid" id="formDiv">
      	<div class="row">
          	<div class="col-xs-9">
          		<div class="col-xs-2"></div>
          		<div class="col-xs-10"><h3>产品发布</h3></div>
      			
          		<form class="form-horizontal" id="bsFrom" role="form" action="javascript:bsForm.add()">
          			<input type="hidden" name="product.product_id" id="product_id" value="">
				   	<div class="form-group">
				      	<label for="name" class="col-sm-2 control-label">产品名称 <sup>*</sup></label>
				      	<div class="col-sm-10">
				         	<input type="text" class="form-control" id="name" 
				         		placeholder="" name="product.name">
				      	</div>
				   	</div>
				   	<div class="form-group">
				   		<label for="type" class="col-sm-2 control-label">产品分类 <sup>*</sup></label>
				      	<div class="col-sm-10">
				         	<select class="form-control" name="product.type" id="type">
							</select>
				      	</div>
				   	</div>
				   	<div class="form-group">
				      	<fieldset disabled class="" id="subtypeFieldset">
				      	<label for="subtype" class="col-sm-2 control-label">产品子类</label>
				      	<div class="col-sm-10">
							<select class="form-control" name="product.subtype" id="subtype">
							</select>
						</div>
						</fieldset>
				   	</div>
				   	<div class="form-group">
				      	<label for="dept" class="col-sm-2 control-label">所属部门 <sup>*</sup></label>
				      	<div class="col-sm-10">
						 	<select class="form-control" name="product.dept" id="dept">
						         <option value="">请选择...</option>
						         <option value="网管事业部">网管事业部</option>
						         <option value="资源事业部">资源事业部</option>
						         <option value="合肥开发中心">合肥开发中心</option>
						         <option value="研发中心">研发中心</option>
						         <option value="ICT事业部">ICT事业部</option>
							</select>
				      	</div>
				   	</div>
				   	<div class="form-group">
				      	<label for="tag_name" class="col-sm-2 control-label">产品标签</label>
				      	<div class="col-sm-10">
				         	<input type="text" class="form-control" id="tag_name" 
				         		placeholder="以逗号分割" name="productTag.tag_name">
				      	</div>
				   	</div>
				   	<div class="form-group">
				      	<label for="desc" class="col-sm-2 control-label">描述</label>
				      	<div class="col-sm-10" id="editDiv">
				      		<textarea class="editArea" id="desc" name="product.desc" cols="100" rows="8" 
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
	    <button type="button" class="btn btn-primary" id="addBut" onclick="bsWin.open()">
	        <i class="glyphicon glyphicon-plus"></i> 产品发布
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
    
    <!-- Bootstrap bootstrap-switch -->
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

	
	<script src="../js/app/productConfig/productConfig.js"></script>
	
	<script type="text/javascript">
	
	<% 
		UserRole userRole = (UserRole)session.getAttribute("userRole");
	%>
	
	// 全局变量
	var ctxUrl = '${ctx}',
		descEditor,
		userId = '1001',
		roleId = 'admin';
	
	 // 富文本编辑器初始化
	 KindEditor.ready(function(K) {
		 descEditor = K.create('textarea[name="product.desc"]', {
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
	</script>
</body>
</html>