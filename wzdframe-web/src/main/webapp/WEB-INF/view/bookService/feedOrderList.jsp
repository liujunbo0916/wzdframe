<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/webuploader.css">
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/style.css">
<link href="/assets/css/plugins/blueimp/css/blueimp-gallery.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>反馈订单</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/user/listPage" method="post" name="Form"
							id="Form">
							<div class="project-list">
								<table 
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
										    <th>反馈用户</th>
											<th>反馈标题</th>
											<th>反馈内容 </th>
											<th>反馈图片</th>
											<th>提交时间</th>
											<th>后台回复</th>
											<th>处理状态</th>
											<th class="center" style="width: 155px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>
														   <img alt="" width="58px" height="58px"
															onerror="javascript:this.src='/statics/img/iphone6.png';"
															src="${item.headimgurl}" />
															${item.nick_name}</td>
														<td>
														
															${item.title}</td>
														<td>${item.content}</td>
														<td>
														<div class="lightBoxGallery">
														<c:forEach items="${fn:split(item.imgs,',')}" var="img">
									<div style="float:left;width: 50px; height: 50px;margin-left:10px;">
										<a href="${SETTINGPD.IMAGEPATH}${img}" style="position: relative;" data-gallery=""> 
										<img class="album_p" style="width: 50px; height: 50px;" src="${SETTINGPD.IMAGEPATH}${img}">
										</a>
									</div>
							</c:forEach>
							<div id="blueimp-gallery" class="blueimp-gallery" style="display: none;">
								<div class="slides" style="width: 61200px;"></div>
								<h3 class="title">图片</h3>
								<a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a>
								<a class="play-pause"></a>
								<ol class="indicator"></ol>
							</div>
						</div>
														</td>
														<td>${item.create_time}
														</td>
														<td>${item.replay}
														</td>
															<td>
																 <c:if test="${empty item.status || item.status eq 1}">
														  <a class="btn btn-primary btn-rounded">等待受理</a>
														  </c:if>
														  <c:if test="${item.status eq 2}">
														      <a class="btn btn-danger btn-rounded">已受理</a>
														  </c:if>
														</td>
														<td class="center">
														 <c:if test="${empty item.status ||item.status eq 1}">
															<a
																href="javascript:acceptance(${item.id});"
																class="btn btn-primary btn-sm" title="受理"> <i
																	class="fa fa-pencil"></i>
															</a> 
														</c:if>
														   <a href="javascript:del('${item.id}');"
																class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
															</a>
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
												</div>
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
	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
		<script type="text/javascript"
		src="/statics/image-upload/dist/webuploader.js"></script>
	<script type="text/javascript" src="/statics/image-upload/upload.js"></script>
	<script src="/assets/js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>
	<script type="text/javascript">
		$(".tree-close-btn").trigger("click");
		function del(id){
			bootbox.confirm("确认删除该导游预约吗？删除之后数据将不可恢复！",function(result){
				if(result){
					Ajax.request("/sys/book/order/delFeed",{"data":{"id":id},
						"success":function(data){
							if(data.code == 200){
							    window.location.reload();	
							}else{
								bootbox.alert(data.msg);
							}
					}});
				}
			});
		}
	   function acceptance(id){
		   var index = layer.open({
	            type: 2,
	            title: '反馈受理',
	            maxmin: true,
	            shadeClose: true, //点击遮罩关闭层
	            area : ['750px' , '500px'],
	            content: "/sys/book/order/acceptancePage?id="+id
	        }); 
	   }
	</script>
</body>
</html>