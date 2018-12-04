<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>预约订单</title>
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
						<li onclick="window.location.href='/wx/user/bookOrderDetail?id=${item.id}'">
							<div class="list-left" style="width:70%">
								<h2>${item.book_address}</h2>
								<p style="font-size:22px;margin-top:75px;">${item.person_number}人</p>
							</div>
							<div class="list-right" style="width:25%">
								<p style="margin-top:10px">${item.book_time}</p>
								<c:if test="${empty item.guide_status || item.guide_status eq 1}">
								   <p class="chul" style="color:#ffb200; position: relative;margin-left: 60px;">待处理</p>
								</c:if>
									<c:if test="${item.guide_status eq 2}">
								   <p class="chul" style="color:#ffb200; position: relative;margin-left: 60px;">已处理</p>
								</c:if>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
</html>
