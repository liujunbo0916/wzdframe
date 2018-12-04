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
.form-control{
    width: 250px;

}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							新增
							商品属性
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/goodsTypeAttr/save" method="post"
							class="form-horizontal m-t" id="commentForm">

							<div class="form-group">
								<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>属性名称：</label>
								<div class="col-sm-8">
									<input type="text" name="attr_name" id="attr_name"
										class="form-control" value="" required />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">所属商品类型：</label>
								<div class="col-sm-8">
								    <input type="hidden" name="goods_type_id" id="goods_type_id" value="${pd.goods_type_id}" />
									<input type="text" name="type_name" id="type_name" class="form-control" value="${pd.type_name}" readonly="readonly"/>
									<%-- <select name="" class="form-control" style="width:100px;">
									   <c:forEach var="type" items="${goods_type}">
								           <option value="${type.type_code}">${type.type_name}</option>
								       </c:forEach>
									</select> --%>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>排序：</label>
								<div class="col-sm-8">
									<input type="text" name="attr_sort" id="attr_sort" class="form-control" value="" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">是否为销售属性：</label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" checked="checked" name="is_sale" value="1" />是</label>
								    <label class="radio-inline"><input type="radio" name="is_sale" value="0"/>否</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">属性是否支持搜索：</label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" checked="checked" name="is_search" value="1" />是</label>
								    <label class="radio-inline"><input type="radio" name="is_search" value="0"/>否</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">同属性值关联：</label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" checked="checked" name="is_linked" value="1" />是</label>
								    <label class="radio-inline"><input type="radio" name="is_linked" value="0"/>否</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">属性录入方式：</label>
								<div class="col-sm-8" id="wrap">
								<!-- 1单行文本，2多行文本，3单选，4多选  单行的多行默认为手工录入，单选和多选默认为列表录入-->
									<label class="radio-inline"><input type="radio" checked="checked" name="attr_input" value="1" onchange="attrv()"/>手工录入</label>
								    <label class="radio-inline"><input type="radio" name="attr_input" value="2" onchange="attrv()"/>多行文本</label>
								    <label class="radio-inline"><input type="radio" name="attr_input" value="3" onchange="attrv()"/>单选</label>
								    <label class="radio-inline"><input type="radio" name="attr_input" value="4" onchange="attrv()"/>多选</label>
								</div>
							</div>
							<div class="form-group" style="display: none" id="isattr">
								<label class="col-sm-2 control-label">属性可选值：</label>
								<div class="col-sm-8">
										<textarea placeholder="多个分组换行分隔" name="attr_values"
										id="attr_values" class="form-control" rows="5">${dataModel.attr_values}</textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button" onclick="checkParam();">
										<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
									</button>
									<button class="btn btn-warning" onclick="history.go(-1)">
										<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
									</button>
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
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
	    function attrv(){
	    	var val_payPlatform = $('#wrap input[name="attr_input"]:checked ').val();
	    	if(val_payPlatform == 3 || val_payPlatform ==4 ){
	    		$('#isattr').css('display','block');
	    	}
	    	if(val_payPlatform == 1 || val_payPlatform ==2 ){
	    		$('#isattr').css('display','none');
	    	}
	    }
	
	    
	    function checkParam(){
	    	if($("#attr_name").val().isEmpty()){
	    		bootbox.alert("请输入属性名字");
	    		return;
	    	}
	    	if($("#attr_name").val().trim().length > 50){
	    		bootbox.alert("属性名字在50个字符以内");
	    		return;
	    	}
	    	if($("#goods_type_id").val().isEmpty()){
	    		bootbox.alert("类型不能为空");
	    		return;
	    	}
	    	if(!$("#attr_sort").val()){
		    	   bootbox.alert("排序不能为空");
		    	   return;
	    	}
	    	if(!$("#attr_sort").val().isNumber()){
	    		bootbox.alert("请输入正确的数字");
		    	   return;
	    	}
	    	if($("#attr_sort").val() < 0 || $("#attr_sort").val() > 100000){
	    		bootbox.alert("请输入正确的数字");
		    	   return;
	    	}
	    	$("#commentForm").submit();
	    }
	</script>
</body>
</html>