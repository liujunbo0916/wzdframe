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
<title>订单填写</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/dingdan.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
<link href="/css/pay-type.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
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
    margin-top: -10px;
}
.text-lable{
    height: 15px;
    font-size: 13px;
    padding: 11px;
    margin-left: -10px;
}
</style>
<body>
	<div class="container">
		<!--title-->
		<!--input-->
		<div class="inpt-box">
			<ul>
				<li style="height: 100px;"><label>导游信息</label>
					<div class="boxa" style="width: 100%;">
						<div class="boxa-l">
							<img class="headImg" src="${prefixImg}${agency.guider_logo}">
						</div>
						<div class="boxa-r">
							<div class="text-lable">${agency.guider_name}</div>
							<div class="text-lable">昵称：${agency.guider_nickname}</div>
							<div class="text-lable">价格：${agency.guider_price} /天</div>
						</div>
					</div></li>
				<li><label>出行人数</label> <input type="text" id="person_number" />
				</li>
				<li><label>预约时间</label> <input style="background-color: #FFF;"
					type="date" id="book_time" /></li>
				<li><label>联系人</label> <input type="text" id="con_name" /></li>
				<li><label>联系手机</label> <input type="number" id="con_phone" />
				</li>
				<li><label>预约地点</label> <input type="text" id="book_address" />
				</li>
			</ul>
		</div>
		<!--预约须知-->
		<div class="text-box">
			<h2>预约须知</h2>
			<div class="text">
				<ul class="cautions-items">
					<li><span>费用包含：都匀景区讲解员服务；1.2米以下儿童免费1.2米以上儿童按1人计费；</span></li>
					<li><span>费用不含：不含任何景点门票，不含任何景点门票；</span></li>
					<li><span>行程时间：3小时；</span></li>
					<li><span>行程内容：景区讲解员推荐或游客DIY的行程。</span></li>
				</ul>
			</div>
		</div>
	</div>
	<!--sumbit-->
	<a class="sumbit" onclick="submitBtn();">提交订单</a>
</body>
<%@ include file="common/commJs.jsp"%>
<%@ include file="common/pay.jsp"%>
<script type="text/javascript">
	var callUrl = "/wx/guider/bookOrder";
	var isSubmit = false;
	function submitBtn() {
		if (!isSubmit) {
			if ($("#person_number").val().isEmpty()
					|| !$("#person_number").val().isNumber()) {
				alert("请注意出行人数输入正确");
				return;
			}
			if ($("#book_time").val().isEmpty()) {
				alert("预约时间不能为空");
				return;
			}
			if ($("#con_name").val().isEmpty()) {
				alert("请输入联系人");
				return;
			}
			if ($("#con_phone").val().isEmpty()
					|| !$("#con_phone").val().isPhone()) {
				alert("请输入正确的手机号码格式");
				return;
			}
			if ($("#book_address").val().isEmpty()) {
				alert("请输入预约地点");
				return;
			}
			alert($("#book_time").val());
			Ajax.request("/wx/guider/bookOrderSub", {
				"data" : {
					"person_number" : $("#person_number").val(),
					"book_time" : $("#book_time").val(),
					"con_name" : $("#con_name").val(),
					"con_phone" : $("#con_phone").val(),
					"book_address" : $("#book_address").val(),
					"guider_id" : '${agency.guiderId}'
				},
				"success" : function(data) {
					if (data.code == 200) {
						toPayShow(data.price, 2, data.id);
					} else {
						alert(data.msg);
					}
				}
			});
		}
	}
	$(function() {
		$("#toPay .fixed-bg").click(function() {
			$("#toPay").fadeOut();
		});
		$("#closePayType").click(function(){
			$("#toPay").fadeOut();
			window.location.href = '/wx/guider/index?resultType=detail&guiderId='+'${agency.guiderId}';
		});
	});
	var userMoney = '${wallet.user_money}';
	$(function() {
		$("#wechatPay").click(function() {
			$(this).children().eq(1).remove();
			$(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
			$("#param_pay_type").val($(this).attr("data-type"));
			$("#yuePay").children().eq(1).remove();
		});
	});
	function toPayShow(money, type, orderId) {
		$("#toPay").fadeIn();
		$("#pay_money").text(money);
		$("#param_money").val(money);
		$("#param_order_id").val(orderId);
		$("#moudle_type").val(type)
		$("#param_pay_type").val("2");
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
