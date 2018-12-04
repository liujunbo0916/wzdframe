<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
   	<title>都匀特产店详情</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/djtcdxq.css">
</head>
<style>
.bar-tab {
    bottom: 0;
    display: table;
    width: 100%;
    height: 50px;
    padding: 0;
    table-layout: fixed;
    border-top: 1px solid #ddd;
    border-bottom: 0;
}
.bar {
    position: fixed;
    right: 0;
    left: 0;
    z-index: 10;
    height: 44px;
    background-color: white;
    border-bottom: 1px solid #ddd;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
}
.bar-tab .toolbar .bar-item {
    font-size: 10px;
    color: #666;
}
.bar-tab .toolbar .custom:before {
  background-image: url(/img/duyun/icons/phone.png);
}
.bar-tab .toolbar .collect, .bar-tab .toolbar .custom {
  width: 66px;
  border-right: 1px solid #ddd;
}
.bar-tab .toolbar .collect:before, .bar-tab .toolbar .custom:before {
  content: '';
  display: block;
  margin: 4px auto 2px;
  width: 18px;
  height: 18px;
  background-repeat: no-repeat;
  background-size: 18px auto;
}
.bar-tab .toolbar .add-cart {
    background: #ff7d13;
    color: #fff;
    font-size: 18px;
}
.bar-tab .toolbar span {
    display: table-cell;
    height: 48px;
    vertical-align: middle;
    text-align: center;
    position: relative;
}
.content .pro-big-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #FFF;
    padding: 15px;
    color: #999;
}
.content .pro-big-title .boxa .pro-wrap .pro-title {
    color: #454553;
    font-size: 18px;
    margin-bottom: 0px;
    margin-top: 10px;
}
.content .pro-big-title .boxa .pro-wrap .pro-nicktitle {
    font-size: 14px;
}

.boxa{ margin:0 auto; width:100%;} 
.boxa-l{ float:left;} 
.boxa-r{ float:left; margin-left: 10px;} 

