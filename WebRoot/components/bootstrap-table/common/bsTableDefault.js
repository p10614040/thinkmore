/** 
 * @Title: bsTableDefault.js
 * @Package javascript/common/bsTable
 * @author yan.liang
 * @date 2015年6月5日
 * @Description: 设置基于Bootstrap表格的默认属性
 */

bsTableDefault = (function($){
	
	/*
	 * 配置表的相关属性
	 */
	function config(){
		// 自定义工具栏
		$('body').append();
		
		$.fn.bootstrapTable.defaults.showRefresh = true;		// 显示刷新按钮
		$.fn.bootstrapTable.defaults.method = 'post';			// 使用post提交
		$.fn.bootstrapTable.defaults.search = true;				// 显示查询文本框
		$.fn.bootstrapTable.defaults.showColumns = true;		// 显示列控制按钮
		$.fn.bootstrapTable.defaults.showToggle = true;			// 显示card view按钮
		$.fn.bootstrapTable.defaults.pagination = true;			// 分页
		$.fn.bootstrapTable.defaults.sidePagination = "server";	// 从服务端获取分页数据	
		$.fn.bootstrapTable.defaults.pageSize = 20;				// 默认每页行数20
		$.fn.bootstrapTable.defaults.pageList = [20, 50, 100];		// 可选分页行数
		$.fn.bootstrapTable.defaults.contentType = 'application/x-www-form-urlencoded';		// 表单编码
		
		return true;
	}
	
	return {
		config: config
	}
	
})(jQuery);


/*
 * 通过统一接口，使用命令调用初始化方法
 */
bsTableDefault.execute = function(fnName) {
	if(fnName === undefined){
		alert("初始化命令不能为空！");
		return;
	}
	if(!bsTableDefault[fnName]){
		alert("不存在的初始化命令【" + fnName + "】");
		return;
	}
	return bsTableDefault[fnName]
			&& bsTableDefault[fnName].apply(bsTableDefault, [].slice.call(
					arguments, 1));
}