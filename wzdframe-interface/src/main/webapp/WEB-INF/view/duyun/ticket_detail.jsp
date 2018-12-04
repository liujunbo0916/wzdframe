<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>门票详情</title>
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
    <link rel="stylesheet" href="/css/duyun/mpxq.css">
</head>
<style>
#popover {
  position: fixed;
  bottom: 50px;
  left: 0;
  z-index: 20;
  display: none;
  width: 100%;
  background-color: #FFF;
}
#popover .content {
    position: relative;
    background: #FFF;
    min-height: 300px;
    height:300px;
    text-align: center;
}

.bar{
    position: absolute;
    right: 15px;
    top: 5px!important;
    padding-right: 10px;
    padding-left: 10px;
    background-color: white;
    border-bottom: 1px solid #ddd;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
}
.icon {
  font-weight: normal;
   color: #000;
    position: absolute;
    display: inline-block;
    font-family: Ratchicons;
    font-size: 24px;
    line-height: 1;
    text-decoration: none;
    -webkit-font-smoothing: antialiased;
    right: 10px;
}
#scenic_introduce img{
  width: 100%;
}
#gobuysay img{
  width: 100%;
}
</style>
<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content ticketlist">
        <div class="tour-info-box">
            <img class="banner" id="scenicLogo" src="/img/duyun/mpjdjs/1.jpg"  onerror="javascript:this.src='/img/duyun/mpjdjs/1.jpg';" alt="" />
            <div class="tour-info">
                <div class="tour-info-marks">
                    <div class="tour-info-name" id="scenicName"></div>
                </div>
                <div class="tour-describe" id="scenicDesc" style="    height: 40px; overflow: hidden;">
                </div>
            </div>
        </div>
        <ul class="table-view">
            <li class="table-view-cell" id="scenic_introduce">
                <a class="navigate-right">
                    景点介绍
                </a>
            </li>
            <li class="table-view-cell up" id="gobuysay" onclick="showFlightDetail(1)">
                <a class="navigate-right">
                    预定说明
                </a>
            </li>
        </ul>
        <!-- <div class="ticket-list">
            <div class="ticket-type-wrap">
                <div class="ticket-type">特惠推荐</div>
            </div>
            <div class="ticket-info-block">
                <div class="ticket-title">【2017中、高考考生优惠票】燕子岩景区门票（不含观 光车） （每个手机号仅可预订一张）</div>
                <div class="ticket-item-info">
                    <div class="ticket-item-left">
                        <div class="ticket-time-box">
                            <span>可订今日票</span>
                            <span>随时退</span>
                        </div>
                        <div class="ticket-detailed">
                            购买须知
                        </div>
                    </div>
                    <div class="ticket-item-right">
                        <span class="ticket-tag-price">¥ 9.9</span>
                        <span class="ticket-old-price">￥60</span>
                        <div class="ticket-book-btn">
                            立即预订
                        </div>
                    </div>
                </div>
            </div>
        </div>
         -->
        <!-- <div class="ticket-list">
            <div class="ticket-type-wrap">
                <div class="ticket-type">优待票</div>
            </div>
            <div class="ticket-info-block">
                <div class="ticket-title">【2017中、高考考生优惠票】燕子岩景区门票（不含观 光车） （每个手机号仅可预订一张）</div>
                <div class="ticket-item-info">
                    <div class="ticket-item-left">
                        <div class="ticket-time-box">
                            <span>可订今日票</span>
                            <span>随时退</span>
                        </div>
                        <div class="ticket-detailed">
                            购买须知
                        </div>
                    </div>
                    <div class="ticket-item-right">
                        <span class="ticket-tag-price">¥ 9.9</span>
                        <span class="ticket-old-price">￥60</span>
                        <div class="ticket-book-btn">
                            立即预订
                        </div>
                    </div>
                </div>
            </div>
        </div> -->
    </div>
       <div class="spinner">
        <div class="loading">
            <img src="/img/duyun/dstc/loading.gif" alt=""/>
        </div>
    </div>
     <!--飞机票明细-->
    <div id="popover" class="flight-detail" style="display: none;">
        <div class="content" style="margin-bottom: -50px;">
                 <div style="margin-top: 10px;">
                 	<span id="pop_title"></span>
                 	<a class="icon icon-close pull-right" id="closed" onclick="closePopover()"></a>
                 </div>
                 <div class="cont" style="padding: 10px;margin-top: 10px;" id="pop_text">
                 </div>
        </div>
    </div>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript">
function UrlSearch() 
{
   var name,value; 
   var str=location.href; //取得整个地址栏
   var num=str.indexOf("?") 
   str=str.substr(num+1); //取得所有参数   stringvar.substr(start [, length ]

   var arr=str.split("&"); //各个参数放到数组里
   for(var i=0;i < arr.length;i++){ 
    num=arr[i].indexOf("="); 
    if(num>0){ 
     name=arr[i].substring(0,num);
     value=arr[i].substr(num+1);
     this[name]=value;
     } 
    } 
} 



