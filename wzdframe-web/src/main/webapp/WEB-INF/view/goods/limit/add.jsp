<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
<style type="text/css">
.file-pick {
	font-size: 18px;
	background: #00b7ee;
	border-radius: 3px;
	line-height: 44px;
	padding: 0 30px;
	color: #fff;
	display: inline-block;
	margin: 0 auto 20px auto;
	cursor: pointer;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							<c:if test="${not empty dataModel}">编辑</c:if>
							<c:if test="${empty dataModel}">新增</c:if>
							商品折扣活动
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/activity/discount/doEdit" method="post"
							class="form-horizontal" id="limitactivity" name="limitactivity"
							enctype="form-data">
							<input id="id" name="id" type="hidden" value="${dataModel.id}">
							<div class="form-group">
								<label class="col-sm-2 control-label"><font color="red"
									size="3px" style="font-weight: bold; font-style: italic;">*&nbsp;</font>活动名称：</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="activity_code"
										name="activity_code" value="${dataModel.activity_code}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动标题：</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="timelimit_title"
										name="timelimit_title" value="${dataModel.timelimit_title}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动开始时间：</label>
								<div class="col-sm-2">
									<div class="input-group">
										<input type="text" class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="timelimit_start_time" id="startDate"
											readonly="readonly"
											value="${dataModel.timelimit_start_time}">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动结束时间：</label>
								<div class="col-sm-2">
									<div class="input-group">
										<input type="text" class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="timelimit_end_time" id="endgetDate" readonly="readonly"
											value="${dataModel.timelimit_end_time}">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动状态：</label>
								<div class="col-sm-2">
									<select name="status" id="status" class="form-control">
										<option value="0"
											<c:if test="${empty dataModel.status || dataModel.status eq 0}">selected ='selected'</c:if>>关闭</option>
											<option value="1"
											<c:if test="${not empty dataModel.status && dataModel.status eq 1}">selected ='selected'</c:if>>开启</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button"
										onclick="submitInfo()">
										<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
									</button>
									<button class="btn btn-warning" type="button"
										onclick="history.go(-1)">
										<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="/statics/js/user/Category.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/vendor/parsley/parsleygoods.min.js"></script>
	<script src="/statics/js/page/editProduct.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.all.min.js">
		
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<script src="/assets/css/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/css/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		$.jeDate("#startDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		});
		$.jeDate("#endgetDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		});

		function submitInfo() {
			if (!$("#activity_code").val()) {
				alert("活动名字不能为空");
				return false;
			}
			if (!$("#startDate").val()) {
				alert("活动开始时间不能为空");
				return false;
			}
			if (!$("#endgetDate").val()) {
				alert("活动结束时间不能为空");
				return false;
			}
			$("#limitactivity").submit();
		}
	</script>
</body>

</html>