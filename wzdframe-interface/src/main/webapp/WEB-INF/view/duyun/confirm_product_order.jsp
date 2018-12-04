<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>确认商品订单</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/confirm-order.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
<style type="text/css">
.yuebuzhu {
	color: #999;
}

#pointChecked, #is_mer_title {
	-webkit-appearance: none;
	border-radius: 0px;
	border: 0px;
	width: 0px;
	-webkit-tap-highlight-color: transparent;
	outline: none;
	background: none;
	text-decoration: none;
}
</style>
<script type="text/javascript">
	//微信支付成功
	var callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/order/myOrderwenhaocurrentPage=1jiahaotype=3jiahaoorder_status=3&jiahaooptType=${pd.optType}jiahaoredirectType=${pd.type}jiahaop_id=${pd.p_id}";
	var cancelUrl = "/wx/order/myOrder?currentPage=1&type=1&order_status=1";
</script>
</head>
<body>
	<!--收货地址-->
	<div class="address">
		<a href='/wx/duyun/user/doaddressList?type=0&actType=${pd.addtype}&buytype=${pd.type}'>
			<div>
				<c:if test="${empty address}">
					<p class="f333">请选择地址</p>
					<p class="f333"></p>
				</c:if>
				<c:if test="${not empty address}">
					<p class="f333">${address.contact_name}&nbsp;&nbsp;&nbsp;${address.contact_phone}</p>
					<p class="f666 font-s12 margin-t12">${address.province}${address.city}${address.area}${address.address}</p>
					<input type="hidden" value="${address.address_id}" id="address_id" />
				</c:if>
			</div> <i class="icon-right"></i>
		</a>
	</div>
	<!--商品介绍-->
	<div class="wrap">
		<c:set value="0" var="totalMoeny"></c:set>
		<c:set value="0" var="expressMoeny"></c:set>
		<div class="content ">
			<c:forEach items="${cartList}" var="item">
				<div class="cart-info" style="margin-top: 15px;"
					data-cartid='${item.cart_id}' data-skuid='${item.sku_id}'
					data-num='${item.goods_number}'
					class="border-bottom clearfix con-box goodsItem"
					onclick="window.location.href='/wx/product/detail?p_id=${item.goods_id}'">
					<img class="l" style="width: 80px; height: 80px;"
						src="${SETTINGPD.IMAGEPATH}${item.list_img}" />
					<div class="con clearfix">
						<div class="l">
							<p>${item.goods_name}</p>
							<p class="font-s12 f666" style="display: block; height: 20px;">
								<c:if test="${item.attr_json ne '-1'}">${item.attr_json}</c:if>
							</p>
							<p class="fad8a54">￥${item.price}</p>
						</div>
						<p class="f666 font-s12 text-X1">X ${item.goods_number}</p>
					</div>
				</div>
				<c:set value="${totalMoeny+(item.price*item.goods_number)}"
					var="totalMoeny"></c:set>
				<c:if test="${item.is_free_shipping eq '0'}">
					<c:set value="${expressMoeny+item.goods_freight}"
						var="expressMoeny"></c:set>
				</c:if>
			</c:forEach>
			<div class="text-box">
				<p>
					总计：<span class="fad8a54">￥<span id="goodsTotalPrice">${totalMoeny}</span>
				</p>
				<p class="f666">
					<c:choose>
						<c:when test="${empty expressMoeny || expressMoeny eq 0}">
				        免运费
				     </c:when>
						<c:otherwise>
					     （含运费￥<span id="freightPrice">${expressMoeny}</span>）
					 </c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</div>
	<%-- 	<div class="wrap-youh">
		<c:if test="${fn.length(coupons) > 0}">
			<div class="wrap-con clearfix">
				<span class="l ">使用优惠券</span> <i class="icon-right"></i>
			</div>
		</c:if>
	<!-- 	<div class="wrap-con clearfix" id="pointDivChecked">
			<span class="l">可用<span id="userPoint"></span>积分抵￥<span
				id="pointPayMoeny"></span></span>
			<div class="check-box r">
				<input name="checkbox" id="pointChecked" type="checkbox"
					checked="checked">
			</div>
		</div> -->
	</div> --%>
