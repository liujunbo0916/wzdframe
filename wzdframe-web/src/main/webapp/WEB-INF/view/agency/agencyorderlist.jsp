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
					<form action="/sys/hotel/listPage" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>酒店列表</h5>
							<div class="ibox-tools">
								<a href="/sys/hotel/editPage" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增酒店</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="search-condition row">
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">酒店名称：</span> <input
											type="text" name="hotel_name" class="form-control"
											value="${pd.hotel_name}">
									</div>
								</div>
								<div class="col-md-1">
									<select class="form-control" name="hotel_state">
										<option value=''>酒店状态</option>
										<option value='0'
											<c:if test="${pd.hotel_state eq 0}">selected = 'selected'</c:if>>
											下架</option>
										<option value='1'
											<c:if test="${pd.hotel_state eq 1}">selected = 'selected'</c:if>>
											上架</option>
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
											<th>酒店名称</th>
											<th>酒店图片</th>
											<th>酒店类型</th>
											<th>酒店星级</th>
											<th>酒店地址</th>
											<th>酒店价格</th>
											<th>联系电话</th>
											<th>人气值</th>
											<th>链接地址</th>
											<th>是否热门</th>
											<th>是否推荐</th>
											<th>状态</th>
											<th class="center" style="width: 200px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.hotel_name}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${item.hotel_img}"></td>
														<td>${item.hotel_type_name}</td>
														<td>${item.hotel_starlevel}</td>
														<td>${item.hotel_address}</td>
														<td>${item.hotel_price}</td>
														<td>${item.hotel_phone}</td>
														<td>${item.hotel_popularity}</td>
														<td><c:if test="${item.hotel_url_type eq 2}">去哪儿网
															</c:if> <c:if
																test="${empty item.hotel_hot || item.hotel_url_type eq 1}">
																携程旅行网
															</c:if> ${item.hotel_url}</td>
														<td><c:if test="${item.hotel_hot eq 1}">
																<span class="label label-primary">是</span>
															</c:if> <c:if
																test="${empty item.hotel_hot || item.hotel_hot eq 0}">
																<span class="label label-danger">否</span>
															</c:if></td>
														<td><c:if test="${item.hotel_recommend eq 1}">
																<span class="label label-primary">是</span>
															</c:if> <c:if
																test="${empty item.hotel_recommend || item.hotel_recommend eq 0}">
																<span class="label label-danger">否</span>
															</c:if></td>
														<td><c:if test="${item.hotel_state eq 1}">
																<span class="label label-primary">上架</span>
															</c:if> <c:if
																test="${empty item.hotel_state || item.hotel_state eq 0}">
																<span class="label label-danger">下架</span>
															</c:if></td>
														<td class="center"><a
															href="/sys/hotel/editPage?hotel_id=${item.hotel_id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> <a
															href="javascript:del('${item.hotel_id}','${item.hotel_name}');"
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
		function del(hotel_id, name) {
			bootbox.confirm("确定删除" + name, function(result) {
				if (result) {
					Ajax.request("/sys/hotel/delPage", {
						"data" : {
							"hotel_id" : hotel_id
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