<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-sure.css" type="text/css">
    <style type="text/css">
       .input-tag{
		    display: inline-block;
		    border-radius: 2px;
		    font: 12px/14px simsun;
		    padding: 2px;
		    color: #fff;
       }
       .adult{
           background-color: #60b7ff;
       }
       .child{
              background-color: #ffb947;
              margin-right: 6px;
       }
       .scollFact{
         position: fixed;
         width: 450px;
         padding: 0;
         margin: auto;
         left: 1050px;
         top:200px;
         bottom:432px!important;
       }
    </style>
</head>
<body>
<%@ include file="common/header.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row nav-container">
    <div class="col-md-1"></div>
    <div class="col-md-1"></div>
     <div class="col-md-2 nav-logo" onclick="window.location.href='/'">
      <img alt="" src="/img/duyun/pc/LOGO.png">
    </div>
    <div class="col-md-2 "></div>
    <div class="col-md-6 nav-time-line">
        <div class="time_line_box">
            <div class="time_line">
                <div>
                    <span>
                        <a class="periodTitle selected" style="left: 0;"></a>
                        <li class="periodContent" style="left: 0;">提交订单</li>
                    </span>
                    <span>
                        <a class="periodTitle " style="left:144px;"></a>
                        <li class="periodContent" style="left:144px;">确认支付</li>
                    </span>
                    <span>
                        <a class="periodTitle" style="left:288px;"></a>
                         <li class="periodContent" style="left:288px;">完成购买</li>
                    </span>
                </div>
                <span class="filling_line"></span>
            </div>
        </div>
    </div>
</div>
<div class="sure-body">
    <div class="row travel-sure-content">
        <div class="col-md-8 route-info-left">
            <div class="route-information-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">路线信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            路线名称:
                        </div>
                        <div class="route-value">
                            ${dataModel.grouptour_name}
                        </div>
                    </div>
