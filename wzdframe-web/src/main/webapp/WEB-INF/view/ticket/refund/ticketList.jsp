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
					<form action="/sys/scenic/list" method="post" name="Form"
						id="Form">
						<div class="ibox-content">
							<div class="search-condition row">
							<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">景区名称：</span> <input type="text"
											name="scenic_name" class="form-control" value="${pd.scenic_name}">
									</div>
								</div>
								<div class="col-md-1">
									<select class="form-control" name="scenic_status">
										<option value=''>景区状态</option>
										<option value='1'
											<c:if test="${pd.scenic_status eq 1}">selected = 'selected'</c:if>>
											正常</option>
										<option value='2'
											<c:if test="${pd.scenic_status eq 2}">selected = 'selected'</c:if>>
											隐藏</option>
									</select>
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
						<div class="ibox-content">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>票号</th>
											<th>姓名</th>
											<th class="center" style="width: 200px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.order_no}</td>
														<td>${item.refund_no}</td>
														<td>${item.order_money}</td>
														<td>${item.refund_phone}</td>
														<td>${item.refund_money}</td>
														<td>${item.refund_num}</td>
														<td>${item.refund_reson}</td>
														<td>${item.refund_time}</td>
														<td>
													       <c:if test="${item.refund_status eq 1}">
																<span class="label label-primary">已退票</span>
															</c:if> 
															<c:if test="${item.refund_status eq 2}">
																<span class="label btn-warning">退票中</span>
															</c:if>
															<c:if test="${item.refund_status eq 3}">
																<span class="label label-danger">退票失败</span>
															</c:if>
														</td>			
													    <td>
														    <c:if test="${item.refund_type eq 1}">
																<span class="label label-primary">支付宝</span>
															</c:if> 
															<c:if test="${item.refund_status eq 2}">
																<span class="label label-danger">微信</span>
															</c:if>
													    </td>
														<td>${empty item.exception_msg ? '无异常' : item.exception_msg}</td>
														<td class="center">
														<%-- <c:if test="${QX.edit == 1}"> --%>
															<a
																href="/sys/scenic/editPage?id=${item.id}"
																class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
															</a> 
															<%-- </c:if> --%>
															 <a href="javascript:void(0);"  onclick="openAlbum('${item.id}');" class="btn btn-primary btn-sm" title="查看门票">
																<i class="fa  fa-database"></i>
															</a> 
															<a
																href="javascript:del('${item.id}','${item.scenic_name}');" 
																class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
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
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
</body>
</html>