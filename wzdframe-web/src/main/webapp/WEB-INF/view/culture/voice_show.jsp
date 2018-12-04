<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../common/top.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/webuploader.css">
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/style.css">
<link href="/assets/css/plugins/blueimp/css/blueimp-gallery.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/statics/jquery-video/skin/circle.skin/circle.player.css">
	<link rel="stylesheet" href="/statics/css/circle.player.css">
<style type="text/css">
.list-left{
	width: 85px;
	float: left;
	margin-right: 30px;
}
.list-right{
	border-bottom: 1px solid #e0e0e0;
	margin-left: 111px;
}
.list-right h2{
	font-size: 12px;
	color: #333333;
}
.right-bottom{
	margin-top: 16px;
}
.right-bottom img{
	width: 25px;
	float: left;
	margin-right: 16px;
}
.right-bottom span{
	font-size: 12px;
    color: #999999;
}
.bof-img{
	float: right;
}

</style>
<%@ include file="../common/foot.jsp"%>
<script src="/assets/js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.transform2d.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.grab.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/mod.csstransforms.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/circle.player.js"></script>
</head>
<body class="gray-bg"> 
	<div class="wrapper wrapper-content">
		<div class="row" style="background-color: #fff;">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
				   	<div class="ibox-title">
						<h5>音频列表<p style="color:red;">音频文件不提供编辑功能如若需要编辑请删除重新上传  </p></h5>
						
						<div class="ibox-tools">
						<a href="javascript:addVoice('${pd.id}');"
							class="btn btn-primary btn-xs"> <i class="fa fa-plus"></i>&nbsp;新增</a>
					</div>
					</div>
					<div class="ibox-content">
							<c:if test="${not empty albumModel}">	
							<c:forEach items="${albumModel}"  var="item">		
									<div class="col-sm-4">
										<!--left-->
										<div class="list-left">
											<img style="width: 85px;height: 85px;" src="${SETTINGPD.IMAGEPATH}${item.resource_img}">
											<span class="badge badge-danger" style="cursor:pointer;" onclick="delStockImg('${item.id}');" class="delImg">移除</span>
										</div>
										<!--right-->
										<div class="list-right clearfix">
										<div class="l" style="width:250px;">
											<div>${item.resource_title}</div>
											<div class="right-bottom clearfix">
												<img src="/statics/img/erj.png">
												<span id="timeFormat${item.id}">${item.resource_hour_format}</span>
											</div>
										</div>
										 <audio id="voicePlay${item.id}" class="audioPlay" style="display:none;" controls="controls">
											  <source src="${SETTINGPD.IMAGEPATH}${item.resource_path}" type="audio/mpeg">
										 </audio>
									     <div class="bof-img" onclick="player(this);" data-time="${item.resource_hour}" id="player${item.id}" data-code="0">
											<img style="width:40px;" src="/statics/img/bofang.png">
										 </div>
										</div>
										</div>
									<%-- <div class="col-sm-3">
									    <div class="list-left">
											<img style="width:85px;height:85px;" src="${SETTINGPD.IMAGEPATH}${item.resource_img}">
											 <span class="badge badge-danger" style="cursor:pointer;" onclick="delStockImg('${item.id}');" class="delImg">移除</span>
										</div>
									    <div class="list-right clearfix">
											<div class="l">
												<div style="width:170px;">${item.resource_title}</div>
												<div class="right-bottom clearfix">
													<img src="/statics/img/erj.png">
													<span>${item.resource_hour}</span>
												</div>
											</div>
											<div class="bof-img" onclick="player(this);" data-time="289" id="player66" data-code="0">
												<img src="/img/bofang.png">
											 </div>
									 <div class="bof-img">
												<div id="jquery_jplayer_${item.id}" class="cp-jplayer"></div>
												<div id="cp_container_${item.id}" class="cp-container">
													<div class="cp-buffer-holder"> 
														<div class="cp-buffer-1"></div>
														<div class="cp-buffer-2"></div>
													</div>
													<div class="cp-progress-holder" > 
														<div class="cp-progress-1"></div>
														<div class="cp-progress-2"></div>
													</div>
													<div class="cp-circle-control" ></div>
													<ul class="cp-controls">
														<li><a class="cp-play" tabindex="1">play</a></li>
														<li><a class="cp-pause" style="display:none;" tabindex="1">pause</a></li> <!-- Needs the inline style here, or jQuery.show() uses display:inline instead of display:block -->
													</ul>
												</div>
											</div>
											<script type="text/javascript">
													var myCirclePlayer = new CirclePlayer("#jquery_jplayer_${item.id}",
													{
														m4a: "${SETTINGPD.IMAGEPATH}${item.resource_path}"/* ,
														oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg" */
													}, {
														cssSelectorAncestor: "#cp_container_${item.id}",
														swfPath: "js",
														wmode: "window",
														keyEnabled: true
													});
											</script> 
										</div>
									</div> --%>
									</c:forEach>
							<div style="float:left;width: 170px; height: 136px;margin-left:40px;">
							   <button class="btn btn-warning" onclick="delStockImg('-2');" style="margin-top: 90px;" type="button"><i class="fa fa-warning"></i> <span class="bold">全部移除</span>
                               </button>
							 </div>
							<div id="blueimp-gallery" class="blueimp-gallery"
								style="display: none;">
								<div class="slides" style="width: 61200px;"></div>
								<h3 class="title">图片</h3>
								<a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a>
								<a class="play-pause"></a>
								<ol class="indicator"></ol>
							</div>
							</c:if>	
							<c:if test="${empty albumModel}">
							       暂无音频数据
							</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
            <div class="col-sm-4 col-sm-offset-5">
                <button class="btn btn-warning" type="button"  onclick="window.history.go(-1);"><i class="fa fa-exchange"></i>&nbsp;&nbsp;返    回&nbsp;&nbsp; </button>
            </div>
          </div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<script type="text/javascript"
		src="/statics/image-upload/dist/webuploader.js"></script>
	<!-- <script type="text/javascript" src="/statics/image-upload/upload_vedio.js"></script> -->
	<script type="text/javascript">
	  function delStockImg(id){
		  var msg = "确定删除该音频？";
		  if(id == '-2'){
			  msg = "确定全部删除？删除之后将不可恢复！";
		  }
		  bootbox.confirm(msg,function(result){
			  if(result){
				  Ajax.request("/sys/culture/resource/delete",{"data":{"id":id,"category_id":'${pd.id}'},"success":function(data){
					  if(data.result == 200){
						  location.reload();
					  }else{
						  bootbox.alert(data.msg);
					  }
				  }});
			  }
		  });
	  }
	  
	  function  addVoice(resource_id){
		   var index = layer.open({
	            type: 2,
	            title: '添加音频',
	            maxmin: true,
	            shadeClose: true, //点击遮罩关闭层
	            area : ['750px' , '500px'],
	            content: "/sys/culture/resource/uploadVoicePage?category_id="+resource_id
	        });
		  
	  }
	  //音频播放控件
	</script>
	
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
			   palyer.children().eq(0).attr('src','/statics/img/bofang.png');
		   }else{
			   audioPlay(palyer);
			   //播放
			   palyer.attr("data-code","1");
			   playerControl.play();
			   palyer.children().eq(0).attr('src','/statics/img/zanting.png');
			 //检测是否播放完成 
			is_playFinish =  setInterval(function(){
		            if(playerControl.ended){
		            	playerControl.pause();
		            	palyer.attr("data-code","0");
		            	playerControl.currentTime = 0;
		            	palyer.children().eq(0).attr('src','/statics/img/bofang.png');
		            	formatTime(parseInt(palyer.attr('data-time')),palyer);
		            	window.clearInterval(is_playFinish);
		            	window.clearInterval(format_time,palyer);
		            }
            }, 500);
			 //格式化时间1秒执行一次
			 format_time =  setInterval(function(){
				 totalTime -- ;
				 if(totalTime != 0){
					 formatTime(totalTime,palyer);
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
	            	palyer.children().eq(0).attr('src','/statics/img/bofang.png');
	            	formatTime(parseInt(palyer.attr('data-time')),palyer);
	            	window.clearInterval(is_playFinish);
	            	window.clearInterval(format_time);
	                totalTime = parseInt(currentPlay.attr('data-time'));
			   }
		   });
	   }
	</script>
	
</body>
</html>