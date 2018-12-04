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
	<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
	<%@ include file="../common/top.jsp"%>
	<link href="/assets/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="/assets/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
	<style type="text/css">
	.file-pick {
	    font-size: 18px;
	    background: #00b7ee;
	    border-radius: 3px;
	    line-height: 44px;
	    padding: 0 30px;
	    color: #fff;
	    display: inline-block;
	    margin: 0 auto 20px auto;
	    cursor: pointer;
	    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	}
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><c:if test="${not empty dataModel}">编辑</c:if><c:if test="${empty dataModel}">新增</c:if>酒店类型</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/hotel/typesavePage" method="post" class="form-horizontal m-t" id="commentForm">
                             
							<input type="hidden" name="hotel_type_id" id="hotel_type_id" value="${dataModel.hotel_type_id}" />
							<div class="form-group">
    							<label class="col-sm-2 control-label">类型名称：</label>
    							<div class="col-sm-8">
       						<input type="text" name="hotel_type_name" id="hotel_type_name" class="form-control" value="${dataModel.hotel_type_name}" required/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">排序：</label>
    							<div class="col-sm-3">
    						    	<input type="number" name="hotel_type_sort" id="hotel_type_sort" class="form-control" value="${dataModel.hotel_type_sort}" required/>
    							</div>
							</div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="valication()"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
                                    <button class="btn btn-warning" type="button" onclick="history.go(-1)"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
<!-- 自定义js -->
    <script type="text/javascript">
        function valication(){
        	if($("#hotel_type_name").val().isEmpty()){
        		bootbox.alert("类型名称不能为空");
        		return false;
        	}
        	if($("#hotel_type_name").val().length > 10){
        		bootbox.alert("类型名称应该在10个字符以内");
        		return false;
        	}
        	if($("#hotel_type_sort").val().isEmpty() || $("#hotel_type_sort").val() < 0 || $("#hotel_type_sort").val() > 500){
        		bootbox.alert("请输入正确的排序数字");
        		return false;
        	}
        	$("#commentForm").submit();
        }
        $(function(){
        	//抓取回排序名次
        	$("#category_order").blur(function(){
        		Ajax.request("/sys/goods/goodsCategory/selectOrder.do?orderValue="+$(this).val(),{"success":function(data){
        			if(data.result == 200){
        				$("#categoryOrderDesc").text("当前系统最大值"+data.data.maxValue+",当前排名"+data.data.orderValue);
        			}
        		}});
        	});
        });
    </script>
</body>
</html>