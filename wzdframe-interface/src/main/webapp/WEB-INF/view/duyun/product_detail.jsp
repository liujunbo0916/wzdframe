<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
  	<title>商品详情</title>
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
    <link rel="stylesheet" href="/css/duyun/tcxq.css">
    <link rel="stylesheet" href="/css/duyun/swiper.min.css">
</head>
<style>
.bar-tab .toolbar .collected {
  width: 66px;
  border-right: 1px solid #ddd;
}
.bar-tab .toolbar .collected:before {
  content: '';
  display: block;
  margin: 4px auto 2px;
  width: 18px;
  height: 18px;
  background-repeat: no-repeat;
  background-size: 18px auto;
  background-image: url(/img/duyun/icons/shoucang.png);
}
#specificationPage .content .spec .spec-unlisted {
  list-style: none;
  margin: 0;
  padding: 0 0 15px 5px;
  width: auto;
}
#specificationPage .content .spec .spec-unlisted li {
  float: left;
  padding: 8px 10px;
  font-size: 15px;
  color: #333;
  line-height: 14px;
  border: 1px solid #333;
  border-radius: 50px;
  margin-right: 10px;
  margin-top: 5px;
}

#specificationPage .content .spec .spec-unlisted .lied {
  float: left;
  padding: 8px 10px;
  font-size: 15px;
  color: #FC9313;
  line-height: 14px;
  border: 1px solid #FC9313;
  border-radius: 50px;
  margin-right: 10px;
  margin-top: 5px;
}

#specificationPage .content .spec .spec-unlisted .unlied {
  float: left;
  padding: 8px 10px;
  font-size: 15px;
  color: #333;
  line-height: 14px;
  border: 1px solid #333;
  border-radius: 50px;
  margin-right: 10px;
  margin-top: 5px;
}
#specificationPage .content .spec .spec-unlisted:before, #specificationPage .content .spec .spec-unlisted:after {
  content: '';
  display: table;
}
#specificationPage .content .spec .spec-unlisted:after {
  clear: both;
}
.ullis{
 width: 100%;
 height: 13px; 
 font-size: 13px;
 font-weight:normal;
     color: #666;
}

.bar-nav .title {
    font-family: PingFang-SC-Medium;
    font-size: 20px;
    font-weight: normal;
    color: #FFFFFF;
}

.title {
    position: absolute;
    display: block;
    width: 100%;
    padding: 0;
    margin: 0 -10px;
    font-size: 17px;
    font-weight: 500;
    line-height: 44px;
    color: #000;
    text-align: left;
    margin-left:130px;
    white-space: nowrap;
}
.title li{
	 list-style-type:none;
}
.pro-detail img {
  width: 100%!important;
}
.activity-msg {
    float: right;
    font-size: 14px;
    color: #ff7d13;
    font-size: 12px;
    position: absolute;
    right: 2px;
    top: 39px;
    margin-right: 10px;
    text-align: center;
    
}
.activity-msg div{
   float: right;
   color: #FFF;
   background: #443b3b;
   width: 22px;
   
}
.activity-msg .spetor{
 margin-left:2px;
 margin-right:4px;
 background: #FFF;
 color: #ff7d13;
 width: 8px;
}

.atrrJson{
	float: right;
	margin-right: -120px;
}


.min-num-label{
    float: right;
    font-size: 14px;
    color: rgb(255, 125, 19);
    display: block;
    margin: 15px;
}

</style>

