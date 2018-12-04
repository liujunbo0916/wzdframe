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
						<h5>导游服务</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/user/listPage" method="post" name="Form"
							id="Form">
							<div class="project-list">
								<table 
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>用户信息</th>
											<th>联系方式</th>
											<th>旅游人数</th>
											<th>预约时间</th>
											<th>联系人</th>
											<th>预约地点</th>
											<th>导游信息</th>
											<th>申请时间</th>
											<th>状态</th>
											<th class="center" style="width: 155px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>
														   <img alt="" width="58px" height="58px"
															onerror="javascript:this.src='/statics/img/iphone6.png';"
															src="${item.headimgurl}" />
															${item.nick_name}</td>
														<td>${item.con_phone}</td>
														<td>${item.person_number}
														</td>
														<td>${item.book_time}
														</td>
														<td>${item.con_name}
														</td>
															<td>${item.book_address}
														</td>
														<td>${item.guider}</td>
														<td>${item.create_time}
														</td>
														<td>
														 <c:if test="${item.guide_status eq 1}">
														  <a class="btn btn-danger btn-rounded">等待受理</a>
														  </c:if>
														  <c:if test="${item.guide_status eq 2}">
														      <a class="btn btn-primary btn-rounded">已受理</a>
														  </c:if>
														</td>
														<td class="center">
														<a
															href="javascript:guideEdit(${item.id});"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> 
														   <a href="javascript:del('${item.id}');"
																class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
															</a>
														</td>
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
												</div>
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
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript">
		$(".tree-close-btn").trigger("click");
		function del(id){
			bootbox.confirm("确认删除该导游预约吗？删除之后数据将不可恢复！",function(result){
				if(result){
					Ajax.request("/sys/book/order/delGuide",{"data":{"id":id},
						"success":function(data){
							if(data.code == 200){
							    window.location.reload();	
							}else{
								bootbox.alert(data.msg);
							}
					}});
				}
			});
		}
	   function guideEdit(id){
		   window.location.href="/sys/book/order/guideEditPage?id="+id;
	   }
	</script>
</body>
</html>