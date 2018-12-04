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
						<h5>发货单管理</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/order/ordersShipping/listPage" method="post" name="Form" id="Form">
							<div class="row">
									<div class="search-condition row">
								<div class="col-md-2">
                                    <div class="input-group">
		                                <input type="text" placeholder="订单号" value="${pd.order_sn}"  class="form-control" name="order_sn">
		                            </div>
                                </div>
								<div class="col-md-2">
                                    <div class="input-group">
		                                <input type="text" placeholder="货运单号" value="${pd.bill_no}"  class="form-control" name="bill_no">
		                            </div>
                                </div>
	                            <div class="col-md-2">
                                    <div class="input-group">
		                                <input type="text" placeholder="收货人" value="${pd.conperson}" class="form-control" name="conperson" >
		                            </div>
                                </div>
                                 <div class="col-md-2">
                                    <div class="input-group">
		                                	<select id="shipping_status" name="shipping_status"  class="search-control">
			       								<option value=''>--配送状态--</option>
												<option value="4" <c:if test="${pd.shipping_status eq 4}">selected = 'selected'</c:if>>已发货</option>
												<option value="5" <c:if test="${pd.shipping_status eq 5}">selected = 'selected'</c:if>>已收货</option>
												<option value="6" <c:if test="${pd.shipping_status eq 6}">selected = 'selected'</c:if>>已签收</option>
												<option value="8" <c:if test="${pd.shipping_status eq 8}">selected = 'selected'</c:if>>已退货</option>
										</select>
		                            </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
	    	                             <button class="btn btn-primary" type="submit" >
													<i class="fa fa-search"></i>&nbsp;查询&nbsp;
									     </button>
		                            </div>
                                </div>
                        </div>
						</div><div class="hr-line-dashed" style="margin: 10px 0;"></div>
							<div class="project-list">
 								<table id="simple-table" class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>货运单号</th>
											<th>订单号</th>
											<th>配送货物</th>
											<th>快递公司</th>
											<th>发货时间</th>
											<th>快递费用</th>
											<th>收货人</th>
											<th>联系人电话</th>
											<th>收货地址</th>
											<th>配送状态</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.bill_no}</td>
														<td>${item.order_sn}</td>
														<td>${item.ex_content}</td>
														<td>${item.ex_name}</td>
														<td>${item.shipping_time}</td>
														<td>${item.ex_money}</td>
														<td>${item.conperson}</td>
														<td>${item.conphone}</td>
														<td>${item.address}</td>
														<td>
														 <c:if test="${item.shipping_status==0}">
														<span class="label">待付款</span>
														</c:if> 
														<c:if test="${item.shipping_status==1}">
														<span class="label label-danger">待配货</span>
														</c:if> 
														<c:if test="${item.shipping_status==2}">
														<span class="label label-purple">配货中</span>
														</c:if> 
														<c:if test="${item.shipping_status==3}">
														 <span class="label label-danger">待发货</span>
														</c:if> 
														<c:if test="${item.shipping_status==4}">
														<span class="label label-primary">已发货</span>
														</c:if> 
														<c:if test="${item.shipping_status==5}">
														<span class="label label-primary">已收货</span>
														</c:if> 
														<c:if test="${item.shipping_status==6}">
														  <span class="label label-success">已签收</span>
														</c:if> 
														<c:if test="${item.shipping_status==7}">
														  <span class="label label-warning">已取消</span>
														</c:if> 
														<c:if test="${item.shipping_status==8}">
														<span class="label badge-pink">已退货</span>
														</c:if>
														</td>
														<td class="center">
                       										<a href="/sys/order/ordersShipping/edit?id=${item.shipping_id}" class="btn btn-primary btn-sm" title="物流">
                           									<i class="fa fa-eye"></i>
                       										</a>
                       									</td>
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
	                                               		${page.pageStr}
													</div>	
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
	<script type="text/javascript">
	        //查看物流
			function watchTrack(order_id){
				var index = layer.open({
					  type: 2,
					  title: '<font color="gray" size="3px"><strong>物流跟踪 </strong></font>',
					  content: "/sys/order/orders/watchTrack?order_id=${dataModel.order_id}",
					  area: ['800px', '495px'],
					  maxmin: true
			    });
			}
	</script>
</body>
</html>