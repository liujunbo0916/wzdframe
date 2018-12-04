/**
 * Created by zhangleyu on 2017/8/29.
 */
$(function() {
	var navList = [ 0, 1, 2, 3, 4 ];
	changeNav = function(data) {
		for (var i = 0; i < navList.length; i++) {
			if (data === navList[i]) {
				$('.home-' + navList[i]).addClass('active');
			} else {
				$('.home-' + navList[i]).removeClass('active');
			}
		}
	}
});
