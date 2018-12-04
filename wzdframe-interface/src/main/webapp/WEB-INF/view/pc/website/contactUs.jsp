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
<jsp:include page="../comm/resource.jsp" flush="true" />
<link rel="stylesheet" href="<%=basePath %>/statics/css/hanguanEd.css" />
<title>联系我们</title>
</head>
<body>
<jsp:include page="../comm/header.jsp" flush="true" />
<div class="content">
	<div class="cTitle"><span>${web.TITLE }</span>&nbsp;&nbsp;&nbsp;<span style="color:#55C521;">${web.CTITLE }</span></div>
    <div class="cContent">
    <div class="cCon">
    ${web.CONTENT}
    </div>
    </div>
</div>
<jsp:include page="../comm/footer.jsp" flush="true" />
</body>
</html>