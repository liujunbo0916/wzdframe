<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>个人中心</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/gr-center.css" rel="stylesheet" />
		<script src="/js/phone.js"></script>
	</head>

	<body>
		<div id="wrapper">
			<ul class="content-list">
				<li class="clearfix" onclick="window.location.href='/wx/user/fotoplace'">
					<!--左边-->
					<div class="icon-box l" >
						<i class="icon icon_zuji"></i>
						<span>涠洲足迹</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
		<!-- 		<li class="clearfix">
					左边
					<div class="icon-box l">
						<i class="icon icon_gr"></i>
						<span>个人信息</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li> -->
				<li class="clearfix" onclick="window.location.href='/wx/scenic/collectList'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_gz"></i>
						<span>我的关注</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
				<li class="clearfix" onclick="window.location.href='/wx/user/feedbackList'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_fz"></i>
						<span>我的反馈</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
				<li class="clearfix" onclick="window.location.href='/wx/user/bookOrder'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_bx"></i>
						<span>我的预约</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
				<li class="clearfix" onclick="window.location.href='/wx/user/aboutUs'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_about"></i>
						<span>关于我们</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
			</ul>
		</div>
	</body>

</html>