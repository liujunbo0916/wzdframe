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

<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <!--产品详情顶部图片-->
        <img class="banner" src="/img/duyun/djtcdxq/1.jpg" />
        <!--产品简介-->
        <div class="pro-big-title">
            <div class="pro-wrap">
                <div class="pro-title">都匀毛尖茶叶特产店</div>
                <div class="pro-mark">
                    <span>茶叶</span>
                </div>
            </div>
            <div class="pro-map">地图搜寻</div>
        </div>
        <div class="pro-bref">
            <div class="header">店铺简介</div>
            <p id="bs_introduction">市里最有名的毛尖茶欢迎游人来，总之是个好地方，可以来看看</p>
            <div class="address">
                <span>地址：</span>
            </div>
            <div class="phone">
                <span>电话：</span>
            </div>
            <div class="time">
                <span>营业时间：</span>
                9:00-12:00,14:00-17:00
            </div>
        </div>
        <div class="products">
            <a class="products-more">
                <div class="">店铺商品</div>
                <div class="more" onclick="goodsMore()">
                    <div>更多</div>
                    <img src="/img/duyun/icons/arrow_right.png" alt=""/>
                </div> 
            </a>
            <ul class="table-view">
                <li class="table-view-cell media">
                    <a class="navigate-right">
                        <img class="hot" src="/img/duyun/icons/hot.png" alt=""/>
                        <img class="media-object pull-left" src="/img/duyun/djtcdxq/1.jpg"/>
                        <div class="media-body">
                            <div class="title-name">
                               	 都匀毛尖茶
                                <div class="recomment">特别推荐</div>
                            </div>
                            <p><i class="rating-star-50"></i><span class="score">5.0</span></p>
                            <p class="moods">230人付款</p>
                            <div class="price">¥ 200.00</div>
                        </div>
                    </a>
                </li>
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
	var storeId='${pd.storeId}';
	var param={
			storeId:storeId,
	}
	$(function(){
		 loadmore(param);
	});
	function loadmore(param){
		$(".table-view").empty();
		loadingPanel.style.display = 'flex';
		responseData.sendRequest("/wx/store/doDetail", param, callBack);
	}
	
	var recommend = '<div class="recomment">特别推荐</div>';
	var hot = '<img class="hot" src="/img/duyun/dstc/hot.png" alt="">';
	var tpl = '<li onclick="window.location.href='+"'"+'/wx/product/detail?p_id={{8}}&pageType=store&storeId={{9}}'+"'"+'" class="table-view-cell media"><a class="navigate-right">{{0}}'+
	          ' <img class="media-object pull-left" src="{{1}}"/><div class="media-body"> <div class="title-name">'+
	          '{{2}}{{3}}</div><p><i class="{{4}}"></i><span class="score">{{5}}</span></p>'+
	          '<p class="moods">{{6}}人付款</p><div class="price">¥ {{7}}</div></div></a></li>';
	//自定义渲染函数
	function callBack(data) {
		var dataAry = [];
		if(data){
			$(".banner").attr("src",data.PrefixImg+data.bs_banner);
			$(".pro-title").html(data.bs_name);
			$("#bs_introduction").html(data.bs_introduction);
			$(".address").append(data.bs_address);
			$(".phone").append(data.bs_phone); 
			var tabs=[];
			tabs=data.bs_tabs.split(",");
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
			if(data.goodList.length > 0){
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
					dataAry[9] = storeId;
					$(".table-view").append(responseData.buildFtl(tpl,dataAry));
					dataAry.length = 0; //清空数组
				}
			}else{
				$(".table-view").empty();
				$(".more").hide();
				$(".load-more").hide();
			}
		}
	}
	
	function goodsMore(){
		window.location.href='/wx/product/list?storeId='+storeId;
	}
	GoBackBtn.excuteHistory("/wx/store/index?resultType=list");
    </script>
</body>
</html>