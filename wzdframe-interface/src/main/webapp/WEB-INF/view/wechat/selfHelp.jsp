<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>自助导览</title>
<link href="/css/map.css" rel="stylesheet" />
<link href="/css/reset.css" rel="stylesheet" />
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=EZPCgQ6zGu6hZSmXlRrUMTpr"></script>
<script src="/js/jquery-1.7.2.js"></script>
   <style type="text/css">
     .icon_voice{
        background:url(/img/ditu/beijing38@2x.png); 
     }
     .icon_bs{
        background:url(/img/ditu/beijing38@2x.png);
     }
     .pinl-fixed {
         box-shadow: 0px 6px 10px rgba(24,22,20,0.1);
         border-radius: 4px;
		 right: 10px;
		 left: 10px;
		 width: 94%;
		 padding-right: 30px;
		 position: fixed;
		 top: 10px;
		 background-color: #fff;
		}
		.input {
		    width: 87%;
		    height: 40px;
		    float: left;
		    overflow: hidden;
		}
		.input input {
		    width: 100%;
		    height: 100%;
		    font-size: 12px;
		    background: #f5f5f5;
		    text-indent: 15px;
		    background-color:#fff;
		    border-right: 1px solid #f5f5f5;
		}
		.fixed-img {
		    float: right;
		}
   </style>
</head>
<body>
	<div id="allmap" style="height:100%"></div>
	<!--图标-->
	<!-- <div class="icon_voice"
		onclick="window.location.href='/wx/scenic/explainList'">
		<img src="/img/laba.png" />
	</div> -->
		   <div class="pinl-fixed clearfix">
		      <div class="input">
		          <input  type="text" id="searchInput" placeholder="搜索景点" />
		      </div>
		      <div class="fixed-img" onclick="onSearch();" style="margin-left:6px;height: 40px;">
			      <p id="thumbsup" style="margin-top: 10px;font-size: 12px;    margin-top: 11px;">搜索</p>
			   </div>
		   </div>
	<div class="icon_voice" style="top: 35%;width: 38px;height: 96px;">
	    <div class="vedio" style="    margin-top: -1px;margin-left: 2px;"  onclick="gotoVedioList();">
	        <img alt="" style="width: 24px;height: 39px;" src="/img/ditu/jiangjieicon@2x.png">
	    </div>
	    <div class="scenic" style="margin-top: 9px;margin-left: 2px;" onclick="gotoVedioList('choose');">
	        <img alt="" style="width: 24px;height: 39px;" src="/img/ditu/jingdianicon.png">
	    </div>
	</div>
	<!--放大缩小-->
	<div class="icon_bs" style="width: 38px;height: 96px;">
		<img id="big" alt="" style="     margin-top: 10px; margin-left: 3px;  width: 23px; " src="/img/ditu/jia@2x.png">
		<img  id="small" style="     margin-top: 19px; margin-left: 3px; width: 23px;" alt="" src="/img/ditu/jian@2x.png">
	</div>
	<div id="container" class="container">
		<div class="con-box clearfix">
			<!--left-->
			<div class="list-left">
				<span></span>
				<h2 id="scenic_name">杂味食堂</h2>
			</div>
			<!--right-->
			<div class="right-box" id="playLogo" data-code="0">
				<div class="icon">
					<img id="player_flag" src="/img/voic.png">
				</div>
				<p id="playTime"></p>
			</div>
			<audio id="voicePlay" style="display: none;" controls="controls" >
				  <source src="" type="audio/mpeg" />
			</audio>
			<audio id="tipPlay" style="display: none;" controls="controls" >
				  <source src="" type="audio/mpeg" />
			</audio>
		</div>
		<div style=" overflow-y: auto; overflow-x: hidden; height: 90px;" class="text" id="scenic_content">
		</div>
	</div>
