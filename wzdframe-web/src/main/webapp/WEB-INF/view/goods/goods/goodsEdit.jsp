<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
<style type="text/css">
.file-pick {
	font-size: 18px;
	background: #00b7ee;
	border-radius: 3px;
	line-height: 44px;
	padding: 0 30px;
	color: #fff;
	display: inline-block;
	margin: 0 auto 20px auto;
	cursor: pointer;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}

.form-control {
	width: 250px;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							<c:if test="${not empty dataModel}">编辑</c:if>
							<c:if test="${empty dataModel}">新增</c:if>
							商品
						</h5>
					</div>
					<form action="/sys/goods/goods/save" method="post"
						class="form-horizontal" id="commentForm"
						enctype="multipart/form-data">
						<div class="ibox-content">
							<div class="panel blank-panel">
								<div class="tabs-left">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#tab-1"
											aria-expanded="true">基本信息</a></li>
										<li class=""><a data-toggle="tab" href="#tab-2"
											aria-expanded="true">详细描述</a></li>
										<li class=""><a data-toggle="tab" href="#tab-3"
											aria-expanded="true">其他信息</a></li>
										<!-- 	<li class=""><a data-toggle="tab" href="#tab-4"
											aria-expanded="true">商品相册</a></li> -->
										<li class=""><a data-toggle="tab" href="#tab-5"
											aria-expanded="true">商品属性</a></li>
										<!-- <li class=""><a data-toggle="tab" href="#tab-6"
											aria-expanded="true">关联商品</a></li> -->
									</ul>
									<div class="tab-content ">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<input type="hidden" name="goods_id" id="goods_id"
													value="${dataModel.goods_id}" />
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品名称：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_name" id="goods_name"
															class="form-control" value="${dataModel.goods_name}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品货号：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_sn" id="goods_sn"
															class="form-control" value="${dataModel.goods_sn}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>本店售价：</label>
													<div class="col-sm-8">
														<input type="text" name="shop_price" id="shop_price"
															class="form-control" value="${dataModel.shop_price}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">市场售价：</label>
													<div class="col-sm-8">
														<input type="text" name="market_price" id="market_price"
															class="form-control" value="${dataModel.market_price}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">虚拟销量：</label>
													<div class="col-sm-8">
														<input type="text" name="virtual_sales" id="virtual_sales"
															class="form-control" value="${dataModel.virtual_sales}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">推荐值（用于商品今日推荐）：</label>
													<div class="col-sm-8">
														<input type="text" name="is_recommend" id="is_recommend"
															class="form-control" value="${dataModel.is_recommend}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>赠送积分（不赠送积分输入0）：</label>
													<div class="col-sm-8">
														<input type="text" name="give_points" id="give_points"
															class="form-control" value="${dataModel.give_points}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>积分支（不支持积分支付输入0）：</label>
													<div class="col-sm-8">
														<input type="text" name="pay_points" id="pay_points"
															class="form-control" value="${dataModel.pay_points}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">商品浏览量：</label>
													<div class="col-sm-8">
														<input type="text" name="click_count" id="click_count"
															class="form-control" value="${dataModel.click_count}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">商品分享次数：</label>
													<div class="col-sm-8">
														<input type="text" name="share_count" id="share_count"
															class="form-control" value="${dataModel.share_count}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">关联店铺(可不选)：</label>
													<div class="col-sm-8">
														 <select name="bs_id" id="bs_id" class="form-control">
														 	<option value="0" <c:if test="${empty dataModel.bs_id || dataModel.bs_id eq 0}">selected ='selected'</c:if>>无</option>
															<c:forEach var="bs" items="${bsList}">
																<option value="${bs.bs_id}" <c:if test="${dataModel.bs_id eq bs.bs_id}">selected ='selected'</c:if>>${bs.bs_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group" >
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否人气推荐：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_popular" value="1"
															<c:if test="${dataModel.is_popular == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_popular" value="0"
															<c:if test="${dataModel.is_popular == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否为特别推荐：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_special" value="1"
															<c:if test="${dataModel.is_special == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_special" value="0"
															<c:if test="${dataModel.is_special == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
												
												 <%-- <div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否为设备：</label>
													<div class="col-sm-1">
														<label class="radio-inline"><input type="radio"
															name="is_device" value="1"
															<c:if test="${dataModel.is_device == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_device" value="0"
															<c:if test="${ empty dataModel.is_device || dataModel.is_device == 0 }">checked="checked"</c:if> />否</label>
													</div>
													<c:if test="${dataModel.is_Null==0}">
														<p class="col-sm-6" style="float: left; color: red;">*
															如果是设备，将添加进设备表！</p>
													</c:if>
													<c:if test="${dataModel.is_Null==1}">
														<p class="col-sm-6" style="float: left; color: red;">*
															当前设备不是初始状态，不能选择否取消设备！</p>
													</c:if>
													<c:if test="${dataModel.is_Null==2}">
														<p class="col-sm-6" style="float: left; color: red;">*
															当前设备是初始状态，可以选择否，将取消该商品为设备！</p>
													</c:if>
												</div>  --%>
												<div class="form-group" style="display:none">
													<label class="col-sm-2 control-label">是否用相册作为图文详情：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_alumb_desc" value="1"
															<c:if test="${dataModel.is_alumb_desc == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_alumb_desc" value="0"
															<c:if test="${dataModel.is_alumb_desc == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
												<!-- 0继承系统分销,1自定义,2不加入分销 -->
												<div class="form-group" style="display:none">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否分销：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															checked="checked" name="rebate_type" value="0"
															<c:if test="${dataModel.rebate_type == 0}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="rebate_type" value="1"
															<c:if test="${dataModel.rebate_type == 1}">checked="checked"</c:if> />自定义</label>
														<label class="radio-inline"><input type="radio"
															name="rebate_type" value="2"
															<c:if test="${dataModel.rebate_type == 2}">checked="checked"</c:if> />不加入分销</label>
													</div>
												</div>
												<input type="hidden" name="rebate_id" id="rebate_id"
													value="${rebateModel.rebate_id}" />
												<div style="display:none" class="form-group rebate_group"
													<c:if test="${dataModel.rebate_type == 1}"> style="display: block" </c:if>
													<c:if test="${dataModel.rebate_type == 0 || dataModel.rebate_type == 2}">style="display: none" </c:if>>
													<label class="col-sm-2 control-label">代理返利：</label>
													<div class="col-sm-8">
														<div class="row">
															<div class="col-md-4">
																<input type="text" name="rebate_1" id="rebate_1"
																	class="form-control" value="${rebateModel.rebate_1}" />
																<span class="help-block m-b-none">一级返利</span>
															</div>
															<div class="col-sm-4">
																<input type="text" name="rebate_2" id="rebate_2"
																	class="form-control" value="${rebateModel.rebate_2}" />
																<span class="help-block m-b-none">二级返利</span>
															</div>
															<div class="col-sm-4">
																<input type="text" name="rebate_3" id="rebate_3"
																	class="form-control" value="${rebateModel.rebate_3}" />
																<span class="help-block m-b-none">三级返利</span>
															</div>
														</div>
													</div>
												</div>
												<%-- <div class="form-group rebate_group"
													<c:if test="${dataModel.rebate_type == 1}"> style="display: block" </c:if>
													<c:if test="${dataModel.rebate_type == 0 || dataModel.rebate_type == 2}">style="display: none" </c:if>>
													<label class="col-sm-2 control-label">代理积分：</label>
													<div class="col-sm-8">
														<div class="row">
															<div class="col-md-4">
																<input type="text" name="points_1" id="points_1"
																	class="form-control" value="${rebateModel.points_1}" />
																<span class="help-block m-b-none">一级返利积分</span>
															</div>
															<div class="col-sm-4">
																<input type="text" name="points_2" id="points_2"
																	class="form-control" value="${rebateModel.points_2}" />
																<span class="help-block m-b-none">二级返利积分</span>
															</div>
															<div class="col-sm-4">
																<input type="text" name="points_3" id="points_3"
																	class="form-control" value="${rebateModel.points_3}" />
																<span class="help-block m-b-none">三级返利积分</span>
															</div>
														</div>
													</div>
												</div> --%>
												<div class="form-group">
													<!-- 封面图 -->
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>列表图片：</label>
													<div class="col-sm-8 ">
														<div class="fileupload fileupload-new"
															data-provides="fileupload">
															<div class="fileupload-new thumbnail"
																style="max-height: 200px;">
																<img src="${SETTINGPD.IMAGEPATH}${dataModel.list_img}"  onerror="this.src='/statics/img/no-img.jpg'"
																	height="100" width="200">
																<%-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} --%>
															</div>
															<div
																class="fileupload-preview fileupload-exists thumbnail"
																style="max-height: 200px; line-height: 20px;"></div>
															<div>
																<span class="btn btn-default btn-file"> <span
																	class="fileupload-new">选择文件</span> <span
																	class="fileupload-exists">重选</span> <input
																	id="list_img" name="list_img" type="file">
																</span> <a href="#" class="btn btn-default fileupload-exists"
																	data-dismiss="fileupload">移除</a>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- 详细描述 -->
										<div id="tab-2" class="tab-pane">
											<div class="panel-body">
												<div class="ibox-content no-padding">
													<div class="form-group">
														<input type="hidden" name="goods_desc" id="goods_desc"
															value="" />
														<div class="col-sm-7">
															<script id="editor" type="text/plain"
																style="width: 100%; height: 280px">${dataModel.goods_desc}</script>
														</div>
													</div>
												</div>
												<br>
											</div>
										</div>
										<div id="tab-3" class="tab-pane">
											<div class="panel-body">
												<div class="form-group">
													<label class="col-sm-2 control-label">商品重量：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_weight" id="goods_weight"
															class="form-control" value="${dataModel.goods_weight}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品库存：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_stock" id="goods_stock"
															class="form-control" value="${dataModel.goods_stock}" />
													</div>
												</div>
												<div class="form-group" style="display:none">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否为虚拟商品：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_virtual" value="1"
															<c:if test="${dataModel.is_virtual == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_virtual" value="0"
															<c:if test="${dataModel.is_virtual == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
												<div class="form-group" style="display:none">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否为赠品：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_gift" value="1"
															<c:if test="${dataModel.is_gift == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_gift" value="0"
															<c:if test="${dataModel.is_gift == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>是否免运费：</label>
													<div class="col-sm-8">
														<label class="radio-inline"><input type="radio"
															name="is_free_shipping" value="1"
															<c:if test="${dataModel.is_free_shipping == 1}">checked="checked"</c:if> />是</label>
														<label class="radio-inline"><input type="radio"
															name="is_free_shipping" value="0"
															<c:if test="${dataModel.is_free_shipping == 0}">checked="checked"</c:if> />否</label>
													</div>
												</div>
										        <div class="form-group"  <c:if test="${dataModel.is_free_shipping == 1}">style="display: none;"</c:if>>
													<label class="col-sm-2 control-label">运费金额：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_freight" id="goods_freight"
															class="form-control" value="${empty dataModel.goods_freight ? 0 : dataModel.goods_freight}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">商品标签：</label>
													<div class="col-sm-8">
														<input type="text" name="goods_tags" id="goods_tags"
															class="form-control" value="${dataModel.goods_tags}" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">商品简述：</label>
													<div class="col-sm-8">
														<textarea placeholder="" name="goods_summary"
															id="goods_summary" class="form-control">${dataModel.goods_summary}</textarea>
													</div>
												</div>
											<%-- 	<div class="form-group">
													<label class="col-sm-2 control-label">商家备注：</label>
													<div class="col-sm-8">
														<textarea placeholder="" name="seller_note"
															id="seller_note" class="form-control">${dataModel.seller_note}</textarea>
													</div>
												</div> --%>
											</div>
										</div>
										<!-- 商品属性 -->
										<div id="tab-5" class="tab-pane">
											<div class="panel-body">
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品分类：</label>
													<div class="col-sm-2" id="appendCategory">
														<input type="hidden" value="${dataModel.category_id}"
															name="category_id" id="category_id" /> <select
															name="category1_id" id="category1_id"
															class="form-control">
															<option value="">--请选择一级分类--</option>
															<c:forEach var="category" items="${category1List}">
																<option value="${category.category_id}"
																	<c:if test="${dataModel.category1_id eq category.category_id}"> selected ='selected'</c:if>>${category.category_name}</option>
															</c:forEach>
														</select>
													</div>
													<c:if test="${not empty category2List}">
														<div class="col-sm-2" id="categoryAppend2">
															<select name="category2_id" id="category2_id"
																class="form-control" onchange="category2Change(this)">
																<option value="">--请选择二级分类--</option>
																<c:forEach var="category" items="${category2List}">
																	<option value="${category.category_id}"
																		<c:if test="${dataModel.category2_id eq category.category_id}"> selected ='selected'</c:if>>${category.category_name}</option>
																</c:forEach>
															</select>
														</div>
													</c:if>
													<c:if test="${not empty category3List}">
														<div class="col-sm-2" id="categoryAppend3">
															<select name="category3_id" id="category3_id"
																class="form-control">
																<option value="">--请选择三级分类--</option>
																<c:forEach var="category" items="${category3List}">
																	<option value="${category.category_id}"
																		<c:if test="${dataModel.category3_id eq category.category_id}"> selected ='selected'</c:if>>${category.category_name}</option>
																</c:forEach>
															</select>
														</div>
													</c:if>
													<div class="col-sm-2"
														style="color: #999; line-height: 2.5;">
														选择分类之后自动筛选出品牌和类型</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label">商品品牌：</label>
													<div class="col-sm-8">
														<select name="brand_id" id="brand_id" class="form-control">
															<c:forEach var="brand" items="${brandList}">
																<option value="${brand.brand_id}"
																	<c:if test="${dataModel.brand_id eq brand.brand_id}"> selected ='selected'</c:if>>${brand.brand_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label"><font
														color="red" size="3px"
														style="font-weight: bold; font-style: italic;">*&nbsp;</font>商品类型：</label>
													<div class="col-sm-8">
														<select name="goods_type_id" id="goods_type_id"
															class="form-control" style="width: 150px;"
															onchange="type_attr()">
															<option value="0">请选择商品类型</option>
															<c:forEach var="type" items="${typeList}">
																<option value="${type.type_id}"
																	<c:if test="${dataModel.goods_type_id eq type.type_id}"> selected ='selected'</c:if>>${type.type_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div id="goodsAttr">
													<div class="wrapper wrapper-content animated fadeInRight">
														<div class="row">
															<div class="col-sm-12">
																<div class="ibox float-e-margins">
																	<div class="ibox-content">
																		<c:choose>
																			<c:when test="${not empty varAllList}">
																				<c:forEach items="${varAllList}" var="attr"
																					varStatus="status">
																					<div class="form-group">
																						<input type="hidden"
																							name="goodsAttr[${status.index}].goods_attr_id"
																							id="goods_attr_id" class="form-control"
																							value="${attr.goods_attr_id}" required /> <input
																							type="hidden"
																							name="goodsAttr[${status.index}].attr_id"
																							id="attr_id" class="form-control"
																							value="${attr.type_attr_id}" required />
																						<!-- 这主要用作显示 -->
																						<label class="col-sm-2 control-label">${attr.attr_name}</label>
																						<!-- 隐藏域用作入库 -->
																						<input type="hidden"
																							name="goodsAttr[${status.index}].attr_name"
																							id="attr_name" class="form-control"
																							value="${attr.attr_name}" required /> <input
																							type="hidden"
																							name="goodsAttr[${status.index}].attr_sort"
																							id="attr_sort" class="form-control"
																							value="${attr.attr_sort}" required /> <input
																							type="hidden"
																							name="goodsAttr[${status.index}].is_sale"
																							id="is_sale" class="form-control"
																							value="${attr.is_sale}" required />
																						<c:forEach items="${varList}" var="attrc"
																							varStatus="statusc"></c:forEach>
																						<div class="col-sm-8">
																							<!-- （1单行文本，2多行文本，3单选，4多选） -->
																							<c:if test="${attr.attr_input == 1 }">
																								<input type="text"
																									name="goodsAttr[${status.index}].attr_value"
																									id="attr_value" class="form-control"
																									value="${attr.attr_value}" required />
																							</c:if>
																							<c:if test="${attr.attr_input == 2 }">
																								<textarea placeholder="多个分组换行分隔"
																									name="goodsAttr[${status.index}].attr_value"
																									id="attr_value" class="form-control">${attr.attr_value}</textarea>
																							</c:if>
																							<c:if test="${attr.attr_input == 3 }">
																								<select
																									name="goodsAttr[${status.index}].attr_value"
																									id="attr_value" class="form-control"
																									style="width: 100px;">
																									<c:forEach var="val" varStatus="vs"
																										items="${fn:split(attr.attr_values,',')}">
																										<option value="${val}"
																											<c:if test="${attr.attr_value eq val}"> selected ='selected'</c:if>>${val}</option>
																									</c:forEach>
																								</select>
																							</c:if>
																							<c:if test="${attr.attr_input == 4 }">
																								<%-- <input type="hidden" value="" name="goodsAttr[${status.index}].attr_value" id="attr_checkbox"> --%>
																								<c:forEach var="val" varStatus="vs"
																									items="${fn:split(attr.attr_values,',')}">
																									<c:forEach
																										items="${fn:split(attr.attr_value,',')}"
																										var="tempItem">
																										<c:if
																											test="${fn:trim(tempItem) eq fn:trim(val)}">
																											<c:set value="${fn:trim(tempItem)}"
																												var="tempAttr" />
																										</c:if>
																									</c:forEach>
																									<label class="checkbox-inline"> <input
																										type="checkbox" value="${val}"
																										name="goodsAttr[${status.index}].attr_value"
																										id="attr_value" onclick="chk()"
																										<c:if test="${tempAttr eq fn:trim(val)}"> checked="checked"</c:if>>${val}</label>
																								</c:forEach>
																								<!-- <input type="button" onclick="chk()" value="提 交" /> -->
																							</c:if>
																							</div>
																					</div>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<tr class="main_info">
																					<td colspan="7" class="center">没有相关数据</td>
																				</tr>
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-4 col-sm-offset-3">
										<button class="btn btn-primary" type="button"
											onclick="checkParam()">
											<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
										</button>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button class="btn btn-warning" type="button" onclick="history.go(-1)">
											<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
										</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript" src="/statics/js/user/Category.js"></script>
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/statics/js/uedit/";
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.all.min.js">
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>
	<script src="/statics/js/jquery-upload.js"></script>
	<script type="text/javascript">
	    $(function(){
	    	$("input[name='is_free_shipping']").click(function(){
	    		if($(this).val() == 1){
	    			$("#goods_freight").parents(".form-group").hide();
	    		}else{
	    			$("#goods_freight").parents(".form-group").show();
	    		}
	    	});
	    	
	    	$(".fileupload-exists").click(function(){
	    		$(this).parents(".fileupload").children().eq(0).remove();
	    	});
	    	
	    });
		var ue = UE.getEditor('editor');
		//返利
		$(":radio[name='rebate_type']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".rebate_group").show();
			} else {
				$(".rebate_group").hide();
			} //选中第2个时，div显示
		});
		/*    
		   $("#commentForm").submit(function(){
			   var html = $("#htmlEditor").code();
				//alert(html);
				$("#goods_desc").val(html); 
		   }); */
		function checkParam() {
			if ($("#category3_id").val() && $("#category3_id").val() != ''
					&& $("#category3_id").val() > 0) {
				$("#category_id").val($("#category3_id").val());
			} else {
				if ($("#category2_id").val() && $("#category2_id").val() != ''
						&& $("#category2_id").val() > 0) {
					$("#category_id").val($("#category2_id").val());
				} else {
					if ($("#category1_id").val()
							&& $("#category1_id").val() != ''
							&& $("#category1_id").val() > 0) {
						$("#category_id").val($("#category1_id").val());
					} else {
						bootbox.alert("请选择商品分类");
						return false;
					}
				}
			}
			if (!$("#goods_name").val()) {
				bootbox.alert("商品名字不能为空");
				return false;
			}
			if ($("#goods_name").val().length > 100) {
				bootbox.alert("商品名字在100个字符以内");
				return false;
			}
			if (!$("#goods_sn").val()) {
				bootbox.alert("商品货号不能为空");
				return false;
			}
			if (!$("#shop_price").val()) {
				bootbox.alert("本店售价不能为空");
				return false;
			}
			if (!$("#shop_price").val().isMoney()) {
				bootbox.alert("本店售价--请输入正确的金额格式");
				return false;
			}
			if ($("#shop_price").val() > 99999999) {
				bootbox.alert("本店售价最大值为99999999");
				return false;
			}
			if (!$("#market_price").val()) {
				$("#market_price").val(0);
			}
			if ($("#market_price").val() && !$("#market_price").val().isMoney()) {
				bootbox.alert("市场售价--请输入正确的金额格式");
				return false;
			}
			if ($("#market_price").val() > 99999999) {
				bootbox.alert("市场售价最大值为99999999");
				return false;
			}
			if (!$("#virtual_sales").val()) {
				$("#virtual_sales").val(0);
			}
			if ($("#virtual_sales").val() == null
					|| $("#virtual_sales").val() == ''
					|| !$("#virtual_sales").val().isNumber()
					|| $("#virtual_sales").val() < 0) {
				bootbox.alert("虚拟销售量必须为正整数");
				return false;
			}
			if (!$("#is_recommend").val()) {
				$("#is_recommend").val(0);
			}
			if (!$("#is_recommend").val().isNumber()
					|| $("#is_recommend").val() < 0) {
				bootbox.alert("推荐必须为正整数");
				return false;
			}
			if ($("#pay_points").val().isEmpty()
					|| !$("#pay_points").val().isNumber()
					|| $("#pay_points").val() < 0) {
				bootbox.alert("支付积分必须为正整数");
				return false;
			}
			if ($("#give_points").val().isEmpty()
					|| !$("#give_points").val().isNumber()
					|| $("#give_points").val() < 0) {
				bootbox.alert("赠送积分必须为正整数");
				return false;
			}
			if (!$("#share_count").val()) {
				$("#share_count").val(0);
			}
			if ($("#share_count").val() == null
					|| $("#share_count").val() == ''
					|| !$("#share_count").val().isNumber()
					|| $("#share_count").val() < 0) {
				bootbox.alert("分享次数必须为正整数");
				return false;
			}
			if (!$("#click_count").val()) {
				$("#click_count").val(0);
			}
			if ($("#click_count").val() == null
					|| $("#click_count").val() == ''
					|| !$("#click_count").val().isNumber()
					|| $("#click_count").val() < 0) {
				bootbox.alert("商品浏览量必须为正整数");
				return false;
			}
			if ($("#goods_weight").val() == null
					|| $("#goods_weight").val() == ''
					|| !$("#goods_weight").val().isMoney()
					|| $("#goods_weight").val() < 0) {
				bootbox.alert("商品重量有误");
				return false;
			}
			if (!$("#goods_stock").val()) {
				bootbox.alert("库存不能为空");
				return false;
			}
			if (!$("#goods_stock").val().isNumber()) {
				bootbox.alert("库存格式不正确");
				return false;
			}
			$("#commentForm").submit();
		}
		var goods_sn = '${dataModel.goods_sn}';
		//检测商品货号
		$(function() {
			$("#goods_sn").blur(
					function() {
						if ($(this).val() != goods_sn) {
							alert("enter");
							if ($("#goods_sn").val() != null
									&& $("#goods_sn").val() != '') {
								Ajax.request(
										"/sys/goods/goods/selectGoodsBySN", {
											"data" : {
												"goods_sn" : $(this).val()
											},
											"success" : function(data) {
												if (data.result != "200") {
													bootbox.alert("商品货号已存在");
												}
											}
										});
							} else {
								bootbox.alert("请输入商品货号");
							}
						}
					});
		});
		type_attr();
		//根据类型动态生成属性列表
		function type_attr() {
			var options = $("#goods_type_id option:selected");
			//alert(options.text());
			var goods_type_id = options.val();
			//根据类型id获得所有的属性,异步请求,返回界面
			$.ajax({
				type : "POST",
				url : "/sys/goods/goodsTypeAttr/listAttr?goods_type_id="
						+ goods_type_id + "&goods_id=${dataModel.goods_id}",
				data : {},
				dataType : "html",
				success : function(html) {
					//$("#goodsAttr").append(html);
					$("#goodsAttr").html("");
					$("#goodsAttr").html(html);
				}
			});
		}
		$("#category1_id").change(function() {
			var data = {};
			data.category1_id = $(this).val();
			xrPage(data);
		});
		$("#category2_id").change(function() {
			var data = {};
			data.category2_id = $(this).val();
			xrPage(data);
		});
		$("#category3_id").change(function() {
			var data = {};
			data.category3_id = $(this).val();
			xrPage(data);
		});
		//查询品牌和类型
		function callBack2Category(thisObj) {
		}
		function callBack3Category(thisObj) {
		}
		function xrPage(dataModel) {
			if (dataModel) {
				Ajax.request(
								"/sys/goods/goods/findBAndTByCategory",
								{
									"data" : dataModel,
									"success" : function(data) {
										if (data.result == 200) {
											$("#goodsAttr").html("");
											$("#brand_id").empty();
											$("#goods_type_id").empty();
											$("#brand_id")
													.append(
															"<option value=''>请选择品牌</option>");
											$("#goods_type_id")
													.append(
															"<option value=''>请选择类型</option>");
											for (var i = 0; i < data.data.brands.length; i++) {
												$("#brand_id")
														.append(
																"<option  value='"+data.data.brands[i].brand_id+"'>"
																		+ data.data.brands[i].brand_name
																		+ "</option>");
											}
											for (var i = 0; i < data.data.types.length; i++) {
												$("#goods_type_id")
														.append(
																"<option  value='"+data.data.types[i].type_id+"'>"
																		+ data.data.types[i].type_name
																		+ "</option>");
											}
										}
									}
								});
			}
		}
	</script>
</body>
</html>