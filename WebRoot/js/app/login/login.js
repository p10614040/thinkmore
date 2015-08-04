/** 
 * @Title: login.js
 * @Package js/app/login
 * @author yan.liang
 * @date 2015年6月12日
 * @Description: 登录
 */
$(function (){
	$('#loginForm').on('submit', function (){
		return valit();
	});
});

/*
 * 表单校验
 */
function valit(){
	var message = '', status = true;
	var userId = $('#inputUserId').val();
	var password = $('#inputPassword').val();
	if(!userId){
		message = '用户名不能为空';
		status = false;
	}else if(!password){
		message = '密码不能为空';
		status = false;
	}
	$('#message').html(message);
	return status;
}