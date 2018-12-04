<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/order-success.css" type="text/css">

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
                        <li class="periodContent choice" style="left: 0;">提交订单</li>
                    </span>
                    <span>
                        <a class="periodTitle selected" style="left:144px;"></a>
                        <li class="periodContent choice" style="left:144px;">确认支付</li>
                    </span>
                    <span>
                        <a class="periodTitle selected" style="left:288px;"></a>
                         <li class="periodContent choice" style="left:288px;">完成购买</li>
                    </span>
                </div>
                <span class="filling_line"></span>
            </div>
        </div>
    </div>
</div>
<div class="body">
    <div class="special-content">
        <div class="sure-order-header">
            <div class="sure-order-one">
                <img src="./img/promise.png" class="promise-img" alt="">
                <span class="success-text">您的订单提交成功！</span>
            </div>
            <div class="sure-order-two">
                <span>订单号：</span>
                <span>${dataModel.ticket_order_no}</span>
            </div>
            <div class="sure-order-three">
                <c:if test="${dataModel.type eq 'ticket'}">
                   <span class="text">系统已向</span>
                   <span class="text">${dataModel.to_contact_mobile}</span>
                   <span class="text">发送了凭证短信，请你妥善保存并在入园当天使用，您可通过</span>
                   <span class="text-color" onclick="window.location.href='/order/ticket/list?selectType=all'">我的订单</span>
                    <span class="text" onclick="orderDetail('${dataModel.id}')">查看详情</span>
                </c:if>
                <!-- 商品支付成功 -->
                 <c:if test="${dataModel.type eq 'product'}">
                    <span class="text">商品购买成功，请等待商家发货！</span>
                    <span class="text-color" onclick="window.location.href='/order/list'">我的订单</span>
                    <span class="text" onclick="orderDetail('${dataModel.id}')">查看详情</span>
                </c:if>
                 <c:if test="${dataModel.type eq 'travel'}">
                   <span class="text">已成功购买！</span>
                   <span class="text-color" onclick="window.location.href='/order/travel/list'">我的订单</span>
                    <span class="text" onclick="orderDetail('${dataModel.id}')">查看详情</span>
                </c:if>
            </div>
        </div>
        <div class=" order-info">
            <p class="info-one">
                为方便您查看订单信息，可扫描二维码关注服务公众号
            </p>
            <img src="/img/duyun/pc/home/qhyscercode.jpg" class="scanner-img" alt="">
            <p class="info-two">
                都匀旅游
            </p>
            <p class="info-two">
                服务公众号
            </p>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
</body>
<script type="text/javascript">
function orderDetail(ticketId){
	var refundInfo = {
			id:ticketId
	}
	window.location.href="/order/ticket/detail?paramStr="+Base64.encode(JSON.stringify(refundInfo))
}
</script>
</html>