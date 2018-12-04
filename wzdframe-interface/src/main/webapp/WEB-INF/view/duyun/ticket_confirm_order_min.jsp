<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- <title>购票确认信息界面</title> -->
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<!-- Sets initial viewport load and disables zooming -->
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="email=no" name="format-detection" />
<link href="/vendors/ratchet/css/ratchet.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/mpddxq.min.css">
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/confirm-order.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
   <style type="text/css">
      .tipError{
         color:red!important;
      }
    </style>
</head>
<script type="text/javascript">

function UrlSearch() 
{
   var name,value; 
   var str=location.href; //取得整个地址栏
   var num=str.indexOf("?") 
   str=str.substr(num+1); //取得所有参数   stringvar.substr(start [, length ]

   var arr=str.split("&"); //各个参数放到数组里
   for(var i=0;i < arr.length;i++){ 
    num=arr[i].indexOf("="); 
    if(num>0){ 
     name=arr[i].substring(0,num);
     value=arr[i].substr(num+1);
     this[name]=value;
   } 
  } 
}
            var Request=new UrlSearch();     	
		 	var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/ticket/indexwenhaoredirectType==ticketjiahaot_id"+Request.scenic_id;
		 	var cancelUrl = '/wx/ticket/index?redirectType=orderList';
</script>
<body>
	<!--底部导航栏-->
	<footer class="bar bar-tab">
		<div class="toolbar">
			<span class="bar-item total-price">
				<div id="ticketTotalPrice">￥ 0.00</div>
				<div>订单总价</div>
			</span> <span class="bar-item btn-buy" onclick="createOrder()">提交订单</span>
		</div>
		<!--支付-->
	<div class="fixed" style="display: none;" id="toPay">
		<!-- style="display:none;" -->
		<div class="fixed-bg"></div>
		<div class="fixed-wrap">
			<ul class="content-list">
				<li>
					<div id="closePayType" class="back l">
						<img src="/img/cancel_icon.png" />
					</div>
					<p class="text-center font-s16">选择支付方式</p>
				</li>
				<!--我发布的-->
				<%-- <li data-type="1" data-nosel="0" id="yuePay"
					class="clearfix selectPayType">
					<!--左边-->
					<div class="icon-box l">
						<img src="/img/yue@2x.png" /> <span class="f666" id="yuePaySpan">余额支付&nbsp;&nbsp;￥${empty wallet.user_money ?0.00:wallet.user_money}</span>
					</div> <!--打勾-->
				</li> --%>
				<!--我发布的-->
				<li data-type="2" id="wechatPay" class="clearfix selectPayType">
					<!--左边-->
					<div class="icon-box l">
						<img src="/img/weixin@2x.png" /> <span class="f666">微信支付</span>
					</div>
					<div class="select-width r">
							<img src="/img/xuanze@2x.png">
					</div>
				</li>
			</ul>
			<div class="clearfix pay">
				<span class="l">付款</span> <span class="fad8a54 r">￥<span
					id="pay_money">0.00</span></span>
			</div>
			<div class="sure-btn">
				<input type="hidden" value="2" id="param_pay_type" /> <input
					type="hidden" value="" id="param_money" /> <input type="hidden"
					value="" id="param_order_id" /> <input type="hidden" value=""
					id="moudle_type" />
				<button onclick="surePay();">确定付款</button>
			</div>
		</div>
	</div>
	</footer>
	<!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
	<div class="content">
        <div class="order-info-wrap">
          <c:forEach items="${ticketList}" var="ticket" varStatus="status">  
		            <div class="ticket-item"   data-code="" <c:if test="${ticket.ticketDetail.IsRealName}">style="margin-bottom:15px;"</c:if>>
		                <div class="title-wrap">
		                    <div class="ticket-title">${ticket.ticket_name}</div>
		                    <div onclick="ticketMoreController.delTicket(this,'${ticket.id}')" class="delete-btn">
		                        <img src="/img/duyun/icons/trash.png" alt="">
		                    </div>
		                </div>
		                <div class="paramArea">
		                <!-- 票务id -->
		                   <input type="hidden" name="ticketId" value="${ticket.id}" />
		                   <!-- 景点id -->
		                   <input type="hidden" name="scenicId" value="${ticket.scenic_id}" />
		                   <!-- 第三方票务公司id -->
		                   <input type="hidden" name="third_no" value="${ticket.third_no}" />
		                   <input type="hidden" name="beginSaleTime" value="${ticket.ticketDetail.BeginSaleTime}">
		                   <input type="hidden" name="endSaleTime" value="${ticket.ticketDetail.EndSaleTime}">
		                   <input type="hidden" name="beginValidTime" value="${ticket.ticketDetail.BeginValidTime}">
		                   <input type="hidden" name="endValidTime" value="${ticket.ticketDetail.EndValidTime}">
		                   <input type="hidden" name="marketPrice" value="${ticket.ticketDetail.MarketPrice}">
		                   <input type="hidden" name="retailPrice" value="${ticket.ticketDetail.RetailPrice}">
		                   <input type="hidden" name="settlementPrice" value="${ticket.ticketDetail.SettlementPrice}">
		                   <input type="hidden" name="minBuyCount" value="${ticket.ticketDetail.MinBuyCount}">
		                   <input type="hidden" name="maxBuyCount" value="${ticket.ticketDetail.MaxBuyCount}">
		                   <input type="hidden" name="advanceBookDays" value="${ticket.ticketDetail.AdvanceBookDays}">
		                   <input type="hidden" name="isRealName" value="${ticket.ticketDetail.IsRealName}">
		                   <input type="hidden" name="settlementPrice" value="${ticket.ticketDetail.SettlementPrice}">
		                   <input type="hidden" name="ticketPrice" value="">
		                   <input type="hidden" name="travelDate" value="">
		                </div>
		                <ul class="table-view">
		                    <li class="table-view-cell" >
		                        <a class="navigate-right choose-date" onclick="selectDate(this);"  href="javascript:;" >
		                            选择日期
		                        </a>
		                    </li>
		                    <li class="table-view-cell">
		                        <a class="ticket-num" >
		                            数量
		                            <div class="num-adjust">
		                                <div class="adjust-minus" onclick="minus(this)" >
		                                    <img src="/img/duyun/icons/minus.png" alt="">
		                                </div>
		                                <div class="adjust-view">${(empty ticket.ticketDetail.MinBuyCount ||  ticket.ticketDetail.MinBuyCount eq 0) ? 1 : ticket.ticketDetail.MinBuyCount}</div>
		                                <div class="adjust-plus" data-isrealname='${ticket.ticketDetail.IsRealName}'  onclick="plus(this)">
		                                    <img src="/img/duyun/icons/plus.png" alt="">
		                                </div>
		                            </div>
		                        </a>
		                    </li>
		                </ul>
		            </div>
		         <c:if test="${ticket.ticketDetail.IsRealName}">  
		            <div class="traveller-list" style="margin-bottom:10px;">
		                <div class="traveller-add">
		                    <div>出行人</div>
		                    <img data-isrealname='${ticket.ticketDetail.IsRealName}' onclick="travelerController.add(this,'direct')" src="/img/duyun/icons/plus.png">
		                </div>
		                <div class="traveller-item">
		                    <div class="item-label" onclick="travelerController.del(this,'direct')">出行人</div>
		                    <div class="item-content">
		                        <!--<div class="traveller-name">乌达</div>
		                        <div class="traveller-code">445895788956845278（成人）</div>-->
		                        <form class="input-group">
		                            <input class="traveller-name" name="traveller-name" type="text" placeholder="姓名">
		                            <input class="traveller-name" name="traveller-phone" type="email" placeholder="联系电话">
		                            <input class="traveller-name" name="traveller-idcard" type="text" placeholder="身份证号">
		                        </form>
		                    </div>
		                </div>
		            </div>
		        </c:if>     
            </c:forEach>
            <div class="action-add" onclick="ticketMoreController.buyOtherTicket();">
                <img src="/img/duyun/icons/plus.jpg" alt="">
                <span>同时购买该景区其他票</span>
            </div>
            <div class="traveller-info">
                <div class="info-item">
                    <div>联系人</div>
                    <div><input class="traveller-name checkConName" name="contact-name" style="height: 100%;margin-bottom:0px;border:0px;idth: 100%;-webkit-appearance: none;line-height: 21px;background-color: #fff;border-radius: 3px;  outline: none;" type="text" placeholder="输入姓名"></div>
                </div>
                <div class="info-item">
                    <div>联系电话</div>
                    <div><input class="traveller-name checkConName" name="contact-phone" style="height: 100%;margin-bottom:0px;border:0px;width: 100%;-webkit-appearance: none;line-height: 21px;background-color: #fff;border-radius: 3px;  outline: none;" type="number" placeholder="输入手机号"></div>
                </div>
                <div class="info-item">
                    <div>邮箱</div>
                    <div><input class="traveller-name checkConName" name="contact-email" style="height: 100%;margin-bottom:0px;border:0px;width: 100%;-webkit-appearance: none;line-height: 21px;background-color: #fff;border-radius: 3px;  outline: none;" type="email" placeholder="输入邮箱"></div>
                </div>
            </div>
        </div>
    </div>
	<!--日期选择-->
	<div id="dateSelect" class="modal">
		<header class="bar bar-nav">
			<a class="icon icon-close pull-right" href="#dateSelect"></a>
			<h1 class="title">选择日期</h1>
			<div class="pro-img"></div>
		</header>
		<div class="content">
			<div class="date-header">
				<div class="date-minus" id="dataLeft">
					<img id="dataLeft_Img" src="/img/duyun/icons/arrow_left_cover.png"
						alt="" />
				</div>
				<div class="date-view" id="yearMonth">2017-8</div>
				<div class="date-plus" id="dataRight">
					<img src="/img/duyun/icons/arrow_right.png" alt="" />
				</div>
			</div>
			<div class="calendar-wrap">
				<div class="calendar-week">
					<span class="calendar-week-item">日</span> <span
						class="calendar-week-item">一</span> <span
						class="calendar-week-item ">二</span> <span
						class="calendar-week-item ">三</span> <span
						class="calendar-week-item ">四</span> <span
						class="calendar-week-item ">五</span> <span
						class="calendar-week-item">六</span>
				</div>
				<div class="calendar-date">
					<div class="calendar-date-item disable empty_day"></div>
					<div class="calendar-date-item disable empty_day"></div>
					<div class="calendar-date-item disable empty_day"></div>
					<div class="calendar-date-item disable empty_day"></div>
					<div class="calendar-date-item disable empty_day"></div>
					<div class="calendar-date-item disable">
						<div class="date-info">1</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">2</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">3</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">4</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">5</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">7</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">8</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">9</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">10</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">11</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">12</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">13</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item checked">
						<div class="date-info">14</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item">
						<div class="date-info">15</div>
						<div class="price-info">￥60</div>
						<div class="extra-info">充足</div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
					<div class="calendar-date-item disable">
						<div class="date-info">6</div>
						<div class="price-info"></div>
						<div class="extra-info"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="spinner">
		<div class="loading">
			<img src="/img/duyun/dstc/loading.gif" alt="" />
		</div>
	</div>
	<%@ include file="common/commJs.jsp"%>
	<%@ include file="common/pay.jsp"%>
	<script src="/vendors/ratchet/js/ratchet.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
	<script type="text/javascript" src="/js/InheritString.js"></script>
	<script type="text/javascript" src="/js/InheritArray.js"></script>
	<script type="text/javascript">
		var nowday;//当前日期
		var nowyear;//当前年份
		var nowmonth;//当前月
		var price;//价格
        var itemDate; //当前选择的item
		var loadingPanel = document.querySelector('.spinner');
		var adjustView;
		var minus = function(thisObj) {
			adjustView = $(thisObj).parents(".ticket-item").find(".adjust-view")[0];
			var buyMinNum = parseInt($(thisObj).parents(".ticket-item").find("input[name='minBuyCount']").val());
			buyMinNum = buyMinNum?buyMinNum:1;
			adjustView.innerText = adjustView.innerText - buyMinNum > 0 ? adjustView.innerText - 1
					: buyMinNum;
			travelerController.del(thisObj,'indirect');
		};
		var plus = function(thisObj) {
			adjustView = $(thisObj).parents(".ticket-item").find(".adjust-view")[0];
			var buyMaxNum = parseInt($(thisObj).parents(".ticket-item").find("input[name='maxBuyCount']").val());
			buyMaxNum = buyMaxNum ? buyMaxNum : 100000;
			adjustView.innerText = adjustView.innerText >= buyMaxNum ? buyMaxNum : adjustView.innerText++;
			travelerController.add(thisObj);
		};
		$(function() {
			$(".getfouce").click(function(){
				$(this).children().eq(1).children().eq(0)[0].focus();
			});
		});
		function dateItemOnClick(objthis) {
			if (!$(objthis).hasClass("checked")
					&& !$(objthis).hasClass("disable")) {
				$(objthis).addClass("checked");
				$(objthis).siblings().removeClass("checked");
			}
			var ticketInfo = $(objthis).attr("data-code");
			ticketInfo = JSON.parse(ticketInfo);
			itemDate.parents(".ticket-item").find(".choose-date").html("选择日期 ： &nbsp;&nbsp;&nbsp;" + ticketInfo.Date);
			itemDate.parents(".ticket-item").find("input[name='ticketPrice']").val(ticketInfo.SettlementPrice);
			itemDate.parents(".ticket-item").find("input[name='travelDate']").val(ticketInfo.Date);
			itemDate.parents(".ticket-item").find("input[name='marketPrice']").val(ticketInfo.MarketPrice);
			itemDate.parents(".ticket-item").find("input[name='retailPrice']").val(ticketInfo.RetailPrice);
			itemDate.parents(".ticket-item").find("input[name='settlementPrice']").val(ticketInfo.SettlementPrice);
			$("#dateSelect").removeClass('active');
			itemDate = itemDate.parents(".ticket-item");
			var ticketTotalPrice = ticketInfo.SettlementPrice;
			if(itemDate.find('.ticket-show-price').length > 0){
				itemDate.find('.fill-price').html("￥"+ticketTotalPrice);
			}else{
			    itemDate.find("ul").append('<li class="table-view-cell ticket-show-price"><a class="ticket-num" >单价<div class="num-adjust  fill-price" style="border: 0px;font-size: 18px;    color: #FF3C00;font-weight: 600;">￥'+ticketTotalPrice+'</div></a></li>');
			}
			getTotalPrice();
		}
		function getTotalPrice() {
			var orderTotalPrice = 0.0;
			var isShowPrice = true;
			$(".ticket-item").each(function(){
				var ticketNum = parseInt($(this).find(".adjust-view").text());
				var ticketPrice = parseFloat($(this).find("input[name='ticketPrice']").val());
				var travelDate = $(this).find("input[name='travelDate']").val();
				if(!travelDate || !ticketNum || !ticketPrice){
					isShowPrice = false;
				}else{
				   orderTotalPrice += ticketNum*ticketPrice;
				}
			});
			    $("#ticketTotalPrice").html("￥" + orderTotalPrice)
		}
		function tecketdata(type, month, price) {
			var date = new Date();
			nowday = date.getDate();
			nowmonth = month;
			nowyear = nowyear;
			if (type == 1) {
				nowmonth++;
			} else if (type == 0) {
				nowmonth = date.getMonth() + 1;
				nowyear = date.getFullYear();
			} else if (type == -1) {
				nowmonth--;
			}
			if (nowmonth > 12) {
				nowmonth -= 12; //月份减           
				nowyear++; //年份增       
				nowyear = nowyear++;
			}
			if (nowmonth <= 0) {
				nowmonth = 12;
				nowyear--; //年份增       
				nowyear = nowyear--;
			}
			if (nowmonth <10) {
				nowmonth ='0'+nowmonth;
			}
			dateParam.yearParam = nowyear;
			dateParam.monthParam = nowmonth;
			var daycount = getdate_count(nowyear, nowmonth);

			var onedayWeek = "0123456".split("")[(new Date(nowyear,
					nowmonth - 1, 1)).getDay()]; //获取月份第一天星期
			var html = '';
			Ajax.request("/wx/ticket/dodateList",
							{
								"data" : dateParam,
								"success" : function(data) {
									if (data.code == 200) {
										var data = data.data;
										if (data) {
											if(data.jsonData!=null && data.jsonData!=''){
												var dayone=data.jsonData[0].Date.substring(8,10);
												if(dayone!='01'){
													var newData=[];
													for (var k = 0; k < (daycount-data.jsonData.length); k++) {
														newData.push({});
													}
													Array.prototype.push.apply(newData, data.jsonData);
													data.jsonData=newData;
												}
											}
											if (onedayWeek && daycount) {
												if (nowyear >= date.getFullYear()&& nowmonth != (date.getMonth() + 1)) {
													for (var i = 0; i < onedayWeek; i++) {
														html += '<div class="calendar-date-item disable empty_day"></div>';
													}
													
													for (var j = 0; j < daycount; j++) {
														var day=(j + 1);
															if(day<10){
																day='0'+day;
															}
														if(data.jsonData[j]!=null && data.jsonData[j]!=''){
															if (data.jsonData[j].Stock == -1) {
																data.jsonData[j].Stock = "充足"
															}
															html += '<div class="calendar-date-item " data-code='
																+ "'"
																+ ''
																+ JSON.stringify(data.jsonData[j])
																+ ''
																+ "'"
																+ '" onclick="dateItemOnClick(this)"><div class="date-info">'
																+ day
																+ '</div><div class="price-info">￥'
																+ data.jsonData[j].SettlementPrice
																+ '</div><div class="extra-info">'
																+ data.jsonData[j].Stock
																+ '</div></div>';
														}else{
															html += '<div class="calendar-date-item disable"><div class="date-info">'
																+ day
																+ '</div><div class="price-info"></div><div class="extra-info"></div></div>';
														}
													}
												} else if (nowyear == date
														.getFullYear()
														&& nowmonth == (date
																.getMonth() + 1)) {
													if (onedayWeek >= 0) {
														for (var i = 0; i < onedayWeek; i++) {
															html += '<div class="calendar-date-item disable empty_day"></div>';
														}
														for (var j = 0; j < daycount; j++) {
															var day=(j + 1);
															if(day<10){
																day='0'+day;
															}
															if(data.jsonData[j]!=null && data.jsonData[j]!=''){
																if (data.jsonData[j].Stock == -1) {
																	data.jsonData[j].Stock = "充足"
																}
																if (day < nowday) {
																	html += '<div class="calendar-date-item disable"><div class="date-info">'
																			+ day
																			+ '</div><div class="price-info"></div><div class="extra-info"></div></div>';
																} else if (day == nowday) {
																	html += '<div class="calendar-date-item checked" data-code='
																			+ "'"
																			+ ''
																			+ JSON
																					.stringify(data.jsonData[j])
																			+ ''
																			+ "'"
																			+ '" onclick="dateItemOnClick(this)"><div class="date-info">'
																			+ day
																			+ '</div><div class="price-info">￥'
																			+ data.jsonData[j].SettlementPrice
																			+ '</div><div class="extra-info">'
																			+ data.jsonData[j].Stock
																			+ '</div></div>';
																} else if (day > nowday) {
																	html += '<div class="calendar-date-item " data-code='
																			+ "'"
																			+ ''
																			+ JSON
																					.stringify(data.jsonData[j])
																			+ ''
																			+ "'"
																			+ '" onclick="dateItemOnClick(this)"><div class="date-info">'
																			+ day
																			+ '</div><div class="price-info">￥'
																			+ data.jsonData[j].SettlementPrice
																			+ '</div><div class="extra-info">'
																			+ data.jsonData[j].Stock
																			+ '</div></div>';
																}
															}else{
																html += '<div class="calendar-date-item disable"><div class="date-info">'
																	+ day
																	+ '</div><div class="price-info"></div><div class="extra-info"></div></div>';
															}
														}
													}
												}
												$(".calendar-date").empty()
														.append(html);
											}
										}
									}
								}
							});
			$("#yearMonth").html(nowyear + "-" + nowmonth);
			/* $(".choose-date").html(
					"选择日期 ： &nbsp;&nbsp;&nbsp;" + nowyear + "-" + nowmonth
							+ "-" + nowday);
			$("#to_travel_date").val(nowyear + "-" + nowmonth + "-" + nowday); */
		}
		$("#dataLeft").click(
				function() {
					var date = new Date();
					var newMonth = nowmonth;
					if (nowyear > date.getFullYear()
							|| newMonth > (date.getMonth() + 1)) {
						tecketdata(-1, nowmonth, price);
						if (nowmonth == (date.getMonth() + 1)) {
							$("#dataLeft_Img").attr('src',
									'/img/duyun/icons/arrow_left_cover.png');
						}
					}
				});
		//日历点击
		$("#dataRight").click(function() {
			$("#dataLeft_Img").attr('src', '/img/duyun/icons/arrow_left.png');
			tecketdata(1, nowmonth, price);
		});
		//获取月份天数
		function getdate_count(new_year, new_month) {
			//如果当前大于12月，则年份转到下一年         
			if (new_month > 12) {
				new_month -= 12; //月份减           
				new_year++; //年份增           
			}
			var new_date = new Date(new_year, new_month, 1); //当前月的第一天
			var date_count = (new Date(new_date.getTime() - 1000 * 60 * 60 * 24))
					.getDate();//获取当月的天数         
			return date_count;
		}
		
		
		//以下控制 选取多张票  包括票的删除  增加
		var ticketIds = '${pd.tids}';
		if(ticketIds){
			   ticketIds = ticketIds.split(",");
		}
		var ticketMoreController = function(){
		}
		/*点击删除某个票务  先判断是否删完  如果删除完 跳转到景点票务详情*/
		ticketMoreController.delTicket = function(thisObj,tempTicketId){
			var travelerElem = $(thisObj).parent().parent().next();
			if(travelerElem.hasClass("traveller-list")){
				travelerElem.remove();
			}
			$(thisObj).parent().parent().remove();
			ticketIds.removeValue(tempTicketId);
			if(ticketIds.length == 0){
				window.location.href='/wx/ticket/index?redirectType=detail&t_id=${pd.scenic_id}';
			}
			getTotalPrice();
		}
		ticketMoreController.buyOtherTicket = function(){
			window.location.href='/wx/ticket/index?redirectType=detail&tids='+ticketIds+'&t_id=${pd.scenic_id}';
		}
		//以下控制出行人的删除添加
		var travelerController = function(){
		}
		travelerController.add = function(thisObj,type){
			//判断点击添加联系人的类型  直接点击加号添加  或者点击添加数量添加
			var travelersElem;
		    travelersElem = $(thisObj).parents(".ticket-item").next();
		    if('direct' == type){
		    	travelersElem = $(thisObj).parent().parent();
		    }
		    var travelers = travelersElem.length;
		    var to_quantity =  parseInt(travelersElem.prev().find(".adjust-view").html());
		    var html = '<div class="traveller-item"><div class="item-label" onclick="travelerController.del(this,'+"'"+'direct'+"'"+')">出行人</div>'
				  +'<div class="item-content"><form class="input-group">'
				  +'<input class="traveller-name checkConName" name="traveller-name" type="text" placeholder="姓名">'
				  +'<input class="traveller-name checkConPhone" name="traveller-phone" type="number" placeholder="联系电话">'
				  +'<input class="traveller-name checkIdCard" name="traveller-idcard" type="text" placeholder="身份证号">'
				  +'</form></div></div>';
			if($(thisObj).attr("data-isrealname") == 'true'){
		       travelersElem.append(html);
			   travelersElem.prev().find(".adjust-view").html(travelersElem.children('.traveller-item').length);
			}else{
			   var num=parseInt(travelersElem.prev().find(".adjust-view").html());
			   travelersElem.prev().find(".adjust-view").html((num+1));
			}	  
			getTotalPrice();
		}
		travelerController.del = function(thisObj,type){
			var travelersElem,travelers;
			if("direct" == type){  //如果点击左边的删除按钮删除
				travelersElem = $(thisObj).parent().parent();
			    travelers = travelersElem.children(".traveller-item").length;
				if(travelers > 1){
				  $(thisObj).parent().remove();
				}
			}else{                 //点击减号删除
				travelersElem = $(thisObj).parents(".ticket-item").next();
				travelers = travelersElem.children(".traveller-item").length;
				if(travelers > 1 ){
					travelersElem.children().eq(travelers-1).remove();
				}
			}
			if($(thisObj).attr("data-isrealname") == 'true'){
				travelersElem.prev().find(".adjust-view").html(travelersElem.children(".traveller-item").length)
			}else{
				var num=parseInt(travelersElem.prev().find(".adjust-view").html());
				travelersElem.prev().find(".adjust-view").html((num));
			}	
			getTotalPrice();
		}
		/*控制日期选择面板  弹出 并且赋值当前的 票务id  以及票务信息 参数 */
		function selectDate(thisObj){
			$("#dateSelect").addClass("active");
			itemDate = $(thisObj);
			var $paramElem = $(thisObj).parents(".ticket-item").find(".paramArea");
			dateParam.BeginValidTime= $paramElem.find('input[name =beginValidTime]').val();
			dateParam.EndValidTime= $paramElem.find('input[name =endValidTime]').val();
			dateParam.ticketTypeId = $paramElem.find('input[name =third_no]').val();
			dateParam.beginSaleTime = $paramElem.find('input[name =beginSaleTime]').val();
			dateParam.endSaleTime = $paramElem.find('input[name =endSaleTime]').val();
			dateParam.isRealName = $paramElem.find('input[name =isRealName]').val();
			tecketdata(0, 0, $paramElem.find('input[name =settlementPrice]').val());
		}
		
		//待购买的票务信息
		var submitTicketInfo = function(){
			this.user_id='';
			this.TravelDate = '';
			this.ThirdOrderId = ''; //平台订单编号
			this.TicketTypeId = ''; //三方票务id
			this.RetailPrice = ''; //零售价格
			this.SettlementPrice = ''; //结算价格
			this.Quantity = ''; //数量
			this.PaymentMethod = 1; //支付方式
			this.isRealName = false;
			this.Tourists = [];
		}
		this.ContactName = ''; //联系人姓名
		this.ContactMobile = ''; //联系人手机
		//创建订单
		function createOrder() {
			var orderInfo = {};
			orderInfo.ticketInfo=[];
			orderInfo.totalMoney = 0.0;
			var isGono = true;
			$(".ticket-item").each(function(){
			   var ticketItem = new submitTicketInfo();
			   ticketItem.TravelDate = $(this).find('input[name="travelDate"]').val();
			   if(ticketItem.TravelDate.isEmpty()){
				   alert("请选择"+$(this).find(".ticket-title").text()+"的出行日期");
				   isGono = false;
				   return false;
			   }
			   ticketItem.TicketTypeId =  $(this).find('input[name="third_no"]').val();
			   ticketItem.RetailPrice  =  $(this).find('input[name="retailPrice"]').val();
			   ticketItem.SettlementPrice  =  $(this).find('input[name="settlementPrice"]').val();
			   ticketItem.Quantity  =  $(this).find('.adjust-view').text();
			   ticketItem.isRealName  =  $(this).find('input[name="isRealName"]').val();
			   orderInfo.totalMoney += parseFloat(ticketItem.SettlementPrice) * ticketItem.Quantity;
			   if(ticketItem.SettlementPrice.isEmpty()){
				   alert($(this).find(".ticket-title").text()+"重新选择出行日期！");
				   isGono = false;
				   return false;
			   }
			   if(ticketItem.isRealName == 'true'){
				   //封装联系人信息
				   var $travelersElem = $(".ticket-item").next();
				   if($travelersElem.hasClass('traveller-list')){
					   $travelersElem.find(".traveller-item").each(function(){
						   var travelerName = $(this).find('input[name="traveller-name"]').val();
						   var travelerPhone = $(this).find('input[name="traveller-phone"]').val();
						   var travelerIdcard = $(this).find('input[name="traveller-idcard"]').val();
						   if(travelerName && travelerPhone && travelerIdcard){
							   if(!travelerPhone.isPhone()){
								  $(this).find('input[name="traveller-phone"]').addClass("tipError");
								  $(this).find('input[name="traveller-phone"]').focus();
								   isGono = false;
								   return false;
							   }
							   if(travelerIdcard.length > 18 || travelerIdcard.length < 16){
								   $(this).find('input[name="traveller-idcard"]').addClass("tipError");
								   $(this).find('input[name="traveller-idcard"]').focus();
								   isGono = false;
								   return false;
							   }
							   ticketItem.Tourists.push({"Name":travelerName,"Mobile":travelerPhone,"IdCardNo":travelerIdcard});
						   }
					   });
					   if(isGono && ticketItem.Tourists.length < ticketItem.Quantity){
						   alert($(this).find(".ticket-title").text()+"输入的出行人数量不对");
						   isGono = false;
						   return false;
					   }
				   }
			   }
			   orderInfo.ticketInfo.push(ticketItem);
			});
			if(isGono){ //如果其他信息验证正确
				orderInfo.ContactName = $("body").find('input[name="contact-name"]').val();
				orderInfo.ContactMobile = $("body").find('input[name="contact-phone"]').val();
				orderInfo.ContactEmail = $("body").find('input[name="contact-email"]').val();
				if(orderInfo.ContactName.isEmpty()){
					$("body").find('input[name="contact-name"]').focus();
					alert("联系人姓名不能为空");
					return;
				}
				if(!orderInfo.ContactMobile.isPhone()){
					$("body").find('input[name="contact-phone"]').focus();
					alert("联系电话格式不正确");
					return;
				}
				//创建订单提交到后台
				Ajax.request("/wx/ticket/doSubmitOrder",{"data":{"paramStr":JSON.stringify(orderInfo)},"success":function(data){
					   if (data.code == 200) {
							toPayShow(data.data.order_money,data.data.a_id);
						} else {
							alert(data.msg);
						}
				}});
			}
		}
		var dateParam = {
			monthParam : '',
			yearParam : '',
			ticketTypeId : '',
			endSaleTime : '',
			beginSaleTime : '',
			BeginValidTime:'',
			EndValidTime:'',
			isRealName : false,
		}
		//微信支付
		$(function(){
		    	$("#toPay .fixed-bg").click(function(){
		    		$("#toPay").fadeOut();
		    	});
		    	$("#closePayType").click(function(){
					$("#toPay").fadeOut();
					window.location.href='/wx/ticket/index?redirectType=detail&t_id='+'${pd.scenic_id}';
				});
		    });
		 var userMoney = '${wallet.user_money}';
	    	$(function(){
	    		$("#yuePay").click(function(){
	    			if($(this).attr("data-nosel") == "1"){
	    				return;
	    			}else{
	    				$(this).children().eq(1).remove();
	       			    $(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	       			    $("#param_pay_type").val($(this).attr("data-type"));
	       			    $("#wechatPay").children().eq(1).remove();
	    			}
	    		});
	    		$("#wechatPay").click(function(){
	    			$(this).children().eq(1).remove();
	   			    $(this).append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    			$("#param_pay_type").val($(this).attr("data-type"));
	    			$("#yuePay").children().eq(1).remove();
	    		});
	    	});
	    	function toPayShow(money,orderId){
	    		var type=2;
	    		$("#toPay").fadeIn();
	    		$("#pay_money").text(money);
	    		$("#param_money").val(money);
	    		$("#param_order_id").val(orderId);
	    		$("#moudle_type").val(type)
	    		if(userMoney){ //余额不足
	    			if(parseFloat(money) > parseFloat(userMoney)){
	    				$("#yuePay").attr("data-nosel",1);
	    				$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu").addClass("yuebuzhu");
	    				$("#param_pay_type").val("2");
	    				if($("#wechatPay").find(".select-width").length == 0){
	    				    $("#wechatPay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    				    $("#yuePay").children().eq(1).remove();
	    				}
	        		}else{//余额可以支付
	        			$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu");
	        			$("#param_pay_type").val("1");
	        			if($("#yuePay").find(".select-width").length == 0){
	        			   $("#yuePay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	        			   $("#wechatPay").children().eq(1).remove();
	        			}
	        		}
	    		}else{ //余额不足
	    			$("#param_pay_type").val("2");
	    			$("#yuePay").attr("data-nosel",1);
	    			$("#yuePay").children().eq(0).children().eq(1).removeClass("yuebuzhu").addClass("yuebuzhu");
	    			if($("#wechatPay").find(".select-width").length == 0){
	    				$("#wechatPay").append('<div class="select-width r"><img src="/img/xuanze@2x.png"/></div>');
	    				 $("#wechatPay").children().eq(1).remove();
	    			}
	    		}
	    	}
	    	function surePay(){
	    		if($("#param_pay_type").val() == "2"){
	    		   toPay($("#param_money").val(),4,$("#param_order_id").val(),callUrl);
	    		}else if($("#param_pay_type").val() == "1"){ //余额支付
	    			if(!'${withdrawPw}'){
	    				window.location.href="/wx/user/setPayPwPage?type=goodsPaySure";
	    			}else{
	    			    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val()+"&zurl="+callUrl;
	    			}
	    		}
	    	}
	   //监听返回按钮
	   GoBackBtn.excuteHistory("/wx/ticket/index?redirectType=detail&pageType=${pd.pageType}&t_id="+Request.scenic_id); 	
	</script>
</body>
</html>