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
    <title>${SEO.seo_web_title}</title>
    <style type="text/css">
       .spot-item,.category-item{
         cursor: pointer;
       }
    </style>
</head>
<body>
<%@ include file="common/ercode.jsp"%>
<%@ include file="common/navi.jsp"%>
<div id="carousel-example-generic" class="carousel slide home-" data-ride="carousel">
    <ol class="carousel-indicators">
	    <c:forEach items="${ads}" var="item" varStatus="status">
	        <li data-target="#carousel-example-generic" data-slide-to="${status.index}" <c:if test="${status.index == 0}"> class="active"</c:if>></li>
	     </c:forEach>   
       <!--  <li data-target="#carousel-example-generic" data-slide-to="1"></li> -->
    </ol>
    <div class="carousel-inner" role="listbox">
      <c:forEach items="${ads}" var="item" varStatus="status">
	        <div class="carousel-item <c:if test="${status.index == 0}">active</c:if>">
	            <ul class="carousel-item-info">
	                <li>
	                    <h4>${item.ad_title}</h4>
	                </li>
	                <li>
	                    <h5>${item.ad_desc}</h5>
	                </li>
	                <li>
	                    <button type="button" class="btn btn-secondary" onclick="goTolink('${item.ad_type}','${item.ad_relation_type}','${item.ad_relation_id}','${item.ad_url}');">查看详情</button>
	                </li>
	            </ul>
	            <img src="${SETTINGPD.IMAGEPATH}${item.ad_display}" class="carousel-img" alt="Third slide">
	        </div>
       </c:forEach>   
     <!--    <div class="carousel-item">
            <ul class="carousel-item-info">
                <li>
                    <h4>史上最全攻略 带你畅玩都匀精美路线</h4>
                </li>
                <li>
                    <h5>攻略最当季 前往都匀</h5>
                </li>
                <li>
                    <button type="button" class="btn btn-secondary">查看详情</button>
                </li>
            </ul>
            <img src="/img/duyun/pc/home.png" class="carousel-img" alt="Third slide">
        </div> -->
    </div>
    <div class="service-book row">
        <div class="service-book-left col-md-3">
            <p class="left-text">都匀</p>
            <p class="left-book">服务预订</p>
        </div>
        <div class="service-book-right col-md-9">
            <div class="row book-category">
                <div class="category-item" onclick="window.open('http://flights.ctrip.com/booking/BJS-KWE-day-1.html','_blank');">
                    <img src="/img/duyun/pc/home/plane.png"  alt="飞机" class="category-img">
                    <span class="category-text">机票预订</span>
                </div>
                <div class="category-item" onclick="window.open('/hotel/list','_blank');">
                    <img src="/img/duyun/pc/home/hotel.png"  alt="酒店" class="category-img">
                    <span class="category-text"> 酒店预订</span>
                </div>
                <div class=" category-item" onclick="window.open('/ticket/list','_blank');" >
                    <img src="/img/duyun/pc/home/ticket.png" alt="门票" class="category-img">
                    <span class="category-text">门票预订</span>
                </div>
                <div class=" category-item" onclick="window.open('/travel/route','_blank')">
                    <img src="/img/duyun/pc/home/travel.png" alt="跟团" class="category-img">
                    <span class="category-text">旅游路线</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="home-travel-route">
    <div class="route-header">
        <span class="router-left-line"></span>
        <span class="router-text">旅游路线</span>
        <span class="router-right-line"></span>
    </div>
    <div id="travel-carousel" class="carousel slide travel-carousel-container" data-ride="carousel">
        <ol class="carousel-indicators travel-indicators">
            <c:set value="${fn:length(dataModel)}" var="len"></c:set>
            <c:forEach begin="1" end="${len}"  var="item" >
                <li data-target="#travel-carousel" data-slide-to="${item}"  <c:if test="${item eq 1}">class="active"</c:if> ></li>
            </c:forEach> 
           <!--  <li data-target="#carousel-inner-2" data-slide-to="2"></li>
            <li data-target="#carousel-inner-3" data-slide-to="3"></li> -->
        </ol>
	        <div class="carousel-inner travel-carousel" role="listbox">
	          <c:forEach items="${dataModel}" var="item" varStatus="status">
	            <div class="carousel-item  carousel-item-${status.index+1} <c:if test='${status.index eq 0}'>active</c:if>">
	                <div class="row travel-carousel-row">
	                    <c:forEach items="${item.value}" var="vl">
		                    <div class=" travel-carousel-item " onclick="goTravelDetail('${vl.grouptour_id}');">
		                        <img src="${SETTINGPD.IMAGEPATH}${vl.grouptour_img}" onError="javascript:this.src='/img/no-img/no-img.jpg';" class="travel-carousel-img" alt="First slide">
		                        <div class="travel-info">
		                            <div style="height:45px; width:100%;    overflow: hidden;">
		                               ${vl.grouptour_name}
		                            </div>
		                            <div style="margin-top:20px;height:66px; width:100%;    overflow: hidden;" class="travel-text-detail">
		                               ${vl.grouptour_sketch }
		                            </div>
		                            <p style="margin-top:20px;">
		                                <span class="travel-info-amount">￥${vl.grouptour_price} 起/人</span>
		                                <span class="travel-info-count">${vl.grouptour_sales}购买</span>
		                                <button type="button" class="btn btn-secondary watch-detail">查看详情</button>
		                            </p>
		                        </div>
		                    </div>
	                    </c:forEach>
	                </div>
	            </div>
        </c:forEach>
	        </div>
    </div>
