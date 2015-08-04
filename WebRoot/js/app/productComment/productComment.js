/** 
 * @Title: productConfig.js
 * @Package js/app/productConfig
 * @author yan.liang
 * @date 2015年6月12日
 * @Description: 产品配置
 */
$(function (){
	// 表格初始化
	bsTableGrid.init($('#bsTable'));
	// 增加表达验证
   bsFormValid.init($('#bsFrom'));
	
	$('#winSave').on('click', function (){
		// bsForm.add();
	});
	
	$('#winClose').on('click', function (){
		bsWin.close();
	});
	
	// 表单初始化
	bsForm.init();
	
});

/*
 * 表格
 */
bsTableGrid = (function (){
	
	var table;
	
	
	function init($table){
		bsTableDefault.execute("config");	// 引入模式属性
		table = $table;
		$table.bootstrapTable({
			//toolbar: '#toolbar',
			url: '/version/listComment',
			pageSize: 10,
			showRefresh: false,
			search: false,
			showColumns: false,
			showToggle: false,
			queryParams: function(params){
				return {
					start: params.offset,
					limit: params.limit,
					ver_id: ver_id
				}
			},
			columns: [{
		        field: 'pc_id',
		        //width: '100px',
		        formatter: tableFormatter.editFormatter
		    }]
		});
	}
	
	var tableFormatter = {
		// 增删改操作
		editFormatter: function (value, row, index) {
			var editTabel ="<p>" +
					           "<table class='table' >" +
					             "<tr><th width='20%' align='left'><div class='comUserName'>"+row.user_id+"</div>" +
					           		"</th>" +
					             "</tr>"+
							     "<tr>	 " +
							       "<td ><div class='comText'>"+row.content+"</div><br />" +
							  		"<div style='float: right; padding: 5px; margin-top: 10px;'>"+ row.create_time+"" +
							  		 "</div>" +
							  	 "</td>" +
							  	"</tr>" +
							  "</table>" +
						"</p>";
			return editTabel;
		}
	}
	
	// 表格刷新
	function reload(){
		table.bootstrapTable('refresh');
	}
	
	// 根据索引获取行数据
	function getRecord(index){
		return table.bootstrapTable('getData')[index];
	}
	
	return {
		init: init,
		reload: reload,
		getRecord: getRecord
	}
})();

/*
 * 产品编辑窗口
 */
 bsWin = (function (){
	 
	 // 打开窗口
	 function open(type, rowIndex){
		 $('#formDiv').slideDown();
		 if(type === 'update'){		// 编辑
			 bsForm.update(bsTableGrid.getRecord(rowIndex));
		 }
	 }
	 
	 // 关闭窗口
	 function close(record){
		 $('#formDiv').slideUp();
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
	 
	 // 表单初始化
	 function init(){
		 queryType(0, $('#type'), 2);
		 
		 // 选择分类后加载子分类
		 $('#type').on('change', function (){
			 typeSelectInit($(this));
		 });
		
	 }
	 
	 // 产品分类初始化
	 function typeInit($type, defaultVal){
		 queryType($type.val(), $('#subtype'), defaultVal);
		 $('#subtypeFieldset').removeAttr('disabled');
	 }
	 
	 // 根据父类型查询产品分类
	 function queryType(parentType, selectObj, defaultVal){
		 $.ajax({
			 type: 'POST',
		     url: '/product/categoryQuery' ,
		     data: {
		    	 parentType: parentType
		     },
		     success: function (data){
		    	 $(selectObj).html('<option value="">请选择...</option>');
		    	 if(data === undefined || data.length === 0){
		    		 $(selectObj).parent().parent().attr('disabled', 'true');
		    	 }
		    	 for(var index = 0; index < data.length; index++){
		    		 $(selectObj).append('<option value="'+data[index].category_id+'">'+data[index].category_name+'</option>');
		    	 }
		    	 if(defaultVal){
		    		 $(selectObj).val(defaultVal);
		    	 }
		     },
		     dataType: 'json'
		 });
	 }
	 
	 /*
	  * 产品保存
	  */
	 function productAdd(){
		 $.ajax({
			 type: 'POST',
			 url: '/product/productSave' ,
			 data: $('#bsFrom').serialize(),
			 success: function (data){
				 bsTableGrid.reload();
				 bsWin.close();
				 bsFormValid.reset();
			 }
		 });
		 
	 }
	 
	 // 产品编辑
	 function productUpdate(record){
		 var product_id = record.product_id;
		 loadData(record);
		 $("body,html").animate({scrollTop:$("#formDiv").offset().top});
	 }
	 
	 // 表单赋值
	 function loadData(dataObj){
		 bsFormValid.reset();	// 赋值前先清空
		 $('#name').val(dataObj.name);
		 if(dataObj.type){
			 $('#type').val(dataObj.type);
			 typeInit($('#type'), dataObj.subtype);
		 }
		 $('#dept').val(dataObj.dept);
		 descEditor.html(dataObj.desc);
		 $('#product_id').val(dataObj.product_id);
	 }
	 
	 // 产品删除
	 function productDelete(index){
		bootstrapConfirm.confirm('是否确认删除？', function (){
			if(!bsTableGrid.getRecord(index).product_id)
				return
			$.ajax({
				 type: 'POST',
				 url: '/product/productDelete' ,
				 data: {
					 'product.product_id': bsTableGrid.getRecord(index).product_id
				 },
				 success: function (data){
					 bsTableGrid.reload();
					 bootstrapConfirm.close();
					 bootstrapMessage.show('删除成功！', 'success');
				 },
				 error: function (data){
					 bsTableGrid.reload();
					 bootstrapConfirm.close();
					 bootstrapMessage.show('删除失败！', 'danger');
				 }
			 });
			
		});
	 }
	 
	 return {
		 init: init,
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
				 'product.name': {
					 validators: {
						 notEmpty: {
							 message: '产品名称不能为空'
						 },
						 stringLength: {
							 max: 100,
							 message: '产品名称最长100个字符'
						 }
					 }
				 },
				 'product.type': {
					 validators: {
						 notEmpty: {
							 message: '产品分类不能为空'
						 }
					 }
				 },
				 'product.subtype': {
					 
				 },
				 'product.dept': {
					 validators: {
						 notEmpty: {
							 message: '部门不能为空'
						 }
					 }
				 },
				 'product.desc': {
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
		 descEditor.html('');	// 清空富文本
	 }
	 
	 return {
		 init: init,
		 valid: valid,
		 reset: reset
	 }
 })();