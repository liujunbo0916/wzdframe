<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>${dataModel.culture_category_name}</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/tesetj.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script> 
			<style type="text/css">
	.con ul li {
		    margin-left: .2rem;
		    padding: .1rem .2rem 2px 0;
		    overflow: hidden;
		    border-bottom: 1px solid #e0e0e0;
		}
		</style>
		
	</head>
	<body>
		<div class="container">
			<!--内容-->
			<div class="con">
				<ul>
					<c:forEach items="${albumModel}" var="item">
						<li onclick="window.location.href='/wx/news/detail?CONTENT_ID=${item.CONTENT_ID}&type=1'">
							<!--left-->
							<div class="list-left">
								<img style="width:2.26rem;height:1.66rem; " src="${SETTINGPD.IMAGEPATH}${item.T_IMG}"/>
							</div>
							<!--right-->
							<div class="list-right">
							 <c:if test="${fn:length(item.TITLE)>12 }">
							    <c:set value="${fn:substring(item.TITLE,0,11)}${'...'}" var="TITLE"></c:set>
							 </c:if>
							 <c:if test="${fn:length(item.TITLE) <= 12}">
							    <c:set value="${item.TITLE}" var="TITLE"></c:set>
							</c:if>
							
							 <c:if test="${fn:length(item.ABSTRACT) > 17 }">
							    <c:set value="${fn:substring(item.ABSTRACT,0,16)}${'...'}" var="ABSTRACT"></c:set>
							 </c:if>
							 <c:if test="${fn:length(item.ABSTRACT) <= 17}">
							    <c:set value="${item.ABSTRACT}" var="ABSTRACT"></c:set>
							</c:if>
								<h2>${TITLE}</h2>
								<p>${ABSTRACT}</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
</html>