var loadingPanel = document.querySelector('.spinner');
var loadingPoP = document.querySelector('.popwindows');
$(function(){
	 $("#scenic_introduce").click(function(){
		window.location.href='/wx/ticket/index?redirectType=introduce&id='+'${pd.t_id}'; 
	  });
	requestTicketDetail();
});
var scenicBookKnow='';
 function requestTicketDetail(){
	 Ajax.request("/wx/ticket/doDetail",{"data":{"t_id":'${pd.t_id}',"travelers_id":'${pd.travelers_id}'},"success":function(data){
		 if(data.code == 200){
			 try{
				 var data = data.data;
				 $("#scenicLogo").attr("src",data.scenicLogo);
				 $("#scenicName").text(data.scenicName);
				 $("#scenicDesc").text(data.scenicDesc);
				 var scenicLable = data.scenicLable || '';
				 scenicLable = scenicLable.split(",");
				 for(var i = 0 ; i < scenicLable.length ; i++){
					 if(scenicLable[i]){
					 	$("#scenicName").parent().append("<span>"+scenicLable[i]+"</span>");
					 }
				 }
				 scenicBookKnow=data.scenicBookKnow; 
				 // scenicBookKnow 预订须知
				 var ticketCates = data.ticketCates;
				 var catesAry = [];
				 for(var i = 0 ; i < ticketCates.length ; i++){
					 catesAry.push(' <div class="ticket-list"><div class="ticket-type-wrap"><div class="ticket-type">'+ticketCates[i].cateName+'</div></div>');
					 var ticketList = ticketCates[i].tickets;
					 for(var j = 0 ; j < ticketList.length ; j++){
						 catesAry.push('<div class="ticket-info-block"><div class="ticket-title">'+ticketList[j].ticketName+'</div>');
						 catesAry.push('<div class="ticket-item-info"><div class="ticket-item-left"><div class="ticket-time-box">');
						 var ticketLable = ticketList[j].ticketLable || '';
						 if(ticketLable){
							 ticketLable = ticketLable.split(",");
							 for(var k = 0 ; k < ticketLable.length ; k++){
								 catesAry.push('<span>'+ticketLable[k]+'</span>');
							 }
						 }
						 catesAry.push('</div><div class="ticket-detailed up" onclick="showFlightDetail(2,'+"'"+''+ticketList[j].ticketTip+''+"'"+')">购买须知</div> </div><div class="ticket-item-right">');
						 catesAry.push('<span class="ticket-tag-price">¥ '+ticketList[j].settlementPrice+'</span><div class="ticket-book-btn" onclick='+'getTicket("'+ticketList[j].ticketId+'","'+data.scenicId+'")>');
						 catesAry.push('立即预订 </div></div></div></div>');
					 }
					 catesAry.push('</div>');
				 }
				 $(".ticketlist").append(catesAry.join(''));
			 }catch(e){
				 loadingPanel.style.display = 'none';
			 }
		 }
		 loadingPanel.style.display = 'none';
	 }});
 }
 var ticketIds = '${pd.tids}';
 function getTicket(ticketId,scenicId){
	 var Request=new UrlSearch(); 
	  /*  if(!'${user.phone}'){
		 window.location.href="/wx/duyun/user/bingphone?bingType=ticketDetail?t_id="+Request.t_id+"&pageType=${pd.pageType}";
		 return;
	 }  */
	/*window.location.href='/wx/ticket/index?redirectType=confirmOrder&ticketId='+ticketId+'&ticketName='+ticketName; */
	if(ticketIds){
		ticketIds = ticketIds+","+ticketId;
	}else{
		ticketIds = ticketId;
	}
	window.location.href='/wx/ticket/index?redirectType=confirmOrder&pageType=${pd.pageType}&ticketIds='+ticketIds+"&scenic_id="+scenicId;
 }
 // 显示popover
 var showPopover = function (popNode) {
     var popover = popNode || document.getElementById('popover');
     popover.style.display = 'block';
     var backdrop = document.createElement('div');
     backdrop.classList.add('backdrop');
     backdrop.style.zIndex = 8;
     popover.parentNode.appendChild(backdrop);
     popover.classList.add('visible');
 };

 // 隐藏popover
 var hiddenPopover = function (popNode) {
     var popover = popNode || document.getElementById('popover');
     popover.style.display = 'none';
     var backdrop = document.querySelector('.backdrop');
     popover.parentNode.removeChild(backdrop);
     popover.classList.remove('visible');
 };

 // 隐藏popover
 var closePopover = function () {
     var toggleBtn = document.querySelector('#gobuysay');
     var popover = document.getElementById('popover');
     if(!toggleBtn.classList.contains('up')){
         toggleBtn.classList.add('up');
     }
     hiddenPopover(popover);
 };
 
 var showFlightDetail = function (type,cont) {
	 var toggleBtn = document.querySelector('#gobuysay');
     var popover = document.getElementById('popover');
     if(toggleBtn.classList.contains('up')){
         toggleBtn.classList.remove('up');
         popover.style.removeProperty('top');
         showPopover(popover);
     }else {
         toggleBtn.classList.add('up');
         closePopover(popover);
     }
     showContent(type,cont);
 };
 
 var showFlightDetails = function (objthis,type,cont) {
     var popover = document.getElementById('popover');
     if($(objthis).hasClass("active")){
    	 $(objthis).removeClass('up');
         popover.style.removeProperty('top');
         showPopover(popover);
	 }else{
		 $(objthis).addClass('up');
	     closePopover(popover);
	 }
 };
 //显示内容 
 function showContent(type,cont){
	 if(type == 1){
		 $("#pop_title").html("预订说明");
		 if(scenicBookKnow){
			 $("#pop_text").html(scenicBookKnow);
		 }else{
			 $("#pop_text").html("暂无信息");
		 }
	 }else{
		 $("#pop_title").html("购买须知");
		 if(cont){
			 $("#pop_text").html(cont);
		 }else{
			 $("#pop_text").html("暂无信息");
		 }
		 
	 }
 }
	 //监听返回按钮
	 if("content"=='${pd.pageType}'){
		 GoBackBtn.excuteHistory("/wx/content/list");
	 }else if("homeDetail" == '${pd.pageType}'){
		 GoBackBtn.excuteHistory("/wx/home");
	 }else{
		 GoBackBtn.excuteHistory("/wx/ticket/index?redirectType=list&pageType=${pd.pageType}");
	 }
</script>
</html>