<!--                     <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            行程套餐:
                        </div>
                        <div class="route-value">
                            路线名称路线名称路线名称路线名称
                        </div>
                    </div>

 -->                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            出行人数:
                        </div>
                        <div class="route-value">
                             <c:if test="${not empty pd.adultNum && pd.adultNum ne 0}">
	                            <div class="person-group">
	                                <div class="input-group" style="width: 80px;">
	                                  <button type="button" class="child-quantity-left-minus btn  btn-number"
	                                        data-type="minus" data-field="">
	                                  <span class="glyphicon glyphicon-minus">${pd.adultNum}</span>
	                                </button>
	                                    <span class="person-text"> 成人</span>
	                                </div>
	                            </div>
                            </c:if>
                            <c:if test="${not empty pd.childsNum && pd.childsNum ne 0}">
	                            <div class="child-group">
	                                <div class="input-group" style="width: 80px;">
	                                    <button type="button" class="child-quantity-left-minus btn  btn-number"
	                                        data-type="minus" data-field="">
	                                  <span class="glyphicon glyphicon-minus">${pd.childsNum}</span>
	                                </button>
	                                    <span class="person-text">儿童</span>
	                                </div>
	                            </div>
                            </c:if>
                        </div>

                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            出行日期:
                        </div>
                        <div class="route-value">
                            <input type="text" disabled="disabled" class="value-input" value="${pd.traveDate}"/>
                        </div>
                    </div>

                </div>
            </div>
            <div class="route-person-information-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">联系人信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="must">*</span>
                            <span class="label-name">姓名:</span>
                        </div>
                        <div class="route-value">
                            <input type="text" id="con_name" class="name-input" placeholder="请输入您的真实姓名"/>
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="must">*</span>
                            <span class="label-name">联系方式:</span>
                        </div>
                        <div class="route-value">
                            <input type="text" class="tel-input" placeholder="+86"/>
                            <input type="text" id="con_phone" class="tel-input-value" placeholder=""/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="route-trip-information-container">
                <div class="row route-information-header">
                    <span class="info-line"></span>
                    <span class="info-text">出行人信息</span>
                </div>
                
       <c:if test="${pd.adultNum > 0}">          
          <c:forEach items="${pd.adultNum}" var="item" varStatus="status">      
	                <div class="trip-header">
	                    出行人${status.index+1}<span class="input-tag adult">成人</span>
	                </div>
	                <div class="trip-route-information-content">
	                    <div class="row router-information-row">
	                        <div class="col-md-3 label-div">
	                            <span class="must">*</span>
	                            <span class="label-name">姓名:</span>
	                        </div>
	                        <div class="route-value">
	                            <input type="text" class="checkConName name-input" placeholder="请输入您的真实姓名"/>
	                             <input type="hidden" class="tourType name-input"  value="1"/>
	                        </div>
	                    </div>
	                    <div class="row router-information-row">
	                        <div class="col-md-3 label-div">
	                            <span class="must">*</span>
	                            <span class="label-name">联系方式:</span>
	                        </div>
	                        <div class="route-value">
	                            <input type="text" class="tel-input" placeholder="+86"/>
	                            <input type="text" class="checkConPhone tel-input-value" placeholder=""/>
	                        </div>
	                    </div>
	                    <div class="row router-information-row">
	                        <div class="col-md-3 label-div">
	                            <span class="must">*</span>
	                            <span class="label-name">身份证号码:</span>
	                        </div>
	                        <div class="route-value">
	                            <input type="text" class="checkIdCard address-input-value" placeholder=""/>
	                        </div>
	                    </div>
	
	                </div>
                </c:forEach>
                </c:if>
                <c:if test="${pd.childsNum > 0}">
	                 <c:forEach items="${pd.childsNum}" var="item" varStatus="status">      
			                <div class="trip-header">
			                    出行人${pd.adultNum+status.index+1} <span class="input-tag child">儿童</span>
			                </div>
			                <div class="trip-route-information-content">
			                    <div class="row router-information-row">
			                        <div class="col-md-3 label-div">
			                            <span class="must">*</span>
			                            <span class="label-name">姓名:</span>
			                        </div>
			                        <div class="route-value">
			                            <input type="text" class="checkConName name-input" placeholder="请输入您的真实姓名"/>
			                            <input type="hidden" class="tourType name-input"  value="0"/>
			                        </div>
			                    </div>
			                    <div class="row router-information-row">
			                        <div class="col-md-3 label-div">
			                            <span class="must">*</span>
			                            <span class="label-name">联系方式:</span>
			                        </div>
			                        <div class="route-value">
			                            <input type="text" class="tel-input" placeholder="+86"/>
			                            <input type="text" class="checkConPhone tel-input-value" placeholder=""/>
			                        </div>
			                    </div>
			                    <div class="row router-information-row">
			                        <div class="col-md-3 label-div">
			                            <span class="must">*</span>
			                            <span class="label-name">身份证号码:</span>
			                        </div>
			                        <div class="route-value">
			                            <input type="text" class="checkIdCard address-input-value" placeholder=""/>
			                        </div>
			                    </div>
			                </div>
	                </c:forEach>
                </c:if>
            </div>
        </div>
        <div id="scollFact" class="col-md-4 router-info-right" style="position: fixed;width: 450px;padding: 0;margin: auto;left: 1050px;top:200px;">
            <div class="row info-right-header" style="overflow: hidden;">
               ${dataModel.grouptour_name}
            </div>
            <div class=" info-right-content">
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行人数
                    </div>
                    <div class="col-md-8 right-value">
                         ${pd.adultNum + pd.childsNum}
                </div>
                    </div>
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行日期
                    </div>
                    <div class="col-md-8 right-value">
                         ${pd.traveDate}
                    </div>
                </div>
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行费用
                    </div>
                    <div class="col-md-8 right-value" style="color: #fc9313;">
                     成人：¥ ${pd.adultNum*pd.adultPrice} &nbsp;&nbsp;&nbsp;儿童 ：¥ ${pd.childsNum*pd.childPrice}
                    </div>
                </div>
                <div class=" row info-right-bottom">
                    <div class="col-md-4 bottom-name">
                        总价:
                    </div>
                    <div class="col-md-8 bottom-value">
                        ¥${pd.adultNum*pd.adultPrice+pd.childsNum*pd.childPrice}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row footer">
    <div class="col-md-8">
        <span class="checkbox-span">
            <input type="checkbox" class="input-check" id="check3">
            <label for="check3"></label>
        </span>
        <span class="foot-color">我已阅读并同意</span>
        <span class="foot-text">预订须知、旅游合同、保险条款、保险经纪委托合同、安全提示</span>
    </div>
    <div class="col-md-4 footer-right">
        <button type="button" class="btn btn-secondary submit-btn" style="cursor: pointer;" onclick="submitOrder();">提交订单</button>
    </div>
