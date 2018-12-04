<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>待付款</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/dfk.css">
</head>

<body>
    <div class="content">
        <div class="bill-info">
            <div class="bill-status">待付款</div>
            <p>请在2017-08-24 19:00前完成付款，逾期订单自动取消</p>
        </div>
        <!--产品信息-->
        <div class="prod-info">
            <div class="title-wrap">
                <div class="type-name">产品信息</div>
            </div>
            <div class="property-wrap">
                <div class="prod-name">荔波小七孔门票</div>
                <div class="property-item">
                    <span>门票类型：</span>
                    <span>成人票</span>
                </div>
                <div class="property-item">
                    <span>出行日期：</span>
                    <span>2017-08-24</span>
                </div>
                <div class="property-item">
                    <span>出行人数：</span>
                    <span>1人</span>
                </div>
            </div>
        </div>
        <!--收货人信息-->
        <div class="consignee-info">
            <div class="title-wrap">
                <div class="type-name">出游人信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>出行人1：</span>
                    <span>吴吴</span>
                </div>
                <div class="property-item">
                    <span>身份证：</span>
                    <span>4489654355946464</span>
                </div>
            </div>
        </div>
        <!--订单信息-->
        <div class="order-info">
            <div class="title-wrap">
                <div class="type-name">订单信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>预订日期：</span>
                    <span>2017-08-24</span>
                </div>
                <div class="property-item">
                    <span>支付方式：</span>
                    <span>在线支付</span>
                </div>
                <div class="property-item">
                    <span>订单总额：</span>
                    <span>￥40</span>
                </div>
            </div>
        </div>

        <div class="link-info">
            <div class="custom-service">联系客服</div>
            <div class="bussiness-num">商家电话</div>
        </div>

        <div class="operation">
            <div class="btn btn-outlined btn-cancel">取消订单</div>
            <div class="btn btn-outlined btn-payment">去付款</div>
        </div>
    </div>

</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>