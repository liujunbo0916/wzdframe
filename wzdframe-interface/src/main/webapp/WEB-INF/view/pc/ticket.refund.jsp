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
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="submit-refund-container">
    <div class="refund-header">
        <span class="my-order">我的订单</span>
        <span class="order-line">/</span>
        <span class="order-text">订单详情</span>
    </div>
    <div class="refund-middle">
        <div class="tuipiao-header">
            提交退票申请
        </div>
        <div class="row tuipiao-one">
            <div class="col-md-3 col tuipiao-col-one">
                <span class="tuipiao-label">订单编号：</span>
                <span class="tuipiao-value">${orderInfo.ticket_order_no}</span>
            </div>
            <div class="col-md-3 col tuipiao-col-one">
                <span class="tuipiao-label">下单时间：</span>
                <span class="tuipiao-value">${orderInfo.to_create_time}</span>
            </div>
            <div class="col-md-6 col tuipiao-col-two">
                <span class="tuipiao-label">订单金额：</span>
                <span class="tuipiao-money">¥${orderInfo.to_order_money}</span>
            </div>
        </div>
        <div class="tuipiao-route">
            <div class="row tuipiao-route-header">
                <span class="tuipiao-info-line"></span>
                <span class="info-text">票务信息</span>
            </div>
            <div class="tuipiao-route-content">
                <div class="row tuipiao-route-row">
                   ${orderInfo.to_ticket_name}
                </div>
                <div class="row tuipiao-route-row">
                    <span class="info-item">
                            <span>出行日期:</span>
                            <span>${orderInfo.to_travel_date}</span>
                        </span>
                  <!--   <span class="info-item">
                            <span>回程日期:</span>
                            <span>2017-06-12</span>
                        </span> -->
                    <span class="info-item">
                            <span>成人:</span>
                            <span>¥${orderInfo.to_settlement_price}*${orderInfo.to_quantity}</span>
                        </span>
                    <span class="info-item">
                            <span>总价:</span>
                            <span class="info-amount">￥${orderInfo.to_order_money}</span>
                        </span>
                </div>
            </div>
        </div>
        <c:if test="${orderInfo.to_is_realname eq '1'}">
	        <c:forEach  begin="0" end="${showRow-1}" var="ll">
		        <div class="row tuipiao-two">
		            <c:forEach items="${traverInfo}" begin="${ll*2}" end="${ll*2+1}" var="item">
			            <div class="col-md-4 col tuipiao-person-info">
			                <div class="row person-label-one">
			                   <div class="col-md-6 col label-left">
			                        ${item.to_name}
			                   </div>
			                    <div class="col-md-6 col label-right">
			                        <c:if test="${item.used_quantity eq 0 && item.refund_quantity eq 0 && item.apply_refund_quantity ne 1}">
			                           <img data-code="${item.ticket_code}" src="/img/duyun/pc/weixuan.png" class="not-choice-icon" alt="">
			                        </c:if>
			                        <c:if test="${item.used_quantity eq 1}">
			                            <span> 已使用</span>
			                        </c:if>
			                        <c:if test="${item.refund_quantity eq 1}">
			                            <span style="color: red;"> 已退票</span>
			                        </c:if>
			                        <c:if test="${item.apply_refund_quantity eq 1}">
			                            <span style="color: red;"> 已申请</span>
			                        </c:if>
			                    </div>
			                </div>
			                <div class="person-label-two">
			                    ${item.ticket_code}
			                </div>
			                <div class="person-label-two">
			                     ${item.to_idcard}
			                </div>
			            </div>
		            </c:forEach>
		        </div>
	        </c:forEach>
	        <div class="tuipiao-three">
		            <div class="refund-apply-content">
		                <div class="row apply-row">
		                    <div class="col-md-1 col apply-label">退票原因：</div>
		                    <div class="col-md-10 col apply-value">
		                        <textarea name="refund_reason" id="refund_reason" cols="65" rows="3"></textarea>
		                        <span class="number-span">
		                           <span class="number-count"><span id="minNum">0</span>/<span id="maxNum">100</span></span>
		                        </span>
		                    </div>
		                </div>
		            </div>
		        </div>
        </c:if>
         <c:if test="${orderInfo.to_is_realname ne '1'}">
		        <div class="tuipiao-three">
		            <div class="refund-apply">
		                退票申请
		            </div>
		            <div class="refund-apply-content">
		                <div class="row apply-row">
		                    <div class="col-md-1 col apply-label">退票数量：</div>
		                    <div class="col-md-10 col apply-value">
		                        <div class="input-group">
		                             <span class="input-group-btn">
		                            <button type="button" class="child-quantity-left-minus btn  btn-number"
		                                    data-type="minus" data-field="">
		                              <span class="glyphicon glyphicon-minus">-</span>
		                            </button>
		                        </span>
		                            <input type="text" id="child-quantity" name="quantity"
		                                   class="form-control input-number"
		                                   value="0" min="1" max="${orderInfo.no_use_quantity}" step="1"/>
		                            <span class="input-group-btn">
		                            <button type="button" class="child-quantity-right-plus btn  btn-number"
		                                    data-type="plus" data-field="">
		                                <span class="glyphicon glyphicon-plus">+</span>
		                            </button>
		                        </span>
		                            <span class="apply-count">共${orderInfo.no_use_quantity}张</span>
		                        </div>
		                    </div>
		                </div>
		                <div class="row apply-row">
		                    <div class="col-md-1 col apply-label">退票原因：</div>
		                    <div class="col-md-10 col apply-value">
		                        <textarea name="refund_reason" id="refund_reason" cols="65" rows="3"></textarea>
		                        <span class="number-span">
		                            <span class="number-count"><span id="minNum">0</span>/<span id="maxNum">100</span></span>
		                        </span>
		                    </div>
		                </div>
		            </div>
		        </div>
	        </c:if>
    </div>
    <div class="apply-submit-container">
        <button type="button"  onclick="refundApply()" class="apply-sub">提交申请</button>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
