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
<%@ include file="../../common/top.jsp"%>
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
							<form action="" name="appSmsTplForm" id="appSmsTplForm"
								method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty smsTpl}">
												<input type="hidden" name="id" id="id"
													value="${smsTpl.id}" />
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">短信模板标题:</td>
													<td><input type="text" name="tpl_title" id="tpl_title"
														value="${smsTpl.tpl_title}" maxlength="32"
														placeholder="输入短信模板标题" title="短信模板标题" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">短信模板内容:</td>
													<td><textarea placeholder="输入短信模板内容" name="tpl_content"
															id="tpl_content" title="短信模板内容" rows="5" class="form-control">${smsTpl.tpl_content}</textarea>

													</td>
												</tr>
												<tr>
													<td
														style="width: 100px; text-align: right; padding-top: 13px;">短信模板示例:</td>
													<td>
														您的验证码是参数1。请不要把验证码泄露给其他人。如非本人操作，可不用理会！
														<br>
														（参数1：替换的平台参数，参数可多个存在，以参数1，参数2...形式存在）
													</td>
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
														style="width: 100px; text-align: right; padding-top: 13px;">短信模板标题:</td>
													<td><input type="text" name="tpl_title" id="tpl_title"
														maxlength="32"
														placeholder="输入短信模板标题" title="短信模板标题" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 100px; text-align: right; padding-top: 13px;">短信模板内容:</td>
													<td><textarea placeholder="输入短信模板内容" name="tpl_content"
															id="tpl_content" title="短信模板内容" rows="5" class="form-control"></textarea>

													</td>
												</tr>
												<tr>
													<td
														style="width: 100px; text-align: right; padding-top: 13px;">短信模板示例:</td>
													<td>
														您的验证码是参数1。请不要把验证码泄露给其他人。如非本人操作，可不用理会！
														<br>
														（参数1：替换的平台参数，参数可多个存在，一参数1，参数2...形式存在）
													</td>
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
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
</body>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name);
	function closed() {
		parent.layer.close(index);
	}

	function save(id) {
		if ($("#tpl_title").val().isEmpty()) {
			bootbox.alert("短信模板标题必填");
			return;
		}
		if ($("#tpl_content").val().isEmpty()) {
			bootbox.alert("短信模板内容必填");
			return;
		}
		var data = $("#appSmsTplForm").serialize();
		if (id == 1) {//保存
			Ajax.request("/cfg/insertSmsTpl", {
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
			Ajax.request("/cfg/updateSmsTpl", {
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