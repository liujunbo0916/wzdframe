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
							导游
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/travel/guider/save" method="post"
							class="form-horizontal m-t" id="commentForm"
							enctype="multipart/form-data">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-3"
									aria-expanded="true">基本信息</a></li>
								<li class=""><a data-toggle="tab" href="#tab-4"
									aria-expanded="true">导游介绍</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-3" class="tab-pane active">
									<div class="panel-body">
										<input type="hidden" name="guider_id" id="guider_id"
											value="${dataModel.guider_id}" />
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>导游名字：</label>
											<div class="col-sm-6">
												<input type="text" name="guider_name" id="guider_name"
													class="form-control" value="${dataModel.guider_name}" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>导游昵称：</label>
											<div class="col-sm-6">
												<input type="text" name="guider_nickname"
													id="guider_nickname" class="form-control"
													value="${dataModel.guider_nickname}" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>导游宣传语：</label>
											<div class="col-sm-6">
												<input type="text" name="guider_propaganda"
													id="guider_propaganda" class="form-control"
													value="${dataModel.guider_propaganda}" />
											</div>
											<div class="col-sm-2">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">1到100个字符&nbsp;</font></label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>标签
												（ 以分号分割）：</label>
											<div class="col-sm-6">
												<input type="text" name="guider_lable" id="guider_lable"
													class="form-control" value="${dataModel.guider_lable}" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>联系电话</label>
											<div class="col-sm-6">
												<input type="text" name="guider_mobile" id="guider_mobile"
													class="form-control" value="${dataModel.guider_mobile}" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">旅行社：</label>
											<div class="col-sm-2" id="province_code">
												<select name="agency_id"
													id="agency_id" class="form-control">
													<option value="">--请选择旅行社--</option>
													<c:forEach var="item" items="${agencylist}">
														<option value="${item.agency_id}"
															<c:if test="${dataModel.agency_id eq item.agency_id}"> selected ='selected'</c:if>>${item.agency_show_name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>宣传照片：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img
															src="<c:if test="${!empty dataModel.guider_logo}">${SETTINGPD.IMAGEPATH}${dataModel.guider_logo}</c:if>"
															height="200" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="height: 200px; width: 200px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input type="file"
															name="guider_logo" id="guider_logo" accept="image/*" />
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>背景照片：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img
															src="<c:if test="${!empty dataModel.guider_bglogo}">${SETTINGPD.IMAGEPATH}${dataModel.guider_bglogo}</c:if>"
															height="200" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="height: 200px; width: 200px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input type="file"
															name="guider_bglogo" id="guider_bglogo" accept="image/*" />
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">带团次数：</label>
											<div class="col-sm-4">
												<input type="text" name="guider_service_num"
													id="guider_service_num" class="form-control"
													value="${dataModel.guider_service_num}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">价格：</label>
											<div class="col-sm-4">
												<input type="text" name="guider_price"
													id="guider_price" class="form-control"
													value="${dataModel.guider_price}">
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">导游评分：</label>
											<div class="col-sm-4">
												<input type="text" name="guider_score" id="guider_score"
													class="form-control" value="${dataModel.guider_score}">
											</div>
											<div class="col-sm-2">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">0到5&nbsp;</font> </label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否可用：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.guider_disabled || dataModel.guider_disabled eq '0'}">checked='checked'</c:if>
													value="0" name="guider_disabled">不可用
												</label> <label class="radio-inline"> <input type="radio"
													value="1"
													<c:if test="${dataModel.guider_disabled eq '1'}">checked='checked'</c:if>
													name="guider_disabled">可用
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
								</div>
								<div id="tab-4" class="tab-pane">
									<div class="panel-body">
										<div class="ibox-content no-padding">
											<input type="hidden" name="guider_desc" id="guider_desc" />
											<div class="col-sm-7">
												<script id="editor" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.guider_desc}</script>
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
		var ue = UE.getEditor('editor');
		function checkForm() {
			if (!$("#guider_name").val().isNotEmpty()
					|| $("#guider_name").val().trim().length > 50) {
				alert("导游名字长度为0到50个字符之间");
				return false;
			}
			if (!$("#guider_nickname").val().isNotEmpty()
					|| $("#guider_nickname").val().trim().length > 50) {
				alert("导游昵称长度为0到50个字符之间");
				return false;
			}
			if (!$("#guider_mobile").val().isNotEmpty()
					|| $("#guider_mobile").val().trim().length > 20) {
				alert("联系电话不能为空");
				return false;
			}
			if($("#guider_price").val() && !$("#guider_price").val().isMoney()){
				   bootbox.alert("价格有误--请输入正确的金额格式");
				   return false;
			 }
			if($("#guider_price").val()> 99999999 || $("#guider_price").val() < 0){
				   bootbox.alert("价格有误,最大值为99999999，最小值为0");
				   return false;
			 }
			if ($("#guider_propaganda").val().length > 100) {
				bootbox.alert("导游宣传标语应该在100个字符以内");
				return false;
			}
			if (!$("#guider_service_num").val()) {
				$("#guider_service_num").val(0)
			}
			if ($("#guider_service_num").val() == null
					|| $("#guider_service_num").val() == ''
					|| !$("#guider_service_num").val().isNumber()
					|| $("#guider_service_num").val() < 0) {
				bootbox.alert("导游服务次数必须正整数");
				return false;
			}
			if (!$("#guider_score").val()) {
				$("#guider_score").val(0)
			}
			if ($("#guider_score").val() == null
					|| $("#guider_score").val() == ''
					|| !$("#guider_score").val().isNumber()
					|| $("#guider_score").val() < 0
					|| $("#guider_score").val() > 5) {
				bootbox.alert("导游评分必须为1-5的正整数");
				return false;
			}
			$("#commentForm").submit();
		}
	</script>
</body>
</html>