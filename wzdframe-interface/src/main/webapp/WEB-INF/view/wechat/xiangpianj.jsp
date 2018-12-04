<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta name="format-detection" content="telephone=no" >
		<meta name="apple-mobile-web-app-capable" content="yes" >
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>老相片集</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/xiangpianj.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
		<link rel="stylesheet" href="/js/appSlideCard/html/css/slide.css" />
		<link rel="stylesheet" href="/js/appSlideCard/html/css/animate.css"/>
		<style type="text/css">
		   .box-con {
			    position: fixed;
			    left: 0;
			    right: 0;
			    top: 0;
			    bottom: 0;
			    display: none;
			}
		</style>
	</head>
	<body>
	<div>
		<div class="container">
			<ul id="imageGrall">
				<c:forEach items="${albumModel}" var="item">
					<li>
						<img style="width: 246px;height: 298px;" src="${SETTINGPD.IMAGEPATH}${item.resource_path}"/>
					</li>
				</c:forEach>
			</ul>
		</div>
		
	<div class="box-con" >	
		  <div id="pull-up" style="position: absolute;left: 0;  right: 0;  top: 0;  bottom: 0;  background: rgba(0, 0, 0, 1);"></div>
			<div class="slider-nav" style="    margin-top: 330px;" id="sliderNav">
				<ul id="element_after">
				<c:set var="arrayvalue" value="zoomIn,zoomInDown,shake,fadeInLeft,rotateIn,rotateInUpLeft,rotateInUpRight,flipInX"></c:set>
				<c:set var="animateds" value="${fn:split(arrayvalue,',')}"/> 
				<c:forEach items="${albumModel}" var="item" varStatus="status">
				    <li>
				       <img style="display: inline;" class="animated <c:out value="${animateds[status.index % fn:length(animateds)]}" />" src="${SETTINGPD.IMAGEPATH}${item.resource_path}" alt=""/>
			        </li>
			      </c:forEach>
				</ul>
			<span class="up-slide"></span>
		  </div>
	</div>
	</div>
	</body>
	<script src="/js/zepto.min.js"></script> 
	<script src="/js/appSlideCard/html/js/slide.js"></script>
	<script type="text/javascript">
	   //扩展的prevAll方法
	  function prevAll(selector){
		var childs = $(selector).parent().children();
		for(var i = 0 ; i < childs.length ; i++){
			if(selector == childs[i]){
				return i;
			}
		}
		return 0;
	  }
	   var silderYuanAry; //保存原始相册的数组
	  function  changeElmPosition(elm){
		 var silderChilds = $("#element_after").children();
		 var destChilds = $(elm).parent().children();
		 var clickIndex = prevAll(elm);
		 var lastElm = []; // 保存顺序变过之后的相册数组
		 for(var i = clickIndex ; i < silderYuanAry.length ; i++){
			 lastElm.push(silderYuanAry[i]);
		 }
		 for(var i = 0 ; i < clickIndex ; i++){
			 lastElm.push(silderYuanAry[i]);
		 }
		 $("#element_after").empty();
		 for(var j = 0 ;j < lastElm.length ; j++){
			 $("#element_after").append(lastElm[j]);
		 }
	   }
		$(".box-con").hide();
		var slider 
		$(function() {
			silderYuanAry = $("#element_after").children();
			$("#imageGrall").children().click(function(){
				//交换元素位置  当前点击的元素以及下面的所有元素都放在第一个元素之前
				changeElmPosition(this);
				slider = $('#sliderNav').slider();
				/* slider.goIndex(prevAll(this)); */
				$(".box-con").show();
			});
			$("#pull-up").click(function(){
				$(".box-con").hide();
			});
		});
	</script>
</html>
