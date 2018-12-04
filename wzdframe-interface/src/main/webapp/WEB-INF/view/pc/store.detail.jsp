<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/store-detail.css" type="text/css">
       <meta name="keywords" content="${dataModel.bs_name}">
    <meta name="description" content="${dataModel.bs_name}">
    <title>${dataModel.bs_name}</title>
    
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="store-body-container">
    <div class="store-body-img">
        <img src="${SETTINGPD.IMAGEPATH}${dataModel.bs_banner}" alt="">
        <div class="store-img-hover">
            <p class="hover-one">
                ${dataModel.bs_name}
            </p>
        </div>
    </div>
    <div class="store-header-text">
        <p class="text-one">
          ${dataModel.bs_introduction}
        </p>
        <p class="text-two">
            <span class="address-data">地址：</span>
            <span class="address-vale">${dataModel.bs_address}</span>
        </p>
    </div>
    <div class="store-detail">
        <div class=" store-body-content">
            <div class="row store-body-header">
                店铺热卖
            </div>
             <c:forEach begin="0" end="${currentSize}" var="ll">
	            <div class="row hot-body">
	             <c:forEach items="${goodsList}" begin="${ll*3}" end="${ll*3+2}" var="item" varStatus="status">
		                <div class="col-md-4 hot-col" onclick="goProductDetail('${item.goods_id}')">
		                    <img src="${SETTINGPD.IMAGEPATH}${item.list_img}" onError="javascript:this.src='/img/no-img/no-img.jpg';" class="hot-image" alt="">
		                    <div class="hot-recommend-content">
		                        <p class="hot-one">
		                            <span class="hot-name">${item.goods_name}</span>
		                            <c:if test="${item.is_popular eq 1}">
		                                <span class="hot-recommend">人气推荐</span>
		                            </c:if>
		                        </p>
		                        <p class="hot-two">
		                            <span class="buy-money">
		                                <span class="list-info-amount">￥${item.shop_price}</span>
		                                <span class="amount-text"> 起／人</span>
		                            </span>
		                            <span class="buy-number">
		                                ${item.virtual_sales}人购买
		                            </span>
		                        </p>
		                    </div>
		                </div>
	                </c:forEach>
	            </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
   function goProductDetail(goods_id){
	   var goodsInfo = {
			   goodsId:goods_id
	   }
	   window.location.href='/product/detail?paramStr='+Base64.encode(JSON.stringify(goodsInfo));
   }
</script>
</html>