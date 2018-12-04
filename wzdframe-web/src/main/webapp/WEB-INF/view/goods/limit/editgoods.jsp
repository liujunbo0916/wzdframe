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
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
	<style type="text/css">	

li.msg div p {
	padding-top: 10px;
	padding-bottom: 10px;
	margin: 0;
	width: 220px;
	color: rgba(255, 255, 255, 0.8);
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	line-height: 16px;
}

.mtop8 {
	margin-top: 8px;
}

td {
	border: solid #add9c0;
	border-width: 0px 1px 1px 0px;
}

table {
	border: solid #add9c0;
	border-width: 1px 0px 0px 1px;
}
/* 翻页样式 */
.pagination { text-align: center; display: block; padding: 15px 0; margin: 0!important;}
.pagination ul { font-size: 0; *word-spacing:-1px/*IE6、7*/; display: inline-block; *display: inline/*IE6,7*/; margin: 0 auto!important; padding: 0; zoom:1;}
.pagination ul li { vertical-align: middle; letter-spacing: normal; word-spacing: normal; display: inline-block; width: auto!important; height: auto!important; padding:0!important; margin: 0 !important; border:none !important;}
.pagination ul li { *display: inline/*IE6,7*/; *float: left; zoom: 1;}
.pagination li span { font-size: 12px; line-height: 24px; color: #AAA; list-style-type: none; background-color: #F5F5F5; display: block; height: 24px; padding: 0px 8px; margin: 0px; border: 1px solid; border-color: #DCDCDC #DCDCDC #B8B8B8 #DCDCDC;}
.pagination li:first-child span { border-radius: 4px 0 0 4px;}
.pagination li:last-child span { border-radius: 0 4px 4px 0;}
.pagination li a span ,
.pagination li a:visited span { color: #333; text-decoration: none; cursor:pointer;}
.pagination li a:hover { text-decoration: none; }
.pagination li a:hover span,
.pagination li a:active span{ color: #333; background-color: #E8E8E8; border-color: #D0D0D0 #D0D0D0 #AEAEAE #D0D0D0; cursor: pointer;}
.pagination li span.currentpage { color: #FFF; font-weight: bold;  background-color: #41BEDD; border-color: #3AABC6 #3AABC6 #318EA6 #3AABC6; border-radius: 0;}

.search-goods-list li {
	list-style:none; /* 将默认的列表符号去掉 */
    display: list-item;
    text-align: -webkit-match-parent;
    float:left; 
    margin-left: 6px;
	margin-right: 6px;
}
ul menu dir {
    display: block;
    list-style-type: disc;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-start: 40px;
}
dl dt{width:300px; float:left;}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							活动商品
						</h5>
					</div>
					
					<input id="id" name="id" type="hidden" value="${dataModel.id}">
						<div class="ibox-content">
							<div class="panel blank-panel">
								<div class="tabs-left">
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#tab-1"
											aria-expanded="true">商品管理</a></li>
											<div class="col-sm-offset-11">
												<button type="button"
													style="margin-top: 3px; height: 35px; font-size: 14px;"
													class="btn btn-primary btn-sm" onclick="addGoods()">添加商品</button>
											</div>
									</ul>
									<div class="tab-content ">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
													<div class="tile-body tile color transparent-white">
																<div class="form-group">
																	<label class="col-sm-3 control-label">活动名称：${dataModel.activity_code}</label>
																	<label class="col-sm-3 control-label">活动开始时间：${dataModel.timelimit_start_time}</label>
																	<label class="col-sm-3 control-label">活动结束时间：${dataModel.timelimit_end_time}</label>
																	<label class="col-sm-2 control-label">活动状态：正常</label>
																</div>
															</div>
															<div class="col-md-12 form-footer " style="height: 10px"></div>
															<div class="tile-body tile color transparent-white">
																<div class="project-list">
																	<!-- 开始循环 -->
																	<c:choose>
																		<c:when test="${not empty dataGoods}">
																			<table id="simple-table"
																				class="center table table-striped table-bordered table-hover">
																				<thead>
																					<tr>
																						<th>商品名称</th>
																						<th>商品图片</th>
																						<th>商品价格</th>
																						<th>折扣价格</th>
																						<th>库存量</th>
																						<th>购买量</th>
																						<th>购买下限</th>
																						<th class="center" style="width: 120px">操作</th>
																					</tr>
																				</thead>
																				<tbody>
																					<c:forEach items="${dataGoods}" var="item">
																						<tr>
																							<td>${item.goods_name}  <c:if
																									test="${item.attr_json eq '-1'}">默认属性</c:if> <c:if
																									test="${item.attr_json ne '-1'}">${item.attr_json}</c:if></td>
																							<td><img
																								onerror="javascript:this.src='/statics/img/imgerror.png';"
																								alt="" style="width: 100px; height: 100px;"
																								src="${SETTINGPD.IMAGEPATH}${item.list_img}"></td>
																							<td>${item.goods_price}</td>
																							<td>${item.discount_price}</td>
																							<td>${item.stock}</td>
																							<td>
																							<c:if test="${empty item.timelimit_buy_min}"> 0 </c:if>
																							<c:if test="${not empty item.timelimit_buy_min}"> ${item.timelimit_buy_min} </c:if>
																							</td>
																							<td>${item.min_num}</td>
																							<td>
																								<button type="button"
																									onclick="editGoods('${item.id}')"
																									class="btn btn-primary btn-sm">编辑</button>
																								<button type="button"
																									class="btn btn-warning btn-sm" onclick="doProDel('${item.id}')">删除</button>
																						</tr>
																					</c:forEach>
																				</tbody>
																			</table>
																		</c:when>
																	</c:choose>
																</div>
															</div>
															<div class="col-md-12 form-footer " style="height: 10px"></div>
															<div class="tile-body tile color transparent-white goodsAll" style="display:none;">
																<div class="goods-list" style="height: 360px;">
																	<div id="div_goods_select" >
																		<table class="search-form" style="border-style:none">
																			<tbody>
																				<tr>
																					<td class="" style="border-style:none"><strong>搜索店内商品&nbsp;&nbsp;&nbsp;</strong></td>
																					<td class="w160" style="border-style:none"><input id="search_goods_name"
																						type="text" name="search_goods_name"
																						value="">&nbsp;&nbsp;&nbsp;</td>
																					<td class="w70 tc" style="border-style:none"><button type="button"
																									onclick="searchGoods()"
																									class="btn btn-primary btn-sm">搜索</button></td>
																				</tr>
																			</tbody>
																		</table>
																		<div id="div_goods_search_result"
																			class="search-result" style="margin-left: 40px;margin-top: 15px; height: 265px">
																			<ul class="goods-list search-goods-list transparent-white">
																				<li>
																					<div class="goods-thumb">
																						<a href="http://www.cbcmall.cn/shop/index.php?act=goods&amp;op=index&amp;goods_id=7187"
																							target="_blank"><img
																							style="width: 240px;height: 170px;" src="http://www.cbcmall.cn/data/upload/shop/store/goods/15/2017/07/25/15_05543245236611562_240.png"></a>
																					</div>
																					<dl class="goods-info">
																						<dt style="margin-top: 10px;font-size: 14px">
																							体验店商品 体验店商品 体验店商品
																						</dt>
																						<dd style="margin-top: 10px;font-size: 12px">销售价格：¥500.00</dd>
																					</dl>
																					<button type="button"
																									class="btn btn-primary btn-sm">选择商品/修改折扣价</button>
																				</li>
																			</ul>
																			</div>
																			<div class="col-md-12 form-footer ">
																				<div class="pagination">
																					<ul>
																						<li><span class="homepage">首页</span></li>
																						<li><span class="previouspage">上一页</span></li>
																						<li><span class="currentpage">1</span></li>
																						<li><span class="nextpage">下一页</span></li>
																						<!-- <li><span>末页</span></li> -->
																					</ul>
																				</div>
																			</div>
																		</div>
																</div>
															</div>
																<div class="col-md-12 form-footer "
																style="margin-top: 20px;">
																	<div class="col-sm-offset-5 col-sm-12"
																		style="margin-top: 20px; margin-bottom: 20px;">
																		<button type="button" onclick="goBack()"
																			class="btn btn-primary">返回列表</button>
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
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
		<script type="text/javascript" src="/statics/js/user/User.js"></script>
</body>
<script src="/assets/js/vendor/parsley/parsleygoods.min.js"></script>
	<script src="/statics/js/page/editProduct.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.all.min.js">
		
	</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
var limitId=${dataModel.id};
function editGoods(id,goods_name,goods_id,sku_id,goods_price) {
	var index = layer.open({
		type : 2,
		title : '修改价格',
		maxmin : false,
		shadeClose : false, //点击遮罩关闭层
		area : [ '300px', '350px' ],
		content : "/sys/activity/discount/priceChange?id=" + id
				+ "&goods_name=" + goods_name +"&goods_id="+goods_id+"&sku_id="+sku_id+"&limit_id="+limitId+"&goods_price="+goods_price,
	});
}

function doProDel(id){
	var pd={};
	pd.id=id;
	bootbox.confirm("你确定删除该活动商品吗？",function(result){
		if(result){
			Ajax.request("/sys/activity/discount/doProDel",
					{
						"data" : pd,
						"success" : function(data) {
							if (data.result == "200") {
								getLimitGoods();
							}else{
								alert(data.msg);
							}
						}
					});
		}
	});
	
}

function goBack() {
	window.location = '/sys/activity/discount/list';
}

//重新拉取数据填充 attr_json
function getLimitGoods() {
	var pd = {};
	pd.id = limitId;
	Ajax.request("/sys/activity/discount/getprolist",
					{
						"data" : pd,
						"success" : function(data) {
							if (data.result == "200") {
								var data = data.data;
								if (data && data.length > 0) {
									var html = '<table id="simple-table"class="center table table-striped table-bordered table-hover">'
											+ '<thead><tr><th>商品名称</th><th>商品图片</th><th>商品价格</th><th>折扣价格</th>'
											+ '<th>库存量</th><th>购买量</th><th>购买下限</th><th class="center" style="width: 120px">操作</th></tr></thead>';
									for (var i = 0; i < data.length; i++) {
										if(data[i].attr_json=='-1'){
											data[i].attr_json="默认属性"
										}
										if(!data[i].timelimit_buy_min){
											data[i].timelimit_buy_min=0;
										}
										html += '<tr><td>'
												+ data[i].goods_name
												+ ' '+data[i].attr_json+'</td>'
												+ '<td><img <img onerror="javascript:this.src='+"'"+'/statics/img/imgerror.png'+"'"+';"'
							+'	alt="" style="width: 100px; height: 100px;"'
							+'	src="${SETTINGPD.IMAGEPATH}'+data[i].list_img+'"></td>'
												+ '<td>'
												+ data[i].goods_price
												+ '</td>'
												+ '<td>'
												+ data[i].discount_price
												+ '</td>'
												+ '<td>'
												+ data[i].stock
												+ '</td>'
												+ '<td>'
												+ data[i].timelimit_buy_min
												+ '</td>'
												+ '<td>'
												+ data[i].min_num
												+ '</td>'
												+ '<td><button type="button" onclick="editGoods('
												+ data[i].id
												+ ')" class="btn btn-primary btn-sm">编辑</button><button type="button"'
							+'		class="btn btn-warning btn-sm" onclick="doProDel('
							+ data[i].id
							+ ')">删除</button></tr>'
									}
									$(".project-list").empty().append(html);
								}else{
									$(".project-list").empty();
								}
							}
						}
					});
}

var currentPage=1;

var goNext=true;

function getGoodsAll(search_name,page) {
	var pd={};
	pd.search_name=search_name;
	pd.currentPage=page;
	Ajax.request("/sys/activity/discount/getGoodslist",
					{
						"data" : pd,
						"success" : function(data) {
							if (data.result == "200") {
								var data = data.data;
								if(data.length == 3){
									goNext=true;
								}else{
									goNext=false;
								}
								if (data && data.length > 0) {
									var html = '';
									for (var i = 0; i < data.length; i++) {
										if(data[i].attr_json=='-1'){
											data[i].attr_json="默认属性"
										}
										html += '<li><div class="goods-thumb"><img onerror="javascript:this.src='+"'"+'/statics/img/imgerror.png'+"'"+';"'
											+'src="${SETTINGPD.IMAGEPATH}'+data[i].list_img+'" style="width: 240px;height: 170px;"></div><dl class="goods-info"><dt style="margin-top: 10px;font-size: 14px">'
											+ data[i].goods_name
											+ ' '+data[i].attr_json+'</dt><dd style="margin-top: 5px;font-size: 12px">销售价格：¥ '
											+ data[i].price
											+ '</dd></dl><button type="button"'
											+ 'onclick="editGoods('+"''"+','+"'"+''
												+ data[i].goods_name
												+ ''+"'"+','+"'"+''
												+ data[i].goods_id
												+ ''+"'"+','+"'"+''
												+ data[i].sku_id
												+ ''+"'"+','+"'"+''
												+ data[i].price
												+  ''+"'"+')" class="btn btn-primary btn-sm">选择商品/修改折扣价</button></li>'
									}
									$(".search-goods-list").empty().append(html);
									$(".pagination").show();
									$(".currentpage").html(currentPage);
								}else{
									currentPage--;
									if(currentPage != 1){
										$(".search-goods-list").empty();
									}
									$(".pagination").show();
									$(".currentpage").html(currentPage);
									alert("没数据了")
								}
							}else{
								alert(data.msg);
							}
						}
					});
}
//添加商品
function addGoods(){
	$(".goodsAll").show();
	$(".search-goods-list").empty(); 
	$(".pagination").hide();
}
//搜索商品
function searchGoods(){
	var goodsName=$("#search_goods_name").val();
	if(goodsName!=null && goodsName!=''){
		getGoodsAll(goodsName,currentPage);
	}else{
		getGoodsAll("",currentPage);
	}
}
//下一页
$(".nextpage").on('click',function(){
	if(goNext){
		currentPage++;
		var goodsName=$("#search_goods_name").val();
		if(goodsName!=null && goodsName!=''){
			getGoodsAll(goodsName,currentPage);
		}else{
			getGoodsAll("",currentPage);
		}
	}else{
		alert("没数据了")
	}
})
	//首页
$(".homepage").on('click',function(){
	if(currentPage!=1){
		currentPage=1;
		var goodsName=$("#search_goods_name").val();
		if(goodsName!=null && goodsName!=''){
			getGoodsAll(goodsName,currentPage);
		}else{
			getGoodsAll("",currentPage);
		}
	}
})
//上一页
$(".previouspage").on('click',function(){
	if(currentPage!=1){
		currentPage--;
		if(currentPage<=0){
			currentPage=1;
		}
		var goodsName=$("#search_goods_name").val();
		if(goodsName!=null && goodsName!=''){
			getGoodsAll(goodsName,currentPage);
		}else{
			getGoodsAll("",currentPage);
		}
	}
})
	</script>
</body>
</html>