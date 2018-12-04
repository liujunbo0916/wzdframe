<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>歌曲欣赏</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/gequxs.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
		<script src="/js/jquery-1.7.2.js"></script>
		<script src="/js/InheritString.js"></script>
		<style type="text/css">
		   .bof-img{
		        width: 60px;
			    float: right;
			    margin-top: 9px;
		   }
		</style>
	</head>
	<body>
		<div class="container"> 
			<!--内容-->
			<div class="con">
				<ul>
					<c:forEach items="${albumModel}" var="item">
						<li>
							<!--left-->
							<div class="list-left">
								<img style="width: 85px;height: 85px;" src="${SETTINGPD.IMAGEPATH}${item.resource_img}"/>
							</div>
							<!--right-->
							<div class="list-right clearfix">
							<div class="l">
								<div style="font-size:30px;width:500px;">${item.resource_title}</div>
								<div class="right-bottom clearfix">
									<img src="/img/erj.png"/>
									<span id="timeFormat${item.id}">${item.resource_hour_format}</span>
								</div>
							</div>
							 <audio id="voicePlay${item.id}" class="audioPlay" style="display:none;" controls="controls" >
								  <source src="${SETTINGPD.IMAGEPATH}${item.resource_path}" type="audio/mpeg" />
							 </audio>
						     <div class="bof-img" onclick="player(this);" data-time='${item.resource_hour}' id="player${item.id}" data-code="0">
								<img src="/img/bofang.png"/>
							 </div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	   var  is_playFinish ,format_time,totalTime;
	   function player(thisObj){
		   //检测别的播放器是否播放
		   var palyer = $(thisObj);
		   var  playerControl = palyer.prev()[0];
		   if(!totalTime){
			   totalTime = parseInt(palyer.attr('data-time'));
		   }
		   if("1" == palyer.attr("data-code")){
			   palyer.attr("data-code","0");
			   playerControl.pause();
			   // 暂停的时候停止定时函数的执行
			   window.clearInterval(is_playFinish);
			   window.clearInterval(format_time);
			   palyer.children().eq(0).attr('src','/img/bofang.png');
		   }else{
			   audioPlay(palyer);
			   //播放
			   palyer.attr("data-code","1");
			   playerControl.play();
			   palyer.children().eq(0).attr('src','/img/zanting.png');
			 //检测是否播放完成 
			is_playFinish =  setInterval(function(){
		            if(playerControl.ended){
		            	playerControl.pause();
		            	palyer.attr("data-code","0");
		            	playerControl.currentTime = 0;
		            	palyer.children().eq(0).attr('src','/img/bofang.png');
		            	formatTime(parseInt(palyer.attr('data-time')),palyer);
		            	window.clearInterval(is_playFinish);
		            	window.clearInterval(format_time,palyer);
		            }
            }, 500);
			 //格式化时间1秒执行一次
			 format_time =  setInterval(function(){
				 var totalTime1 = parseInt(totalTime-playerControl.currentTime);
				 if(totalTime1 != 0){
					 formatTime(totalTime1,palyer);
				 }
			 },1000);
		   }
	   }
	   function formatTime(totalTime,player){
		     var sec = totalTime % 60 +"";
			 sec = sec.PadLeft(2,'0');
			 var min = parseInt(totalTime / 60) + "";
			 min = min.PadLeft(2,'0');
			 player.prev().prev().children().eq(1).children().eq(1).text(min+":"+sec);
	   }
       //检测播放器是否处于播放状态   同一时间只允许一个播放器处于播放状态
	   function audioPlay(currentPlay){
		   $(".bof-img").each(function(){
			   if($(this).attr("data-code")=="1"){
				   //说明播放器处于播放状态  则关闭该状态
				    var  playerControl = $(this).prev()[0];
				    var palyer = $(this);
					playerControl.pause();
	            	palyer.attr("data-code","0");
	            	playerControl.currentTime = 0;
	            	palyer.children().eq(0).attr('src','/img/bofang.png');
	            	formatTime(parseInt(palyer.attr('data-time')),palyer);
	            	window.clearInterval(is_playFinish);
	            	window.clearInterval(format_time);
	                totalTime = parseInt(currentPlay.attr('data-time'));
			   }
		   });
	   }
	</script>
</html>
