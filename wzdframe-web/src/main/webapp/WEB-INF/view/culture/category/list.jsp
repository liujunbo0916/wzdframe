<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>文化分类</h5>
						<div class="ibox-tools">
						<a href="/sys/culture/category/editPage"
							class="btn btn-primary btn-xs"> <i class="fa fa-plus"></i>&nbsp;新增</a>
					</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/user/listPage" method="post" name="Form"
							id="Form">
							<div class="project-list">
								<table 
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>名称</th>
											<th>分类logo</th>
											<th>类型</th>
											<th>创建时间</th>
											<th>状态</th>
											<th class="center" style="width: 155px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>
															${item.culture_category_name}</td>
														<td><img alt="" width="116px" height="58px"
															onerror="javascript:this.src='/statics/img/iphone6.png';"
															src="${SETTINGPD.IMAGEPATH}${item.culture_category_logo}" /></td>
														
														<td>
														  <c:if test="${item.culture_category_type eq 1}">
														     
														     <button class="btn btn-primary dim" type="button">视频</button>
														  </c:if>
														  <c:if test="${item.culture_category_type eq 2}">
														     <button class="btn btn-success  dim" type="button">音频</button>
														  </c:if>
														  <c:if test="${item.culture_category_type eq 3}">
														    <button class="btn btn-info  dim" type="button">图片</button>   
														  </c:if>
														  <c:if test="${item.culture_category_type eq 4}">
														       <button class="btn btn-warning  dim" type="button">文本</button>   
														  </c:if>
														</td>
														<td>
														   ${item.culture_category_time}
														</td>
														<td>
														  <c:if test="${item.culture_category_status eq 1}">
														  <a class="btn btn-primary btn-rounded">正常</a>
														  </c:if>
														  <c:if test="${item.culture_category_status eq 2}">
														      <a class="btn btn-danger btn-rounded">隐藏</a>
														  </c:if>
														</td>
														<td class="center"><a
															href="/sys/culture/category/editPage?id=${item.id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> 
														<a href="javascript:addResource('${item.id}');"
															class="btn btn-primary btn-sm" title="上传资料"> <i
																class="fa fa-database"></i>
														</a>
														<c:if test="${item.culture_category_status eq 1}">
															<a href="javascript:del('${item.id}');"
																class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
															</a>
														</c:if>
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
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript">
		$(".tree-close-btn").trigger("click");
		function del(id){
			bootbox.confirm("确认删除该类目？删除之后前端将无法显示！",function(result){
				if(result){
					Ajax.request("/sys/culture/category/delete",{"data":{"id":id},
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
	   function addResource(id){
		  // window.location.href="/sys/culture/resource/addPage?id="+id;
		      var index = layer.open({
	            type: 2,
	            title: '资源文件',
	            maxmin: true,
	            shadeClose: true, //点击遮罩关闭层
	            area : ['850px' , '600px'],
	            content: "/sys/culture/resource/addPage?id="+id
	        });
			layer.full(index); 
	   }
	</script>
</body>
</html>