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
					<form action="/sys/grouptour/listPage" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>线路列表</h5>
							<div class="ibox-tools">
								<a href="/sys/grouptour/editPage" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增线路</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="search-condition row">
							<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">线路名称：</span> <input type="text"
											name="grouptour_name" class="form-control" value="${pd.grouptour_name}">
									</div>
								</div>
								<div class="col-md-1">
									<select class="form-control" name="grouptour_state">
										<option value=''>状态</option>
										<option value='0'
											<c:if test="${pd.grouptour_state eq 0}">selected = 'selected'</c:if>>
											待发布</option>
										<option value='1'
											<c:if test="${pd.grouptour_state eq 1}">selected = 'selected'</c:if>>
											已发布</option>
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
											<th>线路名称</th>
											<th>线路图片</th>
											<th>线路价格</th>
											<th>联系电话</th>
											<th>游览天数</th>
											<th>线路销量</th>
											<th>旅行社</th>
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
														<td>${item.grouptour_name}</td>
														<td><img alt="" width="100px" height="100px" onerror="this.src='/statics/img/no-img.jpg'"
															src="${SETTINGPD.IMAGEPATH}${item.grouptour_img}"></td>
														<td>成人：￥${item.grouptour_price}     儿童：￥${item.childs_price}</td>
														<td>${item.grouptour_phone}</td>
														<td>${item.grouptour_day}</td>
														<td>${item.grouptour_sales}</td>
														<td>${item.agency_show_name}</td>
														<td><c:if test="${item.grouptour_state eq 1}">
																<span class="label label-primary">已发布</span>
															</c:if> <c:if test="${empty item.grouptour_state || item.grouptour_state eq 0}">
																<span class="label label-danger">待发布 </span>
															</c:if></td>
														<td class="center">
														<a
															href="/sys/grouptour/editPage?grouptour_id=${item.grouptour_id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> 
														<a
															href="javascript:del('${item.grouptour_id}','${item.grouptour_name}');" 
															class="btn btn-warning btn-sm" title="删除"> <i
																class="fa fa-trash"></i>
														</a>
														</td>
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
		function del(grouptour_id,name){
			bootbox.confirm("确定删除"+name,function(result){
				if(result){
					Ajax.request("/sys/grouptour/delPage",{"data":{"grouptour_id":grouptour_id},"success":function(data){
						if(data.result == 200){
							bootbox.alert("成功删除");
							nextPage("${page.currentPage}");
						}else{
							bootbox.alert("成功失败");
						}
					}});
				}
			});
		}
	</script>
</body>
</html>