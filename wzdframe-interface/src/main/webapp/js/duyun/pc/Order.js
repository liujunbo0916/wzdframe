var orderStatus = { // 后台订单状态对应前端订单状态
	statusConstant : {
		ALL_ORDER : 0,
		PENDING_PAY : 1,
		BEHALF_DELIVERY : 2,
		PENDING_EVALUATION : 3,
		RETURNED_GOODS : 4,
		RECEIVING_GOODS : 5
	}
};
var Order = {
	seachData : {
		orderListParam : {
			currentPage : 1,
			order_status : orderStatus.statusConstant.ALL_ORDER,
			resultLength : 15,
			order_type:0
		}
	},
	getQDOrderStatus : function(misFlag) {
		var map = new Map();
		map.put("0", "待付款");
		map.put("1", "待发货");
		map.put("2", "待发货");
		map.put("3", "待发货");
		map.put("4", "待收货");
		map.put("5", "待收货");
		map.put("6", "待评价");
		map.put("7", "已取消");
		map.put("8", "订单完成");
		map.put("9", "订单关闭");
		return map.get(misFlag);
	},
	cancleOrder:function(orderNo){//取消订单
		if(confirm("确定取消该订单？")){
			Ajax.request("/wx/order/orderCancel",{"data":{"order_id":orderNo,"opType":"PC"},"success":function(data){
				if(data.code == 200){
					window.location.reload();
				}else{
					alert(data.msg); 
				}
			}});
		}
	},
	signUp:function(orderNo){
		if(confirm("确定签收该订单？")){
			Ajax.request("/wx/order/orderSign",{"data":{"order_id":orderNo,"opType":"PC"},"success":function(data){
				if(data.code == 200){
					alert("已签收");
					window.location.reload();
				}else{
					alert(data.msg);
				}
			}});
		}
	},delOrder:function(orderNo){
		if(confirm("确认删除该订单？")){
			Ajax.request("/wx/order/orderDel",{"data":{"order_id":orderNo,"opType":"PC"},"success":function(data){
				if(data.code == 200){
					window.location.reload();
				}else{
					alert(data.msg);
				}
			}});
		}
	},
	applyRefundMoney:function(orderNo){
		var apply_reason = $("#refund_reason").val();
		var orderNo = $("#orderNo").val();
		var skuId = $("#skuId").val();
		var goodsId = $("#goodsId").val();
		var userId = $("#userId").val();
		if(!apply_reason){
			alert("申请理由不能为空");
			return;
		}
		if(!apply_reason){
			alert("申请理由不能为空");
			return;
		}
		if(!userId){
			window.location.href="/login";
			return;
		}
		if(confirm("确认退款？退款成功金额将原路返回支付账户？")){
			Ajax.request("/wx/order/orderReturn",{"data":{"refund_reason":apply_reason,"goods_sku_id":skuId,"goods_id":goodsId,"order_id":orderNo},"success":function(data){
				if(data.code == 200){
					window.location.reload();
				}else{
					alert(data.msg);
				}
			}});
		}
	},
	applyRefund:function(orderNo,goods_id){
		
	}
}