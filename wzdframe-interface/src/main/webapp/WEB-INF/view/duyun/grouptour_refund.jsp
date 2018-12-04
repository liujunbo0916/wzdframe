<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket.refund.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/foot.css">
</head>
<style>
.submit-refund-container {
    width: 100%;
    margin: auto !important;
}
.refund-header {
    height: 45px;
    line-height: 45px;
    margin: auto auto auto 20px;
}
.my-order {
    color: #fc9313;
    font-size: 20px;
}
</style>
<body>
<div class="submit-refund-container">
    <div class="refund-header">
        <span class="my-order">跟团游申请订单退款</span>
    </div>
    <div class="refund-middle">
        <div class="row tuipiao-one">
            <div class="col-md-6 col tuipiao-col-one">
                <span class="tuipiao-label">订单编号：</span>
                <span class="tuipiao-value">${orderInfo.orderSn}</span>
            </div>
            </div>
              <div class="row tuipiao-one">
            <div class="col-md-6 col tuipiao-col-one">
                <span class="tuipiao-label">下单时间：</span>
                <span class="tuipiao-value">${orderInfo.createTime}</span>
            </div>
            </div>
              <div class="row tuipiao-one">
            <div class="col-md-6 col tuipiao-col-one">
                <span class="tuipiao-label">订单金额：</span>
                <span class="tuipiao-money">¥${orderInfo.totalPrice}</span>
            </div>
        </div>
        <div class="tuipiao-route">
            <div class="row tuipiao-route-header">
                <span class="tuipiao-info-line"></span>
                <span class="info-text">票务信息</span>
            </div>
            <div class="tuipiao-route-content">
                <div class="row tuipiao-route-row">
                   ${orderInfo.grouptourName}
                </div>
                <div class="row tuipiao-route-row">
                    <span class="info-item">
                            <span>出行日期:</span>
                            <span>${orderInfo.departureDate}</span>
                        </span>
                        </div>
                    <c:if test="${not empty orderInfo.adultNum && orderInfo.adultNum ne 0}">  
                          <div class="row tuipiao-route-row">
                         <span class="info-item">
                            <span>成人:</span>
                            <span>¥${orderInfo.adultPrice} * ${orderInfo.adultNum}</span>
                        </span>
                     </div>
                     </c:if>
                       
                    <c:if test="${not empty orderInfo.childrenNum && orderInfo.childrenNum ne 0}">
                    <div class="row tuipiao-route-row">
                        <span class="info-item">
                            <span>儿童:</span>
                            <span>¥${orderInfo.childrenPrice} * ${orderInfo.childrenNum}</span>
                        </span>    
                    </div>
                    </c:if>
                      <div class="row tuipiao-route-row">
                    <span class="info-item">
                            <span>总价:</span>
                            <span class="info-amount">￥${orderInfo.totalPrice}</span>
                        </span>
                </div>
            </div>
        </div>
	        <c:forEach  begin="0" end="${showRow-1}" var="ll">
		        <div class="row tuipiao-two">
		            <c:forEach items="${orderInfo.traveler}" begin="${ll*2}" end="${ll*2+1}" var="item">
			            <div class="col-md-4 col tuipiao-person-info">
			                <div class="row person-label-one" style="border-bottom:0px solid;">
			                   <div class="col-md-6 col label-left">
			                        ${item.name}
			                        <c:if test="${item.type eq 0}"><span  style="color:	#FF8C00">（儿童）</span></c:if>
			                        <c:if test="${item.type eq 1}"><span style="color:#228B22">（成人）</span></c:if>
			                   </div>
			                    <div class="col-md-6 col label-right">
			                       <c:if test="${empty item.refundStatus || item.refundStatus eq 0}">
			                           <img data-code="${item.id}" src="/img/duyun/pc/weixuan.png" class="not-choice-icon" alt="">
			                        </c:if>
			                        <c:if test="${item.refundStatus eq 1}">
			                            <span>申请中</span>
			                        </c:if>
			                        <c:if test="${item.refundStatus eq 2}">
			                            <span style="color: red;"> 已退款</span>
			                        </c:if>
			                        <c:if test="${item.refundStatus eq 3}">
			                            <span style="color: red;">退款失败</span>
			                        </c:if>
			                    </div>
			                </div>
			            </div>
		            </c:forEach>
		        </div>
	        </c:forEach>
	        <div class="tuipiao-three">
		            <div class="refund-apply-content">
		                <div class="row apply-row">
		                    <div class="col-md-1 col apply-label">退款原因：</div>
		                    <div class="col-md-10 col apply-value">
		                        <textarea name="refund_reason" id="refund_reason" cols="65" rows="3"></textarea>
		                        <span class="number-span">
		                           <span class="number-count"><span id="minNum">0</span>/<span id="maxNum">100</span></span>
		                        </span>
		                    </div>
		                </div>
		            </div>
		        </div>
    </div>
    <div class="apply-submit-container">
        <button type="button"  onclick="refundApply()" class="apply-sub">提交申请</button>
    </div>
