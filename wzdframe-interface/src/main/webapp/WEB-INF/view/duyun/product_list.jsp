<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>都匀特产</title>
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
    <link rel="stylesheet" href="/css/duyun/dstc.css">
    <style type="text/css">
      .content > .table-view:first-child{
         margin-top: 0px;
      }
    </style>
</head>
<body>
 <!-- <nav class="bar bar-standard bar-header-secondary">
        <div class="segmented-control">
            <a class="control-item active" data-code="all">
                综合
            </a>
            <a class="control-item" data-code="virtual_sales">
                销量
            </a>
            <a class="control-item sort-price" data-code="shop_price">
                价格
                <img src="/img/duyun/icons/price_sort.png" alt="">
            </a>
            <a class="control-item sort-by" data-code="category_id" onclick="openMenu()">
                分类
                <img src="/img/duyun/icons/sort.png" alt="">
            </a>
        </div>
    </nav> -->
    
        <nav class="bar bar-standard bar-header-secondary">
        <div class="segmented-control">
            <a class="control-item active" data-code="all">
                综合
            </a>
            <a class="control-item" data-code="virtual_sales">
                销量
            </a>
            <a class="control-item sort-price second" data-code="shop_price">
                价格
                <!--<img src="img/icons/price_sort.png" alt="">-->
            </a>
            <a class="control-item sort-by" data-code="category_id" onclick="openMenu()">
                分类
                <!--<img src="img/icons/sort.png" alt="">-->
            </a>
        </div>
    </nav>
    
    
    <div class="content">
        <ul class="table-view" id="productList">
           <!--  
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <img class="media-object pull-left" src="/img/duyun/dstc/6.jpg"/>
                    <div class="media-body">
                        <div class="title-name">墨冲角角鱼</div>
                        <p><i class="rating-star-40"></i><span class="score">4.0</span></p>
                        <p class="moods">230人付款</p>
                        <div class="price">¥ 78.00</div>
                    </div>
                </a>
            </li> -->
        </ul>
        <div class="load-more">
            <button class="btn btn-block" id="loadMoreBtn">加载更多</button>
        </div>
          <!-- 浮动的购物车按钮 -->
	     <div id="gouwuche" onclick="window.location.href='/wx/cart/shopCart'" style="position:fixed;bottom:100px;right: 0px;opacity:0.8;">
	         <div style="position: relative;">
	           <c:if test="${cartCount ne 0}">
	                <span class="<c:if test="${cartCount < 10}">font-style-s</c:if> <c:if test="${cartCount >= 10}">font-style-b</c:if>">${cartCount}</span>
	           </c:if>
	        </div> 
	        <img id="gwclogo" style="width: 50px;" alt="" src="<c:if test="${empty cartCount || cartCount eq 0}">/img/duyun/icons/gouwuche.png</c:if><c:if test="${cartCount ne 0}"><c:if test="${cartCount < 10}">/img/duyun/icons/gouwuches.png</c:if><c:if test="${cartCount >= 10}">/img/duyun/icons/gouwucheb.png</c:if></c:if>">
	     </div>
    </div>
     <!--产品规格选择-->
    <div id="menuPage" class="modal">
        <div class="content">
            <ul class="table-view" id="categorylist">
            </ul>
        </div>
    </div>
    <!--设定预加载效果-->
    <div class="spinner">
        <div class="loading">
            <img src="/img/duyun/dstc/loading.gif" alt=""/>
        </div>
    </div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script src="/js/InheritString.js"></script>