<body>
    <!--底部导航栏-->
 <footer class="bar bar-tab footer-bar" style="z-index:100">
        <div class="toolbar" style="display: table-row;">
            <a style="color: #666;display: table-cell;height: 48px;vertical-align: middle;text-align: center;position: relative;"  class="bar-item custom" style="color: #666;" href="tel:13631705905"><div>客服</div></a>
            <span class="bar-item collect" id="collect" onclick="goodCollect()">收藏</span>
            <span class="bar-item add-cart" onclick="openModal('addCart');" style="">加入购物车</span>
            <span class="bar-item btn-buy" onclick="openModal('buyNow');" style="">立即购买</span>
        </div>
    </footer>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) /img/duyun/tcxq/1.jpg -->
    <div class="content">
        <!--产品详情顶部图片-->
        <div class="banner">
				<div style="height:205px;width:100%" id="swiper-container" class="swiper-container">
				  <div class="swiper-wrapper">
				  </div>
				  <div class="swiper-pagination"></div>
				</div>
		</div>
        <!--产品简介-->
        <div class="pro-bref">
            <div class="pro-title" id="pro-title">都匀毛尖茶</div>
            <p class="pro-intro" id="pro-intro">都匀毛尖茶产于贵州南部的都匀市。它以优美的外形， 独特的风格列为中国名茶珍品之一。</p>
            <div class="pro-price">
                <span id="shop_price">¥ 200.00</span>
                <span id="market_price">￥380.00</span>
            </div>
            <div class="pro-others">
                <span class="pro-address">都匀</span>
                <span class="pro-post" id="express_money">快递 0.00</span>
                <span class="pro-has-sell">已售<span id="virtual_sales">1120</span>件</span>
            </div>
        </div>
          <a class="pro-choose" onclick="openModal('all')">
            <div class="">选择规格属性</div>
            <img src="/img/duyun/icons/arrow_right.png" alt=""/>
        </a>
        <!--产品介绍-->
        <div class="pro-detail">
            <div class="pro-title">产品介绍</div>
            <!-- <div><p class="pro-content hidden">都匀毛尖， 中国十大名茶之一。1956年，由毛泽东亲 笔命名，又名“白毛尖”、“细毛尖”、“鱼钩茶”、 “雀舌茶”，是贵州三大名茶之一。外形条索紧结纤细 卷曲、披毫，色绿翠。香清高，味鲜浓，叶底嫩绿匀整... 防治坏血病和护御放射性元素等多种功效与作用。</p>
            </div>
            <div class="btn-wrap" onclick="showDetailInfo()">
                <img src="/img/duyun/icons/arrow_down.png" alt=""/>
            </div> 
        </div> -->
        <!--产品图片-->
        <div class="img-wrap" id="picture_list">
           <!--  <img src="/img/duyun/tcxq/2.jpg" alt=""/>
            <img src="/img/duyun/tcxq/3.png" alt=""/>
            <img src="/img/duyun/tcxq/4.jpg" alt=""/> -->
        </div>
    </div>
      <!--产品规格选择-->
    <div id="specificationPage" class="modal">
        <header class="bar bar-nav" style="position: relative;">
            <a class="icon icon-close pull-right" id="closed" onclick="closeModal()"></a>
            <ul class="title" style="margin-top: 4px">
             <li><h1 class="ullis" id="attr_Name">都均毛尖茶</h1></li>
             <li><h1 class="ullis" id="attr_Price">价格：</h1></li>
             <li><h1 class="ullis" id="attr_Stock">库存：</h1> 
             </li>
            </ul>
            <div class="pro-img"></div>
            <input id="attrsPrice" type="hidden"/>
            <input id="attrsStock" type="hidden"/>
            <input id="attrsSkuId" type="hidden"/>
               <div class="activity-msg"  data-cutDown="">
	             <div class="spetor">秒</div><div class="second">00</div>
	             <div class="spetor">分</div><div class="minute">00</div>
	             <div class="spetor">时</div><div class="hour">00</div>
	             <div class="spetor" style="width:56px;">距离结束&nbsp;</div>
	             </div>
        </header>
        <!--底部导航栏-->
        <footer class="bar bar-tab order-bar">
            <div class="toolbar">
            <span class="bar-item total-price">
                <div id="totelPrice">￥961</div>
                <div>订单总价</div>
            </span>
                <span id="addcart-btn" class="bar-item btn-buy" onclick="addCart();">加入购物车</span>
                <span id="buynow-btn" class="bar-item btn-buy" style="background-color: #fe0036;" onclick="goodsOrderSubmit()">确认购买</span>
            </div>
        </footer>
        <div class="content">
            <div class="spec">
            	<div id="speclist">
                <div class="spec-title padding-left-5">规格</div>
                <ul class="spec-list padding-left-5">
                </ul>
            	</div>
                <div class="pro-num">
                    <div class="num-label">数量</div>
                    <div class="num-adjust">
                        <div class="adjust-minus" onclick="minus()">
                            <img src="/img/duyun/icons/minus.png" alt="" />
                        </div>
                        <div class="adjust-view" id="number" >1</div>
                        <div class="adjust-plus" onclick="plus()">
                            <img src="/img/duyun/icons/plus.png" alt="" />
                        </div>
                    </div>
                </div>
                  <div class="min-num-label minnum" style="float: right;font-size:14px;color: #ff7d13;">折扣商品购买下限数量：0</div>
            </div>
        </div>
    </div>
       <!-- 浮动的购物车按钮 -->
	   	     <div id="gouwuche" onclick="goShoppingCart();" style="position:fixed;bottom:100px;right: 0px;opacity:0.8;">
	         <div style="position: relative;">
	           <c:if test="${cartCount ne 0}">
	                <span class="<c:if test="${cartCount < 10}">font-style-s</c:if> <c:if test="${cartCount >= 10}">font-style-b</c:if>">${cartCount}</span>
	           </c:if>
	        </div> 
	        <c:if test="${cartCount eq 0}">
	           <img id="gwclogo" style="width: 50px;" alt="" src="/img/duyun/icons/gouwuche.png">
	        </c:if>
	        <c:if test="${cartCount ne 0}">
	          <img id="gwclogo" style="width: 50px;" alt="" src="<c:if test="${cartCount < 10}">/img/duyun/icons/gouwuches.png</c:if><c:if test="${cartCount >= 10}">/img/duyun/icons/gouwucheb.png</c:if>">
	        </c:if>
	     </div>
    </div>
     <div class="spinner">
        <div class="loading">
            <img src="/img/duyun/dstc/loading.gif" alt=""/>
        </div>
    </div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/swiper.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/countdown/countDown.js"></script>
