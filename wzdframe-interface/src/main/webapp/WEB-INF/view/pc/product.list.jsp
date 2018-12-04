<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="keywords" content="${SEO.seo_value}">
<meta name="description" content="${SEO.seo_description}">
<link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">

<link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/css/duyun/pc/good.list.css">
<link rel="stylesheet" href="/js/swiper/idangerous.swiper.css">
<style type="text/css">
.list-hover {
	display: none;
}

.hover-text {
	height: 18px;
	overflow: hidden;
}
</style>
<title>${SEO.seo_web_title}</title>
</head>
<body>
	<%@ include file="common/navi.jsp"%>
	<%@ include file="common/ercode.jsp"%>
	<div class="row service-nav">
		<div class="col-md-6"></div>
		<div class="col-md-6">
			<div class="row service-nav-right">
				<div style="cursor: pointer;" class="col-md-2 service-0 active"
					onclick="window.location.href='/product/list'">都匀特产</div>
				<div style="cursor: pointer;" class="col-md-2 service-1 "
					onclick="window.location.href='/store/list'">都匀店铺</div>
				<div style="cursor: pointer;" class="col-md-2 service-2"
					onclick="window.location.href='/scenic/list'">都匀景点</div>
			</div>
		</div>
	</div>
	<!-- <div style="width: 1200px; margin: auto"  class="list-img-container">
    <img style="width: 1200px;" src="/img/duyun/pc/ad/ad_1.jpg" class="list-img" alt="">
</div> -->
	<!-- <div class="swiper-container" style="width: 1200px; margin: auto">
  <div class="swiper-wrapper">
      <div class="swiper-slide"> 
         <img  src="/img/duyun/pc/ad/ad_1.jpg" class="list-img" alt="">
      </div>
      <div class="swiper-slide"><img  src="/img/xiangp_list01.png" class="list-img" alt=""> </div>
      <div class="swiper-slide"> <img  src="/img/xiangp_list02.png" class="list-img" alt=""></div>
  </div>
</div> -->
	<div id="carousel-example-generic" style="margin-top: 1px;"
		class="carousel slide home-" data-ride="carousel">
		<ol class="carousel-indicators">
			<c:forEach items="${ads}" var="item" varStatus="status">
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
			</c:forEach>
		</ol>
		<div class="carousel-inner" role="listbox">
			<c:forEach items="${ads}" var="item" varStatus="status">
				<div
					class="carousel-item <c:if test="${status.index == 0}">active</c:if>">
					<ul class="carousel-item-info" style="bottom: 30px; left: 830px;">
						<li>
							<h4>${item.ad_title}</h4>
						</li>
						<li>
							<h5>${item.ad_desc}</h5>
						</li>
						<li>
							<button type="button" class="btn btn-secondary"
								onclick="goTolink('${item.ad_type}','${item.ad_relation_type}','${item.ad_relation_id}','${item.ad_url}');">查看详情</button>
						</li>
					</ul>
					<img src="${SETTINGPD.IMAGEPATH}${item.ad_display}"
						style="width: 1200px;" class="carousel-img" alt="Third slide">
				</div>
			</c:forEach>
		</div>
	</div>
	<div class=" travel-content">
		<div>
			<div class="ticket-header">
				<span class="service-color-text">都匀特色</span> <span
					class="service-text">/</span> <span class="service-text">都匀特产</span>
			</div>
			<div class="row comprehensive-content ">
				<div class="col-md-9 content-left">
					<div class="row sale-row">
						<div style="cursor: pointer;"
							class="comprehensive-sequence <c:if test='${empty pd.order_type || pd.order_type eq "multiple"}'>active</c:if>"
							data-code="multiple">综合排序</div>
						<div style="cursor: pointer;"
							class="route-sale <c:if test='${pd.order_type eq "sale_num"}'>comprehensive-sequence active</c:if>"
							data-code="sale_num">销量优先</div>
						<div style="cursor: pointer;"
							class="route-price <c:if test='${pd.order_type eq "price_order"}'>comprehensive-sequence active</c:if>"
							data-code="price_order">价格</div>
					</div>
					<c:forEach begin="0" end="${page.currentSize}" var="ll">
						<div class="row router-list">
							<c:forEach items="${page.resultPd}" begin="${ll*3}"
								end="${ll*3+2}" var="item" varStatus="status">
								<div style="cursor: pointer;"
									class="col-md-4 router-list-item active"
									onclick="goGoodsDetail('${item.goods_id}')">
									<div class="image-hover">
										<img src="${SETTINGPD.IMAGEPATH}${item.list_img}" alt=""
											onError="javascript:this.src='/img/no-img/no-img.jpg';"
											alt="">
										<c:if test="${not empty item.goods_summary}">
											<div class="list-hover">
												<div class="hover-text">${item.goods_summary}</div>
											</div>
										</c:if>
									</div>
									<div class="good-list-content">
										<div style="height: 27px; overflow: hidden"
											class="list-info-text">${item.goods_name}</div>
										<c:if test="${not empty item.goods_tags}">
											<c:forEach items="${fn:split(item.goods_tags,',')}"
												var="lable">
												<span class="good-recommend">${lable}</span>
											</c:forEach>
										</c:if>
										<p class="list-text-detail">
											<span class="amount">¥${item.shop_price}</span> <strike>¥${item.market_price}</strike>
											<span class="buy-span">${empty item.virtual_sales?0:item.virtual_sales}人购买</span>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
				<div class="col-md-3 content-right" id="storeSelete"></div>
			</div>
		</div>
	</div>
	<div class="row route-footer-content">
		<div class="col-md-9 ">${page.pageStr}</div>
		<div class="col-md-3"></div>
	</div>
	<div class="good-hot">
		<div class="remen-header">热门商品</div>
		<div class="row remen-content" id="newGoodsRecommend"></div>
	</div>
	<%@ include file="common/footer.jsp"%>
	<script src="/js/jquery.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
	<script src="/js/swiper/idangerous.swiper.min.js"
		type="text/javascript"></script>
	<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
	<script type="text/javascript" src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/duyun/pc/redirectJ.js"></script>
