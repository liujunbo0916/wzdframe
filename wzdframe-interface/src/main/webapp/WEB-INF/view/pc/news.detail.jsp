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
    <link rel="stylesheet" href="/css/duyun/pc/advisory.details.css" type="text/css">
       <meta name="keywords" content=" ${dataModel.TITLE}">
    <meta name="description" content=" ${dataModel.TITLE}">
    <title> ${dataModel.TITLE}</title>
    <style type="text/css">
      .advisory-left img{
        width:730px;
      }
      .advisory-content img{
        width: 100%;
      } 
    </style>
    
    
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>
<div class="row advisory-detail">
    <div class="col-md-9 col advisory-left">
        <div class="advisory-header">
            <p class="header-title">
                ${dataModel.TITLE}
            </p>
            <p class="header-date">
                 ${dataModel.PUTTIME}
            </p>
        </div>
        <div class="advisory-content">
            ${dataModel.CONTENT}
        </div>
    </div>
    <div class="col-md-3 col advisory-right" id="hotContent">
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/home.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript" src="/js/BASE64.js"></script>
</body>
<script type="text/javascript">
var fiexdImg = '${SETTINGPD.IMAGEPATH}';
    $(function(){
    	contentHot();
    });
    function contentHot(){
    	Ajax.request("/logic/content/hot",{"data":{"limit":6,"CATEGORY_CODE":'${dataModel.CATEGORY_CODE}'},"success":function(data){
    		if(data.code == 200){
    			var data = data.data;
    			$("#hotContent").empty();
    			var htmlAry = [];
    			htmlAry.push('<div class="advisory-hot">相关资讯</div>');
    			for(var i = 0 ; i < data.length ; i++){
    				htmlAry.push('<div style="cursor:pointer;" class="row hot-advisory-item" onclick="javascript:window.open('+"'"+'/content/detail?CONTENT_ID='+data[i].CONTENT_ID+''+"'"+');"><div class="col-md-3 col hot-advisory-item-left">');
    				htmlAry.push('<img src="'+fiexdImg+data[i].T_IMG+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';" class="news-small-img" alt="">');
    				htmlAry.push('</div><div class="col-md-9 col hot-advisory-item-right">');
    				htmlAry.push('<p class="news-right-one">'+data[i].TITLE+'</p><p class="news-right-two">'+data[i].PUTTIME+'</p></div></div>');
    			}
    			$("#hotContent").append(htmlAry.join(''));
    		}
    	}});
    }
</script>



</html>