</div>
<div class="home-travel-spot" >
    <div class="spot-header">
        <span class="spot-line"></span>
        <span class="spot-header-text">都匀景点</span>
        <span class="spot-line"></span>
    </div>
    <div class="spot-content" >
        <div class="row" id="scenic_list">
            <!-- <div class="col-md-4 spot-item ">
                <img src="/img/duyun/pc/router.png" class="spot-img" alt="First slide">
                <div class="spot-info">
                    <p class="spot-text">
                        建江风光
                    </p>
                    <p class="spot-text-detail">
                        豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店
                    </p>
                </div>

            </div>
            <div class="col-md-4 spot-item">
                <img src="/img/duyun/pc/router.png" class="spot-img" alt="First slide">
                <div class="spot-info">
                    <p class="spot-text">
                        建江风光
                    </p>
                    <p class="spot-text-detail">
                        豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店 豪华酒店
                    </p>
                </div>
            </div> -->
        </div>
        <div class="spot-button-group">
            <button type="button" onclick="window.open('/scenic/list');" class="btn btn-secondary watch-spot-detail ">查看更多</button>

        </div>
    </div>
</div>
<div class="home-travel-strategy" >
    <div class="strategy-header">
        <span class="strategy-line"></span>
        <span class="strategy-text">都匀攻略</span>
        <span class="strategy-line"></span>
    </div>
    <div class="strategy-content" id="raiders_list">
        <!-- <div class="row strategy-row">
            <div class="col-md-6 strategy-item">
                <img src="/img/duyun/pc/router.png" alt="" class=" strategy-img">
                <div class="strategy-detail">
                    <p class="strategy-detail-header">5日都匀游</p>
                    <p class="strategy-detail-content">5日都匀游畅游5日都匀游畅游5日都匀游畅游5日都匀游畅游</p>

                </div>
            </div>
            <div class="col-md-6 strategy-item">
                <img src="/img/duyun/pc/router.png" alt="" class=" strategy-img">
                <div class="strategy-detail">
                    <p class="strategy-detail-header">必有景点</p>
                    <ul class="strategy-detail-content">
                        <li>
                            1.都训经棚山
                        </li>
                        <li>
                            2.石板街
                        </li>
                        <li>
                            3.东山公园
                        </li>
                    </ul>

                </div>
            </div>
        </div> -->
    </div>
