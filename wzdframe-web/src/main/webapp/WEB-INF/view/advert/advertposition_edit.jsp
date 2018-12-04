<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../common/top.jsp"%>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<form action="" name="apForm"
								id="apForm" method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty advplist}">
												<input type="hidden" name="ap_id" id="ap_id"
													value="${advplist.ap_id}" />
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告位置:</td>
													<td><input type="text" name="ap_name" id="ap_name"
														value="${advplist.ap_name}" maxlength="32"
														placeholder="输入广告位置" title="广告位置" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告描述:</td>
													<td><input type="text" name="ap_desc" id="ap_desc"
														value="${advplist.ap_desc}" maxlength="32"
														placeholder="输入广告描述" title="广告描述" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告价格:</td>
													<td><input type="number" name="ap_price" id="ap_price"
														maxlength="32" placeholder="输入价格"
														value="${advplist.ap_price}" title="价格"
														class="form-control" /></td>
												</tr>
												<tr>
													<td style="text-align: center;" colspan="10"><a
														class="btn btn-mini btn-primary" onclick="save(2)">编辑</a>
														<a class="btn btn-mini btn-danger"
														onclick="parent.location.reload();">取消</a></td>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告位置:</td>
													<td><input type="text" name="ap_name" id="ap_name"
														value="" maxlength="32"
														placeholder="输入广告位置" title="广告位置" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告描述:</td>
													<td><input type="text" name="ap_desc" id="ap_desc"
														value="" maxlength="32"
														placeholder="输入广告描述" title="广告描述" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">广告价格:</td>
													<td><input type="number" name="ap_price"
														id="ap_price" maxlength="32" placeholder="输入价格"
														value="" title="价格"
														class="form-control" /></td>
												</tr>
												<tr>
													<td style="text-align: center;" colspan="10"><a
														class="btn btn-mini btn-primary" onclick="save(1)">保存</a>
														<a class="btn btn-mini btn-danger"
														onclick="parent.location.reload();">取消</a></td>
												</tr>
											</c:otherwise>
										</c:choose>
									</table>
								</div>
							</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
</body>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name);
	function closed() {
		parent.layer.close(index);
	}

	function save(id) {
		if ($("#ap_name").val().isEmpty()) {
			bootbox.alert("广告位置必填");
			return;
		}
		if ($("#ap_desc").val().isEmpty()) {
			bootbox.alert("广告描述必填");
			return;
		}
		if ($("#ap_price").val().isEmpty()) {
			bootbox.alert("广告价格必填");
			return;
		}
		var data = $("#apForm").serialize();
		if (id == 1) {//保存
			Ajax.request("/sys/advert/addadvposition", {
				"data" : data,
				"success" : function(data) {
					if (data.result == 200) {
						parent.location.reload();
						closed();
					} else {
						bootbox.alert("保存失败！");
					}
				}
			});
		} else {
			//ajax  编辑
			Ajax.request("/sys/advert/updateadvposition", {
				"data" : data,
				"success" : function(data) {
					if (data.result == 200) {
						parent.location.reload();
						closed();
					} else {
						bootbox.alert("编辑失败！");
					}
				}
			});
		}
	}
</script>
</html>