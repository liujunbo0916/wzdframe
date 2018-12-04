<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>关注</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/home-nav.css" rel="stylesheet"/>
		<link href="/css/cart.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<div class="cart-wrap">
		    <div class="bianji-box clearfix f999">
		    </div>
			<!--box-list-->
			       <div class="box-list clearfix">
						<div class="border-bottom box-img-text">
						 <center><div>欢迎关注黄道微医</div></center>
						  <%--   <img alt="" src="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=${ticket.ticket}"> --%>
						  <img style="margin-top: 20px;" alt="" src="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=${ticket.ticket}">
						   <center><div style="margin-top:30px;color:red">长按图中二维码，识别二维码，关注</div></center>
						    <center><div style="margin-top:10px">关注我们获得更多服务</div></center>
						</div>
					</div>
			<!--box-list-->
			<!--结算-->
		</div>
		<!--nav-->
		 <%@ include file="commJs.jsp"%>
	</body>
</html>
