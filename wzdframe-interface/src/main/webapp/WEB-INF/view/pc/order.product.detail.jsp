<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-sure-detail.css" type="text/css">
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="sure-body">
    <div class="sure-header">
        <span class="order-text" style="cursor: pointer;" onclick="window.location.href='/order/list'">我的订单</span>
        <span class="order-line">/</span>
        <span class="my-order">订单详情</span>
    </div>
    <div class="sure-middle">
        <div class="row wait-content">
            <div class="col-md-9 wait-go">
                        <c:if test="${data.order_status eq 0}">待付款</c:if>
						<c:if test="${data.order_status eq 1 || item.order_status eq 2}">配货中</c:if>
						<c:if test="${data.order_status eq 3}">待发货</c:if>
						<c:if test="${data.order_status eq 4}">已发货</c:if>
						<c:if test="${data.order_status eq 5}">已送达</c:if>
						<c:if test="${data.order_status eq 6}">交易完成</c:if>
						<c:if test="${data.order_status eq 7}">已取消</c:if>
						<c:if test="${data.order_status eq 8}">订单完成</c:if>
						<c:if test="${data.order_status eq 9}">订单关闭</c:if>
            </div>
            <div class="col-md-3 wait-money">
                                                ￥ ${data.order_money}
            </div>
        </div>
        <div class="row middle-content">
            <div class="col-md-4">
                <span>订单编号：</span>
                <span class="order-tel">${data.order_sn}</span>
            </div>
            <div class="col-md-3">
                <span>下单时间：</span>
                <span class="order-tel">${data.create_time}</span>
            </div>
            <div class="col-md-2"></div>
            <div class="col-md-3 order-money">
                订单金额
            </div>
        </div>
    </div>
    <div class="row travel-sure-content">
        <div class="col-md-8 order-info">
            <div class="order-info-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">联系人信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">姓名:</span>
                        </div>
                        <div class="route-value">
                            ${data.contact_name}
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">联系电话:</span>
                        </div>
                        <div class="route-value">
                           ${data.contact_phone}
                        </div>
                    </div>
                      <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">收货地址:</span>
                        </div>
                        <div class="route-value">
                              ${data.province} ${data.city} ${data.area}${data.address}   
                        </div>
                    </div>
                </div>
            </div>
     <div class=" good-info">
            <div class="row good-header">
                <div class="col-md-4 col">
                    <span class="info-line"></span>
                    <span class="info-text">商品信息</span>
                </div>
                <div class="col-md-2 col header-item">规格</div>
                <div class="col-md-2 col header-item">单价(元)</div>
                <div class="col-md-2 col header-item">数量</div>
                <div class="col-md-2 col header-item"></div>
            </div>
            <c:set var="goodsPrice" value="0"></c:set>
            <c:forEach items="${data.goodslist}" var="goods">
	            <div class="row good-content">
	                <div class="col-md-4 col">
	                    <div class="row good-item">
	                        <div class="col-md-3 col item-left">
	                            <img src="${SETTINGPD.IMAGEPATH}${goods.list_img}" class="good-img" alt="">
	                        </div>
	                        <div class="col-md-6 col item-right" style="line-height:20px;height: 70px; margin-top: 8px;overflow: hidden">
	                           ${goods.goods_name}
	                        </div>
	                    </div>
	                </div>
	                <div class="col-md-2 col item-right">
	                <c:if test="${not empty goods.goods_attr && goods.goods_attr ne '-1'}">
	                ${goods.goods_attr}
	                </c:if>
	                </div>
	                <c:set var="goodsPrice" value="${goodsPrice + goods.shop_price*goods.goods_count}"></c:set>
	                <div class="col-md-2 col item-right">¥${goods.shop_price}</div>
	                <div class="col-md-2 col item-right">${goods.goods_count}</div>
	                   <c:if test="${data.order_status eq 5}">
	                     <div class="col-md-2 col item-right">退货
	                     </div>
	                 </c:if>
	            </div>
            </c:forEach>
            <div class=" good-footer">
                <p class="footer-item">
                    <span class="good-amount">商品总计</span>
                    <span>¥${goodsPrice}</span>
                </p>
                 <p class="footer-item">
                    <span class="good-amount">运费总计</span>
                    <span>¥38.00</span>
                </p>
            </div>
        </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
</body>
</html>