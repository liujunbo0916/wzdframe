<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>视频播放</title>
		<link href="/css/reset.css " rel="stylesheet" />
		<link href="/css/shipingxs.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div class="container">
			<ul class="con-list">
				<c:forEach items="${albumModel}" var="item">
					<li onclick="player('${item.id}');">
						<div class="bg"></div>
						<div class="ship-img">
							<img src="/img/shipingbf.png"/>
						</div>
						<div>
							<img src="${SETTINGPD.IMAGEPATH}${item.resource_img}"/>
						</div>
						<div class="text-box">
							<p>${item.resource_title}</p>
							<div class="line"></div>
							<p>${item.resource_desc}</p>
						</div>
					</li>
				</c:forEach>
			</ul>
			
			
		</div>
	</body>
	<script type="text/javascript">
	     function player(id){
	    	 window.location.href='/wx/travel/resource/player?id='+id;
	     }
	</script>
	
	
</html>
