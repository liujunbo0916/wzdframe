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
						<h5>商品列表</h5>
						<div class="ibox-tools">
							<c:if test="${QX.add == 1}">
								<a href="/sys/goods/goods/add" class="btn btn-primary btn-xs"><i
									class="fa fa-plus"></i>&nbsp;新增</a>
							</c:if>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goods/listPage" method="post" name="Form"
							id="Form">
							<div class="search-condition row">
								<div class="col-md-1">
									<div class="input-group">
										<input type="text" placeholder="商品编号" class="form-control"
											name="goods_sn" value="${requestScope.page.pd.goods_sn}">
									</div>
								</div>
								<div class="col-md-1">
									<div class="input-group">
										<input type="text" class="form-control" placeholder="商品名称"
											placeholder="商品名称" name="goods_name"
											value="${requestScope.page.pd.goods_name}">
									</div>
								</div>
								<div class="col-md-1">
									<div class="input-group">
										<select class="form-control" name="is_on_sale">
											<option value=''>--上下架--</option>
											<option value='0'
												<c:if test="${pd.is_on_sale eq 0}">selected = 'selected'</c:if>>
												下架</option>
											<option value='1'
												<c:if test="${pd.is_on_sale eq 1}">selected = 'selected'</c:if>>
												上架</option>
										</select>
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<select class="form-control" name="is_recommend">
											<option value=''>--推荐值排序--</option>
											<option value='0'
												<c:if test="${pd.is_recommend eq 0}">selected = 'selected'</c:if>>
												升序</option>
											<option value='1'
												<c:if test="${pd.is_recommend eq 1}">selected = 'selected'</c:if>>
											           降序</option>
										</select>
									</div>
								</div>
								<div id="categoryAppend" class="col-md-5">
									<div id="categoryAppend1" class="col-md-4">
										<select class="form-control" id="category1_id"
											name="category1_id">
											<option value="">请选择一级分类</option>
											<c:forEach items="${categoryListParent}" var="category">
												<option value="${category.category_id}"
													<c:if test="${requestScope.page.pd.category1_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
												</option>
											</c:forEach>
										</select>
									</div>
									<c:if test="${not empty category2List}">
										<div id="categoryAppend2" class="col-md-4">
											<select class="form-control" id="category2_id"
												name="category2_id">
												<option value="">请选择二级分类</option>
												<c:forEach items="${category2List}" var="category">
													<option value="${category.category_id}"
														<c:if test="${pd.category2_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
													</option>
												</c:forEach>
											</select>
										</div>
									</c:if>
									<c:if test="${not empty category3List}">
										<div id="categoryAppend3" class="col-md-4">
											<select class="form-control" id="category3_id"
												name="category3_id">
												<option value="">请选择三级分类</option>
												<c:forEach items="${category3List}" var="category">
													<option value="${category.category_id}"
														<c:if test="${pd.category3_id eq category.category_id}"> selected='selected'</c:if>>${category.category_name}
													</option>
												</c:forEach>
											</select>
										</div>
									</c:if>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<c:if test="${QX.cha == 1}">
											<button class="btn btn-primary" type="submit">
												<i class="fa fa-search"></i>&nbsp;查询&nbsp;
											</button>
										</c:if>
									</div>
								</div>
							</div>
							<div class="hr-line-dashed" style="margin: 10px 0;"></div>
							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th style="width: 50px;">商品编号</th>
											<th>创建时间</th>
											<th style="width: 50px;">商品信息</th>
											<th>品牌&分类</th>
											<th>商品标签</th>
											<th>商品推荐值</th>
											<th>商品价格</th>
											<th>库存数量</th>
											<th>是否上架</th>
											<th class="center">操作</th>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:forEach items="${varList}" var="item">
													<tr>
														<td>${item.goods_sn}</td>
														<td>${item.create_time}</td>
														<td>
														<a href="/sys/goods/goods/edit?id=${item.goods_id}">
														<p>${item.goods_name}</p>
														<p><img width="100px" height="60px" onerror="this.src='/statics/img/no-img.jpg'"
																		src="${SETTINGPD.IMAGEPATH}${item.list_img}" /></p>
														</a>				
																		</td>
														<td><c:if test="${ empty item.brand_name}">
														    暂无品牌
														</c:if> <c:if test="${not empty item.brand_name}">
														  ${item.brand_name}
														</c:if> <br> <c:if test="${not empty item.category1_id}">
																<c:forEach var="category" items="${categoryList}">
																	<c:if
																		test="${item.category1_id eq category.category_id}">${category.category_name}</c:if>
																</c:forEach>
															</c:if>
															 <c:if test="${not empty item.category2_id}">
														<c:forEach var="category" items="${categoryList}">
																	<c:if
																		test="${item.category2_id eq category.category_id}">${category.category_name}</c:if>
																</c:forEach>
															</c:if> <c:if test="${not empty item.category3_id}">  >
													<c:forEach var="category" items="${categoryList}">
																	<c:if
																		test="${item.category3_id eq category.category_id}">${category.category_name}</c:if>
																</c:forEach>
															</c:if></td>
														<td>${item.goods_tags}</td>
														<td>${item.is_recommend}</td>
														<td>
														<p>销售价格：${item.shop_price}</p>
														<p>市场价格：${item.market_price}</p>
														</td>
														<td>${item.goods_stock}</td>
														<td><c:if test="${item.is_on_sale == 1}">
																<span class="label badge-info">已上架</span>
															</c:if> <c:if test="${item.is_on_sale == 0}">
																<span class="label badge-danger">未上架</span>
															</c:if></td>
														<td class="center" style="width: 200px;">
														<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="ace-icon fa fa-lock" title="无权限"></i></span>
															</c:if> 
															<c:if test="${QX.edit == 1}">
																<a href="/sys/goods/goods/edit?id=${item.goods_id}"
																	class="btn btn-primary btn-sm" title="编辑"> <i
																	class="fa fa-pencil"></i>
																</a>
															</c:if> <a href="javascript:void(0);"
															onclick="openAlbum('${item.goods_id}');"
															class="btn btn-primary btn-sm" title="相册"> <i
																class="fa fa-picture-o"></i>
														</a> <a href="javascript:void(0);"
															onclick="set_stock(${item.goods_id});"
															class="btn btn-primary btn-sm" title="入库"> <i
																class="fa fa-shopping-cart"></i>
														</a> <a href="javascript:void(0);"
															onclick="copy_goods('${item.goods_id}','${item.goods_name}')"
															class="btn btn-primary btn-sm" title="复制"> <i
																class="fa fa-venus-double"></i>
														</a> <c:if test="${item.is_on_sale == 1}">
																<a href="javascript:void(0);"
																	onclick="isSale(${item.goods_id},1);"
																	class="btn btn-primary btn-sm" title="下架"> <i
																	class="fa fa-eye"></i></a>
															</c:if> <c:if test="${item.is_on_sale == 0}">
																<a href="javascript:void(0);"
																	onclick="isSale(${item.goods_id},0);"
																	class="btn btn-danger btn-sm" title="上架"> <i
																	class="fa fa-eye-slash"></i></a>
															</c:if> 
															 <a href="/sys/goods/goods/goodsComments?goods_id=${item.goods_id}&comment_type=1"
															class="btn btn-primary btn-sm" title="评论列表"> <i
																class="fa fa-newspaper-o"></i>
														</a> 
															<c:if test="${QX.del == 1}">
																<a href="javascript:void(0);"
																	onclick="deleteGoods(${item.goods_id})"
																	class="btn btn-warning btn-sm" title="删除"> <i
																	class="fa fa-trash"></i>
																</a>
															</c:if></td>
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
													${page.pageStr}</div>
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
	<script type="text/javascript"
		src="/statics/js/user/categoryListPage.js"></script>
	<script type="text/javascript">
	//设置库存
	function set_stock(goods_id){
		var index = layer.open({
            type: 2,
            title: '商品入库',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['850px' , '600px'],
            content: "/sys/goods/goods/toSetStock?goods_id="+goods_id,
        });
		layer.full(index);
	}
	//上架
	function isSale(id,type){
		var typeStr  = (type=="1")?"下架":"上架";
		bootbox.confirm("你确定"+typeStr+"该商品吗!",function(result){
			if(result){
				 $.ajax({
					   type: "POST",
					   url: "/sys/goods/goods/saleGoods",
					   dataType : "json",
					   data:{
						   goods_id:id,
						   type:type
					   },
					   success: function(data){
						   if(data.result == 200){
					        nextPage('${page.currentPage}');
						   }else{
							   bootbox.alert(data.msg);
						   }
					   },
					   error : function(data){
							bootbox.alert(data.msg);
					   }
					});
			}
		});
	}
	//商品删除
	function deleteGoods(id){
		bootbox.confirm("你确定删除该商品吗!",function(result){
			if (result){
				$.ajax({
					   type: "POST",
					   url: "/sys/goods/goods/deleteGoods",
					   dataType : "json",
					   data : {
						   goods_id: id
					   },
					   success: function(data){
						   if(data.result==200){
					     	 nextPage('${page.currentPage}');
						   }else{
					     	 bootbox.alert(data.msg);
						   }
					   },
					 /*   error : function(data){
						  bootbox.alert(data.msg);
					   } */
					});
			 }
		});
	}
	//商品复制
	function copy_goods(goodsId,goodsName){
		bootbox.confirm("你确定复制["+goodsName+"]吗!",function(result){
			if(result){
		     Ajax.request("/sys/goods/goods/copyGoods",{"data":{"goods_id":goodsId},"success":function(data){
		    	 if(data.result == 200){
		    		 window.location.href="/sys/goods/goods/edit?id="+data.data;
		    	 }else{
		    		 bootbox.alert(data.msg);
		    	 }
		     }});
			}
		});
	}
	//商品相册
	function openAlbum(goodsIds){
		var index = layer.open({
            type: 2,
            title: '商品相册',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['850px' , '600px'],
            content: "/sys/goods/goods/album?goods_id="+goodsIds,
        });
		layer.full(index);
	}
	</script>
</body>
</html>