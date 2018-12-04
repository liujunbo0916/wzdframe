<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>${details.TITLE}</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/zixun-del.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script> 
		<style>
		   .zaiyao{margin-top:0.3rem;padding-bottom:3%;  line-height:1.9em; margin-bottom:6%;background-color:#E5E5E5; padding:0.06rem}
		   .text-content{
					line-height: 1.6;
					font-family: Helvetica Neue ",Helvetica," Hiragino Sans GB "," Microsoft YaHei
						",Arial,sans-serif";
					color: #333333;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<!--text-box-->
			<div class="text-box">
				<h1 style="font-weight: bold;font-size: 0.42rem;">${details.TITLE}</h1>
				<p class="time" style="font-size: 0.27rem;    margin-top: 0.14rem;   color: #8c8c8c;">${fn:substring(details.PUTTIME,0,11)}</p>
				<c:if test="${not empty details.ABSTRACT}">
						<div class="zaiyao">
				        	<div style="    font-size: 0.28rem;width: 0.7rem;border: 1px solid #009FF0;float: left;text-align: center;margin-right: 0.14rem;color: #009FF0;line-height: 1.4em;">摘要</div>
				            <span class="news_content" style="font-size: 0.32rem;">${details.ABSTRACT}</span>
				        </div>	
	        </c:if>
				<div class="txt text-content">
					 ${details.CONTENT}
				</div>
				<div style="margin-bottom: 30px;color:#8c8c8c;">
				     <div style="float:left;font-size: 0.32rem; margin-right: 15px;"><span style="    margin-right: 5px;">阅读</span><span>${empty details.CLICKS?0:details.CLICKS}</span></div>
				     <div <c:if test="${empty details.is_thumbsup || details.is_thumbsup == 0}">onclick="dianzan(this,'${details.CONTENT_ID}');"</c:if>   style="float:left;font-size: 0.32rem;"><img style="float: left;margin-right: 3px;height: 15px; width: 15px; margin-top: 3px;"  <c:if test="${empty details.is_thumbsup || details.is_thumbsup == 0}">src="/img/lydt_weizan@2x.png"</c:if>  <c:if test="${details.is_thumbsup > 0}">src="/img/lydt_yizan@2x.png"</c:if>/><span>${empty details.thumbsup?0:details.thumbsup}</span></div>
				 </div>
			</div>
			<!--list-box-->
			<c:if test="${not empty  recommends}">
				<div class="list-box">
					<div class="border">
						<span>相关推荐</span>
					</div>
					<ul>
						<c:forEach items="${recommends}" var="item">
							<li onclick="window.location.href='/wx/news/detail?CONTENT_ID=${item.CONTENT_ID}'">
								<!--left-->
								<div class="list-left">
									<p>
									<c:if test="${fn:length(item.TITLE) > 27}">
									       ${fn:substring(item.TITLE,0,26)}${'...'}
									   </c:if>
										<c:if test="${fn:length(item.TITLE) <= 27}">
									       ${item.TITLE}
									   </c:if>
									
									</p>
									<!--icon-->
									<div class="left-box">
										<div class="icon1 icon">
											<img src="/img/lydt_weizan@2x.png"/>
											<span style="float: left;">${item.content_total_praise}</span>
										</div>
										<div class="icon2 icon">
											<img src="/img/lydt_liuyan@2x.png"/>
											<span style="float: left;">${item.content_total_comment}</span>
										</div>
									</div>
								</div>
								<!--right-->
								<div class="list-right" style="overflow: hidden;">
									<img onerror="javascript:this.src='/img/jzsb-wzsy.png';" src="${SETTINGPD.IMAGEPATH}${item.T_IMG}"/>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
			<!--游客评论-->
			<c:if test="${not empty comment}">
				<div class="pinl-box" id="commentBox">
					<div class="title-box" onclick="window.location.href='/wx/user/commentList?type=news_detail&content_id=${details.CONTENT_ID}'">
						<h3>游客评论</h3>
						<span>></span>
					</div>
					<ul class="pinl-list" id="pinl-list">
						<c:forEach items="${comment}" var="item">
							<li>
								<div class="li-con">
									<!--top-->
									<div class="list-top clearfix">
										<div class="pinl-img">
											<img src="${item.comment_author_logo}"/>
										</div>
										<div class="pinl-text">
											<p>${item.comment_author }</p>
											<p>${item.comment_context_time}</p>
										</div>
									</div>
									<p class="list-bottom">${item.comment_context}</p>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
		</div>
		<div style="height:0.9rem;">
		   <div class="pinl-fixed clearfix" style="border-top: 1px solid #454553;border-left: 0px;border-right: 0px;border-bottom: 0px;">
		      <div class="input">
		          <input style="float:left;" id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="ContentDetail.comments();" style="margin-right: 35px">
			      <p id="thumbsup" style="margin-top: 0.1rem;">评论</p>
			   </div>
		   </div>
		</div>
			<!-- 分享值 -->
		<div id="share_div" style="display: none;">
			<textarea id="shareLinkTimeLine">${share.shareLinkTimeLine}</textarea>
			<textarea id="shareLinkFriend">${share.shareLinkFriend}</textarea>
			<textarea id="descContent">${empty details.ABSTRACT ? details.TITLE:details.ABSTRACT}</textarea>
			<textarea id="shareTitle">${details.TITLE}</textarea>
			<textarea id="coverImg">${SETTINGPD.IMAGEPATH}${details.T_IMG}</textarea>
		</div>
		<%@ include file="common/wxapi.jsp" %>
	</body>
	<%@ include file="common/commJs.jsp" %>
	<script type="text/javascript">
	$('input').on('focus',function(event){      
        //自动反弹 输入法高度自适应
         var target = this;
         setTimeout(function(){
        	 document.body.scrollTop = document.body.scrollHeight;
         },100);
   });
	
	   var commentFlag = false;
	   var ContentDetail = {
			   thumbsup:function(){
				   //点赞
			   },
			   comments:function(){
				   if(!commentFlag && $("#comment_content").val().isNotEmpty() && $("#comment_content").val().length < 50){
					   commentFlag = true;
					   //评论
					   Ajax.request("/wx/news/comments",{"data":{"user_id":102,"comment_context":$("#comment_content").val(),"CONTENT_ID":'${details.CONTENT_ID}'}
					   ,"success":function(data){
						   $("#comment_content").val("");
						   commentFlag = false;
						   if(data.code == 200){
							   
							   if($("#commentBox").length != 0){
								   var appendHtml = '<li><div class="li-con"><!--top--><div class="list-top clearfix"><div class="pinl-img"><img src="[comment_author_logo]"/>'
									   +'</div><div class="pinl-text"><p>[comment_author]</p><p>[comment_context_time]</p></div></div><p class="list-bottom">[comment_context]</p>'
									   +'</div></li>';
									   appendHtml=appendHtml.replace("[comment_author_logo]", data.data.comment_author_logo);
									   appendHtml=appendHtml.replace("[comment_author]", data.data.comment_author);
									   appendHtml=appendHtml.replace("[comment_context_time]", data.data.show_time);
									   appendHtml=appendHtml.replace("[comment_context]", data.data.comment_context);
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
	   }
		function dianzan(thisObj, CONTENTID) {
			Ajax.request("/wx/news/thumbsup", {"data" : {"CONTENT_ID" : CONTENTID},
				"success" : function(data) {
					if (data.code == 200) {
						$(thisObj).children().eq(1).text(
								parseInt($(thisObj).children().eq(1).text()) + 1);
						$(thisObj).children().eq(0).attr("src",
								"/img/lydt_yizan@2x.png");
					}
				}
			});
		}
	   
	   
	</script>
</html>
