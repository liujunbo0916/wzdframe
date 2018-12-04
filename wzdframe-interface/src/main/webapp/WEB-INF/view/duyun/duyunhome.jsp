<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>首页</title>
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
<link rel="stylesheet" href="/css/duyun/front.css">
</head>
<style>
</style>
<body>
	<!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
	<div class="content">
		<div class="banner-wrap">
			<img class="banner" src="/img/duyun/sy/1.jpg" alt="" />
		</div>
		<div class="nav-info">
			<div class="row">
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/guide.png"
						onclick="window.location.href='/wx/line/selfHelp?pageType=home'" alt="">
					<div>电子导游</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/flight.png"
						onclick="window.location.href='http://flights.ctrip.com'"
						alt="">
					<div>机票预订</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/hotel.png"
						onclick="window.location.href='/wx/hotel/hotellist?pageType=home'" alt="">
					<div>酒店预订</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/tickets.png"
						onclick="window.location.href='/wx/ticket/index?redirectType=list&pageType=home'"
						alt="">
					<div>景点门票</div>
				</div>
			</div>

			<div class="row">
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/route.png"
						onclick="window.location.href='/wx/grouptour/index?redirectType=home&resultType=list'"
						alt="">
					<div>旅游路线</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/tour_tips.png"
						onclick="window.location.href='/wx/line/index?pageType==home'" alt="">
					<div>都匀攻略</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/tourist_attraction.png"
						onclick="window.location.href='/wx/scenic/index?category_id=2&pageType=home'"
						alt="">
					<div>景区景点</div>
				</div>
				<div class="nav-item">
					<img src="/img/duyun/icons/homePage/food.png"
						onclick="window.location.href='/wx/scenic/index?category_id=3&pageType=home'"
						alt="">
					<div>餐饮美食</div>
				</div>
			</div>
		</div>
		<div class="new-info">
			<a class="any-more">
				<div class="">实时资讯</div>
				<div class="more" onclick="window.location.href='/wx/content/list?CTYPE=0&pageType=home'">
					<div>更多</div>
					<img src="/img/duyun/icons/arrow_right.png" alt="" />
				</div>
			</a>
			<div class="travel-follow" id="newslist">
					<div class="follow-item">
						<div class="content-left">
							<img src="/img/duyun/sy/2.jpg" alt="" />
						</div>
						<div class="content-right">
							<div class="news-title"></div>
							<div class="follow-operations">
								<span class="follow-num"></span> <span class="reply-num"></span>
							</div>
						</div>
					</div>
			</div>
		</div>
		<div class="travel-info">
			<a class="any-more">
				<div class="">旅游资讯</div>
				<div class="more" onclick="window.location.href='/wx/content/list?CTYPE=1&pageType=home'">
					<div>更多</div>
					<img src="/img/duyun/icons/arrow_right.png" alt="" />
				</div>
			</a>
			<div class="travel-follow tourism">
				<div class="follow-item">
					<div class="content-left">
						<div class="news-title"></div>
						<div class="follow-operations">
							<span class="follow-num"></span> <span class="reply-num"></span>
						</div>
					</div>
					<div class="content-right">
						<img src="/img/duyun/sy/3.jpg" alt="" />
					</div>
				</div>
			</div>
			<div class="attractions">
				<div class="attraction-item">
					<img width="180px" height="77px" src="/img/duyun/sy/4.jpg" alt="">
					<div>高原桥城及文峰塔</div>
				</div>
				<div class="attraction-item">
					<img src="/img/duyun/sy/5.jpg" alt="">
					<div>都匀夏日游记</div>
				</div>
				<div class="attraction-item">
					<img src="/img/duyun/sy/6.jpg" alt="">
					<div>都匀-记忆里的风景</div>
				</div>
			</div>
		</div>
		<div class="favourite">
			<a class="any-more">
				<div class="">猜你喜欢</div>
				<!-- <div class="more">
					<div>更多</div>
					<img src="/img/duyun/icons/arrow_right.png" alt="" />
				</div> -->
			</a>
			<div class="favourite-wrap">
				<div class="favourite-item">
					<div class="img-wrap">
						<span class="tag">自由行</span> <img src="/img/duyun/sy/7.jpg" alt="" />
					</div>
					<div class="item-title">都匀2-5日自由行·都匀斗篷山（不含机票）</div>
					<div class="price">¥ 316/人</div>
				</div>
				<div class="favourite-item">
					<div class="img-wrap">
						<span class="tag">跟团游</span> <img src="/img/duyun/sy/8.jpg" alt="" />
					</div>
					<div class="item-title">都匀2-5日自由行·都匀斗篷山（不含机票）</div>
					<div class="price">¥ 316/人</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/swiper.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript">
	//加载事件
	$(function() {
		requestDetailList();
	});
	//请求商品详情数据
	function requestDetailList() {
		Ajax.request("/wx/home/doDetail", {
			"data" : {},
			"success" : function(data) {
				if (data.code == 200) {
					try {
						var data = data.data;
					    if(data){
					    	var imgsec=data.prefixImg;
					    	//实时资讯
					    	var newshtml='';
					    	for (var i = 0; i < data.news.length; i++) {
					    		if(data.news[i].TITLE.length > 17){
					    			data.news[i].TITLE=data.news[i].TITLE.substring(0,16)+"...";
				    			}
					    		newshtml+='<div class="follow-item" onclick="doContextDetail('+data.news[i].CONTENT_ID+')"><div class="content-left" ><img src="'+imgsec+data.news[i].T_IMG+'" alt="" /></div>'
										  +'<div class="content-right" style="height:72px;position: relative;"><div class="news-title">'+data.news[i].TITLE+'</div><div class="follow-operations" style="position: absolute;bottom:1px;">'
										  +'<span class="follow-num">'+data.news[i].thumbsups+'</span> <span class="reply-num">'+data.news[i].comments+'</span></div></div></div>';
							}
					    	 $("#newslist").empty().append(newshtml);
					    	//旅游资讯
					    	var tourshtml='';
					    	var tourshtmls='';
					    	for (var j = 0; j < data.tourism.length; j++) {
					    		if(j==0){
					    			tourshtml+='<div class="follow-item" onclick='+'doGroupTourDetail("'+data.tourism[j].SUBJECT_CODE+'","'+data.tourism[j].SUBJECT_ID+'")'+'><div class="content-left" style="height: 126px;position: relative;">'
					    				+'<div class="news-title">'+data.tourism[j].TITLE+'</div>'
					    				+'<div class="follow-operations" style="position: absolute;bottom: 0px;"><span class="follow-num">'+data.tourism[j].thumbsups+'</span> <span class="reply-num">'+data.tourism[j].comments+'</span>'
					    				+'</div></div><div class="content-right"><img src="'+imgsec+data.tourism[j].T_IMG+'" alt="" /></div></div>';
					    		}else{
					    			if(data.tourism[j].TITLE.length > 10 && data.tourism.length > 2){
					    				data.tourism[j].TITLE=data.tourism[j].TITLE.substring(0,9)+"...";
					    			}
					    			tourshtmls+='<div class="attraction-item" onclick='+'doGroupTourDetail("'+data.tourism[j].SUBJECT_CODE+'","'+data.tourism[j].SUBJECT_ID+'")'+'><img src="'+imgsec+data.tourism[j].T_IMG+'" alt=""><div>'+data.tourism[j].TITLE+'</div></div>';
					    		}
							}
					    	$(".tourism").empty().append(tourshtml);
					    	$(".attractions").empty().append(tourshtmls);
					    	//猜你喜欢
					    	var grouptourhtml='';
					    	for (var k = 0; k < data.grouptour.length; k++) {
					    			grouptourhtml+='<div class="favourite-item" onclick='+'doGroupTourDetail(1,"'+data.grouptour[k].grouptour_id+'")'+'><div class="img-wrap">'
					    				+'<span class="tag">跟团游</span> <img src="'+imgsec+data.grouptour[k].grouptour_img+'" alt="" /></div>'
					    				+'<div class="item-title">'+data.grouptour[k].grouptour_name+'</div>'
					    				+'<div class="price">¥ '+data.grouptour[k].grouptour_price+'/人</div></div>';
							}
					    	$(".favourite-wrap").empty().append(grouptourhtml);
					    }
					} catch (e) {
					}
				}
			}
		});
	}
	function doGroupTourDetail(type,groupId){
		if(type==1){//跟团游
			window.location.href='/wx/grouptour/index?resultType=detail&redirectType=homeDetail&grouptour_id='+groupId;
		}else if(type==2){//景点门票
			window.location.href='/wx/ticket/index?pageType=homeDetail&redirectType=detail&t_id='+groupId;
		}
	}
	function doContextDetail(contentId){
		window.location.href = '/wx/content/dodetail?pageType=homeDetail&CONTENT_ID='
			+ contentId;
	}
	 GoBackBtn.excuteHistory("close");
</script>
</html>