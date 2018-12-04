<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
     <link rel="stylesheet" href="/css/duyun/pc/my-order-good.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/product-detail.css" type="text/css">
    <meta name="keywords" content="${dataModel.goods_name}">
    <meta name="description" content="${dataModel.goods_name}">
    <title>${dataModel.goods_name}</title>
    <style type="text/css">
       .small-container{
          cursor: pointer;
       }
       .img-two div{
          cursor: pointer;
       }
       .selected{
          border:  2px solid #e53e41;
       }
       s, strike, del {
		   text-decoration: line-through;
		}
       .introduction-img-container img{
         width: 100%;
       }
       .activity-banner {
       background:#E1481E;
	    height: 32px;
	    line-height: 32px;
	    padding: 0 10px;
	    font-family: "Microsoft YaHei";
	    overflow: hidden;
	    zoom: 1;
	}
	.seckilling .activity-type strong {
    color: #fff;
}
	.activity-type {
    float: left;
}

.seckilling .activity-message {
    color: #fbe2e2;
    font-size: 12px;
}
.activity-message {
    float: right;
    color: #fff;
    font-size: 14px;
}
  
	.activity-message span{
	font-size:14px;
	background:#443b3b;
	color:#FFF;
	margin:0 4px;
	 width: 22px;
	}
    </style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="product-content" style="    overflow: hidden;">
    <div class="product-header">
        <span class="normal-text">
            都匀特色
        </span>
        <span class="normal-text ">
            ／
        </span>
        <span class="normal-text " style="cursor: pointer;" onclick="window.location.href='/product/list'">
            都匀特产
        </span>
        <span class="normal-text ">
           ／
        </span>
        <span class="normal-text active">
            特产详情
        </span>
    </div>
    <div class="row product-item-one">
        <div class="col-md-6 col col-left">
            <div class="img-one">
                <img src="${dataModel.list_img}" class="big-img" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
            </div>
            <c:if test="${not empty dataModel.pictures}">
	            <div class="row img-two">
	                <c:forEach items="${dataModel.pictures}" var="picture">
		                <div class="col-md-2 col small-col">
		                    <img src="${picture.originalImg}" class="small-img" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
		                </div>
	                </c:forEach>
	            </div>
            </c:if>
        </div>
        <div class="col-md-6 col product-right">
            <p class="title-one">
               ${dataModel.goods_name}
            </p>
            <p class="title-two">
                ${dataModel.goods_summary}
            </p>
            <div class="activity-banner  J-seckill seckilling  limittime" id="banner-miaosha" style="">
                        <div class="activity-type">
                            <i class="sprite-seckilling"></i><strong>限时秒杀</strong>
                        </div>
                        <div class="activity-message">距离结束<span class="days">00</span>天<span class="hour">00</span>时<span class="minute">00</span>分<span class="second">00</span>秒</div>
            </div>
            <p class="title-three">
                <span class="money">
                    <span class="limittime" style="padding-right: 10px;font-family: simsun;color: #999;">秒杀价</span>
                    <span class="money-symbol">¥</span>
                    <span class="money-text" id="produce_price">${dataModel.shop_price}</span>
                    <span class="pricing limittime" style="margin-left: 10px;">[<del id="page_origin_price">￥3699</del>]</span>
                </span>
                <span class="amount">
                    ${dataModel.virtual_sales}人购买
                </span>
            </p>
            <div class="row title-four">
                <div class="col-md-2 col promise">服务承诺</div>
                <div class="col-md-10 col promise-text">
                    <span class="promise-item">
                       <img class="promise-img" src="/img/duyun/pc/promise.png"/>
                       正品保障
                    </span>
                    <span class="promise-item">
                       <img class="promise-img" src="/img/duyun/pc/promise.png"/>
                       安全交易
                    </span>
                  </div>
            </div>
            <div class="row title-five">
                <div class="col-md-2 col promise">运费</div>
                <div class="col-md-10 col promise-text">
                 <c:if test="${empty dataModel.goods_freight || dataModel.goods_freight eq '0.00'}">
                    免运费
                 </c:if>
                  <c:if test="${not empty dataModel.goods_freight && dataModel.goods_freight ne '0.00'}">
                    ${dataModel.goods_freight}
                 </c:if>
                </div>
            </div>
            <div class="row title-six">
                <c:forEach items="${dataModel.goodsAttr}" var="attr">
                   <c:if test="${attr.isSale eq 1}">
			                <div class="col-md-2 attr-name col promise">${attr.attrName}</div>
			                <div class="col-md-10 attr-values col promise-text">
			                    <c:forEach items="${attr.attrValue}" var="vals" varStatus="statusV">
			                           <span class="small-container <c:if test="${statusV.index eq 0}">active</c:if>">${vals}</span>
			                    </c:forEach>
			                </div>
	                </c:if>
                </c:forEach>
            </div>
            <div class="row title-seven">
                <div class="col-md-2 col promise">选择数量</div>
                <div class="col-md-10 col promise-text input-group">
                    <span class="input-group-btn" onclick="minus();">
                        <button type="button" class="person-quantity-left-minus btn btn-number"
                                data-type="minus" data-field="">
                          <span class="glyphicon glyphicon-minus">-</span>
                        </button>
                    </span>
                    <input type="text" id="person-quantity" name="quantity"
                           class="form-control input-number"
                           value="1" min="0" step="1">
                    <span class="input-group-btn">
                        <button type="button" class="person-quantity-right-plus btn  btn-number"
                                data-type="plus" data-field="" onclick="plus();">
                            <span class="glyphicon glyphicon-plus">+</span>
                        </button>
                    </span>
                </div>
                <div id="minBuyNum" style="width: 75px;margin-left: 20px;font-size: 12px;line-height: 3;color:#fc9313;display: none;">  3件起购
                     </div>
            </div>
            <div class="title-last">
                <button type="button" id="bookNow" class="btn btn-warning book-btn" style="cursor:pointer;">立即预订</button>
            </div>
        </div>
    </div>
    <div class=" product-item-two">
        <div class="product-introduction">
            <p class="introduction-text">
                产品介绍
            </p>
        </div>
        <div class="introduction-img-container" style="width: 1100px;">
            ${dataModel.goods_desc}
        </div>
    </div>
    <div class="good-hot">
    <div class="remen-header" style="border-bottom:1px solid #E1E1E1;">热门商品</div>
    <div class="row remen-content" id="newGoodsRecommend">
    </div>
