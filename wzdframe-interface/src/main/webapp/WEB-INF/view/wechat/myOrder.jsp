<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>预约订单</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/myOrder.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="container">
			<ul>
				<c:forEach items="${dataModel}" var="item">
					<li onclick="window.location.href='/wx/user/bookOrderDetail?id=${item.id}'">
						<div class="clearfix top">
							<p class="l">${item.create_time}</p>
							<p class="r color ">
							<c:if test="${empty item.guide_status || item.guide_status eq 1}">
								   待处理
								</c:if>
									<c:if test="${item.guide_status eq 2}">
								   已处理
								</c:if>
							</p>
						</div>
						<div class="bottom">
							<div class="bottom-box">
								<p>预约地点：</p>
								<p>${item.book_address}</p>
							</div>
							<div class="bottom-box ">
								<p>出行人数：</p>
								<p>${item.person_number}人</p>
							</div>
							<div class="bottom-box">
								<p>预约时间：</p>
								<p>${item.book_time}</p>
							</div>
						</div>
					</li>
				</c:forEach>
		        </ul>
		</div>
	</body>
	
	<script type="text/javascript">
	var GoBackBtn = {
			pushHistory : function() {
				var state = {
					title : "title",
					url : "#"
				};
				window.history.pushState(state, "title", "#");
			},
			excuteHistory : function(backUrl) {
				GoBackBtn.pushHistory();
				setTimeout(function() {
					window.addEventListener("popstate", function(e) {
						if(backUrl == "close"){
							WeixinJSBridge.call('closeWindow');
						}else{
							window.location.href = backUrl;
						}
					}, false);
				}, 300);
			}
		}
	 GoBackBtn.excuteHistory("/wx/duyun/user/center");
	</script>
</html>
