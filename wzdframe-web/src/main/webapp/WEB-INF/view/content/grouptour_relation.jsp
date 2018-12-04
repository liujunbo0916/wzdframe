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
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form action="" method="post"
							class="form-horizontal m-t" id="commentForm">
							<div class="form-group">
								<label class=" control-label"><font color="red"
									size="3px" style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品列表：</label>
							</div>
							<!-- 开始循环 -->
							<div class="form-group">
								<div class="col-sm-12">
									<table id="simple-table"
										class="center table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th></th>
											<th>线路名称</th>
											<th>线路图片</th>
											<th>线路价格</th>
											<th>联系电话</th>
											<th>游览天数</th>
											<th>线路销量</th>
											</tr>
										</thead>
										<tbody>
											<!-- 开始循环 -->
											<c:choose>
												<c:when test="${not empty dataModel}">
													<c:forEach items="${dataModel}" var="item">
														<tr>
															<td><input type="radio"
																<c:if test="${item.grouptour_id == SUBJECT_ID}">
								                        checked
								                      </c:if>
																name="SUBJECT_ID" id="SUBJECT_ID"
																value="${item.grouptour_id}"></td>
															<td>${item.grouptour_name}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${item.grouptour_img}"></td>
														<td>${item.grouptour_price}</td>
														<td>${item.grouptour_phone}</td>
														<td>${item.grouptour_day}</td>
														<td>${item.grouptour_sales}</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr class="main_info">
														<td colspan="7" class="center">没有相关数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="12">
													<div
														class="dataTables_paginate paging_bootstrap pull-right">
														${page.pageStr}</div>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
							<c:if test="${not empty dataModel}">
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3" style="margin-top: 20px">
									<button class="btn btn-primary" type="button" onclick="sub();">
										<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
									</button>
									<button class="btn btn-warning" onclick="closed();">
										<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
									</button>
								</div>
							</div>
							</c:if>
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
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		var index = parent.layer.getFrameIndex(window.name);
		function closed() {
			parent.layer.close(index);
		}
		function sub() {
			if ($(":radio:checked").length == 0) {
				bootbox.alert("请选择关联跟团游线路");
				return;
			}
			var SUBJECT_ID = $("input[name='SUBJECT_ID']:checked").val();
			parent.pullGroupTourData(SUBJECT_ID);
			closed();
		}
	</script>
</body>
</html>