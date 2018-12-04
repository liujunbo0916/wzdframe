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
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
 <title>特产订单</title> 
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/store-nav.css" rel="stylesheet" />
<link href="/css/store.css" rel="stylesheet" />
<link href="/css/my-order.css" rel="stylesheet" />
<link href="/css/shib.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
 <link rel="stylesheet" href="/css/duyun/lymp.css">
<script src="/js/shipei.js"></script>
<style type="text/css">
.yuebuzhu {
	color: #999;
}
.load-more {
    width: 50%;
    margin: 0 auto;
}
.load-more .btn-block {
    color: #ff7d13;
}
.btn-block {
    display: block;
    width: 100%;
    padding: 15px 0;
    margin-bottom: 10px;
    font-size: 18px;
}
.btn-w {
    position: relative;
    display: inline-block;
    padding: 6px 8px 7px;
    margin-bottom: 0;
    font-size: 12px;
    font-weight: 400;
    line-height: 1;
    color: #333;
    text-align: center;
    white-space: nowrap;
    vertical-align: top;
    cursor: pointer;
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 3px;
}
.btn:active, .btn.active {
    color: inherit;
    background-color: #ccc;
}
.btn-block {
    display: block;
    width: 100%;
    padding: 15px 0;
    margin-bottom: 10px;
    font-size: 18px;
}
.spinner {
    position: fixed;
    display: none;
    z-index: 99;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.3);
    width: 100%;
    height: 100%;
    align-items: center;
    justify-content: center;
}
.spinner .loading {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 150px;
    height: 100px;
    background: rgba(0, 0, 0, 0.8);
    border-radius: 5px 5px;
}
.spinner .loading > img {
    width: 50px;
    height: 50px;
}
.wrapper-next ul li{
    background: #fff;
}
</style>
<script type="text/javascript">
		    var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/order/myOrderwenhaocurrentPage=1jiahaotype=3jiahaoorder_status=3jiahaorectType=orderList";
		</script>
