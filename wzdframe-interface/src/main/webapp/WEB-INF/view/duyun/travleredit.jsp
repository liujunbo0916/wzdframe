<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
		 <title>出行人详情</title> 
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
		<link href="/css/add-address.css" rel="stylesheet" />
		<script src="/js/shipei.js"></script>
	</head>

	<body>
		<div class="wrap-box">
			<div class="content">
				<div class="inpt">
					<label>出行人姓名：</label>
					<input name="travelers_id" type="hidden" value="${dataModel.travelers_id}" id="travelers_id" />
					<input type="text" id="travelers_name" name="travelers_name" value="${dataModel.travelers_name}"/>
				</div>
				<div class="inpt">
					<label>联系电话：</label>
					<input type="number" name="travelers_phone" id="travelers_phone" value="${dataModel.travelers_phone}" />
				</div>
				<div class="inpt">
					<label>身份证号码：</label>
					<input type="number" name="travelers_no" style="width: 250px" id="travelers_no" value="${dataModel.travelers_no}" />
				</div>
				<div class="inpt">
					<label>性别:</label>
					<div style="display: inline;">
					<input type="radio" name="travelers_gender"  <c:if test="${empty dataModel.travelers_gender || dataModel.travelers_gender==1}">checked="checked" </c:if>  id="travelers_gender" value="1" />
					<label style="width: 1px">男</label>
					</div>
					<div style="display: inline; margin-left: 100px">
					<input type="radio" name="travelers_gender"  id="travelers_gender" <c:if test="${dataModel.travelers_gender == 0}">checked="checked" </c:if> value="0" />
					<label>女</label>
					</div>
				</div>
			</div>
		</div>
		<div class="wrap text-center fred" onclick="Travler.editAddTravler();">保存</div>
		 <%@ include file="common/commJs.jsp"%>
		 <script src="/js/page/travler.js"></script>
		<!-- <script src="/js/LArea.js"></script> -->
		<!-- 地址选择控件 -->
		<script type="text/javascript">
		/* Travler.travler:{
			travelers_id:'',
			travelers_name:'',
			travelers_type:'1',
			travelers_no:'',
			travelers_phone:'',
			travelers_gender:'',
		}, */
		Travler.travler.travelers_id='${dataModel.travelers_id}';
		Travler.travler.travelers_name='${dataModel.travelers_name}';
		Travler.travler.travelers_no='${dataModel.travelers_no}';
		Travler.travler.travelers_phone='${dataModel.travelers_phone}';
		Travler.travler.travelers_phone='${dataModel.travelers_phone}';
		Travler.travler.travelers_gender='${dataModel.travelers_gender}';
		</script>
	</body>
</html>