<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>收货地址</title>
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
		<!--地址-->
		<div style="margin-bottom: 90px">
		<c:forEach items="${addressList}" var="addr">
			<div class="address-box" style="    margin-bottom: 10px;">
				<div class="text-box" onclick="Address.setDefaultAddress(${addr.address_id});">
					<p>${addr.contact_name}&nbsp;&nbsp;${addr.contact_phone}</p>
					<p>${addr.province}${addr.city}${addr.area}${addr.address}</p>
						<div class="clearfix inpt-box" style="padding:.1rem;">
						<c:if test="${addr.is_default==1}">
						<div class="check-box l" style="margin-left: -10px;margin-top: 4px;">
							<label style="display:inline;float: inherit; margin-left: 25px;">默认地址</label>
							<input name="checkbox" class="checkedItem" style="width: 17px;height: 17px;" type="radio" checked="checked">
						</div>
						</c:if>
						<div class="r icon-box f666" >
							<a href="/wx/duyun/user/doaddAddress?address_id=${addr.address_id}&type=${pd.type}&actType=${pd.actType}&buytype=${pd.buytype}"><i class="icon icon_bianj" ></i>编辑</a>
							<a href="javascript:Address.delAddress('${addr.address_id}');"><i class="icon icon_shanc" ></i>删除</a>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		<div class="cart-js">
					<button id="submiOrder"  style="background-color: #ff7d13">添加收货地址</button>
		</div>
		<!--地址-->
		 <%@ include file="common/commJs.jsp"%>
		<script src="/js/page/Address.js"></script>
		<script>
			  Address.addrType = '${empty pd.type ? 1 : pd.type}';
			  Address.actType = '${empty pd.actType ? 0 : pd.actType}';
			  Address.buytype = '${pd.buytype}';
		  $(function(){
			  $("#submiOrder").click(function(){
				  window.location.href='/wx/duyun/user/doaddAddress?type='+Address.addrType+"&actType="+Address.actType+"&buytype="+Address.buytype;
			  });
		  });
		</script>
	</body>
</html>