</div>
<div class="row footer-container">
    <div class="col-md-4 footer-left" id="realTimeNews">
        <h3 class="left-header">
            实时资迅
        </h3>
        <!-- <div class=" real-information">
            <p class="real-text">6月18日</p>
            <p class="real-text">贵州全面二孩静照亮相</p>
            <p class="real-detail">查看详情</p>
        </div>
        <div class=" real-information">
            <p class="real-text">6月18日</p>
            <p class="real-text">贵州全面二孩静照亮相</p>
            <p class="real-detail">查看详情</p>
        </div>
        <div class=" real-information">
            <p class="real-text">6月18日</p>
            <p class="real-text">贵州全面二孩静照亮相</p>
            <p class="real-detail">查看详情</p>
        </div> -->

    </div>
    <div class="col-md-8 footer-right">
        <h3 class="right-header">旅游资讯</h3>
        <div class="row tourist-information" id="travelNews">
         <!--    <div class="col-md-3 tourist-information-img">
                <img src="/img/duyun/pc/router.png" alt="" class=" tourist-img">
                <p class="travel-text-detail">
                    5日都匀游畅游5日都匀游畅游5日都匀游畅游5日都匀游畅游
                </p>
            </div>
            <div class="col-md-3 tourist-information-img">
                <img src="/img/duyun/pc/router.png" alt="" class=" tourist-img">
                <p class="travel-text-detail">
                    5日都匀游畅游5日都匀游畅游5日都匀游畅游5日都匀游畅游
                </p>
            </div>
            <div class="col-md-3 tourist-information-img">
                <img src="/img/duyun/pc/router.png" alt="" class=" tourist-img">
                <p class="travel-text-detail">
                    5日都匀游畅游5日都匀游畅游5日都匀游畅游5日都匀游畅游
                </p>
            </div> -->
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/duyun/pc/redirectJ.js"></script>
</body>
<script type="text/javascript">
var imgPrefix = '${SETTINGPD.IMAGEPATH}';
$(function(){
	$(".travel-indicators").children().hover(function() {
		var order = $(this).attr("data-slide-to");
		$(this).siblings().removeClass("active");
		$(this).addClass("active");
		$(".carousel-item-"+order).siblings().removeClass("active");
		$(".carousel-item-"+order).addClass("active");
	}, function() {
	});
	requestScenic();
	requestRaiders();
	requestContent();
});
/**
 * ajax 请求数据
 */
 //请求景点数据
 function requestScenic(){
	Ajax.request("/logic/scenicList",{"data":{"limit":3},"success":function(data){
		if(data.code == 200){
			var data = data.data;
			var scenicAry = [];
			for(var i = 0 ; i < data.length ; i++){
				scenicAry.push('<div class="col-md-4 spot-item " onclick="goScenicDetail('+data[i].id+');"> <img src="'+imgPrefix+data[i].scenic_logo+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" class="spot-img" alt="First slide">');
				scenicAry.push('<div class="spot-info" style="height:118px;overflow: hidden;"> <p class="spot-text">'+data[i].scenic_name+' </p> <p class="spot-text-detail">');
				scenicAry.push(data[i].scenic_desc+'</p></div></div>');
			}
			$("#scenic_list").append(scenicAry.join(''));
		}else{
			$("#scenic_list").parent().parent().hide();
		}
	}});
}
 /**
      请求 攻略数据
 */
 function requestRaiders(){
	 Ajax.request("/logic/raidersList",{"data":{"limit":4},"success":function(data){
			if(data.code == 200){
				var data = data.data;
				var raidersAry1 = ['<div class="row strategy-row">'];
				var raidersAry2 = ['<div class="row strategy-row">'];
				for(var i = 0 ; i < data.length ; i++){
					var indexFlag = parseInt(i / 2);
					if(indexFlag == 0){
						raidersAry1.push('<div class="col-md-6 strategy-item" onclick="window.open('+"'"+'/guide/detail?line_id='+data[i].id+''+"'"+')"><img src="'+imgPrefix+data[i].line_logo+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="" class=" strategy-img">');
						raidersAry1.push('<div class="strategy-detail"><div style="height:25px;overflow: hidden;" class="strategy-detail-header">'+data[i].line_name+'</div><div style="height:45px;overflow: hidden;" class="strategy-detail-content">'+data[i].line_lead+'</div>');
						raidersAry1.push('</div></div>');
					}else if(indexFlag == 1){
						raidersAry2.push('<div class="col-md-6 strategy-item" onclick="window.open('+"'"+'/guide/detail?line_id='+data[i].id+''+"'"+')"><img src="'+imgPrefix+data[i].line_logo+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="" class=" strategy-img">');
						raidersAry2.push('<div class="strategy-detail"><div style="height:25px;overflow: hidden;" class="strategy-detail-header">'+data[i].line_name+'</div><div style="height:45px;overflow: hidden;" class="strategy-detail-content">'+data[i].line_lead+'</div>');
						raidersAry2.push('</div></div>');
					}
				}
				raidersAry1.push('</div>');
				raidersAry2.push('</div>');
				$("#raiders_list").append(raidersAry1.join("")+raidersAry2.join(''));
			}else{
				$("#raiders_list").hide();
			}
	 }});
 }
 /*
       请求资讯
 */
 function requestContent(){
	 Ajax.request("/logic/contentList",{"data":{"limit":3},"success":function(data){
			if(data.code == 200){
				var realTimeNews = data.data.realTimeNews;
				var travelNews = data.data.travelNews;
				var newsAry = [];
				for(var i = 0 ; i < realTimeNews.length ; i++){
					newsAry.push('<div style="cursor:pointer;" onclick="window.location.href='+"'"+'/content/detail?CONTENT_ID='+realTimeNews[i].CONTENT_ID+''+"'"+'" class=" real-information"> <p class="real-text">'+realTimeNews[i].PC_PUTTIME+'</p><p class="real-text">'+realTimeNews[i].TITLE+'</p>');
					newsAry.push('<p class="real-detail" onclick="/content/detail?CONTENT_ID='+realTimeNews[i].CONTENT_ID+'">查看详情</p><div>');
				}
				$("#realTimeNews").append(newsAry.join(''));
				newsAry.length = 0;
				for(var i = 0 ; i < travelNews.length ; i++){
					newsAry.push('<div style="cursor:pointer;" onclick="window.location.href='+"'"+'/content/detail?CONTENT_ID='+realTimeNews[i].CONTENT_ID+''+"'"+'" class="col-md-3 tourist-information-img"><img src="'+imgPrefix+travelNews[i].T_IMG+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="" class=" tourist-img">');
					newsAry.push('<div style="height:45px;overflow: hidden;" class="travel-text-detail">'+travelNews[i].TITLE+'</div></div>');
				}
				$("#travelNews").append(newsAry.join(''));
			}
		}});
 }
	// adType 广告类型  adRtype 内部关联类型  adRId 内部关联ID adUrl 外部链接
	function goTolink(adType,adRtype,adRId,adUrl){
		if(adType == 0){
			//1特产 2门票 3线路 4景点
			if(adRtype == 1){
				goGoodsDetail(adRId);
				//window.location.href='/wx/product/detail?p_id='+adRId;
			}else if(adRtype == 2){
				goTicketDetail(adRId);
				//window.location.href='/wx/ticket/index?redirectType=detail&t_id='+adRId;
			}else if(adRtype == 3){
				goTravelDetail(adRId);
			//	window.location.href='/wx/grouptour/index?resultType=detail&grouptour_id='+adRId;
			}else if(adRtype == 4){
				goScenicDetail(adRId);
				//window.location.href='/wx/scenic/detail?id='+adRId;
			}
		}else if(adType == 1){
			//外部广告链接跳转
			window.location.href=adUrl;
		}
	}
 
</script>
</html>