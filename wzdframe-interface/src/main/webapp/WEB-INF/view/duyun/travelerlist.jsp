<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		 <title>出行人地址</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/address.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
		<style type="text/css">
			.checkedItem, #allCheckedInput {
				-webkit-appearance: none;
				border-radius: 0px;
				border: 0px;
				width: 0px;
				-webkit-tap-highlight-color: transparent;
				outline: none;
				background: none;
				text-decoration: none;
			}
		</style>
		
	</head>
	<body>
	<!--  1身份证 2护照 3军官证 4驾驶证 5学生证 6回乡证 7港澳通行证 8台湾通行证 9其他 -->
	<!-- {travelers_phone=18693396666, travelers_name=测试姓名2, user_id=0, travelers_id=2, travelers_gender=0, travelers_type=2, travelers_no=4949595665665565656} -->
		<c:forEach items="${dataModel}" var="item">
			<div class="address-box">
				<div class="text-box">
					<p>${item.travelers_name}&nbsp;&nbsp;${item.travelers_phone}</p>
					<p style="margin-top: 10px"><c:if test="${item.travelers_type == 1}">身份证 </c:if>
						<c:if test="${item.travelers_type == 2}">护照 ：</c:if>
						<c:if test="${item.travelers_type == 3}">军官证 ：</c:if>
						<c:if test="${item.travelers_type == 4}">驾驶证 ：</c:if>
						<c:if test="${item.travelers_type == 5}">学生证 ：</c:if>
						<c:if test="${item.travelers_type == 6}">回乡证 ：</c:if>
						<c:if test="${item.travelers_type == 7}">港澳通行证：</c:if>
						<c:if test="${item.travelers_type == 8}">台湾通行证 ：</c:if>
						<c:if test="${item.travelers_type == 9}">其他证件 ：</c:if>
					&nbsp;&nbsp;${item.travelers_no}</p>
					<p style="margin-top: 10px">性别：
						<c:if test="${item.travelers_gender == 0}">女 </c:if>
						<c:if test="${item.travelers_gender == 1}">男 </c:if>
						</p>
				</div>
				<div class="clearfix inpt-box">
					<div class="check-box l" style="width: 100px;" onclick="checkedBOX(this)">
						<label style="display:inline;float: inherit; margin-left: 10px;color: white;">0</label>
						<input id="travelers_id" name="travelers_id" style="width: 17px;height: 17px;" type="checkbox" value="${item.travelers_id}" 
						<c:forEach items="${pd.travelerIds}" var="iditem">
							<c:if test="${iditem == item.travelers_id}"> checked="checked"</c:if>
						</c:forEach>
						/>
					</div>
					<div class="r icon-box f666 ">
						<a href="/wx/duyun/user/dotravelersedit?travelers_id=${item.travelers_id}"><i class="icon icon_bianj" ></i>编辑</a>
						<a href="javascript:Travler.delTravler('${item.travelers_id}');"><i class="icon icon_shanc" ></i>删除</a>
					</div>
				</div>
			</div>
		</c:forEach>
		<div class="cart-js" style="margin-bottom: 70px">
				<button id="submitSure" >确认选择</button>
		</div>
		<div class="cart-js">
					<button id="submitOrder" >添加出行人</button>
		</div>
		<!--地址-->
		 <%@ include file="common/commJs.jsp"%>
		<script src="/js/page/travler.js"></script>
		<script>
		  $(function(){
		  	  var orderdata='${pd}';
			  $("#submitOrder").click(function(){
				  window.location.href='/wx/duyun/user/dotravelersedit';
			  });
			  $("#submitSure").click(function(){
				  	var chk_value =[];//定义一个数组    
		            $('input[name="travelers_id"]:checked').each(function(){
		            chk_value.push($(this).val());
		            });
				  	if(chk_value.length == 0){
				  		alert("请选择出行人！");
				  	}
				  window.location.href='/wx/ticket/index?redirectType=confirmOrder&travelers_id='+chk_value;
			  });
		  });
		  
		  function checkedBOX(objthis){
			  if($(objthis).find(':checkbox').checked){
				  $(objthis).find(':checkbox').checked = false;
			  }else{
				  $(objthis).find(':checkbox').checked = true;  
			  }
		  }
		</script>
	</body>
</html>
