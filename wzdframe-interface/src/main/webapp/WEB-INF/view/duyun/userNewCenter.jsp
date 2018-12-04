<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>个人中心</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/wode.css" rel="stylesheet" />
<!-- <link href="/css/duyun/grzx.css" rel="stylesheet" /> -->
<script src="/js/shipei.js"></script>
<style type="text/css">
.floatImg {
	position: absolute;
	top: -5px;
	right: 27px;
	background-color: #47616e;
	color: #fff;
	width: 16px;
	height: 16px;
	border-radius: 50%;
	font-size: 11px;
}
.lg_weblogin_btn {
	display: inline-block;
	width: 118px;
	font-size: 14px;
	margin-right: 6px;
	padding: 3px 0;
	text-align: center;
	color: #E78003;
	border: 1px solid #FF9001;
	background-color: #FFF;
	border-radius: 3px;
	box-shadow: 0 1px 0 rgba(213, 213, 213, 0.8);
	text-decoration: none;
}
.title h2 {
    font-size: 16px;
    font-weight: 500;
}
</style>
<script src="/js/shipei.js"></script>
</head>
<body>
	<!--头像-->
	<div class="photo-bg">
		<!--头像-->
		<div class="toux" onclick="window.location.href='/wx/duyun/user/setting'">
			<center>
				<div
					style="width: 75px; height: 75px; border-radius: 50px; overflow: hidden;" onclick="">
					<img class="headImg" style="width: 76px; height: 75px;"
						src="${empty user.headimgurl?'/img/wechat-photo.jpg':user.headimgurl}" />
				</div>
			</center>
			<p class="f333 margin-t12" style="margin-top: 10px; font-size: 14px;">${empty user.nick_name?'未知昵称':user.nick_name}</p>
			<p style="margin-top: 10px; font-size: 14px;">
				<c:if test="${empty user.phone}">
						 <a href="/wx/duyun/user/bingphone?bingType=userCenter" class="lg_weblogin_btn" id="clogin">点击绑定手机号</a>
				</c:if>
				<c:if test="${not empty user.phone}">
					<a   class="lg_weblogin_btn" >${user.phone}</a>
				</c:if>
			</p>
		</div>
		<!--积分-->
		<%-- <div class="tx-text f47616e">
				<ul>
					<li onclick="window.location.href='/wx/user/pointsDetail'">
						<p>${(empty data || empty data.user_points) ? '-': data.user_points}</p>
						<p>积分</p>
					</li>
					<li onclick="window.location.href='/wx/user/walletPage'">
						<p>￥${(empty data || empty data.user_money) ? '-': data.user_money}</p>
						<p>余额</p>
					</li>
					<li onclick="sub()">
						<p>-</p>
						<p>优惠券</p>
					<!-- </li>
						<li onclick="javascript:alert('请下载国士风app体验更多功能');">
						<p>-</p>
						<p>优惠券</p>
					</li> -->
				</ul>
			</div> --%>
	</div>
	<!--我的订单-->
	<div class="wo-wrap">
	 	<div class="title border-bottom"
			onclick="window.location.href='/wx/order/myOrder?order_status='">
			<a>
				<h2>全部订单</h2><i class="icon-right"></i>
			</a>
		</div> 
		<ul class="flex-list f666">
			<li
				onclick='window.location.href="/wx/order/myOrder?order_status=&type="'
				style="position: relative"><i class="icon icon_dp"></i>
				<p>全部订单</p></li>
			<li
				onclick='window.location.href="/wx/order/myOrder?order_status=0&type=0"'
				style="position: relative"><i class="icon icon_dfk"
				id="waitingRecive"></i>
				<p>待付款</p></li>
			<li
				onclick='window.location.href="/wx/order/myOrder?order_status=3&type=3"'
				style="position: relative"><i class="icon icon_dfh"
				id="waitingSend"></i>
				<p>待发货</p></li>
			<li
				onclick='window.location.href="/wx/order/myOrder?order_status=6&type=6"'
				style="position: relative"><i class="icon icon_dpl"
				id="waitingComment"></i>
				<p>待评论</p></li>
			<!-- <li onclick='window.location.href="/wx/order/myOrder?order_status=0&type=6"' style="position:relative">
					<i class="icon icon_thk"></i>
					<p>退换货</p>
				</li> -->
		</ul>
	</div>
	<!--图标列表-->
	<div class="wo-wrap margin-t20 icon-list">
		<ul class="flex-list f666">
			<li onclick="window.location.href='/wx/cart/shopCart?redirectType=userCenter'" style="padding-bottom:8px;">
					<i class="icon icon_kc"></i>
					<p>购物车</p>
				</li>
			<li
				onclick="window.location.href='/wx/ticket/index?redirectType=orderList'"
				style="padding-bottom: 8px;">
				<i class="icon icon_kc"></i>
				<p>门票订单</p>
			</li>
			<li
				onclick="window.location.href='/wx/grouptour/index?resultType=orderList'"
				style="padding-bottom: 8px;">
				<i class="icon icon_kc"></i>
				<p>跟团订单</p>
			</li>
			<li onclick="window.location.href='/wx/guider/bookOrder'"
				style="padding-bottom: 8px;">
				<i class="icon icon_kc"></i>
				<p>导游订单</p>
			</li>
			<li onclick="window.location.href='/wx/duyun/user/collections'"
				style="padding-bottom: 8px;"><i
				class="icon icon_sc"></i>
				<p>我的收藏</p></li>
			<!-- 	<li onclick="window.location.href='/wx/user/followTeacher'" style="padding-bottom:8px;padding-top:10px;">
					<i class="icon icon_gz"></i>
					<p>我的关注</p>
				</li>
				<li onclick="window.location.href='/wx/course/cdplist'" style="padding-bottom:8px;padding-top:10px;">
					<i class="icon icon_dp"></i>
					<p>点评</p>
				</li>
				<li onclick="window.location.href='/wx/user/setting'" style="padding-bottom:8px;padding-top:10px;">
					<i class="icon icon_sz"></i>
					<p>设置</p>
				</li> -->
		</ul>
	</div>
</body>
<%@ include file="common/commJs.jsp"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		if (!'${user.phone}') {
			$(".flex-list").children()
					.attr("onclick",
							"window.location.href='/wx/duyun/user/bingphone?bingType=userCenter'");
			$(".border-bottom")
			         .attr("onclick",
			                  "window.location.href='/wx/duyun/user/bingphone?bingType=userCenter'");
		}
	});
	 GoBackBtn.excuteHistory("close");
</script>
</html>