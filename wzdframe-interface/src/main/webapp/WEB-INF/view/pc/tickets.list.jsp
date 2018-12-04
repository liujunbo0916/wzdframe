<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-detail.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-list.css" type="text/css">
     <!--[if lt IE 9]>
       <script src="https://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
       <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.js"></script>
    <![endif]-->
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
 <form action="/ticket/list">
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
             <div style="cursor: pointer;" class="col-md-2 service-0" onclick="window.location.href='/hotel/list'">
                酒店预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1 active"  onclick="window.location.href='/ticket/list'">
                门票预订
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-2" onclick="window.location.href='/travel/route'">
                旅游路线
            </div>
        </div>
    </div>
</div>
<div id="carousel-example-generic" style="margin-top:1px;" class="carousel slide home-" data-ride="carousel">
 <ol class="carousel-indicators">
       <c:forEach items="${ads}" var="item" varStatus="status">
	        <li data-target="#carousel-example-generic" data-slide-to="0"  class="active"></li>
	   </c:forEach>        
    </ol>
    <div class="carousel-inner" role="listbox">
	        <c:forEach items="${ads}" var="item" varStatus="status">
		       <div class="carousel-item <c:if test="${status.index == 0}">active</c:if>">
		            <ul class="carousel-item-info" style="bottom: 30px;left: 830px;">
		                <li>
		                    <h4>${item.ad_title}</h4>
		                </li>
		                <li>
		                    <h5>${item.ad_desc}</h5>
		                </li>
		                <li>
		                    <button type="button" class="btn btn-secondary" onclick="goTolink('${item.ad_type}','${item.ad_relation_type}','${item.ad_relation_id}','${item.ad_url}');">查看详情</button>
		                </li>
		            </ul>
		            <img src="${SETTINGPD.IMAGEPATH}${item.ad_display}" style="width:1110px;" class="carousel-img" alt="Third slide">
		        </div>
	        </c:forEach>
    </div>
</div>
<div class="row service-content">
   <!--  <div class="col-md-12"> -->
       <div class="ticket-header">
            <span class="service-text">都匀服务</span>
            <span class="service-text">/</span>
            <span class="service-color-text">门票预定</span>
        </div>
   <div class="row comprehensive-content ">
        <div class="col-md-9 content-left" style="padding-left:0px;">
      <c:forEach begin="0" end="${page.currentSize}" var="ll">
       <div class="row list-container">
           <c:forEach items="${page.resultPd}" begin="${ll*3}" end="${ll*3+2}" var="item" varStatus="status">
	           <div class="col-md-3 list-item active" style="cursor:pointer;" onclick="goTicketDetail('${item.id}');">
	               <div class="image-hover">
	                   <img style="width: 250px;" src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}" alt="" onError="javascript:this.src='/img/no-img/no-img.jpg';">
	                   <div class="list-hover">
	                       <p class="hover-header">${item.scenic_name}</p>
	                       <div class="hover-text">${item.scenic_desc}</div>
	                   </div>
	               </div>
	               <div class="list-content">
	                   <p>
	                       <span class="list-info-text">${item.scenic_name}</span>
	                       <c:forEach items="${fn:split(item.scenic_lable,',')}" var="lable">
	                            <span class="list-info-date">${lable}</span>
	                       </c:forEach>
	                   </p>
	                   <div style="height:37px;overflow: hidden;margin-bottom: 20px;" class="list-text-detail">
	                        ${item.scenic_desc}
	                   </div>
	                   <p>
	                       <span class="list-info-amount">￥${item.scenic_ticket_price}</span>
	                       <span class="amount-text"> 起／人</span>
	                       <span class="list-info-count">${item.scenic_buy_count}购买</span>
	                      <!--  <button type="button" class="btn btn-secondary watch-list-detail">查看详情</button> -->
	                   </p>
	               </div>
	           </div>
           </c:forEach>
          
       </div>
   </c:forEach> 
   
   <div class="row footer-content">
    <div class="col-md-4">

    </div>
    <div class="col-md-5">
        <nav>
            <!-- <ul class="pagination">
                <li>
                    <a class="prev" href="#" aria-label="Previous">
                        上一页
                    </a>
                </li>
                <li><a class="page active" href="#">1</a></li>
                <li><a  class="page" href="#">2</a></li>
                <li><a  class="page" href="#">3</a></li>
                <li><a  class="page" href="#">4</a></li>
                <li><a  class="page" href="#">5</a></li>
                <li><a  class="page" href="#">6</a></li>
                <li><a  class="page" href="#">...</a></li>
                <li>
                    <a class="next" href="#" aria-label="Next">
                        下一页
                    </a>
                </li>
            </ul> -->
            ${page.pageStr}
        </nav>
    </div>
