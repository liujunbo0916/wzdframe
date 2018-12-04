<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>旅游攻略</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/jingdianlx.css" rel="stylesheet"/>
		 <script src="/js/shipei.js"></script> 
	</head>
	<body>
		<div class="container">
			<ul>
				<c:forEach items="${dataModel}" var="item" varStatus="status">
				<c:set value="${status.index+1}" var="tempIndex"></c:set>
					<c:if test="${tempIndex < 10}">
					   <c:set value="${'0'+tempIndex}" var="indexS"></c:set>
					</c:if>
					<c:if test="${tempIndex <= 10}">
					   <c:set value="${tempIndex}" var="indexS"></c:set>
					</c:if>
					<li onclick="window.location.href='/wx/line/detail?line_id=${item.id}'" style="padding: .18rem .10rem;">
						<p class="title"><span>${indexS}</span>${item.line_name}</p>
						<div class="img-list">
							<img  src="${SETTINGPD.IMAGEPATH}${item.line_logo}"/>
						</div>
						<c:if test="${fn:length(item.line_lead) > 20}">
						     <p class="text">${fn:substring(item.line_lead,0,20)}${'...'}</p>
						</c:if>
						<c:if test="${fn:length(item.line_lead) <= 20}">
						      <p class="text">${item.line_lead}</p>
						</c:if>
					</li>
               </c:forEach>				
			</ul>
		</div>
	</body>
	
	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/Ajax.js"></script>
	<script type="text/javascript">
	//监听返回按钮
	if('home' == '${pd.pageType}'){
		GoBackBtn.excuteHistory("/wx/home");
	}else{
	    GoBackBtn.excuteHistory("close");
	}
	</script>
</html>
