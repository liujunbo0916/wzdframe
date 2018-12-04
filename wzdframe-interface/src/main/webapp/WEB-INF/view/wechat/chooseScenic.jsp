<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>景点列表</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/choose.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="container">
			<ul>
				<c:forEach items="${dataModel}" var="item">
					<li onclick="window.location.href='/wx/line/selfHelp?lat=${item.scenic_lat}&lng=${item.scenic_lng}'">
						<p class="l">${item.scenic_name}</p>
						<p class="r">
						${item.distance}
						<c:if test="${item.isKm}">km</c:if>
						</p>
					</li>
				</c:forEach>
			</ul>
		</div>
	</body>
	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/Ajax.js"></script>
	<script type="text/javascript">
	  GoBackBtn.excuteHistory("/wx/line/selfHelp");
	</script>
	
</html>
