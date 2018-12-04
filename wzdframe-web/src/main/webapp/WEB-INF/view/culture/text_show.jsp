<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<!-- jsp文件头和头部 -->
		<%@ include file="../common/top.jsp"%>
<!-- 日期框 -->
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<!-- 检索  -->
						<form action="/sys/content/list.do" method="post" name="Form" id="Form">
						<!-- 检索  -->
					    <div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center">标题</th>
									<th class="center">列表图</th>
									<th class="center">摘要</th>
									<th class="center">点击量</th>
									<th class="center">状态</th>
									<th class="center">创建人</th>
									<th class="center">创建时间</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty albumModel}">
									<c:forEach items="${albumModel}" var="var" varStatus="vs">
										<tr>
											<td class='left'>${var.TITLE}</td>
											<td class='center'><img style="width:100px;height:100px" src="${SETTINGPD.IMAGEPATH}${item.T_IMG}">
											</td>
											<td class='center'>${var.ABSTRACT}</td>
											<td class='center'>${var.CLICKS}</td>
											<td class='center'>
												<c:if test="${var.STATE eq '-1'}">
													<span class="badge">暂存草稿</span>
												</c:if>
												<c:if test="${var.STATE eq '1'}">
													<span class="badge badge-success">发布上线</span>
												</c:if>
												<c:if test="${var.STATE eq '2'}">
													<span class="badge badge-warning">等待发布</span>
												</c:if>
												<c:if test="${var.STATE eq '4'}">
													<span class="badge btn-danger">发布驳回</span>
												</c:if>
											</td>
											<td class='left'>${var.CREATOR}</td>
											<td class='center'><fmt:formatDate value="${var.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													<%-- <a class="btn btn-xs btn-light"> 
														<i class="glyphicon glyphicon-link" id="copy" title="复制链接到剪贴板" data-clipboard-text="<%=basePath%>${CATEGORY_TYPE eq 'ZX' ? 'appnews/newsdetail' : 'appreads/readsdetail'}?CONTENT_ID=${var.CONTENT_ID}"></i>
													</a> --%>
														<a href="javascript:edit('${var.CONTENT_ID}');" class="btn btn-primary btn-sm" title="编辑">
                           										<i class="fa fa-pencil"></i>
                       									</a>
															<a href="javascript:void(0);" onclick="del('${var.CONTENT_ID}','${var.STATE}');" class="btn btn-warning btn-sm" title="删除">
                           										<i class="fa fa-trash"></i>
                       										</a>
													<input type="hidden" id="#foo${vs.index+1}" value="${var.LINK}">
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto" >
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<li>
																<a style="cursor:pointer;" href="javascript:edit('${var.CONTENT_ID}');"  class="tooltip-success" data-rel="tooltip" title="编辑">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															<li>
																<a style="cursor:pointer;"  onclick="del('${var.CONTENT_ID}','${var.STATE}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script type="text/javascript">
		//检索
		function tosearch(){
			$("#Form").submit();
		}
		//删除
		function del(Id,status){
			bootbox.confirm('确定要删除吗?只有是"草稿"状态的资讯才会被删除,"等待发布"的资讯会被删除成草稿。"发布"的资讯不能执行删除操作', function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>content/delete.do?CONTENT_ID="+Id+"&STATE="+status+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage('${page.currentPage}');
					});
				}
			});
		}
		function edit(contentId){
			var title = "添加文章";
			var url = "<%=basePath%>sys/content/goEdit.do";
			if(contentId){
				title = "编辑文章";
				url = '<%=basePath%>sys/content/goEdit.do?CONTENT_ID='+contentId;
			}
			var index = layer.open({
				  type: 2,
				  title: '<font color="gray" size="3px"><strong>'+title+'</strong></font>',
				  content: url,
				  area: ['300px', '195px'],
				  maxmin: true
				});
			layer.full(index);
		}
	</script>


</body>
</html>