<script src="/js/RequestDataForPage.js"></script>
<script type="text/javascript">
    var loadingPanel = document.querySelector('.spinner');
    var loadingMore = document.querySelector('.load-more');
    
    var openMenu = function () {
        var menu = document.getElementById('menuPage');
        showMenu(menu);
    };

    // 隐藏modal
    var closeMenu = function () {
        var menu = document.getElementById('menuPage');
        hiddenMenu(menu);
    };
    // 显示modal
    var showMenu = function (popNode) {
        flag = 1;
        var sortBy = document.querySelector('.sort-by');
        if(sortBy.classList.contains('active')){
            sortBy.childNodes[1].src = '/img/duyun/icons/sort_checked.png'
        }else {
            sortBy.childNodes[1].src = '/img/duyun/icons/sort.png'
        }
        sortBy.removeAttribute('onclick');

        var menu = popNode || document.getElementById('popNode');
        var backdrop = document.createElement('div');
        backdrop.classList.add('backdrop');
        backdrop.addEventListener('touchend', function () {
            hiddenMenu(menu);
        });
        menu.parentNode.appendChild(backdrop);
        menu.classList.add('active');
    };

    // 隐藏modal
    var hiddenMenu = function (popNode) {
        flag = 0;
        var sortBy = document.querySelector('.sort-by');
        sortBy.setAttribute('onclick', 'openMenu()');

        var menu = popNode || document.getElementById('popNode');
        var backdrop = document.querySelector('.backdrop');
        menu.parentNode.removeChild(backdrop);
        menu.classList.remove('active');
    };
    document.addEventListener('touchmove', function (event) {
        if(flag === 1){
            event.preventDefault();
        }
    },false);
    
    var condition = {
			currentPage : "1",
			storeId:'${pd.storeId}',
			is_virtual_sales:'',
			is_shop_price:'0',
			category_id:''
		}
    $(function(){
    	$("#productList").empty();
    	loadMore(condition);
    	$(".control-item").click(function() {
			var datacode = $(this).attr("data-code");
			if(datacode!='category_id'){
				if(datacode=='all'){
					condition.is_virtual_sales='';
					condition.is_shop_price='';
					category_id='';
				}else if(datacode=='virtual_sales'){
					condition.is_virtual_sales=1;
					condition.is_shop_price='';
				}else if(datacode=='shop_price'){
					condition.is_virtual_sales='';
					if(condition.is_shop_price == 1){
						condition.is_shop_price=0;
						$(this).addClass("second");
					}else{
						$(this).removeClass("second");
						condition.is_shop_price=1;
					}
				}
				condition.currentPage = 1;
				$("#productList").empty()
				loadMore(condition);
				closeMenu();
			}
		});
		$(".load-more").click(function() {
			delete condition.currentPage;
			loadMore(condition);
		});
    });
	function loadMore(condition) {
	    loadingPanel.style.display = 'flex';
	    responseData.sendRequest("/wx/product/doList",condition,callBack);
	    loadingPanel.style.display = 'none';
	}
	var recommend = '<div class="recomment">特别推荐</div>';
	var hot = '<img class="hot" src="/img/duyun/dstc/hot.png" alt="">';
	var tpl = '<li onclick="window.location.href='+"'"+'/wx/product/detail?optType=productList&p_id={{8}}'+"'"+'" class="table-view-cell media"><a class="" >{{0}}'+
	          ' <img class="media-object pull-left" src="{{1}}"/><div class="media-body"> <div class="title-name">'+
	          '{{2}}{{3}}</div><p><i class="{{4}}"></i><span class="score">{{5}}</span></p>'+
	          '<p class="moods" style="margin-top: 15px;">{{6}}人付款</p><div class="price">¥ {{7}}</div></div></a></li>';
	          
	//自定义渲染函数
	function callBack(data){
		var dataAry = [];
		var prefixImg = data.prefixImg;
		var categorydata=data.otherPd;
		var data = data.resultPd;
		for(var i = 0 ; i < data.length ; i++){
			//热门。人气推荐
			if(data[i].is_popular==1){
				dataAry[0] = hot;
			}else{
				dataAry[0] = '';
			}
			if(data[i].list_img.startWith('http:')){
				dataAry[1] =data[i].list_img;
			}else{
				dataAry[1] = prefixImg+data[i].list_img;
			}
			dataAry[2] = data[i].goods_name;
			if(dataAry[2].length > 26){
				dataAry[2] = dataAry[2].substring(0,25);
			}
			//特别推荐
			if(data[i].is_special==1){
				dataAry[3] = recommend;
				dataAry[4] = 'rating-star-50';
			}else{
				dataAry[3] = '';
				if(data[i].is_recommend && data[i].is_recommend > 100){
					dataAry[4] = 'rating-star-50';
				}else if(data[i].is_recommend && data[i].is_recommend > 1){
					dataAry[4] = 'rating-star-40';
				}else{
					dataAry[4] = 'rating-star-30';
				}
			}
			dataAry[5] = '';
			dataAry[6] = data[i].virtual_sales;
			dataAry[7] = data[i].shop_price;
			dataAry[8] = data[i].goods_id;
			$("#productList").append(responseData.buildFtl(tpl,dataAry));
			dataAry.length = 0; //清空数组
		}
		if($("#categorylist li").length == 0){
			if(categorydata && categorydata.length > 0){
				if(condition.category_id){
					$("#categorylist").empty().append('<li class="table-view-cell" onclick="categroyClick(this)"> 全部 </li>');
				}else{
					$("#categorylist").empty().append('<li class="table-view-cell active" onclick="categroyClick(this)"> 全部 </li>');
				}
				for (var j = 0; j < categorydata.length; j++) {
					if(categorydata[j].category_id==condition.category_id){
						$("#categorylist").append('<li class="table-view-cell active" onclick="categroyClick(this,'+categorydata[j].category_id+')">'+categorydata[j].category_name+'</li>');
					}else{
						$("#categorylist").append('<li class="table-view-cell" onclick="categroyClick(this,'+categorydata[j].category_id+')">'+categorydata[j].category_name+'</li>');
					}
				}
			}
		}
	}
	
	function categroyClick(thisObj,category_id){
		condition.category_id=category_id;
		condition.currentPage = 1;
		$("#productList").empty()
		$(thisObj).addClass("active");
		$(thisObj).siblings().removeClass("active");
		loadMore(condition);
		closeMenu();
	}
	//返回键控制  列表只有返回商城首页
	 GoBackBtn.excuteHistory("/wx/product/home");
</script>
</html>