<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>跟团游订单</title>
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<!-- Sets initial viewport load and disables zooming -->
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="email=no" name="format-detection" />
<link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/wddd.css">
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
<style type="text/css">
  .bar-header-secondary ~ .content{
      padding-top: 0px;
  }
  .bar-header-secondary{
  top: 0px; 
  }
</style>
</head>
<script type="text/javascript">
		    var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/grouptour/indexwenhaoresultType=orderList";
		</script>
<body>
	<!-- Make sure all your bars are the first things in your <body> -->
	<nav class="bar bar-standard bar-header-secondary">
	 
		<div class="segmented-control">
			     <a class="control-item active all" data-code="all" href="javascript:;">
                全部
            </a>
            <a class="control-item wait_payment" data-code="no_pay" href="javascript:;">
                待付款
            </a>
            <a class="control-item wait_trip" data-code="no_use" href="javascript:;">
                待出行
            </a>
            <a class="control-item refund" data-code="cancle" href="javascript:;">
                取消/退款
            </a>
        </div>
	</nav>

	<!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
	<div class="content">
		<!--全部-->
		<ul id="tickect_orderlist" class="control-content table-view active">
		
		</ul>
		<!--加载更多-->
		<div class="load-more" style="display: block;">
			<button class="btn btn-block" >加载更多</button>
		</div>
	</div>
	<!--设定预加载效果-->
	<div class="spinner">
		<div class="loading">
			<img src="/img/duyun/icons/loading.gif" alt="" />
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
	<%@ include file="common/commJs.jsp"%>
	<%@ include file="common/pay.jsp"%>
	<script src="/vendors/ratchet/js/ratchet.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script src="/js/RequestDataForPage.js"></script>
		<script type="text/javascript" src="/js/BASE64.js"></script>
	<script type="text/javascript" src="/js/InheritString.js"></script>
	<script type="text/javascript">
		var loadingPanel = document.querySelector('.spinner');
		var loadingMore = document.querySelector('.load-more');
		var condition = {
			selectType : "all",
			pageSize : '6',
		}
		$(function() {
			loadMore(condition);
			$(".control-item").click(function() {
				condition.selectType = $(this).attr("data-code");
				condition.currentPage = 1;
				$("#tickect_orderlist").empty()
				loadMore(condition);
			});
			$(".load-more").click(function() {
				delete condition.currentPage;
				loadMore(condition);
			});
		});

		function loadMore(param) {
			loadingPanel.style.display = 'flex';
			responseData.sendRequest("/wx/order/dogroupTourOrderList", param,
					callBack);
			loadingPanel.style.display = 'none';
		}
		var tpls = '<li class="table-view-cell media" ><div class="order-header"><div class="order-id">订单编号：<span>{{0}}</span></div>'
				+ '<div class="order-status">{{1}}</div></div><div class="order-content" onclick='+'window.location.href='+'"{{9}}"'+'><div class="img-wrap">'
				+ '<img src="{{2}}" alt=""><span>跟团游</span></div><div class="pro-wrap">'
				+ '<div class="pro-title">{{3}}</div><div class="pro-type">线路价格：<span>{{4}}</span></div><div class="pro-date">出行日期：<span>{{5}}</span></div>'
				+ '<div class="pro-date">出行人数：<span>{{8}}</span></div><div class="pro-price">￥{{6}}</div></div></div><div class="order-footer">{{7}}</div></li>';
				
		//自定义渲染函数
		function callBack(data) {
			var dataAry = [];
			var prefixImg = data.prefixImg;
			var data = data.resultPd;
			if(data.length != 6){
				loadingMore.style.display = 'none';
			}else{
				loadingMore.style.display = 'flex';
			}
			for (var i = 0; i < data.length; i++) {
				// 0待支付  1 待使用 2 已使用  3已取消 4退款中（所有游客都是退款中订单状态才是退款中）5已退款  6订单已关闭 7 订单已删除
				dataAry[0] = data[i].orderSn;
				if(data[i].orderState == 0){
					dataAry[1] = '待付款';
				}else if(data[i].orderState == 1){
					dataAry[1] = '待使用';
				}else if(data[i].orderState == 2){
					dataAry[1] = '已使用';
				}else if(data[i].orderState == 3){
					dataAry[1] = '已取消';
				}else if(data[i].orderState == 4){
					dataAry[1] = '退款中';
				}else if(data[i].orderState == 5){
					dataAry[1] = '已退款';
				}else if(data[i].orderState == 6){
					dataAry[1] = '已关闭';
				}else if(data[i].orderState == 7){
					dataAry[1] = '已删除';
				}
				dataAry[2] = prefixImg + data[i].grouptourImg;
				
				if(data[i].grouptourName.length > 18){
					data[i].grouptourName=data[i].grouptourName.substring(0,17)+"...";
				}
				dataAry[3] = "【跟团游】"+data[i].grouptourName;
				/* dataAry[4] = "成人：￥ "+data[i].adultPrice+"<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;儿童：￥ "+data[i].childrenPrice; */
				dataAry[4] = "￥ "+data[i].adultPrice;
				dataAry[5] = data[i].departureDate;
				var payMoney=(data[i].adultPrice*data[i].adultNum)+(data[i].childrenPrice*data[i].childrenNum);
				dataAry[6] = payMoney;
				var html='';
				//payStatus 0待支付 1 已支付 2已取消 3退款中 4已退款
				//orderState 0待支付  1 待使用 2 已使用  3已取消 4退款中（所有游客都是退款中订单状态才是退款中）5已退款  6订单已关闭 7 订单已删除
				if(data[i].orderState == 0 && data[i].payStatus == 0){
					html+='<div class="btn btn-pay btn-outlined" onclick="toPayShow('+payMoney+','+data[i].orderId+');">去支付</div>';
				}
				if(data[i].orderState == 1 && data[i].payStatus == 1){
					html+='<div class="btn btn-cancel btn-outlined" onclick='+'cancleOrder("'+data[i].orderId+'","reback")'+'>退票</div>';
				} 
				if(data[i].orderState == 2 || data[i].orderState == 6 || data[i].orderState == 5 || data[i].orderState == 3 || (data[i].orderState == 0 && data[i].payStatus == 0)){
					html+='<div class="btn btn-cancel btn-outlined" onclick='+'cancleOrder("'+data[i].orderId+'","reback")'+'>删除订单</div>';
				}
				dataAry[7]=html;
				/* dataAry[8] = "成人："+data[i].adultNum+" 人 &nbsp;&nbsp;儿童："+data[i].childrenNum+" 人"; */
				dataAry[8] = (parseInt(data[i].adultNum)+parseInt(data[i].childrenNum))+" 人 ";
				dataAry[9] = '/wx/grouptour/index?resultType=orderDetail&order_id='+data[i].orderId;
				$("#tickect_orderlist").append(responseData.buildFtl(tpls, dataAry));
				dataAry.length = 0; //清空数组
			}
		}
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
						window.location.reload();
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
	        GoBackBtn.excuteHistory("/wx/duyun/user/center");
	</script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>