<%@ page language="java" contentType="text/html; charset=UTF-8"
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
					<h5>续重管理</h5>
				</div>
				<div class="ibox-content">
					<form action="/user/listUsers" method="post" name="Form" id="Form">
						<div class="search-condition row">
							<div class="col-md-2">
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
							</div>
							<div class="col-md-5">
								<div class="input-group">
									<c:if test="${QX.add == 1}">
										<button class="btn btn-primary" onclick="addcontnuheavy()"
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
									<th class="center">续重ID</th>
									<th class="center">续重名称</th>
									<th class="center">区域名称</th>
									<th class="center">续重公斤数(KG)</th>
									<th class="center">价格(元)</th>
									<th class="center">创建时间</th>
									<th class="center">操作</th>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty chlist}">
											<c:forEach items="${chlist}" var="chitem" varStatus="vs">
												<tr>
													<td class="center">${chitem.contnu_id}</td>
													<td class="center">${chitem.contnu_name}</td>
													<td class="center">${chitem.area_name}</td>
													<td class="center">${chitem.contnu_kg}</td>
													<td class="center">${chitem.contnu_price}</td>
													<td class="center">${chitem.create_time}</td>
													<td class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
														<div class="hidden-sm hidden-xs btn-group">
															<c:if test="${chlist.size()>0}">
																<c:if test="${QX.edit == 1}">
																	<a class="btn btn-xs btn-success" title="编辑"
																		onclick="updatecontnuheavy(${chitem.contnu_id});">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"
																		title="编辑"></i>
																	</a>
																</c:if>
																<c:if test="${QX.del == 1}">
																	<a class="btn btn-xs btn-danger"
																		onclick="delcontnuheavy(${chitem.contnu_id});"> <i
																		class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																	</a>
																</c:if>
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
	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up"
		class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
	<script type="text/javascript">
	
	function addcontnuheavy() {
		layer.open({
			type : 2,
			title : '添加续重',
			shadeClose : true,
			shade : 0.5,
			area : [ '450px', '620px' ],
			content : 'logistics/setcontnuheavy'
		});
	};
	
	function updatecontnuheavy(contnu_id) {
		layer.open({
			type : 2,
			title : '编辑区域',
			shadeClose : true,
			shade : 0.5,
			area : [ '450px', '620px' ],
			content : 'logistics/setcontnuheavy?contnu_id=' + contnu_id
		});
	};
	
	function delcontnuheavy(contnu_id){
		if(window.confirm("您确定要删除吗？")){
			Ajax.request("/logistics/delcontnuheavy",{"data":{"contnu_id":contnu_id},"success":function(data){
				   if(data.result == "200"){
					   bootbox.alert("删除成功！");
					   window.location.reload();
				   }else{
					   bootbox.alert("删除失败！");
				   }
				}});
		}
	
		}

	
	
	</script>

</body>
</html>
