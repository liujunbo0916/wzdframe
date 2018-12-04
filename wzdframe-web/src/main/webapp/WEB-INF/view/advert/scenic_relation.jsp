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
<%@ include file="../common/top.jsp"%>
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
						<form action="/sys/advert/advertcourses" method="post"
							class="form-horizontal m-t" id="commentForm">
							<div class="form-group">
								<label class=" control-label"><font color="red"
									size="3px" style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品列表：</label>
							</div>

							<!-- 开始循环 -->
							<div class="form-group">
								<div class="col-sm-12">
									<table id="simple-table"
										class="center table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${not empty dataModel}">
												<thead>
													<tr>
														<th></th>
														<th>景区名称</th>
														<th>景区图片</th>
														<th>景区分类</th>
														<th>景区地址</th>
														<th>景区半径</th>
														<th>联系电话</th>
														<th>营业时间</th>
														<th>点击量</th>
														<th>状态</th>
													</tr>
												</thead>

												<tbody>
													<!-- 开始循环 -->
													<c:forEach items="${dataModel}" var="item">
														<tr>
															<td><input type="radio"
																<c:if test="${item.id == ad_relation_id}">
								                        			checked
								                     			 </c:if>
																name="ad_relation_id" id="ad_relation_id"
																value="${item.id}"></td>
															<td>${item.scenic_name}</td>
															<td><img alt="" width="50px" height="45px"
																src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}"></td>
															<td>${item.category_name}</td>
															<td>${item.scenic_address}</td>
															<td>${item.scenic_radius}</td>
															<td>${item.scenic_phone}</td>
															<td>${item.scenic_business_time}</td>
															<td>${item.scenic_click}</td>
															<td><c:if test="${item.scenic_status eq 1}">
																	<span class="label label-primary">正常</span>
																</c:if> <c:if test="${item.scenic_status eq 2}">
																	<span class="label label-danger">隐藏</span>
																</c:if></td>
														</tr>
													</c:forEach>
												</tbody>
												<tfoot>
													<tr>
														<td colspan="12">
															<div
																class="dataTables_paginate paging_bootstrap pull-right">
																${page.pageStr}</div>
														</td>
													</tr>
												</tfoot>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="12" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</table>
								</div>
							</div>
							<c:if test="${not empty dataModel}">
								<div class="form-group">
									<div class="col-sm-4 col-sm-offset-3" style="margin-top: 20px">
										<button class="btn btn-primary" type="button" onclick="sub();">
											<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
										</button>
										<button class="btn btn-warning" onclick="closed();">
											<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
										</button>
									</div>
								</div>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		var index = parent.layer.getFrameIndex(window.name);
		function closed() {
			parent.layer.close(index);
		}
		function sub() {
			var scenic_is_ticket = '${pd.scenic_is_ticket}';
			if (scenic_is_ticket == 1) {//门票景点
				if ($(":radio:checked").length == 0) {
					bootbox.alert("请选择关联景点门票");
					return;
				}
			} else if (scenic_is_ticket == '') {//景点
				if ($(":radio:checked").length == 0) {
					bootbox.alert("请选择关联景点");
					return;
				}
			} else {
				bootbox.alert("类型有误，请联系管理员！");
				return;
			}
			var id = $("input[name='ad_relation_id']:checked").val();
			parent.pullScenicData(id);
			closed();
		}
	</script>
</body>
</html>