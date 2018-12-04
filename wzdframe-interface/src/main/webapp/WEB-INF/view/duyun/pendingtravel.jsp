<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>待出行</title>
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
</head>

<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <div class="bill-info">
            <div class="bill-status">待出行</div>
            <p>您的订单已成功，请提前安排时间到取票点取票</p>
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

        <!--出游人信息-->
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

        <!--二维码验证-->
        <div class="travel-info">
            <div class="property-wrap">
                <div class="property-item">
                    <span>订单号：</span>
                    <span>1006662320</span>
                </div>
                <div class="property-item">
                    <span>验证码：</span>
                    <span>487966</span>
                </div>
            </div>
            <div class="qrcode-wrap">
                <img src="/img/duyun/dcx/1.jpg" alt="" />
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
        </div>
    </div>

</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>