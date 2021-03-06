<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<form action="/sys/scenic/list" method="post" name="Form"
						id="Form">
						<div class="ibox-title">
							<h5>景区列表</h5>
							<div class="ibox-tools">
								<a href="/sys/scenic/editPage" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增景区</a>
							</div>
						</div>
						<div class="ibox-content">
							<div class="search-condition row">
							<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">景区名称：</span> <input type="text"
											name="scenic_name" class="form-control" value="${pd.scenic_name}">
									</div>
								</div>
								<div class="col-md-1">
									<select class="form-control" name="scenic_status">
										<option value=''>景区状态</option>
										<option value='1'
											<c:if test="${pd.scenic_status eq 1}">selected = 'selected'</c:if>>
											正常</option>
										<option value='2'
											<c:if test="${pd.scenic_status eq 2}">selected = 'selected'</c:if>>
											隐藏</option>
									</select>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<button class="btn btn-primary" type="submit">
											<i class="fa fa-search"></i>&nbsp;查询&nbsp;
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="ibox-content">
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>景区名称</th>
											<th>景区图片</th>
											<th>景区分类</th>
											<th>景区地址</th>
											<th>景区半径</th>
											<th>联系电话</th>
											<th>营业时间</th>
											<th>点击量</th>
											<th>状态</th>
											<th class="center" style="width: 200px">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.scenic_name}</td>
														<td><img alt="" width="50px" height="45px"
															src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}" onerror="this.src='/statics/img/no-img.jpg'"></td>
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
														<td class="center">
														<a class="btn btn-xs btn-light"> 
														<i class="glyphicon glyphicon-link" id="copy" title="复制链接到剪贴板" data-clipboard-text="m.aiwzd.cn/wx/scenic/detail?id=${item.id}"></i>
													</a>
														<%-- <c:if test="${QX.edit == 1}"> --%>
														<a
															href="/sys/scenic/editPage?id=${item.id}"
															class="btn btn-primary btn-sm" title="编辑"> <i
																class="fa fa-pencil"></i>
														</a> 
														<%-- </c:if> --%>
														<a href="javascript:void(0);"  onclick="openAlbum('${item.id}');" class="btn btn-primary btn-sm" title="相册">
															<i class="fa fa-picture-o"></i>
														</a>
														<a
															href="javascript:del('${item.id}','${item.scenic_name}');" 
															class="btn btn-warning btn-sm" title="删除"> <i
																class="fa fa-trash"></i>
														</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="12" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="12">
												<div class="dataTables_paginate paging_bootstrap pull-right">
													${page.pageStr}</div>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
		<script  src="/assets/js/plugins/clipboard/dist/clipboard.min.js"></script>
		<script type="text/javascript">
		
	    var clipboard = new Clipboard('#copy');
		clipboard.on('success', function(e) {
		    console.info('Action:', e.action);
		    console.info('Text:', e.text);
		    console.info('Trigger:', e.trigger);
		    layer.alert('链接：'+e.text+'\n已复制到剪贴板中', {icon: 6});
	        console.log(e);
		    e.clearSelection();
		});
		 
		clipboard.on('error', function(e) {
		    console.error('Action:', e.action);
		    console.error('Trigger:', e.trigger);
		}); 
		
		
		//景区相册
		function openAlbum(scenic_id){
			var index = layer.open({
	            type: 2,
	            title: '景区相册',
	            maxmin: true,
	            shadeClose: true, //点击遮罩关闭层
	            area : ['850px' , '600px'],
	            content: "/sys/scenic/albums?scenic_id="+scenic_id,
	        });
			layer.full(index);
		}
		function del(scenic_id,name){
			
			bootbox.confirm("确定删除"+name,function(result){
				if(result){
					Ajax.request("/sys/scenic/del",{"data":{"scenic_id":scenic_id},"success":function(data){
						if(data.result == 200){
							bootbox.alert("成功删除");
							nextPage("${page.currentPage}");
						}
					}});
				}
			});
		}
	</script>
</body>
</html>