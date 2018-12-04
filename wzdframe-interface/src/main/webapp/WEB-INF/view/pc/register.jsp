<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/register.css" type="text/css">
    
    <style type="text/css">
       body{
         background-image: url('/img/duyun/pc/ad/login_background.jpg');
       }
    </style>
    
</head>
<body>
<%@ include file="common/ercode.jsp"%>
<div class=" register-content">
    <div class="row register-row">
        <div class="register-item">
            <input type="number" name="user_name" id="user_name" placeholder="您的手机号码"/>
           
        </div>
        <div class="register-item">
            <input type="text" id="password" name="password" placeholder="请输入6～16位密码"/>
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
            <button type="button" style="cursor: pointer;" class="btn btn-warning register-btn" onclick="register();">立即注册</button>
        </div>
        <div class="register-choice">
            <span class="register-text-one" style="margin-right: 90px;cursor: pointer;" onclick="window.location.href='/login'">立即登陆</span>
            <span class="register-text-one">注册视为同意</span>
            <span class="register-text">都匀用户使用协议</span>
        </div>
    </div>
</div>
</body>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
<script type="text/javascript">
   var isSendCode = true;
   var timeCount = 60;
   var requestSmsCode = function(){
	   if(!isSendCode){
		   return;
	   }
	   var phone = $("#user_name").val();
	   if(!phone.isPhone()){
		   $("#user_name").css("border","1px solid red");
		   return;
	   }
	   Ajax.request("/sendCode",{"data":{"phone":phone,"codetype":0},"success":function(data){
		   if(data.code == 200){
			   isSendCode = false;
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
   $(function(){
	   $("#password").focus(function(){
			  $(this).css("border","");
	  }); 
	  $("#user_name").focus(function(){
		  $(this).css("border","");
	  }); 
   });
   var register = function(){
	   //检测参数
	   if(!$("#user_name").val().isPhone()){
		   $("#user_name").css("border","1px solid red");
		   return;
	   }
	   if(!$("#password").val() || $("#password").val().length >= 16 || $("#password").val().length < 6){
		   $("#password").css("border","1px solid red");
		   return;
	   }
	   Ajax.request("/userRegedit",{"data":{"phone":$("#user_name").val(),"password":$("#password").val(),"smsCode":$("#smsCode").val()}
	   ,"success":function(data){
		   if(data.code == 200){
			   window.location.href="/login";
		   }else{
			   alert(data.msg);
		   }
	   }});
	   
   }
   
   

</script>
</html>