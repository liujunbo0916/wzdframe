<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row login-container">
    <div class="col-md-8"></div>
    <div class="col-md-4">
        <div class="row login-header">
            <c:if test="${empty userInfo}">
	            <span class="login-text" onclick="window.location.href='/login'">登陆</span>
	            <span class="login-text" onclick="window.location.href='/register'">注册</span>
            </c:if>
            <c:if test="${not empty userInfo}">
                 <span class="login-text" style=" color:rgb(243, 133, 15); cursor: pointer;" onclick="window.location.href='/logout'">退出</span>
                 <span class="login-text">欢迎您：<span style=" color:rgb(243, 133, 15);">${userInfo.user_name}</span></span>
                 <span class="login-line"></span>
                 <span class="login-text" style="cursor: pointer;" onclick="window.location.href='/order/list';"> 我的订单</span>
            </c:if>
            <span class="login-text">联系我们</span>
        </div>
    </div>
</div>