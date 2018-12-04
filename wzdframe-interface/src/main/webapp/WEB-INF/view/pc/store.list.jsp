<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="keywords" content="${SEO.seo_value}">
    <meta name="description" content="${SEO.seo_description}">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/store.list.css" type="text/css">
     <title>${SEO.seo_web_title}</title>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
           <div style="cursor: pointer;" class="col-md-2 service-0 " onclick="window.location.href='/product/list';">
               都匀特产
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1 active" onclick="onBook(1);">
                都匀店铺
            </div>
            <div style="cursor: pointer;" onclick="window.location.href='/scenic/list'" class="col-md-2 service-2" onclick="onBook(2);">
                都匀景点
            </div>
        </div>
    </div>
</div>
<div class="travel-strategy-content">
    <div class="sure-header">
        <span class="my-order">都匀特色</span>
        <span class="order-line">/</span>
        <span class="order-text">都匀店铺</span>
    </div>
    <div class="row travel-strategy">
        <div class="col-md-9 col left-store">
            <div class="left-header">
                综合排序
            </div>
           <c:set var="dataModelLength" value="${fn:length(dataModel)}"></c:set> 
          <c:forEach items="${dataModel}" var="item">  
            <div class="row strategy-item">
                <div class="col-md-3 item-left">
                    <img src="${SETTINGPD.IMAGEPATH} ${item.storeImg}" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
                    <p>共${fn:length(item.goodsList)}件商品</p>
                </div>
                <div class="col-md-9 item-right">
                    <div class="row right-content">
                        <div class="col-md-5 col col-one">
                            <p class="right-one">
                               ${item.storeName}
                            </p>
                            <p class="right-two">
                               <span> 主营：</span>
                                <span> ${item.mainsale}</span>
                            </p>
                            <p class="right-three">
                                <span>地址：</span>
                                <span>${item.address}</span>
                            </p>
                            <p class="right-four" style="cursor: pointer;" onclick="goStoreDetail('${item.storeId}');">
                                进店逛逛 >
                            </p>
                        </div>
                        <div class="col-md-7 col col-two">
                            <div class="row liebiao">
                              <c:catch var="CatchNullPointerException">  
	                               <c:forEach items="${item.goodsList}" begin="0" end="2" var="goods">
		                                <div style="cursor: pointer;" onclick="goGoodsDetail('${goods.goodsId}')" class="col-md-3 col liebiao-item">
		                                    <img src="${SETTINGPD.IMAGEPATH}${goods.goodsImg}" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
		                                    <div style="    height: 23.64px; overflow: hidden;">
		                                                                                      ${goods.goodsName}
		                                    </div>
		                                    <p>
		                                        ¥ ${goods.goodsPrice}
		                                    </p>
		                                </div>
	                               </c:forEach> 
                               </c:catch>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           </c:forEach> 
        </div>
        <div class="col-md-3 col right-store" id="storeSelete">
        </div>
    </div>
</div>
<div class="row route-footer-content">
    <div class="col-md-9 col left-store">
      ${page.pageStr}
    </div>
    <div class="col-md-3 col"></div>
</div>

<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
</body>

   <script type="text/javascript">
      var fiexdImg = '${SETTINGPD.IMAGEPATH}';
      $(function(){
    	  requestRecommend();
      });
      function requestRecommend(){
    	  $("#storeSelect").empty();
    	  var htmlAry = [];
    	  $("#storeSelete").append('<div class="right-header" >店铺精选</div>');
    	  Ajax.request("/logic/product/recommend",{"data":{"limit":'${dataModelLength}'},"success":function(data){
    		  if(data.code == 200){
    			  var data = data.data;
    			  for(var i = 0 ; i < data.length ; i++){
    				  htmlAry.push('<div class="row jingxuan-list" style="cursor:pointer;" onclick="goGoodsDetail('+data[i].goods_id+')"><div class="jingxuan-list-image"><img src="'+fiexdImg+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt="">');
    			      htmlAry.push('</div><div class="jingxuan-list-content"><div style="height:23.6px;overflow: hidden;" class="content-one">'+data[i].goods_name+'</div><p class="content-two">¥'+data[i].shop_price+' </p> </div> </div>');
    			  }
    			  $("#storeSelete").append(htmlAry.join(''));
    		  }
    	  }});
      }
      function goStoreDetail(storeId){
    	  var storeInfo = {
    			  bs_id:storeId
    	  }
    	  window.location.href="/store/detail?paramStr="+Base64.encode(JSON.stringify(storeInfo));
      }
      function goGoodsDetail(goodsId){
    	  var paramObj = {
				  goodsId:goodsId
		  }
		  window.location.href='/product/detail?paramStr='+Base64.encode(JSON.stringify(paramObj));
      }
   </script>
</html>