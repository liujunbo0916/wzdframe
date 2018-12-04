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
								<div class="col-sm-12">
									<table id="simple-table"
										class="center table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty dataModel}">
												<thead>
													<tr>
														<th></th>
											<th>票务系统识别码</th>
											<th>景点名字</th>
											<th>票类名称</th>
											<th>类型</th>
											<th>起售价格</th>
											<th>单票/套票</th>
													</tr>
												</thead>
												<tbody>
													<!-- 开始循环 -->
													<c:forEach items="${dataModel}" var="item">
														<tr>
															<td><input type="radio"
																<c:if test="${item.id == SUBJECT_ID}">
								                        checked
								                      </c:if>
																name="SUBJECT_ID" id="SUBJECT_ID"
																value="${item.id}"></td>
														<td>${item.third_no}</td>
														<td>${item.scenic_name}</td>
														<td>${item.ticket_name}</td>
														<td>${item.cate_name}</td>
														<td>${item.ticket_price}</td>
														<td><c:if test="${item.ticket_package_type eq 1}">
																<span class="label label-primary">单票</span>
															</c:if> <c:if test="${item.ticket_package_type eq 2}">
																<span class="label label-danger">套票</span>
															</c:if></td>
														</tr>
													</c:forEach>
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
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="12" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
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
				bootbox.alert("请选择关联普通旅游门票");
				return;
			}
			var course_id = $("input[name='SUBJECT_ID']:checked").val();
			parent.pullTicketData(course_id);
			closed();
		}
	</script>
</body>
</html>