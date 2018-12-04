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
<link href="/statics/css/phone.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							<c:if test="${not empty dataModel}">编辑</c:if>
							<c:if test="${empty dataModel}">新增</c:if>
							酒店
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/hotel/savePage" method="post"
							class="form-horizontal m-t" id="commentForm"
							enctype="multipart/form-data">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1"
									aria-expanded="true">基本信息</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2"
									aria-expanded="true">位置信息</a></li>
							<!-- 	<li class=""><a data-toggle="tab" href="#tab-4"
									aria-expanded="true">描述</a></li> -->
							</ul>
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<input type="hidden" name="hotel_id" id="hotel_id"
											value="${dataModel.hotel_id}" />
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>酒店名称：</label>
											<div class="col-sm-6">
												<input type="text" name="hotel_name" id="hotel_name"
													class="form-control" value="${dataModel.hotel_name}" />
											</div>
											<div class="col-sm-2">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">1到50个字符&nbsp;</font> </label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>联系电话：</label>
											<div class="col-sm-6">
												<input type="text" name="hotel_phone" id="hotel_phone"
													class="form-control" value="${dataModel.hotel_phone}" />
											</div>
											<div class="col-sm-2">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">1到20个字符&nbsp;</font> </label>
											</div>

										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>酒店图片：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img onerror="this.src='/statics/img/no-img.jpg'"
															src="<c:if test="${!empty dataModel.hotel_img}">${SETTINGPD.IMAGEPATH}${dataModel.hotel_img}</c:if>"
															height="100" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input type="file"
															name="hotel_img" id="hotel_img" accept="image/*" />
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>酒店类型：</label>
											<div class="col-sm-2" id="appendCategory">
												<select name="hotel_type_id" id="hotel_type_id"
													class="form-control">
													<option value="">--请选择酒店类型--</option>
													<c:forEach var="item" items="${typeModel}">
														<option 
															value="${item.hotel_type_id}"
															<c:if test="${dataModel.hotel_type_id eq item.hotel_type_id}"> selected ='selected'</c:if>>${item.hotel_type_name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">酒店星级：</label>
											<div class="col-sm-2" id="appendCategory">
												<select name="hotel_starlevel" id="hotel_starlevel"
													class="form-control">
													<option value="0">--无星级--</option>
													<option value="1"
														<c:if test="${dataModel.hotel_starlevel eq 1}"> selected ='selected'</c:if>>一星</option>
													<option value="2"
														<c:if test="${dataModel.hotel_starlevel eq 2}"> selected ='selected'</c:if>>二星</option>
													<option value="3"
														<c:if test="${dataModel.hotel_starlevel eq 3}"> selected ='selected'</c:if>>三星</option>
													<option value="4"
														<c:if test="${dataModel.hotel_starlevel eq 4}"> selected ='selected'</c:if>>四星</option>
													<option value="5"
														<c:if test="${dataModel.hotel_starlevel eq 5}"> selected ='selected'</c:if>>五星</option>
													<option value="6"
														<c:if test="${dataModel.hotel_starlevel eq 6}"> selected ='selected'</c:if>>六星</option>
													<option value="7"
														<c:if test="${dataModel.hotel_starlevel eq 7}"> selected ='selected'</c:if>>七星</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">酒店价格：</label>
											<div class="col-sm-4">
												<input type="number" name="hotel_price" id="hotel_price"
													class="form-control" value="${dataModel.hotel_price}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">酒店链接：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.hotel_url_type || dataModel.hotel_url_type eq '1'}">checked='checked'</c:if>
													value="1" name="hotel_url_type">携程旅行网
												</label> <label class="radio-inline"> <input type="radio"
													value="2"
													<c:if test="${dataModel.hotel_url_type eq '2'}">checked='checked'</c:if>
													name="hotel_url_type">去哪儿网
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">酒店链接地址：</label>
											<div class="col-sm-8">
												<input type="text" name="hotel_url" id="hotel_url"
													class="form-control" value="${dataModel.hotel_url}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">人气值：</label>
											<div class="col-sm-4">
												<input type="number" name="hotel_popularity" id="hotel_popularity"
													class="form-control" value="${dataModel.hotel_popularity}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">酒店简述（500字内）：</label>
											<div class="col-sm-6">
												<textarea rows="5" cols="45" name="hotel_sketch"
													id="hotel_sketch">${dataModel.hotel_sketch}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否热门：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.hotel_hot eq '1'}">checked='checked'</c:if>
													value="1" name="hotel_hot">是
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${empty dataModel.hotel_hot || dataModel.hotel_hot eq '0'}">checked='checked'</c:if>
													name="hotel_hot">否
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否特别推荐：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.hotel_recommend eq '1'}">checked='checked'</c:if>
													value="1" name="hotel_recommend">是
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${empty dataModel.hotel_recommend || dataModel.hotel_recommend eq '0'}">checked='checked'</c:if>
													name="hotel_recommend">否
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">状态：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.hotel_state || dataModel.hotel_state eq '0'}">checked='checked'</c:if>
													value="0" name="hotel_state">下架
												</label> <label class="radio-inline"> <input type="radio"
													value="1"
													<c:if test="${dataModel.hotel_state eq '1'}">checked='checked'</c:if>
													name="hotel_state">上架
												</label>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="button"
													onclick="checkForm();">
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div>
									</div>
								</div>
								<div id="tab-2" class="tab-pane">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>详细地址：</label>
											<div class="col-sm-4">
												<textarea rows="2" cols="60" name="hotel_address"
													id="hotel_address" class="form-control"
													placeholder="请输入酒店的详细地址点击一键定位">${dataModel.hotel_address}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"></label> <input
												type="hidden" name="hotel_lng" id="hotel_lng"
												value="${dataModel.hotel_lng}" /> <input type="hidden"
												name="hotel_lat" id="hotel_lat"
												value="${dataModel.hotel_lat}" />
											<div class="col-sm-4" id="map_show_id"
												style="width: 550px; height: 450px; border: 1px solid gray; margin: auto;">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="button"
													id="location_button">
													<i class="fa fa-check"></i>&nbsp;&nbsp;一键定位&nbsp;&nbsp;
												</button>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="button"
													onclick="checkForm();">
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div>
									</div>
								</div>
								<!-- <div id="tab-4" class="tab-pane">
									<div class="panel-body">
										<div class="ibox-content no-padding">
											<input type="hidden" name="hotel_desc" id="hotel_desc" />
											<div class="col-sm-7">
												<script id="editor" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.hotel_desc}</script>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="button"
													onclick="checkForm();">
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div> 
									</div> 
								</div> -->
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<script src="http://api.map.baidu.com/api?v=1.3"></script>
	<%@ include file="../common/foot.jsp"%>
	<script src="/statics/js/util/BaiduMap.js"></script>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
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
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
	
		var ue = UE.getEditor('editor');
		function checkForm() {
			if (!$("#hotel_name").val().isNotEmpty()
					|| $("#hotel_name").val().trim().length > 50) {
				alert("酒店名字长度为0到50个字符之间");
				return false;
			}
			if (!$("#hotel_phone").val().isNotEmpty()
					|| $("#hotel_phone").val().trim().length > 20) {
				alert("联系电话长度为0到20个字符");
				return false;
			}

			if ($("#hotel_type_id").val() == null
					|| $("#hotel_type_id").val() == '') {
				bootbox.alert("请选择酒店类型");
				return false;
			}

			if ($("#hotel_sketch").val().length > 500) {
				bootbox.alert("酒店简述简述应该在500个字符以内");
				return false;
			}
			if (!$("#hotel_popularity").val()) {
				$("#hotel_popularity").val(0);
			}
			if ($("#hotel_popularity").val() == null
					|| $("#hotel_popularity").val() == ''
					|| !$("#hotel_popularity").val().isNumber()
					|| $("#hotel_popularity").val() < 0) {
				bootbox.alert("人气值必须为正整数");
				return false;
			}
			if (!$("#hotel_address").val().isNotEmpty()) {
				alert("酒店地址不能为空");
				return false;
			}
			$("#commentForm").submit();
		}

		//得到地图对象
		var map = BaiduMap.getMap("map_show_id");
		if ('${dataModel.hotel_address}' != '') {
			BaiduMap.searchByPosition(map, {
				keyword : '${dataModel.hotel_address}',
				lngId : "hotel_lng",
				latId : "hotel_lat"
			}, 12);
		} else {
			var point = new BMap.Point(114.069562, 22.555991);
			map.centerAndZoom(point, 12);
		}
		/*  BaiduMap.searchByAddress(map, "深圳市", 12);  */
		$("#location_button").click(function() {
			BaiduMap.searchByPosition(map, {
				keyword : $("#hotel_address").val(),
				lngId : "hotel_lng",
				latId : "hotel_lat"
			}, 12);
		});
		//详细地址栏失去焦点定位
		$("#hotel_address").blur(
				function() {
					if ($("#hotel_address").val().isNotEmpty()) {
						if (!$("#hotel_lng").val().isNotEmpty()
								|| !$("#hotel_lat").val().isNotEmpty()) {
							BaiduMap.searchByPosition(map, {
								keyword : $("#hotel_address").val(),
								lngId : "hotel_lng",
								latId : "hotel_lat"
							}, 12);
						} else {
							if (window.confirm('是否重新定位？')) {
								BaiduMap.searchByPosition(map, {
									keyword : $("#hotel_address").val(),
									lngId : "hotel_lng",
									latId : "hotel_lat"
								}, 12);
							}
						}
					}
				});
		//
		var fileType = $("#category_id option:selected").attr("data-type");
		if (fileType == "1") {
			$("#voice_file").show();
		} else {
			$("#voice_file").hide();
		}
		$("#category_id").change(function() {
			if ("1" == $("#category_id option:selected").attr("data-type")) {
				$("#voice_file").show();
			} else {
				$("#voice_file").hide();
			}
		});
	</script>
</body>
</html>