</div>
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
</body>
<script type="text/javascript">
   var refundInfo = {
		   order_id:'${orderInfo.orderId}',
		   orderNo:'${orderInfo.orderSn}',
		   refund_quantity:0,
		   refund_reson:'',
		   submitFlag:false,
		   optType:"reback",
		   traveler:[]//退款人列表
   }
   $(function(){
	   $(".not-choice-icon").click(function(){
		   var thisSrc = $(this).attr("src");
		   if(thisSrc.indexOf('weixuan.png') != -1){
			   $(this).attr("src","/img/duyun/pc/yixuan.png");
		   }else{
			   $(this).attr("src","/img/duyun/pc/weixuan.png");
		   }
	   });
	   $('#refund_reason').bind('input propertychange', function() {
		      var minNum = $("#minNum").text();
		      var maxNum = $("#maxNum").text();
		      var valLength = $(this).val().length;
		      if(valLength >= 100){
		    	  $(this).val($(this).val().substring(0,100));
		    	  $("#minNum").text(100);
		    	  $("#minNum").text(0);
		      }else{
		    	  $("#minNum").text(100-valLength);
		    	  $("#minNum").text(valLength);
		      }
		});
/* 	   $(".btn-number").click(function(){
		   var numberValue = $("#child-quantity").val();
		   var type =    $(this).attr("data-type");
		   var maxValue = $("#child-quantity").attr("max");
		   if(type == "minus"){
			   if(numberValue != 1){
				   numberValue--;
			   }
		   }else if(type == "plus"){
			   if(numberValue != maxValue){
			      numberValue++;
			   }
		   }
		   $("#child-quantity").val(numberValue);
	   }); */
   });
   var refundApply = function(){
	   refundInfo.traveler = [];
	   refundInfo.quantity = 0;
	   //实名认证退票 查找用户选择哪一个票号
	   $(".tuipiao-two").children().find("img").each(function(){
		   if($(this).attr("src").indexOf("yixuan") != -1){
			   refundInfo.traveler.push($(this).attr("data-code"));
		   }
	   });
	   refundInfo.refund_quantity = refundInfo.traveler.length;
	   if(refundInfo.refund_quantity == 0){
		   alert("请选择需要退的票");
		   return;
	   }
	   if($("#refund_reason").val().isEmpty()){
		   alert("退款理由不能为空");
		   return;
	   }
	   refundInfo.refund_reson = $("#refund_reason").val();
	   if(refundInfo.submitFlag){
		   return;
	   }
	   refundInfo.submitFlag = true;
	   Ajax.request("/logic/travel/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(refundInfo))},
		   "success":function(data){
			   refundInfo.submitFlag = false;
			   if(data.code == "200"){
				   alert("已申请，请等待审核结果");
				   window.location.href="/wx/grouptour/index?resultType=orderList";
			   }else{
				   alert(data.msg);
			   }
	   },"error":function(){
		   refundInfo.submitFlag = false;
	   }});
   }
</script>
</html>