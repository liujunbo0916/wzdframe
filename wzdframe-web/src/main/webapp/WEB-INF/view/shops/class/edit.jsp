<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<link href="/statics/css/phone.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<form action="/sys/shops/class/save" method="post"
				class="form-horizontal m-t" id="commentForm">
				<div class="col-sm-13">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								<c:if test="${not empty dataModel}">编辑</c:if>
								<c:if test="${empty dataModel}">新增</c:if>
								商铺分类信息
							</h5>
						</div>
						<div class="ibox-content">
							<input type="hidden" name="sc_id" value="${dataModel.sc_id}" />

							<div class="tab-content">
								<div class="panel-body">
									<div class="form-group">
										<label class="col-sm-3 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>分类名称：</label>
										<div class="col-sm-3">
											<input type="text" id="sc_name" name="sc_name"
												class="form-control" value="${dataModel.sc_name}" required />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>保证金数额（元）：</label>
										<div class="col-sm-3">
											<input type="text" id="sc_bail" name="sc_bail"
												class="form-control" value="${dataModel.sc_bail}" required />
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-3 control-label">排序：</label>
										<div class="col-sm-3">
											<input type="text" id="sc_sort" name="sc_sort"
												class="form-control" value="${dataModel.sc_sort}" required />
										</div>
										<label class="col-sm-3 control-label"
											style="text-align: left;">数字范围为0~255，数字越小越靠前</label>
									</div>
									<div class="form-group">
										<div class="col-sm-8 col-sm-offset-5">
											<button class="btn btn-primary" type="button" onclick="sub()">
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
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/statics/js/uedit/";
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.all.min.js">
		
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		var submitFlag = false;
		function sub() {
			if ($("#sc_name").val().isEmpty()) {
				bootbox.alert("分类名称不能为空");
				return;
			}
			if (!$("#sc_bail").val()) {
				bootbox.alert("保证金不能为空");
				return false;
			}
			if (!$("#sc_bail").val().isMoney()) {
				bootbox.alert("保证金--请输入正确的金额格式");
				return false;
			}
			if ($("#sc_bail").val() > 99999999) {
				bootbox.alert("保证金最大值为99999999");
				return false;
			}
			if (!$("#sc_sort").val().isNumber() || $("#sc_sort").val() < 0) {
				bootbox.alert("排序值必须为正整数");
				return false;
			}
			if (submitFlag) {
				return;
			}
			submitFlag = true;
			Ajax.request("/sys/shops/class/save", {
				"data" : $("#commentForm").serialize(),
				"success" : function(data) {
					if (data.result == 200) {
						window.location.href = "/sys/shops/class/list";
					} else {
						submitFlag = false;
						bootbox.alert(data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>