.content .pro-in {
    padding: 10px 15px 1px 15px;
    font-size: 14px;
    color: #666;
    line-height: 14px;
    background: #FFF;
    margin-top: 1px;
}
.content .pro-in > div {
    margin-bottom: 10px;
    line-height: 15px;
}
</style>
<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <!--产品详情顶部图片-->
        <img class="banner" src="/img/duyun/djtcdxq/1.jpg" />
        <!--产品简介-->
        <div class="pro-big-title">
            <div class="boxa" style="width: 100%;">
	            <div class="boxa-l" style="width: 85px; height: 85px; border-radius: 50px; overflow: hidden;">
					<img class="headImg" style="width: 85px; height: 85px;" src="/img/wechat-photo.jpg">
				</div>
				<div class="pro-wrap boxa-r">
				  <div class="pro-title"></div>
				  <div class="pro-nicktitle">昵称：</div>
	                <div class="pro-mark">
	                    <span></span>
	                </div>
	            </div>
			</div>
            <!-- <div class="pro-wrap">
			 <div class="pro-title"></div>
			  <div class="pro-nicktitle">昵称：</div>
                <div class="pro-mark">
                    <span></span>
                </div>
            </div> -->
        </div>
         <div class="pro-in">
            <div class="time">
                <span>宣传语：</span>
            </div>
            <div class="address">
                <span>带团次数：</span>
            </div>
            <div class="phone">
                <span>价格：￥</span>
            </div>
             <div class="lvs">
                <span>旅行社：</span>
            </div>
        </div>
        <div class="pro-bref">
            <div class="header">导游简介</div>
            <p id="bs_introduction"></p>
        </div>
        <footer class="bar bar-tab footer-bar" style="z-index:100">
        <div class="toolbar" style="display: table-row;">
            <a style="color: #666;display: table-cell;height: 48px;vertical-align: middle;text-align: center;position: relative;"  class="bar-item custom" style="color: #666;" href="tel:13631705905"><div>客服</div></a>
            <span class="bar-item add-cart">立即预约</span>
        </div>
   		</footer>
        <div class="products">
            <a class="products-more" style="margin-bottom: 50px">
                <div class="">导游评论</div>
                <div class="more" onclick="goodsMore()">
                    <div>更多</div>
                    <img src="/img/duyun/icons/arrow_right.png" alt=""/>
                </div> 
            </a>
            <ul class="table-view">
            </ul>
        </div>
    </div>
    <!--设定预加载效果-->
    <div class="spinner">
        <div class="loading">
            <img src="/img/duyun/dstc/loading.gif" alt=""/>
        </div>
    </div>
    <script src="/vendors/ratchet/js/ratchet.js"></script>
    <script src="/js/InheritString.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script src="/js/RequestDataForPage.js"></script>
    <script type="text/javascript">
    var loadingPanel = document.querySelector('.spinner');
	var guiderId='${pd.guiderId}';
	var param={
			guiderId:guiderId,
	}
	$(function(){
		 loadmore(param);
	});
	function loadmore(param){
		$(".table-view").empty();
		loadingPanel.style.display = 'flex';
		responseData.sendRequest("/wx/guider/doDetail", param, callBack);
	}
	
	var recommend = '<div class="recomment">特别推荐</div>';
	var hot = '<img class="hot" src="/img/duyun/dstc/hot.png" alt="">';
	var tpl = '<li onclick="window.location.href='+"'"+'/wx/product/detail?p_id={{8}}&pageType=store&guiderId={{9}}'+"'"+'" class="table-view-cell media"><a class="navigate-right">{{0}}'+
	          ' <img class="media-object pull-left" src="{{1}}"/><div class="media-body"> <div class="title-name">'+
	          '{{2}}{{3}}</div><p><i class="{{4}}"></i><span class="score">{{5}}</span></p>'+
	          '<p class="moods">{{6}}人付款</p><div class="price">¥ {{7}}</div></div></a></li>';
	//自定义渲染函数
	function callBack(data) {
		var dataAry = [];
		if(data){
			if(data.guider_bglogo){
				$(".banner").attr("src",data.PrefixImg+data.guider_bglogo);
			}
			if(data.guider_logo){
				$(".headImg").attr("src",data.PrefixImg+data.guider_logo);
			}
			$(".pro-title").html(data.guider_name);
			if(data.guider_nickname){
				$(".pro-nicktitle").html("昵称："+data.guider_nickname); 
			}else{
				$(".pro-nicktitle").html("无昵称"); 
			}
			if(data.guider_nickname){
				$(".lvs").html("旅行社："+data.agency_show_name); 
			}else{
				$(".lvs").html("旅行社：无"); 
			}
			$("#bs_introduction").html(data.guider_desc);
			$(".address").append(data.guider_service_num);
			$(".time").append(data.guider_propaganda);
			if(data.guider_price){
				$(".phone").append(data.guider_price+" /天"); 
			}else{
				$(".phone").append(0.0+" /天"); 
			}
			var tabs=[];
			tabs=data.guider_lable.split(";");
			var html='';
			if(tabs!=null && tabs!=''){
				for (var j = 0; j < tabs.length; j++) {
					html+='<span>'+tabs[j]+'</span>';
				}
			}
			$(".pro-mark").html(html); 
			if(!html){
				$(".pro-mark").hide();
			}
			/* if(data.goodList.length > 0){
				for(var i = 0 ; i < data.goodList.length ; i++){
					//热门。人气推荐
					if(data.goodList[i].is_popular==1){
						dataAry[0] = hot;
					}else{
						dataAry[0] = '';
					}
					if(data.goodList[i].list_img.startWith('http:')){
						dataAry[1] =data.goodList[i].list_img;
					}else{
						dataAry[1] = data.PrefixImg+data.goodList[i].list_img;
					}
					dataAry[2] = data.goodList[i].goods_name;
					//特别推荐
					if(data.goodList[i].is_special==1){
						dataAry[3] = recommend;
					}else{
						dataAry[3] = '';
					}
					dataAry[4] = 'rating-star-50';
					dataAry[5] = '5.0';
					dataAry[6] = data.goodList[i].virtual_sales;
					dataAry[7] = data.goodList[i].shop_price;
					dataAry[8] = data.goodList[i].goods_id;
					dataAry[9] = guiderId;
					$(".table-view").append(responseData.buildFtl(tpl,dataAry));
					dataAry.length = 0; //清空数组
				}
			}else{
				$(".table-view").empty();
				$(".more").hide();
				$(".load-more").hide();
			} */
		}
	}
	$(".add-cart").on("click",function(){
		window.location.href='/wx/guider/guideServiceOrder?guiderId='+guiderId;
	});
    </script>
</body>
</html>