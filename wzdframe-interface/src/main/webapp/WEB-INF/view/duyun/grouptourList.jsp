<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>路线预定</title>
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="email=no" name="format-detection" />
<link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/lxyd.css">
</head>

<body>
	<div class="content">
		<ul class="table-view">
		 	<li class="table-view-cell media"><a class="navigate-right">
					<div class="img-wrap">
						<img class="media-object pull-left" src="/img/duyun/lxyd/1.jpg" />
						<span>跟团游</span>
					</div>
					<div class="media-body">
						<div class="title-name">【25℃贵州】贵阳 安顺 荔波 西江双飞5日深度游 [豪华酒店 ...
						</div>
						<p class="mark">
							<span>纯玩</span> <span>高铁游</span>
						</p>
						<p class="moods">1356人购买</p>
					</div>
					<div class="price">¥ 40起</div>
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
	<script type="text/javascript">
		var loadingPanel = document.querySelector('.spinner');
		var loadingMore = document.querySelector('.load-more');
		var condition = {
			currentPage : "1"
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
			loadingMore.style.display = 'none';
			responseData.sendRequest("/wx/grouptour/doList", param, callBack);
		}
		
		var tpl = '<li class="table-view-cell media" style="padding: 0px 10px 0px 10px;" onclick="doDetail({{5}})"><a class="navigate-right" style="margin: -11px -125px -11px -15px;">'
				+ '<div class="img-wrap"><img class="media-object pull-left" src="{{0}}" /><span>跟团游</span></div><div class="media-body">'
				+ '<div class="title-name">{{1}}</div>'
				+ '{{2}}<br><p class="moods">{{3}}人购买</p></div><div style="bottom: 27px;" class="price">¥ {{4}}起</div></a></li>';
				
		//自定义渲染函数
		function callBack(data) {
			var dataAry = [];
			var prefixImg = data.prefixImg;
			var data = data.resultPd;
			if(data.length != 10){
				loadingMore.style.display = 'none';
			}else{
				loadingMore.style.display = 'flex';
			}
			for (var i = 0; i < data.length; i++) {
				dataAry[0] = prefixImg + data[i].grouptour_img;
				dataAry[1] = data[i].grouptour_name;
				var tabs = [];
				tabs = data[i].grouptour_tab.split(",");
				var html = '';
				if (tabs != null && tabs != '') {
					if (tabs.length > 2) {
						for (var j = 0; j < 2; j++) {
							html += '<span>' + tabs[j] + '</span>';
						}
					} else {
						for (var j = 0; j < tabs.length; j++) {
							html += '<span>' + tabs[j] + '</span>';
						}
					}
				}
				var p = '<p class="mark">' + html + '</p>'
				dataAry[2] = p;
				if (!html) {
					dataAry[2] = '';
				}
				dataAry[3] = data[i].grouptour_sales;
				dataAry[4] = data[i].grouptour_price
				dataAry[5] = "'"+data[i].grouptour_id+"'";
				$(".table-view").append(responseData.buildFtl(tpl, dataAry));
				dataAry.length = 0; //清空数组 
			}
		}
		function doDetail(id){
			window.location.href="/wx/grouptour/index?resultType=detail&redirectType=${pd.redirectType}&grouptour_id="+id;
		}
		//监听返回按钮
		if('home' == '${pd.redirectType}'){
			GoBackBtn.excuteHistory("/wx/home");
		}else{
		  GoBackBtn.excuteHistory("close");
		}
	</script>
</body>
</html>