</body>
<script type="text/javascript">
	var fiexdImg = '${SETTINGPD.IMAGEPATH}';
	$(function() {
		$(".router-list-item").hover(function() {
			$(this).find(".list-hover").show();
		}, function() {
			$(this).find(".list-hover").hide();
		});
		$(".sale-row").children().click(function() {
			var data_code = $(this).attr("data-code");
			var url = "/product/list?currentPage=1&order_type=" + data_code;
			window.location.href = url;
		});
		requestRecommend();
		requestNewsGoods();
		var mySwiper = new Swiper('.swiper-container', {
			loop : true,
			mode : 'horizontal'
		//其他设置
		});
	});
	//请求人气推荐
	function requestRecommend() {
		$("#storeSelect").empty();
		var htmlAry = [];
		$("#storeSelete")
				.append(
						' <div class="row"><div class="hot-recommend">人气推荐</div> </div>');
		Ajax
				.request(
						"/logic/product/recommend",
						{
							"data" : {
								"limit" : '${page.currentSize+1}'
							},
							"success" : function(data) {
								if (data.code == 200) {
									var data = data.data;
									for (var i = 0; i < data.length; i++) {
										htmlAry
												.push('<div class="row hot-recommend-list" style="cursor:pointer;" onclick="goGoodsDetail('
														+ data[i].goods_id
														+ ')"><div class="hot-recommend-image"> <img src="'+fiexdImg+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="">');
										htmlAry
												.push('</div><div class="hot-recommend-content"><p class="content-one"><span class="travel-info-text">'
														+ data[i].goods_name
														+ '</span>');
										if (data[i].goods_tags) {
											var goodsTags = data[i].goods_tags
													.split(",");
											htmlAry
													.push('<span class="baoyou">'
															+ goodsTags[0]
															+ '</span>');
										}
										htmlAry
												.push(' </p><p class="content-two"><span class="amount">¥'
														+ data[i].shop_price
														+ '</span><strike>¥'
														+ data[i].market_price
														+ '</strike>');
										htmlAry
												.push(' <span class="buy-span-two">'
														+ data[i].virtual_sales
														+ '人购买</span></p></div></div>');
									}
									$("#storeSelete").append(htmlAry.join(''));
								}
							}
						});
	}
	//请求新品推荐
	function requestNewsGoods() {
		$("#newGoodsRecommend").empty();
		var htmlAry = [];
		Ajax
				.request(
						"/logic/product/newRecommend",
						{
							"data" : {
								"limit" : '4'
							},
							"success" : function(data) {
								if (data.code == 200) {
									var data = data.data;
									for (var i = 0; i < data.length; i++) {
										htmlAry
												.push('<div style="cursor:pointer;" onclick="goGoodsDetail('
														+ data[i].goods_id
														+ ')" class="col-md-4 hot-list-item "><div class="image-hover">');
										htmlAry
												.push('<img src="'+fiexdImg+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"  alt=""></div>');
										htmlAry
												.push('<div class="good-list-content"><p><span class="list-info-text">'
														+ data[i].goods_name
														+ '</span>');
										if (data[i].goods_tags) {
											var goodsTags = data[i].goods_tags
													.split(",");
											htmlAry
													.push('<span class="good-recommend">'
															+ goodsTags[0]
															+ '</span>');
										}
										htmlAry
												.push('<p class="list-text-detail"><span class="amount">¥'
														+ data[i].shop_price
														+ '</span>');
										htmlAry
												.push('<strike>¥'
														+ data[i].market_price
														+ '</strike><span class="buy-span">'
														+ data[i].virtual_sales
														+ '人购买</span></p></div></div>');
									}
									$("#newGoodsRecommend").append(
											htmlAry.join(''));
								}
							}
						});
	}

	// adType 广告类型  adRtype 内部关联类型  adRId 内部关联ID adUrl 外部链接
	function goTolink(adType, adRtype, adRId, adUrl) {
		if (adType == 0) {
			//1特产 2门票 3线路 4景点
			if (adRtype == 1) {
				goGoodsDetail(adRId);
				//window.location.href='/wx/product/detail?p_id='+adRId;
			} else if (adRtype == 2) {
				goTicketDetail(adRId);
				//window.location.href='/wx/ticket/index?redirectType=detail&t_id='+adRId;
			} else if (adRtype == 3) {
				goTravelDetail(adRId);
				//	window.location.href='/wx/grouptour/index?resultType=detail&grouptour_id='+adRId;
			} else if (adRtype == 4) {
				goScenicDetail(adRId);
				//window.location.href='/wx/scenic/detail?id='+adRId;
			}
		} else if (adType == 1) {
			//外部广告链接跳转
			window.location.href = adUrl;
		}
	}
</script>


</html>