<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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
						<h5>商品品牌</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add == 1 }">
								<a href="/sys/goods/goodsBrand/edit"
									class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goodsBrand/listPage" method="post"
							name="Form" id="Form">
							<div class="search-condition row">
								<div class="col-md-1">
									<div class="input-group">
										<input type="text" class="form-control" placeholder="品牌名称"
											name="brand_name" value="${requestScope.page.pd.brand_name}">
									</div>
								</div>
								<div id="categoryAppend" class="col-md-5">
									<div id="categoryAppend1" class="col-md-4">
										<select class="form-control" id="category1_id"
											name="category1_id">
											<option value="">请选择一级分类</option>
											<c:forEach items="${categoryList}" var="category">
												<option value="${category.category_id}"
													<c:if test="${pd.category1_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
												</option>
											</c:forEach>
										</select>
									</div>
									<c:if test="${not empty category2List}">
										<div id="categoryAppend2" class="col-md-4">
											<select class="form-control" id="category1_id"
												name="category1_id">
												<option value="">请选择一级分类</option>
												<c:forEach items="${category2List}" var="category">
													<option value="${category.category_id}"
														<c:if test="${pd.category2_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
													</option>
												</c:forEach>
											</select>
										</div>
									</c:if>
									<c:if test="${not empty category3List}">
										<div id="categoryAppend3" class="col-md-4">
											<select class="form-control" id="category1_id"
												name="category1_id">
												<option value="">请选择一级分类</option>
												<c:forEach items="${category3List}" var="category">
													<option value="${category.category_id}"
														<c:if test="${pd.category3_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
													</option>
												</c:forEach>
											</select>
										</div>
									</c:if>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<button class="btn btn-primary" type="submit">
											<i class="fa fa-search"></i>&nbsp;查询&nbsp;
										</button>
									</div>
								</div>
							</div>
							<div class="hr-line-dashed" style="margin: 10px 0;"></div>
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>编号</th>
											<th>品牌名称</th>
											<th>品牌logo</th>
											<th>品牌网址</th>
											<th>品牌分类</th>
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
														<td>${item.brand_id}</td>
														<td>${item.brand_name}</td>
														<td><img alt=""
															src="${SETTINGPD.IMAGEPATH}${item.brand_icon}"  onerror="this.src='/statics/img/no-img.jpg'"
															height="50px" width="60px"></td>
														<td><a href="${item.brand_url}" target="_blank">${item.brand_url}</a></td>
														<td>${item.brand_category}</td>
														<td>${item.creator}</td>
														<td>${item.create_time}</td>
														<td class="center" style="width: 200px;"><c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a href="/sys/goods/goodsBrand/edit?id=${item.brand_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1 }">
																<a href="javascript:void(0);"
																	onclick="deleteBrand(${item.brand_id});"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
															</c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="8" class="center">没有相关数据</td>
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
	<script type="text/javascript"
		src="/statics/js/user/categoryListPage.js"></script>
	<script type="text/javascript">
	//品牌删除
	function deleteBrand(brand_id){
		bootbox.confirm("你确定要彻底删除吗！",function(result){
			if(result){
				$.ajax({
					   type: "POST",
					   url: "/sys/goods/goodsBrand/delete",
					   dataType : "json",
					   data : {
						   brand_id: brand_id
					   },
					   success: function(data){
						   if(data.result==200){
							   window.location.href='/sys/goods/goodsBrand/listPage';
						   }else{
						   bootbox.alert(data.msg);
						   }
					   }
					});
			}
		})
	}
	</script>
</body>
</html>