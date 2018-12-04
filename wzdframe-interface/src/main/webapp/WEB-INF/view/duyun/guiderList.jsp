<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>都匀导游</title>
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
<link rel="stylesheet" href="/css/duyun/djtcd.css">
<style type="text/css">
 .content>.table-view:first-child {
	margin-top: 0px;
}

.content .table-view .table-view-cell {
	position: relative;
	padding: 10px 65px 0px 10px;
	overflow: hidden;
	border-bottom: 1px solid #ddd;
} 
</style>
</head>
<body>
	<div class="content">
		<ul class="table-view">
			<li class="table-view-cell"><a class="navigate-right">
					<div class="img-wrap">
						<img class="media-object pull-left" src="/img/duyun/djtcd/1.jpg" />
						<img class="hot" src="/img/duyun/icons/hot.png" alt="" />
					</div>
					<div class="media-body">
						<div class="title-name">
							都匀毛尖茶叶特产店
							<div class="grade">特别推荐</div>
						</div>
						<p class="mark">
							<span>茶叶</span>
						</p>
						<p class="moods">2150人去过</p>
						<p class="price">人均￥55</p>
					</div>
					<div class="distance">距离855m</div>
			</a></li>
		</ul>
		<div class="load-more">
			<button class="btn btn-block">加载更多</button>
		</div>
	</div>
	<!--设定预加载效果-->
	<div class="spinner">
		<div class="loading">
			<img src="/img/duyun/icons/loading.gif" alt="" />
		</div>
	</div>
	<script src="/vendors/ratchet/js/ratchet.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script src="/js/RequestDataForPage.js"></script>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script type="text/javascript">
		var loadingPanel = document.querySelector('.spinner');
		var loadingMore = document.querySelector('.load-more');
		var condition = {
			currentPage : "1",
			currentLat : '',
			currentLng : ''
		}
		$(function() {
			$(".table-view").empty();
			loadMore(condition);
			$(".control-item").click(function() {
				condition.currentPage = 1;
				$(".table-view").empty();
				loadMore(condition);
			});
			$(".load-more").click(function() {
				delete condition.currentPage;
				loadMore(condition);
			});
		});
		function loadMore(param) {
			loadingPanel.style.display = 'flex';
			responseData.sendRequest("/wx/guider/doList", param, callBack);
		}
		var hot = '<img class="hot" src="/img/duyun/dstc/hot.png" alt=""/>';
		var tpl = '<li class="table-view-cell media" onclick="getDetail({{8}});"> <a class="navigate-right"><div class="img-wrap">'
				+ '<img class="media-object pull-left" src="{{0}}"/>'
				+ '{{1}}</div><div class="media-body">'
				+ '<div class="title-name">{{2}}{{3}}</div>'
				+ '{{4}}{{9}}<p class="moods">带团次数：{{5}}</p><p class="price">￥{{6}} /天</p></div>'
				+ '<div class="distance"></div></a></li>';
		//自定义渲染函数
		function callBack(data) {
			var dataAry = [];
			var prefixImg = data.prefixImg;
			var data = data.resultPd;
			if (data.length != 10) {
				loadingMore.style.display = 'none';
			} else {
				loadingMore.style.display = 'flex';
			}
			for (var i = 0; i < data.length; i++) {
				dataAry[0] = prefixImg + data[i].guider_logo;
				dataAry[1] = '';
				if(data[i].guider_nickname){
					dataAry[2] = data[i].guider_name+" ("+data[i].guider_nickname+") ";
				}else{
					dataAry[2] = data[i].guider_name;
				}
				if(data[i].agency_show_name){
					dataAry[3] = '<div class="grade">'+data[i].agency_show_name+'</div>';
				}else{
					dataAry[3] = '';
				}
				var tabs = [];
				tabs = data[i].guider_lable.split(";");
				var html = '';
				if (tabs != null && tabs != '') {
					for (var j = 0; j < tabs.length; j++) {
						html += '<span>' + tabs[j] + '</span>';
					}
				}
				var p = '<p class="mark">' + html + '</p>';
				dataAry[4] = p;
				if (!html) {
					dataAry[4] = '';
				}
				dataAry[5] = data[i].guider_service_num;
				if(data[i].guider_price){
					dataAry[6] = data[i].guider_price;
				}else{
					dataAry[6] = 0.0;
				}
				dataAry[8] = data[i].guider_id;
				if (dataAry[4] == '') {
					dataAry[9] = "<br>";
				} else {
					dataAry[9] = '';
				}
				$(".table-view").append(responseData.buildFtl(tpl, dataAry));
				dataAry.length = 0; //清空数组 
			}
		}

		function getDetail(guiderId) {
			window.location.href = '/wx/guider/index?resultType=detail&guiderId='+ guiderId;
		}
	</script>
</body>
</html>