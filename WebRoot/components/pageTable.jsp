<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    
	<title>Bootstrap Table</title>
    
	<!-- Bootstrap -->
    <link href="../components/bootstrap-3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="../components/bootstrap-3.3.4/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="../components/bootstrap-3.3.4/template/dashboard/dashboard.css" rel="stylesheet">
    
    <!-- Bootstrap-Table -->
    <link href="../components/bootstrap-table/bootstrap-table.css" rel="stylesheet" >
    
    <!-- Bootstrap validator -->
    <link href="../components/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet" >
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="../components/bootstrap-3.3.4/libs/html5shiv.min.js"></script>
      <script src="../components/bootstrap-3.3.4/libs/respond.min.js"></script>
    <![endif]-->
    
</head>
<body>

	<!-- 页面导航栏 -->
	<%@ include file="navbar.jsp" %>
    
    <div class="container-fluid">
      	<div class="row">
        	<!-- 表格 -->
          	<div class="col-xs-12">
          		<table id="bsTable"></table>
          	</div>
      	</div>
    </div>
    
    <!-- 表单窗口 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
	   aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
	            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
	                  &times;
					</button>
					<!-- 窗口标题 -->
	            	<h4 class="modal-title" id="myModalLabel"> 新增 </h4>
	         	</div>
	         	<!-- 窗口内容 -->
		         <div class="modal-body">
					<form class="form-horizontal" id="bsFrom" role="form"
						action="javascript:void(0);">
					   	<div class="form-group">
					      	<label for="name" class="col-sm-2 control-label">产品名称 <sup>*</sup></label>
					      	<div class="col-sm-10">
					         	<input type="text" class="form-control" id="name" 
					         		placeholder="请输入进程名称（必填项）" name="name">
					      	</div>
					   	</div>
					   	<div class="form-group">
					      	<label for="type" class="col-sm-2 control-label">产品类型 <sup>*</sup></label>
					      	<div class="col-sm-10">
								<select class="form-control" name="type" id="type">
							         <option>1</option>
							         <option>2</option>
							         <option>3</option>
							         <option>4</option>
							         <option>5</option>
								</select>
							</div>
					   	</div>
					   	<div class="form-group">
					      	<label for="version" class="col-sm-2 control-label">版本 <sup>*</sup></label>
					      	<div class="col-sm-10">
							 	<input type="text" class="form-control" id="version" 
					            	placeholder="" name="version">
					      	</div>
					   	</div>
					   	<div class="form-group">
					      	<label for="updateTime" class="col-sm-2 control-label">修改时间</label>
					      	<div class="col-sm-10">
					         	<input type="text" class="form-control" id="updateTime" 
					            	placeholder="" name="updateTime">
					      	</div>
					   	</div>
					   	<div class="form-group">
					      	<label for="pro_log_des" class="col-sm-2 control-label">描述</label>
					      	<div class="col-sm-10">
							 	<textarea class="form-control" rows="2" id="pro_log_des"
					             	placeholder="" name="pro_log_des"></textarea>
					      	</div>
					   	</div>
					</form>
		         </div>
		         <div class="modal-footer">
		         	<button type="button" class="btn btn-default" id="winReset"
		               onclick="bsFormValid.reset()">重置
		            </button>
		            <button type="button" class="btn btn-default" id="winClose"
		               data-dismiss="modal">关闭
		            </button>
		            <button type="button" class="btn btn-primary" id="winSave">
		               	保存
		            </button>
		         </div>
		      </div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>

	
	<!-- jQuery (在其它JS之前引用) -->
    <script src="../components/jquery/1.9.1/jquery.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="../components/bootstrap-3.3.4/js/bootstrap.min.js"></script>
    
    <!-- Bootstrap table -->
    <script src="../components/bootstrap-table/bootstrap-table.js"></script>
	<script src="../components/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
	
	<!-- Bootstrap validator -->
    <script src="../components/bootstrap-validator/js/bootstrapValidator.min.js"></script>
    <script src="../components/bootstrap-validator/js/language/zh_CN.js"></script>
	
	<!-- Bootstrap 自定义插件 -->
    <script src="../components/bootstrap-plugin/confirm.js"></script>
    <script src="../components/bootstrap-plugin/message.js"></script>
    
    <!-- Bootstrap table 公用方法 -->
	<script src="../components/bootstrap-table/common/bsTableDefault.js"></script>
	<script src="../components/bootstrap-table/common/bsTableFormatter.js"></script>

	
	<script src="../js/app/pageTable/pageTable.js"></script>
</body>
</html>