<script type="text/javascript">
   //加载事件
   var proId='${pd.proId}';
   $(function(){
	   requestProductDetail();
	   if(proId != null && proId != '' && proId > 0){
		   $(".add-cart").hide();
	   }else{
		   $(".add-cart").show();
	   }
   });
   
   function UrlSearch() 
   {
      var name,value; 
      var str=location.href; //取得整个地址栏
      var num=str.indexOf("?") 
      str=str.substr(num+1); //取得所有参数   stringvar.substr(start [, length ]

      var arr=str.split("&"); //各个参数放到数组里
      for(var i=0;i < arr.length;i++){ 
       num=arr[i].indexOf("="); 
       if(num>0){ 
        name=arr[i].substring(0,num);
        value=arr[i].substr(num+1);
        this[name]=value;
      } 
     } 
   }
   function goShoppingCart(){
	   window.location.href='/wx/cart/shopCart?redirectType=pdetail&p_id=${pd.p_id}';
   }
   
   var flag = 0;
   var bslike = 1;
   
   var selectBtnType = 0; //0表示点击立即购买按钮   1表示点击加入购物车的按钮  2表示点击选择购物车的按钮
   //获取加载组件
    var loadingPanel = document.querySelector('.spinner');
    var showDetailInfo = function () {
        var toggleBtn = document.querySelector('.btn-wrap img');
        var proContent = document.querySelector('.pro-content');
        if(toggleBtn){
            if(proContent.classList.contains('hidden')){
                proContent.classList.remove('hidden');
                toggleBtn.setAttribute('src', '/img/duyun/icons/arrow_up.png');
            }else {
                proContent.classList.add('hidden');
                toggleBtn.setAttribute('src', '/img/duyun/icons/arrow_down.png');
            }
        }
    }
    var adjustView = document.querySelector('.adjust-view');
    var minus = function () {
    	if(adjustView.innerText!=0){
	       	adjustView.innerText = adjustView.innerText - 1 > 0 ? adjustView.innerText - 1 : 1;
	       	totelPrice();
    	}
    };
    var plus = function () {
	        adjustView.innerText ++;
	        var attrsNumber = parseInt($("#attrsStock").val());
	        if(attrsNumber!=0){
		        if(attrsNumber){
			        if(adjustView.innerText > attrsNumber){
			        	alert("库存已达上限");
			        	adjustView.innerText--;
			        	return;
			        }
		        }else{
		        	alert("请选择属性参数")
		        	adjustView.innerText --;
		        	return;
		        }
	        }else{
	        	alert("库存不足");
	        	adjustView.innerText --;
	        }
	        totelPrice();
    };
    var arrsIndex=0;
    
   //请求商品详情数据
   function requestProductDetail(){
	   Ajax.request("/wx/product/doDetail",{"data":{"p_id":'${pd.p_id}',"proId":'${pd.proId}'},"success":function(data){
		   if(data.code == 200){
			  try{
				   var data = data.data;
				   $("#pro-title").text(data.goods_name);
				   $("#pro-intro").text(data.goods_summary);
				   $("#market_price").text("￥"+data.market_price);
				   if(data.goods_name.length > 15){
					   $("#attr_Name").text(data.goods_name.substring(0,14)+"...");   
				   }else{
				   	   $("#attr_Name").text(data.goods_name);
				   }
				   if(proId != null && proId != '' && proId > 0){
					   $("#shop_price").text("￥"+'${pd.price}');
					   $("#shop_price").text("￥"+'${pd.price}');
					   $("#totelPrice").text("￥"+'${pd.price}');
					   $("#attr_Price").text("价格: ￥"+'${pd.price}');
					   $("#attrsPrice").val('${pd.price}');
				   }else{
					   if(data.stock != null && data.stock !=''){
						   $("#shop_price").text("￥"+data.stock.price);
						   $("#shop_price").text("￥"+data.stock.price);
						   $("#totelPrice").text("￥"+data.stock.price);
					   	   $("#attr_Price").text("价格: ￥"+data.stock.price);
					   	   $("#attrsPrice").val(data.stock.price);
	   						$("#addcart-btn").hide();
	   						proId=data.stock.proId;
	   					 	$(".add-cart").hide();
					   }else{
						   $("#shop_price").text("￥"+data.shop_price);
						   $("#shop_price").text("￥"+data.shop_price);
						   $("#totelPrice").text("￥"+data.shop_price);
					   	   $("#attr_Price").text("价格: ￥"+data.shop_price);
					   	   $("#attrsPrice").val(data.shop_price);
					   }
				   }
				   $("#attr_Stock").text("库存: "+data.goods_stock);
				   if(data.goods_stock==0){
			   		   $("#number").text('0');
			   		   adjustView.innerText=0;
				   }
				   $("#attrsSkuId").val(data.sku_id);
				   $("#attrsStock").val(data.goods_stock);
				   
				   if(!data.goods_freight || data.goods_freight == '0.00' || data.goods_freight =='0.0'){
				      $("#express_money").text("免运费");
				   }else{
					  $("#express_money").text("快递  "+data.goods_freight);
				   }
				   if(data.is_goods_like == 1){
					   bslike=0;
					   $("#collect").addClass("collected");
					   $("#collect").removeClass("collect");
				   }else{
					   bslike=1;
				   }
				   $("#virtual_sales").text("￥"+data.virtual_sales);
				   if(data.pictures && data.pictures.length > 0){
					  /*  $("#swiper-container").children().eq(0).empty().append('<div class="swiper-slide"><img src="'+data.list_img+'" alt=""/></div>'); */
					   for(var i = 0 ; i < data.pictures.length ; i++){
						   $("#swiper-container").children().eq(0).append('<div class="swiper-slide"><img src="'+data.pictures[i].originalImg+'" alt=""/></div>');
					   }
					   var mySwiper = new Swiper('#swiper-container', {
							autoplay: 5000,//可选选项，自动滑动
							pagination: '.swiper-pagination'
					   });
				   }else{
						$("#swiper-container").children().eq(0).empty().append('<div class="swiper-slide"><img src="'+data.list_img+'" alt=""/></div>');
				   }
				   $("#picture_list").html(data.goods_desc);
				   $(".pro-img").css("background-image","url(" + data.list_img + ")");
				   //库存展示
				   $("#speclist").empty();
				   if(data.goodsAttr && data.goodsAttr.length >0){
					   var html='';
					   for(var i = 0 ; i < data.goodsAttr.length ; i++){
						   if(data.goodsAttr[i].isSale==1){
							   arrsIndex++;
							   var arrs = data.goodsAttr[i].attrValue;
							   html='<div class="spec-title padding-left-5">'+data.goodsAttr[i].attrName+'</div><ul class="spec-unlisted padding-left-5">';
							   for (var j = 0; j < arrs.length; j++) {
								   html+='<li  class="urli unlied" data-name="'+data.goodsAttr[i].attrName+'" onclick="onliCheck(this)">'+arrs[j]+'</li>';
								}
							   html+='</ul>';
							   $("#speclist").append(html);
							   $("#attrsSkuId").val('');
						   }
					   }
				   }
			  }catch(e){
				  loadingPanel.style.display = 'none';
			  }
		   }
		   loadingPanel.style.display = 'none';
	   }});
   }
    //商品收藏
   function goodCollect(){
	   Ajax.request("/wx/product/doCollect",{"data":{"goods_id":'${pd.p_id}',"is_goods_like":bslike,},"success":function(data){
		   if(data.code == 200){
			  try{
				  if(data.data == 1){
					   bslike=0;
					   $("#collect").addClass("collected");
					   $("#collect").removeClass("collect");
				   }else if(data.data == 0){
					   bslike=1;
					   $("#collect").addClass("collect");
					   $("#collect").removeClass("collected");
				   }else{
					   alert("已收藏")
				   }
			  }catch(e){
				  loadingPanel.style.display = 'none';
			  }
		   }else{
			   alert("操作失败！")
		   }
		   loadingPanel.style.display = 'none';
	   }});
   } 
   
   var checkAttr =[];
   var goods_id ='';
   
   //选择属性   
   function onliCheck(objthis){
		var attr=$(objthis).attr("data-name");
	    var nameVlaueEntry = attr+":"+$(objthis).text();
	   	if($(objthis).hasClass("unlied")){
		  	$(objthis).addClass("lied");
		  	$(objthis).removeClass("unlied");
		  	$(objthis).siblings().removeClass("lied");
			$(objthis).siblings().addClass("unlied");
			var type=0,i=0;
			$.each(checkAttr, function(index, dataobj){ 
		   		if(dataobj.indexOf(attr) >= 0){
		   			type=index;
		   			i=1;
		   			return false;
		   		}
			});
		   	if(type>=0 && i==1 && checkAttr !=null && checkAttr !='' && checkAttr.length > 0){
		   		checkAttr[type]=nameVlaueEntry;
		   	}else{
			   	checkAttr.push(nameVlaueEntry);
		   	}
	   } 
	   proId = 0;
	   getGoodStocks();
   }
   var minNum=0;
  var stockType=0;
  $(".activity-msg").hide();
  $(".minnum").hide();
   // 拉取库存
  function getGoodStocks(){
	   var attrjson='';
	  if(proId != null && proId != '' && proId > 0){
		  attrjson='${empty pd.attrJson?'-1':pd.attrJson}';
		  if(attrjson != null && attrjson != '' && attrjson != -1 ){
			 var slength= attrjson.split("|")
			  $("li.urli").each(function(){
				  	var temp =this.innerHTML;
				  	var attr =$(this).attr("data-name");
				  	var nameVlaueEntry=attr+":"+temp
				  	for (var i = 0; i < slength.length; i++) {
						if(nameVlaueEntry == slength[i]){
							$(this).addClass('lied');   
							$(this).removeClass("unlied");
							checkAttr.push(nameVlaueEntry);
						}
					}
			  });
		  }
	  }else{
		 if(checkAttr.length == 0 || arrsIndex != checkAttr.length) {
		   	return;
		  } 
		 attrjson= checkAttr.join("|");
	  }
   	Ajax.request("/wx/product/doGoodsStock", {
   		"data" : {
   			"goods_id" : '${pd.p_id}',
   			"attr_json" : attrjson
   		},
   		"success" : function(data) {
   			if (data.code == 200) {
   				if(data.data){
   					if(data.data.stockType == 1){
   						$(".activity-msg").show();
   						$(".activity-msg").attr("data-cutDown",data.data.endTime);
   						$("#addcart-btn").hide();
   						stockType=1;
   						proId=data.data.proId;
   						excuCutDown();
   						minNum=data.data.minNum;
   						$(".minnum").html("折扣商品购买下限数量:"+minNum);
   						$(".minnum").show();
   						$("#number").html(minNum);
   					 	$(".add-cart").hide();
   					}else if(data.data.stockType == 0){
   						$(".activity-msg").hide();
   						$("#addcart-btn").show();
   						$(".add-cart").show();
   						$(".minnum").hide();
   						stockType=0;
   					}
	   				$("#attrsPrice").val(data.data.price);
	   				$("#attrsStock").val(data.data.stock); 
	   				$("#attr_Stock").html("库存：" + data.data.stock); 
	   				$("#attr_Price").html("价格：" + data.data.price); 
	   				$("#attrsSkuId").val(data.data.sku_id); 
	   				//上次库存为0 更新数量为1
	   				if(adjustView.innerText==0){
	   					adjustView.innerText=1;
	   			   	}
	   				//数量大于库存  设为库存数
	   				if(adjustView.innerText > parseInt(data.data.stock)){
	   					adjustView.innerText=data.data.stock;
	   			   	}
	   				//库存为0 数量为0
	   				if(data.data.stock==0){
	   					adjustView.innerText=0;
	   				}
	   				//情况选择属性数组，更新价格
	   				totelPrice();
   				}else{
   					$("#attr_Stock").html("库存：0 "); 
	   				$("#attr_Price").html("价格：0 "); 
   					adjustView.innerText=0;
   					totelPrice();
   				}
   			}else{
 			   alert("操作失败！")
 		   }
 		   loadingPanel.style.display = 'none';
   		}
   	});
   }
   //计算价格
   function totelPrice(){
	   var goodsPrice=$("#attrsPrice").val();
	   if(!goodsPrice && goodsPrice!=''){
		   alert("请先选择属性参数")
		   adjustView.innerText =1;
		   return;
	   }
	   var num=$("#number").text();
	   var totelprice=goodsPrice * num;
	   $("#totelPrice").empty().html("￥"+totelprice);
   }
   
   //提交订单
   function goodsOrderSubmit(){
	   /*  if(!'${user.phone}'){
		   window.location.href="/wx/duyun/user/bingphone?bingType=goodsDetail&goods_id=${pd.p_id}";
		   return;
	   }   */ 
		var goodsId='${pd.p_id}';
		var skuId=$("#attrsSkuId").val();
		var goodsNum=$("#number").text();
		var goodsStock=$("#attrsStock").val();
	    if(!skuId || skuId <= 0){
	    	alert("请选择属性参数")
			return;
		}
		if(!goodsNum || goodsNum <= 0){
			alert("请选择商品数量！");
			return;
		}
		if(!goodsStock || goodsStock <= 0){
			alert("该商品库存不足无法购买！");
			return;
		}
	   	if(stockType == 1){//折扣商品直接购买
		   var price=$("#attrsPrice").val();
		   if(minNum > goodsNum){
			   alert("该折扣商品购买下限为"+minNum+"！");
			   return;
		   }   
		   closer();
		   window.location.href = "/wx/order/makeSureOrderByDisCount?goods_id="+goodsId+"&sku_id="+skuId+"&goodsNum="+goodsNum+"&price="+price+"&pro_id="+proId+"&addtype=1";
	   }else if(stockType == 0){//普通商品直接购买
		   closer();
		   window.location.href = "/wx/order/makeSureOrderByDirect?goods_id="+goodsId+"&sku_id="+skuId+"&goodsNum="+goodsNum+"&type=buyNow&optType=${pd.optType}";
	   }
   }
   //添加到购物车
   function addCart(){
	 	/*  if(!'${user.phone}'){
		   window.location.href="/wx/duyun/user/bingphone?bingType=goodsDetail&goods_id=${pd.p_id}&pageType=${pd.pageType}&optType=${pd.optType}";
		   return;
	   }    */
	   var goodsId='${pd.p_id}';
	   var skuId=$("#attrsSkuId").val();
	   var goodsNum=$("#number").text();
	   var goodsStock=$("#attrsStock").val();
	   if(!skuId || skuId <= 0){
   		alert("请选择属性参数");
		   return;
	   }
	   if(!goodsNum || goodsNum <= 0){
			alert("请选择商品数量！");
			return;
	   }
	   if(!goodsStock || goodsStock <= 0){
		   alert("该商品库存不足无法购买！");
		   return;
	   }
	   Ajax.request("/wx/cart/addGoodsCart",
				{"data":
				{  
					"goods_id":goodsId,
					"sku_id":skuId,
					"goods_number":goodsNum,
					"stock":goodsStock
				},
			"success":function(data){
			if(data.code == 200){
			   alert("已成功加入购物车");
			   closeModal();
			}else{
			   alert(data.msg);
			}
		}});
   }
   
   function closer(){
	   if($("#specificationPage").hasClass("active")){
		   $("#specificationPage").removeClass('active');
	   }else{
		   $("#specificationPage").addClass('active');
	   }
   }
   
   var openModal = function (selectType) {
	   if("all" == selectType){
		   selectBtnType = 2;
		   $("#addcart-btn").show();
		   $("#buynow-btn").show();
		   $("#addcart-btn").text("加入购物车");
		   $("#buynow-btn").text("立即购买");
	   }else if("addCart" == selectType){
		   selectBtnType = 1;
		   $("#addcart-btn").show();
		   $("#addcart-btn").text("确定");
		   $("#buynow-btn").hide();
	   }else if("buyNow" == selectType){
		   selectBtnType = 0;
		   $("#addcart-btn").hide();
		   $("#buynow-btn").text("确定");
		   $("#buynow-btn").show();
	   }
       var modal = document.getElementById('specificationPage');
       if($("#specificationPage").hasClass("active")){
    	   closeModal();
	   }else{
       	   showModal(modal);
	   }
   };

   // 隐藏modal
   var closeModal = function () {
       var modal = document.getElementById('specificationPage');
       hiddenModal(modal);
   };

   // 显示modal
   var showModal = function (popNode) {
       flag = 1;
       var modal = popNode || document.getElementById('popNode');
       var footBar = document.querySelector('.footer-bar');
       footBar.style.display = 'none';
       var backdrop = document.createElement('div');
       backdrop.classList.add('backdrop');
       modal.parentNode.appendChild(backdrop);
       modal.classList.add('active');
       if(proId != null && proId != '' && proId > 0){
    	   getGoodStocks(); 
       }
   };

   // 隐藏modal
   var hiddenModal = function (popNode) {
       flag = 0;
       var modal = popNode || document.getElementById('popNode');
       var footBar = document.querySelector('.footer-bar');
       footBar.style.display = 'table';
       var backdrop = document.querySelector('.backdrop');
       modal.parentNode.removeChild(backdrop);
       modal.classList.remove('active');
   };

   document.addEventListener('touchmove', function (event) {
       if(flag === 1){
           event.preventDefault();
       }
   },false);
 	//监听返回按钮  
	if('${pd.pageType}'.indexOf('confirmOrder') != -1){ //从提交订单进来
		if('${pd.optType}'.indexOf("productHome")!= -1){
			GoBackBtn.excuteHistory("/wx/product/home");
		}else if('${pd.optType}'.indexOf('productList')!= -1){
			GoBackBtn.excuteHistory("/wx/product/list");
		}
	}else if('${pd.pageType}'.indexOf('shopCart') != -1){  //从购物车过来
		GoBackBtn.excuteHistory("/wx/cart/shopCart");
	}else if("${pd.pageType}".indexOf('orderList') != -1){ //从订单列表过来
		GoBackBtn.excuteHistory("/wx/order/myOrder?type=${pd.type}&order_status=${pd.status}");
	}else if("${pd.pageType}".indexOf('store') != -1){
		GoBackBtn.excuteHistory("/wx/store/index?resultType=detail&storeId="+'${pd.storeId}');
	}else{
		GoBackBtn.excuteHistory("/wx/product/home");
	}
	 /*定义倒计时*/
	 function excuCutDown(){
		 $(".activity-msg").each(function(){
			 var tempCountDown = new CountDown(parseInt($(this).attr("data-cutDown")));
			 tempCountDown.clearInter();
			 tempCountDown.calCount(this);
	    });
	 }
 </script>
</html>