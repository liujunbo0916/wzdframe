<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>绑定手机</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <style>
        .content {
            background: #FFF;
            padding: 20px;
        }
        .header-title {
            margin-top: 30px;
            font-size: 20px;
            color: #333;
        }
        .btn-orange {
            background-color: #ff7d13;
            color: #FFF;
            font-size: 16px;
            line-height: 16px;
            padding: 15px 20px;
            border: none;
            margin: 0 auto;
        }
        .input-group {
            margin: 10px 0 80px 0;
        }
        .input-row {
            position: relative;
            height: auto;
        }
        .btn-verify {
            position: absolute;
            top: 9px;
            right: 0;
            width: 80px;
            padding: 8px 10px;
            color: #FFF;
            background: #ff7d13;
            border: none;
        }
        .btn-verify:hover, .btn-verify:active, .btn-orange:hover, .btn-orange:active {
            background-color: #ff7d13;
            color: #FFF;
            outline: 0;
        }
        .input-row label {
            line-height: 21px;
            padding: 12px 0;
            color: #333;
        }
        .input-row input {
            height: 44px;
            color: #666;
        }
        input::-webkit-input-placeholder {
            color:#999;
        }
    　　input::-moz-placeholder {
        　　color:#999;
        }
    　　input::-moz-placeholder {
        　　color:#999;
        }
    　　input::-ms-input-placeholder {
        　　color:#999;
        }
    </style>
</head>

<body>
    <div class="content">
        <form name="loginForm" class="input-group">
            <div class="input-row">
                <label>手机号：</label>
                <input name="phoneNum" type="tel" placeholder="请输入手机号" oninput="checkPhoneNum()" onporpertychange="checkPhoneNum()" value="">
            </div>
            <div class="input-row">
                <label>验证码：</label>
                <input name="verifyCode" type="number" placeholder="请输入验证码" oninput="checkPhoneNum()">
                <div class="btn btn-verify disabled" >获取验证码</div>
            </div>
        </form>
        <a class="btn btn-orange btn-block disabled">
            提交
        </a>
    </div>
    <script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
    <script type="text/javascript">
        var bindType = "${pd.bingType}";
        var btnVerify = document.querySelector('.btn-verify');
        var btnOrange = document.querySelector('.btn-orange');
        var checkPhoneNum = function () {
            var phoneNum = loginForm.phoneNum.value;
            var verifyCode = loginForm.verifyCode.value;
            var regex = /^0?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;
            if(regex.test(phoneNum)){
                btnVerify.classList.remove('disabled');
            }else {
                btnVerify.classList.add('disabled');
            }
            if(verifyCode){
                btnOrange.classList.remove('disabled');
            }else {
                btnOrange.classList.add('disabled');
            }
        }

        btnVerify.addEventListener('click', function () {
            var count = 60;
            if(!btnVerify.classList.contains('disabled')){
                btnVerify.classList.add('disabled');
                var interval = setInterval(function () {
                    count = count > 0 ? count-1 : 0;
                    btnVerify.innerText = count + ' (s)';
                    if(count === 0){
                        window.clearInterval(interval);
                        btnVerify.innerText = '获取验证码';
                        btnVerify.classList.remove('disabled');
                    }
                }, 1000);
                var phoneNum = loginForm.phoneNum.value;
                Ajax.request("/wx/duyun/user/sendCode",{"data" : {"phone" : phoneNum,"codetype":'4'},
					"success" : function(data) {
						if (data.code == 200) {
							alert("验证码获取成功，请留意短信消息！")
						} else {
							alert(data.msg);
							btnVerify.classList.remove('disabled');
						}
					}
				}); 
            }else{
            	alert("号码不正确")
            }
        }, false);
        btnOrange.addEventListener('click',function(){
        	 if(!btnOrange.classList.contains('disabled')){
        		 btnOrange.classList.add('disabled');
        		 var phoneNum = loginForm.phoneNum.value;
        		 var verifyCode = loginForm.verifyCode.value;
        		 Ajax.request("/wx/duyun/user/dobingphone",{"data" : {"phone" : phoneNum,"code":verifyCode},
 					"success" : function(data) {
 						if (data.code == 200) {
 							if("productSureOrder" == bindType){
 							   window.location.href="/wx/order/domakeSureOrder?type=0";
 							}else if("userCenter" == bindType){
 							   window.location.href="/wx/duyun/user/center";
 							}else if("shopCart" == bindType){
 								window.location.href="/wx/cart/shopCart";
 							}else if("goodsDetail" == bindType){
 								window.location.href="/wx/product/detail?p_id=${pd.p_id}";
 							}else if("ticketDetail" == bindType){
 								window.location.href='/wx/ticket/index?redirectType=detail&t_id=${pd.t_id}';
 							}else if("grouptour" == bindType){
 								window.location.href='/wx/grouptour/index?resultType=detail&grouptour_id=${pd.grouptour_id}';
 							}
 						 } else {
 							alert(data.msg);
 							btnOrange.classList.remove('disabled');
 						}
 					}
 				});
             }else{
             }
        },false);
        //返回按钮监控
        if("productSureOrder" == bindType){
        	GoBackBtn.excuteHistory("/wx/cart/shopCart?redirectType=${pd.redirectType}");
		}else if("userCenter" == bindType){
			GoBackBtn.excuteHistory("/wx/duyun/user/center");
		}else if("shopCart" == bindType){
			GoBackBtn.excuteHistory("/wx/cart/shopCart?redirectType=${pd.redirectType}");
		}else if("goodsDetail" == bindType){
			GoBackBtn.excuteHistory("/wx/product/detail?p_id=${pd.p_id}&redirectType=${pd.redirectType}&optType=${pd.optType}");
		}else if("ticketDetail" == bindType){
			GoBackBtn.excuteHistory('/wx/ticket/index?redirectType=detail&t_id=${pd.t_id}');
		}else if("grouptour" == bindType){
			GoBackBtn.excuteHistory('/wx/grouptour/index?resultType=detail&grouptour_id=${pd.grouptour_id}&redirectType=${pd.redirectType}');
		}
    </script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>