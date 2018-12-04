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
						<h5>商品列表</h5>
						<div class="ibox-tools">
							<a href="/sys/goods/goodsType/edit"
								class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goodsType/listPage" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>编号</th>
											<th>类型名称</th>
											<th>状态</th>
											<th>创建时间</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.type_id}</td>
														<td>${item.type_name}</td>
														<td><c:if test="${item.is_del eq 1}">
																<span class="label label-danger">已删除</span>
															</c:if> <c:if test="${item.is_del ne 1}">
																<span class="label label-info">正常</span>
															</c:if></td>
														<td>${item.create_time}</td>
														<td class="center" style="width: 200px;"><a
															href="/sys/goods/goodsTypeAttr/listPage?goods_type_id=${item.type_id}&type_name=${item.type_name}"
															class="btn btn-default" role="button"> 属性列表 </a> <c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a href="/sys/goods/goodsType/edit?id=${item.type_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1 }">
																 <a
																	href="/sys/goods/goodsType/delete?type_id=${item.type_id}"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a> 
															<!-- 	<a
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a> -->
															</c:if></td>
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
</body>
</html>