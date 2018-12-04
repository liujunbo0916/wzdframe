
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
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="slimScrollDiv"
							style="position: relative; width: auto; height: 100%;">
							<div class="full-height-scroll"
								style="width: auto; height: 100%;">
								<div class="table-responsive">
									<table class="table table-striped table-hover">
										<tbody>
										
										    <c:choose>
										    <c:when test="${empty tracks}">
										       <tr>
										         <td colspan="4">暂无物流信息</td>
										       </tr>
										    </c:when>
										    <c:otherwise>
										         <c:forEach items="${tracks.traces}" var="item">
												<tr>
													<td colspan="3"  class="client-avatar">${item.acceptTime}</td>
													<td colspan="3">${item.acceptStation}</td>
												</tr>
											</c:forEach>
										    </c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
