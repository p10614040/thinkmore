/** 
 * @Title: confirm.js
 * @Package src/main/webapp/components/bootstrap-plugin
 * @author yan.liang
 * @date 2015年6月8日
 * @Description: 模态窗口插件
 */
/*
 * 基于bootstarp的模态窗口
 */
bootstrapModal = (function (){
	
	var $confirm,
		callbackFn;
	
	function init(){
		var confirmHtml = 
			"<div class=\"modal fade\" id=\"confirmModal\" tabindex=\"-1\" role=\"dialog\"\n" +
			"     aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">\n" + 
			"    <div class=\"modal-dialog\">\n" + 
			"      <div class=\"modal-content\">\n" + 
			"             <!-- 窗口标题 -->\n" + 
			"          <div class=\"modal-header\">\n" + 
			"          </div><!-- /.modal-header -->\n" + 
			"             <!-- 窗口内容 -->\n" + 
			"             <div id=\"confirmMessage\" class=\"modal-body\">\n" + 
			"          			是否基础操作\n" + 
			"             </div>\n" + 
			"             <div class=\"modal-footer\">\n" + 
			"                <button type=\"button\" class=\"btn btn-default\" id=\"bsConfirmCanel\"\n" + 
			"                   data-dismiss=\"modal\">确认\n" + 
			"                </button>\n" + 
			"             </div>\n" + 
			"          </div><!-- /.modal-content -->\n" + 
			"    </div><!-- /.modal -->\n" + 
			"  </div>";
		$('body').append(confirmHtml);
		$confirm = $('#confirmModal');
	}
	
	function show(title, message){
		if(!$confirm){
			init();									// 初始化
		}
		$('#confirmModal .modal-header').html(title);			// 标题
		$('#confirmMessage').html(message);			// 提示信息
		$($confirm).modal('show');
	}
	
	// 关闭提示框
	function hide(){
		$($confirm).modal('hide');
	}
	
	return {
		show: show,
		hide: close
	}
})();