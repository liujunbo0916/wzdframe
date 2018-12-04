<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
<meta http-equiv="Content-Type" content="text/html;  charset=utf-8" />
<link rel="stylesheet" href="/css/duyun/pc/hanguanEd.css" />
 <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">
<title>${dataModel.website_title}</title>
</head>
<body>
<%@ include file="../common/ercode.jsp"%>
<%@ include file="../common/navi.jsp"%>
<div class="content">
	<div class="cTitle"><span style="color:#55C521;">${dataModel.website_title}</span></div>
    <div class="cContent">
    <div class="cCon">
    ${dataModel.website_abstract}
 </div>
    </div>
</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>