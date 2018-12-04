<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<title>购物车</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/home-nav.css" rel="stylesheet" />
<link href="/css/cart.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
<style type="text/css">
.checkedItem, #allCheckedInput {
	-webkit-appearance: none;
	border-radius: 0px;
	border: 0px;
	width: 0px;
	-webkit-tap-highlight-color: transparent;
	outline: none;
	background: none;
	text-decoration: none;
}
</style>
</head>
<body>
	<div class="cart-wrap" style="margin-top: 0rem; margin-bottom: 65px;">
		<div class="bianji-box clearfix f999">
			<a class="r bianji-or-jiesuan" href="javascript:;" code="bianji">编辑</a>
		</div>
		<!--box-list-->
		<c:choose>
			<c:when test="${not empty carSkutList}">
					<c:forEach items="${carSkutList}" var="item" varStatus="status">
						<div class="box-list clearfix">
							<!--checkbox-->
							<div class="check-box l">
								<input name="checkbox" value="${item.cart_id}"
									class="checkedItem" type="checkbox" />
							</div>
							<div class="border-bottom box-img-text"  <c:if test="${status.index eq fn:length(carSkutList)-1}">
							  style="border-bottom: 0px"
							</c:if>    >
								<!--img-->
								<div class="img l"
									onclick="window.location.href='/wx/product/detail?p_id=${item.goods_id}'&pageType=shopCart">
									<img style="height: 80px; width: 80px;"
										src="${SETTINGPD.IMAGEPATH}${item.list_img}" />
								</div>
								<!--text-box-->
								<div class="text-list margin-t12"
									onclick="window.location.href='/wx/product/detail?p_id=${item.goods_id}'&pageType=shopCart">
									<div style="height: 40px; overflow: hidden;">
										<p class="f333">${item.goods_name}</p>
									</div>
									<p class="font-s12 f999"
										<c:if test="${item.attr_json eq '-1'}"> style="visibility:hidden;"</c:if>>
										${item.attr_json}</p>
									<p class="fad8a54 margin-t12">
										￥
										<c:if test="${empty item.attr_json}">${item.shop_price}</c:if>
										<c:if test="${not empty item.attr_json}">${item.sku_price}</c:if>
										<span class="font-s12 f999 jiesuan-show">&nbsp;&nbsp;&nbsp;&nbsp;
											X&nbsp;<span class="f999 goods-number"
											data-price='<c:if test="${empty item.attr_json}">${item.shop_price}</c:if><c:if test="${not empty item.attr_json}">${item.sku_price}</c:if>'>${item.goods_number}</span>
										</span>
									</p>
								</div>
								<div class="num-change bianji-show">
									<em class="jian">-</em> <input type="number"
										value="${item.goods_number}" disabled="disabled" class="num" />
									<em class="add">+</em>
								</div>
							</div>
						</div>
					</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="box-list clearfix">
					<img alt="" src="/img/gouwuchewushuju.png">
				</div>
			</c:otherwise>
		</c:choose>
		<!--box-list-->
		<!--结算-->
		<div class="cart-js" style="bottom: 0rem;">
			<div class="cart-left l">
				<label id="allCheckedLable">全选</label> <input name="checkbox"
					type="checkbox" id="allCheckedInput" />
			</div>
			<div class="cart-right r">
				<div class="yf l jiesuan-show">
				
				    <p>
						运费：<span class="fad8a54">￥<span id="yunfei">0.00</span></span>
					</p>
					<p>
						总计：<span class="fad8a54">￥<span id="totalPrice">0.00</span></span>
					</p>
				<!-- 	<p class="font-s12 text-right f999">不含运费</p> -->
				</div>
				<button class="jiesuan-show"
					onclick="Cart.optDatabase.makeSureOrder();">结算</button>
				<button class="bianji-show"
					onclick="Cart.optDatabase.batchDelCart();">删除</button>
			</div>
		</div>
	</div>
	<!--nav-->
	<%@ include file="common/commJs.jsp"%>
	<script src="/js/page/cart.js"></script>
	<script type="text/javascript">
		$(function() {
			$(".bianji-show").hide();
			Cart.editOrSettle();
			Cart.addOrSub();
			Cart.allChecked();
			$(".checkedItem").click(function() {
				if (!Cart.checkAllItemChecked()) {
					$("#allCheckedInput").removeAttr("checked");
				} else {
					$("#allCheckedInput").prop("checked", true);
				}
				Cart.computeTotalPrice();
			});
		});
		//微信返回按钮的url处理
		/* var backUrl = '';
		if ('${pd.type}' == 'goodsDetail' && '${pd.goods_id}') {
			backUrl = '/wx/goods/detail?goods_id=${pd.goods_id}';
			GoBackBtn.excuteHistory(backUrl);
		} */
		/* pushHistory();
		setTimeout(function () {
		   window.addEventListener("popstate", function(e) {
		      window.location.href='/wx/mall/index';
		   }, false);
		 }, 300);
		 function pushHistory() {
		   var state = {
		     title: "title",
		     url: "#"
		   };
		   window.history.pushState(state, "title", "#");
		 } */
		 //处理返回键 返回问题
		 if('pdetail' == '${pd.redirectType}'){
			 GoBackBtn.excuteHistory("/wx/product/detail?p_id=${pd.p_id}");
		 }else if('userCenter' == '${pd.redirectType}'){
			 GoBackBtn.excuteHistory("/wx/duyun/user/center");
		 }else{
			 GoBackBtn.excuteHistory("/wx/product/home");
		 }
	</script>
</body>
</html>
