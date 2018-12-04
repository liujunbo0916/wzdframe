<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
</head>

<body class="gray-bg">
	<form action="/sys/order/refund/refundFinish" method="post"
		class="form-horizontal" id="commentForm"><input type="hidden" name="order_id" value="${order_id}">
		<input type="hidden" name="order_goods_id" value="${order_goods_id}">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>退货操作</h5>
					<p style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;管理员操作退款将直接退款成功。请谨慎操作</p>
				</div>
				<div class="ibox-content">
				      <div class="tab-content">
							<div class="form-group">
    							<label class="col-sm-2 control-label">退款金额：</label>
    							<div class="col-sm-4">
       						         <input type="text" name="returnMoney" id="returnMoney"
									class="form-control" value="${dateModel.returnMoney}" disabled="disabled"  /> 
    							</div>
    							<div class="col-sm-4">
    							   <p>退还的金额等于支付该商品金额减去积分使用的金额</p>
    							</div>
							</div>	
				            <div class="form-group">
    							<label class="col-sm-2 control-label">回收积分：</label>
    							<div class="col-sm-4">
       						        <input type="text" name="recovery" value="${dateModel.recovery}"  class="form-control" disabled="disabled"  /> 
    							</div>
    							<div class="col-sm-4">
    							   <p>用户购买商品所获取的积分将会被系统收回</p>
    							</div>
							</div>	
					   		<div class="form-group">
    							<label class="col-sm-2 control-label">退回积分${dateModel.returnPoint}：</label>
    							<div class="col-sm-4">
       						        <input type="text" name="returnPoint"  class="form-control" value="${dateModel.returnPoint}" disabled="disabled" /> 
    							</div>
    							<div class="col-sm-4">
    							   <p>如果用户支付采用了积分支付可将积分退回</p>
    							</div>
							</div>				
							<div class="form-group">
    							<div class="col-sm-4 col-sm-offset-3">
								<button class="btn btn-primary" type="button" onclick="sub();">
									<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
								</button>
								<button class="btn btn-warning" onclick="closed();">
									<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
								</button>
							</div>
							</div>		
					</div>
					</div>
				</div>
			</div>
	</form>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
</body>
<script type="text/javascript">

var index = parent.layer.getFrameIndex(window.name);	
function closed(){
	parent.layer.close(index);
}

function sub(){
	bootbox.confirm("确定执行退货操作，操作完之后将不可恢复",function(result){
		if(result){
			Ajax.request("/sys/order/refund/refundFinish",{"data":$("#commentForm").serialize(),"success":function(data){
				if(data.result == 200){
					parent.location.reload();
					closed();
				}else{
					bootbox.alert(data.msg);
				}
			}});
		}
		
	})
}



</script>


</html>