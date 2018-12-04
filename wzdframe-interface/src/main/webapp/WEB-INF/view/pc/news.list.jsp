<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
       <meta name="keywords" content="${SEO.seo_value}">
    <meta name="description" content="${SEO.seo_description}">
   <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/real.news.css" type="text/css">
    <style type="text/css">
          .hot-recommend{
             margin-top: 17px;
             margin-bottom: 23px;
		     border-bottom: 1px solid #cdcdcd;
		     width: 100%;
		     height: 50px;
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
            <div class="col-md-2 service-0 " style="cursor: pointer;" onclick="window.location.href='/guide/list'">
                旅游攻略
            </div>
            <div class="col-md-2 service-1 active " style="cursor: pointer;" onclick="window.location.href='/content/list'">
                实时资讯
            </div>
            <div class="col-md-2 service-2 " style="cursor: pointer;" onclick="onBook(2);">
                旅游资讯
            </div>
        </div>
    </div>
</div>
<div class="row good-news-container">
    <div class="col-md-9 col news-left">
        <div id="news-carousel" class=" carousel slide news-carousel-container"
             data-ride="carousel">
            <ol class="carousel-indicators ticket-indicators">
                <c:forEach  items="${topContent}" var="top" varStatus="status">
                   <li data-target="#news-carousel" data-slide-to="${status.index}" <c:if test="${status.index eq 0}"> class="active" </c:if>></li>
               </c:forEach> 
            </ol>
            <div class="carousel-inner news-carousel" role="listbox">
               <c:forEach items="${topContent}" var="item" varStatus="status"> 
	                <div onclick="javascript:window.open('/content/detail?CONTENT_ID=${item.CONTENT_ID}');" class="carousel-item <c:if test='${status.index eq 1}'>active</c:if>" style="cursor: pointer;">
	                    <img src="${SETTINGPD.IMAGEPATH}${item.T_IMG}" onError="javascript:this.src='/img/no-img/no-img.jpg';" class="news-carousel-img" alt="First slide">
	                    <ul class="news-carousel-info">
	                        <li>
	                            <h4>${item.TITLE}</h4>
	                        </li>
	                        <li>
	                            <h5>${item.PUTTIME}</h5>
	                        </li>
	                    </ul>
	                </div>
                </c:forEach>
            </div>
            <a class="carousel-control-prev" href="#news-carousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#news-carousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <div class="news-info">
            <div class="news-header">
                最新资讯
            </div>
        </div>
        <c:forEach items="${page.resultPd}" var="item">
	        <div class="row news-item" onclick="javascript:window.open('/content/detail?CONTENT_ID=${item.CONTENT_ID}');" style="cursor: pointer;">
	            <div class="col-md-5 col news-item-left">
	                <img src="${SETTINGPD.IMAGEPATH}${item.T_IMG}" onError="javascript:this.src='/img/no-img/no-img.jpg';" class="news-img" alt="">
	            </div>
	            <div class="col-md-7 col news-item-right">
	                <p class="right-one">
	                     ${item.TITLE}
	                </p>
	                <p class="right-two">
	                    ${item.PUTTIME}
	                </p>
	                <p class="right-three">
	                      ${item.ABSTRACT}
	                </p>
	            </div>
	        </div>
        </c:forEach>
        <div class="row route-footer-content">
		    ${page.pageStr}
		</div>
    </div>
   <div class="col-md-3 content-right" >
           
           <div id="storeSelete">
             </div>    
              <div class="relative-recommend">
            <div class="relative-header">
                攻略推荐
            </div>
            <ul class="relative-ul" id="glrecommend">
            </ul>
        </div>           
   </div>
    
    <!-- <div class="col-md-3 col news-right" >
        <div class="hot-news">热销特产</div>
        <div id="newGoodsRecommend">
		        <div class="middle-container">
		            <img src="/img/duyun/pc/router.png" class="middle-img" alt="">
		            <div class="middle-hover">
		                <p class="hover-p">
		                    都匀毛尖茶喜获中国特色旅游商品大赛"金奖"
		                </p>
		            </div>
		        </div>
		        <div class="middle-container">
		            <img src="/img/duyun/pc/router.png" class="middle-img" alt="">
		            <div class="middle-hover">
		                <p class="hover-p">
		                    都匀毛尖茶喜获中国特色旅游商品大赛"金奖"
		                </p>
		            </div>
		        </div>
		        <div class="middle-container">
		            <img src="/img/duyun/pc/router.png" class="middle-img" alt="">
		            <div class="middle-hover">
		                <p class="hover-p">
		                    都匀毛尖茶喜获中国特色旅游商品大赛"金奖"
		                </p>
		            </div>
		        </div>
        </div>
    </div> -->
</div>
<%@ include file="common/footer.jsp"%>
</body>
	<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
	<script type="text/javascript">
	var fiexdImg = '${SETTINGPD.IMAGEPATH}';
	    $(function(){
	    	requestNewsGoods(); 
	    	requestRaiders();
	    });
	    function requestNewsGoods(){
	  	  $("#newGoodsRecommend").empty();
	  	  var htmlAry = [];
	  	  Ajax.request("/logic/product/newRecommend",{"data":{"limit":'4'},"success":function(data){
	  		  if(data.code == 200){
	  			  var data = data.data;
	  			$("#storeSelete").empty();
	  			 $("#storeSelete").append(' <div class="row"><div class="hot-recommend">人气推荐</div> </div>');
	  			  for(var i = 0 ; i < data.length ; i++){
    				  htmlAry.push('<div class="row hot-recommend-list" style="cursor:pointer;" onclick="goGoodsDetail('+data[i].goods_id+')"><div class="hot-recommend-image"> <img src="'+fiexdImg+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="">');
    				  htmlAry.push('</div><div class="hot-recommend-content"><p class="content-one"><span class="travel-info-text">'+data[i].goods_name+'</span>');
    				/*    if(data[i].goods_tags){
    					   var goodsTags = data[i].goods_tags.split(",");
    				       htmlAry.push('<span class="baoyou">'+goodsTags[0]+'</span>');
    				   } */
    				  htmlAry.push(' </p><p class="content-two"><span class="amount">¥'+data[i].shop_price+'</span><strike>¥'+data[i].market_price+'</strike>');
    				  htmlAry.push(' <span class="buy-span-two">'+data[i].virtual_sales+'人购买</span></p></div></div>');
    			  }
	  			  
	  			 $("#storeSelete").append(htmlAry.join(''));
	  		  }
	  	  }});
	  }
	    function requestRaiders(){
	   	 Ajax.request("/logic/raidersList",{"data":{"limit":4},"success":function(data){
	   			if(data.code == 200){
	   				var data = data.data;
	   				$("#glrecommend").empty();
	   				var htmlAry = [];
	   				for(var i = 0 ; i < data.length ; i++){
	   					htmlAry.push(' <li class="relative-li" onclick="goLineDetail('+data[i].id+')">'+data[i].line_name+'</li>');
	   				}
	   				$("#glrecommend").append(htmlAry.join(''));
	   			}else{
	   			}
	   	 }});
	    }
	    function goGoodsDetail(goodsId){
	  	  var paramObj = {
	  			  goodsId:goodsId
	  	  }
	  	  window.location.href='/product/detail?paramStr='+Base64.encode(JSON.stringify(paramObj));
	  }
	  function goLineDetail(line_id){
		  window.open("/guide/detail?line_id="+line_id);
	  }  
	</script>
</html>