</body>
<%@ include file="common/commJs.jsp"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=EZPCgQ6zGu6hZSmXlRrUMTpr"></script>
<script src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/AreaRestriction/1.2/src/AreaRestriction_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
</html>
<script type="text/javascript">
    var imgPathFxid = "${SETTINGPD.IMAGEPATH}";
	var latLntInfo = {
		currentLat : 0,
		currentLng : 0,
		destLat:0,
		destLng:0,
		speed : 0,
		accuracy : 0,
		scenic_id:0,
		is_play_finish:false,
		seachLat:'${pd.lat}',
		seachLng:'${pd.lng}',
		is_input_search:false
	}
	var BMapOpt={
			scenic_marker:[]
	}
	var playerMsg ={
			playControl:'',
			tipControl:''
	}
	var walking,animation,is_playFinish;
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	map.setZoom(16);
	var big = document.getElementById("big");
	var small = document.getElementById("small");
	big.onclick = function(e) {
		map.setZoom(map.getZoom() + 2);
	}
	small.onclick = function(e) {
		map.setZoom(map.getZoom() - 2);
	}
	$(".container").hide();
	wx.config({
		debug : false,
		appId : '${share.shareTicket.appId}',
		timestamp : '${share.shareTicket.timestamp}',
		nonceStr : '${share.shareTicket.nonceStr}',
		signature : '${share.shareTicket.signature}',
		jsApiList : [ 'getLocation' ]
	});
	wx.ready(function() {
		//每15秒查询一次位置信息 重新规划路线
		getLocation();
		//请求所有的景点覆盖到地图上
		getAllScenicMsg();
		//playerMsg.playControl.play();
		var getLocationTimer =  setInterval(function(){
				getLocation();
			/* if(latLntInfo.speed > 0){
			   getLocation();
			} */
		},15000);
		function getLocation() {
			wx.getLocation({
				type : 'wgs84', //默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
				success : function(res) {
					latLntInfo.currentLat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
					latLntInfo.currentLng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
					latLntInfo.speed = res.speed; // 速度，以米/每秒计
					latLntInfo.accuracy = res.accuracy; // 位置精度
					//转换经纬度
					translate(latLntInfo.currentLat, latLntInfo.currentLng);
				}
			});
		}
		//点击播放按钮执行
		$("#playLogo").click(function(){
			if(playerMsg.playControl){
				var $playLogo = $(this);
				 if("1" == $playLogo.attr("data-code")){
					   $playLogo.attr("data-code","0");
					   
					   window.clearInterval(animation);
					   //window.clearInterval(is_playFinish);
					   playerMsg.playControl.pause();
					   $("#player_flag").attr("src","/img/voic.png");
				   }else{
					   //播放
					   $playLogo.attr("data-code","1");
					   playerMsg.playControl.play();
					   checkPlayerEnd();
			      }
			}
		});
});		
	/**
	 * 将腾讯的经纬度转换成百度的经纬度
	 */
	 var pointMarker;
	function translate(lat, lng) {
		var gpsPoint = new BMap.Point(lng, lat);
		BMap.Convertor.translate(gpsPoint, 0, function(currentPoint) {
			latLntInfo.currentLat = currentPoint.lat;
			latLntInfo.currentLng = currentPoint.lng;
			if(!pointMarker){
				map.centerAndZoom(currentPoint,18);
			}
			if(pointMarker){
				map.removeOverlay(pointMarker);
			}
			pointMarker = new BMap.Marker(currentPoint);
			map.addOverlay(pointMarker);
			//查看最近的景点
			findScenicByLngLat(lng,lat);
			//如果是选择页面跳转过来 则绘制出导航路线
			if(latLntInfo.seachLat && latLntInfo.seachLng && !latLntInfo.is_input_search){
				initSearch(latLntInfo.seachLng,latLntInfo.seachLat);
			}
		});
	}
	//请求  所有景点
	function getAllScenicMsg() {
		Ajax.request("/wx/scenic/allScenic", {
			"data" : {},
			"success" : function(data) {
				if (data.code == 200) {
					//将所有的景点
					for(var i = 0 ; i < data.data.length ; i++){
						var scenic_desc;
						if(data.data[i].scenic_desc &&  data.data[i].scenic_desc.length > 100){
							scenic_desc = data.data[i].scenic_desc.substring(0,100);
							scenic_desc = scenic_desc+"...";
						}else{
							scenic_desc = data.data[i].scenic_desc
						}
						 var _html = "<div id='markerInfo'><h4 style='margin:0 0 5px 0;padding:0.2em 0;'>"+data.data[i].scenic_name+"</h4><p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em;'>"+scenic_desc+"</p><div style='width:100%;font-size: 13px;color: blue;margin-left: 250px;'> <a onclick='initSearch("+data.data[i].scenic_lng+","+data.data[i].scenic_lat+");' href='javascript:;'>到这去>></a></div></div>"
						 BMapOpt.scenic_marker.push(createMarker(new BMap.Point(data.data[i].scenic_lng,data.data[i].scenic_lat),_html,data.data[i]));
					}
					 var myClusterer = new BMapLib.MarkerClusterer(map, {markers:BMapOpt.scenic_marker});
				}
			}
		});
	}
	//创建覆盖物
	function createMarker(node,info_html,data){
		var tempPoint = new BMap.Point(node.lng, node.lat);
		var myIcon = new BMap.Icon(imgPathFxid+data.marker_logo, new BMap.Size(40,66));
		 var _marker = new BMap.Marker(tempPoint,{icon:myIcon});
		 _marker.tempPoint = tempPoint;
		 _marker.dataModel = data;
		 _marker.addEventListener("click", function(e){
			    map.openInfoWindow(new BMap.InfoWindow(info_html),node); //将infowindow放在map中
			   // this.openInfoWindow(new BMap.InfoWindow(info_html));
	            latLntInfo.scenic_id = data.id;
	            getScenicDetail(data);
	        });
		 return _marker;
	}
	function initSearch(lng,lat){
		var tempPoint = new BMap.Point(lng,lat);
		//清除上一次的结果
		if(walking){
		   walking.clearResults()
		} 
		walking = new BMap.WalkingRoute(map, {renderOptions:{map: map, autoViewport: true}});
		var currentPoint = new BMap.Point(latLntInfo.currentLng,latLntInfo.currentLat);
		walking.search(currentPoint, tempPoint);
		walking.setSearchCompleteCallback(function(){
			var pts = walking.getResults().getPlan(0).getRoute(0).getPath();
			var polyLine = new BMap.Polyline(pts,{strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5});
			map.addOverlay(polyLine);
		});
	}
	//获取后台景区详情   
	function getScenicDetail(data){
		if(playerMsg.tipControl){
			playerMsg.tipControl.pause();
		}
		if(!data.scenic_voice_path){
			if(playerMsg.playControl){
				playerMsg.playControl.pause();
			}            
			$("#playLogo").hide();
		}else{
			$("#playLogo").show();
			//语音播放
			playerMsg.playControl = document.getElementById('voicePlay');
			//语音提示播放器
			playerMsg.tipControl = document.getElementById('tipPlay');
			//如果提示消息在语音播放的前面
			if(data.scenic_tip_resource && data.scenic_tip_order &&  data.scenic_tip_order == "1"){
				playerMsg.playControl.src = imgPathFxid+data.scenic_tip_resource;
				$("#playTime").text(data.voice_hour);
				//赋值提示语音
				playerMsg.tipControl.src = imgPathFxid+data.scenic_voice_path;
			}else{
				playerMsg.playControl.src = imgPathFxid+data.scenic_voice_path;
				$("#playTime").text(data.voice_hour);
				//赋值提示语音
				if(data.scenic_tip_resource){
				   playerMsg.tipControl.src = imgPathFxid+data.scenic_tip_resource;
				}else{
					 playerMsg.tipControl = null;
				}
			}
			playerMsg.playControl.play();
			//playerMsg.playControl = $("#voicePlay")[0];
			$("#playLogo").attr("data-code","1");
			checkPlayerEnd();
		}
		//不管怎么样都要重新查找对象
		$("#container").hide('slow');
		//将景区简介重下面弹出来
		var scenic_desc;
		scenic_desc = data.scenic_desc||"";
		var scenic_name;
		data.scenic_name = data.scenic_name || "";
		if(data.scenic_name.length > 12){
			scenic_name = data.scenic_name.substring(0,11);
			scenic_name += "...";
		}else{
			scenic_name = data.scenic_name;
		}
		$("#scenic_name").text(scenic_name);
		$("#scenic_content").text(scenic_desc);
		$("#container").show('slow');
		
	}
	//根据当前经纬度去后台取在范围内的景点
	function findScenicByLngLat(lng,lat){
		var overlays = BMapOpt.scenic_marker; //得到所有的覆盖点
		for(var i = 0 ; i < overlays.length ; i++){
			if(overlays[i].tempPoint){
				var point = overlays[i].tempPoint;
				var radius =  parseFloat(overlays[i].dataModel.scenic_radius||0);
				var banjing = getGreatCircleDistance(lat,lng,point.lat,point.lng);
				overlays[i].distance =  banjing - radius;
			}else{
				overlays.splice(i, 1);
			}
		}
		overlays.sort(function(a,b){
			    a.distance = a.distance||1000000; 
			    b.distance = b.distance ||100000;
	            return a.distance-b.distance});
		if(overlays[0].distance <= 0){
			if(playerMsg.playControl && !latLntInfo.is_play_finish){
				return;
			}
			latLntInfo.is_play_finish = false;
			if(latLntInfo.scenic_id != overlays[0].dataModel.id){
				latLntInfo.scenic_id = overlays[0].dataModel.id;
				getScenicDetail(overlays[0].dataModel);
				  //将用户足记记录到数据库
				 Ajax.request("/wx/scenic/ajaxSimpleScenic",{"data":{"lat":lat,"lng":lng,"scenic_id":overlays[0].dataModel.id},"success":function(data){
						if(data.code == 200){
						}
				}});
			}
		}
	}
	
	
	
	
	//检测是否播放结束
	function checkPlayerEnd(){
		animation = setInterval(function(){
			 $("#player_flag").attr("src","/img/voic_empty.png");
			    //设置播放效果
			    setTimeout(function(){
			    	$("#player_flag").attr("src","/img/voic.png");
			  }, 500);
		}, 1000);
		$(playerMsg.playControl).bind("ended",function(){
			$("#player_flag").attr("src","/img/voic.png");
			$("#playLogo").attr("data-code","0");
			window.clearInterval(animation);
			playerMsg.playControl.currentTime = 0;
			playerMsg.playControl.pause();
			latLntInfo.is_play_finish=true;
			if(playerMsg.tipControl){
				playerMsg.playControl.src = playerMsg.tipControl.src;
				$("#playLogo").trigger("click");
				//playerMsg.playControl.play();
			}
		});
		/* animation = setInterval(function(){
			 $("#player_flag").attr("src","/img/voic_empty.png");
			    //设置播放效果
			    setTimeout(function(){
			    	$("#player_flag").attr("src","/img/voic.png");
			  }, 500);
		}, 1000);
		is_playFinish =  setInterval(function(){
	            if(playerMsg.playControl.ended){
	            	//如果语音播放播放完成 开启提示语音的播放
	            	if(playerMsg.tipControl){
				       playerMsg.tipControl.play();
				       checkTipPlayerEnd();
	            	}else{
	            	   latLntInfo.is_play_finish=true;
	            	}
	            	playerMsg.playControl.pause();
	            	$("#playLogo").attr("data-code","0");
	            	playerMsg.playControl.currentTime = 0;
	            	window.clearInterval(is_playFinish);
	            	$("#player_flag").attr("src","/img/voic.png");
	            	window.clearInterval(animation);
	            }
      }, 500); */
	}
	//检测提示语音是否播放完成
	/* function checkTipPlayerEnd(){
		animation = setInterval(function(){
			 $("#player_flag").attr("src","/img/voic_empty.png");
			    //设置播放效果
			    setTimeout(function(){
			    	$("#player_flag").attr("src","/img/voic.png");
			  }, 500);
		}, 1000);
		 is_playFinish =  setInterval(function(){
            if(playerMsg.tipControl.ended){
            	alert("3<><><><>:"+playerMsg.tipControl);
            	//如果语音播放播放完成 开启提示语音的播放
            	latLntInfo.is_play_finish=true;
            	playerMsg.tipControl.pause();
            	$("#playLogo").attr("data-code","0");
            	playerMsg.tipControl.currentTime = 0;
            	window.clearInterval(is_playFinish);
            	$("#player_flag").attr("src","/img/voic.png");
            	window.clearInterval(animation);
            }
  }, 500);
	} */
	//##############################计算经纬度的方法#########################################
	var EARTH_RADIUS = 6378137.0;    //单位M
    var PI = Math.PI;
    function getRad(d){
        return d*PI/180.0;
    }
    function getGreatCircleDistance(lat1,lng1,lat2,lng2){
        var radLat1 = getRad(lat1);
        var radLat2 = getRad(lat2);
        var a = radLat1 - radLat2;
        var b = getRad(lng1) - getRad(lng2);
        var s = 2*Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) + Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));
        s = s*EARTH_RADIUS;
        s = Math.round(s*10000)/10000.0;
        return s;
    }
  //##############################计算经纬度的方法结束#########################################
    //跳转到简介列表
    function gotoVedioList(type){
	     if(!type){
	    	 type = "default";
	     }
    	 window.location.href='/wx/scenic/explainList?type='+type+'&lat='+latLntInfo.currentLat+'&lng='+latLntInfo.currentLng;
    }
   //跳转到搜索列表
   //根据输入的地点去在地图上找点并导航
   function onSearch(){
	   latLntInfo.is_input_search = true;
	   var keyword = $("#searchInput").val();
	   var localSearch = new BMap.LocalSearch(map);
	   localSearch.enableAutoViewport();
	   localSearch.setSearchCompleteCallback(function (searchResult) {
		   var poi = searchResult.getPoi(0);
		   if(poi){
		      initSearch(poi.point.lng,poi.point.lat);
		   }else{
			   alert("暂无搜索结果");
		   }
		});
       localSearch.search(keyword);
   }
 //监听返回按钮
	if('home' == '${pd.pageType}'){
		GoBackBtn.excuteHistory("/wx/home");
	}else{
	    GoBackBtn.excuteHistory("close");
	}
</script>