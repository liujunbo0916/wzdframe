<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>申请退款</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/store.css" rel="stylesheet" />
<link href="/css/duyun/wode-tuikuan.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
</head>
<style>
.l {
	width: 100px;
	height: 100px;
}

.img-text-list .img-box {
	width: 100px;
	height: 100px;
	flex: 0 0 30%;
}

content {
	background: #EFEFEF;
}

.content .bill-info {
	padding: 18px;
	background: #FFF;
}

.content .bill-info .bill-status {
	color: #FC9313;
	font-size: 18px;
	line-height: 18px;
	margin-bottom: 8px;
	margin-top: -10px;
}

.content .bill-info>p {
	color: #999999;
	font-size: 12px;
	line-height: 18px;
	margin-bottom: 8px
}

.content .link-info {
	display: flex;
	align-items: center;
	justify-content: center;
	background: #FFF;
	padding: 11px;
	margin-top: 10px;
}

.link-info>div {
	flex: 1;
	color: #333;
	font-size: 16px;
	line-height: 16px;
	text-align: center;
	padding: 2px;
}

.link-info>div:before {
	content: '';
	display: inline-block;
	width: 16px;
	height: 16px;
	background-repeat: no-repeat;
	background-size: 16px auto;
	background-position: bottom;
	margin-right: 10px;
}

.link-info .custom-service:before {
	background-image: url(/img/duyun/icons/custom.png);
}
</style>
<body>
	<div>
		<ul class="tuihuo-list margin-t20 bg-fff">
			<!--申请服务-->
			<li style="margin-top: -10px">
				<div class="content">
					<div class="bill-info">
						<c:if test="${dataModel.rebacktype == 0}">
							<div class="bill-status">申请退款</div>
							<p id="status_tell">用户可申请退款！</p>
						</c:if>
						<c:if test="${dataModel.rebacktype == 1}">
							<div class="bill-status">退款审核中</div>
							<p id="status_tell">我们会在24小时内处理订单！</p>
						</c:if>
						<c:if test="${dataModel.rebacktype == 2}">
							<div class="bill-status">退款审核失败</div>
							<p id="status_tell">用户退款订单有误，请联系客服！</p>
						</c:if>
						<c:if test="${dataModel.rebacktype == 3}">
							<div class="bill-status">退款成功</div>
							<p id="status_tell">退款金额将原路退回！</p>
						</c:if>
					</div>
				</div>
			</li>
			<c:if test="${not empty goods}">
				<li>
					<div class="img-text-list"
						onclick="getGoodsDetail('+${item.goods_id}+')">
						<div class="img-box">
							<img class="l" src="${SETTINGPD.IMAGEPATH}${goods.list_img}" />
						</div>
						<div class="text-list margin-t12">
							<p class="f333">${goods.goods_name }</p>
							<p class="font-s12 f999">
								<c:if test="${goods.goods_attr ne '-1'}">${goods.goods_attr}</c:if>
							</p>
							<p class="fad8a54 margin-t12">
								￥${goods.shop_price}&nbsp;&nbsp;&nbsp;<span class="f666">X${goods.goods_count}</span>
							</p>
						</div>
					</div>
				</li>
			</c:if>
			<li>
				<p class="f999">申请服务：</p>
				<p>退货退款</p>
			</li>
			<!--退货金额-->
			<li>
				<p class="f999">退货金额：</p>
				<p class="font-s12 fad8a54 ">
					￥${goods.shop_price}<span class="f999"></span>
				</p>
			</li>
			<!--退货原因-->
			<li>
				<p class="f999">退货原因：</p>
				<p>
					<input type="text" name="refund_reason" id="refund_reason"
						value="${refundData.refund_reason}" />
				</p>
			</li>
			<c:if test="${dataModel.rebacktype == 2}">
				<li>
					<div class="link-info">
						<div class="custom-service">联系客服</div>
					</div>
				</li>
			</c:if>

		</ul>
		<c:if test="${dataModel.rebacktype == 0}">
			<div class="tuikuo-btn margin-t40">
				<button onclick="submit()">提交申请</button>
			</div>
		</c:if>

	</div>
	<%@ include file="common/commJs.jsp"%>
</body>
<script>
	function submit() {
		if ($("#refund_reason").val() == null
				|| $("#refund_reason").val() == '') {
			alert("请输入退货原因");
			return false;
		}
		Ajax.request("/wx/order/orderReturn", {
			"data" : {
				"refund_reason" : $("#refund_reason").val(),
				"order_id" : '${dataModel.order_id}',
				"goods_id" : '${dataModel.goods_id}',
				"goods_sku_id" : '${dataModel.goods_sku_id}'
			},
			"success" : function(data) {
				if (data.code = 200) {
					window.location.href = '/wx/order/orderDetail?order_id='+${dataModel.order_id};
				} else {
					alert(data.msg());
				}
			}
		});
	}
</script>
</html>
