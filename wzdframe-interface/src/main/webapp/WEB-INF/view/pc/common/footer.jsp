<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
 <!-- <link rel="stylesheet" href="/css/duyun/pc/foot.css" type="text/css"> -->
 <style type="text/css">
 .duyun-body-footer {
    width: 100%;
    height: 20%;
    background: #828282;
    line-height: 1.6em;
    overflow: hidden;
}
.duyun-body-footer p:nth-child(1) {
    margin-top: 32px;
}
.duyun-body-footer p {
    font-size: 14px;
    color: #E4E4E4;
    text-align: center;
}
.duyun-body-footer a {
    cursor: pointer;
    text-decoration: none;
    color: inherit;
}
 </style>
</head>
<body>
<!-- <div class="duyun-body-footer" style="">
    <div class="duyun-footer-item row">
        <div class="col-md-1 col"></div>
        <div class="col-md-7 col">
            <div class="duyun-footer-title">
                联系我们
            </div>
            <div class="duyun-footer-content">
                <div class="duyun-item">
                    <img src="/img/duyun/pc/kefu.png" class="duyun-item-img" alt=""/>
                    <span class="duyun-item-text">客服时间：</span>
                    <span class="duyun-item-text">周一～周日（09:00~21:00)</span>
                </div>
                <div class="duyun-item">
                    <img src="/img/duyun/pc/dianhua.png" class="duyun-item-img" alt=""/>
                    <span class="duyun-item-text">客服热线：</span>
                    <span class="duyun-item-text">400-720-9967</span>
                </div>
                <div class="duyun-item">
                    <img src="/img/duyun/pc/youxiang.png" class="duyun-item-img" alt=""/>
                    <span class="duyun-item-text">客服邮箱：</span>
                    <span class="duyun-item-text">kf@duyunglobal.com</span>
                </div>
            </div>
        </div>
        <div class="col-md-3 col">
            <img src="/img/duyun/pc/home/qhyscercode.jpg" class="duyun-scanner-img" alt=""/>
            <p class="duyun-item-one">都匀旅游</p>
            <p class="duyun-item-two">服务公众号</p>
        </div>
        <div class="col-md-1 col"></div>
    </div>
</div> -->
<div class="duyun-body-footer">
        <p>贵州梦昀影视文化创意园投资开放有限公司发布</p>
        <p>赣ICP备11008700号-4号 版权所有：贵州梦昀影视文化创意园投资开放有限公司</p>
        <p>运营、技术支持：安盛信达科技股份公司  电话：0755-25917435</p>
        <p >
        <a href="/companyInfo?id=2">企业简介</a> &nbsp;|&nbsp;
        <a href="/companyInfo?id=1">企业文化</a> &nbsp;|&nbsp;
        <a href="/companyInfo?id=3">联系我们</a>         
        </p>
        <p>地址：贵州省黔南布依族苗族自治州经济开发区客运东站</p>
		<p >友情链接：<span class="frendLink"></span></p>
    </div>
</body>
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/Ajax.js"></script>
<script type="text/javascript">
   Ajax.request("/comm/frendsLink",{"data":{},"success":function(data){
	   if(data.code == 200){
		   $(".frendLink").empty();
		   for(var i = 0 ; i < data.data.length ; i++){
			   if(i == data.data.length - 1){
				   $(".frendLink").append('<a  href="javascript:window.open('+"'"+''+data.data[i].link_url+''+"'"+');">'+data.data[i].link_title+'</a>');
			   }else{
				   $(".frendLink").append('<a href="javascript:window.open('+"'"+''+data.data[i].link_url+''+"'"+');">'+data.data[i].link_title+'</a>&nbsp;|&nbsp;');
			   }
		   }
	   }
   }});
</script>
</html>