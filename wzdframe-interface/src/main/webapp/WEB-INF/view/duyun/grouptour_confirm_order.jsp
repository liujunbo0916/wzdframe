<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>跟团游订单确认界面</title>
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
	var  callUrl = "/wx/duyun/user/paySuccess?zurl=/wx/grouptour/indexwenhaoresultType=orderList";
</script>
<body>
	<!--底部导航栏-->
	<footer class="bar bar-tab">
		<div class="toolbar">
			<span class="bar-item total-price">
				<div id="ticketTotalPrice">￥0.0</div>
				<div>订单总价</div>
			</span> <span class="bar-item btn-buy" onclick="createOrder()">提交订单</span>
		</div>
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
		<div class="order-info-wrap">
			 <input type="hidden" id="grouptour_id" />
			<div class="ticket-item">
				<div class="title-wrap">
					<div class="ticket-title" id="t_title"></div>
					<!-- <div class="delete-btn">
                        <img src="/img/duyun/icons/trash.jpg" alt="" />
                    </div> -->
				</div>
				<ul class="table-view">
					<li class="table-view-cell" onclick="selectDate();" ><input type="hidden"
						id="departure_date" /> <a class="navigate-right choose-date"
						href="javascript:;"> 选择日期 </a></li>
					<li class="table-view-cell"><a class="ticket-num"><p>成人：<span style="color: #FF3800;" >￥</span>
					<span style="color: #FF3800;" id="grouptour_price">961</span></p>
							<div class="num-adjust">
								<div class="adjust-minus" onclick="adultminus()">
									<img src="/img/duyun/icons/minus.png" alt="" />
								</div>
								<div class="adult—adjust-view" id="adult_num">1</div>
								<div class="adjust-plus" onclick="adultplus()">
									<img src="/img/duyun/icons/plus.png" alt="" />
								</div>
							</div>
					</a></li>
					<li class="table-view-cell"><a class="ticket-num"><p>儿童：<span style="color: #FF3800;" >￥</span>
					<span style="color: #FF3800;" id="childs_price">961</span></p>
							<div class="num-adjust">
								<div class="adjust-minus" onclick="minus()">
									<img src="/img/duyun/icons/minus.png" alt="" />
								</div>
								<div class="adjust-view" id="children_num">1</div>
								<div class="adjust-plus" onclick="plus()">
									<img src="/img/duyun/icons/plus.png" alt="" />
								</div>
							</div>
					</a></li>
				</ul>
			</div>
			<div class="traveller-list">
				<div class="traveller-add" onclick="getAdultTraveler()">
					<div>成人出行人</div>
					<img src="/img/duyun/icons/plus.png" />
				</div>
				<ul id="adulttravelerList">
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
			<div class="traveller-list">
				<div class="traveller-add" onclick="getChrTraveler()">
					<div>儿童出行人</div>
					<img src="/img/duyun/icons/plus.png" />
				</div>
				<ul id="childrentravelerList">
					<li class="traveller-item">
						<div class="item-label" onclick="delchrTraveler(this)">出行人</div>
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
				<div style="padding-top: 15px">
					<div style="display: inline;">联系人</div>
					<div style="display: inline; margin-left: 28px">
						<input style="width: 300px" type="text" id="link_perple"
							value="" />
					</div>
				</div>
				<div style="padding-top: 10px">
					<div style="display: inline;">联系电话</div>
					<div style="display: inline; margin-left: 10px">
						<input style="width: 300px" type="text" id="link_phone"
							value="" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--日期选择-->
	<div id="dateSelect" class="modal">
		<header class="bar bar-nav">
			<a class="icon icon-close pull-right" onclick="selectDate();" href="javascript:;"></a>
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
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
	<script type="text/javascript" src="/js/InheritString.js"></script>
	<script type="text/javascript">
		var nowday;//当前日期
		var nowyear;//当前年份
		var nowmonth;//当前月
		var adutlprice;//成人价格
		var chrprice;//儿童价格

		var loadingPanel = document.querySelector('.spinner');
		var adjustView = document.querySelector('.adjust-view');
		var adultAdjustView = document.querySelector('.adult—adjust-view');

		//儿童数量加减
		var minus = function() {
			adjustView.innerText = adjustView.innerText - 1 > 0 ? adjustView.innerText - 1
					: 0;
			getTotalPrice();
			delTralis();
		};
		var plus = function() {
			adjustView.innerText++;
			getChrTraveler();
			getTotalPrice();
		};

		//成人数量加减
		var adultminus = function() {
			adultAdjustView.innerText = adultAdjustView.innerText - 1 > 0 ? adultAdjustView.innerText - 1
					: 0;
			getTotalPrice();
			delAdultTralis();
		};
		var adultplus = function() {
			adultAdjustView.innerText++;
			getTotalPrice();
			getAdultTraveler();
		};

		var grouptourId = '${pd.grouptour_id}';
		$(function() {
			groupTourInfo.groupTourId=grouptourId;
			$("#grouptour_id").val(grouptourId);
			ticketDetail();
		});

		function ticketDetail() {
			Ajax.request("/wx/grouptour/doconfirmOrder", {
				"data" : {
					"grouptour_id" : grouptourId
				},
				"success" : function(data) {
					if (data.code == 200) {
						try {
							var data = data.data;
							if (data) {
								$("#t_title").html(data.grouptour_name);
								$("#grouptour_price").html(data.grouptour_price);
								$("#childs_price").html(data.childs_price);
								groupTourInfo.user_id=data.user_id;
								adutlprice = data.grouptour_price;
								chrprice = data.childs_price;
								tecketdata(0, 0, adutlprice);
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
		//日期选中事件
		function dateItemOnClick(objthis) {
			if (!$(objthis).hasClass("checked")
					&& !$(objthis).hasClass("disable")) {
				$(objthis).addClass("checked");
				$(objthis).siblings().removeClass("checked");
			}
			var t_day = $(objthis).children("div").eq(0).text();
			var t_price = $(objthis).children("div").eq(1).text();
			t_price = t_price.substring(1, (t_price.length));
			$("#grouptour_price").html(t_price);
			getTotalPrice();
			$(".choose-date").html(
					"选择日期 ： &nbsp;&nbsp;&nbsp;" + nowyear + "-" + nowmonth
							+ "-" + t_day);
			$("#dateSelect").removeClass('active');
			$("#departure_date").val(nowyear + "-" + nowmonth + "-" + t_day);
		}
		Math.formatFloat = function(f, digit) { 
		    var m = Math.pow(10, digit); 
		    return parseInt(f * m, 10) / m; 
		}
		//计算总价
		function getTotalPrice() {
			var adutlprice = parseFloat($("#grouptour_price").html());
			var chrprice = parseFloat($("#childs_price").html());
			var adutnum = parseInt($("#adult_num").html());
			var chrnum = parseInt($("#children_num").html());
			var totalprice = 0.0;
			totalprice+=Math.formatFloat((adutnum * adutlprice) + (chrnum * chrprice), 2);
			$("#ticketTotalPrice").html("￥" + totalprice);
			groupTourInfo.adultPrice=adutlprice;
			groupTourInfo.childrenPrice=chrprice;
			groupTourInfo.orderMoney=totalprice;
		}
		
		//票务日历
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
			if (nowmonth < 10) {
				nowmonth = '0' + nowmonth;
			}
			var daycount = getdate_count(nowyear, nowmonth);

			var onedayWeek = "0123456".split("")[(new Date(nowyear,
					nowmonth - 1, 1)).getDay()]; //获取月份第一天星期
			var html = '';

			if (onedayWeek && daycount) {
				if (nowyear >= date.getFullYear()
						&& nowmonth != (date.getMonth() + 1)) {
					for (var i = 0; i < onedayWeek; i++) {
						html += '<div class="calendar-date-item disable empty_day"></div>';
					}
					for (var j = 0; j < daycount; j++) {
						var day = (j + 1);
						if (day < 10) {
							day = '0' + day;
						}
						html += '<div class="calendar-date-item "  onclick="dateItemOnClick(this)"><div class="date-info">'
								+ day
								+ '</div><div class="price-info">￥'
								+ price
								+ '</div><div class="extra-info">充足</div></div>';
					}
				} else if (nowyear == date.getFullYear()
						&& nowmonth == (date.getMonth() + 1)) {
					if (onedayWeek >= 0) {
						for (var i = 0; i < onedayWeek; i++) {
							html += '<div class="calendar-date-item disable empty_day"></div>';
						}
						for (var j = 0; j < daycount; j++) {
							var day = (j + 1);
							if (day < 10) {
								day = '0' + day;
							}
							if (day < nowday) {
								html += '<div class="calendar-date-item disable"><div class="date-info">'
										+ day
										+ '</div><div class="price-info"></div><div class="extra-info"></div></div>';
							} else if (day == nowday) {
								html += '<div class="calendar-date-item checked" onclick="dateItemOnClick(this)"><div class="date-info">'
										+ day
										+ '</div><div class="price-info">￥'
										+ price
										+ '</div><div class="extra-info">充足</div></div>';
							} else if (day > nowday) {
								html += '<div class="calendar-date-item " onclick="dateItemOnClick(this)"><div class="date-info">'
										+ day
										+ '</div><div class="price-info">￥'
										+ price
										+ '</div><div class="extra-info">充足</div></div>';
							} else {
								html += '<div class="calendar-date-item disable"><div class="date-info">'
										+ day
										+ '</div><div class="price-info"></div><div class="extra-info"></div></div>';
							}
						}
					}
				}
				$(".calendar-date").empty().append(html);
			}
			$("#yearMonth").html(nowyear + "-" + nowmonth);
			/* $(".choose-date").html(
					"选择日期 ： &nbsp;&nbsp;&nbsp;" + nowyear + "-" + nowmonth
							+ "-" + nowday);
			$("#departure_date").val(nowyear + "-" + nowmonth + "-" + nowday); */
		}
		
		//日历点击
		$("#dataLeft").click(
				function() {
					var date = new Date();
					var newMonth = nowmonth;
					if (nowyear > date.getFullYear()
							|| newMonth > (date.getMonth() + 1)) {
						tecketdata(-1, nowmonth, adutlprice);
						if (nowmonth == (date.getMonth() + 1)) {
							$("#dataLeft_Img").attr('src',
									'/img/duyun/icons/arrow_left_cover.png');
						}
					}
				});
		
		//日历点击
		$("#dataRight").click(function() {
			$("#dataLeft_Img").attr('src', '/img/duyun/icons/arrow_left.png');
			tecketdata(1, nowmonth, adutlprice);
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

		//添加成人出行人
		function getAdultTraveler() {
			var travelers = $("#adulttravelerList li").length;
			var adult_num = parseInt($("#adult_num").html());
			var html = '<li class="traveller-item"><div class="item-label" onclick="delTraveler(this)">出行人</div>'
					+ '<div class="item-content"><form class="input-group">'
					+ '<input class="traveller-name checkConName" type="text" placeholder="姓名">'
					+ '<input class="traveller-name checkConPhone" type="number" placeholder="联系电话">'
					+ '<input class="traveller-name checkIdCard" type="text" placeholder="身份证号">'
					+ '</form></div></li>';
			if (adult_num > travelers) {
				$("#adulttravelerList").append(html);
			}
			if (adult_num <= travelers) {
				$("#adult_num").html((travelers + 1));
				$("#adulttravelerList").append(html);
			}
			getTotalPrice();
		}
		
		//添加儿童出行人
		function getChrTraveler() {
			var travelers = $("#childrentravelerList li").length;
			var children_num = parseInt($("#children_num").html());
			var html = '<li class="traveller-item"><div class="item-label" onclick="delchrTraveler(this)">出行人</div>'
					+ '<div class="item-content"><form class="input-group">'
					+ '<input class="traveller-name checkConName" type="text" placeholder="姓名">'
					+ '<input class="traveller-name checkConPhone" type="number" placeholder="联系电话">'
					+ '<input class="traveller-name checkIdCard" type="text" placeholder="身份证号">'
					+ '</form></div></li>';
			if (children_num > travelers) {
				$("#childrentravelerList").append(html);
			}
			if (children_num <= travelers) {
				$("#children_num").html((travelers + 1));
				$("#childrentravelerList").append(html);
			}
			getTotalPrice();
		}

		//修改成人数量时删除出行人（默认删除左后一行）
		function delAdultTralis() {
			var travelers = $("#adulttravelerList li").length;
			$("#adulttravelerList li").eq(travelers - 1).remove();
		}
		//修改儿童数量时删除出行人（默认删除左后一行）
		function delTralis() {
			var travelers = $("#childrentravelerList li").length;
			$("#childrentravelerList li").eq(travelers - 1).remove();
		}
		//删除成人出行人
		function delTraveler(objthis) {
			var travelers = $("#adulttravelerList li").length;
			$(objthis).parent().remove();
			$("#adult_num").html((travelers-1));
			getTotalPrice();
		}
		//删除儿童出行人
		function delchrTraveler(objthis) {
			var travelers = $("#childrentravelerList li").length;
			$(objthis).parent().remove();
			$("#children_num").html((travelers-1));
			getTotalPrice();
		}
		
		//创建订单
		function createOrder() {
			var adult_num = parseInt($("#adult_num").html());
			var children_num = parseInt($("#children_num").html());
			var departure_date = $("#departure_date").val();
			var link_perple = $("#link_perple").val();
			var link_phone = $("#link_phone").val();
			var travelers = $("#travelerList li").length
			if (departure_date == null || departure_date == '') {
				alert("请选择日期")
				return;
			}
			if(adult_num == 0 && children_num == 0){
				alert("请至少选择一个出行人")
				return;
			}
			groupTourInfo.Tourists.length = 0;
			//成人出行人列表
			if (adult_num > 0) {
				var conPersonItems = $("#adulttravelerList li");
				var travelers=conPersonItems.length;
				if (!conPersonItems && adult_num == null || adult_num == ''
						|| adult_num != travelers) {
					alert("成人出行人数量有误")
					if (adult_num > travelers) {
						for (var i = 0; i < (adult_num - travelers); i++) {
							getAdultTraveler();
						}
					}
					return;
				} else {
					//添加联系人信息
					var indexType = 0;
					conPersonItems.each(function(status) {
						var Name = $(this).find(".checkConName").val();
						var Mobile = $(this).find(".checkConPhone").val();
						var IdCardNo = $(this).find(".checkIdCard").val();
						if (Name.isEmpty() || Name.length > 10) {
							alert("第" + (status + 1) + "位成人出行人校验名字出错");
							indexType = 1;
							return false;
						}
						if (Mobile.isEmpty() || !Mobile.isPhone()) {
							alert("第" + (status + 1) + "位成人出行人校验手机出错");
							indexType = 1;
							return false;
						}
						if (IdCardNo.isEmpty() || IdCardNo.length > 18
								|| IdCardNo.length < 16) {
							alert("第" + (status + 1) + "位成人出行人身份证号验证错误");
							indexType = 1;
							return false;
						}
						groupTourInfo.Tourists.push({
							"Name" : Name,
							"Mobile" : Mobile,
							"IdCardNo" : IdCardNo,
							"checkType" : '1'
						});
					});
					if (indexType == 1) {
						return;
					}
				}
			}
			if (children_num > 0) {
				var conPersonItems = $("#childrentravelerList li");
				var travelers=conPersonItems.length;
				if (!conPersonItems && children_num == null || children_num == ''
						|| children_num != travelers) {
					alert("儿童出行人数量有误")
					if (children_num > travelers) {
						for (var i = 0; i < (children_num - travelers); i++) {
							getChrTraveler();
						}
					}
					return;
				} else {
					//添加联系人信息
					var indexType = 0;
					conPersonItems.each(function(status) {
						var Name = $(this).find(".checkConName").val();
						var Mobile = $(this).find(".checkConPhone").val();
						var IdCardNo = $(this).find(".checkIdCard").val();
						if (Name.isEmpty() || Name.length > 10) {
							alert("第" + (status + 1) + "位儿童出行人校验名字出错");
							indexType = 1;
							return false;
						}
						if (Mobile.isEmpty() || !Mobile.isPhone()) {
							alert("第" + (status + 1) + "位儿童出行人校验手机出错");
							indexType = 1;
							return false;
						}
						if (IdCardNo.isEmpty() || IdCardNo.length > 18
								|| IdCardNo.length < 16) {
							alert("第" + (status + 1) + "位儿童出行人身份证号验证错误");
							indexType = 1;
							return false;
						}
						groupTourInfo.Tourists.push({
							"Name" : Name,
							"Mobile" : Mobile,
							"IdCardNo" : IdCardNo,
							"checkType" : '0'
						});
					});
					if (indexType == 1) {
						return;
					}
				}
			}
			if (link_perple.isEmpty() || link_perple.length > 10) {
				alert("联系人出错")
				return;
			}
			if (link_phone.isEmpty() || !link_phone.isPhone()) {
				alert("联系电话出错")
				return;
			}
			groupTourInfo.adultNum = adult_num;
			groupTourInfo.childsNum = children_num;
			groupTourInfo.tourDate=departure_date;
			groupTourInfo.conName=link_perple;
			groupTourInfo.conPhone=link_phone;
			Ajax.request("/logic/grouptour/createOrder",
							{
								"data" : {
									"paramStr" : Base64.encode(JSON
											.stringify(groupTourInfo))
								},
								"success" : function(data) {
									if (data.code == 200) {
										toPayShow(data.data.pay_price,data.data.order_id);
									} else {
										alert(data.msg);
									}
								}
							});
		}
		  var groupTourInfo = {
				  user_id:'',
				  groupTourId:'',//跟团游ID
				  orderMoney:'',//总价
				  adultNum:'',//成人数量
				  adultPrice : '', //成人价格
				  childsNum:'',//儿童数量
				  childrenPrice : '', //儿童价格
				  tourDate:'', //出发日期
				  conName:'',//联系人姓名
				  conPhone:'',//联系人手机
				  Tourists:[]//联系人 checkType 0儿童 1成人
		  }
		
		//微信支付
		  $(function(){
		    	$("#toPay .fixed-bg").click(function(){
		    		$("#toPay").fadeOut();
		    	});
		    	$("#closePayType").click(function(){
					$("#toPay").fadeOut();
					window.location.href='/wx/grouptour/index?resultType=detail&grouptour_id='+'${pd.grouptour_id}';
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
	    		var type=3;
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
	    		   toPay($("#param_money").val(),3,$("#param_order_id").val(),callUrl);
	    		}else if($("#param_pay_type").val() == "1"){ //余额支付
	    			if(!'${withdrawPw}'){
	    				window.location.href="/wx/user/setPayPwPage?type=goodsPaySure";
	    			}else{
	    			    window.location.href="/wx/user/inputPw?type=gpay&order_id="+$("#param_order_id").val()+"&zurl="+callUrl;
	    			}
	    		}
	    	}
	    	
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
	     	 //监听返回按钮
	        GoBackBtn.excuteHistory("/wx/grouptour/index?resultType=detail&redirectType=${pd.redirectType}&grouptour_id="+Request.grouptour_id);
	     	 
	        /*控制日期选择面板  弹出 关闭 */
			function selectDate(){
	        	if($("#dateSelect").hasClass('active')){
	        		$("#dateSelect").removeClass("active");
	        	}else{
	        		$("#dateSelect").addClass('active');
	        	}
			}
	</script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>