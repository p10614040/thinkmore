/** 
 * @Title: bsTableFormatt.js
 * @Package javascript/resManager/common
 * @author yan.liang
 * @date 2015年6月8日
 * @Description: bs表格的统一渲染对象
 */

/*
 * 统一渲染对象
 */
bsTableFormatter = (function (){
	
	
	// 序号
	function indexFormatter(value, row, index) {
	    return ++index;
	}
	
	return {
		indexFormatter: indexFormatter
	}
})();