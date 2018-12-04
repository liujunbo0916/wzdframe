var MakeSureOrder = {
	temp : {
		temp_pay_by_points : 0,
		temp_skuMap : '',
	},
	data : {
		addressId : 0,
		cartIds : '',
		skuIds : '',
		addType : 0,
		order : {
			pay_type : 1, // 支付方式
			pay_by_points : 0, // 积分支付金额
			pay_by_money : 0, // 现金支付金额
			contact_name : '', // 联系人姓名
			contact_phone : '',// 联系人电话
			province : '', // 省份
			city : '', // 城市
			area : '', // 地区
			address : '', // 街道地址
			user_note : '', // 用户备注
			shipping_type : '快递', // 快递方式
			shipping_money : 0, // 快递金额
			give_points : 0, // 购买时赠送积分
			province_id : 0, // 省份id
			city_id : 0, // 城市id
			area_id : 0, // 区域id
			cart_id : '', // 购物车id
			goods_id : '', // 商品id
			sku_id : '', // 库存id
			attr_json:'',//库存属性名称
			goods_number:'',//商品数量
			user_pay_points : 0,// 用户使用积分数
			is_mer : 0,
			mer_title : '',
			mer_no:'',
			address_id : $("#address_id").val()
		},
		//b2c订单信息
		b2cOrder:{
			cartIds:'',
			addressId:$("#address_id").val(),
			shipping_type:"快递",
			shipping_money:0,
			totalMoney:0,
			is_mer:0,
			mer_no:'',
			mer_title:'',
			mer_no:'',
			//以下是直接购买提交普通订单参数
			mer_type:0,
			skuId:'',
			goodsId:'',
			goodsNumber:1,
			type:'buyCart',
			//以下是直接购买提交折扣订单参数	
			proId :'',	
		}
	},
	pageElemContrl : function() {
		$("#mer_title").parent().hide();
		$("#mer_no").parent().hide();
		$("#merdiv").click(function(envent) {
			if (event.target.tagName.toUpperCase() == 'INPUT') {
				return;
			}
			if ($("#is_mer_title").is(":checked")) {
				$("#mer_title").parent().hide();
				$("#mer_no").parent().hide();
				$("#is_mer_title").removeAttr("checked");
			} else {
				$("#mer_title").parent().show();
				$("#mer_no").parent().show();
				$("#is_mer_title").prop("checked", true);
			}
		});
		$("#is_mer_title").click(function() {
			if ($(this).is(":checked")) {
				$("#mer_title").parent().show();
				$("#mer_no").parent().show();
			} else {
				$("#mer_title").parent().hide();
				$("#mer_no").parent().hide();
			}
		});
		$("#pointDivChecked").click(
				function(envent) {
					if (event.target.tagName.toUpperCase() == 'INPUT') {
						return;
					}
					if ($("#pointChecked").is(":checked")) {
						$("#pointChecked").removeAttr("checked");
						MakeSureOrder.temp.temp_pay_by_points = 0;
						$("#includePoint").text(
								MakeSureOrder.data.order.give_points);
						$("#orderTotalPrice")
								.text(
										(parseFloat($("#orderTotalPrice")
												.text()) + parseFloat($(
												"#pointPayMoeny").text()))
												.toFixed(2));
					} else {
						$("#pointChecked").prop("checked", true);
						$("#includePoint").text(0);
						MakeSureOrder.temp.temp_pay_by_points = $(
								"#pointPayMoeny").text();
						$("#orderTotalPrice")
								.text(
										(parseFloat($("#orderTotalPrice")
												.text()) - parseFloat($(
												"#pointPayMoeny").text()))
												.toFixed(2));
					}
				});
		$("#pointChecked").click(
				function(envent) {
					if ($(this).is(":checked")) {
						$("#includePoint").text(0);
						MakeSureOrder.temp.temp_pay_by_points = $(
								"#pointPayMoeny").text();
						$("#orderTotalPrice")
								.text(
										(parseFloat($("#orderTotalPrice")
												.text()) - parseFloat($(
												"#pointPayMoeny").text()))
												.toFixed(2));
					} else {
						$("#includePoint").text(
								MakeSureOrder.data.order.give_points);
						MakeSureOrder.temp.temp_pay_by_points = 0;
						$("#orderTotalPrice")
								.text(
										(parseFloat($("#orderTotalPrice")
												.text()) + parseFloat($(
												"#pointPayMoeny").text()))
												.toFixed(2));
					}
				});

	},
	// 请求运费
	requestFreight : function() {
		if (!MakeSureOrder.data.addressId) {
			return;
		}
		var goodsCartItem = MakeSureOrder.getAllCartId().cartIdsAry;
		if (goodsCartItem.length == 0) {
			return;
		}
		Ajax.request("/app/order/orderfreight",
						{
							"data" : {
								"cart_ids" : goodsCartItem.join(","),
								"address_id" : MakeSureOrder.data.addressId
							},
							"success" : function(data) {
								if (data.code == 200) {
									MakeSureOrder.data.order.shipping_money = data.data.freight;
									$("#freightPrice").text(data.data.freight);
									$("#goodsTotalPrice")
											.text(
													(parseFloat($(
															"#goodsTotalPrice")
															.text().trim()) + parseFloat(data.data.freight))
															.toFixed(2));
									$("#orderTotalPrice")
											.text(
													(parseFloat($(
															"#orderTotalPrice")
															.text().trim()) + parseFloat(data.data.freight))
															.toFixed(2));
								}
							}
						});
	},
	// 提交订单
	submiOrder : function(thisObj) {
		var Request=new UrlSearch();
		if (!MakeSureOrder.data.b2cOrder.addressId) {
			alert("请选择地址")
			return;
		}
		if ($("#is_mer_title").is(":checked")) {
			MakeSureOrder.data.b2cOrder.is_mer = 1;
			MakeSureOrder.data.b2cOrder.mer_title = $("#mer_title").val();

			MakeSureOrder.data.b2cOrder.mer_no = $("#mer_no").val();

			if(MakeSureOrder.data.b2cOrder.mer_title.isEmpty()){
				alert("发票抬头不能为空");
				return;
			}
			if(MakeSureOrder.data.b2cOrder.mer_no.isEmpty()){
				alert("发票税号不能为空");
				return;
			}

		}else{
			MakeSureOrder.data.b2cOrder.is_mer = 0;
		}
		var cartIds = [];
		$(".cart-info").each(function(){
			if($(this).attr("data-cartid")){
				cartIds.push($(this).attr("data-cartid"));
			}
		});
		try{
			MakeSureOrder.data.b2cOrder.cartIds = cartIds.join(",");
			MakeSureOrder.data.b2cOrder.totalMoney = $("#orderTotalPrice").text();
			MakeSureOrder.data.b2cOrder.shipping_money = $("#freightPrice").text() || 0;
//			MakeSureOrder.data.b2cOrder.goodsId = Request.goods_id;
//			MakeSureOrder.data.b2cOrder.skuId = Request.sku_id;
//			MakeSureOrder.data.b2cOrder.type = Request.type;
//			MakeSureOrder.data.b2cOrder.goodsNumber = Request.goodsNum;
		/*	MakeSureOrder.data.b2cOrder.proId = '${pd.pro_id}';
			MakeSureOrder.data.b2cOrder.goodsId = '${pd.goods_id}';
			MakeSureOrder.data.b2cOrder.skuId = '${pd.sku_id}';
			MakeSureOrder.data.b2cOrder.type = '${pd.type}';
			MakeSureOrder.data.b2cOrder.goodsNumber = '${pd.goodsNum}';*/
		}catch (e) {
		}
		$(thisObj).attr('disabled',"true");
		if(MakeSureOrder.data.addType == 0){
			//普通订单
			Ajax.request("/wx/order/createB2cOrder", {
				"data" : MakeSureOrder.data.b2cOrder,
				"success" : function(data) {
					$(thisObj).removeAttr('disabled');
					if (data.code == 200) { // 生成订单完成 选择支付方式
						toPayShow(data.data.pay_by_money, '1', data.data.order_id);
					} else {
						alert(data.msg);
					}
				}
			});
		}else if(MakeSureOrder.data.addType == 1){
			//折扣订单
			Ajax.request("/wx/order/createB2cOrderForDiscount", {
				"data" : MakeSureOrder.data.b2cOrder,
				"success" : function(data) {
					$(thisObj).removeAttr('disabled');
					if (data.code == 200) { // 生成订单完成 选择支付方式
						toPayShow(data.data.pay_by_money, '1', data.data.order_id);
					} else {
						alert(data.msg);
					}
				}
			});
		}
		
		/*
		MakeSureOrder.data.order.pay_by_points = MakeSureOrder.temp.temp_pay_by_points;
		MakeSureOrder.data.order.pay_by_money = $("#orderTotalPrice").text();
		Ajax.request("/wx/order/doOrder", {
			"data" : MakeSureOrder.data.order,
			"success" : function(data) {
				if (data.code == 200) { // 生成订单完成 选择支付方式
					toPayShow(data.data.pay_by_money, '1', data.data.order_id);
				} else {
					alert(data.msg);
				}
			}
		});*/
	},
	requestUserPoint : function() {
		var skuIdsAry = MakeSureOrder.data.order.sku_id;
		var skuMap =  MakeSureOrder.data.order.goods_number;
		if (skuIdsAry.length == 0) {
			return;
		}
		if (skuMap.length==0) {
			return;
		}
		Ajax.request("/wx/product/doGoodsdiscount",
						{
							"data" : {
								"sku_ids" : skuIdsAry,
								"skuMap" : skuMap,
							},
							"success" : function(data) {
								if (data.code == 200) {
									if (data.data.pay_points == 0
											|| data.data.user_points == 0) {
										$("#pointDivChecked").hide();
										$("#includePoint").text(
												data.data.give_points); // 获得积分
									} else {
										$("#userPoint").text(
												data.data.user_points); // 使用积分数量
										$("#pointPayMoeny").text(
												data.data.pay_points); // 积分抵扣金额
										$("#includePoint").text(0);
										MakeSureOrder.data.order.pay_by_points = data.data.pay_points;
										MakeSureOrder.data.order.user_pay_points = data.data.user_points;
										MakeSureOrder.temp.temp_pay_by_points = data.data.pay_points;
										// 更改订单价格
										$("#orderTotalPrice")
												.text((parseFloat($("#orderTotalPrice")
																.text().trim()) - parseFloat(data.data.pay_points))
																.toFixed(2));
									}
									MakeSureOrder.data.order.give_points = data.data.give_points;
								}
							}
						});

	}
}