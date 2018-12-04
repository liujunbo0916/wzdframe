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
	<%@ include file="../common/top.jsp"%>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>受理申请</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/culture/category/editAction" method="post" class="form-horizontal m-t" id="editForm" >
                            <input type="hidden" name="id" value="${dataModel.id}" />
							<div class="row">
								<div class="form-group">
		    							<label class="col-sm-2 control-label">联系人：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="con_name" name="con_name" value="${dataModel.con_name}">
				                            </div>
		    							</div>
									</div>
										<div class="form-group">
		    							<label class="col-sm-2 control-label">联系电话：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="con_phone" name="con_phone" value="${dataModel.con_phone}">
				                            </div>
		    							</div>
									</div>
									
										<div class="form-group">
		    							<label class="col-sm-2 control-label">预约地点：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="book_address" name="book_address" value="${dataModel.book_address}">
				                            </div>
		    							</div>
									</div>
										<div class="form-group">
		    							<label class="col-sm-2 control-label">旅游人数：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="number" class="form-control" id="person_number" name="person_number" value="${dataModel.person_number}">
				                            </div>
		    							</div>
									</div>
									<div class="form-group">
		    							<label class="col-sm-2 control-label">预约时间：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="book_time" name="book_time" value="${dataModel.book_time}">
				                            </div>
		    							</div>
									</div>
									    <div class="form-group">
									        <label class="col-sm-2 control-label">受理状态：</label>
									        <div class="col-sm-9">
									            <label class="radio-inline">
									                <input type="radio" <c:if test="${dataModel.guide_status eq 1}">checked="checked"</c:if> value="1"  name="guide_status">待受理</label>
									            <label class="radio-inline">
									                <input type="radio"  <c:if test="${dataModel.guide_status eq 2}">checked="checked"</c:if> value="2"  name="guide_status">已受理</label>
									        </div>
									    </div>
									<div class="form-group">
		    							<label class="col-sm-2 control-label">导游信息（可为空）：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="guider" name="guider" value="${dataModel.guider}">
				                            </div>
		    							</div>
									</div>
									 <div class="form-group">
		                                <div class="col-sm-4 col-sm-offset-3">
		                                    <button class="btn btn-primary" type="button" onclick="checkParam();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
		                                    <button class="btn btn-warning" type="button" onclick="window.history.go(-1);"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
		                                </div>
		                            </div>
	                            </div>
	                        </div>
                        </form>
                    </div>
                </div>
        </div>
    </div>
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
</body>
<script type="text/javascript">
function checkParam() {
	   if($("#con_name").val().isEmpty() || $("#con_name").val().length > 10){
		   bootbox.alert("联系人不能为空切小于10个字符");
		   return;
	   }
	   if($("#book_address").val().isEmpty() || $("#book_address").val().length > 100){
		   bootbox.alert("预约地点不能为空且小于100个字符");
		   return;
	   }
	   if($("#person_number").val().isEmpty() || !$("#person_number").val().isNumber() || $("#person_number").val() < 0 || $("#person_number").val() > 100000){
		   bootbox.alert("预约人数格式不正确");
		   return;
	   }
	   if($("#con_phone").val().isEmpty() || !$("#con_phone").val().isPhone()){
		   bootbox.alert("联系电话格式不正确");
		   return;
	   }
	   Ajax.request("/sys/book/order/guideEdit",{"data":$("#editForm").serialize(),
		   "success":function(data){
		      if(data.code  == 200){
		    	 window.location.href='/sys/book/order/guideOrder';
		      }
	   }});
}
</script>



</html>