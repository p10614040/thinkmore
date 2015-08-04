/** 
 * @Title: confirm.js
 * @Package src/main/webapp/components/bootstrap-plugin
 * @author yan.liang
 * @date 2015年6月8日
 * @Description: confirm插件
 */
/*
 * 基于bootstarp的确认窗口
 */
bootstrapConfirm = (function (){
	
	var $confirm,
		callbackFn;
	
	function init(){
		var confirmHtml = 
			"<div class=\"modal fade\" id=\"confirmModal\" tabindex=\"-1\" role=\"dialog\"\n" +
			"     aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">\n" + 
			"    <div class=\"modal-dialog\">\n" + 
			"      <div class=\"modal-content\">\n" + 
			"             <!-- 窗口内容 -->\n" + 
			"             <div id=\"confirmMessage\" class=\"modal-body\">\n" + 
			"          			是否基础操作\n" + 
			"             </div>\n" + 
			"             <div class=\"modal-footer\">\n" + 
			"                <button type=\"button\" class=\"btn btn-default\" id=\"bsConfirmCanel\"\n" + 
			"                   data-dismiss=\"modal\">取消\n" + 
			"                </button>\n" + 
			"                <button type=\"button\" class=\"btn btn-danger\" id=\"bsConfirmYes\">\n" + 
			"                     确认\n" + 
			"                </button>\n" + 
			"             </div>\n" + 
			"          </div><!-- /.modal-content -->\n" + 
			"    </div><!-- /.modal -->\n" + 
			"  </div>";
		$('body').append(confirmHtml);
		$confirm = $('#confirmModal');
	}
	
	function confirm(message, fn){
		if(!$confirm){
			init();									// 初始化
		}
		$('#confirmMessage').html(message);			// 提示信息
		$($confirm).modal('show');
		$('#bsConfirmYes').off();		// 清除所有事件
		if(fn && typeof fn === 'function'){
			$('#bsConfirmYes').on('click', fn);
		}else {
			$('#bsConfirmYes').on('click', function (){
				alert('回调函数未定义');
			});
		}
	}
	
	// 关闭提示框
	function close(){
		$($confirm).modal('hide');
	}
	
	return {
		confirm: confirm,
		close: close
	}
})();