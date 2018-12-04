<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
<link href="/assets/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<form action="/sys/order/orders/save" >
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>费用信息</h5>
				</div>
				<div class="ibox-content">
					<div class="panel blank-panel">
					<input type="hidden" name="id" id="id" class="form-control" value="${dataModel.order_id}" required />
						<div>
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">积分支付金额：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled" name="pay_by_points" id="pay_by_points"
											class="form-control" value="${dataModel.pay_by_points}" required />
									</div>
									<label class="col-sm-2 control-label">实际货币支付金额：</label>
									<div class="col-md-4">
										<input type="text" name="pay_by_money" id="pay_by_money" class="form-control"
											value="${dataModel. pay_by_money}" />
									</div>
								</div></br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">公司配送费用：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled" name="shipping_fee" id="shipping_fee"
											class="form-control" value="${dataModel.shipping_fee}" />
									</div>
									<label class="col-sm-2 control-label">客户配送费：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled" name="shipping_money" id="shipping_money"
											class="form-control" value="${dataModel.shipping_money}" />
									</div>
								</div></br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">公司发票费：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled" name="mer_invoice" id="mer_invoice"
											class="form-control" value="${dataModel.mer_invoice}" />
									</div>
									<label class="col-sm-2 control-label">商品总额：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled"  name="goods_money" id="goods_money"
											class="form-control" value="${dataModel.goods_money}" />
									</div>
								</div></br> </br>
								<div class="form-group">
									<label class="col-sm-2 control-label">支付手续费：</label>
									<div class="col-md-4">
										<input type="text" disabled="disabled" name="pay_fee" id="pay_fee"
											class="form-control" value="${dataModel.pay_fee}" />
									</div>
								</div></br> </br>
								<div class="form-group">
									<input type="hidden" value="cosInfoEdit" name="type">
									<label class="col-sm-2 control-label">操作备注：</label>
									<div class="col-md-4">
										<input type="text" name="auto_note" id="auto_note"
											class="form-control"  style="height: 50px;"/>
									</div>
								</div>
								<div class="col-sm-4 col-sm-offset-3">
								</br> 
									<button class="btn btn-primary" type="submit" >
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
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/jquery.cxselect.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
</body>
</html>