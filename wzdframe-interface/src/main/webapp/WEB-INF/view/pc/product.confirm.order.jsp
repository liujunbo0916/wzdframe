<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/css/duyun/pc/special-order.css"
	type="text/css">
	<link rel="stylesheet" href="/css/otherplatform/tmall_aio.css" type="text/css">
<style type="text/css">
.selectClass {
	border: 1px solid #fc9313;
}
</style>


</head>
<body>
	<%@ include file="common/header.jsp"%>
	<%@ include file="common/ercode.jsp"%>
	<div class="row nav-container">
		<div class="col-md-1"></div>
		<div class="col-md-1"></div>
		<div class="col-md-2 nav-logo" onclick="window.location.href='/'">
			<img alt="" src="/img/duyun/pc/LOGO.png">
		</div>
		<div class="col-md-2 "></div>
		<div class="col-md-6 nav-time-line">
			<div class="time_line_box">
				<div class="time_line">
					<div>
						<span> <a class="periodTitle selected" style="left: 0;"></a>
							<li class="periodContent" style="left: 0;">提交订单</li>
						</span> <span> <a class="periodTitle " style="left: 144px;"></a>
							<li class="periodContent" style="left: 144px;">确认支付</li>
						</span> <span> <a class="periodTitle" style="left: 288px;"></a>
							<li class="periodContent" style="left: 288px;">完成购买</li>
						</span>
					</div>
					<span class="filling_line"></span>
				</div>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="special-content">
			<div class="row name-info" id="address_list">
				<!--    <div class="col-md-3 col add-col" id="address_list_after">
                <div class="add-container" role="button" data-toggle="modal" data-target="#addressModal">
                    <span class="add">+</span>
                    <span class="add-text">添加地址</span>
                </div>
            </div> -->
			</div>
			<div class=" good-info">
				<div class="row good-header">
					<div class="col-md-4 col">
						<span class="info-line"></span> <span class="info-text">商品信息</span>
					</div>
					<div class="col-md-2 col header-item">规格</div>
					<div class="col-md-2 col header-item">单价(元)</div>
					<div class="col-md-2 col header-item">数量</div>
					<div class="col-md-2 col header-item">小计</div>
				</div>
				<div class="row good-content" style="cursor: pointer;"
					onclick="goGoodsDetail('${goodsInfo.goods_id}');">
					<div class="col-md-4 col">
						<div class="row good-item">
							<div class="col-md-3 col item-left">
								<img style="margin-top: 8px;"
									src="${SETTINGPD.IMAGEPATH}${goodsInfo.list_img}"
									onError="javascript:this.src='/img/no-img/no-img.jpg';"
									class="good-img" alt="">
							</div>
							<div class="col-md-6 col item-right"
								style="line-height: 20px; margin-top: 8px;">
								${goodsInfo.goods_name}</div>
						</div>
					</div>
					<div class="col-md-2 col item-right">
						<c:if
							test="${not empty goodsInfo.attr_json && goodsInfo.attr_json ne '-1'}">
               ${goodsInfo.attr_json} </c:if>
					</div>
					<div class="col-md-2 col item-right">¥${goodsInfo.price}</div>
					<div class="col-md-2 col item-right">${goodsInfo.buyNum}</div>
					<div class="col-md-2 col item-right">
						¥
						<fmt:formatNumber type="number"
							value="${goodsInfo.price*goodsInfo.buyNum}" pattern="0.00"
							maxFractionDigits="2" />
					</div>
				</div>
				<div class=" good-footer">

					<div class="order-orderExt" >
						<div class="order-extUser" >
							<div class="order-invoice" >
								<div class="invoice-box" >
									<div class="invoice-title" >
										<input id="invoiceCheckbox" type="checkbox" 
											class="invoice-checkbox"> <label
											for="invoiceCheckbox" >开具发票</label>
									</div>
									<div class="invoice-operate" style="display: none;">
										<div class="invoice-info" >
											<label class="title-label" >发票抬头类型：</label><label
												class="uses-radio-select" >
												<input type="radio" name="uses-radio1512376185556" value="0"  >
												<span>个人</span></label>
												<label class="uses-radio-select" ><input type="radio" checked="checked" name="uses-radio1512376185556" value="1" ><span >企业</span></label>
										</div>
										<div class="invoice-header" 
											data-spm-anchor-id="a220l.1.0.i12.373e1d8eiumJ2m">
											<label class="title-label" >发票抬头：</label><span
												class="header-box" ><input type="text" name="mer_title"	class="header-input" value=""><span
												class="header-err-message hide" ><ins
														class="icon icon-chucuo" ></ins><span
													>&nbsp;请填写发票抬头</span>
												<ins class="arrow-top" ></ins></span></span>
										</div>
										<div class="invoice-tax-no">
											<label class="title-label" >纳税人识别号：</label><span
												class="header-box" ><input type="text"
												class="header-input input-long" name="mer_code" value=""
												placeholder="根据最新增值税管理办法，如需企业抬头发票，请填写有效税号信息"
												data-reactid="" ></span>
											<div
												class="header-err-message err-message-long err-message-static"
												>
												<ins class="icon icon-chucuo" ></ins>
												<span >根据最新增值税管理办法，如需企业抬头发票，请填写有效税号信息。
													<a class="widget-tips-box" target="_blank"
													href="http://www.chinatax.gov.cn/n810341/n810755/c2644618/content.html?spm=a220l.1.0.0.373e1d8eiumJ2m"
													data-spm-anchor-id="a220l.1.0.0"> <img
														src="//img.alicdn.com/tps/TB1QFFkMXXXXXcNXFXXXXXXXXXX-32-32.png"
														class="wtip-icon"
														data-spm-anchor-id="a220l.1.0.i10.373e1d8eiumJ2m"></a>
												</span>
												<ins class="arrow-top" ></ins>
											</div>
										</div>
									</div>
								</div>
								
							</div>
						</div>
						<!-- <div class="order-extUser" >
							<div class="order-invoice" >
								<div class="invoice-box" >
									<div class="invoice-operate" >
										<div class="invoice-info" >
											<label class="title-label" >货运方式：</label><label
												class="uses-radio-select" >
												<input type="radio" checked="checked" name="fright-radio1512376185556" value="0"  >
												<span>快递</span></label>
												<label class="uses-radio-select" ><input type="radio"  name="fright-radio1512376185556" value="1" ><span >自取</span></label>
										</div>
									</div>
								</div>
							</div>
						</div> -->
					</div>
					<p class="footer-item freight_item">
						<span class="good-amount">运费总计</span>
						<c:if
							test="${empty goodsInfo.is_free_shipping || goodsInfo.is_free_shipping eq '1'}">
							<span>¥0.00</span>
							<c:set value="0" var="freight"></c:set>
						</c:if>
						<c:if test="${goodsInfo.is_free_shipping eq '0'}">
							<span>¥${goodsInfo.goods_freight}</span>
							<c:set value="${goodsInfo.goods_freight}" var="freight"></c:set>
						</c:if> 
					</p>
					<p class="footer-item">
						<span class="good-amount">商品总计</span> <span> &nbsp;¥
						  <fmt:formatNumber type="number" value="${goodsInfo.price*goodsInfo.buyNum}" pattern="0.00" maxFractionDigits="2" />
						</span>
					</p>
				</div>
			</div>
			<c:set value="${goodsInfo.price*goodsInfo.buyNum+freight}"
				var="pay_by_money"></c:set>
			<div class="row good-group">
				<div class="col-md-7 col"></div>
				<div class="col-md-3 col group-item-one">
					<span class="money-text">应付：</span> <span class="money-number"
						id="shouldPay">¥<fmt:formatNumber type="number"
							value="${pay_by_money}" pattern="0.00" maxFractionDigits="2" />
					</span>
				</div>
				<div class="col-md-2 col group-item-two">
					<button type="button" style="cursor: pointer;"
						onclick="createOrder();" class="btn btn-warning sub-order">提交订单</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="addressModal" tabindex="-1" role="dialog"
		aria-labelledby="addressModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<div class="modal-title" id="addressModalLabel">
						<span class="info-line"></span> <span class="info-text">添加地址</span>
					</div>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row modal-row">
						<div class="col-md-2 col modal-item">
							<span class="must">*</span> <span class="modal-name">姓名:</span>
						</div>
						<div class="col-md-9 col modal-value">
							<input type="text" class="name-input" id="real_name"
								placeholder="请输入您的真实姓名" />
						</div>
					</div>
					<div class="row modal-row">
						<div class="col-md-2 col modal-item">
							<span class="must">*</span> <span class="modal-name">联系电话:</span>
						</div>
						<div class="col-md-9 col modal-value">
							<input type="text" class="tel-input" placeholder="+86" /> <input
								type="text" class="tel-input-value" id="con_phone"
								placeholder="" />
						</div>
					</div>
					<div class="row modal-row">
						<div class="col-md-2 col modal-item">
							<span class="must">*</span> <span class="modal-name">收件地址:</span>
						</div>
						<div class="col-md-9 col modal-value">
							<select class="province" id="province">
							</select> <select class="city" id="city">
							</select> <select class="area" id="area">
							</select>
						</div>
					</div>
					<div class="row modal-row">
						<div class="col-md-2 col modal-item">
							<span class="must">*</span> <span class="modal-name">详细地址:</span>
						</div>
						<div class="col-md-9 col modal-value">
							<textarea class="modal-area" name="" id="detailAddress" cols="60"
								rows="10"></textarea>
						</div>
					</div>
					<div class="row modal-row">
						<div class="col-md-2"></div>
						<div class="col-md-9">
							<span class="checkbox-span"> <input type="checkbox"
								checked="checked" class="input-check" id="check3"> <label
								for="check3"></label>
							</span> <span class="foot-color">设为默认地址</span>
						</div>
					</div>
					<div class="row modal-row">
						<div class="col-md-3"></div>
						<div class="col-md-5">
							<button type="button" class="btn btn-warning sub-order"
								id="addAddress">添加地址</button>
						</div>
						<div class="col-md-3"></div>
					</div>
				</div>
				<!--<div class="modal-footer">-->
				<!--<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>-->
				<!--<button type="button" class="btn btn-primary">Save changes</button>-->
				<!--</div>-->
			</div>
		</div>
	</div>
	<%@ include file="common/footer.jsp"%>
	<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js"
		type="text/javascript"></script>
	<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
	<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
	<script type="text/javascript" src="/js/jquery.min.js"></script>
	<script type="text/javascript" src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/InheritString.js"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
	var provinceJson = '${province}';
	var cityJson = '${city}';
	var destJson = '${dist}';
	provinceJson = JSON.parse(provinceJson);
	cityJson = JSON.parse(cityJson);
	destJson = JSON.parse(destJson);
	$("#province").append('<option value="">请选择省份</option>');
	$("#city").append('<option value="">请选择城市</option>');
	$("#area").append('<option value="">请选择区县</option>');
	for (var i = 0; i < provinceJson.length; i++) {
		$("#province").append(
				"<option value='"+provinceJson[i].value+"'>"
						+ provinceJson[i].text + "</option>");
	}
	var addressInfo = {
		address_id : '',
		contact_name : '',
		contact_phone : '',
		province_id : '',
		province : '',
		city_id : '',
		city : '',
		area_id : '',
		area : '',
		address : '',
		is_default : 0
	}
	$(function() {
		$("#province").change(
				function() {
					var cityList = cityJson[$(this).val()];

					$('#city').empty();
					$("#city").append('<option value="">请选择城市</option>');
					for (var i = 0; i < cityList.length; i++) {
						$('#city').append(
								'<option value="'+cityList[i].value+'">'
										+ cityList[i].text + '</option>');
					}
					$("#area").empty();
				});
		$("#city").change(
				function() {
					var areaList = destJson[$(this).val()];
					$('#area').empty();
					$("#area").append('<option value="">请选择区县</option>');
					for (var i = 0; i < areaList.length; i++) {
						$('#area').append(
								'<option value="'+areaList[i].value+'">'
										+ areaList[i].text + '</option>');
					}
				});
		//地址是否提交
		var addAddressFlag = false;
		//添加地址
		$("#addAddress").click(
				function() {
					if ($("#real_name").val().length > 10
							|| $("#real_name").val().length < 2) {
						alert("输入的联系人姓名不合法");
						return;
					}
					if (!$("#con_phone").val().isPhone()) {
						alert("手机号不合法");
						return;
					}
					if ($("#detailAddress").val().isEmpty()) {
						alert("详细地址不能为空");
						return;
					}
					if (addAddressFlag) {
						return;
					}
					addressInfo.contact_name = $("#real_name").val();
					addressInfo.contact_phone = $("#con_phone").val();
					addressInfo.province_id = $("#province").val();
					addressInfo.province = $("#province  option:selected")
							.text();
					addressInfo.city_id = $("#city").val();
					addressInfo.city = $("#city option:selected").text();
					addressInfo.area_id = $("#area").val();
					addressInfo.area = $("#area option:selected").text();
					addressInfo.address = $("#detailAddress").val();
					if ($("#check3").attr("checked")) {
						addressInfo.is_default = 1;
					}
					addAddressFlag = true;
					Ajax.request("/comm/createAddress", {
						"data" : {
							"paramStr" : Base64.encode(JSON
									.stringify(addressInfo))
						},
						"success" : function(data) {
							addAddressFlag = false;
							if (data.code == 200) {
								$("#addressModal").hide();
								$(".modal-backdrop").remove();
								requestUserAddress();
							}
						}
					});
				});
		//请求默认地址列表
		requestUserAddress();
	});
	function requestUserAddress() {
		Ajax.request(
						"/comm/addressList",
						{
							"data" : {},
							"success" : function(data) {
								if (data.code == 200) {
									var htmlAry = [];
									var data = data.data;
									$("#address_list").empty();
									for (var i = 0; i < data.length; i++) {
										if (data[i].is_default) {
											htmlAry.push('<div class="col-md-4 col special-one selectClass" data-address-id="'
															+ data[i].address_id
															+ '"  data-contact-name="'
															+ data[i].contact_name
															+ '" data-contact-phone="'
															+ data[i].contact_phone
															+ '" onclick="selectAdd(this);"');
											htmlAry.push('data-province-id="'
													+ data[i].province_id
													+ '" data-province="'
													+ data[i].province
													+ '" data-city-id="'
													+ data[i].city_id
													+ '" data-city="'
													+ data[i].city + '" ')
											htmlAry.push('data-area-id="'
													+ data[i].area_id
													+ '" data-area="'
													+ data[i].area
													+ '"  data-address="'
													+ data[i].address + '">');
										} else {
											htmlAry
													.push('<div class="col-md-4 col special-one" style="cursor:pointer;" data-address-id="'
															+ data[i].address_id
															+ '" data-contact-name="'
															+ data[i].contact_name
															+ '" data-contact-phone="'
															+ data[i].contact_phone
															+ '" onclick="selectAdd(this);"');
											htmlAry.push('data-province-id="'
													+ data[i].province_id
													+ '" data-province="'
													+ data[i].province
													+ '" data-city-id="'
													+ data[i].city_id
													+ '" data-city="'
													+ data[i].city + '" ')
											htmlAry.push('data-area-id="'
													+ data[i].area_id
													+ '" data-area="'
													+ data[i].area
													+ '"  data-address="'
													+ data[i].address + '">');
										}
										htmlAry
												.push('<div class="row route-information-header">');
										htmlAry
												.push('<div class="col-md-6 col"> <span class="info-line"></span><span class="info-text">联系人信息</span></div>');
										htmlAry
												.push('<div class="col-md-6 col default-col">');
										if (data[i].is_default) {
											htmlAry
													.push('<span class="default-one">默认地址</span><span class="default-two">|</span>');
											addressInfo.address_id = data[i].address_id;
											addressInfo.contact_name = data[i].contact_name;
											addressInfo.contact_phone = data[i].contact_phone;
											addressInfo.province_id = data[i].province_id;
											addressInfo.province = data[i].province;
											addressInfo.city_id = data[i].city_id;
											addressInfo.city = data[i].city;
											addressInfo.area_id = data[i].area_id;
											addressInfo.area = data[i].area;
											addressInfo.address = data[i].address;
										}
										htmlAry
												.push('<span class="default-three" style="cursor:pointer;" onclick="delAddress('
														+ data[i].address_id
														+ ')">删除</span></div></div><div class="special-item-row"><div class="row router-information-row">');
										htmlAry
												.push('<div class="col-md-3 col label-div"><span class="label-name">姓名:</span> </div><div class="col-md-7 col route-value">');
										htmlAry
												.push(''
														+ data[i].contact_name
														+ '</div></div><div class="row router-information-row"><div class="col-md-3 col label-div">');
										htmlAry
												.push('<span class="label-name">联系方式:</span></div><div class="col-md-7 col  route-value">'
														+ data[i].contact_phone
														+ '');
										htmlAry
												.push('</div></div><div class="row router-information-row"><div class="col-md-3 col label-div"><span class="label-name">收货地址:</span></div>');
										htmlAry
												.push('<div class="col-md-7 col  route-value">'
														+ data[i].province
														+ data[i].city
														+ data[i].area
														+ data[i].address
														+ '</div></div></div></div>');
									}
									if (data.length == 0) {
										htmlAry
												.push('<div class="col-md-3 col add-col" style="padding-top: 0px!important;" id="address_list_after"> <div class="add-container" role="button" data-toggle="modal" data-target="#addressModal">');
										htmlAry
												.push('<span class="add">+</span><span class="add-text">添加地址</span> </div> </div>');
									}
									if (data.length > 0 && data.length < 3) {
										htmlAry
												.push('<div class="col-md-3 col add-col" id="address_list_after"> <div class="add-container" role="button" data-toggle="modal" data-target="#addressModal">');
										htmlAry
												.push('<span class="add">+</span><span class="add-text">添加地址</span> </div> </div>');
									}
									if (data.length == 0) {
										addressInfo.address_id = '';
										addressInfo.contact_name = '';
										addressInfo.contact_phone = '';
										addressInfo.province_id = '';
										addressInfo.province = '';
										addressInfo.city_id = '';
										addressInfo.city = '';
										addressInfo.area_id = '';
										addressInfo.area = '';
										addressInfo.address = '';
									}
									$("#address_list").append(htmlAry.join(''));
								}
							}
						});
	}
	function delAddress(addressId) {
		var delParam = {
			"address_id" : addressId
		}
		if (confirm("确定要删除该地址？")) {
			Ajax.request("/comm/delAddress", {
				"data" : {
					"paramStr" : Base64.encode(JSON.stringify(delParam))
				},
				"success" : function(data) {
					if (data.code == 200) {
						requestUserAddress();
					}
				}
			});
		}
	}
	//b2c订单信息
	var b2cOrder = {
		cartIds : '',
		addressId : addressInfo.address_id,
		shipping_type : "0",
		shipping_money : '<fmt:formatNumber type="number" value="${freight}" pattern="0.00" maxFractionDigits="2"/>',
		totalMoney : '<fmt:formatNumber type="number" value="${pay_by_money}" pattern="0.00" maxFractionDigits="2"/>',
		is_mer : 0,
		mer_title : '',
		//以下是直接购买提交订单参数
		skuId : '${goodsInfo.sku_id}',
		goodsId : '${goodsInfo.goods_id}',
		goodsNumber : '${goodsInfo.buyNum}',
		type : 'buyNow',
		mer_type:'1', //发票类型  默认为1企业发票
		mer_code:'',//发票税码
		activeType:'${activeType}',
		activePrice:'${activePrice}',
		activeProId:'${activeProId}',
		is_submit : false
	}

	function createOrder() {
		b2cOrder.addressId = addressInfo.address_id;
		if($("#invoiceCheckbox").is(':checked')){
			//说明需要开票
			var merType = $("input[name='uses-radio1512376185556']:checked").val();
			if($("input[name='mer_title']").val().isEmpty()){
				alert("发票抬头不能为空");
			    return;
			}
			if(merType == 1 && $("input[name='mer_code']").val().isEmpty()){ //企业发票
				alert("企业发票税号不能为空");
			    return;
			}
			b2cOrder.mer_code = $("input[name='mer_code']").val();
			b2cOrder.mer_title = $("input[name='mer_title']").val();
			b2cOrder.mer_type = merType;
		}
		b2cOrder.shipping_type = $("input[name='fright-radio1512376185556']:checked").val();
		if (0 == b2cOrder.shipping_type && !b2cOrder.addressId) { //如果选择是快递可以不添加地址
			alert("请添加有效地址");
			return;
		}
		if (b2cOrder.is_submit) {
			return;
		}
		b2cOrder.is_submit = true;
		if(b2cOrder.activeType == '2'){//创建活动订单
			Ajax.request("/logic/product/createSingleOrder", {
				"data" : {
					"paramStr" : Base64.encode(JSON.stringify(b2cOrder))
				},
				"success" : function(data) {
					b2cOrder.is_submit = false;
					if (data.code == 200) {
						var data = data.data;
						var orderNo = {
							order_id : data.order_id,
							order_sn : data.order_sn,
							pay_by_money : data.pay_by_money
						}
						window.location.href = "/selectPayMethod?paramStr="
								+ Base64.encode(JSON.stringify(orderNo));
					} else {
						alert("库存不足");
					}
				}
			});
		}else{
			Ajax.request("/logic/product/createSingleOrder", {
				"data" : {
					"paramStr" : Base64.encode(JSON.stringify(b2cOrder))
				},
				"success" : function(data) {
					b2cOrder.is_submit = false;
					if (data.code == 200) {
						var data = data.data;
						var orderNo = {
							order_id : data.order_id,
							order_sn : data.order_sn,
							pay_by_money : data.pay_by_money
						}
						window.location.href = "/selectPayMethod?paramStr="
								+ Base64.encode(JSON.stringify(orderNo));
					} else {
						alert("库存不足");
					}
				}
			});
			
		}
	}
	function selectAdd(thisObj) {
		$(thisObj).addClass("selectClass")
		/*  addressInfo.contact_name = $(thisObj).attr("data-contact-name");
		 addressInfo.contact_phone = $(thisObj).attr("data-contact-phone");
		 addressInfo.province_id = $(thisObj).attr("data-province-id");
		 addressInfo.province = $(thisObj).attr("data-province");
		 addressInfo.city_id = $(thisObj).attr("data-city-id");
		 addressInfo.city = $(thisObj).attr("data-city");
		 addressInfo.area_id = $(thisObj).attr("data-area-id");
		 addressInfo.area = $(thisObj).attr("data-area");
		 addressInfo.address = $(thisObj).attr("data-address"); */
		addressInfo.address_id = $(thisObj).attr("data-address-id");
		$(thisObj).siblings().removeClass("selectClass");
	}

	function goGoodsDetail(goodsId) {
		var paramObj = {
			goodsId : goodsId
		}
		window.location.href = '/product/detail?paramStr='
				+ Base64.encode(JSON.stringify(paramObj));
	}
	/*订单扩展信息js处理*/
	(function(window,$){
		 function orderExt(){
			this.selectInvoice = function(){
			    $("input[name='uses-radio1512376185556']").click(function(){
			    	if($(this).val() == 1){ //企业
			    		$(".invoice-tax-no").show();
			    	}else{
			    		$(".invoice-tax-no").hide();
			    	}
			    });
			    $("#invoiceCheckbox").click(function(){
			    	if($(this).is(':checked')){
			    		$(this).parent().next().show();
			    	}else{
			    		$(this).parent().next().hide();
			    	}
			    });
			    $("input[name='fright-radio1512376185556']").click(function(){
			    	if($(this).val() == 1){ //自取
			    	   $(".freight_item").hide();
			    	   $("#shouldPay").text("￥${goodsInfo.price*goodsInfo.buyNum}");
			    	}else if($(this).val() == 0){ //快递
			    	   $(".freight_item").show();
			    	   $("#shouldPay").text('￥<fmt:formatNumber type="number" value="${goodsInfo.price*goodsInfo.buyNum+freight}" pattern="0.00" maxFractionDigits="2" />');
			    	}
			    });
			}
		}
		window.orderExt = new orderExt();
	})(window,$)
	orderExt.selectInvoice();
</script>
</html>