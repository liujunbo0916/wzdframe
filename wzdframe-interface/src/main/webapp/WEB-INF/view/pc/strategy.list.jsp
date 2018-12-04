<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/travel.strategy.css" type="text/css">
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
          <div class="row service-nav-right">
            <div class="col-md-2 service-0 active " style="cursor: pointer;" onclick="window.location.href='/guide/list'">
                旅游攻略
            </div>
            <div class="col-md-2 service-1  " style="cursor: pointer;" onclick="window.location.href='/content/list'">
                实时资讯
            </div>
            <div class="col-md-2 service-2 " style="cursor: pointer;" onclick="onBook(2);">
                旅游资讯
            </div>
        </div>
    </div>
</div>
<div class="travel-strategy-content">
        <div class="sure-header">
            <span class="my-order">都匀咨询</span>
            <span class="order-line">/</span>
            <span class="order-text">攻略列表</span>
        </div>
        <div class="row travel-strategy">
            <div class="col-md-8 travel-strategy-left">
                <c:forEach items="${page.resultPd}" var="item" >
	                <div class="row strategy-item" onclick="window.location.href='/guide/detail?line_id=${item.id}'">
	                    <div class="col-md-5 item-left">
	                        <img src="${SETTINGPD.IMAGEPATH}${item.line_logo}" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
	                    </div>
	                    <div class="col-md-7 item-right">
	                        <p class="right-one">
	                            ${item.line_name}
	                        </p>
	                        <p class="right-two">
	                           ${item.create_time}
	                        </p>
	                        <p class="right-three">
	                            ${item.line_tip}
	                        </p>
	                        <p class="right-four">
	                            <span class="eye-span">
	                                  <img src="/img/duyun/pc/travel/eye.png" class="eye-img" alt="">
	                                <span>&nbsp;&nbsp;2305</span>
	                            </span>
	                            <span class="message-span">
	                                  <img src="/img/duyun/pc/travel/message.png" class="messgae-img" alt="">
	                                <span>&nbsp;&nbsp;15</span>
	                            </span>
	                        </p>
	                    </div>
	                </div>
               </c:forEach> 
            </div>
            <div class="col-md-4 travel-strategy-right" id="scenicList">
                <div class="right-header">
                    相关景点
                </div>
              <!--   <div class="row hot-recommend-list">
                    <div class="hot-recommend-image">
                        <img src="./img/router.png" alt="">
                    </div>
                    <div class="hot-recommend-content">
                        <p class="content-one">
                            <span class="travel-info-text">安顺</span>
                            <span class="travel-info-text">荔波</span>
                            <span class="travel-info-text">西双日非</span>
                        </p>
                        <p class="content-twp">
                            今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈
                        </p>
                        <p class="content-three">
                            <span class="list-info-amount">$2250</span>
                            <span class="amount-text"> 起／人</span>
                        </p>
                    </div>
                </div> -->
            </div>
        </div>
</div>
<div class="row route-footer-content">
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-3">
            </div>
            <div class="col-md-9">
               ${page.pageStr}
            </div>
        </div>
    </div>
    <div class="col-md-4"></div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script  src="/js/Ajax.js"></script>
	<script src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
  $(function(){
	  requestScenicList();
  });
   var imgFiexd = '${SETTINGPD.IMAGEPATH}';
   function requestScenicList(){
	   Ajax.request("/logic/scenicList",{"data":{"limit":2},"success":function(data){
		   if(data.code == 200){
			   var data = data.data;
			   var htmlAry = [];
			   for(var i = 0 ; i<data.length ; i++){
				   htmlAry.push('<div onclick="goScenicDetail('+data[i].id+');" class="row hot-recommend-list" style="cursor:pointer;"><div class="hot-recommend-image">');
				   htmlAry.push('<img src="'+imgFiexd+data[i].scenic_logo+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" alt=""> </div><div class="hot-recommend-content"> <div class="content-one" style="height:20px;overflow: hidden;">'+data[i].scenic_name+'</div>');
				   htmlAry.push('<div style="height:44px;margin-top:15px;overflow: hidden;" class="content-twp">'+data[i].scenic_desc+'</div><p class="content-three"></p></div></div>')
			   }
			   $("#scenicList").append(htmlAry.join(''));
		   }
	   }});
   }
	function goScenicDetail(scenic_id){
		var scenicInfo = {
				id :scenic_id
		}
		window.open("/scenic/detail?paramStr="+Base64.encode(JSON.stringify(scenicInfo)));
	}
</script>
</html>