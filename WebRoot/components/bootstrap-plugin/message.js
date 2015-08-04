/** 
 * @Title: message.js
 * @Package src/main/webapp/components/bootstrap-plugin
 * @author yan.liang
 * @date 2015年6月8日
 * @Description: 基于bootstrap的消息提示插件
 */

bootstrapMessage = (function (){
	
	var $message,
		timeOut,	// 定时任务
		delayTime = 1500;	//显示时间
	
	// 初始化
	function init(){
		if(!$message){
			var messageHtml = 
				"<div class=\"alert alert-warning\" id=\"bsMessage\" style=\"position:absolute; z-index:9999; top:0;width: 100%;display:none;text-align:center;\">\n" +
				"       <a href=\"#\" class=\"close\" data-dismiss=\"alert\">\n" + 
				"          &times;\n" + 
				"       </a>\n" + 
				"       <span>您的网络连接有问题。</span>\n" + 
				"  </div>";
			$('body').append(messageHtml);
			$message = $('#bsMessage');
		}
	}
	
	// 显示提示信息
	function show(message, type){
		init();		// 初始化
		$($message).removeClass('alert-success alert-info alert-warning alert-danger');	// 清除样式
		$($message).find('span').html();	// 清除提示信息
		if(type === 'success'){
			$($message).addClass('alert-success');
		}else if(type === 'warning'){
			$($message).addClass('alert-warning');
		}else if(type === 'danger'){
			$($message).addClass('alert-danger');
		}else {
			$($message).addClass('alert-info');
		}
		$($message).find('span').html(message);
		$($message).slideDown();
		timeOutClose();	// 启动定时关闭
	}
	
	/*
	 * 关闭提示信息
	 */
	function hide(){
		$($message).slideUp();
	}
	
	
	// 定时关闭
	function timeOutClose(){
		if(timeOut){	// 如果已有定时任务先清除
			clearTimeout(timeOut);
		}
		timeOut = setTimeout("bootstrapMessage.hide();", delayTime);
	}
	
	return {
		show: show,
		hide: hide
	}
})();