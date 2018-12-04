<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>涠洲历史</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/weizouzj.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
		<style type="text/css">
		.list-box ul li {
			    padding: 10px 15px;
			    border-bottom: 1px solid #e0e0e0;
			    overflow: hidden;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<!--内容-->
			<div class="con">
				<ul>
					
					<c:forEach items="${albumModel}" var="item">
					<li>
						<p class="time">2017-4-12  18:00</p>
						<div class="list-box clearfix">
							<!--left-->
							<div class="list-left">
								<img src="/img/tesetj_list.png"/>
							</div>
							<!--right-->
							<div class="list-right">
								<h2>鳄鱼山</h2>
								<p>国家4A级旅游区</p>
							</div>
						</div>
					</li>
					</c:forEach>
					<li>
						<p class="time">2017-4-12  18:00</p>
						<div class="list-box clearfix">
							<!--left-->
							<div class="list-left">
								<img src="/img/tesetj_list.png"/>
							</div>
							<!--right-->
							<div class="list-right">
								<h2>鳄鱼山</h2>
								<p>国家4A级旅游区</p>
							</div>
						</div>
					</li>
					<li>
						<p class="time">2017-4-12  18:00</p>
						<div class="list-box clearfix">
							<!--left-->
							<div class="list-left">
								<img src="/img/tesetj_list.png"/>
							</div>
							<!--right-->
							<div class="list-right">
								<h2>鳄鱼山</h2>
								<p>国家4A级旅游区</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</body>
</html>
