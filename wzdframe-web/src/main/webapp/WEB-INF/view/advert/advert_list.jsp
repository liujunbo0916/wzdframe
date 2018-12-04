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
					<h5>广告列表</h5>
				</div>
				<div class="ibox-content">
					<form action="" method="post" name="Form" id="Form">
						<div class="search-condition row">
							<div style="float: right; margin-right: 50px">
								<div class="input-group">
									<a href="/sys/advert/editadvert?ad_id=0"
										class="btn btn-primary btn-xs"> <i class="fa fa-plus"></i>&nbsp;添加
									</a>
								</div>
							</div>
						</div>
						<div class="hr-line-dashed" style="margin: 10px 0;"></div>
						<div class="project-list">
							<table id="simple-table" class="table table-bordered">
								<thead>
									<tr>
										<th class="center">广告ID</th>
										<th class="center">广告位置</th>
										<th class="center">开始时间</th>
										<th class="center">结束时间</th>
										<th class="center">广告显示图片</th>
										<th class="center">广告链接</th>
										<th class="center">广告类型</th>
										<th class="center">推荐值</th>
										<th class="center">关联类型</th>
										<th class="center">关联商品/门票/线路/景点ID</th>
										<th class="center">浏览量</th>
										<th class="center">创建时间</th>
										<th class="center">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty advertlist}">
											<c:forEach items="${advertlist}" var="item" varStatus="vs">
												<tr>
													<td>${item.ad_id}</td>
													<td>${item.ap_name}</td>
													<td class="center">${item.ad_begin_time}</td>
													<td class="center">${item.ad_end_time}</td>
													<td class="center"><img
														src="${SETTINGPD.IMAGEPATH}${item.ad_display}"
														height="100" width="200"></td>
													<td class="center">${item.ad_url}</td>
													<td class="center"><c:if test="${item.ad_type eq 0}">内部广告</c:if>
														<c:if test="${item.ad_type eq 1}">外部广告</c:if></td>
														<td class="center">${item.is_recommend}</td>
													<td class="center"><c:if
															test="${empty item.ad_relation_type}">无</c:if> <c:if
															test="${item.ad_relation_type eq 1}">特产</c:if> <c:if
															test="${item.ad_relation_type eq 2}">门票</c:if> <c:if
															test="${item.ad_relation_type eq 3}">线路</c:if> <c:if
															test="${item.ad_relation_type eq 4}">景点</c:if></td>
													<td class="center"><c:if
															test="${empty item.ad_relation_type}">无</c:if> <c:if
															test="${not empty item.ad_relation_id }">${item.ad_relation_id}</c:if>
													</td>
													<td class="center">${item.ad_page_views}</td>
													<td class="center">${item.ad_create_time}</td>
													<td>
														<div class="hidden-sm hidden-xs btn-group">
															<c:if test="${advertlist.size()>0}">
																<a href="/sys/advert/editadvert?ad_id=${item.ad_id}"
																	class="btn btn-xs btn-success"
																	style="margin-right: 10px;" title="编辑"> <i
																	class="ace-icon fa fa-pencil-square-o bigger-120"
																	title="编辑"></i>
																</a>
																<a href="javascript:void(0)"
																	onclick="deladvert('${item.ad_id}')"
																	class="btn btn-xs btn-danger"> <i
																	class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																</a>
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
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
</body>

<script type="text/javascript">

	
	
	//广告删除
	function deladvert(ad_id){
		bootbox.confirm("你确定要删除该广告吗！",function(result){
			if (result){
				$.ajax({
					   type: "POST",
					   url: "/sys/advert/deladvert",
					   dataType : "json",
					   data : {
						   ad_id: ad_id
					   },
					   success: function(data){
						   if(data.result == 200){
					          window.location.href='/sys/advert/desclist';
						   }else{
							   bootbox.alert(data.msg );
						   }
					   }
					});
			 }
		});
	}
</script>
</html>
