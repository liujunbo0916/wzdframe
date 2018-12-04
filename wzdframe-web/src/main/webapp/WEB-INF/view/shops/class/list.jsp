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
						<h5>商铺分类列表</h5>
						<div class="ibox-tools">
							<a href="/sys/shops/class/editPage" class="btn btn-primary btn-xs"><i
								class="fa fa-plus"></i>&nbsp;新增</a>
						</div>
					</div>
					<div class="ibox-content">
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>排序</th>
										<th>分类名称</th>
										<th>保证金数额(元)</th>
										<th class="center" style="width: 155px">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty dataModel}">
											<c:forEach items="${dataModel}" var="item">
												<tr>
													<td>${item.sc_sort}</td>
													<td>${item.sc_name}</td>
													<td>${item.sc_bail}</td>
													<td class="center"><a
														href="/sys/shops/class/editPage?sc_id=${item.sc_id}"
														class="btn btn-primary btn-sm" title="编辑"> <i
															class="fa fa-pencil"></i>
													</a> <a href="javascript:void(0)"
														onclick="deletesc(${item.sc_id})"
														class="btn btn-primary btn-sm" title="删除"> <i
															class="fa fa-trash"></i>
													</a></td>
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
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	
	<script type="text/javascript">
	
	function deletesc(scid){
		bootbox.confirm("你确定删除该商铺分类吗吗!",function(result){
			if(result){
				Ajax.request("/sys/shops/class/delete", {
					"data" : {"sc_id":scid},
					"success" : function(data) {
						if (data.result == 200) {
							window.location.href = "/sys/shops/class/list";
						} else {
							submitFlag = false;
							bootbox.alert(data.msg);
						}
					}
				});
			}
		});
	}
	</script>
</body>
</html>