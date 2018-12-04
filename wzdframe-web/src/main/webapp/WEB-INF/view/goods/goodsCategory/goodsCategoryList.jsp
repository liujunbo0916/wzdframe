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
						<h5>商品分类</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add==1}">
								<a href="/sys/goods/goodsCategory/edit"
									class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goodsCategory/listPage" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th style="width: 250px;">分类名称</th>
											<th>icon</th>
											<!-- <th>是否显示在搜索栏</th> -->
											<!-- <th>是否作为课程分类</th> -->
											<th>创建人</th>
											<th>创建时间</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>

									<tbody class="tree-grid">
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr data-pid="${item.parent_id}"
														data-id="${item.category_id}">
														<td>${item.category_name}
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <c:if
																test="${!item.is_leaf}">
																<a
																	href="/sys/goods/goodsCategory/edit?category_id=${item.category_id}"
																	class="btn btn-primary btn-xs"><i
																	class="fa fa-plus"></i>&nbsp;添加下级</a>
														</td>
														</c:if>
														<td><img alt="" onerror="this.src='/statics/img/no-img.jpg'"
															src="${SETTINGPD.IMAGEPATH}${item.category_icon}"
															height="50" width="100"></td>
														<%-- <td><c:if test="${item.is_show_search == 1}">是</c:if>
															<c:if test="${item.is_show_search == 0}">否</c:if></td> --%>
														<%-- <td><c:if test="${item.is_course == 1}">是</c:if> <c:if
																test="${empty item.is_course || item.is_course == 0}">否</c:if>
														</td> --%>
														<td>${item.creator}</td>
														<td>${item.create_time}</td>
														<td class="center" style="width: 200px;"><c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a
																	href="/sys/goods/goodsCategory/edit?id=${item.category_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1 }">
																<a href="javascript:void(0);"
																	onclick="deleteCate(${item.category_id});"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
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
									<%-- <tfoot>
	                                        <tr>
	                                            <td colspan="8">
	                                               	<div class="dataTables_paginate paging_bootstrap pull-right">
	                                               		${page.pageStr}
													</div>	
	                                            </td>
	                                        </tr>
	                                    </tfoot> --%>
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
	<script src="/statics/plugin/treeGrid.js"></script>
	<script type="text/javascript">
	$(".tree-close-btn").trigger("click"); 
	//品牌删除
	function deleteCate(category_id){
		bootbox.confirm("你确定要彻底删除！",function(result){
			if(result){
				$.ajax({
					   type: "POST",
					   url: "/sys/goods/goodsCategory/delete",
					   dataType : "json",
					   data : {
						   category_id: category_id
					   },
					   success: function(data){
						   if(data.result==200){
					      	   window.location.href='/sys/goods/goodsCategory/listPage';
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