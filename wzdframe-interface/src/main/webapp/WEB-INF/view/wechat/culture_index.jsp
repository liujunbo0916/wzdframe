<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>特色文化</title>
		<link href="/css/reset.css " rel="stylesheet" />
		<link href="/css/tesewh.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div class="container">
			<ul class="con-list">
			<c:forEach items="${dataModel}" var="item"> 	
				<li onclick="window.location.href='/wx/travel/resource/list?id=${item.id}'">
					<div>
						<img src="${SETTINGPD.IMAGEPATH}${item.culture_category_logo}"/>
					</div>
					<c:if test="${empty item.culture_category_color}">
					  <c:set value="FFFFFF" var="colorFont"></c:set>
					</c:if>
					<c:if test="${not empty item.culture_category_color}">
					  <c:set value="${item.culture_category_color}" var="colorFont"></c:set>
					</c:if>
					   <a style="border:1px solid #${colorFont}; color:#${colorFont};">${item.culture_category_name}</a>
				</li>
			</c:forEach>	
			</ul>
		</div>
	</body>
</html>
