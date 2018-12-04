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
							线路
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/grouptour/savePage" method="post"
							class="form-horizontal m-t" id="commentForm"
							enctype="multipart/form-data">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1"
									aria-expanded="true">基本信息</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2"
									aria-expanded="true">产品特色</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3"
									aria-expanded="true">线路行程</a></li>
								<li class=""><a data-toggle="tab" href="#tab-4"
									aria-expanded="true">费用说明</a></li>
								<li class=""><a data-toggle="tab" href="#tab-5"
									aria-expanded="true">注意事项</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<input type="hidden" name="grouptour_id" id="grouptour_id"
											value="${dataModel.grouptour_id}" />
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>线路名称：</label>
											<div class="col-sm-6">
												<input type="text" name="grouptour_name" id="grouptour_name"
													class="form-control" value="${dataModel.grouptour_name}" />
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
												<input type="text" name="grouptour_phone"
													id="grouptour_phone" class="form-control"
													value="${dataModel.grouptour_phone}" />
											</div>
											<div class="col-sm-2">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">1到20个字符&nbsp;</font> </label>
											</div>

										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>线路图片：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img  onerror="this.src='/statics/img/no-img.jpg'"
															src="<c:if test="${!empty dataModel.grouptour_img}">${SETTINGPD.IMAGEPATH}${dataModel.grouptour_img}</c:if>"
															height="100" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input type="file"
															name="grouptour_img" id="grouptour_img" accept="image/*" />
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">旅行社：</label>
											<div class="col-sm-2">
												<select name="agency_id" id="agency_id"
													class="form-control">
													<option value="">--请选择旅行社--</option>
													<c:forEach var="item" items="${agencylist}">
														<option value="${item.agency_id}"
															<c:if test="${dataModel.agency_id eq item.agency_id}"> selected ='selected'</c:if>>${item.agency_show_name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">成人价格：</label>
											<div class="col-sm-4">
												<input type="number" name="grouptour_price"
													id="grouptour_price" class="form-control"
													value="${dataModel.grouptour_price}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">儿童价格：</label>
											<div class="col-sm-4">
												<input type="number" name="childs_price"
													id="childs_price" class="form-control"
													value="${dataModel.childs_price}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">人数限度：</label>
											<div class="col-sm-8">
												<input type="text" name="grouptour_limited"
													id="grouptour_limited" class="form-control"
													value="${dataModel.grouptour_limited}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">线路销量：</label>
											<div class="col-sm-8">
												<input type="text" name="grouptour_sales"
													id="grouptour_sales" class="form-control"
													value="${dataModel.grouptour_sales}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">游览天数：</label>
											<div class="col-sm-8">
												<input type="text" name="grouptour_day" id="grouptour_day"
													class="form-control" value="${dataModel.grouptour_day}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">线路标签：</label>
											<div class="col-sm-4">
												<input type="text" name="grouptour_tab" id="grouptour_tab"
													class="form-control" value="${dataModel.grouptour_tab}">
											</div>
											<div class="col-sm-3">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">标签以逗号(",")分隔</font> </label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">线路简述（500字内）：</label>
											<div class="col-sm-6">
												<textarea rows="5" cols="45" name="grouptour_sketch"
													id="grouptour_sketch">${dataModel.grouptour_sketch}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">状态：</label>
											<div class="col-sm-8">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.grouptour_state || dataModel.grouptour_state eq '0'}">checked='checked'</c:if>
													value="0" name="grouptour_state">待发布
												</label> <label class="radio-inline"> <input type="radio"
													value="1"
													<c:if test="${dataModel.grouptour_state eq '1'}">checked='checked'</c:if>
													name="grouptour_state">已发布
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
										<div class="ibox-content no-padding">
											<input type="hidden" name="grouptour_character"
												id="grouptour_character" />
											<div class="col-sm-7">
												<script id="editor_grouptour_character" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.grouptour_character}</script>
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
								<div id="tab-3" class="tab-pane">
									<div class="panel-body">
										<div class="ibox-content no-padding">
											<input type="hidden" name="grouptour_trip"
												id="grouptour_trip" />
											<div class="col-sm-7">
												<script id="editor_grouptour_trip" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.grouptour_trip}</script>
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
								<div id="tab-4" class="tab-pane">
									<div class="panel-body">
										<div class="ibox-content no-padding">
											<input type="hidden" name="grouptour_statement"
												id="grouptour_statement" />
											<div class="col-sm-7">
												<script id="editor_grouptour_statement" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.grouptour_statement}</script>
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
								<div id="tab-5" class="tab-pane">
									<div class="panel-body">
										<div class="ibox-content no-padding">
											<input type="hidden" name="grouptour_attention"
												id="grouptour_attention" />
											<div class="col-sm-7">
												<script id="editor_grouptour_attention" type="text/plain"
													style="width: 100%; height: 280px;">${dataModel.grouptour_attention}</script>
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
    $(function(){
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
	
	
		var ue1 = UE.getEditor('editor_grouptour_character');
		var ue2 = UE.getEditor('editor_grouptour_trip');
		var ue3 = UE.getEditor('editor_grouptour_statement');
		var ue4 = UE.getEditor('editor_grouptour_attention');
		function checkForm() {
			if (!$("#grouptour_name").val().isNotEmpty()
					|| $("#grouptour_name").val().trim().length > 50) {
				alert("线路名字长度为0到50个字符之间");
				return false;
			}
			if (!$("#grouptour_phone").val().isNotEmpty()
					|| $("#grouptour_phone").val().trim().length > 20) {
				alert("联系电话长度为0到20个字符");
				return false;
			}
			if ($("#grouptour_sketch").val().length > 500) {
				bootbox.alert("线路简述简述应该在500个字符以内");
				return false;
			}
			if ($("#agency_id").val()==null || $("#agency_id").val()=='') {
				bootbox.alert("请选择旅行社");
				return false;
			}
			if ($("#agency_id").val()==null || $("#agency_id").val()=='') {
				bootbox.alert("请选择旅行社");
				return false;
			}
			if ($("#grouptour_price").val()==null || $("#grouptour_price").val()=='') {
				bootbox.alert("请输入成人价格");
				return false;
			}
			if ($("#childs_price").val()==null || $("#childs_price").val()=='') {
				bootbox.alert("请输入儿童价格");
				return false;
			}
			if (!$("#grouptour_sales").val()) {
				$("#grouptour_sales").val(0);
			}
			if (!$("#grouptour_day").val()) {
				$("#grouptour_day").val(1);
			}
			$("#grouptour_character").val(ue1.getContent());
			$("#grouptour_trip").val(ue2.getContent());
			$("#grouptour_statement").val(ue3.getContent());
			$("#grouptour_attention").val(ue4.getContent());
			$("#commentForm").submit();
		}
	</script>
</body>
</html>