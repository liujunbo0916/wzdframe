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
</head>
<body class="gray-bg">

	<form name="commentForm"  id="commentForm" action="/sys/order/orders/save?logType=personInfoEdit">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>收货人信息</h5>
				</div>
				<div class="ibox-content">
					<div class="panel blank-panel">
						<input type="hidden" name="id" id="id" class="form-control"
							value="${dataModel.order_id}" required />
						<div>
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">收货人：</label>
									<div class="col-md-4">
										<input type="text" name="contact_name" id="contact_name"
											class="form-control" value="${dataModel.contact_name}"
											required />
									</div>
								</div></br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">手机：</label>
									<div class="col-md-4">
										<input type="text" name="contact_phone" id="contact_phone"
											class="form-control" value="${dataModel.contact_phone}" />
									</div>
								</div> </br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">用户备注：</label>
									<div class="col-md-4">
										<input type="text" name="user_note" id="user_note"
											class="form-control" value="${dataModel.user_note}" />
									</div>
								</div> </br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">省市区选择：</label>
									<div class="col-sm-8">
										<div class="row">
											<div class="col-md-4">
												<select id="province" disabled="disabled" class="form-control"
													 name="province" data-value="${dataModel.province}">
													<option>请选择省份</option>
												</select>
											</div>
											<div class="col-md-4">
												<select id="city" class="form-control" name="city" 
													data-value="${dataModel.city}">
													<option>请选择城市</option>
												</select>
											</div>
											<div class="col-md-4">
												<select  id="area" class="form-control" name="area" 
													data-value="${dataModel.area}">
													<option>请选择区县</option>
												</select>
											</div>
										</div>
									</div>
								</div> </br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">地址：</label>
									<div class="col-md-4">
										<input type="text" name="address" id="address"
											class="form-control" value="${dataModel.address}" />
									</div>
								</div>	</br> </br>
								<div class="form-group">
									<input type="hidden" value="personInfoEdit" name="type">
									<label class="col-sm-2 control-label">操作备注：</label>
									<div class="col-md-4">
										<input type="text" name="auto_note" id="auto_note"
											class="form-control"  style="height: 50px;"/>
									</div>
								</div>
								<div class="col-sm-4 col-sm-offset-3">
									</br>
									<button class="btn btn-primary" type="button" onclick="sub()" >
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
	</form>

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script src="/statics/plugin/region.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/jquery.cxselect.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
	function sub(){
		 if(!$("#contact_name").val()){
			   bootbox.alert("收货人不能为空");
			   return false;
		   }
		 if(!$("#contact_phone").val()){
			   bootbox.alert("手机不能为空");
			   return false;
		   }
		 if(!$("#city").val()){
			   bootbox.alert("请选择城市");
			   return false;
		   }
		 if(!$("#area").val()){
			   bootbox.alert("请选择区域");
			   return false;
		   }
		 if(!$("#address").val()){
			   bootbox.alert("请填写具体地址");
			   return false;
		   }
		 $("#commentForm").submit();
		}
	
	</script>
	
</body>
</html>