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
	cancleOrder:function(orderNo){//取消订单
		if(confirm("确定取消该订单？")){
			Ajax.request("/wx/order/orderCancel",{"data":{"order_id":orderNo},"success":function(data){
				if(data.code == 200){
					window.location.href='/wx/order/myOrder?currentPage=1&type=&order_status=';
				}else{
					alert(data.msg); 
				}
			}});
		}
	},
	toPay:function(money,type,orderId){
		toPayShow(money,type,orderId);
	},
	signUp:function(orderNo){
		if(confirm("确定签收该订单？")){
			Ajax.request("/wx/order/orderSign",{"data":{"order_id":orderNo},"success":function(data){
				if(data.code == 200){
					window.location.href='/wx/order/myOrder?currentPage=1&type=6&order_status=6';
				}else{
					alert(data.msg);
				}
			}});
		}
	},
}



