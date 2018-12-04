<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>登录</title>
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="/assets/css/animate.min.css" rel="stylesheet">
    <link href="/assets/css/style.min.css" rel="stylesheet">
</head>
<body class="gray-bg">
   <div class="middle-box text-center loginscreen  animated fadeInDown">
       <div>
           <div>
             <h1 class="logo-home" style="color: #e6e6e6;">MiS</h1>
           </div>
           <h3>欢迎使用${system_name}</h3>
           <form class="m-t" role="form" action="checklogin" method="POST">
               <div class="form-group">
                   <input class="form-control" placeholder="用户名" required="required"  id="loginname" name="loginname" value="">
               </div>
               <div class="form-group">
                   <input type="password" class="form-control" placeholder="密码" name="password" id="password" value="">
               </div>

               <div class="form-group">
                   <div class="col-sm-7" style="padding-left: 0px;">
                       <input  class="form-control" placeholder="验证码" name="checkcode" id="checkcode" value="">
                   </div>
                   <div class="col-sm-2" style="padding-right: 0px;">
                       <img style="height: 34px;cursor: pointer;" id="showCheckCode" onclick="changeCheckCode();" src="/main/loginCheckCode" />
                   </div>
               </div>
               <div style="clear: both;"></div>
               <div class="form-group" style="margin-top: 20px;">
               <button type="button" id="do_login" onclick="Login.doLogin();" class="btn btn-primary block full-width m-b">登 录</button>
               </div>
           </form>
       </div>
    </div>
<script type="text/javascript" src="/assets/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/statics/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/statics/js/jquery.tips.js"></script>
<script type="text/javascript" src="/statics/js/util/Ajax.js"></script>
<script type="text/javascript" src="/statics/js/user/Login.js"></script>
<script type="text/javascript">
	$(document).keyup(function(event) {
		if (event.keyCode == 13) {
			$("#do_login").trigger("click");
		}
	});
	
	window.onload = function(){
		if(window.parent != window){
			window.parent.parent.location.reload();
		}
	}

    function changeCheckCode() {
        $("#showCheckCode").attr("src","/main/loginCheckCode?timestamp="+(new Date()).valueOf());
    }
</script>


</body>
</html>