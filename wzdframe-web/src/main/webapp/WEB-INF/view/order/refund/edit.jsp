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
<link href="/assets/css/plugins/summernote/summernote.css"
	rel="stylesheet">
<link href="/assets/css/plugins/summernote/summernote-bs3.css"
	rel="stylesheet">
</head>

<body class="gray-bg">
	<form action="/sys/order/ordersShipping/save" method="post"
		class="form-horizontal" id="commentForm">
		<div class="wrapper wrapper-content">
			<div class="row">
					<div class="col-sm-13">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>
									<c:if test="${not empty dataModel}">编辑</c:if>
									发货单
								</h5>
							</div>
				<form action="/sys/course/editAction" method="post" id="commentForm">
							<div class="ibox-content">
								<input type="hidden" name="shipping_id" value="${dataModel.shipping_id}" />
								 <input type="hidden" name="ex_code" id="ex_code" class="form-control"  required/>
								<div class="tab-content">
							<div class="form-group">
    							<label class="col-sm-2 control-label">所属订单：</label>
    							<div class="col-sm-8">
       						         <input type="text" disabled="disabled" class="form-control"  value="${dataModel.order_sn}"/>
    							</div>
							</div>	
							<div class="form-group">
    							<label class="col-sm-2 control-label"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*&nbsp;</font>货运单号：</label>
    							<div class="col-sm-8">
       						         <input type="text" name="bill_no" id="bill_no" class="form-control"  required/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*&nbsp;</font>配送公司：</label>
    							<div class="col-sm-8">
    							     <select name="ex_name" id="ex_name" class="form-control">
    							        <option>--请选择快递公司--</option>
    							        <c:forEach items="${companyList}" var="company">
    							           <option value="${company.desc}" data-code="${company.code}">${company.desc}</option>
    							        </c:forEach>
    							     </select>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*&nbsp;</font>配送费用：</label>
    							<div class="col-sm-8">
    							     <input type="text" name="ex_money" id="ex_money" class="form-control"  required/>
    							</div>
							</div>
							
							<div class="form-group">
    							<label class="col-sm-2 control-label">所属订单：</label>
    							<div class="col-sm-8">
       						         <input type="text" disabled="disabled" class="form-control"  value="${dataModel.order_sn}"/>
    							</div>
							</div>	
							
							
							<div class="form-group">
    							<label class="col-sm-2 control-label">管理员备注：</label>
    							<div class="col-sm-8">
    							    <textarea id="note_admin" name="note_admin" cols="80" rows="3"></textarea>
    							</div>
							</div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="sub();"><i class="fa fa-check"></i>&nbsp;&nbsp;生成发货单&nbsp;&nbsp; </button>
                                    <button class="btn btn-warning" type="button" onclick="closed();"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
                                </div>
                            </div>
								</div>
							</div>
						</form>
						</div>
					</div>
			</div>
		</div>
	</form>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript">
		function  sub(){
			bootbox.confirm("确定生成发货单？",function(result){
				if(result){
					if($("#bill_no").val().isEmpty()){
						bootbox.alert("运单号不能为空");
						return;
					}
					if($("#ex_name").val().isEmpty()){
						bootbox.alert("请选择快递公司");
						return;
					}
					if(!$("#ex_money").val().isMoney()){
						bootbox.alert("无效金额数据");
						return;
					}
					$("#ex_code").val($("#ex_name").find("option:checked").attr("data-code"));
					Ajax.request("/sys/order/orders/generateDeliverBill",{"data":$("#commentForm").serialize(),"success":function(data){
						if(data.result == 200){
							parent.location.reload();
							closed();
						}
					}});
				}
			});
		}
</script>
</body>
</html>