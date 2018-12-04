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
<link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/mpddxq.css">
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/confirm-order.css" rel="stylesheet" />
<link href="/css/pay-type.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
</head>
<script type="text/javascript">
		 	var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/ticket/indexwenhaoredirectType==orderList";
		</script>
<body>
	<!--底部导航栏-->
	<footer class="bar bar-tab">
		<div class="toolbar">
			<span class="bar-item total-price">
				<div id="ticketTotalPrice">￥961</div>
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
					id="pay_money">1180.00</span></span>
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
		<div class="order-info-wrap" style="margin-top: 0px;">
			<input type="hidden" id="to_settlement_price" /> <input
				type="hidden" id="to_ticket_id" /> <input type="hidden"
				id="to_scenic_id" /> <input type="hidden" id="ticket_third_no" />
			<div class="ticket-item" style="    background: #FFF;">
				<div class="title-wrap" style="background: #FFF;">
					<div class="ticket-title" style="font-size: 17px;color: #5E5E5E;" id="t_title"></div>
					<!-- <div class="delete-btn">
                        <img src="/img/duyun/icons/trash.jpg" alt="" />
                    </div> -->
				</div>
				<ul class="table-view" style="margin-right:8px;margin-left:8px;border-top: 1px solid #E1E1E1;border-bottom: 1px solid #E1E1E1;">
					<li class="table-view-cell"><input type="hidden"
						id="to_travel_date" /> <a class="navigate-right choose-date"
						href="#dateSelect" style="font-size: 17px;color: #5E5E5E;"> 选择日期 </a></li>
					<li class="table-view-cell"><a class="ticket-num" style="font-size: 17px;color: #5E5E5E;">数量
							<div class="num-adjust">
								<div class="adjust-minus" onclick="minus()">
									<img src="/img/duyun/icons/minus.png" alt="" />
								</div>
								<input type="hidden" id="tickets_price" name="tickets_price" />
								<div class="adjust-view" id="to_quantity">1</div>
								<div class="adjust-plus" onclick="plus()">
									<img src="/img/duyun/icons/plus.png" alt="" />
								</div>
							</div>
					</a></li>
				</ul>
			</div>
			<div class="traveller-list">
				<div class="traveller-add" onclick="getTraveler()">
					<div>出行人</div>
					<img src="/img/duyun/icons/plus.png" />
				</div>
				<ul id="travelerList">
					<li class="traveller-item">
						<div class="item-label" onclick="delTraveler(this)">出行人</div>
						<div class="item-content">
							<form class="input-group">
								<input class="traveller-name checkConName" type="text"
									placeholder="姓名"> <input
									class="traveller-name checkConPhone" type="number"
									placeholder="联系电话"> <input
									class="traveller-name checkIdCard" type="text"
									placeholder="身份证号">
							</form>
						</div>
					</li>
				</ul>
			</div>
			<div class="traveller-info">
				<div class="getfouce"  style="padding-top: 15px;    border-bottom: 1px solid #E1E1E1;">
					<div style="float: left; line-height: 2;font-size: 17px;color: #5E5E5E;">联系人</div>
					<div style="display: inline;">
						<input style="padding-left: 37px;width: 200px;border:0;outline:none;margin-bottom: 0px;" type="text" id="to_contact_name"
							value="" />
					</div>
				</div>
				<div class="getfouce" style="padding-top: 20px; border-bottom: 1px solid #E1E1E1;">
					<div style="float: left; font-size: 17px;color: #5E5E5E;">联系电话</div>
					<div style="display: inline; margin-left: 10px">
						<input style="width: 200px;border:0;outline:none;margin-bottom: 0px;" type="text" id="to_contact_mobile"
							value="" />
					</div>
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
	<script type="text/javascript">
		var nowday;//当前日期
		var nowyear;//当前年份
		var nowmonth;//当前月
		var price;//价格

		var loadingPanel = document.querySelector('.spinner');
		var adjustView = document.querySelector('.adjust-view');
		var minus = function() {
			adjustView.innerText = adjustView.innerText - 1 > 0 ? adjustView.innerText - 1
					: 1;
			getTotalPrice();
			delTralis();
		};
		var plus = function() {
			adjustView.innerText++;
			getTotalPrice();
			getTraveler();
		};
		var ticketId = '${pd.ticketId}';
		$(function() {
			$("#to_ticket_id").val(ticketId);
			ticketDetail();
			$(".getfouce").click(function(){
				$(this).children().eq(1).children().eq(0)[0].focus();
			});
			
		});
		function ticketDetail() {
			Ajax.request("/wx/ticket/doticketorder",
							{	"data" : {
									"ticketId" : ticketId
								},
								"success" : function(data) {
									if (data.code == 200) {
										try {
											var data = data.data;
											if (data) {
												$("#to_scenic_id").val(data.scenic_id);
												$("#ticket_third_no").val(data.third_no);
												$("#t_title").html(data.datedetail.TicketTypeName);
												$("#tickets_price").val(data.datedetail.SettlementPrice);
												dateParam.BeginValidTime= data.datedetail.BeginValidTime;
												dateParam.EndValidTime= data.datedetail.EndValidTime;
												dateParam.ticketTypeId = data.datedetail.TicketTypeId;
												dateParam.beginSaleTime = data.datedetail.BeginSaleTime;
												dateParam.endSaleTime = data.datedetail.EndSaleTime;
												dateParam.isRealName = data.datedetail.IsRealName;
												
												submitTicketInfo.TicketTypeId = dateParam.ticketTypeId;
												submitTicketInfo.isRealName = dateParam.isRealName;
												submitTicketInfo.user_id = data.user_id;
												
												price = data.datedetail.SettlementPrice;
												tecketdata(0, 0, price);
												 if (!dateParam.isRealName) {
													$(".traveller-list").hide();
												} 
												getTotalPrice();
											}
										} catch (e) {
											loadingPanel.style.display = 'none';
										}
									}
									loadingPanel.style.display = 'none';
								}
							});
		}
		function dateItemOnClick(objthis) {
			if (!$(objthis).hasClass("checked")
					&& !$(objthis).hasClass("disable")) {
				$(objthis).addClass("checked");
				$(objthis).siblings().removeClass("checked");
			}
			var ticketInfo = $(objthis).attr("data-code");
			ticketInfo = JSON.parse(ticketInfo);
			submitTicketInfo.TravelDate = ticketInfo.Date;
			submitTicketInfo.RetailPrice = ticketInfo.RetailPrice;
			submitTicketInfo.SettlementPrice = ticketInfo.SettlementPrice;

			var t_day = $(objthis).children("div").eq(0).text();
			var t_price = $(objthis).children("div").eq(1).text();
			t_price = t_price.substring(1, (t_price.length));
			$("#tickets_price").val(t_price);
			getTotalPrice();
			 $(".choose-date").html(
					"选择日期 ： &nbsp;&nbsp;&nbsp;" + nowyear + "-" + nowmonth
							+ "-" + t_day); 
			$("#dateSelect").removeClass('active');
			 $("#to_travel_date").val(nowyear + "-" + nowmonth + "-" + t_day);
		}

		function getTotalPrice() {
			var price = $("#tickets_price").val();
			var num =  parseInt($("#to_quantity").html());
			$("#ticketTotalPrice").html("￥" + (price * num));
			$("#to_settlement_price").val((price * num));
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

		//添加出行人
		function getTraveler() {
			var travelers = $("#travelerList li").length;
			var to_quantity =  parseInt($("#to_quantity").html());
			var html = '<li class="traveller-item"><div class="item-label" onclick="delTraveler(this)">出行人</div>'
					  +'<div class="item-content"><form class="input-group">'
					  +'<input class="traveller-name checkConName" type="text" placeholder="姓名">'
					  +'<input class="traveller-name checkConPhone" type="number" placeholder="联系电话">'
					  +'<input class="traveller-name checkIdCard" type="text" placeholder="身份证号">'
					  +'</form></div></li>';
			if(to_quantity > travelers){
				$("#travelerList").append(html);
			}
			if(to_quantity <= travelers){
				$("#to_quantity").html((travelers+1));
				$("#travelerList").append(html);
			}
			getTotalPrice();
		}
		//修改数量是删除出行人（默认删除左后一行）
		function delTralis() {
			var travelers = $("#travelerList li").length;
			if(travelers > 1 ){
				$("#travelerList li").eq(travelers-1).remove();
			}
		}
		//删除出行人
		function delTraveler(objthis) {
			var travelers = $("#travelerList li").length;
			$(objthis).parent().remove();
			$("#to_quantity").html((travelers-1));
			getTotalPrice();
		}
		
		//创建订单
		function createOrder() {
			var to_settlement_price = $("#to_settlement_price").val();
			var to_ticket_id = $("#to_ticket_id").val();
			var ticket_third_no = $("#ticket_third_no").val();
			var to_quantity =  parseInt($("#to_quantity").html());
			var to_travel_date = $("#to_travel_date").val();
			var to_contact_name = $("#to_contact_name").val();
			var to_contact_mobile = $("#to_contact_mobile").val();
			var to_scenic_id = $("#to_scenic_id").val();
			var to_ticket_name = $("#t_title").html();
			var travelers = $("#travelerList li").length
			if (to_travel_date == null || to_travel_date == '') {
				alert("请选择日期")
				return;
			}
			if (to_quantity == null || to_quantity == '' || to_quantity == 0) {
				alert("请选择出行人数")
				return;
			}
			if (dateParam.isRealName && to_quantity > 0) {
				 var conPersonItems  = $(".traveller-item");
				 var travelers=conPersonItems.length;
				if (!conPersonItems && to_quantity == null || to_quantity == ''
						|| to_quantity != travelers) {
					alert("请选择出行人或出行人数量有误")
					if(to_quantity > travelers){
						for (var i = 0; i < (to_quantity-travelers); i++) {
							getTraveler();
						}
					}
					return;
				}else{
					 	//添加联系人信息
					 	var indexType=0;
					   	submitTicketInfo.Tourists.length = 0;
						conPersonItems.each(function(status){
							   var Name = $(this).find(".checkConName").val();
							   var Mobile = $(this).find(".checkConPhone").val();
							   var IdCardNo = $(this).find(".checkIdCard").val();
							   if(Name.isEmpty() || Name.length > 10){
								   alert("第"+(status+1)+"位校验名字出错");
								   indexType=1;
								   return false;
							   }
							   if(Mobile.isEmpty() || !Mobile.isPhone()){
								   alert("第"+(status+1)+"位校验手机出错");
								   indexType=1;
								   return false;
							   }
							   if(IdCardNo.isEmpty() || IdCardNo.length > 18 || IdCardNo.length < 16){
								   alert("第"+(status+1)+"位身份证号验证错误");
								   indexType=1;
								   return false;
							   }
							   	submitTicketInfo.Tourists.push({"Name":Name,"Mobile":Mobile,"IdCardNo":IdCardNo});
						   });
						if(indexType==1){
							return;
						}
				}
			}
			if (to_contact_name.isEmpty() || to_contact_name.length > 10) {
				alert("联系人出错")
				return;
			}
			if (to_contact_mobile.isEmpty() || !to_contact_mobile.isPhone()) {
				alert("联系电话出错")
				return;
			}
			submitTicketInfo.Quantity = to_quantity;
			submitTicketInfo.ContactName = to_contact_name;
			submitTicketInfo.ContactMobile = to_contact_mobile;
			 Ajax.request("/logic/ticket/addOrder",{"data" : {"paramStr" : Base64.encode(JSON.stringify(submitTicketInfo))},
								"success" : function(data) {
									if (data.code == 200) {
										toPayShow(data.data.to_order_money,data.data.o_id);
									} else {
										alert(data.msg);
									}
								}
							}); 
		}
		//待购买的票务信息
		var submitTicketInfo = {
			user_id:'',
			TravelDate : '',
			ThirdOrderId : '', //平台订单编号
			TicketTypeId : '', //三方票务id
			RetailPrice : '', //零售价格
			SettlementPrice : '', //结算价格
			Quantity : '', //数量
			ContactName : '', //联系人姓名
			ContactMobile : '', //联系人手机
			PaymentMethod : 1, //支付方式
			isRealName : false,
			Tourists : []
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
	    		   toPay($("#param_money").val(),2,$("#param_order_id").val(),callUrl);
	    		}else if($("#param_pay_type").val() == "1"){ //余额支付
	    			if(!'${withdrawPw}'){
	    				window.location.href="/wx/user/setPayPwPage?type=goodsPaySure";
	    			}else{
	    			    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val()+"&zurl="+callUrl;
	    			}
	    		}
	    	}
	</script>
</body>
</html>