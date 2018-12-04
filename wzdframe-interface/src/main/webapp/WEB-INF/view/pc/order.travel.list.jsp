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
    <style type="text/css">
       .my-order-header div{
          cursor: pointer;
       }
    </style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="order-body">

    <div class="my-order-content">
     <div class="row commodity-header-one">
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn" onclick="window.location.href='/order/ticket/list'">门票订单</button>
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn"  onclick="window.location.href='/order/list'">商品订单</button>
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn active" onclick="window.location.href='/order/travel/list'">跟团订单</button>
        </div>
        <div class="row my-order-header">
            <div   onclick="window.location.href='/order/travel/list'" class="col-md-1 first <c:if test="${page.pd.selectType ne 'cancle' && page.pd.selectType ne 'no_pay' && page.pd.selectType ne 'no_use'}">active</c:if>">
                全部
            </div>
            <div class="col-md-1 second <c:if test="${page.pd.selectType eq 'no_pay'}">active</c:if>"  onclick="window.location.href='/order/travel/list?selectType=no_pay'">
                待付款
            </div>
            <div class="col-md-1 three <c:if test="${page.pd.selectType eq 'no_use'}">active</c:if>" onclick="window.location.href='/order/travel/list?selectType=no_use'">
                待出行
            </div>
            <div class="col-md-1 four <c:if test="${page.pd.selectType eq 'cancle'}">active</c:if>" onclick="window.location.href='/order/travel/refundList?selectType=cancle'">
                退款
            </div>
        </div>
        <div class="row-order-list">
            <div class="row list-header">
                <div class="col-md-3 header-one">
                    订单信息
                </div>
                <div class="col-md-1 header-two">
                    类型
                </div>
                <div class="col-md-2 header-three">
                    行程日期
                </div>
                <div class="col-md-2 header-four">
                    支付金额
                </div>
                <div class="col-md-2 header-five">
                    订单状态
                </div>
                <div class="col-md-2 header-six">
                    操作
                </div>
            </div>
			  <c:forEach items="${dataModel}" var="item">         
			            <div class=" list-content">
			                <div class="row bottom-line">
			                <div class="col-md-3 content-one">
			                    <div class="row-one">
			                        <span class="item-one">
			                            <span class="label-name">订单号:</span>
			                            <span class="label-value">${item.orderSn}</span>
			                        </span>
			                        <span class="item-one">
			                            <span class="label-name">下单时间:</span>
			                            <span class="label-value">${item.createTime}</span>
			                        </span>
			                    </div>
			                    <div class="row-two">
			                    </div>
			                    <div class="row-three">
			                       ${item.grouptourName}
			                    </div>
			                </div>
			                <div class="col-md-1 content-two">
			                    跟团
			                </div>
			                <div class="col-md-2 content-three">
			                     ${item.departureDate}
			                </div>
			                <div class="col-md-2 content-four">
			                    ¥ ${item.totalPrice}
			                </div>
			                <div class="col-md-2 content-five">
			                   <c:if test="${item.orderState eq 0}">
			                        <p>待付款</p>
			                   </c:if>
			                    <c:if test="${item.orderState eq 1}">
			                        <p>待出行</p>
			                   </c:if>
			                     <c:if test="${item.orderState eq 2}">
			                        <p>已完成</p>
			                   </c:if>
			                   <c:if test="${item.orderState eq 3}">
			                        <p>已取消</p>
			                   </c:if>
			                    <c:if test="${item.orderState eq 4}">
			                        <p>退款中</p>
			                   </c:if>
			                   <c:if test="${item.orderState eq 5}">
			                        <p>已退款</p>
			                   </c:if>
			                    <c:if test="${item.orderState eq 6}">
			                        <p>订单已关闭</p>
			                   </c:if>
			                   <p class="order-detail" style="cursor: pointer;" onclick="goTravelOrderDetail('${item.orderId}');">订单详情</p>
			                </div>
			                <div class="col-md-2 content-six">
			                     <c:if test="${item.orderState eq 0}">
			                         <p class="go-pay" onclick="goPay('${item.orderId}');">去支付</p>
			                     </c:if>
			                      <c:if test="${item.orderState eq 1}">
			                         <p class="go-pay" style="cursor: pointer;" onclick="goApplyRefundPage('${item.orderId}');" >申请退款</p>
			                     </c:if>
			                    <c:if test="${item.orderState eq 6 || item.orderState eq 3 || item.orderState eq 2}">
			                        <p style="cursor: pointer;" onclick="orderOpt('${item.orderId}','delete');">删除订单</p>
			                    </c:if>
			                    <c:if test="${item.orderState eq 0}">
			                         <p style="cursor: pointer;" onclick="orderOpt('${item.orderId}','cancle');">取消订单</p>
			                    </c:if>
			                </div>
			               </div>
			            </div>
			</c:forEach>            
        </div>
       <c:if test="${fn:length(dataModel) eq 0}">
            <div class="order_list_empty mb20" style="display:block;" id="noContentView">暂时没有相关订单</div>
       </c:if>
    </div>
     <div class="row route-footer-content">
    <div class="col-md-9 ">
        ${page.pageStr}
    </div>
    <div class="col-md-3"></div>
</div>
<div class="good-hot" style="margin-bottom: 40px;">
    <div class="remen-header" style="border-bottom:1px solid #E1E1E1;">热门跟团</div>
    <div class="row remen-content" id="newGoodsRecommend">
    </div>
</div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
var fiexdImg = '${SETTINGPD.IMAGEPATH}';
$(function(){
	if('${fn:length(dataModel)}' != '0'){
	   requestNewsGoods();
	}else{
		$(".good-hot").hide();
	}
})
//请求新品推荐
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
function goTravelOrderDetail(order_id){
	 var paramObj = {
			 order_id:order_id
	  }
	window.location.href="/order/travel/detail?paramStr="+Base64.encode(JSON.stringify(paramObj));
}
function goPay(orderId){
	   var orderInfo = {
			   "order_id":orderId
	   }
	   window.location.href='/travel/payType?paramStr='+Base64.encode(JSON.stringify(orderInfo));
}
//订单操作  取消订单   删除订单   
function  orderOpt(orderId,optType){
	var tipMsg = (optType == "cancle")?"确定取消该订单吗？":"确定删除该订单吗？";
	if(confirm(tipMsg)){
		var opt = {
				orderId:orderId,
				optType:optType
		}
		Ajax.request("/logic/travel/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(paramObj))},
			"success":function(data){
				if(data.code == 200){
					alert("操作成功");
					window.location.reload();
				}else{
					alert(data.msg);
				}
			}});
	}
}
//跳转到申请退款页面
function goApplyRefundPage(orderId){
	var paramObj = {
			order_id : orderId
	}
	window.location.href="/order/traval/refund?paramStr="+Base64.encode(JSON.stringify(paramObj));
}


</script>
</html>