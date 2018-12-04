<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>足迹</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/weizouzj.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div class="container">
			<!--内容-->
			<div class="con">
				<ul>
					<c:forEach items="${dataModel}" var="item">
							  <li>
								<p class="time">${item.visit_time}</p>
								<div class="list-box clearfix">
									<!--left-->
									<div class="list-left">
										<img src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"/>
										<span class="go">已去过</span>
									</div>
									<!--right-->
									<div class="list-right">
									      <c:if test="${fn:length(item.scenic_name) > 10}">
									    <c:set value="${fn:substring(item.scenic_name,0,9)}${'...'}" var="scenic_name"></c:set>
										</c:if>
										 <c:if test="${fn:length(item.scenic_name) <= 10}">
										    <c:set value="${item.scenic_name}" var="scenic_name"></c:set>
										</c:if>
									
										<h2>${scenic_name}</h2>
											<c:if test="${not empty item.scenic_desc}">
												<p>
													 <c:if test="${fn:length(item.scenic_desc) > 14}">
													    <c:set value="${fn:substring(item.scenic_desc,0,13)}${'...'}" var="scenic_desc"></c:set>
													</c:if>
													 <c:if test="${fn:length(item.scenic_desc) <= 14}">
													    <c:set value="${item.scenic_desc}" var="scenic_desc"></c:set>
													</c:if>
													${scenic_desc}
												</p>
												</c:if>
									</div>
								</div>
							</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
</html>
