<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>商品首页</title>
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
<link rel="stylesheet" href="/css/duyun/spsy.css">
<link rel="stylesheet" href="/css/duyun/swiper.min.css">
</head>
<style>
.content img {
	width: 100%;
}
.activity-message {
    float: right;
    font-size: 14px;
    color: #ff7d13;
    font-size: 12px;
    position: absolute; 
    right: 2px;
    top: -55px;
    text-align:center;
    
}
.activity-message div{
   float: right;
   color: #FFF;
   background: #443b3b;
   width: 22px;
   
}
.activity-message .spetor{
 margin-left:2px;
 margin-right:4px;
 background: #FFF;
 color: #ff7d13;
 width: 8px;
}
.discount-item .discount-title{
    width: 70%;
    height: 20px;
    margin-top: 10px;
    margin-bottom: 10px;
    overflow: hidden;
    color: #777;

}
</style>
<body>
	<div class="content">
		<div class="banner">
			<div style="height: 205px; width: 100%" id="swiper-container"
				class="swiper-container">
				<div class="swiper-wrapper"></div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
		<div class="popular-info">
			<a class="any-more">
				<div class="">人气推荐</div>
				<div class="more" onclick="window.location.href='/wx/product/list'">
					<div>更多</div>
					<img src="/img/duyun/icons/arrow_right.png" alt="" />
				</div>
			</a>
			<div class="slide-box">
				<div class="wrap" style="">
				</div>
			</div>
		</div>
		<div class="discount-info">
			<a class="any-more">
				<div class="">限时折扣</div>
			</a>
			<div class="discount-wrap">
			</div>
		</div>
		<div class="favourite-info">
			<a class="any-more">
				<div class="">猜你喜欢</div>
			</a>
			<div class="favourite-wrap">
			</div>
		</div>
		<!-- 浮动的购物车按钮 -->
		<div id="gouwuche" onclick="window.location.href='/wx/cart/shopCart'"
			style="position: fixed; bottom: 100px; right: 0px; opacity: 0.8;">
			<div style="position: relative;">
				<c:if test="${cartCount ne 0}">
					<span
						class="<c:if test="${cartCount < 10}">font-style-s</c:if> <c:if test="${cartCount >= 10}">font-style-b</c:if>">${cartCount}</span>
				</c:if>
			</div>
			<c:if test="${cartCount eq 0}">
				<img id="gwclogo" style="width: 50px;" alt=""
					src="/img/duyun/icons/gouwuche.png">
			</c:if>
			<c:if test="${cartCount ne 0}">
				<img id="gwclogo" style="width: 50px;" alt=""
					src="<c:if test="${cartCount < 10}">/img/duyun/icons/gouwuches.png</c:if><c:if test="${cartCount >= 10}">/img/duyun/icons/gouwucheb.png</c:if>">
			</c:if>
		</div>
	</div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/swiper.min.js"></script>
