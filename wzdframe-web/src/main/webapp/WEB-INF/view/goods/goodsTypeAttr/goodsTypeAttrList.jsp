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
						<h5>属性列表</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add == 1 }">
							<a href="/sys/goods/goodsTypeAttr/add?goods_type_id=${pd.goods_type_id}&type_name=${pd.type_name}" class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if>
						</div> 
					</div>
					<div class="ibox-content">
					     <input type="hidden" name="goods_type_id" id="goods_type_id" value="${pd.goods_type_id}" />
					     <input type="hidden" name="type_name" id="type_name" value="${pd.type_name}" />
						<form action="" method="post" name="Form" id="Form">
							<div class="project-list">
 								<table id="simple-table" class="center table table-striped table-bordered table-hover" >	
									<thead>
										<tr>
											<th>编号</th>
											<th>属性名称</th>
											<th>属性类型</th>
											<th>商品类型</th>
											<th>属性录入方式</th>
											<th>可选值列表</th>
											<th>排序</th>
											<th>创建人</th>
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
														<td>${item.type_attr_id}</td>
														<td>${item.attr_name}</td>
														<td>
														    <c:if test="${item.is_sale == 0}"><span class="label badge-info">参数</span></c:if>
                                                            <c:if test="${item.is_sale == 1}"><span class="label badge-danger">销售</span></c:if>
														</td>
														<td>${item.type_name}</td>
														<!-- 属性录入方式（1单行文本，2多行文本，3单选，4多选） -->
														<td>
														    <c:if test="${item.attr_input == 1}">单行文本</c:if>
                                                            <c:if test="${item.attr_input == 2}">多行文本</c:if>
                                                            <c:if test="${item.attr_input == 3}">单选</c:if>
                                                            <c:if test="${item.attr_input == 4}">多选</c:if>
														</td>
														<td style="word-wrap:break-word;word-break:break-all;" width="250px">${item.attr_values}</td>
														<td>${item.attr_sort}</td>
														<td>${item.creator}</td>
														<td>${item.create_time}</td>
														<td class="center">
															<a href="/sys/goods/goodsTypeAttr/edit?id=${item.type_attr_id}&type_name=${item.type_name}" class="btn btn-primary btn-sm" title="编辑">
                           										<i class="fa fa-pencil"></i>
                       										</a>
                       										<a href="/sys/goods/goodsTypeAttr/detele?type_attr_id=${item.type_attr_id}" class="btn btn-warning btn-sm" title="删除">
                           										<i class="fa fa-trash"></i>
                       										</a> 
                       										<!-- <a href="javascript:void(0);" class="btn btn-warning btn-sm" title="删除">
                           										<i class="fa fa-trash"></i>
                       										</a> -->
                       									</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="9" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
										<tfoot>
	                                        <tr>
	                                            <td colspan="9">
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
</body>
</html>