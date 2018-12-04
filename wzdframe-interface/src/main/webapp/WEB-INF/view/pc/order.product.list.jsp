<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/my-order-good1.css" type="text/css">
    <style type="text/css">
       .my-order-header div,.more-money p,.bianhao-two{
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
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn active"  onclick="window.location.href='/order/list'">商品订单</button>
            <button style="cursor: pointer;" type="button" class="btn btn-light order-btn" onclick="window.location.href='/order/travel/list'">跟团订单</button>
        </div>
        <div class="row my-order-header">
            <div codeFlag ="" class="col-md-1 col first <c:if test="${empty pd.type}">active</c:if>">
                全部
            </div>
            <div codeFlag ="0" class="col-md-1 col second <c:if test="${pd.type eq 0}">active</c:if>">
                待付款
            </div>
            <div codeFlag ="3" class="col-md-1 col three <c:if test="${pd.type eq 3}">active</c:if>">
                待发货
            </div>
            <div codeFlag ="4" class="col-md-1 col four <c:if test="${pd.type eq 4}">active</c:if>">
                待收货
            </div>
             <div codeFlag ="6" class="col-md-1 col four <c:if test="${pd.type eq 6}">active</c:if>">
                待评价
            </div>
        <%--  <div class="col-md-1 col four <c:if test="${pd.type eq 7}">active</c:if>">
                退换货
         </div> --%>
        </div>
        <div class="row-order-list">
            <div class="row list-header">
                <div class="col-md-3 col header-one">
                    订单信息
                </div>
                <div class="col-md-1 col header-two">
                    单价
                </div>
                <div class="col-md-2 col header-three">
                    数量
                </div>
                <div class="col-md-2 col header-four">
                    订单金额
                </div>
                <div class="col-md-2 col header-five">
                    订单状态
                </div>
                <div class="col-md-2 col header-six">
                    操作
                </div>
            </div>
         <c:set var="dataLength" value="${fn:length(page.resultPd)}"></c:set>
            <c:if test="${dataLength ne  0}">
        <c:forEach items="${page.resultPd}" var="item">   
            <div class="list-content">
                <div class="row bianhao">
                    <div class="col col-md-3 bianhao-one">
                        <span class="label-name">订单号:</span>
                        <span class="label-value">${item.order_sn}</span>
                    </div>
                    <div class="col col-md-3 bianhao-one">
                        <span class="label-name">下单时间:</span>
                        <span class="label-value">${item.create_time}</span>
                    </div>
                    <div class="col col-md-6 bianhao-two" onclick="window.location.href='/order/detail?order_id=${item.order_id}'">
                        订单详情&gt;
                    </div>
                </div>
                <div class="row bianhao-content">
                    <div class="col-md-3 col">
                        <c:forEach items="${item.goodList}" var="goods">
	                        <div class="row more-list" style="cursor: pointer;" onclick="goGoodsDetail('${goods.goods_id}');">
	                            <div class="col-md-5 col item-left">
	                                <img src="${SETTINGPD.IMAGEPATH}${goods.list_img}" onError="javascript:this.src='/img/no-img/no-img.jpg';" class="good-img" alt="">
	                            </div>
	                            <div class="col-md-6 col item-right">
	                                <div style="height: 90px;overflow: hidden;" class="xiao-title">
	                                   ${goods.goods_name}
	                                </div>
	                               <c:if test="${not empty goods.goods_attr && goods.goods_attr != '-1'}">
	                                <p class="xiaolihe">
	                                    ${goods.goods_attr}
	                                </p>
	                               </c:if>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                    <div class="col-md-1 col">
                        <c:forEach items="${item.goodList}" var="goods">
                        <div class="row more-list-money">
                            <p class="more-text">
                                ￥${goods.shop_price}
                            </p>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="col-md-2 col content-three">
                        <c:forEach items="${item.goodList}" var="goods">
                        <div class="row more-list-money">
                             <div class="col-md-3">
                             <p class="more-text">
                                ${goods.goods_count}
                            </p></div>
                         <%--    <c:if test="${item.refund_result ne 3 && item.order_status eq 5}">
	                            <div class="col-md-5" onclick="openApplyRefundPage()" style="margin-top:30px;cursor: pointer;">
	                               <p class="go-pay"> 退货</p>                 
	                            </div>
                            </c:if> --%>
                            <c:if test="${(item.order_status eq 1 || item.order_status eq 3 || item.order_status eq 2) && (goods.is_refund ne 1 && goods.is_refund ne 3)}">
	                            <div class="col-md-5" onclick="openApplyPage('${item.order_id}','${goods.goods_id}','${goods.goods_sku_id}');" style="margin-top:30px;cursor: pointer;">
	                               <p class="go-pay">退款</p>                 
	                            </div>
                            </c:if>
                            <c:if test="${goods.is_refund eq 1}">
                                <div class="col-md-5"  style="cursor: pointer;">
                                 <p style="width: 80px;color:#fc9313">退款中</p>     
                                </div>
                            </c:if> 
                            <c:if test="${goods.is_refund eq 3}">
	                              <div class="col-md-5" style="cursor: pointer;">
	                                 <p style="width: 80px;color:#fc9313">退款成功</p>
	                              </div>       
                            </c:if>
                             <c:if test="${goods.is_refund eq 2}">
	                             <div class="col-md-5" style="margin-top:30px;cursor: pointer;">
	                                <p class="go-pay">重新申请</p>
	                             </div>        
                            </c:if>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="col-md-2 col more-money">
                        ¥${item.order_money}
                    </div>
                    <div class="col-md-2 col more-money">
	                        <c:if test="${item.order_status eq 0}">待付款</c:if>
							<c:if test="${item.order_status eq 1 || item.order_status eq 2}">配货中</c:if>
							<c:if test="${item.order_status eq 3}">待发货</c:if>
							<c:if test="${item.order_status eq 4}">已发货</c:if>
							<c:if test="${item.order_status eq 5}">已送达</c:if>
							<c:if test="${item.order_status eq 6}">交易完成</c:if>
							<c:if test="${item.order_status eq 7}">已取消</c:if>
							<c:if test="${item.order_status eq 8}">订单完成</c:if>
							<c:if test="${item.order_status eq 9}">订单已关闭</c:if>
                    </div>
                    <div class="col-md-2 col more-money">
							<c:if test="${item.order_status eq 0}">
								<p class="go-pay" onclick="goPay('${item.order_id}','${item.order_sn}','${item.pay_by_money}');">付款</p>
							</c:if>
							<c:if test="${item.order_status eq 4 ||item.order_status eq 5}">
								<p class="go-pay" onclick="Order.signUp(${item.order_id});">签收</p>
							</c:if>
							<c:if test="${item.order_status eq 6}">
								<p>去评价</p>
							</c:if>
						<%-- 	<c:if test="${item.order_status eq 3 || item.order_status eq 2}">
							   <p class="go-pay" onclick="openApplyPage('${item.order_id}');"  >申请退款</p>
							</c:if> --%>
						<%--     <c:if test="${item.order_status eq 5}">
							   <p class="go-pay" onclick="Order.delOrder(${item.order_id});">申请退货</p>
							</c:if> --%>
							<c:if test="${item.pay_status eq 0}">
								 <p onclick="Order.cancleOrder(${item.order_id});">取消订单</p>
							</c:if>
							<c:if test="${item.order_status eq 7 || item.order_status eq 9}">
							     <p onclick="Order.delOrder(${item.order_id});">删除订单</p>
							</c:if>
                    </div>
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
        ${page.pageStr}
    </div>
    <div class="col-md-3"></div>
</div>
<div class="good-hot" style="margin-bottom: 40px;">
    <div class="remen-header" style="border-bottom:1px solid #E1E1E1;">热门商品</div>
    <div class="row remen-content" id="newGoodsRecommend">
    </div>
</div>
</div>
<div class="modal fade" id="zhifubaoModal" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog ticket-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                 <div class=" register-content">
			            <div class="row apply-row" style="    margin-top: 35px;">
			                 <div class="col-md-3 col apply-label" style="margin-top: 23px; margin-left: 10px;">退款原因：</div>
			                 <div class="col-md-8 col apply-value" style="margin-left: -30px;">
			                     <textarea name="refund_reason" id="refund_reason" cols="30" rows="5"></textarea>
			                     <span class="number-span">
			                         <span class="number-count"><span id="minNum">0</span>/<span id="maxNum">100</span></span>
			                     </span>
			                 </div>
			             </div>
			             <input type="hidden" name="ordeNo" value="" id="orderNo" />
			             <input type="hidden" name="goodsId" value="" id="goodsId" />
			             <input type="hidden" name="skuId" id="skuId" />
			             <c:if test="${not empty userInfo}">
			                 <input type="hidden" name="userId" id="userId" value="${userInfo.user_id}" />
			             </c:if>
			             <c:if test="${empty userInfo}">
			                 <input type="hidden" name="userId" id="userId" value="" />
			             </c:if>
					    <div class="row register-row">
					        <div class="register-button">
					            <button type="button" id="do_login" class="btn btn-warning register-btn" style="cursor: pointer;" onclick="Order.applyRefundMoney();">提交申请</button>
					        </div>
					    </div>
	              </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/duyun/pc/Order.js"></script>
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
	$(".my-order-header div").click(function(){
		$(this).siblings().children(0).removeClass("active");
		$(this).children(0).addClass("active");
		var codeFlag = $(this).attr("codeFlag");
		window.location.href="/order/list?currentPage=1&type="+codeFlag+"&order_status="+codeFlag;
	});
	$("#closeIcon").click(function(){
		 $('#zhifubaoModal').modal("hide");
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
				  htmlAry.push('<div class="good-list-content"><p><div style="height:57px;overflow: hidden;" class="list-info-text">'+data[i].goods_name+'</div>');
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
function openApplyPage(orderId,goodsId,skuId){
	$("#orderNo").val(orderId);
	$("#goodsId").val(goodsId);
	$("#skuId").val(skuId);
	alert(skuId);
	$("#zhifubaoModal").modal('show');
}
function openApplyRefundPage(orderId,goodsId){
}

function goPay(order_id,order_sn,pay_by_money){
	var orderNo = {
			order_id:order_id,
			order_sn:order_sn,
			pay_by_money:pay_by_money
	}
	window.location.href="/selectPayMethod?paramStr="+Base64.encode(JSON.stringify(orderNo));
}



</script>
</html>