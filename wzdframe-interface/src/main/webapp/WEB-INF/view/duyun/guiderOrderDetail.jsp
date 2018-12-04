<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>订单填写</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/dingdan.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
		<link href="/css/pay-type.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
		<link href="/css/wode-information.css" rel="stylesheet" />
	</head>
	<style>
		.boxa {
		margin: 0 auto;
		width: 100%;
		}

.boxa-l {
	float: left;
	width: 70px;
	height: 70px;
	border-radius: 50px;
	overflow: hidden;
	margin-top: 15px;
	margin-left: -10px;
}

.headImg {
	width: 70px;
	height: 70px;
}

.boxa-r {
    float: left;
    margin-left: 10px;
    width: 50%;
    height: 100px;
    margin-top: -12px;
}

.text-lable{
    height: 15px;
    font-size: 13px;
    padding: 11px;
    margin-left: -10px;
}
.inpt-box ul li {
    border-bottom: 1px solid #e0e0e0;
    line-height: 1.1rem;
    overflow: hidden;
}
.fixed-btn button{
    color: #A89352;
    border: 1px solid #A89352;
}
	</style>
	<body>
		<div class="container">
			<!--title-->
			<!--input-->
			<div class="inpt-box">
				<ul>
					<li>
						<label>订单状态</label>
						<span>
						<!-- 0 待支付 1 已支付 2 已完成 3 已取消 4退款中 5已退款  6订单关闭  -->
						<c:if test="${dataModel.guide_status == 0}">待付款</c:if>
						<c:if test="${dataModel.guide_status == 1}">已支付</c:if>
						<c:if test="${dataModel.guide_status == 2}">已完成</c:if>
						<c:if test="${dataModel.guide_status == 3}">已取消</c:if>
						<c:if test="${dataModel.guide_status == 4}">退款中</c:if>
						<c:if test="${dataModel.guide_status == 5}">已退款</c:if>
						<c:if test="${dataModel.guide_status == 6}">订单关闭 </c:if>
						</span>
					</li>
				    <li>
						<label>下单时间</label>
						<span>${dataModel.create_time}</span>
					</li>
					<li>
						<label>出行人数</label>
						<span>${dataModel.person_number}</span>
					</li>
					<li>
						<label>预约时间</label>
						<span>${dataModel.book_time}</span>
					</li>
					<li>
						<label>联系人</label>
						<span>${dataModel.con_name}</span>
					</li>
					<li>
						<label>联系手机</label>
						<span>${dataModel.con_phone}</span>
					</li>
					<li>
						<label>预约地点</label>
						<span>${dataModel.book_address}</span>
					</li>
					<li style="height: 100px;"><label>导游信息</label>
					<div class="boxa" style="width: 100%;">
						<div class="boxa-l">
							<img class="headImg" src="${prefixImg}${dataModel.guider_logo}">
						</div>
						<div class="boxa-r">
							<div class="text-lable">${dataModel.guider_name}</div>
							<div class="text-lable">电话：${dataModel.guider_mobile}</div>
							<div class="text-lable">价格：${dataModel.guider_price} /天</div>
						</div>
					</div></li>
				</ul>
			</div>
			<!--预约须知-->
			<div class="text-box">
				<h2>订单须知</h2>
				<%-- <div class="text">
					${bookKnow}
				</div> --%>
				<div class="text">
					<ul class="cautions-items">
						<li><span>费用包含：都匀景区讲解员服务；1.2米以下儿童免费1.2米以上儿童按1人计费；</span></li>
						<li><span>费用不含：不含任何景点门票，不含任何景点门票；</span></li>
						<li><span>行程时间：3小时；</span></li>
						<li><span>行程内容：景区讲解员推荐或游客DIY的行程。</span></li>
					</ul>
				</div>
			</div>
			<div class="text-box">
				<div class="text">
				</div>
			</div>
			<div class="fixed-btn clearfix">
				<c:if test="${(dataModel.guide_status == 2 || dataModel.guide_status == 4 || dataModel.guide_status == 5 || dataModel.guide_status == 6) && dataModel.pay_status == 1}"><button class="r to-comment">评论</button></c:if>
				<c:if test="${dataModel.guide_status == 1 && dataModel.pay_status == 1}"><button class="r to-cancle">取消订单</button></c:if>
				<c:if test="${dataModel.guide_status == 0 && dataModel.pay_status == 0}"><button class="r to-delete">删除订单</button></c:if>
				<c:if test="${dataModel.guide_status == 0 && dataModel.pay_status == 0}"><button class="r to-pay">付款</button></c:if>
			</div>
		</div>
	</body>
	  <%@ include file="common/commJs.jsp"%>
	  <%@ include file="common/pay.jsp"%>
	  <script type="text/javascript">
	     GoBackBtn.excuteHistory("/wx/guider/bookOrder");
	     $(".to-pay").click(function(){
	    	 var price='${dataModel.guider_price}';
	    	 var orderId='${dataModel.id}';
	    	 if(!orderId || orderId < 0){
	    		 alert("导游预约订单有误，请联系管理员！")
	    	 }
	    	 if(!price || price < 0){
	    		 alert("导游预约订单金额有误，请联系管理员！")
	    	 }
	    	 toPayShow(price,orderId);
	    });
	       
	    $(function() {
	   		$("#toPay .fixed-bg").click(function() {
	   			$("#toPay").fadeOut();
	   		});
	   		$("#closePayType").click(function(){
	   			$("#toPay").fadeOut();
	   		});
	   	});
	       
	   	$(function() {
	   		$("#wechatPay").click(function() {
	   			$(this).children().eq(1).remove();
	   			$(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	   			$("#param_pay_type").val($(this).attr("data-type"));
	   			$("#yuePay").children().eq(1).remove();
	   		});
	   	});
	   	
	   	function toPayShow(money, orderId) {
	   		$("#toPay").fadeIn();
	   		$("#pay_money").text(money);
	   		$("#param_money").val(money);
	   		$("#param_order_id").val(orderId);
	   		$("#yuePay").attr("data-nosel", 1);
	   		$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu").addClass("yuebuzhu");
	   		if ($("#wechatPay").find(".select-width").length == 0) {
	   			$("#wechatPay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	   			$("#wechatPay").children().eq(1).remove();
	   		}
	   	}
	   	
	   	function surePay() {
	   		toPay($("#param_money").val(), 5, $("#param_order_id").val(),callUrl);
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
	   				id="pay_money">0.00</span></span>
	   		</div>
	   		<div class="sure-btn">
	   			<input type="hidden" value="2" id="param_pay_type" /> <input
	   				type="hidden" value="" id="param_money" /> <input type="hidden"
	   				value="" id="param_order_id" />
	   			<button onclick="surePay();">确定付款</button>
	   		</div>
	   	</div>
	   </div>
</html>
