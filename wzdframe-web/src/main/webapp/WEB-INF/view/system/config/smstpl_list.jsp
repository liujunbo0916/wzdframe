﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../common/top.jsp"%>
</head>
<body class="no-skin">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<div class="ibox-title">
					<h5>短信模板列表</h5>
				</div>
				<div class="ibox-content">
					<form action="/user/listUsers" method="post" name="Form" id="Form">
						<div class="search-condition row">
						<%-- 	<div class="col-md-2">
								<div class="input-group">
									<span class="input-group-addon">关键字</span> <input type="text"
										name="keywords" value="${pd.keywords }" class="form-control">
								</div>
							</div>
							<div class="col-md-2">
								<div class="input-group">
									<button class="btn btn-primary" onclick="User.submitForm();"
										type="button" id="query_button_id">
										<i class="fa fa-search"></i>&nbsp;查询&nbsp;
									</button>
								</div>
							</div> --%>
							<div class="col-md-5">
								<div class="input-group">
									<c:if test="${QX.add == 1}">
										<button class="btn btn-primary" onclick="addSmsTpl()"
											type="button">
											<i class="fa fa-plus"></i>&nbsp;添加
										</button>
									</c:if>
								</div>
							</div>
						</div>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<th class="center">短信模板ID</th>
									<th class="center">短信模板标题</th>
									<th class="center">短信模板内容</th>
									<th class="center">短信模板编号</th>
									<th class="center">操作</th>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty smsTpllist}">
											<c:forEach items="${smsTpllist}" var="item" varStatus="vs">
												<tr>
													<td class="center">${item.id}</td>
													<td class="center">${item.tpl_title}</td>
													<td class="center">${item.tpl_content}</td>
													<td class="center">${item.tpl_var}</td>
													<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
														<div class="hidden-sm hidden-xs btn-group">
															<c:if test="${smsTpllist.size()>0}">
																<c:if test="${QX.edit == 1}">
																	<a class="btn btn-xs btn-success" title="编辑"
																		onclick="updateSmsTpl(${item.id});">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"
																		title="编辑"></i>
																	</a>
																</c:if>
																 <%-- <c:if test="${QX.del == 1}">
																	<a class="btn btn-xs btn-danger"
																		onclick="delcontnuheavy(${item.id});"> <i
																		class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																	</a>
																</c:if>  --%>
															</c:if>
														</div>
													</td>
												</tr>

											</c:forEach>
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="10" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="10" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="11" style="vertical-align: top;">
											<div class="pagination"
												style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
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

	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
	<script type="text/javascript">
	
	function addSmsTpl() {
		layer.open({
			type : 2,
			title : '添加短信模板信息',
			shadeClose : true,
			shade : 0.5,
			area : [ '600px', '620px' ],
			content : '/cfg/smsTplAddEdit'
		});
	};
	
	function updateSmsTpl(id) {
		layer.open({
			type : 2,
			title : '编辑短信模板信息',
			shadeClose : true,
			shade : 0.5,
			area : [ '600px', '620px' ],
			content : '/cfg/smsTplAddEdit?id=' + id
		});
	};
	
	/*  function delcontnuheavy(id){
		if(window.confirm("您确定要删除吗？")){
			Ajax.request("/cfg/delcontnuheavy",{"data":{"id":id},"success":function(data){
				   if(data.result == "200"){
					   bootbox.alert("删除成功！");
					   window.location.reload();
				   }else{
					   bootbox.alert("删除失败！");
				   }
				}});
			}
		}  */

	
	
	</script>

</body>
</html>
