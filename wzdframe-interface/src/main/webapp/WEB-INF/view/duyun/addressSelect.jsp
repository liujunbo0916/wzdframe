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
		<link href="/css/cart.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
		
		
		<style type="text/css">
			.cart-js-back{
					position: fixed;
				    left: 0;
				    right: 0;
				    height: 1.2rem;
				    background: #fff;
				    padding-left: .34rem;
				}
			.cart-js-back button{
			    width: 100%;
			    background: #ab8a54;
			    height: 100%;
			    color: #fff;
			    display: inline-block;
			}
		</style>
	</head>
	<body>
		<!--地址-->
		<c:forEach items="${addressList}" var="addr">
		<div class="box-list clearfix" onclick="Address.setDefaultAddress(${addr.address_id});">
						<!--checkbox-->
						<div class="border-bottom box-img-text" style="background-color:#fff;margin-left: 0rem;">
							<!--img-->
							<!--text-box-->
							<div class="text-list margin-t12" style="margin-left: .35rem;margin-top:5px;">
								<p class="f333">${addr.contact_name}&nbsp;&nbsp;${addr.contact_phone}</p>
								<p>${addr.province}${addr.city}${addr.area}${addr.address}</p>
							</div>
						</div>
					</div>
		<%-- 	<div class="box-list clearfix">
			    	<div class="check-box l">
							<input name="checkbox" value="${item.cart_id}" class="checkedItem"  type="checkbox"/>
					</div>
				<div class="text-box r">
					<p>${addr.contact_name}&nbsp;&nbsp;${addr.contact_phone}</p>
					<p>${addr.province}${addr.city}${addr.area}${addr.address}</p>
				</div>
				<div class="clearfix inpt-box">
					<div class="r icon-box f666">
					</div>
				</div>
			</div> --%>
		</c:forEach>
			<div class="cart-js" style="padding-left: 0rem;bottom: 0rem;    height: 0.9rem;">
					<button id="submiOrder" style="background-color: #ff7d13" onclick="window.location.href='/wx/user/addressList'">管理地址</button>
		</div>
		<!--地址-->
		 <%@ include file="common/commJs.jsp"%>
		<script src="/js/page/mall/Address.js"></script>
		<script>
		  Address.addrType = '${empty pd.type ? 1 : pd.type}';
		  Address.cartIds = '${pd.cartIds}';
		</script>
	</body>
</html>
