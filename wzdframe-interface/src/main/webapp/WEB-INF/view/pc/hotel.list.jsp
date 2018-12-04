<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="keywords" content="${SEO.seo_value}">
    <meta name="description" content="${SEO.seo_description}">
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-detail.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-list.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/travel-route.css" type="text/css">
    <title>${SEO.seo_web_title}</title>
</head>
<body>
<%@ include file="common/ercode.jsp"%>
<%@ include file="common/navi.jsp"%>

<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
          <div style="cursor: pointer; " class="col-md-2 service-0 active">
                酒店预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1"  onclick="window.location.href='/ticket/list'">
                门票预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-2" onclick="window.location.href='/travel/route'">
                旅游路线
            </div>
        </div>
    </div>
</div>
<div class=" travel-content">
    <div >
        <div class="ticket-header">
            <span class="service-text">都匀服务</span>
            <span class="service-text">/</span>
            <span class="service-color-text">酒店预订</span>
        </div>
        <div class="row comprehensive-content ">
        <div class="col-md-9 content-left">
            <div class="row sale-row">
                <div class="comprehensive-sequence <c:if test='${empty pd.orderType || pd.orderType eq "multiple"}'>active</c:if>" data-code="multiple">
                    综合排序
                </div>
                <div class="route-sale <c:if test='${pd.orderType eq "popularity"}'>comprehensive-sequence active</c:if>" data-code="popularity">
                    人气
                </div>
                <div class="route-price <c:if test='${pd.orderType eq "price"}'>comprehensive-sequence active</c:if>" data-code="price">
                    价格
                </div>
            </div>
            <c:forEach begin="0" end="${page.currentSize}" var="ll">
            <div class="row router-list">
	            <c:forEach items="${page.resultPd}" begin="${ll*3}" end="${ll*3+2}" var="item" varStatus="status">
		                <div  onclick="window.open('${item.hotel_url}')" class="col-md-4 router-list-item <c:if test='${status.index eq (ll*3+2)}'>last</c:if>">
		                    <div class="image-hover">
		                        <img style="width:270px;" src="${SETTINGPD.IMAGEPATH}${item.hotel_img}" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
		                        <div class="list-hover" style="height:62px;overflow: hidden;">
		                            <p class="hover-header">${item.hotel_name}</p>
		                            <p class="hover-text">${item.hotel_sketch}</p>
		                        </div>
		                    </div>
		                    <div class="list-content">
		                        <div style="overflow: hidden;height:50px;">
		                            <span class="list-info-text">${item.hotel_name}</span>
		                            <c:forEach items="${fn:split(item.hotel_tags,',')}" var="lable">
		                                <span class="list-info-date">${lable}</span>
		                            </c:forEach>
		                        </div>
		                        <div style="overflow: hidden;height:54px;margin-top:12px;" class="list-text-detail">
		                           ${item.hotel_sketch}
		                        </div>
		                        <p>
		                            <span class="list-info-amount">￥${item.hotel_price}</span>
		                            <span class="amount-text"> 起／人</span>
		                        </p>
		                    </div>
		                </div>
	                </c:forEach>
            </div>
          </c:forEach>
        </div>
        <div class="col-md-3 content-right" id="hotLine">
            <div class="row">
                <div class="hot-recommend">
                    热卖推荐
                </div>
            </div>
     <!--        <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="/img/duyun/pc/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="content-one">
                        <span class="travel-info-text">安顺</span>
                        <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="content-two">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div>
 -->
        </div>
        </div>
    </div>
</div>
<div class="row route-footer-content">
    <div class="col-md-9 ">
           ${page.pageStr}
    </div>
    <div class="col-md-3"></div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>

<script type="text/javascript">
var imgPrefix = '${SETTINGPD.IMAGEPATH}';
   $(function(){
	   $(".router-list-item").hover(function(){
		   $(this).find(".list-hover").show('slow');
	   },function(){
		   $(this).find(".list-hover").hide('slow');
	   });
	   $(".sale-row").children().click(function(){
		   var data_code = $(this).attr("data-code");
		   var url = "/hotel/list?currentPage=1&orderType="+data_code;
		   window.location.href=url;
	   });
	   requestContent();
   });
   //重写nextPage方法
   function nextPage(num){
	   var url = "/hotel/list?currentPage="+num;
	   window.location.href=url;
   }
   function requestContent(){
		 Ajax.request("/logic/hotLine",{"data":{"limit":2},"success":function(data){
			if(data.code == 200){
				var htmlAry = [];
				var data = data.data;
				for(var i = 0 ; i < data.length ; i++){
					htmlAry.push(' <div onclick="goRouteDetail('+data[i].grouptour_id+')" class="row hot-recommend-list"><div class="hot-recommend-image">');
					htmlAry.push(' <img src="'+imgPrefix+data[i].grouptour_img+'" alt="" onerror="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"></div><div class="hot-recommend-content">');
					htmlAry.push(' <div style="height:50px;overflow: hidden;" class="content-one"><span class="travel-info-text">'+data[i].grouptour_name+'</span></div>');
					htmlAry.push('<p class="content-two"><span class="list-info-amount">￥'+data[i].grouptour_price+'</span><span class="amount-text"> 起／人</span></p>');
					htmlAry.push('</div></div>');
				}
				$("#hotLine").append(htmlAry.join(''));
			}
		}});
	 }
   function goRouteDetail(id){
	   var routeInfo = {
			   id:id
	   }
	   window.location.href='/travel/route/detail?paramStr='+Base64.encode(JSON.stringify(routeInfo));
   }
</script>
</body>
</html>