</div>
   
   </div>
     <div class="col-md-3 content-right" id="hotLine">
            <div class="row">
                <div class="hot-recommend">
                    热卖推荐
                </div>
            </div>
     <!--        <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="/img/duyun/pc/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="content-one">
                        <span class="travel-info-text">安顺</span>
                        <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="content-two">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div>
 -->
        </div>
   </div>
   <!--  </div> -->
</div>
<div class="good-hot">
    <div class="remen-header">热门商品</div>
    <div class="row remen-content" id="newGoodsRecommend">
    </div>
</div>
 </form>
<%@ include file="common/footer.jsp"%>
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/duyun/pc/redirectJ.js"></script>
<script type="text/javascript">
var imgPrefix = '${SETTINGPD.IMAGEPATH}';
   $(function(){
	   $(".list-item").hover(function(){
		   $(this).find(".list-hover").show();
	   },function(){
		   $(this).find(".list-hover").hide();
	   });
	   requestContent();
	   requestNewsGoods();
   });
   function requestContent(){
		 Ajax.request("/logic/hotLine",{"data":{"limit":'${page.currentSize+1}'},"success":function(data){
			if(data.code == 200){
				var htmlAry = [];
				var data = data.data;
				for(var i = 0 ; i < data.length ; i++){
					htmlAry.push(' <div class="row hot-recommend-list"><div class="hot-recommend-image">');
					htmlAry.push(' <img src="'+imgPrefix+data[i].grouptour_img+'" alt="" onerror="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"></div><div class="hot-recommend-content">');
					htmlAry.push(' <div style="height:50px;overflow: hidden;" class="content-one"><span class="travel-info-text">'+data[i].grouptour_name+'</span></div>');
					htmlAry.push('<p class="content-two"><span class="list-info-amount">￥'+data[i].grouptour_price+'</span><span class="amount-text"> 起／人</span></p>');
					htmlAry.push('</div></div>');
				}
				$("#hotLine").append(htmlAry.join(''));
			}
		}});
	 }
   //请求新品推荐
   function requestNewsGoods(){
 	  $("#newGoodsRecommend").empty();
 	  var htmlAry = [];
 	  Ajax.request("/logic/product/newRecommend",{"data":{"limit":'4'},"success":function(data){
 		  if(data.code == 200){
 			  var data = data.data;
 			  for(var i = 0 ; i < data.length ; i++){
 				  htmlAry.push('<div style="cursor:pointer;" onclick="goGoodsDetail('+data[i].goods_id+')" class="col-md-4 hot-list-item "><div class="image-hover">');
 				  htmlAry.push('<img src="'+imgPrefix+data[i].list_img+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"  alt=""></div>');
 				  htmlAry.push('<div class="good-list-content"><p><span class="list-info-text">'+data[i].goods_name+'</span>');
 				/*    if(data[i].goods_tags){
 					   var goodsTags = data[i].goods_tags.split(",");
 				       htmlAry.push('<span class="good-recommend">'+goodsTags[0]+'</span>');
 				   } */
 				  htmlAry.push('<p class="list-text-detail"><span class="amount">¥'+data[i].shop_price+'</span>');
 				  htmlAry.push('<strike>¥'+data[i].market_price+'</strike><span class="buy-span">'+data[i].virtual_sales+'人购买</span></p></div></div>');
 			  }
 			  $("#newGoodsRecommend").append(htmlAry.join(''));
 		  }
 	  }});
   }
/*    function toGoPage(id){
	   var ticketPatam = {
			   t_id:id
	   }
	   window.location.href='/ticket/detail?paramStr='+Base64.encode(JSON.stringify(ticketPatam));
   } */
   // adType 广告类型  adRtype 内部关联类型  adRId 内部关联ID adUrl 外部链接
  	function goTolink(adType,adRtype,adRId,adUrl){
  		if(adType == 0){
  			//1特产 2门票 3线路 4景点
  			if(adRtype == 1){
  				goGoodsDetail(adRId);
  				//window.location.href='/wx/product/detail?p_id='+adRId;
  			}else if(adRtype == 2){
  				goTicketDetail(adRId);
  				//window.location.href='/wx/ticket/index?redirectType=detail&t_id='+adRId;
  			}else if(adRtype == 3){
  				goTravelDetail(adRId);
  			//	window.location.href='/wx/grouptour/index?resultType=detail&grouptour_id='+adRId;
  			}else if(adRtype == 4){
  				goScenicDetail(adRId);
  				//window.location.href='/wx/scenic/detail?id='+adRId;
  			}
  		}else if(adType == 1){
  			//外部广告链接跳转
  			window.location.href=adUrl;
  		}
  	}
   
</script>
</body>
</html>