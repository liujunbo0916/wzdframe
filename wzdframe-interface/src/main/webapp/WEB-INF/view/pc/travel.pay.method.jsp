<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/sure.order.css" type="text/css">
</head>
<body>
<%@ include file="common/header.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row nav-container">
    <div class="col-md-1"></div>
    <div class="col-md-1"></div>
       <div class="col-md-2 nav-logo" onclick="window.location.href='/'">
      <img alt="" src="/img/duyun/pc/LOGO.png">
    </div>
    <div class="col-md-2 "></div>
    <div class="col-md-6 nav-time-line">
        <div class="time_line_box">
            <div class="time_line">
                <div>
                    <span>
                        <a class="periodTitle selected" style="left: 0;"></a>
                        <li class="periodContent" style="left: 0;">提交订单</li>
                    </span>
                    <span>
                        <a class="periodTitle selected" style="left:144px;"></a>
                        <li class="periodContent" style="left:144px;">确认支付</li>
                    </span>
                    <span>
                        <a class="periodTitle" style="left:288px;"></a>
                         <li class="periodContent" style="left:288px;">完成购买</li>
                    </span>
                </div>
                <span class="filling_line"></span>
            </div>
        </div>
    </div>
</div>
<div class="body">
    <div class="special-content" style="margin-bottom: 200px;">
        <div class="sure-order-header">
            <div class="sure-order-one">
                <img src="/img/duyun/pc/zfcg.png" class="promise-img" alt="">
                <span class="success-text">您的订单提交成功！</span>
            </div>
            <div class="sure-order-two" id="timeDown">
               <c:if test="${orderDisabled ne '1'}">
                <span>支付时间剩余：</span>
                <span class="time" id="hourTime">${hourTime}</span>
                <span>时</span>
                <span class="time" id="minuteTime">${minteTime}</span>
                <span>分</span>
                <span class="time" id="secondTime">${secondTime}</span>
                <span>秒，超时则订单关闭</span>
                </c:if>
                <c:if test="${orderDisabled eq '1'}">
                    <span style="color:#fc9313;">订单已关闭，请重新下单支付</span>
                </c:if>
            </div>
        </div>
        <div class=" good-info">
            <div class="row good-header">
                <div class="col-md-8 col item-left">
                    <span class="info-text">商品信息</span>
                </div>
                <div class="col-md-4 col item-right">
                    <span>订单号：</span>
                    <span>${orderInfo.order_sn}</span>
                </div>
            </div>
            <div class="row good-content">
                <div class="col-md-8 col item-left">
                     <span style="font-size: 12px;">
                  ${orderInfo.grouptour_name}
                    </span>
                </div>
                <c:if test="${orderInfo.adult_num > 0}">
                    <div class="col-md-2 col item-right" style="color: #fc9313;">成人x${orderInfo.adult_num}</div>
                </c:if>
                <c:if test="${orderInfo.children_num > 0}">
                    <div class="col-md-2 col item-right" style="color: #fc9313;">儿童x${orderInfo.children_num}</div>
                </c:if>
            </div>
            <div class="row good-content-two">
                <div class="col-md-8 col item-left">
                       <span class="zhifubao-item">
                           <img src="/img/duyun/pc/yixuan.png" class="choice-img" alt="">
                           <img src="/img/duyun/pc/zhifubao.png" class="value-img" alt="">
                           支付宝
                       </span>
                    <span class="weixin-item">
                           <img src="/img/duyun/pc/weixuan.png" class="choice-img" alt="">
                           <img src="/img/duyun/pc/weixin.png" class="value-img" alt="">
                          微信
                    </span>
                </div>
                <div class="col-md-4 col item-right">应付金额：<span style="color: #fc9313;">¥${orderInfo.pay_price}</span></div>
            </div>
        </div>
        <div class="row good-group">
            <div class="col-md-8 col item-left"></div>
            <div class="col-md-4 col item-right">
               <c:if test="${orderDisabled ne '1'}">
                  <button type="button" id="payNow"   class="btn btn-warning sub-order">确认支付</button>
               </c:if>
            </div>
        </div>
    </div>
    <%@ include file="common/footer.jsp"%>
    <div class="modal fade" id="zhifubaoModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog zhifubao-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                   <p class="zhifu-title">
                       支付中，请稍后...
                   </p>
                    <p class="zhifu-item">
                       您的支付请求已提交，请耐心等待支付结果
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="weixinModal" tabindex="-1" role="dialog"  aria-labelledby="weixinModalTitle"  aria-hidden="true">
        <div class="modal-dialog weixin-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header weixin-header" style="background: #E7F1ff;">
                    <div class="modal-title weixin-header-item" id="weixinModalTitle">微信支付</div>
                    <button type="button" class="close weixin-close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body weixin-body">
                    <p class="weixin-title">
                        请使用微信"扫一扫"，扫描二维码支付
                    </p>
                    <img style="border: 1px solid #D5D5D5;" id="zhifuQR" src="" class="weixin-scanner" alt="">
                </div>
            </div>
        </div>
    </div>
    <script src="/js/jquery.min.js" type="text/javascript"></script>
    <script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
    <script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
    <script src="/js/duyun/pc/home.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/Ajax.js"></script>
    <script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
  //计时器
   var  countDown = function(){
	  var secondDown = setInterval(function(){
		  //秒倒计时
		  var tempSecond = parseInt($("#secondTime").text());
		  var tempMinte = parseInt($("#minuteTime").text());
		  var tempHour = parseInt($("#hourTime").text());
		  if(tempSecond == 0){
			  if(tempMinte == 0){
				  if(tempHour == 0){
					  clearInterval(secondDown);
					  
					  $("#payNow").remove();
					  $("#timeDown").empty();
					  $("#timeDown").append('<span style="color:#fc9313;">订单已关闭，请重新下单支付</span>');
				  }else{
					  tempHour --;
					  tempMinte = 59;
					  tempSecond= 59;
				  }
			  }else{
				  tempMinte --;
				  tempSecond = 59;
			  }
		  }else{
		     tempSecond--;
		  }
		  if(tempSecond < 10){
			  tempSecond = "0"+tempSecond;
		  }
		  if(tempMinte < 10){
			  tempMinte = "0"+tempMinte;
		  }
		  if(tempHour < 10){
			  tempHour = "0"+tempHour;
		  }
		  $("#secondTime").text(tempSecond);
		  $("#minuteTime").text(tempMinte);
		  $("#hourTime").text(tempHour);
	  }, 1000);
  }
  //支付宝1 微信2
  var submitInfo = {
		  type:3,
		  payType:1,
		  orderId:'${orderInfo.order_id}',
		  money:'${orderInfo.pay_price}'
  }
  
  
  $(function(){
	 $(".zhifubao-item,.weixin-item").click(function(){
		 if($(this).hasClass("zhifubao-item")){
			 submitInfo.payType= 1;
		 }else{
			 submitInfo.payType= 2;
		 }
		 if($(this).children().eq(0).attr("src").indexOf("weixuan.png") != -1){
			 $(this).children().eq(0).attr("src","/img/duyun/pc/yixuan.png");
			 $(this).siblings().children().eq(0).attr("src","/img/duyun/pc/weixuan.png");
		 }else{
			 $(this).children().eq(0).attr("src","/img/duyun/pc/weixuan.png");
		 }
	 }); 
	 $('.zhifubao-none-icon').hide();
	    // $('.weixin-none-icon').show();
	    $('.weixin-icon').hide();
	 countDown();
	 $("#payNow").click(function(){
		 if(submitInfo.payType == 1){
			 window.location.href="/pay/getPayConfig?paramStr="+Base64.encode(JSON.stringify(submitInfo));
			/*  window.open("/pay/getPayConfig?paramStr="+Base64.encode(JSON.stringify(submitInfo)));
			 window.close(); */
		 }else{
		 $('#zhifubaoModal').modal('show');
			 Ajax.request("/pay/getPayConfig",{"data":{"paramStr":Base64.encode(JSON.stringify(submitInfo))},"success":function(data){
				 $('#zhifubaoModal').modal('hide');  
				 if(data.code == 200){
					    if(submitInfo.payType == 2){
					    	$("#zhifuQR").attr("src","/pay/qrGen?width=220&payContent="+data.data.code_url+"&height=220&");
					    	 $('#weixinModal').modal('show');
					    	var orderStatus =  setInterval(function(){
					    		requestOrderPayStatus(orderStatus);
					    	 }, 1000);
					    }else if(submitInfo.payType == 1){
					    	$("#alipay_content").text(data.data);
					    }
				    }
			 }});
		 }
	/* 	 $('.sub-order').click(function () {
	            setTimeout(function () {
	            	$("#weixinModal").modal('show');
	            }, 2000)
	    }) */
	 });
  });
  function requestOrderPayStatus(orderStatus){
	  Ajax.request("/pay/scanSuccess",{"data":{'orderId':'${orderInfo.order_id}',"type":"travel"},"success":function(data){
		  if(data.code == 200){
			  var data = data.data;
			  if(data.pay_status == 1){
				  window.clearInterval(orderStatus);
				  $('#weixinModal').modal("hide");
				  setTimeout(function(){
					  var orderInfo = {
							  type:'travel',
							  id:data.order_id,
							  to_contact_mobile:data.link_phone,
							  ticket_order_no:data.order_sn
					  }
					  window.location.href="/pay/paySuccess?paramStr="+Base64.encode(JSON.stringify(orderInfo));
				  }, 500);
			  }
		  }
	  }});
  }
</script>
</html>