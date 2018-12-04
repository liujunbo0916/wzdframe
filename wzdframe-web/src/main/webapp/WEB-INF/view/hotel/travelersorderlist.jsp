<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>线路订单</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/grouptour/orderlistPage" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>订单号</th>
											<th>下单人</th>
											<th>总金额</th>
											<th>应付金额</th>
											<th>联系人信息</th>
											<th>下单时间</th>
											<th>支付状态</th>
											<th>订单状态</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.order_sn}</td>
														<td>${item.user_name}</td>
														<td>${item.total_price}</td>
														<td>${item.pay_price}</td>
														<td>${item.link_perple}${item.link_phone}
															${item.link_remark}</td>
														<td>${item.create_time}</td>
														<td><c:if test="${item.pay_status eq 0}">待支付</c:if> <c:if
																test="${item.pay_status eq 1}">已支付</c:if> <c:if
																test="${item.pay_status eq 2}">已取消</c:if> <c:if
																test="${item.pay_status eq 3}">退款中</c:if> <c:if
																test="${item.pay_status eq 4}">已退款</c:if></td>
														<td><c:if test="${empty item.order_state}">待支付</c:if>
															<c:if test="${item.order_state eq 0}">待使用</c:if> <c:if
																test="${item.order_state eq 1}">已使用</c:if></td>
														<td class="center" style="width: 200px;"><c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a
																	href="/sys/grouptour/ordereditPage?order_id=${item.order_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1 }">
																<a href="javascript:void(0);"
																	onclick="deleteCate(${item.order_id});"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
															</c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="18" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
									<%-- <tfoot>
	                                        <tr>
	                                            <td colspan="8">
	                                               	<div class="dataTables_paginate paging_bootstrap pull-right">
	                                               		${page.pageStr}
													</div>	
	                                            </td>
	                                        </tr>
	                                    </tfoot> --%>
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
	<%@ include file="../common/foot.jsp"%>
	<script src="/statics/plugin/treeGrid.js"></script>
	<script type="text/javascript">
	//类型删除
	function deleteCate(order_id){
		bootbox.confirm("你确定要彻底删除！",function(result){
			if(result){
				$.ajax({
					   type: "POST",
					   url: "/sys/grouptour/orderdelPage",
					   dataType : "json",
					   data : {
						   order_id: order_id
					   },
					   success: function(data){
						   if(data.result==200){
					      	   window.location.href='/sys/grouptour/orderlistPage';
						   }else{
							   bootbox.alert(data.msg);
						   }
					   }
					});
			}
		})
	}
	</script>
</body>
</html>