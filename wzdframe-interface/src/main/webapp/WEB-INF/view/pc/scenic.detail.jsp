<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/strategy-detail.css" type="text/css">
           <meta name="keywords" content="${dataModel.scenic_name}">
    <meta name="description" content="${dataModel.scenic_name}">
    <title>${dataModel.scenic_name}</title>
    <style type="text/css">
       .body-left img{
           width: 100%;
       }
    
    </style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
            <div class="col-md-2 service-0" onclick="onBook(0);">
                旅游攻略
            </div>
            <div class="col-md-2 service-1 " onclick="onBook(1);">
                实时资讯
            </div>
            <div class="col-md-2 service-2 active " onclick="onBook(2);">
                旅游资讯
            </div>
        </div>
    </div>
</div>
<div class="body-container">
    <div class="body-img">
        <img src="${SETTINGPD.IMAGEPATH}${dataModel.scenic_logo}"  onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
        <div class="img-hover">
            <div class="hover-one">
                ${dataModel.scenic_name}
            </div>
            <div class="hover-two" style="height:135px;overflow: hidden;">
             ${dataModel.scenic_desc}
            </div>
        </div>
    </div>
    <div class="row body-content" style="margin-top: 50px;">
        <div class="col-md-8 body-left" style="overflow: hidden;">
            ${dataModel.scenic_content}
        </div>
        <div class="col-md-4 body-right" id="scenicList">
            <p class="relative-spot">相关景点</p>
        <!--     <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="./img/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="recommend-one">
                        <span class="travel-info-text">安顺</span>
                        <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="recommend-two">
                        今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈

                    </p>
                    <p class="recommend-three">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div> -->
        <!--     <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="./img/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="recommend-one">
                        <span class="travel-info-text">安顺</span>
                          <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="recommend-two">
                        今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈

                    </p>
                    <p class="recommend-three">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div> -->
        </div>

    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
$(function(){
	requestScenicList();
});
var imgFiexd = '${SETTINGPD.IMAGEPATH}';
function requestScenicList(){
	   Ajax.request("/logic/scenicList",{"data":{"limit":2,"line_id":'${lineDetail.id}'},"success":function(data){
		   if(data.code == 200){
			   var data = data.data;
			   var htmlAry = [];
			   for(var i = 0 ; i<data.length ; i++){
				   htmlAry.push('<div onclick="goScenicDetail('+data[i].id+');" class="row hot-recommend-list"><div class="hot-recommend-image">');
				   htmlAry.push('<img src="'+imgFiexd+data[i].scenic_logo+'" alt=""> </div><div class="hot-recommend-content"> <div class="content-one" style="height:20px;overflow: hidden;">'+data[i].scenic_name+'</div>');
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