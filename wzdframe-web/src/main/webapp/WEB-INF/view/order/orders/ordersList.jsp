<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
</head>
<link href="/assets/css/plugins/jedate1/skin/jedate.css" rel="stylesheet"/>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>商品订单列表</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/order/orders/listPage" method="post"
							name="Form" id="Form">
							<div class="row">
								<div class="search-condition row">
									<div class="col-md-12">
									   <div class="col-md-2">
											<div class="input-group">
												<input
													placeholder="订单号" type="text" class="form-control" name="order_sn" value="${pd.order_sn}">
											</div>
										</div>
											<div class="col-md-2">
												<div class="input-group">
													<input
													  placeholder="下单人"	type="text" class="form-control" name="user_name" value="${pd.user_name}">
												</div>
											</div>
										<div class="col-md-2">
											<div class="input-group">
												<input type="text" placeholder="订单开始时间" class="form-control date" style="width: 180px;cursor:pointer;background-color:#fff;"
														name="start_create_time" id="startDate" readonly="readonly" value='<fmt:formatDate value="${pd.start_create_time}" pattern="yyyy-MM-dd"/>'>
											</div>
										</div>
										<div class="col-md-2">	
											<div class="input-group">
												<input type="text" placeholder="订单结束时间" class="form-control date" style="width: 180px;cursor:pointer;background-color:#fff;"
														name="end_create_time" id="endDate" readonly="readonly" value='<fmt:formatDate value="${pd.end_create_time}" pattern="yyyy-MM-dd"/>'>
											</div>
										</div>	
										<div class="col-md-2">
											<div class="input-group">
											<select
													id="order_status" name="order_status"
													class="form-control input-group">
													<option value=''>--订单状态--</option>
													<option value='0' <c:if test="${pd.order_status==0}"> selected="selected"</c:if> >待支付</option>
													<option value='1' <c:if test="${pd.order_status==1}"> selected="selected"</c:if> >待确认</option>
													<option value="2" <c:if test="${pd.order_status==2}"> selected="selected"</c:if> >配货中</option>
													<option value="3" <c:if test="${pd.order_status==3}"> selected="selected"</c:if> >待配送</option>
													<option value="4" <c:if test="${pd.order_status==4}"> selected="selected"</c:if> >配送中</option>
													<option value="5" <c:if test="${pd.order_status==5}"> selected="selected"</c:if> >已送达</option>
													<option value="6" <c:if test="${pd.order_status==6}"> selected="selected"</c:if> >交易完成</option>
													<option value='7' <c:if test="${pd.order_status==7}"> selected="selected"</c:if> >已取消</option>
													<option value='8' <c:if test="${pd.order_status==8}"> selected="selected"</c:if> >订单完成</option>
													<option value='9' <c:if test="${pd.order_status==9}"> selected="selected"</c:if> >订单关闭</option>
												</select>
											</div>
									</div>
									<div class="col-md-2">
										<div class="input-group">
											<button class="btn btn-primary" type="submit">
												<i class="fa fa-search"></i>&nbsp;查询&nbsp;
											</button>
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
											<th>下单人</th>
											<th>收货信息</th>
											<th>总金额</th>
											<th>应付金额</th>
											<th>下单时间</th>
											<th>订单状态</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.order_sn}</td>
														<td>${item.user_name}</td>
														<td>
														<p>收货人姓名：${item.contact_name}</p>
														<p>收货人手机号：${item.contact_phone}</p>
														<p>收货地址：${item.province}${item.city}${item.area}${item.address}</p>
														</td>
														<td>${item.order_money}</td>
														<td>${item.pay_by_money}</td>
															<td>${item.create_time}</td>
														<td>
														<c:if test="${item.order_status==0}">
														<span class="label">待付款</span>
														</c:if> 
														<c:if test="${item.order_status==1}">
														<span class="label label-danger">待确认</span>
														</c:if> 
														<c:if test="${item.order_status==2}">
														<span class="label label-purple">配货中</span>
														</c:if> 
														<c:if test="${item.order_status==3}">
														 <span class="label label-danger">待发货</span>
														</c:if> 
														<c:if test="${item.order_status==4}">
														<span class="label label-primary">已发货</span>
														</c:if> 
														<c:if test="${item.order_status==5}">
														<span class="label label-primary">已送达</span>
														</c:if> 
														<c:if test="${item.order_status==6}">
														  <span class="label label-success">交易成功</span>
														</c:if> 
														<c:if test="${item.order_status==7}">
														  <span class="label label-warning">已取消</span>
														</c:if> 
														<c:if test="${item.order_status==8}">
														<span class="label badge-pink">订单完成</span>
														</c:if>
														<c:if test="${item.order_status==9}">
														<span class="label badge-pink">订单关闭</span>
														</c:if>
														</td>
														<td class="center">
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> 
														<c:if test="${QX.edit == 1}">
														<a href="/sys/order/orders/edit?id=${item.order_id}" class="btn btn-primary btn-sm" title="编辑"> 
														<i class="fa fa-pencil"></i>
														</a> 
														</c:if>
														<c:if test="${item.order_status eq 7 && QX.del==1}">
															<a href="delOrder('${item.order_id}')" class="btn btn-warning btn-sm" title="删除"> <i class="fa fa-trash"></i>
															</a>
														</c:if>
														</td>
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
   <script type="text/javascript" src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
   <script type="text/javascript">
	   $.jeDate("#startDate",{
			format:"YYYY-MM-DD",
			isTime:true//isClear:false,
		});
		$.jeDate("#endDate",{
			format:"YYYY-MM-DD",
			isTime:true//isClear:false,
		});
		
		
		function delOrder(orderId){
			bootbox.confirm("确定删除该订单吗？",function(result){
				if(result){
					Ajax.request("/sys/order/orders/delete",{"data":{"order_id":order_id},"success":function(data){
						if(data.result == 200){
							window.location.reload();
						}else{
						    bootbox.alert(data.msg);	
						}
					}});
				}
			});
		}
		
   </script>
</body>
</html>