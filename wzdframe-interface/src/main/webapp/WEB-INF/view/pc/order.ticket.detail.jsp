<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-sure-detail.css" type="text/css">
    <style type="text/css">
      .icon_discount{
            width: 60px;
		    height: 28px;
		    position: absolute;
		    left: 370px;
            top: 23px;
		    background: #fc9313;
		    font-size: 13px;
		    color: #fff;
		    font: normal 18px/28px tahoma,arial;
		    text-align: center;
      }
	   .icon_discount i {
		    height: 0;
		    width: 0;
		    overflow: hidden;
		    border-top: 6px solid #fc9313;
		    border-left: 30px dashed transparent;
		    border-right: 30px dashed transparent;
		    border-bottom: none;
		    position: absolute;
		    left: 0;
		    bottom: -6px;
		}
		
		.no_use{
		      background: #24c6c8;
		}
		
		.no_use i{
		   border-top: 6px solid #24c6c8;
		}
		.refuned{
		     background:#DEDFDF;
		}
		.refuned i{
	    	border-top: 6px solid #DEDFDF;
		}
		.refunding{
		    background:#F8AC5A;
		}
		.refunding i{
	    	border-top: 6px solid #F8AC5A;
		}
	    </style>
    
    
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="sure-body">
    <div class="sure-header">
        <span class="my-order">我的订单</span>
        <span class="order-line">/</span>
        <span class="order-text">订单详情</span>
    </div>
    <div class="sure-middle">
        <div class="row wait-content">
            <div class="col-md-9 wait-go">
               <c:if test="${empty orderInfo.to_refund_status || orderInfo.to_refund_status ne 3}"> 
                    <c:if test="${orderInfo.to_status eq 1}">
                        <p>待付款</p>
                    </c:if>
                    <c:if test="${orderInfo.to_status eq 2 || orderInfo.to_status eq 5}">
                        <p>待使用</p>
                    </c:if>
                    <c:if test="${orderInfo.to_status eq 3}">
                        <p>已使用</p>
                    </c:if>
                     <c:if test="${orderInfo.to_status eq 4}">
                        <p>已取消</p>
                    </c:if>
                    <c:if test="${orderInfo.to_status eq 6}">
                        <p>交易关闭</p>
                    </c:if>
               </c:if>
               <c:if test="${orderInfo.to_refund_status eq 3}"> 
                                                                  已退票
              </c:if>
            </div>
            <div class="col-md-3 wait-money">
                                                    ￥ ${orderInfo.to_order_money}
            </div>
        </div>
        <div class="row middle-content">
            <div class="col-md-4">
                <span>订单编号：</span>
                <span class="order-tel">${orderInfo.ticket_order_no}</span>
            </div>
            <div class="col-md-3">
                <span>下单时间：</span>
                <span class="order-tel">${orderInfo.to_create_time}</span>
            </div>
            <div class="col-md-2"></div>
            <div class="col-md-3 order-money">
                订单金额
            </div>
        </div>
    </div>
    <div class="row travel-sure-content">
        <div class="col-md-8 order-info">
            <div class="order-info-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">票务信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                          <c:if test="${not empty orderInfo.to_scenic_name}">${orderInfo.to_scenic_name} -</c:if> ${orderInfo.to_ticket_name}
                          <c:if test="${not empty orderInfo.to_cate_name}">
                                                                                         （${orderInfo.to_cate_name}）
                          </c:if>
                    </div>
                    <div class="row router-information-row">
                        <span class="info-item">
                            <span>未使用:</span>
                            <span style="color: #fc9313;">${orderInfo.noUseTicket}张</span>
                        </span>
                        <span class="info-item">
                            <span>已使用:</span>
                            <span style="color: #fc9313;">${orderInfo.alUseTicket}张</span>
                        </span>
                        <span class="info-item">
                            <span>已退票:</span>
                            <span style="color: #fc9313;">${orderInfo.refundTicket}张</span>
                        </span>
                    </div>
                    <div class="row router-information-row">
                        <span class="info-item">
                            <span>出行日期:</span>
                            <span>${orderInfo.to_travel_date}</span>
                        </span>
                        <span class="info-item">
                          <c:if test="${not empty orderInfo.to_cate_name}">
                               <span>${orderInfo.to_cate_name}:</span>
                          </c:if>
                            <span>¥${orderInfo.to_settlement_price} * ${orderInfo.to_quantity }</span>
                        </span>
                        <span class="info-item">
                            <span>总价:</span>
                            <span class="info-amount">￥${orderInfo.to_settlement_price*orderInfo.to_quantity}</span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="order-info-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">联系人信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">姓名:</span>
                        </div>
                        <div class="route-value">
                           ${orderInfo.to_contact_name }
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">联系电话:</span>
                        </div>
                        <div class="route-value">
                            ${orderInfo.to_contact_mobile}
                        </div>
                    </div>
                </div>
            </div>
        <c:if test="${orderInfo.to_is_realname eq '1' && showRow >= 1}">    
            <div class="order-info-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">出游人信息</span>
                </div>
              <c:forEach  begin="0" end="${showRow-1}" var="ll">
                <div class="row trip-content">
                   <c:forEach items="${traverInfo}" begin="${ll*2}" end="${ll*2+1}" var="item" varStatus="status">   
                    <div class="col-md-6 trip-left">
                        <c:choose>
	                         <c:when test="${not empty item.used_quantity && item.used_quantity eq 1}">
	                             <em class="icon_discount">已使用<i></i></em>
	                            </c:when>
	                         <c:when test="${not empty item.refund_quantity && item.refund_quantity eq 1}">
	                            <em class="icon_discount refuned">已退票<i></i></em>
	                        </c:when>
	                         
	                         <c:when test="${not empty item.apply_refund_quantity && item.apply_refund_quantity eq 1}">
	                            <em class="icon_discount refunding">退票中<i></i></em>
	                        </c:when>
	                         <c:otherwise><em class="icon_discount no_use">未使用<i></i></em></c:otherwise>
                        </c:choose>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">出游人${status.index+1}:</span>
                            </div>
                            <div class="route-value">
                                          ${item.to_name}
                            </div>
                        </div>
                        
                        <c:if test="${not empty item.ticket_code}">
		                         <div class="row router-information-row">
		                            <div class="col-md-6 label-div">
		                                <span class="label-name">票号:</span>
		                            </div>
		                            <div class="route-value">
		                                        ${item.ticket_code}
		                            </div>
		                        </div>
                        </c:if>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">身份证号码:</span>
                            </div>
                            <div class="route-value">
                                ${item.to_idcard}
                            </div>
                        </div>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">联系电话:</span>
                            </div>
                            <div class="route-value">
                                        ${item.to_phone}
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                </c:forEach>
            </div>
         </c:if>   
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
</body>
</html>