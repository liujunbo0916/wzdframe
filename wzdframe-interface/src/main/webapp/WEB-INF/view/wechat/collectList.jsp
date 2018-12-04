<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>关注列表</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/tesetj.css" rel="stylesheet"/>
		<link href="/css/shib.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="container">
			<!--导航-->
				<!-- 无数据显示 -->
			 <c:if test="${empty category}">
				<div class="imgs">
					<img src="/img/meiyoushuju@2x.png"/>
					<p>暂时没有数据</p>
				</div>
			 </c:if>
	<c:if test="${not empty category}">
			<div class="nav">
				<ul id="navicate">
					<c:forEach items="${category}" var="item">
						<li  <c:if test="${pd.category_id eq item.id}">class="select"</c:if> data-id="${item.id}" ><a>${item.scenic_category}</a></li>
					</c:forEach>
				</ul>
			</div>
			<!--内容-->
			<div class="con">
				<ul>
					<c:forEach items="${contentList}" var="item">
						<li onclick="window.location.href='/wx/scenic/detail?id=${item.id}'">
							<!--left-->
							<div class="list-left">
								<img src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"/>
							</div>
							<!--right-->
							<div class="list-right">
								<h2>
								    <c:if test="${fn:length(item.scenic_name) > 10}">
									    <c:set value="${fn:substring(item.scenic_name,0,9)}${'...'}" var="scenic_name"></c:set>
									</c:if>
									 <c:if test="${fn:length(item.scenic_name) <= 10}">
									    <c:set value="${item.scenic_name}" var="scenic_name"></c:set>
									</c:if>
                                    ${scenic_name}								
								</h2>
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
						</li>
					</c:forEach>
				</ul>
				<c:if test="${empty contentList}">
				  <div class="imgs">
					<img src="/img/meiyoushuju@2x.png"/>
					<p>暂时没有数据</p>
				</div>
				</c:if>
			</div>
			</c:if>
		</div>
	</body>
	<script src="/js/jquery-1.7.2.js"></script>
	<script type="text/javascript">
	   $("#navicate").children().click(function(){
		   var categoryId = $(this).attr('data-id');
		   window.location.href='/wx/scenic/collectList?category_id='+categoryId;
	   });
	</script>
</html>
