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
<%@ include file="../../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
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
</style>
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
							代金卷
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/coupon/save" method="post"
							class="form-horizontal m-t" id="commentForm" name="commentForm"
							enctype="multipart/form-data">
							<input type="hidden" name="id" id="id" value="${dataModel.id}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">代金卷名称：</label>
								<div class="col-sm-8">
									<input type="text" name="cash_name" id="cash_name"
										class="form-control" value="${dataModel.cash_name}" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券图片：</label>
								<div class="col-sm-8">
									<div class="fileupload fileupload-new"
										data-provides="fileupload">
										<div class="fileupload-new thumbnail"
											style="max-height: 200px;">
											<img src="${SETTINGPD.IMAGEPATH}${dataModel.cash_img}"
												height="100" width="200">
										</div>
										<div class="fileupload-preview fileupload-exists thumbnail"
											style="max-height: 200px; line-height: 20px;"></div>
										<div>
											<span class="btn btn-default btn-file"> <span
												class="fileupload-new">选择文件</span> <span
												class="fileupload-exists">重选</span> <input type="file"
												name="cash_img" id="cash_img" />
											</span> <a href="#" class="btn btn-default fileupload-exists"
												data-dismiss="fileupload">移除</a>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券面额（元）：</label>
								<div class="col-sm-8">
									<input type="text" name="cash_money" id="cash_money"
										class="form-control" value="${dataModel.cash_money}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">发放总数：</label>
								<div class="col-sm-8">
									<input type="text"
										onkeyup="this.value=this.value.replace(/\D/g,'')"
										name="cash_grant_num" id="cash_grant_num" class="form-control"
										value="${dataModel.cash_grant_num}" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">每人领取个数：</label>
								<div class="col-sm-8">
									<%-- <input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" disabled="disabled" name="cash_receive" id="cash_receive"
										class="form-control" value="${dataModel.cash_receive}" /> --%>
									<input type="text"
										onkeyup="this.value=this.value.replace(/\D/g,'')"
										disabled="disabled" name="cash_receive" id="cash_receive"
										class="form-control" value="1" /> <input type="hidden"
										name="cash_receive" id="cash_receive" value="1" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">最低消费金额可使用(元)：</label>
								<div class="col-sm-8">
									<input placeholder="" name="cash_consumption_money"
										id="cash_consumption_money" class="form-control"
										value="${dataModel.cash_consumption_money}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券状态：</label>
								<div class="col-sm-2">
									<label class="radio-inline"><input type="radio"
										name="cash_status" value="1"
										<c:if test="${dataModel.cash_status == 1}">checked="checked"</c:if> />启用</label>
									<label class="radio-inline"><input type="radio"
										name="cash_status" value="0"
										<c:if test="${ empty dataModel.cash_status || dataModel.cash_status == 0 }">checked="checked"</c:if> />失效</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券领取截止时间：</label>
								<div class="col-sm-2">
									<div class="input-group">
										<input type="text" class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="cash_endget_time" id="endgetDate" readonly="readonly"
											value='<fmt:formatDate value="${dataModel.cash_endget_time}" pattern="yyyy-MM-dd hh:mm:ss" />'>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券使用截止时间：</label>
								<div class="col-sm-2">
									<div class="input-group">
										<input type="text" class="form-control date"
											style="width: 180px; cursor: pointer; background-color: #fff;"
											name="cash_end_time" id="startDate" readonly="readonly"
											value='<fmt:formatDate value="${dataModel.cash_end_time}" pattern="yyyy-MM-dd hh:mm:ss" />'>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">代金券描述：</label>
								<div class="col-sm-8">
									<textarea placeholder="" name="cash_desc" id="cash_desc"
										class="form-control">${dataModel.cash_desc}</textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button" onclick="sub()">
										<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
									</button>
									<button class="btn btn-warning" onclick="history.go(-1)">
										<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
									</button>
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
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
		$.jeDate("#startDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		//isClear:false,
		});
		$.jeDate("#endgetDate", {
			format : "YYYY-MM-DD hh:mm:ss",
			isTime : true
		//isClear:false,
		});
		
	    $(function(){
    		$(".fileupload-exists").click(function(){
        		$(this).parents(".fileupload").children().eq(0).remove();
        	});
       });
		
		function sub() {
			var name = $("#cash_name").val();
			name = name.replace(/\s/g, "");
			if (!name) {
				bootbox.alert("填写代金劵名称");
				return;
			}
			if (!$("#cash_money").val() && !$("#cash_money").val().isMoney()
					|| $("#cash_money").val() <= 0) {
				bootbox.alert("填写正确的代金卷面额");
				return;
			}
			if (!$("#cash_grant_num").val() && $("#cash_grant_num").val() <= 0) {
				bootbox.alert("填写正确的发放总数");
				return;
			}
			if (!$("#cash_receive").val() && $("#cash_receive").val() <= 0) {
				bootbox.alert("填写正确的用户领取数量");
				return;
			}
			if (!$("#cash_consumption_money").val()
					|| !$("#cash_consumption_money").val().isMoney()
					|| $("#cash_consumption_money").val() < 0) {
				bootbox.alert("填写最低消费可用金额");
				return;
			}
			if (!$("#endgetDate").val()) {
				bootbox.alert("选择领取截止时间");
				return;
			}
			if (!$("#startDate").val()) {
				bootbox.alert("选择使用截止时间");
				return;
			}

			$("#commentForm").submit();
		}
	</script>
</body>
</html>