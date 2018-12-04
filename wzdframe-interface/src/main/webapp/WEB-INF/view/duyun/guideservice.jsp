<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
   	<title>预约导游</title>
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
    <link rel="stylesheet" href="/css/duyun/yydy.css">
</head>

<body>
<!--     <header class="bar bar-nav">
        <a class="icon icon-left-nav pull-left"></a>
        <h1 class="title">预约导游</h1>
    </header> -->
   <!--  <nav class="bar bar-standard bar-header-secondary">
        <div class="segmented-control">
            <a class="control-item active" href="#reservationGuide">
                预约导游
            </a>
            <a class="control-item" href="#myOrder">
                我的订单
            </a>
        </div>
    </nav> -->
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <div class="yydy-wrap" onclick="window.location.href='/wx/user/guideServiceOrder'"></div>
    </div>

</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>