</div>
</div>
	<%@ include file="common/footer.jsp"%>
	<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script src="/js/BASE64.js"></script>
	<script type="text/javascript" src="/js/countdown/countDown.js"></script>
	<script type="text/javascript">
	   var adjustView = document.querySelector("#person-quantity");
	   var activeType = 1; //1为普通商品  2为做活动商品
	   var  activePrice = 0; //活动价格
	   var activeProId = ''; //活动商品对应的item
	   var activeNum = 1;
	   var activeMin = 1;
	   
	   var fiexdImg = '${SETTINGPD.IMAGEPATH}';
	   var minus = function () {
	        adjustView.value = adjustView.value - 1 > activeMin ? adjustView.value - 1 : activeMin;
	    };
	    var plus = function () {
	        adjustView.value ++;
	    };
	    $(".limittime").hide();
	    var requestStockData = [];
	    var stockInfo = {
	    		attr_json:'',
	    		price:'',
	    		goods_id:'',
	    		sku_id:'${dataModel.sku_id}',
	    		stock:'${dataModel.goods_stock}'
	    }
	  //检测程序  检测是否每一组的value都有active
	    var checkIsReqestStok = function(){
	    	requestStockData.length = 0;
	    	var checkFlag = true;
	    	if($(".attr-values").length== 0){
	    		return false;
	    	}
	    	$(".attr-values").each(function(){
	    		var selectedItem = $(this).children(".active");
	    		if(selectedItem.length == 0){
	    			checkFlag = false;
	    		}else{
	    			var itemVal =selectedItem.text();
	    		    var itemName = selectedItem.parent().prev().text();
	    		    requestStockData.push(itemName+":"+itemVal);
	    		}
	    	});
	    	return checkFlag;
	    }
	  //请求库存的方法
	  var requestStock = function(){
		  if(checkIsReqestStok()){
			  Ajax.request("/wx/product/doGoodsStock",{"data":{"attr_json":requestStockData.join('|'),"goods_id":'${dataModel.id}'},
				  "success":function(data){
					  if(data.code == 200){
					      var data = data.data;
						  if(data.stockType == 1){
							  $(".limittime").show();
							  new CountDown(parseInt(data.endTime),"showDays").calCount($(".activity-message")[0]);
							  $("#page_origin_price").text("￥"+data.market_price);
							  activeType = 2;
							  activeProId = data.proId;
							  $("#person-quantity").val(data.minNum);
							  activeMin = data.minNum;
							  if(data.minNum != 1){
							     $("#minBuyNum").show().text(data.minNum+"件起购");
							  }
		   					}else{
		   						activeType = 1;
		   						$(".limittime").hide();
		   					 $("#person-quantity").val("1");
		   					}
						  activeMin = $("#person-quantity").val();
						  stockInfo.attr_json = data.attr_json;
						  stockInfo.price = data.price;
						  stockInfo.goods_id = data.goods_id;
						  stockInfo.sku_id = data.sku_id;
						  stockInfo.stock = data.stock;
						  $("#produce_price").text(stockInfo.price);
					  }
				  }});
		  }
	  }
	  $(".small-container").click(function(){
	    	if(!$(this).hasClass("active")){
	    		$(this).siblings().removeClass('active');
	    		$(this).addClass('active');
	    		requestStock();
	    	}
	    });
	  $(function(){
		  //页面加载完成请求库存
		  requestStock(); 
		  requestNewsGoods();
		  $("#bookNow").click(function(){
			  if(!stockInfo.goods_id){
				  stockInfo.goods_id='${dataModel.id}';
			  }
			  var paramStr = {
						 "stockId": stockInfo.sku_id,
						 "goodsNumber":$('#person-quantity').val(),
						 "goodsId":stockInfo.goods_id,
						 "pageType":"productDetail",
						 "activeType":activeType,
						 "activePrice":stockInfo.price,   //活动商品传 活动价格，
						 "activeProId":activeProId  //活动商品id
			  } 
			  if(parseInt(stockInfo.stock) < parseInt($('#person-quantity').val())){
				  alert("库存不足");
				  return;
			  }
			  if(!'${userInfo}'){
			     window.location.href='/login?paramStr='+Base64.encode(JSON.stringify(paramStr));
			  }else{
				  window.location.href='/product/order/confirm?paramStr='+Base64.encode(JSON.stringify(paramStr));
			  }
		  });
		  
		  if($(".title-six").children().length == 0){
			  $(".title-six").remove();
		  }
		  $(".img-two div").click(function(){
			  $(".big-img").attr("src",$(this).children(0).attr("src"));
			  if(!$(this).children(0).hasClass("selected")){
			     $(this).children(0).addClass("selected");
			  }
			  $(this).siblings().children(0).removeClass("selected");
		  });
	  });
	  function requestNewsGoods(){
		  $("#newGoodsRecommend").empty();
		  var htmlAry = [];
		  Ajax.request("/logic/product/newRecommend",{"data":{"limit":'4'},"success":function(data){
			  if(data.code == 200){
				  var data = data.data;
				  for(var i = 0 ; i < data.length ; i++){
					  htmlAry.push('<div style="cursor:pointer;" onclick="goGoodsDetail('+data[i].goods_id+')" class="col-md-4 hot-list-item "><div class="image-hover">');
					  htmlAry.push('<img src="'+fiexdImg+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"  alt=""></div>');
					  htmlAry.push('<div class="good-list-content"><p><span class="list-info-text">'+data[i].goods_name+'</span>');
					   if(data[i].goods_tags){
						   var goodsTags = data[i].goods_tags.split(",");
					       htmlAry.push('<span class="good-recommend">'+goodsTags[0]+'</span>');
					   }
					  htmlAry.push('<p class="list-text-detail"><span class="amount">¥'+data[i].shop_price+'</span>');
					  htmlAry.push('<strike>¥'+data[i].market_price+'</strike><span class="buy-span">'+data[i].virtual_sales+'人购买</span></p></div></div>');
				  }
				  $("#newGoodsRecommend").append(htmlAry.join(''));
			  }
		  }});
	   }
	    function goGoodsDetail(goodsId){
	    	var paramObj = {
			    goodsId:goodsId
			}
			window.location.href='/product/detail?paramStr='+Base64.encode(JSON.stringify(paramObj));
	     }
	</script>
</body>
</html>