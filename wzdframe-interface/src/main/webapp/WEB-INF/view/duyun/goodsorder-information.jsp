
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
<!-- <title>订单详情</title> -->
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/confirm-order.css" rel="stylesheet" />
<link href="/css/wode-information.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
<link href="/css/pay-type.css" rel="stylesheet" />
<style>
.fixed-btn button{
    color: #A89352;
    border: 1px solid #A89352;
}
</style>
</head>
<body>
	<div>
		<!--商家已发货71 97 110-->
		<div class="address shangj-wrap">
			<a>
				<div>
					<p>
						<c:if test="${data.order_status eq 0}">待付款</c:if>
						<c:if
							test="${data.order_status eq 1 || data.order_status eq 2 || data.order_status eq 3}">待发货</c:if>
						<c:if test="${data.order_status eq 4 || data.order_status eq 5}">待收货</c:if>
						<c:if test="${data.order_status eq 6}">待评价</c:if>
						<c:if test="${data.order_status eq 7}">已取消</c:if>
						<c:if test="${data.order_status eq 8}">订单完成</c:if>
						<c:if test="${data.order_status eq 9}">订单关闭</c:if>
					</p>
					<!-- <p class="margin-t12">剩8天自动确认订货</p> -->
				</div>
			</a>
		</div>
		<!--收货地址-->
		<div class="address margin-t20">
			<a>
				<div>
					<p class="f333">${data.contact_name}&nbsp;&nbsp;&nbsp;${data.contact_phone}</p>
					<p class="f666 font-s12 margin-t12">${data.province}${data.city}${data.area}${data.address}</p>
				</div>
			</a>
		</div>
		<!--商品介绍-->
		<div class="wrap">
			<div class="content ">
				<c:forEach items="${data.goodslist}" var="goods">
					<div class="clearfix con-boxs"
						onclick="goDetailPage('${data.order_id}','${goods.goods_id}','${goods.goods_sku_id}');">
						<img class="l" src="${SETTINGPD.IMAGEPATH}${goods.list_img}" />
						<div class="con clearfix">
							<div class="l">
								<p>${goods.goods_name}</p>
								<p class="font-s12 f666">
									<c:if test="${goods.goods_attr ne '-1'}">${goods.goods_attr}</c:if>
								</p>
								<p class="fad8a54 margin-t12">
									￥${goods.shop_price}&nbsp;&nbsp;&nbsp;<span class="f666">X${goods.goods_count}</span>
								</p>
							</div>
						</div>
						<c:if test="${data.order_status eq 6}">
							<div class="btn">
								<button class="r pingjia">评价</button>
							</div>
						</c:if>
						<c:if test="${data.order_status == 3 || data.order_status == 2 || data.order_status == 1 && data.pay_status == 1}">
							<div class="btn">
								<c:if test="${goods.is_refund eq 0 ||  goods.is_refund eq ''}">
									<button class="r reback" data-code="0">申请退款</button>
								</c:if>
								<c:if test="${goods.is_refund == 1}">
									<button class="r reback" data-code="1">退款审核</button>
								</c:if>
								<c:if test="${goods.is_refund == 2}">
									<button class="r reback" data-code="2">退款失败</button>
								</c:if>
								<c:if test="${goods.is_refund == 3}">
									<button class="r reback" data-code="3">退款成功</button>
								</c:if>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
		<!--商品详情-->
		<div class="shop-inform margin-t20">
			<ul>
				<li class="f999">
					<p>商品总价</p>
					<p>￥${data.goods_money}</p>
				</li>
				<li class="f999">
					<p>运费</p>
					<p>￥${data.shipping_money}</p>
				</li>
				<!-- 	<li class="f999">
					<p>使用优惠券</p>
					<p>-￥10.0</p>
				</li> -->
				<c:if
					test="${data.user_pay_points ne 0 && data.pay_by_points ne 0.0}">
					<li class="f999">
						<p>用${data.user_pay_points}积分</p>
						<p>-￥${data.pay_by_points}</p>
					</li>
				</c:if>
				<li>
					<p class="f333">实付</p>
					<p class="fad8a54">￥${data.pay_by_money}</p>
				</li>
				<c:if test="${empty data.give_points || data.give_points ne 0 }">
					<li>
						<p class="f333">赠送积分</p>
						<p class="fad8a54">${data.give_points}</p>
					</li>
				</c:if>
			</ul>
		</div>
		<!--订单详情-->
		<div class="bg-fff margin-t20 pd">
			<p>订单号：${data.order_sn}</p>
			<p style="margin-top: 10px;">下单时间：${data.create_time}</p>
		</div>
		<!--查看物流  确认收货-->
		<div class="fixed-btn clearfix">
			<%-- <c:if test="${data.order_status < 3 }">
				<button class="r" onclick="Order.cancleOrder(${data.order_id});">取消订单</button>
			</c:if> --%>
			<c:if test="${data.order_status eq 0 && data.pay_status eq 0}">
				<button class="r"
					onclick="Order.toPay('${data.pay_by_money}','2','${data.order_id}');">付款</button>
			</c:if>
			<c:if test="${data.order_status eq 5}">
				<button class="r" onclick="Order.signUp(${data.order_id});">确认收货</button>
			</c:if>
			<c:if
				test="${data.order_status eq 4 || data.order_status eq 5 || data.order_status eq 6 || data.order_status eq 8 || data.order_status eq 9}">
				<button class="r"
					onclick="window.location.href='/wx/order/orderlogistics?order_id=${data.order_id}';">查看物流</button>
			</c:if>
		</div>
	</div>
	<%@ include file="common/commJs.jsp"%>
	<script src="/js/page/Order.js"></script>
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
				<%-- <li data-type="1" data-nosel="0" id="yuePay"
					class="clearfix selectPayType">
					<!--左边-->
					<div class="icon-box l">
						<img src="/img/yue@2x.png" /> <span class="f666" id="yuePaySpan">余额支付&nbsp;&nbsp;￥${empty wallet.user_money ?0.00:wallet.user_money}</span>
					</div> <!--打勾-->
				</li> --%>
				<!--我发布的-->
				<li data-type="2" id="wechatPay" class="clearfix selectPayType">
					<!--左边-->
					<div class="icon-box l">
						<img src="/img/weixin@2x.png" /> <span class="f666">微信支付</span>
					</div>
					<div class="select-width r"><img src="/img/xuanze@2x.png"></div>
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
	<%@ include file="common/pay.jsp"%>
	<script type="text/javascript">
		 $(function(){
		    	$("#toPay .fixed-bg").click(function(){
		    		$("#toPay").fadeOut();
		    	});
		    	$("#closePayType").click(function(){
					$("#toPay").fadeOut();
				});
		    });
		 var userMoney = '${wallet.user_money}';
	    	$(function(){
	    		$("#yuePay").click(function(){
	    			if($(this).attr("data-nosel") == "1"){
	    				return;
	    			}else{
	    				$(this).children().eq(1).remove();
	       			    $(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	       			    $("#param_pay_type").val($(this).attr("data-type"));
	       			    $("#wechatPay").children().eq(1).remove();
	    			}
	    		});
	    		$("#wechatPay").click(function(){
	    			$(this).children().eq(1).remove();
	   			    $(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    			$("#param_pay_type").val($(this).attr("data-type"));
	    			$("#yuePay").children().eq(1).remove();
	    		});
	    	});
	    	function toPayShow(money,type,orderId){
	    		$("#toPay").fadeIn();
	    		$("#pay_money").text(money);
	    		$("#param_money").val(money);
	    		$("#param_order_id").val(orderId);
	    		if(userMoney){ //余额不足
	    			if(parseFloat(money) > parseFloat(userMoney)){
	    				$("#yuePay").attr("data-nosel",1);
	    				$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu").addClass("yuebuzhu");
	    				$("#param_pay_type").val("2");
	    				if($("#wechatPay").find(".select-width").length == 0){
	    				    $("#wechatPay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    				    $("#yuePay").children().eq(1).remove();
	    				}
	        		}else{//余额可以支付
	        			$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu");
	        			$("#param_pay_type").val("1");
	        			if($("#yuePay").find(".select-width").length == 0){
	        			   $("#yuePay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	        			   $("#wechatPay").children().eq(1).remove();
	        			}
	        		}
	    		}else{ //余额不足
	    			$("#param_pay_type").val("2");
	    			$("#yuePay").attr("data-nosel",1);
	    			$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu").addClass("yuebuzhu");
	    			if($("#wechatPay").find(".select-width").length == 0){
	    				$("#wechatPay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    				 $("#wechatPay").children().eq(1).remove();
	    			}
	    		}
	    	}
	    	function surePay(){
	    		if($("#param_pay_type").val() == "2"){
	    		   toPay($("#param_money").val(),1,$("#param_order_id").val());
	    		}else if($("#param_pay_type").val() == "1"){ //余额支付
	    			if(!'${pd.withdrawPw}'){
	    				window.location.href="/wx/user/setPayPwPage?type=goodsPay";
	    			}else{
	    			    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val();
	    			}
	    		}
	    	}
	    	//跳转到详情页面
	    	function goDetailPage(order_id,goods_id,goods_sku_id){
	    		if($(event.target).hasClass("pingjia")){
	    			window.location.href='/wx/order/addGoodsComment?order_id=${data.order_id}&goods_id='+goods_id;//评价
	    		}else if($(event.target).hasClass("reback")){
	    			var rebacktype=$(event.target).attr("data-code");
	    			window.location.href='/wx/order/doApplyRefund?order_id='+order_id+'&goods_id='+goods_id+'&goods_sku_id='+goods_sku_id+'&rebacktype='+rebacktype;//退款
	    		}else{
	    			window.location.href='/wx/product/detail?p_id='+goods_id;
	    		}
	    	}
		</script>
</body>
</html>
