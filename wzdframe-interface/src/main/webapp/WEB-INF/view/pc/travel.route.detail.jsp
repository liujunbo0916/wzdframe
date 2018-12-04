<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/path-detail.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/calendar.css" type="text/css">
      <meta name="keywords" content="${dataModel.grouptour_name}">
    <meta name="description" content="${dataModel.grouptour_name}">
    <title>${dataModel.grouptour_name}</title>
    <style type="text/css">
     .disabled-click{
         color:#808080;
       }
       .path-detail-content img{
          width: 100%;
       }
    </style>
    
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="body-container">
    <div class="main">
        <div class="title">
            <span>都匀服务 </span>
            <span style="cursor: pointer;" onclick="window.location.href='/travel/route'">&nbsp;/&nbsp;旅游路线</span>
            <span>&nbsp;/&nbsp;路线详情</span>
        </div>
        <div class="content">
            <div class="carouselSide">
                <div id="ticket-carousel" class="col-md-5 carousel slide ticket-carousel-container"
                     data-ride="carousel">
                    <ol class="carousel-indicators ticket-indicators">
                        <li data-target="#ticket-carousel" data-slide-to="0" class="active"></li>
                      <!--   <li data-target="#ticket-carousel" data-slide-to="1"></li> -->
                    </ol>
                    <div class="carousel-inner ticket-carousel" role="listbox">
                        <div class="carousel-item active">
                            <img src="/img/duyun/pc/ad/ad_1.jpg" class="ticket-carousel-img" alt="First slide">
                        </div>
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
                <div class="calendar" id="calendar">
                    <div class="calendar-title-box">
                        <span class="prev-month"  id="prevMonth">&lt;</span>
                        <span class="calendar-title" id="calendarTitle"><span id="currentYear">${currentYear}</span>年<span id="currentMonth">${currentMonth}</span>月</span><span
                            id="nextMonth" class="next-month">&gt;</span></div>
                    <div class="calendar-body-box">
                        <table id="calendarTable" class="calendar-table">
                            <tbody id="selectDateInfo">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="pathDetail">
                <div class="header">
                   ${dataModel.grouptour_name}
                </div>
                <div class="tip">
                     ${dataModel.grouptour_sketch}
                </div>
                <div class="priceSection">
                    <div>
                        <span class="price">
                            ¥<span>${dataModel.grouptour_price}</span>起／人
                        </span>
                        <span class="price-text">价格说明</span>
                        <span class="price-buy">${dataModel.grouptour_sales}人购买</span>
                    </div>
                </div>
                <div class="attractionSection">
                    <div class="attractionRow">
                        <div class="attractionTitle">行程时间</div>
                        <div class="attractionContent">${dataModel.grouptour_day}天${dataModel.grouptour_day -1}夜</div>
                    </div>
                    <div class="attractionRow">
                        <div class="attractionTitle">行程概况</div>
                        <div class="attractionContent">
                            <span>D1&nbsp;</span> 抵达都匀 >
                            <span>D2&nbsp;</span> 抵达都匀 >
                            <span>D3&nbsp;</span> 抵达都匀
                        </div>
                    </div>
                    <div class="attractionRow">
                        <div class="attractionTitle">行程套餐</div>
                        <div class="attractionContent">
                            <c:forEach items="${fn:split(dataModel.grouptour_tab,',')}" var="item">
	                            <div class="serviceItem">
	                                <img class="promise-img" src="/img/duyun/pc/promise.png" alt=""/>
	                                ${item}
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="buySection">
                    <div class="buyRow">
                        <div class="buyTitle">选择日期</div>
                        <div class="buyContent">
                            <div class="chooseBox">日期</div>
                        </div>
                    </div>
                    <div class="buyRow">
                        <div class="buyTitle">选择数量</div>
                        <div class="buyContent">
                            <div class="rangeBtn">
                                <div class="action" onclick="minus(this)">-</div>
                                <div class="content" id="range1">1</div>
                                <div class="action" onclick="plus(this)">+</div>
                            </div>
                            <div class="buyDetail">
                                <span id="adultPrice">￥0</span>
                                /成人
                            </div>
                            <div class="gap"></div>
                            <div class="rangeBtn">
                                <div class="action" onclick="minus(this)">-</div>
                                <div class="content" id="range2">1</div>
                                <div class="action" onclick="plus(this)">+</div>
                            </div>
                            <div class="buyDetail">
                                <span id="childPrice">￥0</span>
                                /儿童
                                <span style="padding-left: 10px;text-decoration: underline;">儿童标准</span>
                            </div>
                        </div>
                    </div>
                    <div class="buyRow">
                        <button type="button" style="cursor: pointer;" class="btn btn-warning book-btn" onclick="bookNow();">立即预订</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="content-middle">
            <div class="row content-middle-header">
                <div class="col-md-2 col header-text active" onclick="scrollPosition('product_introduce',this);">
                    产品介绍
                </div>
                <div style="cursor: pointer;"
                class="col-md-2 col header-text " onclick="scrollPosition('grouptour_statement',this);">
                    费用说明
                </div>
                <div style="cursor: pointer;"  class="col-md-2 col header-text" onclick="scrollPosition('grouptour_attention',this);">
                预订须知
                </div>
            </div>
            <div class=" path-detail-content">
                <div class="row route-information-header" id="product_introduce">
                    <span class="info-line"></span>
                    <span class="info-text">产品介绍</span>
                </div>
                ${dataModel.grouptour_trip}
                <!-- <div class="row path-row-one">
                    <div class="col-md-2 col item-left">
                        第一天
                    </div>
                    <div class="col-md-col-12 col item-right">
                         到达都匀
                    </div>
                </div>
                <div class="row path-row-two">
                    <div class="col-md-2 col"></div>
                    <div class="col-md-10 col"></div>
                </div>
                <div class="row path-row-three">
                    <div class="col-md-2 col col-left-one">
                        <img src="/img/duyun/pc/route/jingdian.png" class="can-img" alt="">
                    </div>
                    <div class="col-md-10 col col-right-one">
                        <span>景点：</span>
                        <span>百子桥</span>
                    </div>
                </div>
                <div class="row path-row-four">
                    <div class="col-md-2 col line-col"></div>
                    <div class="col-md-10 col line-right">
                        <img src="/img/duyun/pc/route/home.png" class="img-one" alt=""/>
                        <p class="text-one">这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介</p>
                    </div>
                </div>
                <div class="row path-row-three">
                    <div class="col-md-2 col col-left-one">
                        <img src="/img/duyun/pc/route/jingdian.png" class="can-img" alt="">
                    </div>
                    <div class="col-md-10 col col-right-one">
                        <span>景点：</span>
                        <span>百子桥</span>
                    </div>
                </div>
                <div class="row path-row-four">
                    <div class="col-md-2 col line-col"></div>
                    <div class="col-md-10 col line-right">
                        <img src="/img/duyun/pc/home.png" class="img-one" alt=""/>
                        <p class="text-one">这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介</p>
                    </div>
                </div>
                <div class="row path-row-three">
                    <div class="col-md-2 col col-left-one">
                        <img src="/img/duyun/pc/route/canting.png" class="can-img" alt="">
                    </div>
                    <div class="col-md-10 col col-right-one">
                        <span>餐厅：</span>
                        <span>KFC</span>
                    </div>
                </div>
                <div class="row path-row-four">
                    <div class="col-md-2 col line-col"></div>
                    <div class="col-md-10 col line-right">
                        <img src="/img/duyun/pc/home.png" class="img-one" alt=""/>
                    </div>
                </div>
                <div class="row path-row-three">
                    <div class="col-md-2 col col-left-one">
                        <img src="/img/duyun/pc/route/jiudian.png" class="can-img" alt="">
                    </div>
                    <div class="col-md-10 col col-right-one">
                        <span>都匀文峰大酒店</span>
                    </div>
                </div>
                <div class="row path-row-four">
                    <div class="col-md-2 col not-line-col"></div>
                    <div class="col-md-10 col line-right">
                        <img src="/img/duyun/pc/home.png" class="img-one" alt=""/>
                    </div>
                </div> -->
                <div class="row route-information-header" id="grouptour_statement">
                    <span class="info-line"></span>
                    <span class="info-text">费用说明</span>
                </div>
                <div class="expense-content">
                 ${dataModel.grouptour_statement}
                   <!--  <ul>
                        <li class="li-one">
                            <p class="li-p">费用包含</p>
                            <ul>
                                <li class="child-li">1.酒店：入住3万五星酒店</li>
                                <li class="child-li">2.酒店：入住3万五星酒店</li>
                                <li class="child-li">3.酒店：入住3万五星酒店</li>
                            </ul>
                        </li>
                        <li class="li-one">
                            <p class="li-p">费用不含</p>
                            <ul>
                                <li class="child-li">1.酒店：入住3万五星酒店</li>
                                <li class="child-li">2.酒店：入住3万五星酒店</li>
                            </ul>
                        </li>
                    </ul> -->
                </div>
                <div class="row route-information-header" id="grouptour_attention">
                    <span class="info-line"></span>
                    <span class="info-text">预订须知</span>
                </div>
                <div class="expense-content">
                ${dataModel.grouptour_attention}
                  <!--   <ul>
                        <li class="li-one">
                            <p class="li-p">退变更限制</p>
                            <ul>
                                <li class="child-li">1.酒店：入住3万五星酒店</li>
                            </ul>
                        </li>
                        <li class="li-one">
                            <p class="li-p">出行须知</p>
                            <ul>
                                <li class="child-li">1.酒店：入住3万五星酒店</li>
                            </ul>
                        </li>
                    </ul> -->
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
 <script type="text/javascript">
 var bookInfo ={
		 childsNum:$("#range2").text(),
		 adultNum:$("#range1").text(),
		 traveDate:'',
		 childPrice:0,
		 adultPrice:0,
		 groupTourId:'${dataModel.grouptour_id}'
 }
 var currentMonth = '${currentMonth}';
 var currentYear = '${currentYear}';
 var adultPrice = '${dataModel.grouptour_price}';
 var childPrice = '${dataModel.childs_price}';
     $(function(){
    	 requestDateInfo();
    	 $("#prevMonth").click(function(){
    		 if($("#prevMonth").hasClass("disabled-click")){
    			 return;
    		 }
    		 $("#nextMonth").removeClass("disabled-click");
    		 var selectYear = $("#currentYear").text();
    		 var selectMonth = $("#currentMonth").text();
    		 selectMonth = parseInt(selectMonth);
    		 selectYear = parseInt(selectYear);
    		 selectMonth --;
    		 if(selectMonth == 0){
    			 selectMonth = 12;
    			 selectYear = selectYear - 1;
    		 }
    		 $("#currentYear").text(selectYear);
    		 $("#currentMonth").text(selectMonth);
    		 requestDateInfo(selectYear,selectMonth);
    	 });
    	 $("#nextMonth").click(function(){
    		 if($("#nextMonth").hasClass("disabled-click")){
    			 return;
    		 }
    		 $("#prevMonth").removeClass("disabled-click");
    		 var selectYear = $("#currentYear").text();
    		 var selectMonth = $("#currentMonth").text();
    		 selectMonth = parseInt(selectMonth);
    		 selectYear = parseInt(selectYear);
    		 selectMonth++;
    		 if(selectMonth > 12){
    			 selectMonth = 1;
    			 selectYear = selectYear+1;
    		 }
    		 $("#currentYear").text(selectYear);
    		 $("#currentMonth").text(selectMonth);
    		 requestDateInfo(selectYear,selectMonth);
    	 });
    	    minus = function (obj) {
    	        var content = parseInt(obj.nextElementSibling.innerText, 10);
    	        if (content) {
    	            obj.nextElementSibling.innerText = --content;
    	        }
    	        bookInfo.childsNum = $("#range2").text();
    	        bookInfo.adultNum = $("#range1").text();
    	    };
    	    plus = function(obj) {
    	        var content = parseInt(obj.previousElementSibling.innerText, 10);
    	        obj.previousElementSibling.innerText = ++content;
    	        bookInfo.childsNum = $("#range2").text();
    	        bookInfo.adultNum = $("#range1").text();
    	    };
     });
      function requestDateInfo(selectYear,selectMonth){
    	  if(!selectYear){
    		  selectYear = currentYear;
    	  }
    	  if(!selectMonth){
    		  selectMonth = currentMonth
    	  }
    	  Ajax.request("/logic/calDate",{"data":{"currentYear":selectYear,"currentMonth":selectMonth,"adultPrice":adultPrice,"childPrice":childPrice},
    		  "success":function(data){
    		  if(data.code == 200){
    			  var data = data.data;
    			  var htmlAry = [];
    			  $("#selectDateInfo").empty();
    			  $("#selectDateInfo").append('<tr class="calendar-header"><th>日</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th></tr>');
    			  for(var i = 0 ; i < data.dataList.length ; i++){
    				  if(i % 7 == 0){
    				     htmlAry.push("<tr>");
    				  }
    				  if(data.dataList[i].disabled == 1){
    					  htmlAry.push('<td></td>');
    				  }else{
    					  htmlAry.push('<td style="cursor:pointer;" onclick="selectDateInfo(this)" data-code='+"'"+JSON.stringify(data.dataList[i])+"'"+'"><div class="calendar-cell"> <div class="cell-date">'+data.dataList[i].dayOfMonth+'</div>');
        				  htmlAry.push('<div class="cell-price">￥'+data.dataList[i].groupPrice+'</div> <div class="cell-status">充足</div> </div> </td>');
    				  }
    				  if(i % 7 == 6){
    					  htmlAry.push('</tr>');
    				  }
    			  }
    			  $("#selectDateInfo").append(htmlAry.join(''));
    			  if(data.selectYear == currentYear && data.selectMonth == currentMonth){
    				  $("#prevMonth").addClass("disabled-click");
    			  }
    			/*   currentMonth =  parseInt(currentMonth);
    			  currentYear = parseInt(currentYear);
    			  currentMonth ++;
    			  if(currentMonth > 12){
    				  currentMonth = 1;
    				  currentYear = currentYear+1;
    			  } */
    		  }
    	  }});
      }
      function  selectDateInfo(thisObj){
    	 var routeInfo = JSON.parse($(thisObj).attr("data-code"));
    	 $(".chooseBox").text(routeInfo.dateStr);
    	 if(routeInfo.childPrice){
    		 $("#childPrice").text("￥"+routeInfo.childPrice);
    	 }
    	 $("#adultPrice").text("￥"+routeInfo.groupPrice);
    	 bookInfo.traveDate = routeInfo.dateStr;
    	 bookInfo.childPrice = routeInfo.childPrice;
    	 bookInfo.adultPrice = routeInfo.groupPrice;
      }
      function  scrollPosition(index,thisObj){
    	    $(thisObj).addClass("active");
    	    $(thisObj).siblings().removeClass("active");
    	    var $objTr = $("#"+index); //找到要定位的地方  tr 
    	    var x = $objTr.offset();
    	    $("body").animate({scrollTop:x.top},"slow"); //定位tr 
   	  } 
      
      
      
      function bookNow(){
    	  if(!bookInfo.traveDate){
    	     alert("请选择出行日期");
    	     return;
    	  }
    	  if(!bookInfo.adultNum  || !bookInfo.childsNum){
    		  alert("请选择出行人数");
    		  return;
    	  }
    	  window.location.href="/travel/route/confirmOrder?paramStr="+Base64.encode(JSON.stringify(bookInfo));
      }
 </script>
</html>