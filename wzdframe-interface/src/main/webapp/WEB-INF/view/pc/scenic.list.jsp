<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="keywords" content="${SEO.seo_value}">
<meta name="description" content="${SEO.seo_description}">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <!--<link rel="stylesheet" href="./css/strategy-detail.css" type="text/css">-->
    <link rel="stylesheet" href="/css/duyun/pc/scenic.css">
    <style type="text/css">
       .scenic-item{
        cursor: pointer;
       }
    </style>
    <title>${SEO.seo_web_title}</title>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
            <div style="cursor: pointer;" onclick="window.location.href='/product/list'" class="col-md-2 service-1 " onclick="onBook(1);">
                都匀特产
            </div>
            <div class="col-md-2 service-2 " style="cursor: pointer;" onclick="window.location.href='/store/list'"   onclick="onBook(2);">
                都匀店铺
            </div>
               <div class="col-md-2 service-0 active" onclick="onBook(0);">
                都匀景点
            </div>
            
        </div>
    </div>
</div>
<div class="body-content">
    <div class="body-img">
        <img src="/img/duyun/pc/ad/ad_1.jpg" alt="">
    </div>
    <div class="scenic-body">
        <c:forEach begin="0" end="${page.currentSize}" var="ll">
		        <div class="row img-content">
		            <c:forEach items="${page.resultPd}" begin="${ll*3}" end="${ll*3+2}" var="item" varStatus="status">
			            <div onclick="goScenicDetail(${item.id});" class="col-md-4 scenic-item <c:if test="${status.index % 3 == 2}">last-item</c:if>">
			                <img src="${SETTINGPD.IMAGEPATH}${item.scenic_logo}" class="scenic-img" onError="javascript:this.src='/img/no-img/no-img.jpg';" alt="">
			                <div class="row img-hover" style="display: none;">
			                    <div class="col-md-9">
			                                  ${item.scenic_name}
			                    </div>
			                    <div class="col-md-3">
			                        <img src="/img/duyun/pc/right-arrow.png" class="right-arrow" alt="">
			                    </div>
			                </div>
			            </div>
		            </c:forEach>
		        </div>
        </c:forEach>
        <div class="scenic-footer">
            ${page.pageStr}
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
<script type="text/javascript">
    
    $(function(){
    	$(".scenic-item").hover(function(){
    		$(this).find(".img-hover").show('slow');
    	},function(){
    		$(this).find(".img-hover").hide('slow');
    	});
    });
    //重写nextPage方法
	function nextPage(num){
		   var url = "/scenic/list?currentPage="+num;
		   window.location.href=url;
	}
	function goScenicDetail(scenic_id){
		var scenicInfo = {
				id :scenic_id
		}
		window.open("/scenic/detail?paramStr="+Base64.encode(JSON.stringify(scenicInfo)));
	}
</script>
</body>
</html>