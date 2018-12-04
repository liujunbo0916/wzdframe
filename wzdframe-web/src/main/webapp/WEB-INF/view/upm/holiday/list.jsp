<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
					<form action="/sys/holiday/list" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>景区列表</h5>
							<div class="ibox-tools">
								<a href="/sys/holiday/editPage" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增假期</a>
							</div>
						</div>
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
											<th>假期名字</th>
											<th>假期编码</th>
											<th>假期日期</th>
											<th class="center" style="width: 200px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.holiday_name}</td>
														<td>${item.holiday_code}</td>
														<td>
														<c:forEach items="${fn:split(item.holiday_value,';')}" var="item">
														   <p>${item}</p>
														</c:forEach>
														</td>
														<td class="center">
															<a
																href="/sys/scenic/editPage?id=${item.id}"
																class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
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
		<script type="text/javascript">
	</script>
</body>
</html>