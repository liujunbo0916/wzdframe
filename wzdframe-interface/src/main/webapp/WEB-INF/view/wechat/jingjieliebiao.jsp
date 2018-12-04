<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
     <title>讲解列表</title>
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
    <link rel="stylesheet" href="/css/duyun/dstc.css">
    <style type="text/css">
    
        .list-rights{
		    position: absolute;
		    right: 20px;
		    bottom: 8px;
        }
        .list-rights img{
            width: auto;
		    height: 35px;
        }
    </style>
</head>
<body>
    <div class="content">
        <ul id="sortDefault" class="control-content table-view active">
            <c:forEach items="${dataModel}" var="item">
	            <li class="table-view-cell media">
	                <a class="" style="margin: -11px -29px -11px -15px;">
	                    <img onclick="goToDetail('${item.id}',event);" style="    width: 124px; height: 114px;" class="media-object pull-left" src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"/>
	                    <div class="media-body">
	                        <div onclick="goToDetail('${item.id}',event);" class="title-name">
	                           ${item.scenic_name}
	                        </div>
	                        <div onclick="goToDetail('${item.id}',event);" style="height: 40px; overflow: hidden;font-size: 15px;    margin-top: 10px;">${item.scenic_desc}</div>
	                         <audio  class="audioPlay" style="visibility: hidden;" controls="controls" >
								  <source src="${SETTINGPD.IMAGEPATH}${item.scenic_voice_path}" type="audio/mpeg" />
							 </audio>
							 <div class="list-rights" id="voicePlay${item.id}" onclick="player(this,event);" data-time='${item.resource_hour}'  data-code="0">
								<img src="/img/weizou_voice.png"/>
							</div>
	                    </div>
	                </a>
	            </li>
            </c:forEach>
        </ul>
    </div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery-1.7.2.js"></script>
<script src="/js/Ajax.js"></script>
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
       
       GoBackBtn.excuteHistory("/wx/line/selfHelp");
	</script>
</html>