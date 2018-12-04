<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
</head>

<body class="gray-bg">
	<form action="/sys/order/orders/save?type=refundFinish" method="post"
		class="form-horizontal" id="commentForm"><input type="hidden" name="id" value="${order_id}">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>退货操作</h5>
				</div>
				<div class="ibox-content">
					<div class="panel blank-panel">
						<div>
							<div class="panel-body">
								退款：<input type="text" name="" id="pay_by_points"
									class="form-control" value="" required /> 回收积分：<input
									type="text" name="" id="pay_by_points"
									class="form-control" value="" required /> 操作备注：<input
									type="text" name="action_note" id="auto_note"
									class="form-control" value="" required />
							</div>
							<div class="col-sm-4 col-sm-offset-3">
								<button class="btn btn-primary" type="submit">
									<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
								</button>
								<button class="btn btn-warning" onclick="history.go(-1)">
									<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
</body>
</html>