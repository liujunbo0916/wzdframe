<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
try{
	wx.config({
		debug : false,
		appId : '${share.shareTicket.appId}',
		timestamp : '${share.shareTicket.timestamp}',
		nonceStr : '${share.shareTicket.nonceStr}',
		signature : '${share.shareTicket.signature}',
		jsApiList : [ 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage']
	});
	wx.ready(function() {
				wx.onMenuShareAppMessage({
					title :  document.getElementById("shareTitle").value,
					desc :   document.getElementById("descContent").value,
					link :   document.getElementById("shareLinkTimeLine").value,
					imgUrl : document.getElementById("coverImg").value,
					trigger : function(res) {
						//alert("触发分享给好友");
					},
					success : function(res) {
						//alert("成功分享给好友");
					},
					cancel : function(res) {
						//alert('已取消');
					},
					fail : function(res) {
						//alert("分享给朋友:" + JSON.stringify(res));
					}
				});
				// 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
				wx.onMenuShareTimeline({
					title :  document.getElementById("shareTitle").value,
					desc :   document.getElementById("descContent").value,
					link :   document.getElementById("shareLinkFriend").value,
					imgUrl : document.getElementById("coverImg").value,
					trigger : function(res) {
						//alert('用户点击分享到朋友圈');
					},
					success : function(res) {
						//onShareSuccess("101202");
					},
					cancel : function(res) {
						//alert('已取消');
					},
					fail : function(res) {
						//App.alert("分享到朋友圈:"+JSON.stringify(res));
					}
				});
			});
}catch(e){
}
</script>
