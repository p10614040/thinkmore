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
		$.fn.bootstrapTable.defaults.formatSearch = function (){return '产品名称'};
		table = $table;
		var colunms = columnInit();
		$table.bootstrapTable({
			toolbar: '#toolbar',
			url: ctxUrl+'/product/productQuery',
			pageSize: 10,
			showColumns: false,
			showToggle: false,
			queryParams: function(params){
				return {
					start: params.offset,
					limit: params.limit,
					keyword: params.search
				}
			},
			columns: colunms,
		    onLoadSuccess : function (){
		    	
		    	// 隐藏标签列
		    	table.bootstrapTable('hideColumn', 'tag_names');
		    	
		    	// 初始化审核按钮
		    	var tableRecords = table.bootstrapTable('getData');
		    	for(var i = 0; i < tableRecords.length; i++){
		    		var butId = 'checkBut_' + tableRecords[i].product_id,
						defaultState = false;
					if(tableRecords[i].check_status == 1){
						defaultState = true;
					}
					createSwitchBut(butId, defaultState, tableRecords[i].product_id);
		    	}
		    }
		});
	}
	
	function columnInit(){
		var columns = [{
	        field: 'index',
	        formatter: bsTableFormatter.indexFormatter
	    }, {
	    	title: '版本号',
	    	field: 'ver_code',
	        formatter: tableFormatter.vercodeFormatter
	    }, {
	        title: '产品名称',
	        field: 'name',
	        formatter: tableFormatter.nameFormatter
	    }, {
	        title: '产品分类',
	        field: 'type_name'
	    }, {
	        title: '产品子类',
	        field: 'subtype_name',
	    }, {
	        title: '所属部门',
	        field: 'dept'
	    }, {
	        title: '创建时间',
	        field: 'cTime'
	    }, {
	        title: '修改时间',
	        field: 'mTime'
	    }, {
	        title: '发布用户',
	        field: 'userid'
	    }, {
	    	title: '标签',
	        field: 'tag_names'
	    }, {
	        field: 'product_id',
	        width: '90px',
	        formatter: tableFormatter.editFormatter
	    }]
		if(roleId === 'admin'){		// 只有管理员有审核权限
			columns.push({
		        title: '审核状态',
		        field: 'check_status',
		        width: '90px',
		        formatter: tableFormatter.checkStatusFormatter
		    });
		}
		return columns;
	}
	
	var tableFormatter = {
		// 增删改操作
		editFormatter: function (value, row, index) {
			var editTabel = "<div id=\"\" class=\"btn-group\">\n" +
			"      <button type=\"button\" class=\"btn btn-sm btn-default\" onclick=\"bsWin.open('update', "+index+")\">\n" + 
			"          <i class=\"glyphicon glyphicon-pencil\"></i>\n" + 
			"      </button>\n" + 
			"      <button type=\"button\" class=\"btn btn-sm btn-default\" onclick=\"bsForm.del("+index+")\">\n" + 
			"          <i class=\"glyphicon glyphicon-trash\"></i>\n" + 
			"      </button>\n" + 
			"  </div>";
			return editTabel;
		},
		// 审核按钮
		checkStatusFormatter: function (val, row, index){
			var butId = 'checkBut_' + row.product_id;
			var switchBut = "<input id=\""+butId+"\" type=\"checkbox\" name=\"my-checkbox\"  data-size=\"small\">";
			return switchBut;
		},
		// 版本号
		vercodeFormatter: function (val, row, index){
			return "<a href=\""+ctxUrl+"/product/productVersion?productId="+row.product_id+"\">"+(val || '发布')+"</a>";
		},
		// 产品名称
		nameFormatter: function (val, row, index){
			return "<a target=\"_blank\" href=\""+ctxUrl+"/product/productDetail/"+row.product_id+"\">"+(val || '-')+"</a>";
		}
	}
	
	// 菜单导航按钮
	function createSwitchBut(butId, defaultState, product_id){
		var $switchObj = $('#'+butId);
		$switchObj.bootstrapSwitch({
	    	onText: 'YES',
	    	offText: 'NO',
	    	state: defaultState,
	    	onSwitchChange : function (event, state){
	    		if(state){
	    			upadteCheck($switchObj, product_id, 1);
	    		}else {
	    			upadteCheck($switchObj, product_id, 0);
	    		}
	    	}
	    });
	}
	
	// 更新审核状态
	function upadteCheck($switchObj, id, state){
		$.ajax({
			 type: 'POST',
			 url: ctxUrl+'/product/productSave' ,
			 data: {
				 'product.product_id': id,
				 'product.check_status': state
			 },
			 success: function (data){
			 },
			 error: function(){
			 }
		 });
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
		 queryType(0, $('#type'));
		 
		 // 选择分类后加载子分类
		 $('#type').on('change', function (){
			 typeInit($(this));
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
		     url: ctxUrl+'/product/categoryQuery' ,
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
			 url: ctxUrl+'/product/productSave' ,
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
		 $("body,html").animate({scrollTop:$("#formDiv").offset().top - 50});
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
		 $('#tag_name').val(dataObj.tag_names);
	 }
	 
	 // 产品删除
	 function productDelete(index){
		bootstrapConfirm.confirm('是否确认删除？', function (){
			if(!bsTableGrid.getRecord(index).product_id)
				return
			$.ajax({
				 type: 'POST',
				 url: ctxUrl+'/product/productDelete' ,
				 data: {
					 'product.product_id': bsTableGrid.getRecord(index).product_id
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
				 'productTag.tag_name': {
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
		 $('#product_id').val('');		// 清除ID
	 }
	 
	 return {
		 init: init,
		 valid: valid,
		 reset: reset
	 }
 })();