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
					<h5>物流列表</h5>
				</div>
				<div class="ibox-content">
					<form action="/logistics/arealist" method="post" name="Form"
						id="Form">
				<%-- 		<div class="search-condition row" >
							<div class="col-md-2" >
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
									<button class="btn btn-primary" onclick="User.add()"
										type="button">
										<i class="fa fa-plus"></i>&nbsp;添加
									</button>
								</div>
							</div>
						</div> --%>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th class="center">区域ID</th>
										<th class="center">区域名称</th>
										<th class="center">目的地</th>
										<th class="center">首重(KG)</th>
										<th class="center">首重价格(元)</th>
										<th class="center">续重(KG:元)</th>
										<th class="center">到达时间（天）</th>
										<th class="center">创建时间</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty areaList}">
											<c:forEach items="${areaList}" var="aeraitem" varStatus="vs">
												<tr>
													<td>${aeraitem.area_id}</td>
													<td>${aeraitem.area_name}</td>
													<td style="text-align: left !important;"><c:forEach items="${aeraitem.pclist}" var="pitem">
															<p>${pitem.cName }</p>
														</c:forEach></td>
													<td class="center">${aeraitem.first_kg}</td>
													<td class="center">${aeraitem.first_price}</td>
													<td>
													<c:forEach items="${aeraitem.chlist}" var="citem">
															<p>${citem.contnuName}: ${citem.contnuPrice} 元</p>
													</c:forEach></td>
													<td class="center">${aeraitem.send_time}</td>
													<td class="center">${aeraitem.create_time}</td>
													
													
													
													
												<%-- 	<td>
														<div class="hidden-sm hidden-xs btn-group">
															<c:if test="${areaList.size()>0}">
																<a class="btn btn-xs btn-success" title="编辑"
																	onclick="updatearea(${aeraitem.area_id});"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"
																	title="编辑"></i>
																</a>
																<a class="btn btn-xs btn-danger"
																	onclick="delarea(${aeraitem.area_id});"> <i
																	class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																</a>
															</c:if>
														</div>
													</td> --%>
												</tr>
											</c:forEach>
											<c:if test="${QX.chas == 0 }">
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

</body>
</html>