<!-- 	<div class="wrap-youh">
		<div class="wrap-con clearfix" id="merdiv">
			<span class="l">配送方式</span>
			<div class="check-box r">
				<input name="checkbox" id="is_mer_title" type="checkbox">快递
				<input name="checkbox" id="is_mer_title" type="checkbox"> 到店自提
			</div>
		</div>
	</div>
 -->	<div class="wrap-youh">
		<div class="wrap-con clearfix" id="merdiv">
			<span class="l">开具发票</span>
			<div class="check-box r">
				<input name="checkbox" id="is_mer_title" type="checkbox">
			</div>
		</div>
		<div class="wrap-con clearfix" style="border-bottom: 0px;">
			<input type="text" placeholder="请填写发票抬头"
				style="border: 1px solid #e0e0e0; height: 35px; width: 80%; text-indent: .3rem; margin-top: 10px;"
				name="mer_title" id="mer_title" /> <span style="margin-left: 20px;"><span
				id="alreadyWord">0</span>/<span id="noWriteWord">50</span></span> <input
				type="text" placeholder="请填写发票税号"
				style="border: 1px solid #e0e0e0; height: 35px; width: 80%; text-indent: .3rem; margin-top: 10px;"
				name="mer_no" id="mer_no" />
		</div>
			<div class="wrap-con clearfix" style="border-bottom: 0px;display: none;">
			<input type="text" placeholder="请填写纳税人识别号"
				style="border: 1px solid #e0e0e0; height: 35px; width: 80%; text-indent: .3rem; margin-top: 10px;"
				name="mer_no" id="mer_no" /> 
		</div>
	</div>
	
	<!--提交订单-->
	<div class="cart-js">
		<div class="yf margin-t20 l">
			<p style="margin-top: 8px;">
				总计：<span class="fad8a54">￥<span id="orderTotalPrice">${totalMoeny+expressMoeny}</span></span>
			</p>
			<!-- <p class="font-s12  f999" id="getPoint">
				（可获得<span id="includePoint">0</span>积分）
			</p> -->
		</div>
		<div class="cart-right r">
			<button id="submiOrder" style="background-color: #FF3C00;"
				onclick="MakeSureOrder.submiOrder(this);">去支付</button>
		</div>
	</div>
	<%@ include file="common/commJs.jsp"%>
	<%@ include file="common/pay.jsp"%>
	<script src="/js/page/MakeSureOrder.js"></script>
	<script type="text/javascript">
		$(function() {
			//页面样式控制
			MakeSureOrder.pageElemContrl();
			MakeSureOrder.requestUserPoint();
		});
		MakeSureOrder.data.addressId = '${address.address_id}';
		var addtype='${pd.addtype}';
		if(addtype == 1){
			MakeSureOrder.data.addType = 1;
		}
		//初始化订单数据
		MakeSureOrder.data.order.province = '${address.province}';
		MakeSureOrder.data.order.city = '${address.city}';
		MakeSureOrder.data.order.area = '${address.area}';
		MakeSureOrder.data.order.city_id = '${address.city_id}';
		MakeSureOrder.data.order.area_id = '${address.area_id}';
		MakeSureOrder.data.order.province_id = '${address.province_id}';
		MakeSureOrder.data.order.address = '${address.address}';
		MakeSureOrder.data.order.contact_name = '${address.contact_name}';
		MakeSureOrder.data.order.contact_phone = '${address.contact_phone}';
		MakeSureOrder.data.order.goods_id = '${dataModel.goods_id}';
		MakeSureOrder.data.order.sku_id = '${dataModel.stock.sku_id}';
		MakeSureOrder.data.order.attr_json = '${dataModel.stock.attr_json}';
		MakeSureOrder.data.order.goods_number = '${dataModel.goods_number}';
		MakeSureOrder.data.b2cOrder.proId = '${pd.pro_id}';
		MakeSureOrder.data.b2cOrder.goodsId = '${pd.goods_id}';
		MakeSureOrder.data.b2cOrder.skuId = '${pd.sku_id}';
		MakeSureOrder.data.b2cOrder.type = '${pd.type}';
		MakeSureOrder.data.b2cOrder.goodsNumber = '${pd.goodsNum}';
		$(function() {
			$("#toPay .fixed-bg").click(function() {
				$("#toPay").fadeOut();
			});
			$("#closePayType").click(function() {
				$("#toPay").fadeOut();
				window.location.href='/wx/product/detail?p_id='+'${pd.goods_id}';
			});
		});
		var userMoney = '${wallet.user_money}';
		$(function() {
			$("#yuePay")
					.click(
							function() {
								if ($(this).attr("data-nosel") == "1") {
									return;
								} else {
									$(this).children().eq(1).remove();
									$(this)
											.append(
													'<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
									$("#param_pay_type").val(
											$(this).attr("data-type"));
									$("#wechatPay").children().eq(1).remove();
								}
							});
			$("#wechatPay")
					.click(
							function() {
								$(this).children().eq(1).remove();
								$(this)
										.append(
												'<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
								$("#param_pay_type").val(
										$(this).attr("data-type"));
								$("#yuePay").children().eq(1).remove();
							});
		});
		function toPayShow(money, type, orderId) {
			$("#toPay").fadeIn();
			$("#pay_money").text(money);
			$("#param_money").val(money);
			$("#param_order_id").val(orderId);
			$("#moudle_type").val(type)
			if (userMoney) { //余额不足
				if (parseFloat(money) > parseFloat(userMoney)) {
					$("#yuePay").attr("data-nosel", 1);
					$("#yuePay").children().eq(0).children().eq(1).removeClass(
							"yuebuzhu").addClass("yuebuzhu");
					$("#param_pay_type").val("2");
					if ($("#wechatPay").find(".select-width").length == 0) {
						$("#wechatPay")
								.append(
										'<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
						$("#yuePay").children().eq(1).remove();
					}
				} else {//余额可以支付
					$("#yuePay").children().eq(0).children().eq(1).removeClass(
							"yuebuzhu");
					$("#param_pay_type").val("1");
					if ($("#yuePay").find(".select-width").length == 0) {
						$("#yuePay")
								.append(
										'<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
						$("#wechatPay").children().eq(1).remove();
					}
				}
			} else { //余额不足
				$("#param_pay_type").val("2");
				$("#yuePay").attr("data-nosel", 1);
				$("#yuePay").children().eq(0).children().eq(1).removeClass(
						"yuebuzhu").addClass("yuebuzhu");
				if ($("#wechatPay").find(".select-width").length == 0) {
					$("#wechatPay")
							.append(
									'<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
					$("#wechatPay").children().eq(1).remove();
				}
			}
		}
		function surePay() {
			if ($("#param_pay_type").val() == "2") {
				toPay($("#param_money").val(), 1, $("#param_order_id").val(),
						callUrl);
			} else if ($("#param_pay_type").val() == "1") { //余额支付
				if (!'${withdrawPw}') {
					window.location.href = "/wx/user/setPayPwPage?type=goodsPaySure";
				} else {
					window.location.href = "/wx/user/inputPw?type=gpay&order_id="
							+ $("#param_order_id").val() + "&zurl=" + callUrl;
				}
			}
		}

		function UrlSearch() {
			var name, value;
			var str = location.href; //取得整个地址栏
			var num = str.indexOf("?")
			str = str.substr(num + 1); //取得所有参数   stringvar.substr(start [, length ]
			var arr = str.split("&"); //各个参数放到数组里
			for (var i = 0; i < arr.length; i++) {
				num = arr[i].indexOf("=");
				if (num > 0) {
					name = arr[i].substring(0, num);
					value = arr[i].substr(num + 1);
					this[name] = value;
				}
			}
		}
		var Request = new UrlSearch();
		//监听返回按钮  
		if(addtype==1){
			GoBackBtn.excuteHistory("/wx/product/home");
		}else{
			if ('${pd.type}' == 'buyNow') {
				GoBackBtn.excuteHistory("/wx/product/detail?p_id="
						+ Request.goods_id + "&optType=" + Request.optType
						+ "&pageType=confirmOrder");
			} else {
				GoBackBtn.excuteHistory("/wx/cart/shopCart?redirectType=${pd.redirectType}");
			}
		}
	</script>
	<!--浮动层-->
	<div class="fixed" style="display: none;" id="toPay">
		<!-- style="display:none;" -->
		<div class="fixed-bg"></div>
		<div class="fixed-wrap">
			<ul class="content-list">
				<li>
					<div id="closePayType" class="back l">
						<img src="/img/cancel_icon.png" />
					</div>
					<p class="text-center font-s16">选择支付方式</p>
				</li>
				<!--我发布的-->
				<li data-type="2" id="wechatPay" class="clearfix selectPayType">
					<!--左边-->
					<div class="icon-box l">
						<img src="/img/weixin@2x.png" /> <span class="f666">微信支付</span>
					</div>
					<div class="select-width r">
						<img src="/img/xuanze@2x.png">
					</div>
				</li>
			</ul>
			<div class="clearfix pay">
				<span class="l">付款</span> <span class="fad8a54 r">￥<span
					id="pay_money">1180.00</span></span>
			</div>
			<div class="sure-btn">
				<input type="hidden" value="2" id="param_pay_type" /> <input
					type="hidden" value="" id="param_money" /> <input type="hidden"
					value="" id="param_order_id" />
				<button onclick="surePay();">确定付款</button>
			</div>
		</div>
	</div>
</body>
</html>
