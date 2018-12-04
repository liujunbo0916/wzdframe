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
					<div class="ibox-title">
						<h5>出游人列表</h5>
						<div class="ibox-tools">
							<%-- <c:if test="${QX.add==1}">
								<a href="/sys/grouptour/travelerseditPage"
									class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if> --%>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/grouptour/travelerslistPage" method="post"
							name="Form" id="Form">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>用户名</th>
											<th>出游人姓名</th>
											<th>出游人电话</th>
											<th>证件类型</th>
											<th>证件号码</th>
											<th>性别</th>
											<th>创建时间</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.user_name}</td>
														<td>${item.travelers_name}</td>
														<td>${item.travelers_phone}</td>
														<td><c:if test="${item.travelers_type eq 1}">身份证</c:if>
															<c:if test="${item.travelers_type eq 2}">护照</c:if> <c:if
																test="${item.travelers_type eq 3}">军官证</c:if> <c:if
																test="${item.travelers_type eq 4}">驾驶证</c:if> <c:if
																test="${item.travelers_type eq 5}">学生证</c:if> <c:if
																test="${item.travelers_type eq 6}">回乡证</c:if> <c:if
																test="${item.travelers_type eq 7}">港澳通行证</c:if> <c:if
																test="${item.travelers_type eq 8}">台湾通行证</c:if> <c:if
																test="${item.travelers_type eq 9}">其他</c:if></td>
														<td>${item.travelers_no}</td>
														<td><c:if test="${item.travelers_gender eq 0}">女</c:if>
															<c:if test="${item.travelers_gender eq 1}">男</c:if></td>
														<td>${item.create_time}</td>
														<td class="center" style="width: 200px;"><c:if
																test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> <c:if test="${QX.edit == 1}">
																<a
																	href="/sys/grouptour/travelerseditPage?travelers_id=${item.travelers_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <c:if test="${QX.del == 1 }">
																<a href="javascript:void(0);"
																	onclick="deleteCate(${item.travelers_id});"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
															</c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="10" class="center">没有相关数据</td>
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
	<%@ include file="../common/foot.jsp"%>
	<script src="/statics/plugin/treeGrid.js"></script>
	<script type="text/javascript">
	//类型删除
	function deleteCate(travelers_id){
		bootbox.confirm("你确定要彻底删除！",function(result){
			if(result){
				$.ajax({
					   type: "POST",
					   url: "/sys/grouptour/travelersdelPage",
					   dataType : "json",
					   data : {
						   travelers_id: travelers_id
					   },
					   success: function(data){
						   if(data.result==200){
					      	   window.location.href='/sys/grouptour/travelerslistPage';
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