<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>报修</title>
<link href="/css/reset.css " rel="stylesheet" />
<link href="/css/baoxiu.css" rel="stylesheet" />
<script src="/js/phone.js"></script>
<style type="text/css">
.add-img {
	width: 150px;
	margin-right: 15px;
}
.sumbit {
	position: fixed;
	bottom: 0;
	width: 100%;
	height: 98px;
	line-height: 98px;
	background: #ffb200;
	font-size: 38px;
	color: #ffffff;
	text-align: center;
}
</style>

</head>
<body style="background: #fff;">
	<div class="container">
		<div class="inpt">
			<input type="text" id="title" placeholder="标题" />
		</div>
		<!-- <div class="inpt">
			<input type="text" placeholder="位置" />
		</div> -->
		<div class="inpt-box">
			<textarea placeholder="请描述需要维修的状态..." id="content"></textarea>
			<span>500</span>
		</div>
		<div class="add clearfix">
			<div class="add-icon" id="addImgs">
				<img src="/img/baoxiu_add.png" />
			</div>
		</div>
	</div>
	<a class="sumbit" id="sub">提交订单</a>
</body>
<%@ include file="common/commJs.jsp"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
	var images = {
		serverIds : [],
		localIds:[]
	}
	var isSubmit = false;
	wx.config({
		debug : false,
		appId : '${share.shareTicket.appId}',
		timestamp : '${share.shareTicket.timestamp}',
		nonceStr : '${share.shareTicket.nonceStr}',
		signature : '${share.shareTicket.signature}',
		jsApiList : [ 'chooseImage', 'uploadImage' ]
	});
	wx.ready(function() {
				$("#addImgs").click(function() {
									wx.chooseImage({
												count : 3,//默认9  
												sizeType : [ 'original',
														'compressed' ],//可以指定是原图还是压缩图，默认二者都有  
												sourceType : [ 'album',
														'camera' ],//可以指定来源是相册还是相机，默认二者都有  
												success : function(res) {
													var localIds = res.localIds;//返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片  
													images.localIds = res.localIds;
													for (var i = 0; i < localIds.length; i++) {
														$("#addImgs")
																.before(
																		"<div class='add-img'><img  style='width:150px;height:140px;' src='"+localIds[i]+"'/><span class='delete' data-code='"+i+"' onclick='deleteImg(this)'><img src='/img/quxiao.png'/></img></span></div>");
													}
													var i = 0,length = images.localIds.length;  
													function upload(){
														wx.uploadImage({
															localId : images.localIds[i], //需要上传的图片的本地ID，由chooseImage接口获得
															isShowProgressTips : 1, // 默认为1，显示进度提示
															success : function(res) {
																i++;
																images.serverIds.push(res.serverId);
																if (i < length) {  
									                                upload();  
								                                 } 
															}
														});
													}
													upload();
												},
											});
				});
	});
	$("#sub").click(function(){
		if($("#title").val().isEmpty()){
			alert("请输入标题");
			return;
		}
		if($("#content").val().isEmpty()){
			alert("请输入内容");
			return;
		}
		if(!isSubmit){
			Ajax.request("/wx/user/addFeedback",{"data":{"serverIds":images.serverIds.join(","),"title":$("#title").val(),"content":$("#content").val()},
				"success":function(data){
					isSubmit = true;
					if(data.code == 200){
						window.location.href="/wx/user/feedbackList";
					}
			}});
		}
	});
	function deleteImg(thisObj){
		//得到img对象 
		var localId = $(thisObj).prev().attr("src");
		var index =$(thisObj).attr("data-code");
		images.serverIds.splice(index,1);
		alert(images.serverIds);
		$(thisObj).parent().remove();
	}
</script>
</html>
