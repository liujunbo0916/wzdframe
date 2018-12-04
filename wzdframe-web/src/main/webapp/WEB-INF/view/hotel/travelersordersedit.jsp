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
<style type="text/css">
.file-pick {
	font-size: 18px;
	background: #00b7ee;
	border-radius: 3px;
	line-height: 44px;
	padding: 0 30px;
	color: #fff;
	display: inline-block;
	margin: 0 auto 20px auto;
	cursor: pointer;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}

.btns-al {
	left: 120px;
}

.sanks-lab {
	text-align: left;
	width: 22%;
}

.sank-lab {
	text-align: right;
	width: 28%;
}

.sank-lab span {
	font-weight: 900;
}

.sank {
	width: 100%;
}

table {
	border-collapse: separate;
	border-spacing: 3px;
}
</style>
</head>

<body class="gray-bg">
	<form action="/sys/order/orders/save" method="post"
		class="form-horizontal" id="commentForm">
		<input type="hidden" name="order_id" id="order_id" 
			value="${dataModel.order_id}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>基本信息</h5>
						</div>
						<div class="ibox-content">

							<table class="table table-bordered">
								<thead>
									<tr>
										<th>订单号</th>
										<th>下单人</th>
										<th>订单状态</th>
										<th>下单时间</th>
										<th>支付方式</th>
										<th>支付状态</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${dataModel.order_sn}</td>
										<td>${dataModel.user_name}</td>
										<td><c:if test="${empty dataModel.order_state}">
												<span class="label">待付款</span>
											</c:if> <c:if test="${dataModel.order_state==0}">
												<span class="label label-success">待使用</span>
											</c:if> <c:if test="${dataModel.order_state==1}">
												<span class="label label-danger">已使用</span>
											</c:if></td>
										<td>${dataModel.create_time}</td>
										<td><c:if test="${dataModel.pay_type == 0}">
												<span class="label">微信</span>
											</c:if> <c:if test="${dataModel.pay_type == 1}">
												<span class="label">支付宝</span>
											</c:if> <c:if test="${dataModel.pay_type == 2}">
												<span class="label">余额支付</span>
											</c:if> <c:if test="${dataModel.pay_type == 3}">
												<span class="label">公众号支付</span>
											</c:if> <c:if test="${dataModel.pay_type ==4}">
												<span class="label">银联支付</span>
											</c:if> <c:if test="${empty dataModel.pay_type}">
												<span class="label">订单尚未支付</span>
											</c:if></td>
										<td><c:if
												test="${empty dataModel.pay_status || dataModel.pay_status eq 0}">
												<span class="label label-warning">待付款</span>
											</c:if> <c:if test="${dataModel.pay_status eq 1}">
												<span class="label label-success">已付款</span>
											</c:if> <c:if test="${dataModel.pay_status eq 2}">
												<span class="label label-success">已取消</span>
											</c:if> <c:if test="${dataModel.pay_status eq 3}">
												<span class="label label-success">已退款</span>
											</c:if> <c:if test="${dataModel.pay_status eq 4}">
												<span class="label label-success">退款中</span>
											</c:if></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>联系人信息</h5>
							<div class="ibox-tools">
								<c:if
									test="${(dataModel.shipping_status eq 0 ||dataModel.shipping_status eq 2||dataModel.shipping_status eq 3)&&(dataModel.order_status eq 0 || dataModel.order_status eq 3 || dataModel.order_status eq 2)}">
									<a
										href="/sys/order/orders/edit?id=${dataModel.order_id}&type=personInfoEdit"
										class="btn btn-primary btn-xs">&nbsp;编辑</a>
								</c:if>
							</div>
						</div>
						<div class="ibox-content">
							<div>
								<table class="table table-bordered" style="border-spacing: 0px;">
									<thead>
										<tr>
											<th>联系人姓名</th>
											<th>联系手机</th>
											<th>用户备注</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>${dataModel.link_perple}</td>
											<td>${dataModel.link_phone}</td>
											<td><c:choose>
													<c:when test="${empty dataModel.link_remark}">
														<span class="label">空</span>
													</c:when>
													<c:otherwise>${dataModel.link_remark}</c:otherwise>
												</c:choose></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty adults}">
					<div class="col-sm-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>成人出行人信息</h5>
							</div>
							<div class="ibox-content">
								<table class="table table-bordered" style="border-spacing: 0px;">
									<thead>
										<tr>
											<th>出行人姓名</th>
											<th>出行人电话</th>
											<th>证件类型</th>
											<th>证件号码</th>
											<th>性别</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${adults}" var="item">
											<tr>
												<td>${item.travelers_name}</td>
												<td>${item.travelers_phone}</td>
												<td><c:if test="${item.travelers_type eq 1}">身份证</c:if>
													<c:if test="${item.travelers_type eq 2}">护照</c:if> <c:if
														test="${item.travelers_type eq 3}">军官证</c:if> <c:if
														test="${item.travelers_type eq 4}">驾驶证</c:if> <c:if
														test="${item.travelers_type eq 5}">学生证</c:if> <c:if
														test="${item.travelers_type eq 6}">回乡证</c:if> <c:if
														test="${item.travelers_type eq 7}">港澳通行证</c:if> <c:if
														test="${item.travelers_type eq 8}">台湾通行证</c:if> <c:if
														test="${item.travelers_type eq 9}">其他</c:if></td>
												<td>${item.travelers_no}</td>
												<td><c:if test="${item.travelers_gender eq 0}">女</c:if>
													<c:if test="${item.travelers_gender eq 1}">男</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty childrens}">
					<div class="col-sm-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>儿童出行人信息</h5>
							</div>
							<div class="ibox-content">
								<table class="table table-bordered" style="border-spacing: 0px;">
									<thead>
										<tr>
											<th>出行人姓名</th>
											<th>出行人电话</th>
											<th>证件类型</th>
											<th>证件号码</th>
											<th>性别</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${childrens}" var="item">
											<tr>
												<td>${item.travelers_name}</td>
												<td>${item.travelers_phone}</td>
												<td><c:if test="${item.travelers_type eq 1}">身份证</c:if>
													<c:if test="${item.travelers_type eq 2}">护照</c:if> <c:if
														test="${item.travelers_type eq 3}">军官证</c:if> <c:if
														test="${item.travelers_type eq 4}">驾驶证</c:if> <c:if
														test="${item.travelers_type eq 5}">学生证</c:if> <c:if
														test="${item.travelers_type eq 6}">回乡证</c:if> <c:if
														test="${item.travelers_type eq 7}">港澳通行证</c:if> <c:if
														test="${item.travelers_type eq 8}">台湾通行证</c:if> <c:if
														test="${item.travelers_type eq 9}">其他</c:if></td>
												<td>${item.travelers_no}</td>
												<td><c:if test="${item.travelers_gender eq 0}">女</c:if>
													<c:if test="${item.travelers_gender eq 1}">男</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>费用信息</h5>
							<div class="ibox-tools">
								 <c:if
									test="${empty dataModel.pay_status || dataModel.pay_status eq 0 && empty dataModel.order_state}">
									<input type="button" onclick="javascript:state('pay_price');"
															class="btn btn-primary btn-xs " value="编辑">
								</c:if> 
							</div>
						</div>
						<div class="ibox-content">
							<div class="panel blank-panel">
								<div>
									<table class="table table-bordered"
										style="border-spacing: 0px;">
										<tbody>
											<tr>
												<td><strong>用户：</strong></td>
												<td>费用总额：${dataModel.total_price}</td>
												<td>待支付金额: <input id="pay_price"  name="pay_price" value="${dataModel.pay_price}"/></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>操作信息</h5>
					</div>
					<div class="ibox-content">
						<div class="panel blank-panel">
							<div>
								<div class="panel-body">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><div align="right">
														<strong>操作备注：</strong>
													</div></td>
												<td colspan="5"><textarea id="action_note"
														name="action_note" cols="80" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>
													<div align="right"></div>
													<div align="right">
														<strong>当前可执行操作：</strong>
													</div>
												</td>
												<td colspan="5">
													<c:if
														test="${dataModel.pay_status eq 0 && empty dataModel.order_state}">
														<input type="button" onclick="javascript:state('pay');"
															class="btn btn-primary btn-xs " value="设为已付款">
													</c:if> 
													<c:if
														test="${dataModel.pay_status eq 1 && dataModel.order_state eq 0}">
														<input type="button" onclick="javascript:state('nopay');"
															class="btn btn-primary btn-xs " value="设为未付款">
													</c:if> 
													<c:if
														test="${dataModel.pay_status eq 1 && dataModel.order_state eq 1}">
														<input type="button" onclick="javascript:state('nouser');"
															class="btn btn-primary btn-xs " value="设为未使用">
													</c:if> 
														<c:if
														test="${dataModel.pay_status eq 1 && (not empty dataModel.order_state && dataModel.order_state eq 0 )}">
														<input type="button" onclick="javascript:state('user');"
															class="btn btn-primary btn-xs " value="设为已使用">
													</c:if> 
													 <c:if
														test="${dataModel.pay_status != 1 && (not empty dataModel.order_state && dataModel.order_state eq 0 )}">
														<input type="button" class="btn btn-primary btn-xs "
															onclick="javascript:state('cancel');" value="&nbsp;设为已取消">
														<input type="button" class="btn btn-primary btn-xs "
															onclick="javascript:state('backing');" value="&nbsp;设为退款中">
														<input type="button" class="btn btn-primary btn-xs "
															onclick="javascript:state('back');" value="&nbsp;设为已退款">
													</c:if>
													</td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>操作者：</strong>
													</div></td>
												<td><div align="center">
														<strong>操作时间</strong>
													</div></td>
												<td><div align="center">
														<strong>订单状态</strong>
													</div></td>
												<td><div align="center">
														<strong>付款状态</strong>
													</div></td>
												<td><div align="center">
														<strong>操作人员备注</strong>
													</div></td>
												<td><div align="center">
														<strong>系统备注</strong>
													</div></td>
											</tr>
											<c:forEach items="${loglist}" var="item">
												<tr>
													<td><div align="center">${item.creator}</div></td>
													<td><div align="center">${item.create_time}</div></td>
													<td><div align="center">
															<c:if test="${item.order_status eq 0}">待使用</c:if>
															<c:if test="${item.order_status eq 1}">已使用</c:if>
														</div></td>
													<td><div align="center">
															<c:if test="${item.pay_status eq 0}">待付款</c:if>
															<c:if test="${item.pay_status eq 1}">已付款</c:if>
															<c:if test="${item.pay_status eq 2}">已取消</c:if>
															<c:if test="${item.pay_status eq 3}">退款中</c:if>
															<c:if test="${item.pay_status eq 4}">已退款</c:if>
														</div></td>
													<td><div align="center">${item.auto_note}</div></td>
													<td><div align="center">${item.log_note}</div></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="form-group">
									<div class="col-sm-8 col-sm-offset-5">
										<button class="btn btn-warning" onclick="history.go(-1)">
											<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript">
		function state(type) {
			var data = [ {
				"name" : "pay",
				"ali_name" : "已付款"
			}, {
				"name" : "nopay",
				"ali_name" : "未付款"
			}, {
				"name" : "user",
				"ali_name" : "已使用"
			}, {
				"name" : "nouser",
				"ali_name" : "未使用"
			}, {
				"name" : "back",
				"ali_name" : "已退款"
			}, {
				"name" : "backing",
				"ali_name" : "退款中"
			}, {
				"name" : "cancel",
				"ali_name" : "已取消"
			}, 
			{
				"name" : "pay_price",
				"ali_name" : "修改"
			} 
			];
			var title = "";
			for (var o in data) {
				if (data[o].name == type) {
					title = data[o].ali_name;
					break;
				}
			}
			var action_note = $("#action_note").val();
			var pay_price = $("#pay_price").val();
			if("pay_price"==type){
				if(!pay_price){
					$("#pay_price").val(0)
					pay_price=0;
				}
			}
			var order_id = $("#order_id").val();
				bootbox.confirm(
								"您确定" + title + "该订单吗",
								function(result) {
									if (result) {
										$.ajax({
													type : "post",
													url : "/sys/grouptour/ordersavePage?type="
															+ type
															+ "&action_note="
															+ action_note
															+ "&order_id=" + order_id+"&pay_price="+pay_price,
													dataType : "json",
													 complete : function() {
														window.location.href = "/sys/grouptour/ordereditPage?order_id="
																+ order_id;
													} 
												});
									}
								});
		}

		//查看物流
		function watchTrack(order_id) {
			var index = layer
					.open({
						type : 2,
						title : '<font color="gray" size="3px"><strong>物流跟踪 </strong></font>',
						content : "/sys/order/orders/watchTrack?order_id=${dataModel.order_id}",
						area : [ '800px', '495px' ],
						maxmin : true
					});
		}
		function refundGoods(orderGoodsId, orderId) {
			var index = layer
					.open({
						type : 2,
						title : '<font color="gray" size="3px"><strong>退货 </strong></font>',
						content : "/sys/order/refund/refundMoneyPage?order_id="
								+ orderId + "&order_goods_id=" + orderGoodsId,
						area : [ '800px', '495px' ],
						maxmin : true
					});
		}
	</script>
</body>
</html>