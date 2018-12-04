<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>讲解列表</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/jiangjielb.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="con">
				<ul>
					<c:forEach items="${dataModel}" var="item">
						<li>
							<!--left-->
							<div onclick="goToDetail('${item.id}',event);" class="list-left">
								<img src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"/>
							</div>
							<!--left-->
							<div onclick="goToDetail('${item.id}',event);" class="list-right">
										<h2>
								    <c:if test="${fn:length(item.scenic_name) > 10}">
									    <c:set value="${fn:substring(item.scenic_name,0,9)}${'...'}" var="scenic_name"></c:set>
									</c:if>
									 <c:if test="${fn:length(item.scenic_name) <= 10}">
									    <c:set value="${item.scenic_name}" var="scenic_name"></c:set>
									</c:if>
                                    ${scenic_name}								
								</h2>
								<c:if test="${not empty item.scenic_desc}">
								<p>
									 <c:if test="${fn:length(item.scenic_desc) > 14}">
									    <c:set value="${fn:substring(item.scenic_desc,0,13)}${'...'}" var="scenic_desc"></c:set>
									</c:if>
									 <c:if test="${fn:length(item.scenic_desc) <= 14}">
									    <c:set value="${item.scenic_desc}" var="scenic_desc"></c:set>
									</c:if>
									${scenic_desc}
								</p>
								</c:if>
							</div>
							 <audio  class="audioPlay" style="visibility: hidden;" controls="controls" >
								  <source src="${SETTINGPD.IMAGEPATH}${item.scenic_voice_path}" type="audio/mpeg" />
							 </audio>
							<!--right-->
							<div class="list-rights" id="voicePlay${item.id}" onclick="player(this,event);" data-time='${item.resource_hour}'  data-code="0">
								<img src="/img/weizou_voice.png"/>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
    <script src="/js/jquery-1.7.2.js"></script>
	<script src="/js/InheritString.js"></script>
	<script type="text/javascript">
	   //播放代码
	   
	   var  is_playFinish ,dhplay;
	   function player(thisObj,event){
		   event.stopPropagation();
		   //检测别的播放器是否播放
		   var palyer = $(thisObj);
		   var  playerControl = palyer.prev()[0];
		   if("1" == palyer.attr("data-code")){
			   palyer.attr("data-code","0");
			   playerControl.pause();
			   // 暂停的时候停止定时函数的执行
			   window.clearInterval(is_playFinish);
			   window.clearInterval(dhplay);
			   palyer.children().eq(0).attr('src','/img/weizou_voice.png');
		   }else{
			   audioPlay(palyer);
			   //播放
			   palyer.attr("data-code","1");
			   playerControl.play();
			   palyer.children().eq(0).attr('src','/img/weizou_voice.png');
			 //检测是否播放完成 
			is_playFinish =  setInterval(function(){
		            if(playerControl.ended){
		            	playerControl.pause();
		            	palyer.attr("data-code","0");
		            	playerControl.currentTime = 0;
		            	palyer.children().eq(0).attr('src','/img/weizou_voice.png');
		            	window.clearInterval(is_playFinish);
		            	window.clearInterval(dhplay);
		            }
            }, 500);
			dhplay = setInterval(function(){
				 palyer.children().eq(0).attr("src",'/img/weizou_voice_player.png');
				 setTimeout(function(){
					 $(palyer).children().eq(0).attr('src','/img/weizou_voice.png')
				 }, 500); 
			 },1000);
		   }
	   }
       //检测播放器是否处于播放状态   同一时间只允许一个播放器处于播放状态
	   function audioPlay(currentPlay){
		   $(".list-rights").each(function(){
			   if($(this).attr("data-code")=="1"){
				   //说明播放器处于播放状态  则关闭该状态
				    var  playerControl = $(this).prev()[0];
				    var palyer = $(this);
					playerControl.pause();
	            	palyer.attr("data-code","0");
	            	playerControl.currentTime = 0;
	            	palyer.children().eq(0).attr('src','/img/weizou_voice.png');
	            	window.clearInterval(is_playFinish);
	            	window.clearInterval(dhplay);
			   }
		   });
	   }
       
       function goToDetail(id,e){
    	   window.location.href='/wx/scenic/detail?id='+id
       }
       
	</script>
</html>
