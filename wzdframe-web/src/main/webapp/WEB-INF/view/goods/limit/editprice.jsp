<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../common/top.jsp"%>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<form action="" name="appSmsTplForm" id="appSmsTplForm"
								method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
												<input id="id" name="id" type="hidden" value="${dataModel.id}" />
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">商品价格：</td>
													<td>${dataModel.goods_price}</td>
												</tr>
												<tr>
													<td
														style="width: 79px; text-align: right; padding-top: 13px;">折扣价格：</td>
													<td><input type="text" class="form-control" id="discount_price"
														name="discount_price" value="${dataModel.discount_price}">
													</td>
												</tr>
												<tr>
													<td
														style="width: 100px; text-align: right; padding-top: 13px;">购买下限：</td>
													<td>
														<input type="text" class="form-control" id="min_num"
														name="min_num" value="${dataModel.min_num}">
													</td>
												</tr>
												<tr>
													<td style="text-align: center;" colspan="10"><a
														class="btn btn-mini btn-primary" onclick="editPrice();">提交</a>
														</td>
												</tr>
									</table>
								</div>
							</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript" src="/statics/js/user/User.js"></script>
</body>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name);
function closed() {
	parent.layer.close(index);
}
function editPrice() {
	var goodsPrice='${dataModel.goods_price}';
	if (!$("#discount_price").val() || $("#discount_price").val() < 0
			|| !$("#discount_price").val().isMoney()) {
		alert("折扣价格有误");
		return false;
	}
	if (parseFloat($("#discount_price").val()) >= parseFloat(goodsPrice)) {
		alert("折扣价格要比商品价格小");
		return false;
	}
	
	if (!$("#min_num").val() || $("#min_num").val() < 1
			|| !$("#min_num").val().isNumber()) {
		alert("购买下限有误");
		return false;
	}
	var pd={};
	pd.id=$("#id").val();
	pd.discount_price= $("#discount_price").val();
	pd.min_num= $("#min_num").val();
	pd.goods_price= goodsPrice;
	pd.goods_id= '${dataPd.goods_id}';
	pd.goods_name= '${dataPd.goods_name}';
	pd.stock_id= '${dataPd.sku_id}';
	pd.limit_id= '${dataPd.limit_id}';
	Ajax.request("/sys/activity/discount/doPrice", {
		"data" : pd,
		"success" : function(data) {
			if (data.result == "200") {
				parent.getLimitGoods();
				closed()
			} else {
				alert(data.msg);
			}
		}
	});
}
</script>
</html>