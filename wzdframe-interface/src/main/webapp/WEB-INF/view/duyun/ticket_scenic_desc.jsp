<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>景点介绍</title> 
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
    <link rel="stylesheet" href="/css/duyun/mpjdjs.css">
    <style type="text/css">
      .trip-detail img{
         width: 100%!important;
      }
    </style>
    
    
</head>
<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
      <div class="content">
        <div class="trip-detail">
           <!--  <div class="trip-item">
                <div class="trip-title main-title">景点介绍</div>
                <p>小七孔景区位于荔波县西南部，距县城28公里，距麻尾火车站36公里。是樟江风景名胜区的四大风景片区之一，地处贵州高原南缘地带，东经107°39′—107°95′，北纬25°12′—25°34′，总面积46.4平方公里。景区集林、洞、湖、石、水等多种景观于一体，玲珑秀丽，享有“超级盆景”之誉。景区以精巧、秀美、古朴、幽静著称，移步换景、令人耳目常新。</p>
            </div>
            <div class="trip-item">
                <div class="trip-title sub-title">
                    小七孔古桥
                    <div class="dot"></div>
                </div>
                <p>小七孔古桥建于清道光十五年（公元1835年），古为黔南通往广西商旅交通要道，横跨响水河。桥下潭水幽蓝两岸古木萌绿，衬出桥的雅静恬美。桥长40米，宽2.2米高5.5米，桥体取拱形，结构玲珑，工艺精妙。 为《修碑》 ，铭筑桥功德；一为《万古兴桥碑》 ，刻有“群山岩浪千千岁，响水河桥万万年”联句。桥腹七孔，俗称“小七孔古桥”。小七孔风景区因此桥而得名。</p>
                <img src="img/mpjdjs/2.jpg" alt=""/>
            </div>
            <div class="trip-item">
                <div class="trip-title sub-title">
                    拉雅瀑布
                    <div class="dot"></div>
                </div>
                <p>拉雅瀑布：一级景点，源自响水河上游山体洞泉，截流沿崖体陡岸悬空而下，落差30米，宽20余米，“拉雅”布依语译“美丽的女神”。</p>
                <img src="img/mpjdjs/3.jpg" alt=""/>
            </div> -->
            ${pd.scenicContent}
        </div>
    </div>
</body>
</html>
