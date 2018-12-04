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
<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>优惠劵</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add == 1 }">
								<a href="/sys/goods/coupon/edit" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/coupon/listPage" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>代金券名称</th>
											<th>代金券图片</th>
											<th>代金券面额</th>
											<th>发放总数</th>
											<th>代金券领取截止日期</th>
											<th>代金券有效期</th>
											<th>每人领取个数</th>
											<th>代金券描述</th>
											<th>最低消费金额</th>
											<th>领取人数</th>
											<th>代金卷状态</th>
											<th>创建时间</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.cash_name}</td>
														<td><img alt="" width="150px" height="80px"
															src="${SETTINGPD.IMAGEPATH}${item.cash_img}" /></td>
														<td>${item.cash_money}</td>
														<td>${item.cash_grant_num}</td>
															<td>${item.cash_endget_time}</td>
														<td>${item.cash_end_time}</td>
														<td>${item.cash_receive}</td>
														<td>${item.cash_desc}</td>
														<td>${item.cash_consumption_money}</td>
														<td>${item.cash_get_num}</td>
														<td><c:if
																test="${empty item.cash_status || item.cash_status==0}">
																<span class="badge badge-danger">已失效</span>
															</c:if> <c:if test="${item.cash_status==1}">
																<span class="badge badge-success">可用</span>
															</c:if> <c:if test="${item.cash_status==2}">
																<span class="badge badge-danger">已抢光</span>
															</c:if></td>
														<td>${item.create_time}</td>
														<td class="center" style="width: 200px;"><c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a href="/sys/goods/coupon/edit?id=${item.id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1}">
																<a href="/sys/goods/coupon/del?id=${item.id}"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
															</c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="12" class="center">没有相关数据</td>
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
	<script src="/assets/js/content.min.js"></script>
	<script>
		function del(id) {

		}
	</script>
</body>
</html>