</head>
<body class="body-scroll">
	<div>
		<!--nav-->
		<nav class="nav-scroll">
			<ul>
				<li codeFlag=""><a
					<c:if test="${empty pd.type || pd.type == ''}">class="select"</c:if>>全部</a></li>
				<li codeFlag="0"><a
					<c:if test="${not empty pd.type && pd.type eq 0}">class="select"</c:if>>待付款</a></li>
				<li codeFlag="3"><a
					<c:if test="${not empty pd.type && pd.type eq 3}">class="select"</c:if>>待发货</a></li>
				<li codeFlag="4"><a
					<c:if test="${not empty pd.type && pd.type eq 4}">class="select"</c:if>>待收货</a></li>
				<li codeFlag="6"><a
					<c:if test="${not empty pd.type && pd.type eq 6}">class="select"</c:if>>待评价</a></li>
			</ul>
		</nav>
		<div class="box"></div>
		<!--图文列表-->
		<div class="container1" id="wrapper">
			<div class="wrapper-next" style="width: 100%">
					<ul id="appendText">
					</ul>
				<div class="load-more">
				    <button class="btn-w btn-block">加载更多</button>
				</div>
			</div>
		</div>
		<!-- 无数据显示 -->
			<div class="imgs" style="display: none;">
				<img src="/img/meiyoushuju@2x.png" />
				<p>暂时没有数据</p>
			</div>
		  <div class="spinner">
			        <div class="loading">
			            <img src="/img/duyun/dstc/loading.gif" alt=""/>
			        </div>
		  </div> 
	</div>
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
	<script src="/js/page/Order.js"></script>
	<script>
	 var loadingMore = document.querySelector('.load-more');
	 var loadingPanel = document.querySelector('.spinner');
		 var condition = {
				currentPage : "1",
				type:'',
				order_status:'${pd.order_status}',
		 }
		 $(function(){
		    	$("#appendText").empty();
		    	loadMore(condition);
		    	$("nav ul li").click(function(){
					$(this).siblings().children(0).removeClass("select");
					$(this).children(0).addClass("select");
					var codeFlag = $(this).attr("codeFlag");
					condition.type=codeFlag;
					condition.currentPage = 1;
					condition.order_status = codeFlag;
					$("#appendText").empty();
					loadMore(condition);
				});
				$(".load-more").click(function() {
					delete condition.currentPage;
					loadMore(condition);
				});
		    });
		 
		function loadMore(condition) {
			loadingPanel.style.display = 'flex';
		    responseData.sendRequest("/wx/order/doOrderList",condition,callBack);
		}
		
		function callBack(data){
			var prefixImg = data.prefixImg;
			var pd = data.pd;
			var data = data.resultPd;
			condition.order_status = pd.order_status;
			for (var i = 0; i < data.length; i++) {
				var htmlAry='';
				var order_status=data[i].order_status;
				var order_status_html='';
				if(order_status==0){
					order_status_html='<p class="l f666" style="float: right;">待付款</p>';
				}else if(order_status==1 || order_status==2){
					order_status_html='<p class="l f666" style="float: right;">配货中</p>';
				}else if(order_status==3){
					order_status_html='<p class="l f666" style="float: right;">待发货</p>';
				}else if(order_status==4){
					order_status_html='<p class="l f666" style="float: right;">已发货</p>';
				}else if(order_status==5){
					order_status_html='<p class="l f666" style="float: right;">已送达</p>';
				}else if(order_status==6){
					order_status_html='<p class="l f666" style="float: right;">交易完成</p>';
				}else if(order_status==7){
					order_status_html='<p class="l f666" style="float: right;">已取消</p>';
				}else if(order_status==8){
					order_status_html='<p class="l f666" style="float: right;">订单完成</p>';
				}else if(order_status==9){
					order_status_html='<p class="l f666" style="float: right;">订单关闭</p>';
				}
				htmlAry+='<li><div  class="container1"><div onclick="window.location.href='+"'"+'/wx/order/orderDetail?order_id='+data[i].order_id+''+"'"+'" class="clearfix time"><p class="l f666">'
								+ data[i].create_time
								+ '</p>'+order_status_html+'</div>';
				var tempCount = 0;
				var goodsList = data[i].goodList;
				for (var j = 0; j < goodsList.length; j++) {
					htmlAry+='<div onclick="window.location.href='+"'"+'/wx/order/orderDetail?order_id='+data[i].order_id+''+"'"+'" class="img-text-list border-bottom"><div class="img-box"><img src="'
									+ prefixImg
									+ goodsList[j].list_img
									+ '"/></div>';
					htmlAry+='<div class="text-list margin-t12"><p class="f333">'
									+ goodsList[j].goods_name + '</p>';
					if(goodsList[j].goods_attr != '-1'){
						htmlAry+='<p class="font-s12 f999">'
								+ goodsList[j].goods_attr
								+ '</p>';
					}
					htmlAry+='<p class="fad8a54 margin-t12">￥'
							+ goodsList[j].shop_price + '</p></div></div>';
					tempCount += goodsList[j].goods_count;
				}
				htmlAry+='<div class="all text-right"><p class="f999">共'
						+ tempCount + '件商品  合计：<span class="fad8a54">￥'
						+ data[i].order_money + '</span></p></div>';
				htmlAry+='<div class="btn">';
				/* if(data[i].order_status == 0 || data[i].order_status == 1 || data[i].order_status == 2 ||data[i].order_status == 3){
					htmlAry
					+='<button onclick="Order.cancleOrder('+data[i].order_id+');">取消订单</button>';
				} */
				if(data[i].order_status == 0){
					htmlAry+='<button onclick="Order.toPay('+data[i].order_money+',2,'+data[i].order_id+');">付款</button>';
				}
				if(data[i].order_status == 4||data[i].order_status == 5){
					htmlAry+='<button onclick="Order.signUp('+data[i].order_id+');">签收</button>';
				} 
				if(data[i].order_status == 6){
					htmlAry+=' <button onclick='+"'"+'window.location.href="/wx/order/addGoodsComment?order_id='+data[i].order_id+'"'+"'"+'>评价</button>';
				}
				htmlAry+="</div></div></li>";
				$("#appendText").append(htmlAry);
			}
			if(data.length > 0){
				$(".imgs").hide();
			}else{
				$(".imgs").show();
			}
		}
		 
		//GoBackBtn.excuteHistory("/wx/user/userCenter");
		
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
	    		   toPay($("#param_money").val(),1,$("#param_order_id").val(),callUrl);
	    		}else if($("#param_pay_type").val() == "1"){ //余额支付
	    			if(!'${withdrawPw}'){
	    				window.location.href="/wx/user/setPayPwPage?type=goodsPaySure";
	    			}else{
	    			    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val()+"&zurl="+callUrl;
	    			}
	    		}
	    	}
	    	//返回按钮控制
	    	 GoBackBtn.excuteHistory("/wx/duyun/user/center");
	</script>
</body>
</html>