</body>
<script type="text/javascript">
   var refundInfo = {
		   ticketCodes:[], //退票人列表
		   id:'${orderInfo.id}',
		   orderNo:'${orderInfo.ticket_order_no}',
		   refund_quantity:0,
		   refund_reson:'',
		   maxQuantity:'${empty orderInfo.no_use_quantity?0:orderInfo.no_use_quantity}',
		   submitFlag:false,
		   isRealName:'${orderInfo.to_is_realname}',
		   opt:"reback"
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
	   
	   $(".btn-number").click(function(){
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
	   });
   });
   var refundApply = function(){
	   refundInfo.ticketCodes = [];
	   refundInfo.quantity = 0;
	   if(parseInt(refundInfo.isRealName)){
		   //实名认证退票 查找用户选择哪一个票号
		   $(".tuipiao-two").children().find("img").each(function(){
			   if($(this).attr("src").indexOf("yixuan") != -1){
				   refundInfo.ticketCodes.push($(this).attr("data-code"));
			   }
		   });
		   refundInfo.refund_quantity = refundInfo.ticketCodes.length;
		   if(refundInfo.refund_quantity == 0){
			   alert("请选择需要退的票");
			   return;
		   }
	   }else{
		   refundInfo.refund_quantity = $("#child-quantity").val();
		   if(refundInfo.maxQuantity < refundInfo.refund_quantity){
			   alert("退票数量超过未使用的票数量");
			   return;
		   }
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
	   Ajax.request("/logic/ticket/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(refundInfo))},
		   "success":function(data){
			   refundInfo.submitFlag = false;
			   if(data.code == "200"){
				   alert("已申请，请等待审核结果");
			   }else{
				   alert(data.msg);
			   }
	   },"error":function(){
		   refundInfo.submitFlag = false;
	   }});
   }
</script>
</html>