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
<%@ include file="../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
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
							出游人
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/grouptour/travelerssavePage" method="post"
							class="form-horizontal m-t" id="commentForm">

							<input type="hidden" name="travelers_id" id="travelers_id"
								value="${dataModel.travelers_id}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">出游人姓名：</label>
								<div class="col-sm-8">
									<input type="text" name="travelers_name" id="travelers_name"
										class="form-control" value="${dataModel.travelers_name}"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">出游人电话：</label>
								<div class="col-sm-8">
									<input type="text" name="travelers_phone" id="travelers_phone"
										class="form-control" value="${dataModel.travelers_phone}"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">证件类型：</label>
								<div class="col-sm-2" id="appendCategory">
									<select name="travelers_type" id="travelers_type"
										class="form-control">
										<option value="1"
											<c:if test="${dataModel.travelers_type eq 1}"> selected ='selected'</c:if>>身份证</option>
										<option value="2"
											<c:if test="${dataModel.travelers_type eq 2}"> selected ='selected'</c:if>>护照</option>
										<option value="3"
											<c:if test="${dataModel.travelers_type eq 3}"> selected ='selected'</c:if>>军官证</option>
										<option value="4"
											<c:if test="${dataModel.travelers_type eq 4}"> selected ='selected'</c:if>>驾驶证</option>
										<option value="5"
											<c:if test="${dataModel.travelers_type eq 5}"> selected ='selected'</c:if>>学生证</option>
										<option value="6"
											<c:if test="${dataModel.travelers_type eq 6}"> selected ='selected'</c:if>>回乡证</option>
										<option value="7"
											<c:if test="${dataModel.travelers_type eq 7}"> selected ='selected'</c:if>>港澳通行证</option>
										<option value="8"
											<c:if test="${dataModel.travelers_type eq 8}"> selected ='selected'</c:if>>台湾通行证</option>
										<option value="9"
											<c:if test="${dataModel.travelers_type eq 9}"> selected ='selected'</c:if>>其他</option>

									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">证件号码：</label>
								<div class="col-sm-3">
									<input type="text" name="travelers_no" id="travelers_no"
										class="form-control" value="${dataModel.travelers_no}"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
								<div class="col-sm-8">
									<label class="radio-inline"> <input type="radio"
										<c:if test="${dataModel.travelers_gender eq '1'}">checked='checked'</c:if>
										value="1" name="travelers_gender">男
									</label> <label class="radio-inline"> <input type="radio"
										value="0"
										<c:if test="${empty dataModel.travelers_gender || dataModel.travelers_gender eq '0'}">checked='checked'</c:if>
										name="travelers_gender">女
									</label>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button"
										onclick="valication()">
										<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
									</button>
									<button class="btn btn-warning" onclick="history.go(-1)">
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
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript">
		function valication() {
			if ($("#travelers_name").val().isEmpty()) {
				bootbox.alert("出游人姓名不能为空");
				return false;
			}
			if ($("#travelers_name").val().length > 10) {
				bootbox.alert("出游人姓名应该在10个字符以内");
				return false;
			}
			if ($("#travelers_type").val() == null
					|| $("#travelers_type").val() == '') {
				bootbox.alert("请选择证件类型");
				return false;
			}
			if ($("#travelers_no").val().isEmpty()) {
				bootbox.alert("证件号码不能为空");
				return false;
			}
			$("#commentForm").submit();
		}
	</script>
</body>
</html>