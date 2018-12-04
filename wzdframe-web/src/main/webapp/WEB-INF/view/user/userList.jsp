<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
</head>
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>会员列表</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/user/listPage" method="post" name="Form"
							id="Form">
							<div class="search-condition row">
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" placeholder="注册开始时间"
											class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="start_create_time" id="startDate" readonly="readonly"
											value='<fmt:formatDate value="${pd.start_create_time}" pattern="yyyy-MM-dd"/>'>
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<input type="text" placeholder="注册结束时间"
											class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="end_create_time" id="endDate" readonly="readonly"
											value='<fmt:formatDate value="${pd.end_create_time}" pattern="yyyy-MM-dd"/>'>
									</div>
								</div>
								<div class="col-md-2">
										<div class="input-group">
											<button class="btn btn-primary" type="submit">
												<i class="fa fa-search"></i>&nbsp;查询&nbsp;
											</button>
										</div>
									</div>
							</div>
						</form>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table"
								class="center table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>微信头像</th>
										<th>微信昵称</th>
										<th>注册时间</th>
										<th>关注状态</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty varList}">
											<c:forEach items="${varList}" var="item">
												<tr>
													<td>
																<img alt="" width="58px" height="58px"
																	onerror="javascript:this.src='/statics/img/iphone6.png';"
																	src="${item.headimgurl}" />
													</td>
													<td>  <span class="label label-primary">${item.nick_name }</span>
													</td>
													<td>${item.subscribe_time}</td>
														<td><c:choose>
															<c:when
																test="${empty item.subscribe || !item.subscribe}">
																<span class="label label-danger">未关注</span>
															</c:when>
															<c:when test="${item.subscribe}">
																<span class="label label-success">已关注</span>
															</c:when>
														</c:choose>
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
												${page.pageStr}</div>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script src="/statics/plugin/treeGrid.js"></script>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<script type="text/javascript">
	$.jeDate("#startDate",{
		format:"YYYY-MM-DD",
		isTime:true//isClear:false,
	});
	$.jeDate("#endDate",{
		format:"YYYY-MM-DD",
		isTime:true//isClear:false,
	});
	$(".tree-close-btn").trigger("click"); 
	function openUploadPanel(id){
		layer.open({
			  type: 2,
			  title: '会员地址薄',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['580px', '380px'],
			  content: '/sys/user/userAddressList?userId='+id
			});
	}
	function openUploadBank(id){
		layer.open({
			  type: 2,
			  title: '绑定银行卡',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['580px', '380px'],
			  content: '/sys/user/userWithdraw/listBinding?user_id='+id
			});
	}
	</script>
</body>
</html>