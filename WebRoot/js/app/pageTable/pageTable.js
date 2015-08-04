/** 
 * @Title: bootstrapTableDemo.js
 * @Package javascript/app/bootstrapTableDemo
 * @author yan.liang
 * @date 2015年6月8日
 * @Description: Bootstrap表格demo
 */

$(function (){
	// 表格初始化
	bsTableGrid.init($('#bsTable'));
	// 增加表达验证
	bsFormValid.init($('#bsFrom'));
	
	$('#winSave').on('click', function (){
		bsFormValid.valid();
	});
	
});

/*
 * 表格
 */
bsTableGrid = (function (){
	
	var table;
	
	function init($table){
		bsTableDefault.execute("config");	// 引入模式属性
		
		table = $table.bootstrapTable({
			url: "data.json",
			columns: [{
		        field: 'index',
		        formatter: bsTableFormatter.indexFormatter
		    }, {
		        title: '产品名称',
		        field: 'name'
		    }, {
		        title: '产品类型',
		        field: 'type'
		    }, {
		        title: '版本',
		        field: 'version'
		    }, {
		        title: '修改时间',
		        field: 'updateTime'
		    }, {
		        field: 'id',
		        width: '125px',
		        formatter: tableFormatter.editFormatter
		    }]
		});
	}
	
	var tableFormatter = {
		// 增删改操作
		editFormatter: function (value, row, index) {
			var editTabel = "<div id=\"tableToolBar\" class=\"btn-group\">\n" +
			"      <button type=\"button\" class=\"btn btn-sm btn-default\" onclick=\"bsWin.open()\">\n" + 
			"          <i class=\"glyphicon glyphicon-plus\"></i>\n" + 
			"      </button>\n" + 
			"      <button type=\"button\" class=\"btn btn-sm btn-default\" onclick=\"bsWin.open('update', "+index+")\">\n" + 
			"          <i class=\"glyphicon glyphicon-pencil\"></i>\n" + 
			"      </button>\n" + 
			"      <button type=\"button\" class=\"btn btn-sm btn-default\" onclick=\"bsForm.del("+index+")\">\n" + 
			"          <i class=\"glyphicon glyphicon-trash\"></i>\n" + 
			"      </button>\n" + 
			"  </div>";
			return editTabel;
		}
	}
	
	return {
		init: init
	}
})();

/*
 * 产品编辑窗口
 */
 bsWin = (function (){
	 
	 // 打开窗口
	 function open(type, rowIndex){
		 $('#myModal').modal('show')
		 bsFormValid.reset();	// 重置表单
		 if(type === 'update'){
			 $('#myModalLabel').html('修改');
		 }else{
			 $('#myModalLabel').html('新增');
		 }
	 }
	 
	 // 关闭窗口
	 function close(record){
		 $('#myModal').modal('hide');
	 }
	 
	 return {
		 open: open,
		 close: close
	 }
 })();

/*
 * 产品编辑表单
 */
 bsForm = (function (){
	 
	 function productAdd(){
		 $('#myModal').modal('show')
	 }
	 
	 function productUpdate(record){
		 
	 }
	 
	 function productDelete(record){
		bootstrapConfirm.confirm('是否确认删除？', function (){
			bootstrapConfirm.close();
			bootstrapMessage.show('删除成功！', 'success');
		});
	 }
	 
	 return {
		 add: productAdd,
		 update: productUpdate,
		 del: productDelete
	 }
 })();
 
 /*
  * 表单验证
  */
 bsFormValid = (function (){
	 
	 var $bsForm;
	 
	 // 表单验证初始化
	 function init($form){
		 if(!$form){
			 return;
		 }
		 $bsForm = $form;
		 $form.bootstrapValidator({
			 message: '无效',
			 feedbackIcons: {
				 valid: 'glyphicon glyphicon-ok',
				 invalid: 'glyphicon glyphicon-remove',
				 validating: 'glyphicon glyphicon-refresh'
			 },
			 fields: {
				 name: {
					 validators: {
						 notEmpty: {
							 message: '产品名称不能为空'
						 },
						 stringLength: {
							 max: 30,
							 message: '产品名称最长30个字符'
						 }
					 }
				 },
				 type: {
					 validators: {
						 notEmpty: {
							 message: '产品类型不能为空'
						 }
					 }
				 },
				 version: {
					 validators: {
						 notEmpty: {
							 message: '版本不能为空'
						 }
					 }
				 },
				 pro_log_des: {
					 validators: {
						 stringLength: {
							 max: 128,
							 message: '描述最长128个字符'
						 }
					 }
				 }
			 }
		 });
	 }
	 
	 // 验证表单
	 function valid(){
		 $bsForm.bootstrapValidator('validate');
	 }
	 
	 // 验证表单重置
	 function reset(){
		 $bsForm.data('bootstrapValidator').resetForm(true);
	 }
	 
	 return {
		 init: init,
		 valid: valid,
		 reset: reset
	 }
 })();