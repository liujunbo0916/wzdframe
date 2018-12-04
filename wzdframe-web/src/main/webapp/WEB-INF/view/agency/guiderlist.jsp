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
					<form action="/sys/travel/guider/list" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>导游列表</h5>
							<div class="ibox-tools">
								<a href="/sys/travel/guider/edit" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增导游</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="search-condition row">
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">导游名字：</span> <input
											type="text" name="guider_name" class="form-control"
											value="${pd.guider_name}">
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">导游昵称：</span> <input
											type="text" name="guider_nickname" class="form-control"
											value="${pd.guider_nickname}">
									</div>
								</div>
								<div class="col-md-1">
									<select class="form-control" name="guider_disabled">
										<option value=''>状态</option>
										<option value='0'
											<c:if test="${pd.guider_disabled eq 0}">selected = 'selected'</c:if>>
											不可用</option>
										<option value='1'
											<c:if test="${pd.guider_disabled eq 1}">selected = 'selected'</c:if>>
											可用</option>
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
											<th>导游名字</th>
											<th>宣传照片</th>
											<th>导游昵称</th>
											<th>宣传语</th>
											<th>导游标签</th>
											<th>旅行社</th>
											<th>联系电话</th>
											<th>带团次数</th>
											<th>价格（/天）</th>
											<th>导游评分</th>
											<th>创建时间</th>
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
														<td>${item.guider_name}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${item.guider_logo}"></td>
														<td>${item.guider_nickname}</td>
														<td>${item.guider_propaganda}</td>
														<td>${item.guider_lable}</td>
														<td>${item.agency_show_name}</td>
														<td>${item.guider_mobile}</td>
														<td>${item.guider_service_num}</td>
														<td>${item.guider_price}</td>
														<td>${item.guider_score}</td>
														<td>${item.guider_create_time}</td>
														<td><c:if test="${item.guider_disabled eq 1}">
																<span class="label label-primary">可用</span>
															</c:if> <c:if
																test="${empty item.guider_disabled || item.guider_disabled eq 0}">
																<span class="label label-danger">不可用</span>
															</c:if></td>
														<td class="center"><a
															href="/sys/travel/guider/edit?guider_id=${item.guider_id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> <a
															href="javascript:del('${item.guider_id}','${item.guider_name}');"
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
		function del(guider_id, name) {
			bootbox.confirm("确定删除" + name, function(result) {
				if (result) {
					Ajax.request("/sys/travel/guider/delete", {
						"data" : {
							"guider_id" : guider_id
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