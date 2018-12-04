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
							旅行社
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/travel/agency/save" method="post"
							class="form-horizontal m-t" id="commentForm"
							enctype="multipart/form-data">
								<input type="hidden" id="agency_province" name="agency_province" value="${dataModel.agency_province}"/>
								<input type="hidden" id="agency_city" name="agency_city" value="${dataModel.agency_city}"/>
								<input type="hidden" id="agency_area" name="agency_area" value="${dataModel.agency_area}"/>
							<div class="tab-content">
								<div class="panel-body">
									<input type="hidden" name="agency_id" id="agency_id"
										value="${dataModel.agency_id}" />
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>旅行社名称：</label>
										<div class="col-sm-6">
											<input type="text" name="agency_name" id="agency_name"
												class="form-control" value="${dataModel.agency_name}" />
										</div>
										<div class="col-sm-2">
											<label class="control-label"><font color="red"
												size="3px" style="font-size: 11px;">1到50个字符&nbsp;</font> </label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>旅行社宣传名称：</label>
										<div class="col-sm-6">
											<input type="text" name="agency_show_name"
												id="agency_show_name" class="form-control"
												value="${dataModel.agency_show_name}" />
										</div>
										<div class="col-sm-2">
											<label class="control-label"><font color="red"
												size="3px" style="font-size: 11px;">1到50个字符&nbsp;</font> </label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>旅行社宣传标语：</label>
										<div class="col-sm-6">
											<input type="text" name="agency_slogan" id="agency_slogan"
												class="form-control" value="${dataModel.agency_slogan}" />
										</div>
										<div class="col-sm-2">
											<label class="control-label"><font color="red"
												size="3px" style="font-size: 11px;">1到100个字符&nbsp;</font></label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>旅行社联系电话：</label>
										<div class="col-sm-6">
											<input type="text" name="agency_phone" id="agency_phone"
												class="form-control" value="${dataModel.agency_phone}" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">旅行社省/市（县）/区：</label>
										<div class="col-sm-2" id="province_code">
											 <select name="agency_province_code" id="agency_province_code" class="form-control">
												<option value="">--请选择省份--</option>
												<c:forEach var="item" items="${plist}">
													<option value="${item.region_id}"
														<c:if test="${dataModel.agency_province_code eq item.region_id}"> selected ='selected'</c:if>>${item.region_name}</option>
												</c:forEach>
											</select>
										</div>
										<c:if test="${not empty citylist}">
											<div class="col-sm-2" id="city_code">
												<select name="agency_city_code" id="agency_city_code"
													class="form-control">
													<option value="">--请选择市/县--</option>
													<c:forEach var="item" items="${citylist}">
														<option value="${item.region_id}" 
															<c:if test="${dataModel.agency_city_code eq item.region_id}"> selected ='selected'</c:if>>${item.region_name}</option>
													</c:forEach>
												</select>
											</div>
										</c:if>
										<c:if test="${not empty arealist}">
											<div class="col-sm-2" id="area_code">
												<select name="agency_area_code" id="agency_area_code"
													class="form-control" onchange="onAreaChange(this)">
													<option value="">--请选择区域--</option>
													<c:forEach var="item" items="${arealist}">
														<option value="${item.region_id}" 
															<c:if test="${dataModel.agency_area_code eq item.region_id}"> selected ='selected'</c:if>>${item.region_name}</option>
													</c:forEach>
												</select>
											</div>
										</c:if>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">详细地址：</label>
										<div class="col-sm-4">
											<input type="text" name="agency_address" id="agency_address"
												class="form-control" value="${dataModel.agency_address}">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>旅行社Logo图片：</label>
										<div class="col-sm-8">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<div class="fileupload-new thumbnail"
													style="max-height: 200px;">
													<img
														src="<c:if test="${!empty dataModel.agency_logo}">${SETTINGPD.IMAGEPATH}${dataModel.agency_logo}</c:if>"
														height="200" width="200">
												</div>
												<div class="fileupload-preview fileupload-exists thumbnail"
													style="height: 200px; width: 200px;"></div>
												<div>
													<span class="btn btn-default btn-file"> <span
														class="fileupload-new">选择文件</span> <span
														class="fileupload-exists">重选</span> <input type="file"
														name="agency_logo" id="agency_logo" accept="image/*" />
													</span> <a href="#" class="btn btn-default fileupload-exists"
														data-dismiss="fileupload">移除</a>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">旅游许可证号码：</label>
										<div class="col-sm-4">
											<input type="text" name="agency_permit" id="agency_permit"
												class="form-control" value="${dataModel.agency_permit}">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">营业执照号码：</label>
										<div class="col-sm-4">
											<input type="text" name="agency_license" id="agency_license"
												class="form-control" value="${dataModel.agency_license}">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><font
											color="red" size="3px"
											style="font-weight: bold; font-style: italic;">*&nbsp;</font>营业执照图片：</label>
										<div class="col-sm-8">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<div class="fileupload-new thumbnail"
													style="max-height: 200px;">
													<img
														src="<c:if test="${!empty dataModel.agency_license_img}">${SETTINGPD.IMAGEPATH}${dataModel.agency_license_img}</c:if>"
														height="300" width="150">
												</div>
												<div class="fileupload-preview fileupload-exists thumbnail"
													style="height：300px; width：150px;"></div>
												<div>
													<span class="btn btn-default btn-file"> <span
														class="fileupload-new">选择文件</span> <span
														class="fileupload-exists">重选</span> <input type="file"
														name="agency_license_img" id="agency_license_img"
														accept="image/*" />
													</span> <a href="#" class="btn btn-default fileupload-exists"
														data-dismiss="fileupload">移除</a>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">旅行社评分：</label>
										<div class="col-sm-4">
											<input type="text" name="agency_stars" id="agency_stars"
												class="form-control" value="${dataModel.agency_stars}">
										</div>
										<div class="col-sm-2">
											<label class="control-label"><font color="red"
												size="3px" style="font-size: 11px;">0到5&nbsp;</font> </label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">状态：</label>
										<div class="col-sm-8">
											<label class="radio-inline"> <input type="radio"
												<c:if test="${empty dataModel.agency_status || dataModel.agency_status eq '0'}">checked='checked'</c:if>
												value="0" name="agency_status">待发布
											</label> <label class="radio-inline"> <input type="radio"
												value="1"
												<c:if test="${dataModel.agency_status eq '1'}">checked='checked'</c:if>
												name="agency_status">发布上线
											</label>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-4 col-sm-offset-3">
											<button class="btn btn-primary" type="button"
												onclick="checkForm();">
												<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
											</button>
											<button class="btn btn-warning" type="button" onclick="history.go(-1)">
												<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
											</button>
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
	<script type="text/javascript" src="/statics/js/user/province.js"></script>
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
			if (!$("#agency_name").val().isNotEmpty()
					|| $("#agency_name").val().trim().length > 50) {
				alert("旅行社名称长度为0到50个字符之间");
				return false;
			}
			if (!$("#agency_show_name").val().isNotEmpty()
					|| $("#agency_show_name").val().trim().length > 50) {
				alert("旅行社宣传名称长度为0到50个字符之间");
				return false;
			}
			if (!$("#agency_phone").val().isNotEmpty()
					|| $("#agency_phone").val().trim().length > 20) {
				alert("旅行社联系电话不能为空");
				return false;
			}
			if ($("#agency_slogan").val().length > 100) {
				bootbox.alert("旅行社宣传标语应该在100个字符以内");
				return false;
			}
			if (!$("#agency_permit").val().isNotEmpty()) {
				alert("旅行社旅游许可证号码不能为空");
				return false;
			}
			if (!$("#agency_license").val().isNotEmpty()) {
				alert("旅行社营业执照号码不能为空");
				return false;
			}
			if (!$("#agency_stars").val()) {
				$("#agency_stars").val(0)
			}
			if ($("#agency_stars").val() == null
					|| $("#agency_stars").val() == ''
					|| !$("#agency_stars").val().isNumber()
					|| $("#agency_stars").val() < 0
					|| $("#agency_stars").val() > 5) {
				bootbox.alert("旅行社评分必须为1-5的正整数");
				return false;
			}
			if (!$("#agency_province").val()) {
				alert("请选择省份");
				return false;
			}
			if (!$("#agency_city").val()) {
				alert("请选择市/县");
				return false;
			}
			if (!$("#agency_area").val()) {
				alert("请选择区域");
				return false;
			}
			if (!$("#agency_address").val().isNotEmpty()) {
				alert("详细地址不能为空");
				return false;
			}
			$("#commentForm").submit();
		}
		
	</script>
</body>
</html>