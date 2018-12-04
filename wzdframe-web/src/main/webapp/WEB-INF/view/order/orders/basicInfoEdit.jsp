<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<form action="/sys/order/orders/save?logType=basicInfoEdit" >
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>基本信息</h5>
				</div>
				<div class="ibox-content">
					<div class="panel blank-panel">
					<input type="hidden" name="id" id="id" class="form-control" value="${dataModel.order_id}" required />
						<div>
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">赠送积分数量：</label>
									<div class="col-md-4">
										<input type="text" name="give_points" id="give_points"
											class="form-control" value="${dataModel.give_points}" />
									</div>
								</div></br> </br>
								<div class="form-group">
									<input type="hidden" value="basicInfoEdit" name="type">
									<label class="col-sm-2 control-label">操作备注：</label>
									<div class="col-md-4">
										<input type="text" name="auto_note" id="auto_note"
											class="form-control"  style="height: 50px;"/>
									</div>
								</div></br> 
								<div class="col-sm-4 col-sm-offset-3"> </br>
									<button class="btn btn-primary" type="submit" >
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
		</div>
	</form>

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/jquery.cxselect.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
</body>
</html>