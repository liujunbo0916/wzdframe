<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
//money  支付金额
//type   如果 type =1 商品支付   type=2 课程支付   type =3 场馆支付  type=4充值
var payConfig = {
		appId:'',
		timeStamp:'',
		nonceStr:'',
		pack_age:'',
		signType:'MD5',
		paySign:''
}
function toPay(money,type,orderId,callUrl){
	alert(type);
	callUrl = callUrl;
	//请求后台 配置
	Ajax.request("/wx/pay/getPayConfig",{"data":{"money":money,"type":type,"orderId":orderId},
		"success":function(data){
			//将后台请求过来的配置信息赋值
			if(data.code == "200"){
				$("#toPay").hide();
				payConfig.appId = data.data.appId;
				payConfig.timeStamp = data.data.timestamp;
				payConfig.nonceStr = data.data.nonceStr;
				payConfig.pack_age = data.data.pack_age;
				payConfig.paySign = data.data.paySign;
			    //调起微信支付
				if (typeof WeixinJSBridge == "undefined"){
				   if( document.addEventListener ){
				       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
				   }else if (document.attachEvent){
				       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
				       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
				   }
				   }else{
				     onBridgeReady();
		        }
			}
			
	}});
}
function onBridgeReady(){
	   WeixinJSBridge.invoke(
	       'getBrandWCPayRequest', {
	           "appId":payConfig.appId,     //公众号名称，由商户传入     
	           "timeStamp":payConfig.timeStamp,         //时间戳，自1970年以来的秒数     
	           "nonceStr":payConfig.nonceStr, //随机串     
	           "package":payConfig.pack_age,     
	           "signType":"MD5",         //微信签名方式：     
	           "paySign":payConfig.paySign //微信签名 
	       },
	       function(res){     
	           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
	        	   // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
	        	   if(callUrl){
	        		   window.location.href=callUrl;
	        	   }
	           }else if(res.err_msg == "get_brand_wcpay_request:cancel"){
	        	   if(cancelUrl){
	        		   window.location.href=cancelUrl;
	        	   }
	           }     
	       }
	   ); 
	}
</script>

