<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<link href="/assets/css/plugins/datetimepicker/bootstrap-datetimepicker.css" rel="stylesheet"/>
	<%@ include file="../../common/top.jsp"%>
</head>
<body>
 <div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>系统日志</h5>
					</div>
					<div class="ibox-content">
						<form action="list" method="post" name="Form" id="Form">
							<div class="search-condition row">
                                <div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">日志标题</span>
		                                <input type="text" class="form-control" name="title" id="title" value="${requestScope.page.pd.title }"/>
		                            </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">操作者ip</span>
		                                <input type="text" class="form-control" name="remote_addr" id="remote_addr" value="${requestScope.page.pd.remote_addr }"/>
		                            </div>
                                </div>
                                <div class="col-md-5"> 
                                <div class="input-group">
                                    <span class="input-group-addon">操作时间</span>
									<div class="input-group date" style="float: left;" id="startTime">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
										<input type="text" class="form-control date" style="width: 180px;" name="startTime" readonly="readonly"
											id="createMinTime" value="${requestScope.page.pd.startTime}">
									</div>
									<div class="input-group" style="float: left;">
										<span class="input-group-addon" style="height: 34px;">到</span>
									</div>
									<div class="input-group date" style="float: left;" id="endTime">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										<input type="text" class="form-control date" style="width: 180px;" name="endTime" readonly="readonly"
											id="createMaxTime" value="${requestScope.page.pd.endTime}">
									</div>
								</div>
								</div>
                                <div class="col-md-1">
                                    <div class="input-group">
	    	                           <button class="btn btn-primary" type="submit" id="query_button_id">
											<i class="fa fa-search"></i>&nbsp;查询&nbsp;
										</button>
		                            </div>
                                </div>
							</div>
							<div class="hr-line-dashed" style="margin: 20px 0;"></div>
						
							<div class="project-list">
 								<table id="simple-table" class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>操作菜单</th>
											<th>操作者用户名</th>
											<th>操作者姓名</th>
											<th>URI</th>
											<th>提交方式</th>
											<th>操作者ip</th>
											<th>操作时间</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty requestScope.data}">
												<c:forEach items="${requestScope.data}" var="item">
													<tr>
														<td>${pageScope.item.title}</td>
														<td>${pageScope.item.user.USERNAME}</td>
														<td>${pageScope.item.user.NAME}</td>
														<td>${pageScope.item.requestUri}</td>
														<td>${pageScope.item.method}</td>
														<td>${pageScope.item.remoteAddr}</td>
														<td><fmt:formatDate value="${pageScope.item.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
	                                            <td colspan="8">
	                                               	<div class="dataTables_paginate paging_bootstrap pull-right">
	                                               		${requestScope.page.pageStr}
													</div>	
	                                            </td>
	                                        </tr>
	                                    </tfoot>
								</table>
							</div>
						</form>
						
						<form action="/custodian" id="myForm" method="post">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/plugins/datetimepicker/bootstrap-datetimepicker.js"></script>
	<script src="/assets/js/plugins/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
		function temp(id){
			if(confirm("确定要删除吗")){
				location.href="/custodian/delete/"+id;
			}else{
				return false;
			}
		}
		$("#startTime").datetimepicker({
			format: "yyyy-mm-dd hh:ii",
	        autoclose: true,
	        todayBtn: true,
	        minuteStep: 10,
	        language:"zh-CN"
		});
		$("#endTime").datetimepicker({
			format: "yyyy-mm-dd hh:ii",
	        autoclose: true,
	        todayBtn: true,
	        minuteStep: 10,
	        language:"zh-CN"
		});
	</script>
</body>
</html>