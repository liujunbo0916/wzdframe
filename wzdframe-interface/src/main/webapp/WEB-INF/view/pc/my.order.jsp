<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/my-order.css" type="text/css">

</head>
<body class="my-body">
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="order-body">
    <div class="my-order-content">
        <div class="row my-order-header">
            <div class="col-md-1 first active">
                全部
            </div>
            <div class="col-md-1 second">
                待付款
            </div>
            <div class="col-md-1 three">
                待出行
            </div>
            <div class="col-md-1 four">
                取消/退款
            </div>
        </div>
        <div class="row-order-list">
            <div class="row list-header">
                <div class="col-md-3 header-one">
                    订单信息
                </div>
                <div class="col-md-1 header-two">
                    类型
                </div>
                <div class="col-md-2 header-three">
                    行程日期
                </div>
                <div class="col-md-2 header-four">
                    支付金额
                </div>
                <div class="col-md-2 header-five">
                    订单状态
                </div>
                <div class="col-md-2 header-six">
                    操作
                </div>
            </div>
            <div class=" list-content">
                <div class="row bottom-line">


                <div class="col-md-3 content-one">
                    <div class="row-one">
                        <span class="item-one">
                            <span class="label-name">订单号:</span>
                            <span class="label-value">45678900</span>
                        </span>
                        <span class="item-one">
                            <span class="label-name">下单时间:</span>
                            <span class="label-value">2014-09-08 18:21:20</span>
                        </span>
                    </div>
                    <div class="row-two">
                        都匀2-5日自由行
                    </div>
                    <div class="row-three">
                        都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行
                    </div>
                </div>
                <div class="col-md-1 content-two">
                    跟团
                </div>
                <div class="col-md-2 content-three">
                    2017-08-10
                </div>
                <div class="col-md-2 content-four">
                    ¥1230
                </div>
                <div class="col-md-2 content-five">
                   <p>未出行</p>
                    <p class="order-detail">订单详情</p>
                </div>
                <div class="col-md-2 content-six">
                    <p>删除订单</p>
                    <p>取消订单</p>
                </div>
                </div>
            </div>
            <div class=" list-content">
                <div class="row bottom-line">
                <div class="col-md-3 content-one">
                    <div class="row-one">
                        <span class="item-one">
                            <span class="label-name">订单号:</span>
                            <span class="label-value">45678900</span>
                        </span>
                        <span class="item-one">
                            <span class="label-name">下单时间:</span>
                            <span class="label-value">2014-09-08 18:21:20</span>
                        </span>
                    </div>
                    <div class="row-two">
                        都匀2-5日自由行
                    </div>
                    <div class="row-three">
                        都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行
                    </div>
                </div>
                <div class="col-md-1 content-two">
                    跟团
                </div>
                <div class="col-md-2 content-three">
                    2017-08-10
                </div>
                <div class="col-md-2 content-four">
                    ¥1230
                </div>
                <div class="col-md-2 content-five">
                    <p>未出行</p>
                    <p class="order-detail">订单详情</p>
                </div>
                <div class="col-md-2 content-six">
                    <p class="go-pay">去付款</p>
                    <p>取消订单</p>
                </div>
                </div>
            </div>
            <div class=" list-content">
                <div class="row bottom-line last">
                <div class="col-md-3 content-one">
                    <div class="row-one">
                        <span class="item-one">
                            <span class="label-name">订单号:</span>
                            <span class="label-value">45678900</span>
                        </span>
                        <span class="item-one">
                            <span class="label-name">下单时间:</span>
                            <span class="label-value">2014-09-08 18:21:20</span>
                        </span>
                    </div>
                    <div class="row-two">
                        都匀2-5日自由行
                    </div>
                    <div class="row-three">
                        都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行都匀2-5日自由行
                    </div>
                </div>
                <div class="col-md-1 content-two">
                    跟团
                </div>
                <div class="col-md-2 content-three">
                    2017-08-10
                </div>
                <div class="col-md-2 content-four">
                    ¥1230
                </div>
                <div class="col-md-2 content-five">
                    <p>未出行</p>
                    <p class="order-detail">订单详情</p>
                </div>
                <div class="col-md-2 content-six">
                    <p>删除订单</p>
                    <p>取消订单</p>
                </div>
            </div>
            </div>
        </div>

    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="./js/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="./js/popper.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
<script src="home.js" type="text/javascript"></script>
<script src="travel.sure.js" type="text/javascript"></script>

</body>
</html>