<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>订单填写</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/dingdan.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="container">
			<!--title-->
			<!--input-->
			<div class="inpt-box">
				<ul>
				
				    <li>
						<label>下单时间</label>
						<span>${dataModel.create_time}</span>
					</li>
					<li>
						<label>出行人数</label>
						<span>${dataModel.person_number}</span>
					</li>
					<li>
						<label>预约时间</label>
						<span>${dataModel.book_time}</span>
					</li>
					<li>
						<label>联系人</label>
						<span>${dataModel.con_name}</span>
					</li>
					<li>
						<label>联系手机</label>
						<span>${dataModel.con_phone}</span>
					</li>
					<li>
						<label>预约地点</label>
						<span>${dataModel.book_address}</span>
					</li>
					<li>
						<label>导游信息</label>
					     <span><c:if test='${empty dataModel.guider && empty dataModel.guider_id}'>未指定</c:if>
					     <c:if test='${not empty dataModel.guider && empty dataModel.guider_id}'>${dataModel.guider}</c:if>
					     <c:if test='${(not empty dataModel.guider_id && empty dataModel.guider) ||(not empty dataModel.guider_id && not empty dataModel.guider)}'>${dataModel.guider_name}   ${dataModel.guider_mobile}</c:if></span>
					</li>
				</ul>
			</div>
			<!--预约须知-->
			<div class="text-box">
				<h2>预约须知</h2>
				<%-- <div class="text">
					${bookKnow}
				</div> --%>
				<div class="text">
					<ul class="cautions-items">
						<li><span>费用包含：都匀景区讲解员服务；1.2米以下儿童免费1.2米以上儿童按1人计费；</span></li>
						<li><span>费用不含：不含任何景点门票，不含任何景点门票；</span></li>
						<li><span>行程时间：3小时；</span></li>
						<li><span>行程内容：景区讲解员推荐或游客DIY的行程。</span></li>
					</ul>
				</div>
			</div>
		</div>
	</body>
	  <%@ include file="common/commJs.jsp"%>
	  <script type="text/javascript">
	       GoBackBtn.excuteHistory("/wx/user/bookOrder");
	</script>
</html>
