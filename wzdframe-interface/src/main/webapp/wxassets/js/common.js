//获取屏幕字体尺寸
(function(doc, win) {
	var docEl = doc.documentElement, //拿到整个文档中的js对象
		resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize', //如果翻转事件在当前的窗口对象中存在
		recalc = function() {
			var clientWidth = docEl.clientWidth;
			if(!clientWidth) return;

			docEl.style.fontSize = 14 * (clientWidth / 320) + 'px';
		};

	if(!doc.addEventListener) return;
	win.addEventListener(resizeEvt, recalc, false);
	doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);