
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>设置</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/wode-yhk-sz.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div id="wrapper">
			<div id="scroller">
				<!--正在加载中...-->
				<!--<div id="pullDown">
					<div class="pullDownLabel">正在加载中...</div>
				</div>-->
				<!--内容区域-->
				<div id="out">
					<div id="datalist">
						<ul class="content-list">
							<!--我发布的-->
							
						<li  class="clearfix">
								<!--左边-->
								<div class="icon-box l" style="margin-top: 6px;margin-left: 2px;">
									<span>${user.nick_name}</span>
								</div>
								<div class="r">
								   	<img class="headImg" style="width: 36px; height:35px;"  src="${empty user.headimgurl?'/img/wechat-photo.jpg':user.headimgurl}" />
								</div>
							</li>
						    <li  class="clearfix" onclick="window.location.href='/wx/duyun/user/changePhone?bindType=changePhone';">
								<!--左边-->
								<div class="icon-box l">
									<span>${user.phone}</span>
								</div>
								<div class="r">
									<i class="icon-right"></i>
								</div>
							</li>
							<li onclick="window.location.href='/wx/duyun/user/doaddressList'" class="clearfix">
								<!--左边-->
								<div class="icon-box l">
									<span>收货地址</span>
								</div>
								<div class="r">
									<i class="icon-right"></i>
								</div>
							</li>
							<!--我发布的-->
						</ul>
					</div>
				</div>
			</div>
		</div>
		  <%@ include file="common/commJs.jsp"%>
		  <script type="text/javascript">
		   //监听返回按钮
	        GoBackBtn.excuteHistory("/wx/duyun/user/center");
		  </script>
	</body>
</html>
