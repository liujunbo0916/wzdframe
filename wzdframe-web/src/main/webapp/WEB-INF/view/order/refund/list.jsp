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
						<h5>退货单管理</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/order/refund/listPage" method="post" name="Form" id="Form">
							<div class="row">
									<div class="search-condition row">
								<div class="col-md-1">
                                    <div class="input-group">
		                                <input type="text" placeholder="订单号" value="${pd.order_sn}"  class="form-control" name="order_sn">
		                            </div>
                                </div>
								<div class="col-md-1">
                                    <div class="input-group">
		                                <input type="text" placeholder="退货单号" value="${pd.bill_no}"  class="form-control" name="bill_no">
		                            </div>
                                </div>
	                            <div class="col-md-1">
                                    <div class="input-group">
		                                <input type="text" placeholder="下单人" value="${pd.conperson}" class="form-control" name="conperson" >
		                            </div>
                                </div>
                                 <div class="col-md-1">
                                    <div class="input-group">
		                                	<select id="refund_status" name="refund_status"  class="search-control">
			       								<option value=''>退货状态</option>
												<option value="1" <c:if test="${pd.refund_status eq 1}">selected = 'selected'</c:if>>待审核</option>
												<option value="2" <c:if test="${pd.refund_status eq 2}">selected = 'selected'</c:if>>审核失败</option>
												<option value="3" <c:if test="${pd.refund_status eq 3}">selected = 'selected'</c:if>>审核成功</option>
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
											<th>退货信息</th>
											<th>商品型号</th>
											<th>应退</th>
											<th>退货原因</th>
											<th>问题图片</th>
											<th>系统备注</th>
											<th>退货状态</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>
														<p>退货人：${item.user_name}</p>
															<p>退货单号：${item.refund_no}</p>
															<p> <a href="/sys/order/orders/listPage?order_sn=${item.order_sn}">订单号： ${item.order_sn}</a></p>
														</td>
														<td>${item.goods_name}<c:if test="${not empty item.goods_attr}">
														（${item.goods_attr}）
														</c:if>
														<c:if test="${not empty item.goods_count}">
														   数量:${item.goods_count}
														</c:if>
														</td>
														<td><p>应退金额：${empty item.refund_money ? 0:item.refund_money}</p>
														    <p>应退积分：${empty item.refund_points?0:item.refund_points}</p>
														    <p>回收积分：${empty item.resive_points?0:item.resive_points}</p>
														</td>
														<td>${item.refund_reason}</td>
														<td>
														<c:forEach items="${fn.split(item.refund_images,',')}" var="img">
														  <img alt="" width="50px;" height="50px;"  src="${SETTINGPD.IMAGEPATH}${img}">
														  </c:forEach>
														</td>
														<td>${item.refund_remark}</td>
														<td>
														 <c:if test="${empty item.refund_status || item.refund_status==1}">
														<span class="label label-warning">待审核</span>
														</c:if> 
														<c:if test="${item.refund_status==2}">
														<span class="label label-danger">退款失败</span>
														</c:if> 
														<c:if test="${item.refund_status==3}">
														<span class="label label-purple">退款成功</span>
														</c:if> 
														</td>
														<td class="center">
                       										<c:if test="${empty item.refund_status || item.refund_status==1}">
	                       										<a href="javascript:refundOrder(2,${item.refund_id});" class="btn btn-danger btn-sm" title="拒绝退货">
	                           									<i class="fa fa-minus-circle"></i>
	                       										</a>
	                       										<a href="javascript:refundOrder(3,${item.refund_id});" class="btn btn-purple btn-sm" title="确认退货">
	                           									<i class="fa fa-mail-reply"></i>
	                       										</a>
                       										</c:if>
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
	        function refundOrder(status,refundId){
	        	var title = "拒绝该申请"
	        	if(status == 3){
	        		title = "同意该申请";
	        	}
	        	bootbox.confirm("您确认"+title,function(result){
	        		if(result){
	        			Ajax.request("/sys/order/refund/refundOrder",{"data":{"status":status,"refund_id":refundId},"success":function(data){
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