<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>涠洲攻略</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/gonglue-del.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script> 
<style type="text/css">
		.pinl-fixed{
			width: 100%;
		    padding: 8px .3rem;
		    border: 1px solid #333;
		    position: fixed;
		    bottom: 0;
		    background-color: #fff;
		}
		.input{
			width: 6.04rem;
			height: .56rem;
			border-radius: 4px;
			float: left;
			overflow: hidden;
		}
		.input input{
			width: 100%;
			height: 100%;
			font-size: .26rem;
			background: #f5f5f5;
			text-indent: .15rem;
		}
		.fixed-img{
			float: right;
		}
		.fixed-img img{
			width: .26rem;
			text-align: center;
			margin: 0 auto;
		}
		.fixed-img p{
			font-size: .22rem;
			color: #666666;
		}
		.line-detail img{
		   width: 100%;
		}
</style>
</head>
<body>
		<div class="container">
			<!--banner-->
			<div class="banner">
				<div class="banner-img">
					<img style="height:4.2rem;" src="${SETTINGPD.IMAGEPATH}${Details.line_logo}"/>
				</div>
				<div class="banner-box">
					<!--left-->
					<div class="list-left">
							<h2>${Details.line_name}</h2>
							<!--icon-->
							<div class="left-box">
								<div class="icon1 icon"  <c:if test="${!praiseF}">onclick="praise('${Details.id}',this);"</c:if>>
									<c:if test="${praiseF}"><img src="/img/lydt_yizan@2x.png"/></c:if>
									<c:if test="${!praiseF}"><img src="/img/lydt_weizan@2x.png"/></c:if>
									<span id="praiseCount">420</span>
									</div>
								<div class="icon2 icon">
									<img src="/img/lydt_liuyan@2x.png"/>
									<span id="commentCount">342</span>
								</div>
							</div>
						</div>
				</div>
			</div>
			<div class="text-box">
				<h3>导语</h3>
				<p style="    margin-top: 10px;">
					${Details.line_lead}
				</p>
			</div>
			<!--ul-->
			<div class="line-detail">
				<ul>
				<c:forEach items="${dataModel}" var="item" varStatus="status">
					<c:set value="${status.index+1}" var="tempIndex"></c:set>
					<c:if test="${tempIndex < 10}">
					   <c:set value="${'0'+tempIndex}" var="indexS"></c:set>
					</c:if>
					<c:if test="${tempIndex <= 10}">
					   <c:set value="${tempIndex}" var="indexS"></c:set>
					</c:if>
					<li>
						<div class="text-box">
							<h4>TOP ${indexS}：${item.scenic_name}</h4>
							<div class="text-img">
								<img src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"/>
							</div>
							<p>
								${item.scenic_desc}
							</p>
							<c:if test="${not empty item.scenic_tip }">
								<div class="tips-box">
									<p>Tips:</p>
									<p>${item.scenic_tip}</p>
								</div>
							</c:if>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
			<!--游客-->
			<div class="pinl-box" id="commentBox">
				<div class="title-box" onclick="window.location.href='/wx/user/commentList?type=scenic_line&line_id=${Details.id}'">
					<h3>游客评论</h3>
					<span>></span>
				</div>
				<ul class="pinl-list" id="commentAppend">
				</ul>
			</div>
		</div>
