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
						<h5>订单管理</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/rebate/orderList" method="post" name="Form" id="Form">
							<div class="row">
									<div class="search-condition row">
								<div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">订单号：</span>
		                                <input type="text" class="form-control" name="order_sn">
		                            </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">状态：</span>
		                                	<select id="rebate_status" name="rebate_status"  class="form-control input-group">
			       								<option value='请选择'>----请选择----</option>
												<option value="3">等待分佣</option>
												<option value="5">已经分佣</option>
												<option value="6">取消分佣</option>
												<option value="4">交易失败</option>
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
											<th style="width: 130px">订单号</th>
											<th>下单人</th>
											<th>订单总额</th>
											<th>返佣总额</th>
											<th>受益人(1|2|3)</th>
											<th>返现金(1|2|3)</th>
										<!-- 	<th>返积分(1|2|3)</th> -->
											<th>返佣状态</th>
											<th>订单状态</th>
											<th style="width: 150px">下单时间</th>
											<th class="center" style="width: 120px">操作</th>
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
														<td>${item.order_money}</td>
														<td>${item.total_rebate}</td>
														<td>
															<c:choose>
															    <c:when test="${item.name_1 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.name_1}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.name_2 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.name_2}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.name_3 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.name_3}
															    </c:otherwise>
															</c:choose>
														</td>
														<td>
															<c:choose>
															    <c:when test="${item.rebate_1 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.rebate_1}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.rebate_2 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.rebate_2}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.rebate_3 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.rebate_3}
															    </c:otherwise>
															</c:choose>
														</td>
														<%-- <td>
															<c:choose>
															    <c:when test="${item.points_1 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.points_1}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.points_2 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.points_2}
															    </c:otherwise>
															</c:choose>
															|
															<c:choose>
															    <c:when test="${item.points_3 eq null}">
															      	 <span class="label label-primary">无</span>
															    </c:when>
															    <c:otherwise>
															        ${item.points_3}
															    </c:otherwise>
															</c:choose>
														</td> --%>
														<td>
															<c:choose>
															 <c:when test="${item.rebate_status eq -1}">
															      	 <span class="label badge-warning">分销关闭</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 0}">
															      	 <span class="label badge-warning">等待付款</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 1}">
															      	 <span class="label badge-warning">等待审核</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 2}">
															      	 <span class="label badge-info">等待完成</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 3}">
															      	 <span class="label badge-info">等待返佣</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 4}">
															      	 <span class="label badge-danger">交易失败</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 5}">
															      	 <span class="label label-primary">已经返佣</span>
															    </c:when>
															    <c:when test="${item.rebate_status eq 6}">
															      	 <span class="label label-primary">取消返佣</span>
															    </c:when>
															</c:choose>
														</td>
														<td>
															<c:if test="${item.order_status==0}">待付款</c:if>
															<c:if test="${item.order_status==1}">待确认</c:if>
															<c:if test="${item.order_status==2}">配货中</c:if>
															<c:if test="${item.order_status==3}">待发货</c:if>
															<c:if test="${item.order_status==4}">已发货</c:if>
															<c:if test="${item.order_status==5}">已送达</c:if>
															<c:if test="${item.order_status==6}">交易成功</c:if>
															<c:if test="${item.order_status==7}">已取消</c:if>
															<c:if test="${item.order_status==8}">已退货</c:if>
														</td>
														<td>${item.create_time}</td>
														<td class="center">
														<!-- 订单状态交易成功,且返佣状态为等待返佣 -->
														<c:if test="${item.order_status==6}">
															<c:if test="${item.rebate_status==3}">
																<a onclick="confirmRakeBack(${item.id})" href="javascript:;" class="btn btn-primary btn-sm" title="分成">分成</a>
															</c:if>		
														</c:if>
<%-- 														<c:if test="${item.order_status==6}"> --%>
<%-- 															<c:if test="${item.rebate_status==5}"> --%>
<%-- 																<a onclick="confirmCancelRakeBack(${item.id})" href="javascript:;" class="btn btn-warning btn-sm" title="取消">取消</a> --%>
<%-- 															</c:if>		 --%>
<%-- 														</c:if> --%>
<%--                        									<c:if test="${item.order_status==7||item.order_status==8}"> --%>
<%-- 															<c:if test="${item.rebate_status==4}"> --%>
<%-- 																<a onclick="confirmCancelRakeBack(${item.id})" href="javascript:;" class="btn btn-warning btn-sm" title="取消">取消</a> --%>
<%-- 															</c:if>		 --%>
<%-- 														</c:if> --%>
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
	                                            <td colspan="11">
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
	<%@ include file="../common/foot.jsp"%>
<!-- 自定义js -->
	<script type="text/javascript">
		function confirmRakeBack(data){
			app.confirm("警告","您确定要为执行返佣",rakeBack,data);
		}
		function rakeBack(data){
			/* Ajax.request("/logistics/savearea", {
				"data" : data,
				"success" : function(data) {
					if (data.result == 200) {
						parent.location.reload();
						closed();
						bootbox.alert("保存失败！");
					} else {
						bootbox.alert("保存失败！");
					}
				}
			}); */
			 app.post({"id":data},"/sys/rebate/rakeBack",rakeBackSuccess,rakeBackError,true) 
		}
		function rakeBackSuccess(data){
			if(data.code==200){
				app.error("已经将佣金返给客户","执行成功");
				window.location.reload();
			}
		}
		function rakeBackError(data){
			if(data.code==205||data.code==201){
				app.error(data.msg,"返佣失败");	
			}else if(data.code==200){
				app.error("已经将佣金返给客户","执行成功");
				window.location.reload();
			}else{
				app.error("发生未知错误","返佣失败");
			}
		}
		
		//取消返佣
// 		function confirmCancelRakeBack(data){
// 			app.confirm("警告","您确定要为执行返佣",rakeBack,data);
// 		}
// 		function rakeBack(data){
// 			app.post({"id":data},"/sys/rebate/cancelRake",rakeBackSuccess,rakeBackError,true)
// 		}
// 		function rakeBackSuccess(data){
// 			app.success("已经将佣金返给客户","执行成功");
// 		}
// 		function rakeBackError(data){
// 			if(data.code==205||data.code==201){
// 				app.error(data.msg,"返佣失败");	
// 			}else{
// 				app.error("发生未知错误","返佣失败");
// 			}
// 		}
		
	</script>
</body>
</html>