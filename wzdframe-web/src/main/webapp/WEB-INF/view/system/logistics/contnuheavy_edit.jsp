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
							<form action="logistics/savecontnuheavy" name="contnuheavyForm"
								id="contnuheavyForm" method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty contnuheavy}">
											<input type="hidden" name="contnu_id" id="contnu_id"
													value="${contnuheavy.contnu_id}" />
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">区域选择:</td>
													<td id="juese"><select
														class="chosen-select form-control" name="area_id"
														id="area_id" data-placeholder="请选择区域"
														style="vertical-align: top;" class="form-control">
															<c:forEach items="${arealist}" var="area">
																<option value="${area.area_id}"
																	<c:if test="${area.area_id eq contnuheavy.area_id}"> selected="selected" </c:if> >${area.area_name}</option>
															</c:forEach>
													</select></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">续重公斤数(KG):</td>
													<td><input type="text" name="contnu_kg" id="contnu_kg"
														value="${contnuheavy.contnu_kg}" maxlength="32"
														placeholder="输入续重公斤数" title="续重公斤数" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">价格(元):</td>
													<td><input type="text" name="contnu_price"
														id="contnu_price" maxlength="32" placeholder="输入价格"
														value="${contnuheavy.contnu_price}" title="价格"
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
														style="width: 79px; text-align: right; padding-top: 13px;">区域选择:</td>
													<td id="juese"><select
														class="chosen-select form-control" name="area_id"
														id="area_id" data-placeholder="请选择区域"
														style="vertical-align: top;" class="form-control">
															<c:forEach items="${arealist}" var="area">
																<option value="${area.area_id}" >${area.area_name}</option>
															</c:forEach>
													</select></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">续重公斤数(KG):</td>
													<td><input type="text" name="contnu_kg" id="contnu_kg"
														maxlength="32" placeholder="输入续重公斤数" title="续重公斤数"
														class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">价格(元):</td>
													<td><input type="text" name="contnu_price"
														id="contnu_price" maxlength="32" placeholder="输入价格"
														title="价格" class="form-control" /></td>
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
		if ($("#contnu_kg").val().isEmpty()) {
			bootbox.alert("续重公斤数必填");
			return;
		}
		if ($("#contnu_price").val().isEmpty()) {
			bootbox.alert("续重公斤价格必填");
			return;
		}
		var data = $("#contnuheavyForm").serialize();
		if (id == 1) {//保存
			Ajax.request("/logistics/savecontnuheavy", {
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
			//alert($("#province_id").val())
			//ajax  编辑
			Ajax.request("/logistics/updateContnuheavy", {
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
		/* 	
			$("#areas").val(data);
			//submit form
			$("#userForm").submit(); */
	}
</script>
</html>