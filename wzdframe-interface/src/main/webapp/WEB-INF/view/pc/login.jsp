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
        <div class="register-item">
            <input type="password" placeholder="请输入6～16位密码" id="password"/>
        </div>
        <div class="register-button">
            <button type="button" id="do_login" class="btn btn-warning register-btn" style="cursor: pointer;" onclick="doLogin();">登陆</button>
        </div>
    </div>
    <div class="register-select">
        <span>第三方账号登陆:</span>
        <img src="/img/duyun/pc/weixin.png" onclick="window.open('${pcAuth}')" style="margin-left: 30px;cursor: pointer;"  alt="">
        <span onclick="window.location.href='/register'"  style="margin-left: 90px;cursor: pointer;">立即注册</span>
    </div>
</div>
</body>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
<script src="/js/BASE64.js"></script>
<script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
<script type="text/javascript">
var paramObj = "${param.paramStr}";
var submitFlag = false;
var doLogin = function(){
	if(submitFlag){
		return;
	}
	var username = $("#username").val();
	var password = $("#password").val();
	if(!username.isPhone()){
		 $("#username").css("border","1px solid red");
		 return;
	}
	if(!$("#password").val() || $("#password").val().length >= 16 || $("#password").val().length < 6){
		 $("#password").css("border","1px solid red");
		 return;
	 }
	submitFlag = true;
	Ajax.request("/doLogin",{"data":{"username":username,"password":password},"success":function(data){
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


/*
 * 微信登陆功能
 
 */
 var obj = new WxLogin({
     id:"login_container", 
     appid: "", 
     scope: "snsapi_login", 
     redirect_uri: "",
     state: "",
     style: "",
     href: ""
   });
 
 



</script>
</html>