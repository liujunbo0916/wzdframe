<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>待发货</title>
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
    <link href="、vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/dfh.css">
</head>

<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <div class="bill-info">
            <div class="bill-status">待发货</div>
            <p>您的订单已成功，请等待商家发货</p>
        </div>
        <!--产品信息-->
        <div class="prod-info">
            <div class="title-wrap">
                <div class="type-name">产品信息</div>
            </div>
            <div class="property-wrap">
                <div class="prod-name">都匀毛尖茶</div>
                <div class="property-item">
                    <span>商品属性：</span>
                    <span>1斤</span>
                </div>
                <div class="property-item">
                    <span>订单金额：</span>
                    <span>￥230</span>
                </div>
                <div class="property-item">
                    <span>订单运费：</span>
                    <span>￥0</span>
                </div>
            </div>
        </div>

        <!--收货人信息-->
        <div class="consignee-info">
            <div class="title-wrap">
                <div class="type-name">收货人信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>商品属性：</span>
                    <span>吴吴</span>
                </div>
                <div class="property-item">
                    <span>联系电话：</span>
                    <span>135486946464</span>
                </div>
                <div class="property-item">
                    <span>收货地址：</span>
                    <span>广东省深圳市福田荣华路128号</span>
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

</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>