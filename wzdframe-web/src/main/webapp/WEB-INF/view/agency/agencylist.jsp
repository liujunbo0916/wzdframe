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
					<form action="/sys/travel/agency/list" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>旅行社列表</h5>
							<div class="ibox-tools">
								<a href="/sys/travel/agency/edit" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增旅行社</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="search-condition row">
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">旅行社名称：</span> <input
											type="text" name="agency_name" class="form-control"
											value="${pd.agency_name}">
									</div>
								</div>
								<div class="col-md-2">
									<select class="form-control" name="agency_status">
										<option value=''>旅行社状态</option>
										<option value='0'
											<c:if test="${pd.agency_status eq 0}">selected = 'selected'</c:if>>
											待发布</option>
										<option value='1'
											<c:if test="${pd.agency_status eq 1}">selected = 'selected'</c:if>>
											发布上线</option>
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
											<th>旅行社名称</th>
											<th>旅行社宣传名称</th>
											<th>旅行社宣传标语</th>
											<th>旅行社图片</th>
											<th>旅行社联系电话</th>
											<th>旅行社评分</th>
											<th>旅行社地址</th>
											<th>创建时间</th>
											<th>旅行社状态</th>
											<th class="center" style="width: 200px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.agency_name}</td>
														<td>${item.agency_show_name}</td>
														<td>${item.agency_slogan}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${item.agency_logo}"></td>
														<td>${item.agency_phone}</td>
															<td>${item.agency_stars}</td>
														<td>${item.agency_province}${item.agency_city}${item.agency_area}${item.agency_address}</td>
														<td>${item.agency_create_time}</td>
														<td><c:if test="${item.agency_status eq 1}">
																<span class="label label-primary">已发布</span>
															</c:if> <c:if
																test="${empty item.agency_status || item.agency_status eq 0}">
																<span class="label label-danger">待发布</span>
															</c:if></td>
														<td class="center"><a
															href="/sys/travel/agency/edit?agency_id=${item.agency_id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a>
														<a href="/sys/travel/guider/list?agency_id=${item.agency_id}"
															class="btn btn-primary btn-sm" title="导游列表"> <i
																class="fa fa-database"></i>
															</a> <a
															href="javascript:del('${item.agency_id}','${item.agency_name}');"
															class="btn btn-warning btn-sm" title="删除"> <i
																class="fa fa-trash"></i>
														</a></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="15" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="15">
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
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript">
		function del(agency_id, name) {
			bootbox.confirm("确定删除" + name, function(result) {
				if (result) {
					Ajax.request("/sys/travel/agency/delete", {
						"data" : {
							"agency_id" : agency_id
						},
						"success" : function(data) {
							if (data.result == 200) {
								bootbox.alert("成功删除");
								nextPage("${page.currentPage}");
							}
						}
					});
				}
			});
		}
	</script>
</body>
</html>