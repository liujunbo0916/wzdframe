<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>跟团游订单详情</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/dcx.css">
    <link href="/css/reset.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
</head>
<script type="text/javascript">
	var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/grouptour/indexwenhaoresultType=orderList";
</script>
<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <div class="bill-info">
            <div class="bill-status"></div>
            <p id="status_tell"></p>
        </div>
        <!--产品信息-->
        <div class="prod-info">
            <div class="title-wrap">
                <div class="type-name">产品信息</div>
            </div>
            <div class="property-wrap">
                <div class="prod-name">荔波小七孔门票</div>
                <div class="property-item">
                    <span>门票价格：</span>
                    <span id="ticket_type">成人票</span>
                </div>
                <div class="property-item">
                    <span>出行日期：</span>
                    <span id="ticket_date">2017-08-24</span>
                </div>
                <div class="property-item">
                    <span>出行人数：</span>
                    <span id="ticket_num">1人</span>
                </div>
            </div>
        </div>

        <!--出游人信息-->
        <div class="consignee-info">
            <div class="title-wrap">
                <div class="type-name">出游人信息</div>
            </div>
        </div>

        <!--二维码验证-->
        <!-- <div class="travel-info">
        	<div class="title-wrap">
                <div class="type-name">二维码信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>订单号：</span>
                    <span id="onderNo">1006662320</span>
                </div>
                <div class="property-item">
                    <span>验证码：</span>
                    <span id="">487966</span>
                </div>
            </div>
            <div class="qrcode-wrap">
                <img src="/img/duyun/dcx/1.jpg" alt="" />
            </div>
        </div> -->

        <!--订单信息-->
        <div class="order-info">
            <div class="title-wrap">
                <div class="type-name">订单信息</div>
            </div>
            <div class="property-wrap">
             	<div class="property-item">
                    <span>订单号：</span>
                    <span id="onderNo">1006662320</span>
                </div>
                <div class="property-item">
                    <span>预订日期：</span>
                    <span id="create_date">2017-08-24</span>
                </div>
                <div class="property-item">
                    <span>支付方式：</span>
                    <span id="payType">在线支付</span>
                </div>
                <div class="property-item">
                    <span>订单总额：</span>
                    <span><span>￥</span><span id="totalMoney">40</span></span>
                </div>
            </div>
        </div>
  		 <!--联系人信息-->
        <div class="order-info">
            <div class="title-wrap">
                <div class="type-name">联系人信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>联系人姓名：</span>
                    <span id="link_people"></span>
                </div>
                <div class="property-item">
                    <span>联系电话：</span>
                    <span id="link_phone"></span>
                </div>
            </div>
        </div>
        <div class="link-info">
            <div class="custom-service">联系客服</div>
            <div class="bussiness-num">商家电话</div>
        </div>

        <div class="operation">
            <div class="btn btn-outlined btn-cancel">取消订单</div>
        </div>
    </div>
    <!--支付-->
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
					value="" id="param_order_id" /> <input type="hidden" value=""
					id="moudle_type" />
				<button onclick="surePay();">确定付款</button>
			</div>
		</div>
	</div>
</body>
<%@ include file="common/commJs.jsp"%>
	<%@ include file="common/pay.jsp"%>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/swiper.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript">
//加载事件
$(function(){
	   requestDetail();
});

