<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>路线详情</title>
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
<link rel="stylesheet" href="/css/duyun/lxxq.css">

<style type="text/css">
.prodetail img {
	width: 100% !important;
}
</style>
</head>

<body>
	<!--底部导航栏-->
	<footer class="bar bar-tab">
		<div class="toolbar" style="display: table-row;">
			<a
				style="color: #666; display: table-cell; height: 48px; vertical-align: middle; text-align: center; position: relative;"
				class="bar-item custom" style="color: #666;" href="tel:13631705905"><div>客服</div></a>
			<!-- <span class="bar-item custom" style="">客服</span>
             <span class="bar-item collect" style="">收藏</span> -->
			<span class="bar-item btn-buy">立即预定</span>
		</div>
	</footer>

	<!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
	<div class="content">
		<!--产品详情顶部图片-->
		<img class="pro-img" src="/img/duyun/lxxq/1.jpg" />
		<!--产品简介-->
		<div class="pro-bref">
			<div class="pro-title proTitle"></div>
			<p class="pro-intro"></p>
			<div class="pro-price">
				<span><span class="unit"></span></span> <span class=""></span>
			</div>
		</div>
		<!-- 
        <a class="pro-choose" href="#specificationPage">
            <div class="">选择：套餐类型/日期/人数</div>
            <img src="/img/duyun/icons/arrow_right.png" alt=""/>
        </a> -->
		<div class="detail">
			<!--tab-->
			<div class="segmented-control">
				<a class="control-item active" onclick="selectDate('feature');" href="javascript:;">产品介绍 </a>
				<a class="control-item" onclick="selectDate('route');" href="javascript:;">行程安排 </a> 
				<a class="control-item" onclick="selectDate('expense-explain');" href="javascript:;"> 费用说明 </a>
				<a class="control-item" onclick="selectDate('predetermine');" href="javascript:;"> 预订须知</a>
			</div>
			<!--产品介绍-->
			<div class="prodetail">
				<div id="feature" class="feature pro-detail active">
					<div class="pro-title">产品特色</div>
				</div>
				<div id="route" class="route pro-detail noactive">
					<div class="pro-title">行程安排</div>
				</div>
				<div id="expense-explain"
					class="expense-explain pro-detail noactive">
					<div class="pro-title">费用说明</div>
				</div>
				<div id="predetermine"
					class="predetermine pro-detail noactive">
					<div class="pro-title">预订须知</div>

				</div>
			</div>
		</div>
		<div class="spinner">
			<div class="loading"></div>
		</div>
	</div>
	<!--产品规格选择-->
	<div id="specificationPage" class="modal">
		<header class="bar bar-nav">
			<a class="icon icon-close pull-right" href="#specificationPage"></a>
			<h1 class="title">都均毛尖茶</h1>
			<div class="pro-img"></div>
		</header>

		<!--底部导航栏-->
		<footer class="bar bar-tab order-bar">
			<div class="toolbar">
				<span class="bar-item total-price">
					<div>￥961</div>
					<div>订单总价</div>
				</span> <span class="bar-item btn-buy">提交订单</span>
			</div>
		</footer>
		<div class="content">
			<div class="spec">
				<div class="spec-title padding-left-5">规格</div>
				<ul class="spec-list padding-left-5">
					<li>礼盒包装</li>
					<li>礼盒包装</li>
					<li>礼盒包装</li>
					<li>礼盒包装</li>
					<li>礼盒包装</li>
					<li>礼盒包装</li>
				</ul>
				<div class="pro-num">
					<div class="num-label">数量</div>
					<div class="num-adjust">
						<div class="adjust-minus" onclick="minus()">
							<img src="/img/duyun/icons/minus.png" alt="" />
						</div>
						<div class="adjust-view">1</div>
						<div class="adjust-plus" onclick="plus()">
							<img src="/img/duyun/icons/plus.png" alt="" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/swiper.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script type="text/javascript">
		function UrlSearch() {
			var name, value;
			var str = location.href; //取得整个地址栏
			var num = str.indexOf("?")
			str = str.substr(num + 1); //取得所有参数   stringvar.substr(start [, length ]

			var arr = str.split("&"); //各个参数放到数组里
			for (var i = 0; i < arr.length; i++) {
				num = arr[i].indexOf("=");
				if (num > 0) {
					name = arr[i].substring(0, num);
					value = arr[i].substr(num + 1);
					this[name] = value;
				}
			}
		}

		//加载事件
		$(function() {
			requestDetail();
		});
		var loadingPanel = document.querySelector('.spinner');
		var showDetailInfo = function() {
			var toggleBtn = document.querySelector('.btn-wrap img');
			var proContent = document.querySelector('.pro-content');
			if (toggleBtn) {
				if (proContent.classList.contains('hidden')) {
					proContent.classList.remove('hidden');
					toggleBtn.setAttribute('src',
							'/img/duyun/icons/arrow_up.png');
				} else {
					proContent.classList.add('hidden');
					toggleBtn.setAttribute('src',
							'/img/duyun/icons/arrow_down.png');
				}
			}
		};
		var adjustView = document.querySelector('.adjust-view');

		var minus = function() {
			adjustView.innerText = adjustView.innerText - 1 > 0 ? adjustView.innerText - 1
					: 1;
		};

		var plus = function() {
			adjustView.innerText++;
		};
		//请求商品详情数据
		function requestDetail() {
			Ajax.request("/wx/grouptour/dodetail",
							{"data" : {"grouptour_id" : '${pd.grouptour_id}'},
								"success" : function(data) {
									if (data.code == 200) {
										try {
											var detaildata = data.data;
											if (detaildata) {
												$(".pro-img").attr("src",detaildata.grouptour_img);
												$(".proTitle").html(detaildata.grouptour_name);
												$(".pro-intro").text(detaildata.grouptour_sketch);
												var html = '<span>¥ '
														+ detaildata.grouptour_price
														+ ' <span class="unit">起/人</span></span><span class="">'
														+ detaildata.grouptour_sales
														+ '人付款</span>';
												$(".pro-price").html(html);
												$(".feature").append(detaildata.grouptour_character);
												$(".route").append(detaildata.grouptour_trip);
												$(".expense-explain").append(detaildata.grouptour_statement);
												$(".predetermine").append(detaildata.grouptour_attention);
												selectDate('feature');
											}
										} catch (e) {
											loadingPanel.style.display = 'none';
										}
									}
									loadingPanel.style.display = 'none';
								}
							});
		}
		$(".btn-buy").on("click",function() {
			/*  if(!'${user.phone}'){
				var Request=new UrlSearch(); 
				window.location.href="/wx/duyun/user/bingphone?redirectType=${pd.redirectType}&bingType=grouptour&grouptour_id="+Request.grouptour_id;
				return;
			 }  */
			window.location.href = '/wx/grouptour/index?resultType=confirmOrder&redirectType=${pd.redirectType}&grouptour_id='+${pd.grouptour_id};
		});
		//控制返回按钮
		if ("content" == '${pd.redirectType}') {
			GoBackBtn.excuteHistory("/wx/content/list");
		} else if ("homeDetail" == '${pd.redirectType}') {
			GoBackBtn.excuteHistory("/wx/home");
		} else {
			GoBackBtn.excuteHistory("/wx/grouptour/index?resultType=list&redirectType=${pd.redirectType}");
		}

		/*控制内容选择面板   */
		function selectDate(type) {
			if (type == "feature") {
				$(".feature").addClass("active");
				$(".feature").removeClass("noactive");
				$(".route").removeClass("active");
				$(".expense-explain").removeClass("active");
				$(".predetermine").removeClass("active");
				$(".route").addClass("noactive");
				$(".expense-explain").addClass("noactive");
				$(".predetermine").addClass("noactive");
			} else if (type == "route") {
				$(".feature").removeClass("active");
				$(".feature").addClass("noactive");
				$(".route").addClass("active");
				$(".route").removeClass("noactive");
				$(".expense-explain").removeClass("active");
				$(".predetermine").removeClass("active");
				$(".expense-explain").addClass("noactive");
				$(".predetermine").addClass("noactive");
			} else if (type == "expense-explain") {
				$(".feature").removeClass("active");
				$(".route").removeClass("active");
				$(".predetermine").removeClass("active");
				$(".expense-explain").removeClass("noactive");
				$(".feature").addClass("noactive");
				$(".route").addClass("noactive");
				$(".expense-explain").addClass("active");
				$(".predetermine").addClass("noactive");
				
			} else if (type == "predetermine") {
				$(".feature").removeClass("active");
				$(".route").removeClass("active");
				$(".expense-explain").removeClass("active");
				$(".predetermine").removeClass("noactive");
				$(".feature").addClass("noactive");
				$(".route").addClass("noactive");
				$(".expense-explain").addClass("noactive");
				$(".predetermine").addClass("active");
			}
		}
	</script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>