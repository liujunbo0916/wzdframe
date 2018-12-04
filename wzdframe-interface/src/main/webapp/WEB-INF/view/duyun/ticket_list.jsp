<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>旅游门票</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/lymp.css">
    <style type="text/css">
       .content .table-view .table-view-cell .price {
			  bottom:12px;
			}
    </style>
</head>
<body>
    <div class="content">
        <ul class="table-view" id="dataUl">
         <!--    <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="/img/duyun/lymp/5.jpg"/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            茂兰自然保护区
                            <span class="grade">4A级景区</span>
                        </div>
                        <p class="mark">
                            <span>AAAA</span>
                            <span>可订今日票</span>
                        </p>
                        <p class="moods">1356人购买</p>
                        <p class="distance">距离1.5km</p>
                    </div>
                    <div class="price">¥ 42起</div>
                </a>
            </li> -->
        </ul>
        <div class="load-more">
            <button class="btn btn-block">加载更多</button>
        </div>
    </div>
    <!--设定预加载效果-->
    <div class="spinner">
        <div class="loading">
            <img src="/img/duyun/dstc/loading.gif" alt=""/>
        </div>
    </div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script src="/js/RequestDataForPage.js"></script>
<script type="text/javascript">
		var loadingPanel = document.querySelector('.spinner');
		var loadingMore = document.querySelector('.load-more');
		var condition = {
				currentPage : "1",
				currentLat:'',
				currentLng:''
			}
		/*微信获取经纬度 操作*/  
	/* 	wx.config({
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
						$("#dataUl").empty();
						loadMore(condition);
					}
				});
			}
	    }); */
		$(function(){
			loadMore(condition);
			$(".control-item").click(function() {
				condition.currentPage = 1;
				$("#dataUl").empty();
				loadMore(condition);
			});
			$(".load-more").click(function() {
				delete condition.currentPage;
				loadMore(condition);
			});
		});
		function loadMore(condition) {
		    loadingPanel.style.display = 'flex';
		    responseData.sendRequest("/wx/ticket/doList",condition,callBack);
		}
		var tpl = '<li onclick="window.location.href='+"'"+'/wx/ticket/index?redirectType=detail&pageType=${pd.pageType}&t_id={{8}}'+"'"+'" class="table-view-cell media"><a class="navigate-right"><div class="img-wrap">'+
				  '<img class="media-object pull-left" src="{{0}}"/>{{1}}</div>'+
				  '<div class="media-body"><div class="title-name">{{2}} {{3}}</div>'+
				  '{{4}}<p class="moods">{{5}}人购买</p>'+
				  '<p class="distance">距离{{6}}</p></div><div class="price">¥ {{7}}起</div></a></li>';
		//自定义渲染函数
		function callBack(data){
			var dataAry = [];
			var prefixImg = data.prefixImg;
			var data = data.resultPd;
			if(data.length != 10){
				loadingMore.style.display = 'none';
			}else{
				loadingMore.style.display = 'flex';
			}
			for(var i = 0 ; i < data.length ; i++){
				dataAry[0] = prefixImg+data[i].scenic_logo;
				if(i < 3){
				   dataAry[1] = "<span>TOP"+(i+1)+"</span>";
				}else{
					dataAry[1] = "";
				}
				dataAry[2] = data[i].scenic_name;
				dataAry[3] = '';
				var scenic_lable = data[i].scenic_lable || "";
				scenic_lable = scenic_lable.split(",")
				var tmpLabel = [];
				if(scenic_lable.length >0 && scenic_lable!=null && scenic_lable!=''){
					var html='<p class="mark">';
					for(var j = 0 ; j < scenic_lable.length ; j++){
						html+='<span>'+scenic_lable[j]+'</span>';
					}
					html+='</p>';
					dataAry[4] = html;
				}else{
					dataAry[4]='<br>';
				}
				dataAry[5] = data[i].scenic_buy_count || 0;
				if(data[i].isKm){
				   dataAry[6] = data[i].distance+"km";
				}else{
					dataAry[6] = data[i].distance+"m";
				}
				dataAry[7] = data[i].scenic_ticket_price||0.00;
				dataAry[8] = data[i].id;
				$("#dataUl").append(responseData.buildFtl(tpl,dataAry));
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