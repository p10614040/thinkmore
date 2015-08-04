/** 
 * @Title: detail.js
 * @Package js/app
 * @author yan.liang
 * @date 2015年6月13日
 * @Description: 表单详情
 */

$(function (){
	// 初始化收藏按钮
	$.ajax({
		 type: 'POST',
		 url: ctxUrl+'/productCollect/followQuery/' + productId ,
		 success: function (data){
			 if(data){
				 console.log(data);
				 // 标注已收藏
				 if(data.userCollect.length === 1){
					 $(".star button").removeClass('btn-default');
					 $(".star button").addClass('btn-success');
					 $(".star span:first").removeClass('glyphicon-star-empty');
					 $(".star span:first").addClass('glyphicon-star');
					 $(".star span:eq(1)").html('已收藏');
				 }
				 
				 // 显示收藏总数
				 if(data.totalList){
					 $(".star .badge").html(data.totalList.total);
				 }
			 }
		 },
		 error: function(){
		 }
	 });
});

/*
 * 收藏
 */
function collect(obj){
	if($(obj).hasClass('btn-success')){		// 取消收藏
		$.ajax({
			 type: 'POST',
			 url: ctxUrl+'/productCollect/unfollow/' + productId ,
			 success: function (data){
				 $(obj).removeClass('btn-success');
				 $(obj).addClass('btn-default');
				 $(".star span:first").removeClass('glyphicon-star');
				 $(".star span:first").addClass('glyphicon-star-empty');
				 $(".star span:last").html(parseInt($(".star span:last").html()) - 1);
				 $(".star span:eq(1)").html('收藏');
			 },
			 error: function(){
			 }
		 });
	}else {		// 收藏
		$.ajax({
			 type: 'POST',
			 url: ctxUrl+'/productCollect/follow/' + productId ,
			 success: function (data){
				 $(obj).removeClass('btn-default');
				 $(obj).addClass('btn-success');
				 $(".star span:first").removeClass('glyphicon-star-empty');
				 $(".star span:first").addClass('glyphicon-star');
				 $(".star span:last").html(parseInt($(".star span:last").html()) + 1);
				 $(".star span:eq(1)").html('已收藏');
			 },
			 error: function(){
			 }
		 });
	}
}