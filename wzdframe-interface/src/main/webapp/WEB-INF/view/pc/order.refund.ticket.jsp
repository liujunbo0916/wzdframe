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
    </style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="order-body">

    <div class="my-order-content">
     <div class="row commodity-header-one">
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn active" onclick="window.location.href='/order/ticket/list'">门票订单</button>
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn"  onclick="window.location.href='/order/list'">商品订单</button>
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn " onclick="window.location.href='/order/travel/list'">跟团订单</button>
        </div>
        <div class="row my-order-header">
            <div style="cursor: pointer;" data-code="all" class="col-md-1 select-type first">
                全部
            </div>
            <div style="cursor: pointer;" data-code="no_pay" class="col-md-1 select-type second">
                待付款
            </div>
            <div style="cursor: pointer;" data-code="no_use" class="col-md-1 select-type three">
                待使用
            </div>
            <div style="cursor: pointer;" onclick="window.location.href='/ticket/refund/order'" class="col-md-1  four active">
                退票
            </div>
        </div>
        <div class="row-order-list">
            <div class="row list-header">
                <div class="col-md-3 header-one">
                    退票信息
                </div>
                <div class="col-md-1 header-two">
                    数量
                </div>
                <div class="col-md-2 header-three">
                    退票时间
                </div>
                <div class="col-md-2 header-four">
                    退回金额
                </div>
                  <div class="col-md-2 header-six">
                    失败备注
                </div>
                <div class="col-md-2 header-five">
                    状态
                </div>
            </div>
	            <div class=" list-content ">
            <c:set var="dataLength" value="${fn:length(dataModel.resultPd)}"></c:set>
            <c:if test="${dataLength ne  0}">
            <c:forEach items="${dataModel.resultPd}" var="item" varStatus="status">
	                <div class="row bottom-line <c:if test='${status.index+1 eq dataLength}'> order-last</c:if>">
	                <div class="col-md-3 content-one">
	                    <div class="row-one">
	                        <span class="item-one">
	                            <span class="label-name">订单号:</span>
	                            <span class="label-value">${item.refund_no}</span>
	                        </span>
	                    </div>
	                    <div class="row-two">
	                        ${item.to_scenic_name}
	                    </div>
	                    <div class="row-three">
	                       ${item.to_ticket_name} （出行日期：${item.to_travel_date}） 
	                    </div>
	                </div>
	                <div class="col-md-1 content-two">
	                ${item.refund_num}张
	                      <c:if test="${empty item.to_package_type ||  item.to_package_type eq 1}">
	                          （单票）
	                      </c:if>
	                          <c:if test="${not empty item.to_package_type &&  item.to_package_type eq 2}">
	                         （套票）
	                      </c:if>
	                </div>
	                <div class="col-md-2 content-three">
	                    ${item.refund_time}
	                </div>
	                <div class="col-md-2 content-four">
	                    ¥${item.refund_money}
	                </div>
	                 <div class="col-md-2 content-six">
	                </div>
	                <div class="col-md-2 content-five" style="color:#333333;">
	                    <c:if test="${item.refund_status eq 1}"> 
	                                                                   已退票
	                    </c:if>
	                       <c:if test="${item.refund_status eq 2}"> 
	                                                                   退票中
	                    </c:if>
	                     <c:if test="${item.refund_status eq 3}"> 
	                                                                  退票失败
	                    </c:if>
	                </div>
	            </div>
         </c:forEach>  
         </c:if> 
         <c:if test="${dataLength eq 0}">
            <div class="order_list_empty mb20" style="display:block;" id="noContentView">暂时没有相关订单</div>
         </c:if>
        </div>
    </div>
     <div class="row route-footer-content">
    <div class="col-md-9 ">
        ${dataModel.pageStr}
    </div>
    <div class="col-md-3"></div>
</div>
<div class="good-hot">
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
<script type="text/javascript" src="/js/InheritString.js"></script>
</body>
<script type="text/javascript">
var fiexdImg = '${SETTINGPD.IMAGEPATH}';

$(function(){
	if('${dataLength}' != '0'){
	   requestNewsGoods();
	   $(".good-hot").show();
	}else{
		$(".good-hot").hide();
	}
	$(".select-type").click(function(){
		window.location.href="/order/ticket/list?selectType="+$(this).attr("data-code");
	});
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
function cancleOrder(orderId){
	var orderInfo = {
			id:orderId,
			opt:"cancle"
	}
	if(!confirm("确认取消该订单？")){
		return;
	}
	Ajax.request("/logic/ticket/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(orderInfo))},"success":function(data){
		if(data.code == 200){
		}
	}});
}
function refundDetail(ticketId){
	var refundInfo = {
			id:ticketId
	}
	window.location.href="/ticket/refund?paramStr="+Base64.encode(JSON.stringify(refundInfo));
}
function orderDetail(ticketId){
	var refundInfo = {
			id:ticketId
	}
	window.location.href="/order/ticket/detail?paramStr="+Base64.encode(JSON.stringify(refundInfo))
}
</script>
</html>