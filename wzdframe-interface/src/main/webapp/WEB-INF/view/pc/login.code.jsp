<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/register.css" type="text/css">
     <style type="text/css">
       body{
         background-image: url('/img/duyun/pc/ad/login_background.jpg');
       }
    </style>
    
</head>
<body>
<img src="/img/duyun/pc/ad/login_background.jpg" class="register-img" alt="">
<div class=" register-content">
    <div class="row register-row">
        <div class="register-item">
            <input type="text" placeholder="您的手机号码" id="username"/>
        </div>
           <div class="row register-item">
            <div class="col-md-7 col-item-one">
                <input type="text" class="token-input" id="smsCode" placeholder="请输入验证码"/>
            </div>
            <div class="col-md-5 col-item-two">
                <button type="button" style="cursor: pointer;" onclick="requestSmsCode();" id="requestSmsCode" class="btn send-token">发送验证码</button>
            </div>
        </div>
        <div class="register-button">
            <button type="button" id="do_login" class="btn btn-warning register-btn" style="cursor: pointer;" onclick="doLogin();">登陆</button>
        </div>
    </div>
</div>
</body>
<script src="/js/jquery.min.js"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
<script src="/js/BASE64.js"></script>
<script type="text/javascript">
var paramObj = "${param.paramStr}";
var submitFlag = false;
var doLogin = function(){
	if(submitFlag){
		return;
	}
	var username = $("#username").val();
	var smsCode = $("#smsCode").val();
	if(!username.isPhone()){
		 $("#username").css("border","1px solid red");
		 return;
	}
	if(!$("#smsCode").val() || $("#smsCode").val().length != 6){
		 $("#smsCode").css("border","1px solid red");
		 return;
	 }
	submitFlag = true;
	Ajax.request("/doLoginByCode",{"data":{"username":username,"smsCode":smsCode},"success":function(data){
		submitFlag = false;
		if(data.code == 200){
			if(!paramObj){
			   window.location.href="/";
			}else{
				//如果是从需要登陆的页面跳转过来的
				var _paramObj = Base64.decode(paramObj);
				_paramObj = JSON.parse(_paramObj);
				if(_paramObj.pageType == "productDetail"){
					window.location.href="/product/detail?paramStr="+paramObj;
				}else if(_paramObj.pageType =='productConfirm'){
					window.location.href="/product/order/confirm?paramStr="+paramObj;
				}
			}
		}else{
			alert(data.msg);
		}
	}});
}
$(function(){
	   $("#password").focus(function(){
			  $(this).css("border","");
	  }); 
	  $("#username").focus(function(){
		  $(this).css("border","");
	  }); 
});

$(document).keyup(function(event) {
	if (event.keyCode == 13) {
		$("#do_login").trigger("click");
	}
});
var isSendCode = true;
var timeCount = 60;
var requestSmsCode = function(){
	   if(!isSendCode){
		   return;
	   }
	   var phone = $("#username").val();
	   if(!phone.isPhone()){
		   $("#user_name").css("border","1px solid red");
		   return;
	   }
	   Ajax.request("/sendCode",{"data":{"phone":phone,"codetype":0},"success":function(data){
		   if(data.code == 200){
			   isSendCode = false;
			   timeCount --;
			   $("#requestSmsCode").text(timeCount+"重新发送");
			   var a=setInterval(function(){
				   timeCount --;
				   $("#requestSmsCode").text(timeCount+"重新发送");
				   if(timeCount==0){
					   timeCount = 60;
					   isSendCode = true;
					   $("#requestSmsCode").text("发送验证码");
					   clearInterval(a);
				   }
			   },1000);
		   }else{
			   alert(data.msg);
		   }
	   }});
}
</script>
</html>