</div>
<div class="modal fade" id="toLoginModal" tabindex="-2" role="dialog"  aria-labelledby="calendarModalLabel" aria-hidden="true">
	<!-- <div  id="toLogin" class="register-content">
	    <div class="row register-row">
	        <div class="register-item">
	            <input type="text" placeholder="您的手机号码" id="username">
	        </div>
	        <div class="register-item">
	            <input type="password" placeholder="请输入6～16位密码" id="password">
	        </div>
	        <div class="register-button">
	            <button type="button" id="do_login" class="btn btn-warning register-btn" style="cursor: pointer;" onclick="doLogin();">登陆</button>
	        </div>
	    </div>
	    <div class="register-select">
	        <span>第三方账号登陆:</span>
	        <img src="/img/duyun/pc/weixin.png" style="margin-left: 30px;cursor: pointer;" alt="">
	        <span onclick="anonymousBuy();"  style="margin-left: 90px;cursor: pointer;">匿名预定</span>
	    </div>
	</div> -->
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
</div>
<%@ include file="common/footer.jsp"%>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
</body>
<script type="text/javascript">
  var groupTourInfo = {
		  groupTourId:'${dataModel.grouptour_id}',
		  orderMoney:'${pd.adultNum*pd.adultPrice+pd.childsNum*pd.childPrice}',
		  adultNum:'${pd.adultNum}',
		  childsNum:'${pd.childsNum}',
		  tourDate:'${pd.traveDate}',
		  adultPrice:'${pd.adultPrice}',
		  childrenPrice:'${pd.childPrice}',
		  anonymous:0,
		  conName:'',
		  conPhone:'',
		  Tourists:[]
  }
  var paramCheck = function(){
  }
  paramCheck.errorTip=function(thisObj){
	   thisObj.css("border","solid 1px #ffd6ef");
	   thisObj.parent().prev().children().eq(1).css("color","red");
	   $("body").animate({scrollTop:thisObj.offset().top-50},"slow");
  }
  paramCheck.conNameConfirm = function(thisObj){
	   thisObj.css("border","");
	   thisObj.parent().prev().children().eq(1).css("color","");
  }
  
  $(function(){
	  $("#con_name").focus(function(){
		  paramCheck.conNameConfirm($(this));
	  });
	  $("#con_phone").focus(function(){
		  paramCheck.conNameConfirm($(this));
	  });
	  $(".checkConName").focus(function(){
		  paramCheck.conNameConfirm($(this));
	  });
	  $(".checkConPhone").focus(function(){
		  paramCheck.conNameConfirm($(this));
	  });
	  $(".checkIdCard").focus(function(){
		  paramCheck.conNameConfirm($(this));
	  });
  });
  var isSubmit =false;
  function submitOrder(){
	  if(!$("#check3").is(':checked')){
		   alert("请阅读并同意预定须知");
		   return;
	   }
	  if(isSubmit){
		 return; 
	  }
	  groupTourInfo.conName = $("#con_name").val();
	  groupTourInfo.conPhone = $("#con_phone").val();
	  if($("#con_name").val().isEmpty() || $("#con_name").val().length > 10){
		   paramCheck.errorTip($("#con_name"));
		   return;
	   }
	   if($("#con_phone").val().isEmpty() || !$("#con_phone").val().isPhone()){
		   paramCheck.errorTip($("#con_phone"));
		   return;
	   }
	   var conPersonItems = $(".trip-route-information-content");
	   //校验出行人信息
		   try{
			   groupTourInfo.Tourists=[];
			   conPersonItems.each(function(){
				   var Name = $(this).find(".checkConName").val();
				   var Mobile = $(this).find(".checkConPhone").val();
				   var IdCardNo = $(this).find(".checkIdCard").val();
				   if(Name.isEmpty() || Name.length > 10){
					   paramCheck.errorTip($(this).find(".checkConName"));
					   throw '校验名字出错';
					   return;
				   }
				   if(Mobile.isEmpty() || !Mobile.isPhone()){
					   paramCheck.errorTip($(this).find(".checkConPhone"));
					   throw '校验手机出错';
					   return;
				   }
				   if(IdCardNo.isEmpty() || IdCardNo.length > 18 || IdCardNo.length < 16){
					   paramCheck.errorTip($(this).find(".checkIdCard"));
					   throw '身份证号验证错误';
					   return;
				   }
				   groupTourInfo.Tourists.push({"checkType":$(this).find(".tourType").val(),"Name":Name,"Mobile":Mobile,"IdCardNo":IdCardNo});
			   });
		   }catch(e){
			   return;
		   }
		   isSubmit = true;
		   Ajax.request("/logic/grouptour/createOrder",{"data":{"paramStr":Base64.encode(JSON.stringify(groupTourInfo))},
			   "success":function(data){
				   if(data.code == 200){
					   var orderInfo = {
							   "order_id":data.data.order_id
					   }
					   window.location.href='/travel/payType?paramStr='+Base64.encode(JSON.stringify(orderInfo));
				   }else  if(data.code == 204){
					   isSubmit = false;
					   $("#toLoginModal").modal('show');
				   }else{
					   isSubmit = false;
					   alert(data.msg);
				   }
		   }})
  }
//登录功能
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
		if(!$("#smsCode").val()  || $("#smsCode").val().length != 6){
			 $("#smsCode").css("border","1px solid red");
			 return;
		 }
		submitFlag = true;
		Ajax.request("/doLoginByCode",{"data":{"username":username,"smsCode":smsCode},"success":function(data){
			submitFlag = false;
			if(data.code == 200){
				//成功之后调用提交票务订单接口
				$("#toLoginModal").modal('hide');
				submitOrder();
			}else{
				alert(data.msg);
			}
		}});
	}
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
//登录功能结束

//页面效果控制js
window.onscroll = function(){ 
    if(document.body.scrollHeight - 200 - getScrollTop() - 340 <= 440){
    	if(!$("#scollFact").hasClass("scollFact")){
    	  $("#scollFact").addClass("scollFact");
    	}
    }else{
    	if($("#scollFact").hasClass("scollFact")){
      	    $("#scollFact").removeClass("scollFact");
      	}
    }
} 
function getScrollTop()
{
    var scrollTop=0;
    if(document.documentElement&&document.documentElement.scrollTop)
    {
        scrollTop=document.documentElement.scrollTop;
    }
    else if(document.body)
    {
        scrollTop=document.body.scrollTop;
    }
    return scrollTop;
}

</script>
</html>