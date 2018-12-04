<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
</head>
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>店铺列表</h5>
						<div class="ibox-tools">
							<a href="/sys/shops/editPage" class="btn btn-primary btn-xs"><i
								class="fa fa-plus"></i>&nbsp;新增</a>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/shops/list" method="post" name="Form" id="Form">
							<div class="search-condition row">
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">店铺</span> <input type="text"
											name="bs_name" class="form-control" value="${pd.bs_name}">
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<select name="bs_grade_id" class="form-control input-group">
											<option value=''>--所属等级--</option>
											<c:forEach items="${gradeData}" var="item">
												<option value='${item.bsg_id}'
													<c:if test="${pd.bs_grade_id eq item.bsg_id}"> selected="selected"</c:if>>${item.bsg_name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<select id="bs_state" name="bs_state"
											class="form-control input-group">
											<option value=''>--店铺类型--</option>
											<option value='1'
												<c:if test="${pd.bs_state==1}"> selected="selected"</c:if>>开启</option>
											<option value="2"
												<c:if test="${pd.bs_state==2}"> selected="selected"</c:if>>关闭</option>
											<option value="3"
												<c:if test="${pd.bs_state==3}"> selected="selected"</c:if>>已到期</option>
											<option value="4"
												<c:if test="${pd.bs_state==4}"> selected="selected"</c:if>>即将到期</option>
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
						</form>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>店铺</th>
										<th>店铺logo</th>
										<th>店铺地址</th>
										<th>人均价格</th>
										<th>店铺等级</th>
										<th>推荐状态</th>
										<th>店铺有效期</th>
										<th>状态</th>
										<th class="center" style="width: 155px">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty dataModel}">
											<c:forEach items="${dataModel}" var="item">
												<tr>
													<td>${item.bs_name}</td>
													<td><img width="100px" height="100px" onerror="this.src='/statics/img/no-img.jpg'" src="${SETTINGPD.IMAGEPATH}${item.bs_logo}"/></td>
													<td>${item.bs_address}</td>
													<td>${item.bs_price} 起</td>
													<td>${item.bsg_name}</td>
													<td>
													<c:if test="${empty item.is_recommend || item.is_recommend == 0}">不推荐</c:if>
														<c:if test="${item.is_recommend == 1}">人气推荐</c:if>
															<c:if test="${item.is_recommend == 2}">特别推荐</c:if>
													</td>
													<td><c:if test="${empty item.bs_closed_time}">
													           无限制
													   </c:if> <c:if test="${not empty item.bs_closed_time}">
													           ${item.bs_closed_time}
													   </c:if></td>
													<td><c:if test="${item.bs_state eq 0}">
															<span class="label label-danger">关闭</span>
														</c:if> <c:if test="${item.bs_state eq 1}">
															<span class="label label-primary">开启</span>
														</c:if> <c:if test="${item.bs_state eq 2}">
															<span class="label label-default">待审核</span>
														</c:if> <c:if test="${item.bs_state eq 3}">
															<span class="label label-warning">审核不通过</span>
														</c:if></td>
													<td class="center"><a
														href="/sys/shops/editPage?bs_id=${item.bs_id}"
														class="btn btn-primary btn-sm" title="编辑"> <i
															class="fa fa-pencil"></i>
													</a><a href="javascript:void(0)"
														onclick="openUploadBank(${item.user_id})"
														class="btn btn-primary btn-sm" title="删除"> <i
															class="fa fa-trash"></i>
													</a></td>
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
										<td colspan="10">
											<div class="dataTables_paginate paging_bootstrap pull-right">
												${page.pageStr}</div>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
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