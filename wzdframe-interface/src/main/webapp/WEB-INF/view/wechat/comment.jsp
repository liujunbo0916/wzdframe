<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>评论列表</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/weizougk.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
		<style type="text/css">
		.cant-box{
				background: #fff;
				margin-top: 18px;
				padding: 30px;
			}
			.cant-box h3{
				font-size: 32px;
				color: #454553;
				margin-bottom: 30px;
			}
			.cant-img{
				width: 100%;
				margin-bottom: 22px;
			}
			.img-list{
				overflow: hidden;
			}
			.img-list li{
				float: left;
				width: 334px;
			}
			.img-list li:nth-child(even){
				float: right;
			}
			.tips-box{
				background: #fef8f0;
				border: 1px solid #fee4c4;
				padding: 25px 38px;
			}
			.jinduback{
			    height: 10px;
			    background:#ffdf4c;
			    float: left;
		        margin-top: 45px;
                margin-left: -435px;
			}
			.text-box1{
			    background: #fff;
			    color: #666666;
			    font-size: 18px;
			     padding: 10px; 
			    /* line-height: 3em; */
			    margin-top: 18px;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<!--游客评论-->
				<div class="pinl-box">
				<ul class="pinl-list">
					 <c:forEach items="${dataModel}" var="item">
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
		</div>
         <div style="height:90px;display: none;">
		   <div class="pinl-fixed clearfix">
		      <div class="input">
		          <input id="comment_content" type="text" placeholder="我有话说" />
		      </div>
		      <div class="fixed-img" onclick="addComments();" style="margin-right: 38px">
			      <p id="thumbsup" style="margin-top: 10px;">评论</p>
			   </div>
		   </div>
		</div>
	</body>
	<%@ include file="common/commJs.jsp"%>
	<script type="text/javascript">
	
	   var isSubmit = false;
	   var commentType = '${pd.type}';
	   function addComments(){
	    	if("scenic_line" == commentType){
	    		addComment();
	    	}
	    	if("scenic_index" == commentType){
	    		scenicComment();
	    	}
	    	if("news_detail" == commentType){
	    		newsComment();
	    	}
	    }
	   function  newsComment(){
		   alert('${pd.content_id}');
		   if(!isSubmit && $("#comment_content").val().isNotEmpty() && $("#comment_content").val().length < 50){
			   //评论
			   Ajax.request("/wx/news/comments",{"data":{"comment_context":$("#comment_content").val(),"CONTENT_ID":'${pd.content_id}'}
			   ,"success":function(data){
				   isSubmit = true;
				   if(data.code == 200){
					   window.location.reload();
				   }
			   }});
		   }
	   }
	   function scenicComment(){
		   if($("#comment_content").val().isEmpty()){
			   alert("请输入评论内容");
			   return;
		   }
		   if(!submitFlag){
			   submitFlag = true;
			   Ajax.request("/wx/scenic/addComment",{"data":{"comment_content":$("#comment_content").val(),"id":'${pd.scenic_id}'},"success":function(data){
				   submitFlag = false;
				   if(data.code != 200){
					   alert("服务器异常");
				   }else{
					   window.location.reload();
				   }
			   }});
		   }
	   }
  	    function addComment(){
  		  if($("#comment_content").val().isEmpty()){
  			  return;
  		  }
  		  if(!isSubmit){
  			     Ajax.request("/wx/line/addComment",{"data":{"line_id":'${pd.line_id}',"content":$("#comment_content").val()},
  			    	 "success":function(data){
  			         isSubmit = true;
  			    	 if(data.code == 200){
  			    		 $("#comment_content").val('');
  			    		 window.location.reload();
  			    	 }
  			     }});
  		  }
  	  }
	</script>
</html>
