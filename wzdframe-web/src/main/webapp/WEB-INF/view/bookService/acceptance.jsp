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
                        <h5>受理反馈</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="#" method="post" class="form-horizontal m-t" id="editForm" >
							<div class="row">
                                	<div class="form-group">
		    							<label class="col-sm-2 control-label">反馈信息（可为空）：</label>
		    							<div class="col-sm-10">
		       						         <div class="input-group">
				                                <textarea rows="10" cols="20" id="replay" name="replay">${dataModel.replay}</textarea>
				                            </div>
		    							</div>
									</div>
									 <div class="form-group">
		                                <div class="col-sm-4 col-sm-offset-3">
		                                    <button class="btn btn-primary" type="button" onclick="checkParam();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
		                                    <button class="btn btn-warning" type="button" onclick="closed();"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
		                                </div>
		                            </div>
	                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
</body>
<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	function closed(){
		  parent.layer.close(index);
	 }
  function checkParam(){
	   Ajax.request("/sys/book/order/acceptance",{"data":{"id":'${pd.id}',"status":2,"replay":$("#replay").val()},
		   "success":function(data){
		      if(data.code  == 200){
		    	  parent.location.reload();
		    	  closed();
		      }
	   }});
  }
</script>
</html>