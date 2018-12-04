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
<%@ include file="../common/top.jsp"%>
</head>
<body class="no-skin">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<div class="ibox-title">
					<h5>广告位管理</h5>
				</div>
				<div class="ibox-content">
					<form action="" method="post" name="Form" id="Form">
						<div class="search-condition row">
							<div  style="float:right;margin-right: 50px">
								<div class="input-group">
									<button class="btn btn-primary" onclick="addadvposition()"
										type="button">
										<i class="fa fa-plus"></i>&nbsp;添加
									</button>
								</div>
							</div>
						</div>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<th class="center">广告位置ID</th>
									<th class="center">广告唯一标识</th>
									<th class="center">广告位置</th>
									<th class="center">广告描述</th>
									<th class="center">广告价格</th>
									<th class="center">创建时间</th>
									<th class="center">操作</th>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty advplist}">
											<c:forEach items="${advplist}" var="item" varStatus="vs">
												<tr>
													<td class="center">${item.ap_id}</td>
													<td class="center">${item.ap_code}</td>
													<td class="center">${item.ap_name}</td>
													<td class="center">${item.ap_desc}</td>
													<td class="center">${item.ap_price}</td>
													<td class="center">${item.ap_create_time}</td>
													<td class="center">
														<div class="hidden-sm hidden-xs btn-group">
															<c:if test="${advplist.size()>0}">
																<a class="btn btn-xs btn-success" title="编辑" style="margin-right: 10px"
																	onclick="updateadvposition(${item.ap_id});"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"
																	title="编辑"></i>
																</a>
																<%-- <a class="btn btn-xs btn-danger" 
																	onclick="deladvposition(${item.ap_id});"> <i
																	class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																</a> --%>
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
	<%@ include file="../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
	<script type="text/javascript">
	
	function addadvposition() {
		layer.open({
			type : 2,
			title : '添加广告位置',
			shadeClose : true,
			shade : 0.5,
			area : [ '450px', '620px' ],
			content : '/sys/advert/editposition'
		});
	};
	
	function updateadvposition(ap_id) {
		layer.open({
			type : 2,
			title : '编辑广告位置',
			shadeClose : true,
			shade : 0.5,
			area : [ '450px', '620px' ],
			content : '/sys/advert/editposition?ap_id=' + ap_id
		});
	};
	
	function deladvposition(ap_id){
		if(window.confirm("您确定要删除吗？")){
			Ajax.request("/sys/advert/deladvposition",{"data":{"ap_id":ap_id},"success":function(data){
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
