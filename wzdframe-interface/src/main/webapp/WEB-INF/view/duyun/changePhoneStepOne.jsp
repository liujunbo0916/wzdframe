<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>更换手机</title>
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
                <input name="phoneNum" id="phoneNum" type="tel" disabled="disabled" placeholder="" value="${user.phone}">
            </div>
            <div class="input-row">
                <label>验证码：</label>
                <input name="verifyCode" id="verifyCode" type="number" placeholder="请输入验证码" oninput="checkPhoneNum()">
                <div class="btn btn-verify disabled" >获取验证码</div>
            </div>
        </form>
        <a class="btn btn-orange btn-block" href="javascript:doStepOne();">
                                   下一步
        </a>
    </div>
    <script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
    <script type="text/javascript">
        var btnVerify = document.querySelector('.btn-verify');
        var btnOrange = document.querySelector('.btn-orange');
        var count = 60;
        btnVerify.addEventListener('click', function () {
            if(count === 60){
                btnVerify.classList.add('disabled');
                var interval = setInterval(function () {
                    count = count > 0 ? count-1 : 0;
                    btnVerify.innerText = count + ' (s)';
                    if(count === 0){
                        window.clearInterval(interval);
                        btnVerify.innerText = '获取验证码';
                        count = 60;
                    }
                }, 1000);
                Ajax.request("/wx/duyun/user/sendCode",{"data" : {"phone" : $("#phoneNum").val(),"codetype":'4'},
					"success" : function(data) {
						if (data.code == 200) {
							alert("验证码获取成功，请留意短信消息！")
						} else {
							alert(data.msg);
						}
					}
				}); 
            }else{
            }
        }, false);
      $(function(){
        	$("#verifyCode").bind('input propertychange',function(){
        		if($(this).length == 6){
        			btnVerify.classList.remove('disabled');
        		}else if($(this).length > 6 || $(this).length < 6){
        			btnVerify.classList.add('disabled');
        		}
        	});
        });
        var isSubmit = false;
        function doStepOne(){
        	if(!isSubmit){
        		isSubmit = true;
        		Ajax.request("/wx/duyun/user/doChangePhoneStepOne",{"data":{"phone":'${user.phone}',"code":$("#verifyCode").val()},"success":function(data){
        			isSubmit = false;
        			if(data.code == 200){
            			window.location.href="/wx/duyun/user/bingphone";
            		}
            	}});
        	}
        }
    </script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>