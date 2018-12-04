<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>商城</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/store-nav.css" rel="stylesheet"/>
		<link href="/css/store.css" rel="stylesheet"/>
		<link href="/css/my-order.css" rel="stylesheet"/>
		<link href="/css/shib.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div>
			<!--nav-->
			<nav>
				<ul>
					 <li class="clickItem_1">
						<a class="select">特产</a>
					</li>
					<li class="clickItem_2">
						<a>其他</a>
					</li> 
				</ul>
			</nav>
			<div class="box"></div>
			<!--图文列表-->
			<div class="container1 option_1" >
				<!--列表-->
				<c:forEach items="${goodsList}" var="item">
					<div class="img-text-list border-bottom" onclick="getGoodsDetail('+${item.goods_id}+')">
						<div class="img-box">
							<img  src="${SETTINGPD.IMAGEPATH}${item.list_img}"/>
						</div>
						<div class="text-list margin-t12">
							<p class="f333">${item.goods_name }</p>
							<p class="font-s12 f999"></p>
							<p class="fad8a54 margin-t12">￥${item.shop_price}</p>
						</div>
					</div>
				</c:forEach>
			</div>
			 <div class="container1 option_2">
				<!--列表-->
				<c:forEach items="${courseList}" var="item">
					<div class="img-text-list border-bottom">
						<div class="img-box">
							<img  src="${SETTINGPD.IMAGEPATH}${item.course_logo}"/>
						</div>
						<div class="text-list margin-t12">
							<p class="f333">${item.course_name }</p>
							<p class="font-s12 f999">${item.course_buyer_total}人已报名</p>
							<p class="fad8a54 margin-t12">
							   <span class="font-s16 fad8a54">￥<span id="shopPrice"><c:if test="${item.course_open_panic eq 1}">${item.course_panic_price}</c:if>
								     <c:if test="${empty item.course_open_panic || item.course_open_panic eq 0}">${item.course_price}</c:if>
								   </span></span>
								   <c:if test="${item.course_open_panic eq 1}">
								      <span class="f999 text-decoration">￥<span id="marketPrice" class="price-thorght">${item.course_price}</span></span>
								   </c:if>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
				<div class="imgs">
					<img src="/img/meiyoushuju@2x.png"/>
					<p>暂时没有数据</p>
				</div>
		</div>
	</body>
	<%@ include file="common/commJs.jsp"%>
	<script type="text/javascript">
	   var courseLength = '${fn:length(courseList)}';
	   var goodsLength = '${fn:length(goodsList)}';
	  
	  	function getGoodsDetail(id){
	  		window.location.href='/wx/product/detail?p_id='+id;
	  	}
	  
	    $(function(){
	    	$(".option_2").hide();
	    	$(".imgs").hide();
	    	 if(goodsLength == "0"){
	  	   		$(".imgs").show();
	  	   	}
	    	$(".clickItem_1").click(function(){
	    		$(".imgs").hide();
	    		$(".option_1").show();
	    		$(".option_2").hide();
	    		$(".clickItem_2").children().eq(0).removeClass("select");
	    		$(".clickItem_1").children().eq(0).addClass("select");
	    		if(goodsLength == "0"){
	    			$(".imgs").show();
	    		}
	    	});
	        $(".clickItem_2").click(function(){
	        	$(".imgs").hide();
	        	$(".option_2").show();
	    		$(".option_1").hide();
	    		$(".clickItem_1").children().eq(0).removeClass("select");
	    		$(".clickItem_2").children().eq(0).addClass("select");
	    		if(courseLength == "0"){
	    			$(".imgs").show();
	    		}
	    	});
	    });
        //监听返回按钮
        GoBackBtn.excuteHistory("/wx/duyun/user/center");
	</script>
</html>
