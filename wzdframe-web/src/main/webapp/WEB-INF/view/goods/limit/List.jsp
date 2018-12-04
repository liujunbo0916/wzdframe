<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>限时折扣活动列表</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add == 1}">
								<a href="/sys/activity/discount/edit"
									class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;添加活动</a>
							</c:if>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/activity/discount/list" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<c:if test="${not empty dataModel}">
											<tr>
												<th>活动名字</th>
												<th>活动标题</th>
												<th>活动开始时间</th>
												<th>结束时间</th>
												<th>创建时间</th>
												<th>状态</th>
												<th class="center" style="width: 85px">操作</th>
											</tr>
										</c:if>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.activity_code}</td>
														<td>${item.timelimit_title}</td>
														<td>${item.timelimit_start_time}</td>
														<td>${item.timelimit_end_time}</td>
														<td>${item.create_time}</td>
														<td><c:if test="${item.status eq 0}">
																<span class="badge badge-danger">关闭</span>
															</c:if> <c:if test="${item.status eq 1}">
																<span class="badge badge-info">开启</span>
															</c:if></td>
														<td class="center" style="width: 300px;">
															<button type="button"
																onclick="javascript:window.location.href='/sys/activity/discount/edit?id=${item.id}'"
																class="btn btn-primary btn-sm">编辑</button>
															<c:if test="${item.status eq 1}">
															<button type="button"
																onclick="javascript:window.location.href='/sys/activity/discount/prolist?id=${item.id}'"
																class="btn btn-primary btn-sm">管理</button>
															<button type="button" class="btn btn-warning btn-sm"
																onclick="deleteactivity('${item.id}')">删除</button></c:if>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="16" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="12">
												<div class="dataTables_paginate paging_bootstrap pull-right">
													${page.pageStr}</div>
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
</body>
<script type="text/javascript">
	function deleteactivity(id) {
		bootbox.confirm("你确定删除该活动吗!", function(result) {
			if (result) {
				window.location.href = "/sys/activity/discount/doDel?id=" + id;
			}
		});
	}
</script>
</html>