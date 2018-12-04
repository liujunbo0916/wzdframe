<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/douyun-store.css" type="text/css">
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
            <div style="cursor: pointer;" class="col-md-2 service-0 " onclick="window.location.href='/product/list';">
               都匀特产
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1 active" onclick="onBook(1);">
                都匀店铺
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-2" onclick="onBook(2);">
                都匀景点
            </div>
        </div>
    </div>
</div>
<div class="travel-strategy-content">
    <div class="sure-header">
        <span class="my-order">都匀特色</span>
        <span class="order-line">/</span>
        <span class="order-text">店铺列表</span>
    </div>
    <div class=" travel-strategy">
        <div class="left-header">
            推荐店铺
        </div>
        <c:forEach items="${page.resultPd}" var="item">
	        <div class="row strategy-item" style="cursor: pointer;" onclick="goStoreDetail('${item.bs_id}');">
	            <div class="col-md-3 item-left">
	                <img src="${SETTINGPD.IMAGEPATH}${item.bs_logo}" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
	            </div>
	            <div class="col-md-9 item-right">
	                <div class="row right-content">
	                    <div class="col-md-8">
	                        <p class="right-one">
	                           ${item.bs_name}
	                        </p>
	                        
			                        <p class="right-two">
			                        <c:forEach items="${fn:split(item.bs_tabs,',')}" var="lable">
			                            ${lable}&nbsp;&nbsp;
			                            </c:forEach>
			                        </p>
	                        
	                        <p class="right-three">
	                            ${item.bs_introduction}
	                        </p>
	                        <p class="right-four">
	                            <span class="eye-span">
	                                <img src="/img/duyun/pc/location.png" class="eye-img" alt="">
	                                <span>&nbsp;&nbsp;地址：</span>
	                                 <span>${item.bs_address}</span>
	                            </span>
	                        </p>
	                    </div>
	                    <div class="col-md-3 col-two">
	                        <p class="open-date">经营时间</p>
	                        <p class="open-date">
	                            ${item.bs_shop_hours}
	                        </p>
	                    </div>
	                    <div class="col-md-1">
	                        <img src="/img/duyun/pc/stroe-right-arrow.png" class="duyun-arrow" alt=""/>
	                    </div>
	                </div>
	            </div>
	        </div>
        </c:forEach>
    </div>
</div>
<div class="row route-footer-content">
    ${page.pageStr}
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript">
  function goStoreDetail(bs_id){
	  var storeInfo = {
			  bs_id:bs_id
	  }
	  window.location.href="/store/detail?paramStr="+Base64.encode(JSON.stringify(storeInfo));
  }
</script>
</body>
</html>