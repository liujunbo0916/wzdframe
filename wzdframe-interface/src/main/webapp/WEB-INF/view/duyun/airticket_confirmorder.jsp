<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
   	<title>机票订单详情</title>
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
    <link rel="stylesheet" href="/css/duyun/jpddxq.css">
</head>

<body>
    <!--底部导航栏-->
    <footer class="bar bar-tab">
        <div class="toolbar">
            <span class="bar-item total-price">
                <div>￥961 <div class="person-num">（共0人）</div></div>
                <div>订单总价</div>
                <span class="detail-txt up" onclick="showFlightDetail()">
                    明细
                    <img src="/img/duyun/icons/arrow_up.png" alt="" />
                </span>
            </span>
            <span class="bar-item btn-buy" onclick="goLogin()">提交订单</span>
        </div>
    </footer>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <div class="order-info-wrap">
            <div class="flight-wrap">
                <a class="flight-chosen">
                    <div class="flight-item">
                        <div class="aircraft-info">
                            <div class="icon-trip">去</div>
                            <div>08-22 周二 21:45</div>
                            <div>经济舱</div>
                        </div>
                        <div class="trip-info">
                            <span>宝安机场T1</span>
                            -
                            <span>都匀机场</span>
                        </div>
                    </div>
                    <div class="flight-item">
                        <div class="aircraft-info">
                            <div class="icon-trip">返</div>
                            <div>08-25 周五 16:40 </div>
                            <div>经济舱</div>
                        </div>
                        <div class="trip-info">
                            <span>都匀机场</span>
                            -
                            <span>宝安机场T1</span>
                        </div>
                    </div>
                </a>
                <div class="flight-price">
                    <div class="first-row">
                        <div>成人票: ￥861</div>
                        <div>
                            <a href="#">退改签规则</a>
                            <a href="#">儿童票说明</a>
                        </div>
                    </div>
                    <div class="second-row">机建燃油：￥100 +￥0</div>
                </div>
            </div>
            <div class="traveller-list">
                <div class="traveller-add">
                    <div>乘机人</div>
                    <img src="/img/duyun/icons/plus.png" />
                </div>
                <div class="traveller-item">
                    <div class="item-label">
                        <img src="/img/duyun/icons/delete.png" alt="" />
                    </div>
                    <div class="item-content">
                        <div class="traveller-name">乌达</div>
                        <div class="traveller-code">445895788956845278（成人）</div>
                    </div>
                </div>
            </div>
            <div class="traveller-info">
                <div class="info-item">
                    <div>联系人</div>
                    <div>乌达</div>
                </div>
                <div class="info-item">
                    <div>联系电话</div>
                    <div>15467464633</div>
                </div>
                <!--<div class="info-item">
                    <div>邮箱</div>
                    <div></div>
                </div>-->
            </div>
        </div>
    </div>

    <!--飞机票明细-->
    <div id="popover" class="flight-detail">
        <div class="content">
            机票信息
        </div>
    </div>
    <script type="text/javascript">
        // 显示popover
        var showPopover = function (popNode) {
            var popover = popNode || document.getElementById('popNode');
            popover.style.display = 'block';
            var backdrop = document.createElement('div');
            backdrop.classList.add('backdrop');
            backdrop.style.zIndex = 8;
            popover.parentNode.appendChild(backdrop);
            popover.classList.add('visible');
            backdrop.addEventListener('touchend', function () {
                closePopover();
            });
        };

        // 隐藏popover
        var hiddenPopover = function (popNode) {
            var popover = popNode || document.getElementById('popNode');
            popover.style.display = 'none';
            var backdrop = document.querySelector('.backdrop');
            popover.parentNode.removeChild(backdrop);
            popover.classList.remove('visible');
        };

        // 隐藏popover
        var closePopover = function () {
            var toggleBtn = document.querySelector('.detail-txt');
            var popover = document.getElementById('popover');
            hiddenPopover(popover);
            toggleBtn.classList.add('up');
            toggleBtn.children[0].setAttribute('src', '/img/duyun/icons/arrow_up.png');
        };
        
        var showFlightDetail = function () {
            var toggleBtn = document.querySelector('.detail-txt');
            var popover = document.getElementById('popover');
            if(toggleBtn.classList.contains('up')){
                toggleBtn.classList.remove('up');
                toggleBtn.children[0].setAttribute('src', '/img/duyun/icons/arrow_down.png');
                popover.style.removeProperty('top');
                showPopover(popover);
            }else {
                toggleBtn.classList.add('up');
                toggleBtn.children[0].setAttribute('src', '/img/duyun/icons/arrow_up.png');
                closePopover(popover);
            }
        };
    </script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>