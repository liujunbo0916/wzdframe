<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>我的反馈</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/wode-baoxiu.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div class="container">
			<!--内容-->
			<div class="con">
				<ul>
					<c:forEach items="${dataModel}" var="item">
					<li>
						<div class="clearfix">
								<!--left-->
							<div class="list-left">
								<img style="width:166px;height:140px;"  src="${SETTINGPD.IMAGEPATH}${item.first_img}"/>
							</div>
							<!--right-->
							<div class="list-right">
								<h2>${item.title}</h2>
								<p>${item.create_time}</p>
								<c:if test="${item.status || item.status eq 1}">
								   <span class="chul">未处理</span>
								</c:if>
								<c:if test="${item.status eq 2}">
								   <span class="chul">已处理</span>
								</c:if>
							</div>
						</div>
						<!--客服回复-->
						<c:if test="${item.status eq 2 && not empty item.replay}">
							<div class="report">
								${item.replay}
							</div>
						</c:if>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
</html>
