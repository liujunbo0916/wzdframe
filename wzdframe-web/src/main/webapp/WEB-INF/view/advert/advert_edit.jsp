<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
<link href="/statics/css/phone.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<form action="/sys/advert/addadvert" method="post"
				class="form-horizontal m-t" id="advertForm"
				enctype="multipart/form-data">
				<div class="col-sm-13">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								<c:if test="${not empty dataModel}">编辑</c:if>
								<c:if test="${empty dataModel}">新增</c:if>
								广告
							</h5>
						</div>
						<div class="ibox-content">
							<input type="hidden" name="ad_id" id="ad_id"
								value="${dataModel.ad_id}" />
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>广告位置：</label>
											<div class="col-sm-3">
												<tr>
													<td id="juese"><select
														class="chosen-select form-control" name="ad_apid"
														id="ad_apid" data-placeholder="请选择广告位置"
														style="vertical-align: top;" class="form-control">
															<c:forEach items="${advplist}" var="item">
																<option value="${item.ap_id}"
																	<c:if test="${item.ap_id eq dataModel.ad_apid}"> selected="selected" </c:if>>${item.ap_name}</option>
															</c:forEach>
													</select></td>
												</tr>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>广告类型：</label>
											<div class="col-sm-3">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.ad_type ||  dataModel.ad_type eq 0}">checked="checked"</c:if>
													value="0" name="ad_type">内部广告
												</label> <label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.ad_type eq 1}">checked="checked"</c:if>
													value="1" name="ad_type">外部广告
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">推荐值(0-255)：</label>
											<div class="col-sm-3">
												<input type="text" name="is_recommend" id="is_recommend"
													class="form-control" value="${dataModel.is_recommend}" />
											</div>
										</div>
										<div class="form-group ">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>显示时间：</label>
											<div class="col-sm-5">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group">
															<input type="text" class="form-control date"
																style="width: 180px; cursor: pointer; background-color: #fff;"
																name="ad_begin_time" id="startDate" readonly="readonly"
																value="${requestScope.dataModel.ad_begin_time}">
															<div class="input-group" style="float: left;">
																<span class="input-group-addon" style="height: 34px;">到</span>
															</div>
															<input type="text" class="form-control date"
																style="width: 180px; cursor: pointer; background-color: #fff;"
																name="ad_end_time" id="endDate" readonly="readonly"
																value="${requestScope.dataModel.ad_end_time}">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">显示图片：</label>
											<div class="col-sm-3">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img src="${SETTINGPD.IMAGEPATH}${dataModel.ad_display}"
															height="100" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input type="file"
															name="ad_display" id="ad_display" />
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group zreohideOrShow">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>广告链接：</label>
											<div class="col-sm-3">
												<input type="text" name="ad_url" id="ad_url"
													class="form-control" value="${dataModel.ad_url}" />
											</div>
										</div>
										<div class="form-group hideOrShow">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>关联类型：</label>
											<div class="col-sm-3">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.ad_relation_type ||dataModel.ad_relation_type <= 1}">checked="checked"</c:if>
													value="1" name="ad_relation_type">特产
												</label> <label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.ad_relation_type eq 2}">checked="checked"</c:if>
													value="2" name="ad_relation_type">门票
												</label>
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.ad_relation_type eq 3}">checked="checked"</c:if>
													value="3" name="ad_relation_type">线路（跟团游）
												</label>
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.ad_relation_type eq 4}">checked="checked"</c:if>
													value="4" name="ad_relation_type">景点
												</label>
											</div>
										</div>
										<div class="form-group hideOrShow">
											<div class="form-group goodshideOrShow">
												<label class="col-sm-3 control-label"></label>
												<div class="col-sm-3">
													<span class="btn btn-default btn-file"> <span
														class="fileupload-new"
														onclick="editgoods('${dataModel.ad_relation_id}')">选择特产</span>
												</div>
												<div class="form-group col-sm-12">
													<div class="col-sm-2"></div>
													<div id="goodsdiv" class="col-sm-8">
														<table id="simple-table"
															class="center table table-striped table-bordered table-hover">
															<c:choose>
																<c:when test="${not empty goods}">
																	<thead>
																		<tr>
																			<th>商品ID</th>
																			<th>商品编号</th>
																			<th>商品名称</th>
																			<th>商品图片</th>
																			<th>商品售价</th>
																		</tr>
																	</thead>
																	<tbody>
																		<input type="hidden" name="ad_relation_goods_id"
																			id="ad_relation_goods_id" value="${goods.goods_id}" />
																		<tr>
																			<td>${goods.goods_id}</td>
																			<td>${goods.goods_sn}</td>
																			<td>${goods.goods_name}</td>
																			<td><img width="100px" height="60px"
																				src="${SETTINGPD.IMAGEPATH}${goods.list_img}" /></td>
																			<td>${goods.shop_price}</td>
																		</tr>
																</c:when>
															</c:choose>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="form-group tickethideOrShow">
												<label class="col-sm-3 control-label"></label>
												<div class="col-sm-3">
													<span class="btn btn-default btn-file"> <span
														class="fileupload-new tors"
														onclick="editTicket('${dataModel.ad_relation_id}')">选择门票</span>
												</div>
												<div class="form-group col-sm-12">
													<div class="col-sm-2"></div>
													<div id="scenicdiv" class="col-sm-8">
														<table id="simple-table"
															class="center table table-striped table-bordered table-hover">
															<c:choose>
																<c:when test="${not empty scenic}">
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
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<input type="hidden" name="ad_relation_scenic_id"
																				id="ad_relation_scenic_id" value="${scenic.id}">
																			<td>${scenic.scenic_name}</td>
															<td><img alt="" width="50px" height="45px"
																src="${SETTINGPD.IMAGEPATH}${scenic.scenic_logo}"></td>
															<td>${scenic.category_name}</td>
															<td>${scenic.scenic_address}</td>
															<td>${scenic.scenic_radius}</td>
															<td>${scenic.scenic_phone}</td>
															<td>${scenic.scenic_business_time}</td>
															<td>${scenic.scenic_click}</td>
															<td><c:if test="${scenic.scenic_status eq 1}">
																	<span class="label label-primary">正常</span>
																</c:if> <c:if test="${scenic.scenic_status eq 2}">
																	<span class="label label-danger">隐藏</span>
																</c:if></td>
																		</tr>
																	</tbody>
																</c:when>
															</c:choose>
														</table>
													</div>
												</div>
											</div>
											<div class="form-group grouptourhideOrShow">
												<label class="col-sm-3 control-label"></label>
												<div class="col-sm-3">
													<span class="btn btn-default btn-file"> <span
														class="fileupload-new"
														onclick="editGrouptour('${dataModel.ad_relation_id}')">选择线路</span>
												</div>
												<div class="form-group col-sm-12">
													<div class="col-sm-2"></div>
													<div id="grouptourdiv" class="col-sm-8">
														<table id="simple-table"
															class="center table table-striped table-bordered table-hover">
															<c:choose>
																<c:when test="${not empty grouptour}">
																	<thead>
																		<tr>
																			<th>线路名称</th>
																			<th>线路图片</th>
																			<th>线路价格</th>
																			<th>联系电话</th>
																			<th>游览天数</th>
																			<th>线路销量</th>
																			<th>旅行社</th>
																			<th>状态</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<input type="hidden" name="ad_relation_grouptour_id"
																				id="ad_relation_grouptour_id" value="${grouptour.grouptour_id}">
																			<td>${grouptour.grouptour_name}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${grouptour.grouptour_img}"></td>
														<td>成人：￥${grouptour.grouptour_price}     儿童：￥${grouptour.childs_price}</td>
														<td>${grouptour.grouptour_phone}</td>
														<td>${grouptour.grouptour_day}</td>
														<td>${grouptour.grouptour_sales}</td>
														<td>${grouptour.agency_show_name}</td>
														<td><c:if test="${grouptour.grouptour_state eq 1}">
																<span class="label label-primary">已发布</span>
															</c:if> <c:if test="${empty grouptour.grouptour_state || grouptour.grouptour_state eq 0}">
																<span class="label label-danger">待发布 </span>
															</c:if></td>
																		</tr>
																	</tbody>
																</c:when>
															</c:choose>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-8 col-sm-offset-5">
												<button class="btn btn-primary" type="button"
													onclick="checkyse();">
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<!-- Data picker -->
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<!-- ace scripts -->

	<script type="text/javascript">
		$.jeDate("#startDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		//isClear:false,
		});
		$.jeDate("#endDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		//isClear:false,
		});

	    $(function(){
    		$(".fileupload-exists").click(function(){
        		$(this).parents(".fileupload").children().eq(0).remove();
        	});
       });
		
		
		if ('${dataModel.ad_type}' == '1') {
			$(".zreohideOrShow").show();
			$(".hideOrShow").hide();
		}
		if ('${dataModel.ad_type}' == '0' || '${dataModel.ad_type}' == '') {
			$(".zreohideOrShow").hide();
			$(".hideOrShow").show();
		}
		//广告类型
		$(":radio[name='ad_type']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".zreohideOrShow").show();
				$(".hideOrShow").hide();
			} else {
				$(".zreohideOrShow").hide();
				$(".hideOrShow").show();
			}
		});
		if ('${dataModel.ad_type}' == '0' || '${dataModel.ad_type}' == ''
				|| '${dataModel.ad_relation_type}' == '1'
				|| '${dataModel.ad_relation_type}' == '') {
			$(".tickethideOrShow").hide();
			$(".goodshideOrShow").show();
			$(".grouptourhideOrShow").hide();
		}
		if ('${dataModel.ad_relation_type}' == '2' ||'${dataModel.ad_relation_type}' == '4') {
			$(".tickethideOrShow").show();
			$(".goodshideOrShow").hide();
			$(".grouptourhideOrShow").hide();
		}
		if ('${dataModel.ad_relation_type}' == '3') {
			$(".tickethideOrShow").hide();
			$(".grouptourhideOrShow").show();
			$(".goodshideOrShow").hide();
		}
		//内部广告关联类型
		var valtype='${dataModel.ad_relation_type}';
		$(":radio[name='ad_relation_type']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".goodshideOrShow").show();
				$(".tickethideOrShow").hide();
				$(".grouptourhideOrShow").hide();
			} else if (value == 2 || value == 4) {
				$(".goodshideOrShow").hide();
				if(valtype==value){
					$("#scenicdiv").show();
				}else{
					$("#scenicdiv").hide();
				}
				if(value=='2'){
					$(".tors").html('选择门票');
				}else{
					$(".tors").html('选择景点');
				}
				$(".tickethideOrShow").show();
				$(".grouptourhideOrShow").hide();
			}else if (value == 3) {
				$(".goodshideOrShow").hide();
				$(".tickethideOrShow").hide();
				$(".grouptourhideOrShow").show();
			}
		});
		function checkyse() {
			var adType = $("input[name='ad_type']:checked").val();
			var adRelationType = $("input[name='ad_relation_type']:checked").val();
			if (adType == 1) {
				if ($("#ad_url").val().isEmpty()) {
					bootbox.alert("链接必填");
					return;
				}
			} else if (adType == 0) {
				var ad_relation_id='';
				if (adRelationType == 1) {
					 ad_relation_id = $("#ad_relation_goods_id").val();
				} else if (adRelationType == 2 || adRelationType == 4) {
					 ad_relation_id = $("#ad_relation_scenic_id").val();
				}else if(adRelationType == 3){
					 ad_relation_id = $("#ad_relation_grouptour_id").val();
				}
				if (ad_relation_id == null || ad_relation_id == '') {
					bootbox.alert("请选择关联产品");
					return;
				}
			} else {
				bootbox.alert("请选择广告类型");
				return;
			}
			if (!$("#is_recommend").val()) {
				$("#is_recommend").val(0);
			}
			if (!$("#is_recommend").val().isNumber()
					|| $("#is_recommend").val() < 0) {
				bootbox.alert("推荐必须为正整数");
				return false;
			}
			$("#advertForm").submit();
		}
		
		/* function editgoods(ad_relation_id) {
			var title = "广告关联商品";
			var url = "/sys/course/relationgoods.do?course_id=" + courseId
					+ '&category_id=' + $("#category_id").val();
			index = layer.open({
				type : 2,
				title : '<font color="gray" size="3px"><strong>' + title
						+ ' </strong></font>',
				content : url,
				area : [ '800px', '495px' ],
				maxmin : true
			});
			layer.full(index);
		} */
		function editgoods(ad_relation_id) {
			var title = "广告关联特产";
			var url = "/sys/advert/advertgoods.do?ad_relation_id="
					+ ad_relation_id;
			index = layer.open({
				type : 2,
				title : '<font color="gray" size="3px"><strong>' + title
						+ ' </strong></font>',
				content : url,
				area : [ '800px', '495px' ],
				maxmin : true
			});
			layer.full(index);
		}
		//拉取广告关联特产
		function pullGoodsData(goods_id) {
			Ajax.request("/sys/advert/pushGoodsByID.do",
							{"data" : {
									"goods_id" : goods_id
								},
								"method" : "POST",
								"success" : function(data) {
									if (data.result == 200) {
										var data = data.data;
										$("#goodsdiv").empty();
										var html = '';
										html = '<table id="simple-table" class="center table table-striped table-bordered table-hover"> <thead> <tr><th>商品ID</th><th>商品编号</th><th>商品名称</th><th>商品图片</th><th>商品售价</th></tr></thead>'
												+ '<tbody><input type="hidden" name="ad_relation_goods_id" id="ad_relation_goods_id" value="'+data.goods_id+'" />'
												+ '<tr><td>'
												+ data.goods_id
												+ '</td><td>'
												+ data.goods_sn
												+ '</td><td>'
												+ data.goods_name
												+ '</td><td><img width="100px" height="60px" src="${SETTINGPD.IMAGEPATH}'+data.list_img+'" /></td><td>'
												+ data.shop_price + '</td>';
										html += '</tbody></table>';
										if (html) {
											$("#goodsdiv").append(html);
										}
									}
								}
							});
		}

		function editTicket(ad_relation_id) {
			var title='广告关联景点';
			var scenic_is_ticket='1';
			if ($("input[name='ad_relation_type']:checked").val() == '2') {
				title = title+"门票";
			}
			if($("input[name='ad_relation_type']:checked").val() == '4'){
				scenic_is_ticket='';
			}
			var url = "/sys/advert/advertTicket.do?ad_relation_id="
					+ ad_relation_id+'&scenic_is_ticket='+scenic_is_ticket;
			index = layer.open({
				type : 2,
				title : '<font color="gray" size="3px"><strong>' + title
						+ ' </strong></font>',
				content : url,
				area : [ '800px', '495px' ],
				maxmin : true
			});
			layer.full(index);
		}
		//拉取广告关联景点/景点门票
		function pullScenicData(id) {
					Ajax.request("/sys/advert/pushScenicDataByID.do",
								{
									"data" : {
									"id" : id
								},
								"method" : "POST",
								"success" : function(data) {
									if (data.result == 200) {
										var data = data.data;
										$("#scenicdiv").empty();
										if(data){
											var html = '';
											html = '<table id="simple-table" class="center table table-striped table-bordered table-hover"><thead><tr>'
												+ '<th>景区名称</th><th>景区图片</th><th>景区分类</th><th>景区地址</th><th>景区半径</th><th>联系电话</th><th>营业时间</th><th>点击量</th><th>状态</th></tr></thead>'
													+ '<tbody><tr><input type="hidden" name="ad_relation_scenic_id" id="ad_relation_scenic_id" value="'+data.id+'">'
													+ '<td>'+data.scenic_name+'</td><td><img alt="" width="50px" height="45px" src="${SETTINGPD.IMAGEPATH}'
													+ data.scenic_logo+'"></td><td>'+data.category_name+'</td><td>'+data.scenic_address+'</td><td>'+data.scenic_radius+'</td>'
													+ '<td>'+data.scenic_phone+'</td><td>'+data.scenic_business_time+'</td><td>'+data.scenic_click+'</td>';
											if (data.scenic_status == 1) {
												html += '<td><span class="label label-primary">正常</span></td>';
											} else if (data.course_level == 2) {
												html += '<td><span class="label label-danger">隐藏</span></td>';
											}
											if (html) {
												$("#scenicdiv").append(html);
											}
										}
									}
								}
							});
		}
		
		function editGrouptour(ad_relation_id) {
			var title = "广告关联线路";
			var url = "/sys/advert/advertGrouptour.do?ad_relation_id="
					+ ad_relation_id;
			index = layer.open({
				type : 2,
				title : '<font color="gray" size="3px"><strong>' + title
						+ ' </strong></font>',
				content : url,
				area : [ '800px', '495px' ],
				maxmin : true
			});
			layer.full(index);
		}
		
		//拉取广告关联景点/景点门票
		function pullGrouptourData(id) {
					Ajax.request("/sys/advert/pushGrouptourByID.do",
								{
									"data" : {
									"id" : id
								},
								"method" : "POST",
								"success" : function(data) {
									if (data.result == 200) {
										var data = data.data;
										$("#grouptourdiv").empty();
										if(data){
											var html = '';
											html = '<table id="simple-table" class="center table table-striped table-bordered table-hover"><thead><tr>'
												+ '<th>线路名称</th><th>线路图片</th><th>线路价格</th><th>联系电话</th><th>游览天数</th><th>线路销量</th><th>旅行社</th><th>状态</th></tr></thead>'
													+ '<tbody><tr><input type="hidden" name="ad_relation_grouptour_id" id="ad_relation_grouptour_id" value="'+data.grouptour_id+'">'
													+ '<td><img alt="" width="100px" height="100px"src="${SETTINGPD.IMAGEPATH}'
													+data.grouptour_img+'"></td><td>成人：￥'+data.grouptour_price+'     儿童：￥'+data.childs_price+'</td>'
													+ '<td>'+data.grouptour_phone+'</td><td>'+data.grouptour_day+'</td><td>'+data.grouptour_sales+'</td><td>'+data.agency_show_name+'</td>';
											if (data.grouptour_state == 1) {
												html += '<td><span class="label label-primary">已发布</span></td>';
											} else if (data.grouptour_state == 2) {
												html += '<td><span class="label label-danger">待发布 </span></td>';
											}
											if (html) {
												$("#grouptourdiv").append(html);
											}
										}
									}
								}
							});
		}
	</script>
</body>
</html>