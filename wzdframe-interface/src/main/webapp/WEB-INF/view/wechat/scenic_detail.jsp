<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>景点概况</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/weizougk.css" rel="stylesheet"/>
	    <script src="/js/shipei.js"></script> 
		<style type="text/css">
		.cant-box{
				background: #fff;
				margin-top: 0.18rem;
				padding: .3rem;
			}
			.cant-box h3{
				font-size: 0.32rem;
				color: #454553;
				margin-bottom: 0.30rem;
			}
			.cant-img{
				width: 100%;
				margin-bottom: 0.22rem;
			}
			.img-list{
				overflow: hidden;
			}
			.img-list li{
				float: left;
				width: 3.34rem;
			}
			.img-list li:nth-child(even){
				float: right;
			}
			.tips-box{
				background: #fef8f0;
				border: 1px solid #fee4c4;
				padding: 0.25rem 0.38rem;
			}
			.jinduback{
			    height: 0.10rem;
			    background:#ffdf4c;
			    float: left;
		        margin-top: 0.45rem;
                margin-left: -4.35rem;
			}
			.text-box1{
			    background: #fff;
			    color: #666666;
			    font-size: 0.18rem;
			     padding: 0.1rem; 
			    /* line-height: 3em; */
			    margin-top: 0.18rem;
			}
			.text-box1 h3{
			    font-size: 0.32rem;
				color: #454553;
				margin-bottom: 0.3rem;
			}
			.text-box1 img{
			  width: 100%;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<!--banner-->
			<div class="banner">
				<div class="banner-img">
					<img style="height:4.20rem;width:100%" src="${SETTINGPD.IMAGEPATH}${dataModel.detail.scenic_logo}"/>
				</div>
				<div class="banner-box">
					<!--left-->
					<div class="list-left">
							<h2>${dataModel.detail.scenic_name}</h2>
							<!--icon-->
							<div class="left-box">
								<div class="icon1 icon" onclick="praise(this);">
									<img 
									<c:if test="${dataModel.isPraise}">
									src="/img/lydt_yizan@2x.png"
									</c:if>
									<c:if test="${!dataModel.isPraise}">
									src="/img/lydt_weizan@2x.png"
									</c:if>
									/>
									<span>${empty dataModel.praiseCount ? 0 : dataModel.praiseCount}</span>
								</div>
								<div class="icon2 icon" onclick="collect(this);">
									<img <c:if test="${dataModel.isCollect}">src="/img/yiguanzhu@2x.png"</c:if> 
									<c:if test="${!dataModel.isCollect}">src="/img/guanzhu@2x.png"</c:if>
									 />
									<span>${empty dataModel.collectCount ? 0 : dataModel.collectCount}</span>
								</div>
							</div>
						</div>
					<!--right-->
					<div class="right-box" onclick="window.location.href='/wx/scenic/navigation?lat=${dataModel.detail.scenic_lat}&lng=${dataModel.detail.scenic_lng}'">
						<div class="icon3">
							<img src="/img/weizou_dit.png"/>
						</div>
						<p>地图搜寻</p>
					</div>
				</div>
			</div>
			<!--text-box-->
			<div class="text-box1" style="font-size: 16px;">
				<h3>基本信息</h3>
				<p>${dataModel.detail.scenic_content}</p>
				<c:if test="${not empty dataModel.detail.scenic_phone}">
				   <p>电话：${dataModel.detail.scenic_phone}</p>
				</c:if>
				<c:if test="${not empty dataModel.detail.scenic_business_time}">
				   <p>营业时间：${dataModel.detail.scenic_business_time}</p>
				</c:if>
				<c:if test="${not empty dataModel.detail.scenic_tip}">
					<div class="tips-box">
						<p>Tips:</p>
						<p>${dataModel.detail.scenic_tip}</p>
					</div>
				</c:if>
			</div>
			<!--voice-->
			<c:if test="${not empty dataModel.detail.scenic_voice_path}">
			    <div class="voice-box">
				<h3>语音信息</h3>
				<div class="voice">
					<div id="palyer" data-code="0" data-time="${dataModel.detail.scenic_voice_hour}" class="voice-img">
						<img src="/img/weizou_voice.png"/>
					</div>
					<div class="jindu" id="jindu">
						<!-- <div class="circle" id="producePoint"></div> -->
					</div>
					<div class="jinduback" id="jinduProduce" style="width: 0.758941rem;" ></div>
					<span>${dataModel.detail.voice_hour}</span>
				</div>
				<!-- 音频播放 -->
				<audio id="voicePlay" style="visibility: hidden;" controls="controls" >
				  <source src="${SETTINGPD.IMAGEPATH}${dataModel.detail.scenic_voice_path}" type="audio/mpeg" />
				</audio>
			   </div>
			</c:if>
			<c:if test="${not empty dataModel.IMGS}">
				<div class="cant-box">
					<h3>餐厅图片</h3>
					<div class="cant">
						<div class="cant-img">
							<img style="height: 3.8rem;width: 100%" src="${SETTINGPD.IMAGEPATH}${dataModel.detail.scenic_logo}"/>
						</div>
						<ul class="img-list">
							<c:forEach items="${dataModel.IMGS}" var="item">
							<li>
								<img style="height: 3.8rem;width: 3.34rem" src="${SETTINGPD.IMAGEPATH}${item.img_path}"/>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>
			<!--游客评论-->
			 <c:if test="${not empty dataModel.comments}"> 
				<div class="pinl-box" id="commentBox">
				<div class="title-box" onclick="window.location.href='/wx/user/commentList?type=scenic_index&scenic_id=${dataModel.detail.id}'">
					<h3>游客评论</h3>
					<span>></span>
				</div>
				<ul class="pinl-list" style="font-size: 16px;" id = "pinl-list">
					<c:forEach items="${dataModel.comments}" var="item">
						  <li>
							<div class="li-con">
								<!--top-->
								<div class="list-top clearfix">
									<div class="pinl-img">
										<img src="${item.headimgurl}"/>
									</div>
									<div class="pinl-text">
										<p>${item.nick_name}</p>
										<p>${item.comment_time}</p>
									</div>
								</div>
								<p class="list-bottom">${item.scenic_comment_content}</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			 </c:if> 
		</div>
     <!--     <div style="height:0.9rem;">
		   <div class="pinl-fixed clearfix">
		      <div class="input">
		          <input id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="addComments();">
			      <p id="thumbsup" style="margin-top: 0.1rem;">评论</p>
			   </div>
		   </div>
		</div> -->
			<div style="height:0.9rem;">
		   <div class="pinl-fixed clearfix" style="border-top: 1px solid #454553;border-left: 0px;border-right: 0px;border-bottom: 0px;">
		      <div class="input">
		          <input style="float:left;" id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="addComments();" style="margin-right: 38px">
			      <p id="thumbsup" style="margin-top: 0.1rem;">评论</p>
			   </div>
		   </div>
		</div>
		<!-- 分享值 -->
		<div id="share_div" style="display: none;">
			<textarea id="shareLinkTimeLine">${share.shareLinkTimeLine}</textarea>
			<textarea id="shareLinkFriend">${share.shareLinkFriend}</textarea>
			<textarea id="descContent">${dataModel.detail.scenic_name}</textarea>
			<textarea id="shareTitle">${dataModel.detail.scenic_name}</textarea>
			<textarea id="coverImg">${SETTINGPD.IMAGEPATH}${dataModel.detail.scenic_logo}</textarea>
		</div>
		<%@ include file="common/wxapi.jsp" %>
	</body>
	<%@ include file="common/commJs.jsp"%>
	<script type="text/javascript">
	//发表评论
	   var submitFlag = false;
	   var praiseFlag = false; 
	   var collectFlag = false;
	   function addComments(){
		   if($("#comment_content").val().isEmpty()){
			   alert("请输入评论内容");
			   return;
		   }
		   if(!submitFlag){
			   submitFlag = true;
			   Ajax.request("/wx/scenic/addComment",{"data":{"comment_content":$("#comment_content").val(),"id":'${dataModel.id}'},"success":function(data){
				   submitFlag = false;
				   if(data.code != 200){
					   alert("服务器异常");
				   }else{
					   $("#comment_content").val("");
					   
					   if($("#commentBox").length  != 0){
						   var appendHtml = '<li><div class="li-con"><!--top--><div class="list-top clearfix"><div class="pinl-img"><img src="[comment_author_logo]"/>'
							   +'</div><div class="pinl-text"><p>[comment_author]</p><p>[comment_context_time]</p></div></div><p class="list-bottom">[comment_context]</p>'
							   +'</div></li>';
							   appendHtml=appendHtml.replace("[comment_author_logo]", data.data.comment_author_logo);
							   appendHtml=appendHtml.replace("[comment_author]", data.data.comment_author);
							   appendHtml=appendHtml.replace("[comment_context_time]", data.data.show_comment_time);
							   appendHtml=appendHtml.replace("[comment_context]", data.data.scenic_comment_content);
							   if($("#pinl-list").children().length > 0){
							      $("#pinl-list").children().eq(0).before(appendHtml);
							   }else{
								   $("#pinl-list").append(appendHtml);
							   }
					   }else{
						   window.location.reload();
					   }
				   }
			   }});
		   }
	   }
	   //点赞
	   function praise(thisObj){
		   if(!praiseFlag){
			   praiseFlag = true;
			   if("/img/lydt_weizan@2x.png" == $(thisObj).children().eq(0).attr("src")){
				   Ajax.request("/wx/scenic/praise",{"data":{"id":'${dataModel.id}'},"success":function(data){
					   praiseFlag = false;
					   if(data.code == 200){
						   $(thisObj).children().eq(0).attr("src","/img/lydt_yizan@2x.png");
						   $(thisObj).children().eq(1).text(parseInt($(thisObj).children().eq(1).text())+1);
					   }
				   }});
			   }
		   }
	   }
	   //收藏
	   function collect(thisObj){
		   if(!collectFlag){
			   collectFlag = true;
			   if("/img/guanzhu@2x.png" == $(thisObj).children().eq(0).attr("src")){
				   Ajax.request("/wx/scenic/collect",{"data":{"scenic_id":'${dataModel.id}'},"success":function(data){
					   praiseFlag = false;
					   if(data.code == 200){
						   $(thisObj).children().eq(0).attr("src","/img/yiguanzhu@2x.png");
						   $(thisObj).children().eq(1).text(parseInt($(thisObj).children().eq(1).text())+1);
					   }
				   }});
			   }
		   }
	   }
	   //控制播放
	   $(function(){
		   var dhplay,is_playFinish;
		   //获取进度条的长度
		   var progress = parseFloat($("#jindu").css("width"));
		   progress = progress / (parseFloat($("#palyer").attr("data-time")) * 2); //每秒前进的进度
		   $("#palyer").click(function(){
			   var palyer = $(this);
			   var playerControl = $("#voicePlay")[0];
			   if("1" == palyer.attr("data-code")){
				   palyer.attr("data-code","0");
				   playerControl.pause();
				   // 暂停的时候停止定时函数的执行
				   window.clearInterval(dhplay);
				   window.clearInterval(is_playFinish);
				   $('#palyer').children().eq(0).attr('src','/img/weizou_voice.png');
			   }else{
				   //播放
				   palyer.attr("data-code","1");
				   playerControl.play();
				 //检测是否播放完成 
				is_playFinish =  setInterval(function(){
					  /*   var left = parseFloat($("#producePoint").css("margin-left"));
					    $("#producePoint").css("margin-left",parseFloat(left)+progress); */
					    if(playerControl.currentTime != 0){
					    	var withPro = accAdd(parseFloat(document.getElementById('jinduProduce').style.width), progress);
					    	if(withPro <= 434){
					          $("#jinduProduce").css("width",withPro);
					    	}
					    }
					    //控制进度条往前走
			            if(playerControl.ended){
			            	playerControl.pause();
			            	palyer.attr("data-code","0");
			            	playerControl.currentTime = 0;
			            	/* $("#producePoint").css("margin-left","-5px"); */
			            	 $("#jinduProduce").css("width","0px");
			            	window.clearInterval(is_playFinish);
			            	window.clearInterval(dhplay);
			            }
	            }, 500);
				 //让播放有动画效果
				dhplay = setInterval(function(){
					 palyer.children().eq(0).attr("src",'/img/weizou_voice_player.png');
					 setTimeout("$('#palyer').children().eq(0).attr('src','/img/weizou_voice.png')", 500); 
				 },1000);
			   }
		   });
		   function accAdd(arg1,arg2){  
			    var r1,r2,m;  
			    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}  
			    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}  
			    m=Math.pow(10,Math.max(r1,r2))  
			    return (arg1*m+arg2*m)/m  
			}
	   });
	   
	   if('home' == '${pd.pageType}'){
	       GoBackBtn.excuteHistory("/wx/home");
	   }else{
		   GoBackBtn.excuteHistory("/wx/scenic/index?category_id=${pd.category_id}&pageType=${pd.pageType}");
	   }
	   
	</script>
</html>
