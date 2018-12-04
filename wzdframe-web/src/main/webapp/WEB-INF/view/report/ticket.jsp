<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
</head>
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>票务报表</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/report/ticket/list" method="post"
							name="Form" id="Form">
							<div class="row">
								<div class="search-condition row">
									<div class="col-md-12">
										<div class="col-md-1">
											<div class="input-group">
												<input type="text" placeholder="订单开始时间"
													class="form-control date"
													style="width: 180px; cursor: pointer; background-color: #fff;"
													name="start_create_time" id="startDate" readonly="readonly"
													value='<fmt:formatDate value="${pd.start_create_time}" pattern="yyyy-MM-dd"/>'>
											</div>
										</div>
										<div class="col-md-2">
											<div class="input-group">
												<input type="text" placeholder="订单结束时间"
													class="form-control date"
													style="width: 180px; cursor: pointer; background-color: #fff;"
													name="end_create_time" id="endDate" readonly="readonly"
													value='<fmt:formatDate value="${pd.end_create_time}" pattern="yyyy-MM-dd"/>'>
											</div>
										</div>
										<div class="col-md-1">
											<div class="input-group">
												<button class="btn btn-primary" type="submit">
													<i class="fa fa-search"></i>&nbsp;查询&nbsp;
												</button>
											</div>
										</div>
										<div class="col-md-2">
											<div class="input-group">
												<h5 style="margin-top: 10px;">本次统计总金额 ${totalMoney} 元</h5>
											</div>
										</div>
									</div>
								</div>
								<div class="hr-line-dashed" style="margin: 10px 0;"></div>
								<div class="project-list">
									<table id="simple-table"
										class="center table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>订单号</th>
												<th>订单金额（元）</th>
												<th>应付金额（元）</th>
												<th>下单人信息</th>
												<th>订单状态</th>
												<th>下单时间</th>
											</tr>
										</thead>
										<tbody>
											<!-- 开始循环 -->
											<c:choose>
												<c:when test="${not empty ticketList}">
													<c:forEach items="${ticketList}" var="item">
														<tr>
															<td>${item.orderNo}</td>
															<td>${item.orderMoney}</td>
															<td>${item.settlementPrice}</td>
															<td>
																<p>下单人姓名：${item.contactName}</p>
																<p>下单人手机号：${item.contactMobile}</p>
																<p>景点名称：${item.scenicName}</p>
																<p>票类信息：${item.ticketName}   ${item.cateName}</p>
															</td>
															<td> 已使用</td>
															<td>${item.createTime}</td>
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
													<div
														class="dataTables_paginate paging_bootstrap pull-right">
														${page.pageStr}</div>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<script type="text/javascript">
		$.jeDate("#startDate", {
			format : "YYYY-MM-DD",
			isTime : true
		});
		$.jeDate("#endDate", {
			format : "YYYY-MM-DD",
			isTime : true
		});

		/* function delOrder(orderId) {
			bootbox.confirm("确定删除该订单吗？", function(result) {
				if (result) {
					Ajax.request("/sys/order/orders/delete", {
						"data" : {
							"order_id" : order_id
						},
						"success" : function(data) {
							if (data.result == 200) {
								window.location.reload();
							} else {
								bootbox.alert(data.msg);
							}
						}
					});
				}
			});
		} */
	</script>
</body>
</html>