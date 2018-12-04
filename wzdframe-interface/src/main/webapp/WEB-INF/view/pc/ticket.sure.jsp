<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-sure.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/calendar.css" type="text/css">
    <style type="text/css">
       #calendarTable tr td{
          cursor: pointer;
       }
       .disabled-click{
         color:#808080;
       }
       .scollFact{
         position: fixed;
         width: 450px;
         padding: 0;
         margin: auto;
         left: 1050px;
         top:200px;
         bottom:385px!important;
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
                    <span class="info-text">购票信息</span>
                </div>
                <div class="route-information-content">
                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            名称:
                        </div>
                        <div class="route-value">
                           ${ticketInfo.ticket_name}
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            出行日期:
                        </div>
                        <div class="route-value">
                            <input type="text" class="value-input" id="date_input" value="请选择日期"  role="button" data-toggle="modal" data-target="#calendarModal">
                            <img src="/img/duyun/pc/rili.png" class="rili-img" alt="" role="button" data-toggle="modal" data-target="#calendarModal">
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 route-name">
                            数量:
                        </div>
                        <div class="route-value">
                            <div class="person-group">
                                <div class="input-group">
                                    <span class="input-group-btn" data-code="minus">
                                        <button type="button" class="person-quantity-left-minus btn btn-number"
                                                data-type="minus" data-field="" >
                                          <span class="glyphicon glyphicon-minus">-</span>
                                        </button>
                                    </span>
                                    <input type="text" id="person-quantity" name="quantity"
                                           class="form-control input-number"
                                           value="${dataModel.MinBuyCount eq 0 ? 1 : dataModel.MinBuyCount}" min="0" step="1">
                                    <span class="input-group-btn" data-code="plus">
                                        <button type="button" class="person-quantity-right-plus btn  btn-number"
                                                data-type="plus" data-field="">
                                            <span class="glyphicon glyphicon-plus">+</span>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <!-- <div class="child-group">
                                <div class="input-group">
                            <span class="input-group-btn">
                                <button type="button" class="child-quantity-left-minus btn  btn-number"
                                        data-type="minus" data-field="">
                                  <span class="glyphicon glyphicon-minus">-</span>
                                </button>
                            </span>
                                    <input type="text" id="child-quantity" name="quantity"
                                           class="form-control input-number"
                                           value="10" min="0" step="1">
                                    <span class="input-group-btn">
                                <button type="button" class="child-quantity-right-plus btn  btn-number"
                                        data-type="plus" data-field="">
                                    <span class="glyphicon glyphicon-plus">+</span>
                                </button>
                            </span>
                                    <span class="person-text">儿童</span>
                                </div>
                            </div> -->
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
                            <input type="text" id="conName" class="name-input" placeholder="请输入您的真实姓名"/>
                            <span id="conNameError" style="display:none;color:red;font-size: 12px;font-style: italic;">格式非法</span>
                        </div>
                    </div>
                    <div class="row router-information-row">
                        <div class="col-md-3 label-div">
                            <span class="must">*</span>
                            <span class="label-name">联系方式:</span>
                        </div>
                        <div class="route-value">
                            <input type="text" class="tel-input" placeholder="+86"/>
                            <input type="text" id="conPhone" class="tel-input-value" placeholder=""/>
                            <span id="conNameError" style="display:none;color:red;font-size: 12px;font-style: italic;">格式非法</span>
                        </div>
                    </div>

                </div>
            </div>
            
	            <div class="route-trip-information-container" id="travelers" style="display: none;">
	                <div class="row route-information-header">
	                    <span class="info-line"></span>
	                    <span class="info-text">出行人信息<span style="color:#ffd6ef;">&nbsp;&nbsp;（该票需要实名认证，请填写出行人信息）</span></span>
	                </div>
        </div>
    </div>
    
    <div class="col-md-4 router-info-right" id="scollFact" style="position: fixed;width: 450px;padding: 0;margin: auto;left: 1050px;top:200px;">
            <div class="row info-right-header">
              订单信息
            </div>
            <div class=" info-right-content">
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行人数
                    </div>
                    <div class="col-md-8 right-value" id="order_person_num">
                         1
                    </div>
                </div>
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行日期
                    </div>
                    <div class="col-md-8 right-value" id="order_person_date">
                       未选择
                    </div>
                </div>
                <div class="row info-right-row">
                    <div class="col-md-4 right-name">
                        出行费用
                    </div>
                    <div class="col-md-8 right-value">
                                                            ￥  <span id="order_person_price"></span>
                    </div>
                </div>
                <div class=" row info-right-bottom">
                    <div class="col-md-4 bottom-name">
                        总价:
                    </div>
                    <div class="col-md-8 bottom-value" id="order_total_price">
                        
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
        <button type="button" onclick="submitTicketOrder();" class="btn btn-secondary submit-btn">提交订单</button>
    </div>
</div>
<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
    <div class="modal-dialog ticket-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="calendar ticket-calendar" id="calendar">
                    <div class="calendar-title-box">
                        <span class="prev-month" id="prevMonth">&lt;</span>
                        <span class="calendar-title" id="calendarTitle">2017年09月</span><span
                            id="nextMonth" class="next-month">&gt;</span></div>
                    <div class="calendar-body-box">
                        <table id="calendarTable" class="calendar-table">
                            <tbody id="dateList">
                            <tr class="calendar-header">
                                <th>日</th>
                                <th>一</th>
                                <th>二</th>
                                <th>三</th>
                                <th>四</th>
                                <th>五</th>
                                <th>六</th>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="toLoginModal" tabindex="-2" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
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
<!-- <script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script> -->
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/duyun/pc/travel.sure.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/InheritString.js"></script>

</body>
<script type="text/javascript">
   var ticketInfo = {
		   ticketTypeId:'${dataModel.TicketTypeId}',
		   minBuyCount:'${dataModel.MinBuyCount}',
		   maxBuyCount:'${dataModel.MaxBuyCount}',
		   isRealName:'${dataModel.IsRealName}',
		   stock:'${dataModel.Stock}',
		   SettlementPrice:'${dataModel.SettlementPrice}',
		   beginSaleTime:'${dataModel.BeginSaleTime}',
		   endSaleTime:'${dataModel.EndSaleTime}',
		   idCardLimitDays:'${dataModel.IdCardLimitDays}',
		   idCardLimitCount:'${dataModel.IdCardLimitCount}'
   }
   var dateListInfo = {
		   beginSaleTime:'${dataModel.BeginSaleTime}',
		   endSaleTime:'${dataModel.EndSaleTime}',
		   ticketTypeId:'${dataModel.TicketTypeId}',
		   select_month:'${currentMonth}',
		   select_year:'${currentYear}',
		   disabledMaxMonth:'',
		   disabledMaxYear:'',
		   disabledMinMonth:'',
		   disabledMinYear:''
   }
   //待购买的票务信息
   var submitTicketInfo = {
		   TravelDate:'',
		   ThirdOrderId:'', //平台订单编号
		   TicketTypeId:'${dataModel.TicketTypeId}', //三方票务id
		   RetailPrice:'',   //零售价格
		   SettlementPrice:'', //结算价格
		   Quantity:'',        //数量
		   ContactName:'',    //联系人姓名
		   ContactMobile:'',  //联系人手机
		   PaymentMethod:1,    //支付方式
		   isRealName:'${dataModel.IsRealName}',
		   anonymous:0, //是否匿名购买  默认false
		   Tourists:[]
   }
   
   var paramCheck = function(){
   }
   paramCheck.errorTip=function(thisObj){
	   thisObj.css("border","solid 1px #ffd6ef");
	   thisObj.parent().prev().children().eq(1).css("color","red");
   }
   paramCheck.conNameConfirm = function(thisObj){
	   thisObj.css("border","");
	   thisObj.parent().prev().children().eq(1).css("color","");
   }
   
   $(function(){
	   //登录控制
	   if (event.keyCode == 13) {
			$("#do_login").trigger("click");
		}
	   $("#password").focus(function(){
			  $(this).css("border","");
	  }); 
	  $("#username").focus(function(){
		  $(this).css("border","");
	  }); 
	   //登录控制结束
	   $(".input-group-btn").click(function(){
		   var groupType = $(this).attr("data-code");
		   var inputValue = parseInt($("#person-quantity").val())
		   if("plus" == groupType){
			   if(parseInt(ticketInfo.maxBuyCount) == 0){
			      inputValue ++;
			   }else{
				   if(inputValue < parseInt(ticketInfo.maxBuyCount)){
					   inputValue ++;
				   }
			   }
		   }else if("minus" == groupType){
			   if(ticketInfo.minBuyCount == 0){
				   ticketInfo.minBuyCount = 1
			   }
			   if(inputValue > parseInt(ticketInfo.minBuyCount)){
				   inputValue--;
			   }
		   }
		   $("#order_person_num").text(inputValue);
		   $("#person-quantity").val(inputValue);
		   calPrice();
	   });
	   requestDateList();
	   $("#prevMonth").click(function(){
		   if($(this).hasClass("disabled-click")){
			   return;
		   }
		   $("#nextMonth").removeClass("disabled-click");
		   dateListInfo.select_month = parseInt(dateListInfo.select_month)-1;
		   dateListInfo.select_year = parseInt(dateListInfo.select_year);
		   if(dateListInfo.select_month < 1){
			   dateListInfo.select_month = 12;
			   dateListInfo.select_year = dateListInfo.select_year-1;
		   }
		   requestDateList("min",this);
	   });
	   $("#nextMonth").click(function(){
		   if($(this).hasClass("disabled-click")){
			   return;
		   }
		   $("#prevMonth").removeClass("disabled-click");
		   dateListInfo.select_month = parseInt(dateListInfo.select_month)+1;
		   dateListInfo.select_year = parseInt(dateListInfo.select_year);
		   if(dateListInfo.select_month > 12){
			   dateListInfo.select_month = 1;
			   dateListInfo.select_year = dateListInfo.select_year + 1;
		   }
		   requestDateList("max",this);
	   });
	   $("#conName").blur(function(){
		   if($("#conName").val().isEmpty() || $("#conName").val().length > 10){
			   paramCheck.errorTip($("#conName"));
		   }else{
			   paramCheck.conNameConfirm($("#conName"));
		   }
	   });
	   $("#conPhone").blur(function(){
		   if($("#conPhone").val().isEmpty() || !$("#conPhone").val().isPhone()){
			   paramCheck.errorTip($("#conPhone"));
		   }else{
			   paramCheck.conNameConfirm($("#conPhone"));
		   }
	   });
	   $("#conName").focus(function(){
		   paramCheck.conNameConfirm($("#conName"));
	   });
	   $("#conPhone").focus(function(){
		   paramCheck.conNameConfirm($("#conPhone"));
	   });
   });
   var requestDateList = function(clickType,thisObj){
	   Ajax.request("/logic/ticket/dateList",{"data":{"paramStr":Base64.encode(JSON.stringify(dateListInfo))},"success":function(data){
		   if(data.code == 200){
			   //返回成功   渲染日期控件
			   var dataInfo = data.data;
			   dateListInfo.disabledMinMonth = dataInfo.disabledMinMonth;
			   dateListInfo.disabledMinYear = dataInfo.disabledMinYear;
			   dateListInfo.disabledMaxMonth = dataInfo.disabledMaxMonth;
			   dateListInfo.disabledMaxYear = dataInfo.disabledMaxYear;
			   //控制显示
			   $("#calendarTitle").text(dateListInfo.select_year+"年"+dateListInfo.select_month+"月");
			   //控制向前向后按钮的disabled状态
			   if(dataInfo.disabledMinMonth ==  dataInfo.monthParam && dataInfo.disabledMinYear == dataInfo.yearParam){
		          	 $("#prevMonth").addClass("disabled-click");
			   }
			   if(dataInfo.disabledMaxMonth ==  dataInfo.monthParam && dataInfo.disabledMaxYear == dataInfo.yearParam){
				     $("#nextMonth").addClass("disabled-click");
			   }
			   var data = dataInfo.jsonData;
			   $("#dateList").empty();
			   var htmlAry = ['<tr class="calendar-header"> <th>日</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th></tr>'];
			   for(var i = 0 ; i < data.length ; i++){
				   var dateTemple = data[i];
				   if(i % 7 == 0){
				      htmlAry.push('<tr>');
				   }
				   if(data[i].dayOfMonth !='0' && data[i].Stock !='0'){
					   if(parseInt(data[i].dayOfMonth) < 10){
						   data[i].dayOfMonth = "0"+data[i].dayOfMonth;
					   }
					   var kucun = "充足";
					   if(parseInt(data[i].Stock)<10){
						   if(data[i].Stock != "-1"){
						      kucun = data[i].Stock;
						   }
					   }
					   htmlAry.push('<td data-code='+"'"+''+JSON.stringify(data[i])+''+"'"+'" class="currentDay" data-dismiss="modal" onclick="selectDate(this);"><div class="calendar-cell">');
					   htmlAry.push('<div class="cell-date" style="color:#333">'+data[i].dayOfMonth+'</div><div class="cell-price">￥'+data[i].SettlementPrice+'</div>');
					   htmlAry.push('<div class="cell-status">'+kucun+'</div></div></td>');
				   }else if(data[i].dayOfMonth !='0' && data[i].Stock =='0'){
					   if(parseInt(data[i].dayOfMonth) < 10){
						   data[i].dayOfMonth = "0"+data[i].dayOfMonth;
					   }
					   htmlAry.push('<td data="20170902" class="currentMonth">');
					   htmlAry.push('<div class="calendar-cell">');
					   htmlAry.push('<div class="cell-date" >'+data[i].dayOfMonth+'</div></div> </td>');
				   }else{
					   htmlAry.push('<td></td>');
				   }
				   if(i % 7 == 6){
					      htmlAry.push('</tr>');
					}
			   }
			   $("#dateList").append(htmlAry.join(''));
		   }
	   }});
   }
   //点击选择日期
   function selectDate(thisObj){
	   var ticketInfo = $(thisObj).attr("data-code");
	   ticketInfo =  JSON.parse(ticketInfo);
	   $("#date_input").val(ticketInfo.Date);
	   $("#order_person_date").text(ticketInfo.Date);
	   $("#order_person_price").text(ticketInfo.SettlementPrice);
	   submitTicketInfo.TravelDate = ticketInfo.Date;
	   submitTicketInfo.RetailPrice = ticketInfo.RetailPrice;
	   submitTicketInfo.SettlementPrice = ticketInfo.SettlementPrice;
	   calPrice();
   }
   
   
   //计算订单金额
   function calPrice(){
	  var quantity = $("#person-quantity").val();
	  var singlePrice =$("#order_person_price").text();
	  if(quantity && singlePrice){
		  quantity  = parseInt($("#person-quantity").val());
		  singlePrice = parseFloat($("#order_person_price").text());
	      $("#order_total_price").text("￥ "+toDecimal(quantity*singlePrice));
	  }
   }
   //提交订单
   
   var realNameftl = [];
   realNameftl.push('<div class="trip-header"> 出行人{{1}}</div><div class="trip-route-information-content"><div class="row router-information-row"><div class="col-md-3 label-div">');
   realNameftl.push('<span class="must">*</span><span class="label-name">姓名:</span></div> <div class="route-value"><input type="text" class="name-input checkConName" placeholder="请输入您的真实姓名"/>');
   realNameftl.push('</div></div><div class="row router-information-row"><div class="col-md-3 label-div"><span class="must">*</span>');
   realNameftl.push('<span class="label-name">联系方式:</span> </div><div class="route-value"><input type="text" class="tel-input" placeholder="+86"/>');
   realNameftl.push('<input type="text" class="tel-input-value checkConPhone" placeholder=""/></div></div><div class="row router-information-row">');    
   realNameftl.push('<div class="col-md-3 label-div"><span class="must">*</span><span class="label-name">身份证号码:</span>');
   realNameftl.push('</div><div class="route-value"> <input type="text" class="address-input-value checkIdCard" placeholder=""/></div></div></div>');
   
   function submitTicketOrder(){
	   
	   if(!$("#check3").is(':checked')){
		   alert("请阅读并同意预定须知");
		   return;
	   }
	   submitTicketInfo.Quantity = $("#person-quantity").val();
	   
	   if($("#conName").val().isEmpty() || $("#conName").val().length > 10){
		   paramCheck.errorTip($("#conName"));
		   return;
	   }
	   submitTicketInfo.ContactName = $("#conName").val();
	   
	   if($("#conPhone").val().isEmpty() || !$("#conPhone").val().isPhone()){
		   paramCheck.errorTip($("#conPhone"));
		   return;
	   }
	   submitTicketInfo.ContactMobile = $("#conPhone").val();
	   if(!submitTicketInfo.TravelDate){
		   alert("请选择出行日期");
		   return;
	   }
	   if(ticketInfo.isRealName == "true"){
		   var conPersonItems  = $(".trip-route-information-content");
		   //实名认证信息没有加入进联系人队列
		   if(!conPersonItems || conPersonItems.length != submitTicketInfo.Quantity){
			   alert("实名认证,并且没有实名信息");
			   $("#travelers").show();
			   //根据人数生成实名认证
			   $("#travelers").empty();
			   for(var i = 0 ; i < parseInt(submitTicketInfo.Quantity) ; i++){
				   var htmlStr = new String(realNameftl.join(''));
				   htmlStr = htmlStr.replace("{{1}}",i+1);
			      $("#travelers").append(htmlStr);
			   }
			   litennerTraveler();
			   return;
		   }else{
			   //添加联系人信息
			   submitTicketInfo.Tourists.length = 0;
			   try{
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
					   submitTicketInfo.Tourists.push({"Name":Name,"Mobile":Mobile,"IdCardNo":IdCardNo});
				   });
			   }catch(e){
				   return;
			   }
		   }
	   }
	   var paramStr = Base64.encode(JSON.stringify(submitTicketInfo));
	   Ajax.request("/logic/ticket/addOrder",{"data":{"paramStr":paramStr},"success":function(data){
		   if(data.code == 200){
			   var orderInfo = {
					   "order_id":data.data.o_id
			   }
			   window.location.href='/ticket/payType?paramStr='+Base64.encode(JSON.stringify(orderInfo));
		   }else if(data.code == 204){
			   $("#toLoginModal").modal('show');
		   }else{
			   alert(data.msg);
		   }
	   }});
   }
   function toDecimal(x) { 
	      var f = parseFloat(x); 
	      if (isNaN(f)) { 
	        return; 
	      } 
	      f = Math.round(x*100)/100; 
	      return f; 
  } 
   function litennerTraveler(){
	   
	   $(".checkConName").blur(function(){
		   if($(this).val().isEmpty() || $(this).val().length > 10){
			   $(this).css("border","solid 1px #ffd6ef");
			   $(this).parent().prev().children().eq(1).css("color","red");
		   }else{
			   $(this).css("border","");
			   $(this).parent().prev().children().eq(1).css("color","");
		   }
	   });
	   $(".checkConName").focus(function(){
		   $(this).css("border","");
		   $(this).parent().prev().children().eq(1).css("color","");
	   });
	   
	   $(".checkConPhone").blur(function(){
		   if($(this).val().isEmpty() || !$(this).val().isPhone()){
			   $(this).css("border","solid 1px #ffd6ef");
			   $(this).parent().prev().children().eq(1).css("color","red");
		   }else{
			   $(this).css("border","");
			   $(this).parent().prev().children().eq(1).css("color","");
		   }
	   });
	   $(".checkConPhone").focus(function(){
		   $(this).css("border","");
		   $(this).parent().prev().children().eq(1).css("color","");
	   });
	   
	   $(".checkIdCard").blur(function(){
		   if($(this).val().isEmpty() || $(this).val().length > 18 || $(this).val().length < 16){
			   $(this).css("border","solid 1px #ffd6ef");
			   $(this).parent().prev().children().eq(1).css("color","red");
		   }else{
			   $(this).css("border","");
			   $(this).parent().prev().children().eq(1).css("color","");
		   }
	   });
	   $(".checkIdCard").focus(function(){
		   $(this).css("border","");
		   $(this).parent().prev().children().eq(1).css("color","");
	   });
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
				submitTicketOrder();
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
		   $("#requestSmsCode").text(timeCount+"重新发送");
		   Ajax.request("/sendCode",{"data":{"phone":phone,"codetype":0},"success":function(data){
			   if(data.code == 200){
				   isSendCode = false;
				   timeCount --;
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
    if( getScrollTop()> 245/* document.body.scrollHeight - 200 - getScrollTop() - 340 <= 440 */){
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