<script src="/js/Ajax.js"></script>
<script src="/js/RequestDataForPage.js"></script>
<script type="text/javascript" src="/js/countdown/countDown.js"></script>
<script type="text/javascript">
	//加载事件
	$(function() {
		requestDetail();
	});

	function requestDetail() {
		//请求首页数据
		Ajax.request("/wx/product/doHome",
						{
							"data" : {},
							"success" : function(data) {
								if (data.code == 200) {
									try {
										var data = data.data;
										var prefixImg = data.prefixImg;
										var heatgoods = data.heatgoods;
										var likegoods = data.likegoods;
										var discountgoods = data.discountgoods;
										$(".slide-box").empty();
										$(".favourite-wrap").empty();
										$(".discount-wrap").empty();
										var heathtml = '<div class="wrap" style="" >';
										for (var i = 0; i < heatgoods.length; i++) {
											if (heatgoods[i].goods_name.length > 7) {
												heatgoods[i].goods_name = heatgoods[i].goods_name
														.substring(0, 6)
														+ "...";
											}
											heathtml += '<div class="slide-item" onclick="window.location.href='
													+ "'"
													+ '/wx/product/detail?optType=productHome&p_id='
													+ heatgoods[i].goods_id
													+ ''
													+ "'"
													+ '">'
													+ '<img src="'+prefixImg+heatgoods[i].list_img+'"   alt="">'
													+ '<p>'
													+ heatgoods[i].goods_name
													+ '</p>'
													+ '<div class="price">￥'
													+ heatgoods[i].shop_price
													+ '</div></div>';
										}
										heathtml += '</div>';
										$(".slide-box").append(heathtml);
										var likelength = likegoods.length % 2;
										if (likelength == 1) {
											likegoods.push({});
										}
										for (var j = 0; j < likegoods.length; j++) {
											var likehtmlone, likehtml = '';
											if (likegoods[j].goods_name.length > 10) {
												likegoods[j].goods_name = likegoods[j].goods_name
														.substring(0, 9)
														+ "...";
											}
											likehtmlone = '<div class="favourite-item" onclick="window.location.href='
													+ "'"
													+ '/wx/product/detail?p_id='
													+ likegoods[j].goods_id
													+ ''
													+ "'"
													+ '">'
													+ '<img style="height:162px" src="'+prefixImg+likegoods[j].list_img+'" alt="">'
													+ '<p>'
													+ likegoods[j].goods_name
													+ '</p>'
													+ '<div class="price">￥'
													+ likegoods[j].shop_price
													+ '</div></div>';
											if (JSON
													.stringify(likegoods[j + 1]) != "{}") {
												if (likegoods[j + 1].goods_name.length > 10) {
													likegoods[j + 1].goods_name = likegoods[j + 1].goods_name
															.substring(0, 9)
															+ "...";
												}
												likehtml = '<div class="favourite-item" onclick="window.location.href='
														+ "'"
														+ '/wx/product/detail?p_id='
														+ likegoods[j + 1].goods_id
														+ ''
														+ "'"
														+ '">'
														+ '<img style="height:162px" src="'+prefixImg+likegoods[j+1].list_img+'" alt="">'
														+ '<p>'
														+ likegoods[j + 1].goods_name
														+ '</p>'
														+ '<div class="price">￥'
														+ likegoods[j + 1].shop_price
														+ '</div></div>';
											} else {
												likehtml = '<div class="favourite-item">'
														+ '<img src="" alt="" style="display: none;">'
														+ '<p></p>'
														+ '<div class="price"></div></div>';
											}
											$(".favourite-wrap").append(
													'<div class="row">'
															+ likehtmlone
															+ likehtml
															+ '</div>');
											j++;
										}
										if(discountgoods.length > 0){
											var disHtml = '';
											for (var k = 0; k < discountgoods.length; k++) {
												if (discountgoods[k].goods_name.length > 18) {
													discountgoods[k].goods_name = discountgoods[k].goods_name
															.substring(0, 17)
															+ "...";
												}
												/* onclick="window.location.href='
													+ "'"
													+ '/wx/product/detail?p_id='
													+ discountgoods[k].goods_id
													+ ''
													+ "&proId="
													 	+discountgoods[k].id+
														+ ''
														+ "&stockId="
													 	+discountgoods[k].stock_id+
														+ ''
														+ "'"
													+ '">'
													+ ' */
												disHtml += '<div class="row"><div class="discount-item" onclick="window.location.href='
													+ "'"
													+ '/wx/product/detail?p_id='
													+ discountgoods[k].goods_id
													+ ''
													+ "&proId="
													 	+discountgoods[k].id
														+ ''
														+ "&attrJson="
														+discountgoods[k].attr_json
														+ ''
														+ "&cutDown="
														+discountgoods[k].cutDown
														+ ''
														+ "&price="
														+discountgoods[k].discount_price
														+ ''
														+ "'"
													+ '">'
													+ '<img width="100%" src="'
														+ prefixImg
														+ discountgoods[k].list_img
														+ '"   alt="">'
														+ '<div class="discount-title">'+discountgoods[k].goods_name+'<br>'+discountgoods[k].attr_json+'</div>'
														+ '<div class="" style="color: #777;margin-bottom: 7px;text-decoration:line-through">原价：￥'
														+ discountgoods[k].goods_price
														+ '</div>'
														+ '<div class="price" style="position: relative;">折扣价格：￥'
														+ discountgoods[k].discount_price
														+ '<div class="activity-message" data-cutDown="'+discountgoods[k].cutDown+'">'
														+ '<div class="spetor">秒</div><div class="second">00</div><div class="spetor">分</div><div class="minute">00</div><div   class="spetor">时</div><div class="hour">00</div></div>'
														+ '<span style="width: 97px;" onclick="gobuy('+discountgoods[k].goods_id+','+discountgoods[k].stock_id+','+discountgoods[k].min_num+','+discountgoods[k].discount_price+','+discountgoods[k].id+')">立即抢购</span></div></div></div>';
											}
											$(".discount-wrap").append(disHtml);
											//执行定时器
											excuCutDown();
										}else{
											$(".discount-info").hide();
										}
									} catch (e) {
									}
								}
							}
						});
		//请求广告数据
		Ajax.request("/wx/advert/selectadvertlist",
						{
							"data" : {
								"ad_apid" : "8069"
							},
							"success" : function(data) {
								if (data.code == 200) {
									try {
										var data = data.data;
										var prefixImg = data.prefixImg;
										var datalist = data.datalist;
										if (datalist && datalist.length > 0) {
											for (var i = 1; i < datalist.length; i++) {
												$("#swiper-container")
														.children()
														.eq(0)
														.append(
																'<div class="swiper-slide" onclick="goTolink('
																		+ datalist[i].ad_type
																		+ ","
																		+ datalist[i].ad_relation_type
																		+ ","
																		+ datalist[i].ad_relation_id
																		+ ","
																		+ datalist[i].ad_url
																		+ ')"><img src="'+prefixImg+datalist[i].ad_display+'" alt=""/></div>');
											}
											var mySwiper = new Swiper(
													'#swiper-container',
													{
														autoplay : 5000,//可选选项，自动滑动
														pagination : '.swiper-pagination'
													});
										}
									} catch (e) {
									}
								}
							}
						});
	}
	// adType 广告类型  adRtype 内部关联类型  adRId 内部关联ID adUrl 外部链接
	function goTolink(adType, adRtype, adRId, adUrl) {
		if (adType == 0) {
			//1特产 2门票 3线路 4景点
			if (adRtype == 1) {
				window.location.href = '/wx/product/detail?p_id=' + adRId;
			} else if (adRtype == 2) {
				window.location.href = '/wx/ticket/index?redirectType=detail&t_id='
						+ adRId;
			} else if (adRtype == 3) {
				window.location.href = '/wx/grouptour/index?resultType=detail&grouptour_id='
						+ adRId;
			} else if (adRtype == 4) {
				window.location.href = '/wx/scenic/detail?id=' + adRId;
			}
		} else if (adType == 1) {
			//外部广告链接跳转
			window.location.href = adUrl;
		}
	}
	//首页返回按钮监听  默认关闭微信浏览器页面
	GoBackBtn.excuteHistory('close');
 function excuCutDown(){
	 $(".activity-message").each(function(){
		 var tempCountDown = new CountDown(parseInt($(this).attr("data-cutDown")));
		 tempCountDown.calCount(this);
    });
 }
 //提交订单
 function gobuy(goodsId,skuId,goodsNum,price,porId){
	   /*  if(!'${user.phone}'){
		   window.location.href="/wx/duyun/user/bingphone?bingType=goodsDetail&goods_id=${pd.p_id}";
		   return;
	   }  */ 
		window.location.href = "/wx/order/makeSureOrderByDisCount?goods_id="+goodsId+"&sku_id="+skuId+"&goodsNum="+goodsNum+"&price="+price+"&pro_id="+porId+"&addtype=1";
 }
</script>
</html>