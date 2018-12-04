<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><c:if test="${not empty dataModel}">编辑</c:if><c:if test="${empty dataModel}">新增</c:if>商品类型</h5>
                    </div>
                    <div class="ibox-content icons-box">
                       <c:forEach items="${allBrand}" var="brand">
                        <div>
                            <h3>${brand.key}</h3>
                            <c:forEach items="${brand.value}" var="item">
                                 <c:set value="0" var="flag"></c:set>
                                 
                                 <c:forEach items="${brandIds}" var="brandids">
                                      <c:if test="${item.brand_id eq  brandids}">
                                            <c:set value="1" var="flag"></c:set>
                                      </c:if>
                                 </c:forEach>
                                 <div class="infont col-md-3 col-sm-4"><a href="javascript:;"> 
                                    <input type="checkbox" <c:if test="${flag eq 1}">checked='checked'</c:if> value="${item.brand_id}" name="brand" >
                                    ${item.brand_name}</a></div>
                            </c:forEach>
                            <div class="clearfix"></div>
                        </div>
                        </c:forEach>
                             <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="sub();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
                                    <button class="btn btn-warning" type="button" onclick="closed();"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript">
	  var index = parent.layer.getFrameIndex(window.name);	
	  function closed(){
			parent.layer.close(index);
		}
	  function sub(){
		  var brands = [];
		  $("input[name='brand']:checked").each(function(){
			  brands.push($(this).val());
		  });
		  
		  if(brands.length == 0){
			  bootbox.alert("您未选择任何一个品牌");
			  return;
		  }
		  parent.getSelectBrand(brands.join(","));
		  closed();
	  }
	</script>
	
	
	
</body>
</html>