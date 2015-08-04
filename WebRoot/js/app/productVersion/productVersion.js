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
		$.fn.bootstrapTable.defaults.formatSearch = function (){return '版本号'};	// 默认搜索文字
		table = $table;
		var colunms = columnInit();
		$table.bootstrapTable({
			toolbar: '#toolbar',
			url: '/version/versionQuery',
			pageSize: 10,
			showColumns: false,
			showToggle: false,
			queryParams: function(params){
				return {
					start: params.offset,
					limit: params.limit,
					keyword: params.search,
					productId: productId
				}
			},
			columns: colunms
		});
	}
	
	function columnInit(){
		var columns = [{
	        field: 'index',
	        formatter: bsTableFormatter.indexFormatter
	    }, {
	        title: '版本号',
	        field: 'ver_code'
	    }, {
	        title: '文档地址',
	        field: 'document'
	    }, {
	        title: '下载地址',
	        field: 'download',
	    }, {
	        title: '创建时间',
	        field: 'cTime'
	    }, {
	        title: '修改时间',
	        field: 'mTime'
	    }, {
	        field: 'ver_id',
	        width: '100px',
	        formatter: tableFormatter.editFormatter
	    }]
		return columns;
	}
	
	var tableFormatter = {
		// 增删改操作
		editFormatter: function (value, row, index) {
			var editTabel = "<div id=\"tableToolBar\" class=\"btn-group\">\n" +
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
 * 版本编辑表单
 */
 bsForm = (function (){
	 
	 // 表单初始化
	 function init(){
		
	 }
	 
	 /*
	  * 版本保存
	  */
	 function versionAdd(){
		 $.ajax({
			 type: 'POST',
			 url: '/version/versionSave' ,
			 data: $('#bsFrom').serialize(),
			 success: function (data){
				 bsTableGrid.reload();
				 bsWin.close();
				 bsFormValid.reset();
			 }
		 });
		 
	 }
	 
	 // 版本编辑
	 function versionUpdate(record){
		 var ver_Id = record.ver_Id;
		 loadData(record);
		 $("body,html").animate({scrollTop:$("#formDiv").offset().top - 50});
	 }
	 
	 // 表单赋值
	 function loadData(dataObj){
		 bsFormValid.reset();	// 赋值前先清空
		 $('#ver_Id').val(dataObj.ver_Id);
		 $('#ver_code').val(dataObj.ver_code);
		 $('#document').val(dataObj.document);
		 $('#download').val(dataObj.download);
		 descEditor.html(dataObj.desc);
	 }
	 
	 // 版本删除
	 function versionDel(index){
		bootstrapConfirm.confirm('是否确认删除？', function (){
			if(!bsTableGrid.getRecord(index).ver_Id)
				return
			$.ajax({
				 type: 'POST',
				 url: '/version/versionDelete' ,
				 data: {
					 'productVersion.ver_Id': bsTableGrid.getRecord(index).ver_Id
				 },
				 success: function (data){
					 bsTableGrid.reload();
					 bootstrapConfirm.close();
					 // bootstrapMessage.show('删除成功！', 'success');
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
		 add: versionAdd,
		 update: versionUpdate,
		 del: versionDel
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
				 'productVersion.ver_code': {
					 validators: {
						 notEmpty: {
							 message: '版本号不能为空'
						 },
						 stringLength: {
							 max: 100,
							 message: '版本号最长100个字符'
						 }
					 }
				 },
				 'productVersion.document': {
					 validators: {
						 notEmpty: {
							 message: '文档地址不能为空'
						 }
					 }
				 },
				 'productVersion.download': {
					 validators: {
						 notEmpty: {
							 message: '下载地址不能为空'
						 }
					 }
				 },
				 'productVersion.desc': {
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
		 $('#ver_Id').val('');		// 清除ID
	 }
	 
	 return {
		 init: init,
		 valid: valid,
		 reset: reset
	 }
 })();