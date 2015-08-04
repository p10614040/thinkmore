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
	$('#winSave').on('click', function (){
		// bsForm.add();
	});
	
	$('#winClose').on('click', function (){
		bsWin.close();
	});
});

/*
 * 表格
 */
bsTableGrid = (function (){
	
	var table;
	
	function init($table){
		bsTableDefault.execute("config");	// 引入模式属性
		table = $table;
		var colunms = columnInit();
		$table.bootstrapTable({
			toolbar: '#toolbar',
			url: ctxUrl+'/product/productTableCollect',
			pageSize: 10,
			showColumns: false,
			showToggle: false,
			showRefresh:false,
			search:false,
			queryParams: function(params){
				return {
					start: params.offset,
					limit: params.limit,
					keyword: params.search,
					productType: productType,
					subProductType: subProductType
				}
			},
			columns: colunms,
			onLoadSuccess: function(){
				$table.bootstrapTable('hideColumn','name');
				$table.bootstrapTable('hideColumn','mTime');
				$table.bootstrapTable('hideColumn','product_id');
			}
		});
	}
	
	function columnInit(){
		var columns = [{
	    	field: 'desc',
	        formatter: tableFormatter.vercodeFormatter
	    }, {
	    	field: 'name'
	    }, {
	    	field: 'mTime'
	    }, {
	    	field: 'product_id'
	    }]
		return columns;
	}
	
	var tableFormatter = {
		// 表格内容
		vercodeFormatter: function (value, row, index){
			return"<ul class='List'>\n" +
			"            <li class='recomm'>\n" + 
			"              <h3>\n" + 
			"				<a href=\"product/productDetail/"+row.product_id+"\" target=\"_blank\">"+row.name+"</a>\n" + 
			"              </h3>\n" + 
			"              <table width='100%'>\n" + 
			"                <tr>\n" + 
			"                  <td>\n" + 
			"                    <p class='detail'>\n" +row.desc+"\n" + 
			"                    </p>\n" + 
			"                  </td>\n" + 
			"                </tr>\n" + 
			"              </table>\n" + 
			"\n" + 
			"              <p class='news'>\n" + 
			"                <strong style='color:#666;'>最近更新：</strong><span>" +row.mTime+"</span>\n" + 
			"              </p>\n" + 
			"            </li>" +
			"  </ul>";
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
