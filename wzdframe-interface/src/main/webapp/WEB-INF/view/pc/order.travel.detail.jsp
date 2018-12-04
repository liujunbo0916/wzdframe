<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-sure-detail.css" type="text/css">
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
                  <c:if test="${dataModel.orderState eq 0}">
                       <p>待付款</p>
                  </c:if>
                   <c:if test="${dataModel.orderState eq 1}">
                       <p>待出行</p>
                  </c:if>
                    <c:if test="${dataModel.orderState eq 2}">
                       <p>已完成</p>
                  </c:if>
                  <c:if test="${dataModel.orderState eq 3}">
                       <p>已取消</p>
                  </c:if>
                   <c:if test="${dataModel.orderState eq 4}">
                       <p>退款中</p>
                  </c:if>
                  <c:if test="${dataModel.orderState eq 5}">
                       <p>已退款</p>
                  </c:if>
                   <c:if test="${dataModel.orderState eq 6}">
                       <p>订单已关闭</p>
                  </c:if>
            </div>
            <div class="col-md-3 wait-money">
                ￥ ${dataModel.totalPrice}
            </div>
        </div>
        <div class="row middle-content">
            <div class="col-md-4">
                <span>订单编号：</span>
                <span class="order-tel">${dataModel.orderSn}</span>
            </div>
            <div class="col-md-3">
                <span>下单时间：</span>
                <span class="order-tel">${dataModel.createTime}</span>
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
                    <span class="info-text">路线信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                       ${dataModel.grouptourName}
                    </div>
                    <div class="row router-information-row">
                        <span class="info-item">
                            <span>出行日期:</span>
                            <span>${dataModel.departureDate}</span>
                        </span>
                       <c:if test="${not empty dataModel.adultNum && dataModel.adultNum > 0}">
	                        <span class="info-item">
	                            <span>成人:</span>
	                            <span>¥ ${dataModel.adultPrice} * ${dataModel.adultNum}</span>
	                        </span>
                       </c:if>
                        <c:if test="${not empty dataModel.childrenNum && dataModel.childrenNum > 0}">
	                       <span class="info-item">
                            <span>儿童:</span>
                            <span>¥ ${dataModel.childrenPrice} * ${dataModel.childrenNum}</span>
                        </span>
                       </c:if>
                        <span class="info-item">
                            <span>总价:</span>
                            <span class="info-amount">￥ ${dataModel.totalPrice}</span>
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
                             ${dataModel.linkPerple}
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="label-name">联系电话:</span>
                        </div>
                        <div class="route-value">
                             ${dataModel.linkPhone}
                        </div>
                    </div>
                </div>
            </div>
            <div class="order-info-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">出游人信息</span>
                </div>
                <div class="row trip-content">
                    
                 <c:forEach items="${dataModel.traveler}" var="item" varStatus="status">   
                    <div class="col-md-6 trip-left">
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">出游人${status.index+1}:</span>
                            </div>
                            <div class="route-value">
                               ${item.name}
                            </div>
                        </div>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">身份证号码:</span>
                            </div>
                            <div class="route-value">
                                 ${item.idCard}
                            </div>
                        </div>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">联系电话:</span>
                            </div>
                            <div class="route-value">
                                 ${item.phone}
                            </div>
                        </div>
                    </div>
                </c:forEach>    
                    <!-- <div class="col-md-6 trip-right">
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">出游人2:</span>
                            </div>
                            <div class="route-value">
                                张三2
                            </div>
                        </div>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">身份证号码:</span>
                            </div>
                            <div class="route-value">
                                665411222

                            </div>
                        </div>
                        <div class="row router-information-row">
                            <div class="col-md-6 label-div">
                                <span class="label-name">联系电话:</span>
                            </div>
                            <div class="route-value">
                                122566899000
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="./js/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
</body>
</html>