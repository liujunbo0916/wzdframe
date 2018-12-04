<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>酒店列表</title>
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<!-- Sets initial viewport load and disables zooming -->
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="email=no" name="format-detection" />
<link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/jd.css">
<style type="text/css">
.bar-header-secondary {
  top: 0px;
}
.bar-header-secondary ~ .content {
  padding-top: 44px;
}
</style>

</head>
<body>
	<nav class="bar bar-standard bar-header-secondary">
		<div class="segmented-control">
			<a class="control-item active" data-code="popularity" href="javascript:;"> 人气最高 </a> <a
				class="control-item" data-code="distance" href="javascript:;"> 距离最近 </a> <a
				class="control-item" data-code="price" href="javascript:;"> 价格最低 </a>
		</div>
	</nav>
	<div class="content">
		<!--人气最高，距离最近，价格最低-->
		<ul id="hotellist" class="control-content table-view active">
		</ul>
		<!--加载更多-->
		<div class="load-more">
			<button class="btn btn-block" id="load-more">加载更多</button>
		</div>
	</div>
	<!--设定预加载效果-->
	<div class="spinner">
		<div class="loading">
			<img src="/img/duyun/icons/loading.gif" alt="" />
		</div>
	</div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script src="/js/RequestDataForPage.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
	var loadingPanel = document.querySelector('.spinner');
	var condition = {
			orderType:"popularity",
			currentLat:'',
			currentLng:''
	}
	/*微信获取经纬度 操作*/  
	wx.config({
		debug : false,
		appId : '${share.shareTicket.appId}',
		timestamp : '${share.shareTicket.timestamp}',
		nonceStr : '${share.shareTicket.nonceStr}',
		signature : '${share.shareTicket.signature}',
		jsApiList : [ 'getLocation' ]
	});
    wx.ready(function() {
		getLocation();
		function getLocation() {
			wx.getLocation({
				type : 'wgs84', //默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
				success : function(res) {
					condition.currentLat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
					condition.currentLng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
					loadMore(condition);
				}
			});
		}
    });
	$(function() {
		$(".control-item").click(function(){
			condition.orderType = $(this).attr("data-code");
			condition.currentPage = 1;
			$("#hotellist").empty();
			loadMore(condition);
		});
		$("#load-more").click(function(){
			delete condition.currentPage;
			loadMore(condition);
		});
	});
	function loadMore(param) {
		loadingPanel.style.display = 'flex';
		responseData.sendRequest("/wx/hotel/doList", param, callBack);
	}
	var hot = '<img class="hot" src="/img/duyun/dstc/hot.png" alt=""/>';
	var recomment1 = '<div class="recomment">人气推荐</div>';
	var recomment2 = '<div class="recomment">特别推荐</div>';
	
	var tpls = '<li class="table-view-cell media" onclick='+'javascript:window.location.href="'+'{{2}}'+'"'+'><a class="navigate-right"> {{0}}'
			+ '<img class="media-object pull-left" src="{{3}}"/>'
			+ '<div class="media-body"><div class="title-name">'
			+ '{{4}}{{1}}'
			+ '</div><p>距离     {{5}}</p>'
			+ '<p class="moods">{{6}}</p>'
			+ '<div class="price">¥ {{7}}</div></div></a></li>';
	//自定义渲染函数
	function callBack(data) {
		var dataAry = [];
		var prefixImg = data.prefixImg;
		var data = data.resultPd;
		for (var i = 0; i < data.length; i++) {
			//是否热门
			if(data[i].hotel_hot == 1){
				dataAry[0] = hot;
			}else{
				dataAry[0] = '';
			}
			//是否特别推荐
			if(data[i].hotel_recommend == 1){
				dataAry[1] = recomment2;
			}else{
				dataAry[1] = '';
			}
			dataAry[2] = data[i].hotel_url;
			dataAry[3] = prefixImg + data[i].hotel_img;
			dataAry[4] = data[i].hotel_name;
			/* dataAry[5] = data[i].hotel_popularity */
			dataAry[5] = data[i].distance;
			dataAry[6] = data[i].hotel_type_name;
			dataAry[7] = data[i].hotel_price;
			$("#hotellist").append(responseData.buildFtl(tpls, dataAry));
			dataAry.length = 0; //清空数组
		}
	}
	 //监听返回按钮
	if('home' == '${pd.pageType}'){
		GoBackBtn.excuteHistory("/wx/home");
	}else{
	    GoBackBtn.excuteHistory("close");
	}
</script>
</html>