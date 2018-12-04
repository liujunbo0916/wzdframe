<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>系统日志</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/log/list" method="post" name="Form" id="Form">
							<div class="search-condition row">
								<div class="col-sm-2">
									<div class="input-group">
										<span class="input-group-addon">日志内容</span> <input type="text"
											class="form-control" name="log_content" id="log_content"
											value="${requestScope.page.pd.log_content}" />
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">用户名</span> <input type="text"
											class="form-control" name="log_seller_name"
											id="log_seller_name"
											value="${requestScope.page.pd.log_seller_name}" />
									</div>
								</div>
								<%-- 		<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">操作者ip</span> <input
											type="text" class="form-control" name="log_seller_ip"
											id="log_seller_ip"
											value="${requestScope.page.pd.log_seller_ip }" />
									</div>
								</div> --%>

								<div class="col-md-5">
									<div class="form-group">
										<div class="input-group">
											<span class="input-group-addon">操作时间</span>
											<div class="input-group">
												<span class="input-group-addon"><i
													class="fa fa-calendar"></i></span> <input type="text"
													class="form-control date"
													style="width: 180px; cursor: pointer; background-color: #fff;"
													name="startTime" id="startTime" readonly="readonly"
													value="${requestScope.page.pd.startTime}">
												<div class="input-group" style="float: left;">
													<span class="input-group-addon" style="height: 34px;">到</span>
												</div>
												<span class="input-group-addon"><i
													class="fa fa-calendar"></i></span> <input type="text"
													class="form-control date"
													style="width: 180px; cursor: pointer; background-color: #fff;"
													name="endTime" id="endTime" readonly="readonly"
													value="${requestScope.page.pd.endTime}">
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-1">
									<div class="input-group">
										<button class="btn btn-primary" type="submit"
											id="query_button_id">
											<i class="fa fa-search"></i>&nbsp;查询&nbsp;
										</button>
									</div>
								</div>
							</div>
							<div class="hr-line-dashed" style="margin: 20px 0;"></div>
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>日志内容</th>
											<th>操作者用户名</th>
											<th>URI</th>
											<th>是否异常</th>
											<th>操作者ip</th>
											<th>操作时间</th>
											<th>失败异常</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty data}">
												<c:forEach items="${data}" var="item">
													<tr>
														<td>${item.log_content}</td>
														<td>${item.log_seller_name}</td>
														<td>${item.log_url}</td>
														<td><c:if test="${item.log_state == 1}">
																<span class="label badge-info">成功</span>
															</c:if> <c:if test="${item.log_state == 0}">
																<span class="label badge-danger">异常</span>
															</c:if></td>
														<td>${item.log_seller_ip}</td>
														<td>${item.log_time}</td>
														<td><c:if test="${item.log_state eq 0}">
																<a href="/sys/log/exceptionlist?log_id=${item.log_id}"
																	class="btn btn-primary btn-sm" title="失败信息"> <i
																	class="fa fa-newspaper-o"></i>
																</a>
															</c:if></td>
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
											<td colspan="8">
												<div class="dataTables_paginate paging_bootstrap pull-right">
													${requestScope.page.pageStr}</div>
											</td>
										</tr>
									</tfoot>
								</table>
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
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
	<script type="text/javascript">
		$.jeDate("#startTime", {
			format : "YYYY-MM-DD 00:00:00",
			isTime : true
		//isClear:false,
		});
		$.jeDate("#endTime", {
			format : "YYYY-MM-DD 23:59:59",
			isTime : true
		//isClear:false,
		});
	</script>
</body>
</html>