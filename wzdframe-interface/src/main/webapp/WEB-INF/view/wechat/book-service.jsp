<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>预定服务</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/gr-center.css" rel="stylesheet" />
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div id="wrapper">
			<ul class="content-list">
				<li class="clearfix" onclick="window.location.href='/wx/user/guideService'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_daoyou"></i>
						<span>导游服务</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
				<li class="clearfix" onclick="window.location.href='http://www.laiu8.cn/phone/ship'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_quanpiao"></i>
						<span>船票预订</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
				<li class="clearfix" onclick="window.location.href='http://pay.weizhouisland.com.cn:7171/main'">
					<!--左边-->
					<div class="icon-box l">
						<i class="icon icon_menpiao"></i>
						<span>门票预定</span>
					</div>
					<div class="r">
						<i class="icon-right"></i>
					</div>
				</li>
			</ul>
		</div>
	</body>

</html>