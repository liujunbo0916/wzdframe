<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
     <link rel="stylesheet" href="/css/duyun/pc/home.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-detail.css" type="text/css">
    <link rel="stylesheet" href="/css/duyun/pc/ticket-list.css" type="text/css">
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
          <div style="cursor: pointer;" class="col-md-2 service-0 active" onclick="window.location.href='/product/list'">
               都匀特产
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-1 "  onclick="window.location.href='/store/list'">
               都匀店铺
            </div>
            <div style="cursor: pointer;" class="col-md-2 service-2" onclick="window.location.href='/scenic/list'">
                都匀景点
            </div>
        </div>
    </div>
</div>
<div class="list-img-container">
    <img src="/img/duyun/pc/home.png" class="list-img" alt="">
</div>
<div class="row service-content">
    <div class="col-md-12">
       <div class="ticket-header">
            <span class="service-color-text">都匀特色</span>
            <span class="service-text">/</span>
            <span class="service-text">特产列表</span>
        </div>
      <c:forEach begin="0" end="${page.currentSize}" var="ll">
       <div class="row list-container" style="    margin-bottom: 20px;">
           <c:forEach items="${page.resultPd}" begin="${ll*3}" end="${ll*3+2}" var="item" varStatus="status">
	           <div style="cursor:pointer;" class="col-md-4 list-item active"  data-code="${item.goods_id}">
	               <div class="image-hover">
	                   <img style="width: 360px;" src="${SETTINGPD.IMAGEPATH}${item.list_img}" alt="" onError="javascript:this.src='/img/no-img/no-img.jpg';">
	                   <div class="list-hover">
	                       <p class="hover-header">${item.goods_name}</p>
	                       <p class="hover-text">${item.goods_desc}</p>
	                   </div>
	               </div>
	               <div class="list-content">
	                   <div style="height: 55px;overflow: hidden;">
	                       <span class="list-info-text">${item.goods_name}</span>
	                       <c:forEach items="${fn:split(item.goods_tags,',')}" var="lable">
	                            <span class="list-info-date">${lable}</span>
	                       </c:forEach>
	                   </div>
	                   <p class="list-text-detail">
	                        ${item.scenic_desc}
	                   </p>
	                   <p>
	                       <span class="list-info-amount">￥${item.shop_price}</span>
	                       <span class="list-info-count">${item.virtual_sales}购买</span>
	                       <button type="button" class="btn btn-secondary watch-list-detail">查看详情</button>
	                   </p>
	               </div>
	           </div>
           </c:forEach>
       </div>
   </c:forEach>       
    </div>
</div>
<div class="row footer-content">
    <div class="col-md-7">
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
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript">
   $(function(){
	  $(".list-item").click(function(){
		  var paramObj = {
				  goodsId:$(this).attr("data-code")
		  }
		  window.location.href='/product/detail?paramStr='+Base64.encode(JSON.stringify(paramObj));
	  }); 
   });
</script>
</body>
</html>