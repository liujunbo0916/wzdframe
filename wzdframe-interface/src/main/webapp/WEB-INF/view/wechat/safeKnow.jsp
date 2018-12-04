<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>安全须知</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/anquanxz.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script> 
	</head>
	<body>
		<div class="container">
			<h1 style="font-size:22px;">参观游览安全须知</h1>
			<p style="font-size:18px;">欢迎您来到涠洲岛，为方便您安全的参观游览请您详细阅读以下须知：</p>
			<div class="text-box" style="font-size:16px;">
				${dataModel.safe_know}
			</div>
		</div>
	</body>
</html>
