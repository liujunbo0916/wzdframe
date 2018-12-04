<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
							<form action="logistics/savearea" name="lgssForm" id="lgssForm"
								method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty areadata}">
												<input type="hidden" name="area_id" id="province_id"
													value="${areadata.area_id}" />
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">区域名称:</td>
													<td><input type="text" name="area_name" id="area_name"
														value="${areadata.area_name}" maxlength="32"
														placeholder="这里输入区域名称" title="区域名称" class="form-control"
														onblur="User.hasExist({'id':'loginname','msg':'区域名称已经存在','oldValue':'${pd.USERNAME}'});" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">省份选择:</td>
													<td id="juese">
														<div class="form-group draggable ui-draggable dropped"
															style="position: static;">
															<div class="col-sm-9">
																<c:forEach items="${plist}" var="pd">
																	<c:set value="0" var="flag"></c:set>
																	<c:forEach items="${areadata.provinces}" var="psd">
																		<c:if test="${psd eq pd.region_id}">
																			<c:set value="1" var="flag"></c:set>
																		</c:if>
																	</c:forEach>
																	<label class="checkbox-inline"> <input
																		type="checkbox" name="province_id"
																		<c:if test="${flag eq 1}">
																		     checked="checked"
																		</c:if>
																		value="${pd.region_id}" id="inlineCheckbox1">${pd.region_name}</label>
																</c:forEach>
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">首重(KG):</td>
													<td><input type="text" name="first_kg" id="first_kg"
														maxlength="32" placeholder="输入首重" title="首重" value="${areadata.first_kg}"
														class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">首重价格(KG):</td>
													<td><input type="text" name="first_price"
														id="first_price" maxlength="32" placeholder="输入首重价格" value="${areadata.first_price}"
														title="首重价格" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">送达天数(KG):</td>
													<td><input type="text" name="send_time" id="send_time"
														maxlength="32" placeholder="输入送达天数" title="送达天数" value="${areadata.send_time}"
														class="form-control" /></td>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">区域名称:</td>
													<td><input type="hidden" value="" id="areas"
														name="areas" /> <input type="text" name="area_name"
														id="area_name" value="${areadata.area_name}" maxlength="32"
														placeholder="这里输入区域名称" title="区域名称" class="form-control"
														onblur="User.hasExist({'id':'loginname','msg':'区域名称已经存在','oldValue':'${pd.USERNAME}'});" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">省份选择:</td>
													<td id="juese">
														<div class="form-group draggable ui-draggable dropped"
															style="position: static;">
															<div class="col-sm-9">
																<c:forEach items="${plist}" var="pd">
																	<label class="checkbox-inline"> <input
																		type="checkbox" name="province_id"
																		<c:if test="${fn:contains(areadata.province_id,pd.region_id)}"> checked="checked" </c:if>
																		value="${pd.region_id}" id="inlineCheckbox1">${pd.region_name}</label>
																</c:forEach>
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">首重(KG):</td>
													<td><input type="text" name="first_kg" id="first_kg"
														maxlength="32" placeholder="输入首重" title="首重"
														class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">首重价格(KG):</td>
													<td><input type="text" name="first_price"
														id="first_price" maxlength="32" placeholder="输入首重价格"
														title="首重价格" class="form-control" /></td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">送达天数(KG):</td>
													<td><input type="text" name="send_time" id="send_time"
														maxlength="32" placeholder="输入送达天数" title="送达天数"
														class="form-control" /></td>
												</tr>
											</c:otherwise>
										</c:choose>
										<tr>
											<td style="text-align: center;" colspan="10"><c:if
													test="${ not empty areadata.area_id}">
													<a class="btn btn-mini btn-primary" onclick="checkyse(2)">编辑</a>
												</c:if> <c:if test="${empty areadata.area_id}">
													<a class="btn btn-mini btn-primary" onclick="checkyse(1)">保存</a>
												</c:if> <a class="btn btn-mini btn-danger" onclick="closed();">取消</a></td>
										</tr>
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

	function checkyse(id) {
		/* 		//checkbox   redio
		 var checkedValue = $("input[name='pId']:checked").each(function(){
		 data.push($(this).val());
		 });
		 data = data.join(",");
		 */
		if ($("#area_name").val().isEmpty()) {
			bootbox.alert("区域名字必填");
			return;
		}
		var data = $("#lgssForm").serialize();
		
		if (id == 1) {
			//ajax
			Ajax.request("/logistics/savearea", {
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
			//ajax

			Ajax.request("/logistics/updatearea", {
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