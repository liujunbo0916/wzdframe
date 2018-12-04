<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>${details.TITLE}</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/zixun-del.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script> 
		<style>
		   .zaiyao{margin-top:.3rem;padding-bottom:3%;  line-height:1.9em; margin-bottom:6%;background-color:#E5E5E5; padding:6px}
		   .text-content{
				line-height: 1.6;
				font-family: Helvetica Neue",Helvetica,"Hiragino Sans GB","Microsoft YaHei",Arial,sans-serif";
				color: #333333;
				font-size: .17rem;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<!--text-box-->
			<div class="text-box">
				<h1 style="font-weight: bold;font-size: .32rem;">${details.TITLE}</h1>
				<p class="time" style="font-size: .27rem;">${details.PUTTIME}</p>
				<c:if test="${not empty details.ABSTRACT}">
			<div class="zaiyao">
	        	<div style="font-size: .23rem; width: .5rem;border: 1px solid #009FF0;float: left;text-align: center;margin-right: .14rem;margin-top: 3px;color: #009FF0;line-height: 1.4em;">摘要</div>
	            <span class="news_content" style="font-size: .27rem;">${details.ABSTRACT}</span>
	        </div>	
	        </c:if>
				<div class="txt text-content" style="font-size: .27rem;">
					 ${details.CONTENT}
				</div>
			</div>
		</div>
	</body>
	  <%@ include file="common/commJs.jsp"%>
</html>