<!-- 	<div style="height:.9rem;">
		   <div class="pinl-fixed clearfix">
		      <div class="input">
		          <input id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="addComment();">
			      <p id="thumbsup" style="margin-top: 10px;">评论</p>
			   </div>
		   </div>
		</div> -->
			<div style="height:0.9rem;">
		   <div class="pinl-fixed clearfix" style="border-top: 1px solid #454553;border-left: 0px;border-right: 0px;border-bottom: 0px;">
		      <div class="input">
		          <input style="float:left;" id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="addComment();">
			      <p id="thumbsup" style="margin-top: 0.1rem;">评论</p>
			   </div>
		   </div>
		</div>
					<!-- 分享值 -->
		<div id="share_div" style="display: none;">
			<textarea id="shareLinkTimeLine">${share.shareLinkTimeLine}</textarea>
			<textarea id="shareLinkFriend">${share.shareLinkFriend}</textarea>
			<textarea id="descContent">${Details.line_lead}</textarea>
			<textarea id="shareTitle">${Details.line_name}</textarea>
			<textarea id="coverImg">${SETTINGPD.IMAGEPATH}${Details.line_logo}</textarea>
		</div>
		<%@ include file="common/wxapi.jsp" %>
	</body>
	 <%@ include file="common/commJs.jsp"%>
	 <script type="text/javascript">
	 $('input').on('focus',function(event){      
	        //自动反弹 输入法高度自适应
	         var target = this;
	         setTimeout(function(){
	        	 document.body.scrollTop = document.body.scrollHeight;
	         },100);
	   });
	     requestComment();
	     var imgUrl = '${SETTINGPD.IMAGEPATH}';
	    	  //拉取最新的评论信息
	     function requestComment(){
		     Ajax.request("/wx/line/ajaxGetComment",{"data":{"line_id":'${Details.id}'},"success":function(data){
		    	 if(data.code == 200){
		    		 var comments = data.data.comments;
		    		 var praiseCount = data.data.praiseCount || 0;
		    		 var commentCount = data.data.commentCount || 0;
		    		 $("#praiseCount").text(praiseCount);
		    		 $("#commentCount").text(commentCount);
		    		 if(comments.length > 0){
		    			 $("#commentBox").show();
		    			 $("#commentAppend").empty();
		    			 for(var i = 0 ; i < comments.length; i++){
		    				 if(comments[i].nick_name.isEmpty()){
		    					 comments[i].nick_name='无昵称';
		    				 }
		    				 $("#commentAppend").append('<li><div class="li-con"><div class="list-top clearfix"><div class="pinl-img"><img src="'+comments[i].headimgurl+'"/></div><div class="pinl-text"><p>'+comments[i].nick_name+'</p><p>'+comments[i].create_time+'</p></div></div><p class="list-bottom">'+comments[i].content+'</p></div></li>');
		    			 }
		    		 }else{
		    			 $("#commentBox").hide();
		    		 }
		    	 }
		     }});
	     }
    	  var isSubmit = false;
    	  function addComment(){
    		  if($("#comment_content").val().isEmpty()){
    			  return;
    		  }
    		  if(!isSubmit){
    			  isSubmit = true;
    			  Ajax.request("/wx/line/addComment",{"data":{"line_id":'${Details.id}',"content":$("#comment_content").val()},
    			    "success":function(data){
    			   	isSubmit = false;
    			    if(data.code == 200){
    			    	$("#comment_content").val('');
    			    	requestComment();
    			    }
    			 }});
    		  }
    	  }
    	  var praiseFlag = false;
    	  function praise(line_id,thisObj){
    		  if($(thisObj).children().eq(0).attr("src")== "/img/lydt_yizan@2x.png"){
    			  //如果已点赞   
    			  return;
    		  }
    		  if(!praiseFlag){
    			  Ajax.request("/wx/line/praise",{"data":{"line_id":line_id},
 			    	 "success":function(data){
 			    	 praiseFlag = true;
 			    	 if(data.code == 200){
 			    		$(thisObj).children().eq(0).attr("src","/img/lydt_yizan@2x.png");
 			    		$(thisObj).children().eq(1).text(parseInt($(thisObj).children().eq(1).text())+1);
 			    	 }
 			     }});
    		  }
    	  }
    	//监听返回按钮
    		if('homeDetail' == '${pd.pageType}'){
    			GoBackBtn.excuteHistory("/wx/home");
    		}else{
    		    GoBackBtn.excuteHistory("/wx/line/index?pageType=${pd.pageType}");
    		}
	 </script>
</html>
