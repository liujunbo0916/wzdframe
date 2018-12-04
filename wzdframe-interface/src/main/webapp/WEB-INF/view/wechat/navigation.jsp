<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<title>导航</title>
	<link href="/css/map.css" rel="stylesheet"/>
	<link href="/css/reset.css" rel="stylesheet"/>
</head>
<body>
	<div id="allmap" style="height:100%"></div>
	<!--放大缩小-->
	<div class="icon_bs">
		<a id="big">+</a>
		<a id="small">-</a>
	</div>
</body>
</html>
<%@ include file="common/commJs.jsp"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=EZPCgQ6zGu6hZSmXlRrUMTpr"></script>
<script src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript">
//保留经纬度信息
var latLntInfo = {
		currentLat:0,	
		currentLng:0,
		distLat:'${pd.lat}',
		distLng:'${pd.lng}',
		distAddress:'${pd.address}',
		speed:0,
		accuracy:0
}
wx.config({
	debug : false,
	appId : '${share.shareTicket.appId}',
	timestamp : '${share.shareTicket.timestamp}',
	nonceStr : '${share.shareTicket.nonceStr}',
	signature : '${share.shareTicket.signature}',
	jsApiList : [ 'getLocation' ]
});
var map = new BMap.Map("allmap");
map.setZoom(16);
var index = 0;
wx.ready(function() {
	//每15秒查询一次位置信息 重新规划路线
	getLocationMsg();
	var getLocation =  setInterval(function(){
		getLocationMsg();
	},15000);
	function getLocationMsg(){
		wx.getLocation({
		    type: 'wgs84', //默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
		    success: function (res) {
		    	latLntInfo.currentLat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		    	latLntInfo.currentLng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		    	latLntInfo.speed = res.speed; // 速度，以米/每秒计
		    	latLntInfo.accuracy = res.accuracy; // 位置精度
		    	//转换经纬度
		    	if(latLntInfo.speed  > 0 || index == 0){
		    		index = 1;
		    		translate(latLntInfo.currentLat,latLntInfo.currentLng);
		    	}
		    }
		});
	}
});
//初始化地图
 /* 参数  currentLat  currentLng
   * distLat    distLng
 */
var walking;
function initSearch(latLntInfo){
	if(walking){
		  walking.clearResults()
	}
	walking = new BMap.WalkingRoute(map, {renderOptions:{map: map, autoViewport: true}});
	var currentPoint = new BMap.Point(latLntInfo.currentLng,latLntInfo.currentLat);
	var destPoint = new BMap.Point(latLntInfo.distLng,latLntInfo.distLat);
	walking.search(currentPoint, destPoint);
}
/**
 * 将腾讯的经纬度转换成百度的经纬度
 */
 function translate(lat,lng){
/* 	Ajax.request("/wx/scenic/translate",{"data":{"lat":lat,"lng":lng},"success":function(data){
		if(data.code == 200){
			latLntInfo.currentLat =    data.data.baidu.lat;
			latLntInfo.currentLng =    data.data.baidu.lng;
			map.centerAndZoom(new BMap.Point(latLntInfo.currentLng, latLntInfo.currentLat), 16);
			//绘制出路线
			initSearch(latLntInfo);
		}
	}}); */
	var gpsPoint = new BMap.Point(lng, lat);
	BMap.Convertor.translate(gpsPoint, 0, function(currentPoint) {
		latLntInfo.currentLat = currentPoint.lat;
		latLntInfo.currentLng = currentPoint.lng;
		map.setCenter(new BMap.Point(latLntInfo.currentLng, latLntInfo.currentLat));
		/* map.centerAndZoom(new BMap.Point(latLntInfo.currentLng, latLntInfo.currentLat), 16); */
		//绘制出路线
		initSearch(latLntInfo);
	});
}
</script>