//请求订单详情数据
function requestDetail(){
	   Ajax.request("/wx/order/dogroupTourOrderDetail",{"data":{"order_id":'${pd.order_id}'},"success":function(data){
		   if(data.code == 200){
			  try{
				 var data = data.data;
				   if(data){
					// 0待支付  1 待使用 2 已使用  3已取消 4退款中（所有游客都是退款中订单状态才是退款中）5已退款  6订单已关闭 7 订单已删除
					   if(data.orderState == 0){
						   $(".bill-status").html("待付款");
						   $("#status_tell").html("请完成付款，逾期订单自动取消");
						}else if(data.orderState == 1){
							$(".bill-status").html("待使用");
							 $("#status_tell").html("您的订单已成功，请提前安排时间到取票点取票！");
						}else if(data.orderState == 2){
							$(".bill-status").html("已使用");
							 $("#status_tell").html("您的订单已完成，感谢你的光临，欢迎再次预定！");
						}else if(data.orderState == 4){
							$(".bill-status").html("退款中");
							 $("#status_tell").html("您的订单退款正在审核中，请耐心等待！");
						}else if(data.orderState == 5){
							$(".bill-status").html("已退款");
							 $("#status_tell").html("您的订单已成功退款，感谢你的光临，欢迎再次预定！");
						}else if(data.orderState == 6){
							$(".bill-status").html("已关闭");
							 $("#status_tell").html("您的订单已关闭，感谢你的光临，欢迎再次预定！");
						}
					   $(".prod-name").html("【跟团游】"+data.grouptourName);
					   $("#ticket_type").html("成人：￥"+data.adultPrice+"&nbsp;&nbsp;&nbsp;儿童：￥"+data.childrenPrice);
					   $("#ticket_date").html(data.departureDate);
					   $("#ticket_num").html("成人："+data.adultNum+" 人&nbsp;&nbsp;&nbsp;儿童："+data.childrenNum+" 人");
						   var traveler='';
						   for (var i = 0;  i < data.traveler.length;  i++) {
							   if(data.traveler[i].type == 0){
								   data.traveler[i].type="儿童"
							   }else if(data.traveler[i].type == 1){
								   data.traveler[i].type="成人"
							   }
							   traveler+='<div class="property-wrap">'
							   	+'<div class="property-item"><span>出行人('+data.traveler[i].type+')：</span><span>'+data.traveler[i].name+'</span></div>'
								+'<div class="property-item"><span>联系电话：</span><span>'+data.traveler[i].phone+'</span></div>'
								+'<div class="property-item"><span>身份证：</span> <span>'+data.traveler[i].idCard+'</span> </div></div>';
						   	}
						   if(traveler){
							   $(".consignee-info").append(traveler);
						   }
					   var payMoney=(data.adultPrice*data.adultNum)+(data.childrenPrice*data.childrenNum);
					   $("#link_people").html(data.linkPerple);
					   $("#link_phone").html(data.linkPhone);
					   $("#onderNo").html(data.orderSn);
					   /* $(".qrcode-wrap img").attr("src",""); */
					   var html='';
					   	if(data.orderState == 0 && data.payStatus == 0){
						   $(".travel-info").hide(); 
						   html+='<div class="btn btn-pay btn-outlined" onclick="toPayShow('+payMoney+','+data.orderId+');">去支付</div>';
						}
						if(data.orderState == 1 && data.payStatus == 1){
							html+='<div class="btn btn-cancel btn-outlined" onclick='+'cancleOrder("'+data.orderId+'","reback")'+'>退票</div>';
						} 
						if(data.orderState == 2 || data.orderState == 6 || data.orderState == 5 || data.orderState == 3 || (data.orderState == 0 && data.payStatus == 0)){
							html+='<div class="btn btn-cancel btn-outlined" onclick='+'cancleOrder("'+data.orderId+'","delete")'+'>删除订单</div>';
						}
						grouptourPhone=data.grouptourPhone;
						$(".operation").empty().append(html);
					    $("#totalMoney").html(payMoney);
				   }
			  }catch(e){
			  }
		   }
	   }});
	}
	/*  var grouptourPhone='';
	$(".bussiness-num").on("click",function(){
		window.location.href='wtai://wp//mc;'+grouptourPhone;
	});  */

	 function cancleOrder(orderId,opt,thisobj){
		var orderInfo = {
				order_id:orderId,
				optType:opt
		}
		if(opt=="delete"){
			if(!confirm("确认删除该订单？")){ //
				return;
			}
			Ajax.request("/logic/travel/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(orderInfo))},"success":function(data){
				if(data.code == 200){
					window.location.href="/wx/grouptour/index?resultType=orderList";
				}else{
					alert(data.msg);
				}
			}});
		}else if(opt=="reback"){
			if(!confirm("确认申请该订单退票吗？")){
				return;
			}
			window.location.href="/wx/grouptour/doGroupOrderRefund?order_id="+orderId;
		}
	} 
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
function toPayShow(money,orderId){
	var type=3;
	$("#toPay").fadeIn();
	$("#pay_money").text(money);
	$("#param_money").val(money);
	$("#param_order_id").val(orderId);
	$("#moudle_type").val(type)
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
	   toPay($("#param_money").val(),$("#moudle_type").val(),$("#param_order_id").val(),callUrl);
	}else if($("#param_pay_type").val() == "1"){ //余额支付
		if(!'${withdrawPw}'){
			window.location.href="/wx/user/setPayPwPage?type=goodsPaySure";
		}else{
		    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val()+"&zurl="+callUrl;
		}
	}
}
//监听返回按钮
GoBackBtn.excuteHistory("/wx/grouptour/index?resultType=orderList");
</script>

</html>