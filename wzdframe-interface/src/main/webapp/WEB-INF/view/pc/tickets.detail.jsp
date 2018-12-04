<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-detail.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/calendar.css" type="text/css">
       <meta name="keywords" content="${dataModel.scenicName}">
    <meta name="description" content="${dataModel.scenicName}">
    <title>${dataModel.scenicName}</title>
    <style type="text/css">
       .product-introduction-container img {
         width: 100%;
       }
    
    </style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
            <div style="cursor: pointer;" class="col-md-2 service-0">
                酒店预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1 active"  onclick="window.location.href='/ticket/list'">
                门票预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-2" onclick="window.location.href='/travel/route'">
                旅游路线
            </div>
        </div>
    </div>
</div>
<div class="row service-content">
    <div>
        <div class="ticket-header">
            <span class="service-color-text">都匀服务</span>
            <span class="service-text">/</span>
            <span class="service-text">门票详情</span>
        </div>
        <div class="row ticket-image-container">
            <div id="ticket-carousel" class="col-md-5 carousel slide ticket-carousel-container"
                 data-ride="carousel">
                <ol class="carousel-indicators ticket-indicators">
                    <li data-target="#ticket-carousel" data-slide-to="0" class="active"></li>
               <!--      <li data-target="#ticket-carousel" data-slide-to="1"></li>
                    <li data-target="#ticket-carousel" data-slide-to="2"></li>
                    <li data-target="#ticket-carousel" data-slide-to="3"></li>
                    <li data-target="#ticket-carousel" data-slide-to="4"></li> -->
                </ol>
                <div class="carousel-inner ticket-carousel" role="listbox">
                    <div class="carousel-item active">
                        <img src="${dataModel.scenicLogo}"  onError="javascript:this.src='/img/no-img/no-img.jpg';" class="ticket-carousel-img" alt="First slide">
                    </div>
                 <!--    <div class="carousel-item ">
                        <img src="/img/duyun/pc/router.png" class="ticket-carousel-img" alt="First slide">
                    </div>
                    <div class="carousel-item ">
                        <img src="/img/duyun/pc/router.png" class="ticket-carousel-img" alt="First slide">
                    </div>
                    <div class="carousel-item ">
                        <img src="/img/duyun/pc/router.png" class="ticket-carousel-img" alt="First slide">
                    </div>
                    <div class="carousel-item ">
                        <img src="/img/duyun/pc/router.png" class="ticket-carousel-img" alt="First slide">
                    </div> -->
                </div>
                <a class="carousel-control-prev" href="#ticket-carousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#ticket-carousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="col-md-7 ticket-image-right">
                <div class="img-header">
                    <span>${dataModel.scenicName}</span>
                </div>
                <c:forEach items="${fn:split(dataModel.scenicLable,',')}" var="lable">
                  <span class="img-level">${lable}</span>
                 </c:forEach>
                <div class="img-amount">
                    <span class="price">¥ ${dataModel.scenicTicketPrice}起／人</span>
                    <span class="price-text">价格说明</span>
                    <span class="price-buy">${empty dataModel.scenicBuyCount ?'0':dataModel.scenicBuyCount}人购买</span>
                </div>
                <div class="row img-address">
                    <div class="col-md-2 address">景点地址</div>
                    <div class="col-md-10 address-text">贵州省</div>
                </div>
                <div class="row img-open-time">
                    <div class="col-md-2 open-time">开发时间</div>
                    <div class="col-md-10 open-text">
                        淡季08:00-17:00(12月至次年3月);旺季08:00-17:00(3月至次年11月）
                    </div>
                </div>
               <!--  <div class="row service-promise">
                    <div class="col-md-2 promise">服务承诺</div>
                    <div class="col-md-10 promise-text">
                            <span class="promise-item">
                               <img class="promise-img" data-src="holder.js/900x500/auto/#777:#555/text:First slide"
                                    alt="yy"/>
                                24小时退款保证
                            </span>
                        <span class="promise-item">
                               <img class="promise-img" data-src="holder.js/900x500/auto/#777:#555/text:First slide"
                                    alt="yy"/>
                                安全交易
                            </span>
                        <span class="promise-item">
                                <img class="promise-img" data-src="holder.js/900x500/auto/#777:#555/text:First slide"
                                     alt="yy"/>
                                如实描述
                            </span>
                        <span class="promise-item">
                                <img class="promise-img" data-src="holder.js/900x500/auto/#777:#555/text:First slide"
                                     alt="yy"/>
                                当日可定
                            </span>
                        <span class="promise-item">
                                <img class="promise-img" data-src="holder.js/900x500/auto/#777:#555/text:First slide"
                                     alt="yy"/>
                                未验证消费随时退
                            </span>


                    </div>
                </div> -->
            </div>
        </div>
    </div>
</div>
<div class="row service-detail-container">
    <div class="service-detail-middle">
        <div class="row product-header">
            <div class="first-col">
                <span>产品名称</span>
            </div>
            <div class="second-col">
                提前支付时间
            </div>
            <div class="third-col">
                价格
            </div>
            <div class="tail-col">
                支付方式
            </div>
        </div>
       <c:forEach items="${dataModel.ticketCates}" var="item"> 
	        <div class="recommend">
	           ${item.cateName}
	        </div>
	        <c:forEach items="${item.tickets}" var="ticket">
		        <div class="row recommend-detail">
		            <div class="first-col detail-one">
		                ${ticket.ticketName}
		            </div>
		            <div class="second-col detail-two">
		                <c:if test="${ticket.advanceBookDays eq 0}">
		                                                       当天 ${ticket.lastBookTime}前
		                </c:if>
		                <c:if test="${ticket.advanceBookDays ne 0}">
		                                                      游玩前${ticket.advanceBookDays}天  ${ticket.lastBookTime}前
		                </c:if>
		                
		                <span class="old-price">
		                    <strike>¥${ticket.marketPrice}</strike>
		                </span>
		            </div>
		            <div class="third-col detail-three">
		                <span class="new-price">¥ ${ticket.settlementPrice}</span>
		            </div>
		            <div class="tail-col detail-four">
		                   <span>
		                   <c:if test="${empty ticket.paymentMethod || ticket.paymentMethod eq 1}">
		                   在线支付
		                   </c:if>
		                   <c:if test="${ticket.paymentMethod eq 2}">
		                   代售点取票
		                   </c:if>
		                   </span>
		                   <c:if test="${empty ticket.paymentMethod || ticket.paymentMethod eq 1}">
		                       <button type="button" onclick="bookSure('${ticket.thirdNo}');"  class="btn btn-secondary online-booking">预订</button>
		                  </c:if>
		            </div>
		        </div>
	        </c:forEach>
        </c:forEach>
    </div>
</div>
<div class="row service-footer-container">
    <div>
        <div class="row footer-header">
            <c:if test="${not empty dataModel.scenicContent}">
              <div class="col-md-2 introduce-detail product-introduction active"><a href="#productReduce" style="color:black;">产品介绍</a></div>
            </c:if>
           <c:if test="${not empty dataModel.scenicBookKnow}">
              <div class="col-md-2 introduce-detail booking-information"><a href="#bookKnow" style="color:black;">预订须知</a></div>
          </c:if>
          <c:if test="${not empty dataModel.scenicTraffic}">
           <div class="col-md-2 introduce-detail traffic-guidance"> <a href="#traffic" style="color:black;">交通指南</a></div>
           </c:if>
            <div class="col-md-6"></div>
        </div>
        <div class="product-introduction-container">
            <div class="introduction-header" id="productReduce">
                <span class="introduction-header-line"></span>
                <span class="introduction-header-text">产品介绍</span>
            </div>
             ${dataModel.scenicContent}
             <c:if test="${not empty dataModel.scenicBookKnow}">
	            <div class="booking-information-container">
	                <div class="book-header" id="bookKnow">
	                    <span class="introduction-header-line"></span>
	                    <span class="introduction-header-text">预订须知</span>
	                </div>
	               ${dataModel.scenicBookKnow}
	            </div>
            </c:if>
            <div id="traffic" class="traffic-guidance-container">
                ${dataModel.scenicTraffic}
            </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/tickets.detail.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript">
	$(function(){
		$(".introduce-detail").click(function(){
			  $(this).siblings().removeClass('active');
			  $(this).addClass('active');
		  });
	});
	var bookSure = function(thirdNo){
		var dateInfo = {
				thirdNo:thirdNo
		}
		window.location.href="/ticket/order/confirm?paramStr="+Base64.encode(JSON.stringify(dateInfo));
	}
	
	
</script>
</body>
</html>