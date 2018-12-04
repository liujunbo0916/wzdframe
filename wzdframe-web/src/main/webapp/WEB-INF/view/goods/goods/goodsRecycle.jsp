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
						<h5>商品回收站</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goods/recyclePage" method="post" name="Form" id="Form">
						    <div class="search-condition row">
								<div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">商品编号</span>
		                                <input type="text" class="form-control" name="goods_sn" value="${requestScope.page.pd.goods_sn}">
		                            </div>
                                </div>
								<div class="col-md-2">
                                    <div class="input-group">
	    	                            <span class="input-group-addon">商品名称</span>
		                                <input type="text" class="form-control" name="goods_name" value="${requestScope.page.pd.goods_name}">
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
							<div class="hr-line-dashed" style="margin: 10px 0;"></div>
							<div class="project-list">
 								<table id="simple-table" class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>商品编号</th>
											<th>商品图片</th>
											<th>商品名称</th>
											<th>商品分类</th>
											<th>商品标签</th>
											<th>商场售价</th>
											<th>库存数量</th>
											<th>是否上架</th>
											<th>创建人</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.goods_sn}</td>
														<td>
														<img width="100px" height="60px"
																		src="${SETTINGPD.IMAGEPATH}${item.list_img}" />
														</td>
														<td>${item.goods_name}</td>
														<td>
														    <c:forEach var="category" items="${categoryList}">
														         <c:if test="${item.category_id eq category.category_id}">${category.category_name}</c:if>
															</c:forEach>
														</td>
														<td>${item.goods_tags}</td>
														<td>${item.market_price}</td>
														<td>${item.goods_stock}</td>
														<td>
														    <c:if test="${item.is_on_sale == 1}">是</c:if>
                                                            <c:if test="${item.is_on_sale == 0}">否</c:if>
														</td>
														<td>${item.creator}</td>
														<td class="center" style="width: 200px;">
                       										<a href="javascript:void(0);" onclick="recycleGoods(${item.goods_id})" class="btn btn-warning btn-sm" title="回收">
                           										<i class="fa fa-recycle"></i>
                       										</a>
                       										<a href="javascript:void(0);"
																	onclick="deleteGoods(${item.goods_id})"
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
	                                            <td colspan="12">
	                                               	<div class="dataTables_paginate paging_bootstrap pull-right">
	                                               		${page.pageStr}
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
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript">
	//商品回收
	function recycleGoods(id){
		bootbox.confirm("你确定要回收该商品吗！",function(result){
			if(result){
				$.ajax({
					   type: "POST",
					   url: "/sys/goods/goods/recycleGoods",
					   dataType : "json",
					   data : {
						   goods_id: id
					   },
					   success: function(data){
						   if(data.result == 200){
					          nextPage("${page.currentPage}");
						   }else{
							   bootbox.alert(data.msg);
						   }
					   },
					   error : function(data){
						   bootbox.alert(data.msg);
						   window.location.href='/sys/goods/goods/recyclePage';
					   }
					});
			}
			
		});
	}
	
	function deleteGoods(goodsId){
		bootbox.confirm("如果删除该商品，将会删除该商品所有的信息且数据不能恢复",function(result){
			if(result){
				Ajax.request("/sys/goods/goods/thoroughDel",{"data":{"goods_id":goodsId},"success":function(data){
					if(data.result == 200){
						nextPage('${page.currentPage}');
					}else{
						bootbox.alert(data.msg);
					}
				}});
			}
		});
	}
	</script>
</body>
</html>