<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>旅游动态</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/dongtai.css" rel="stylesheet" />
<link href="/css/iscroll.css" rel="stylesheet">
 <script src="/js/shipei.js"></script> 
<style type="text/css">
.list-box ul li {
	padding: .2rem .3rem;
	border-bottom: 1px solid #e0e0e0;
	overflow: hidden;
}

.left-box span {
	line-height: 1.5;
}

.floatTitle {
	position: absolute;
	bottom: 0px;
	background-color: rgba(0, 0, 0, 0.5);
	font-size: .3rem;
	height: 1.16rem;
	font-weight: normal;
	padding-top: .18rem;
	line-height: 1.4;
}
</style>
</head>
<body class="body-scroll">
	<%-- <jsp:include page="common/extension-title.jsp"></jsp:include> --%>
	<div id="wrapper" class="container" style="top: 0px !important;">
		<div class="wrapper-next" style="width: 100%;">
			<div id="pullDown">
				<center>
					<span class="pullDownLabel">下拉刷新...</span>
				</center>
			</div>
			<!--banner-->
			<div class="banner"
				style='position: relative; overflow: hide; height: 3.46rem;'>
				<c:forEach items="${dataModel.tops}" var="item">
					<c:if test="${not empty item.C_IMG}">
						<c:set value="${item.C_IMG}" var="c_img"></c:set>
					</c:if>
					<c:if test="${empty item.C_IMG}">
						<c:set value="${item.T_IMG}" var="c_img"></c:set>
					</c:if>
					<img onclick="goDetailPage('${item.CONTENT_ID}',event);"
						style="height: 3.46rem; width: 100%"
						onerror="javascript:this.src='/img/jzsb-wzsy.png';"
						src="${SETTINGPD.IMAGEPATH}${c_img}" />
					<span class="floatTitle"  ><p
							style="color: #fff;font-size: .33rem; margin-left: .3rem; margin-right: .3rem;">
							<c:if test="${fn:length(item.TITLE)> 40}">
				             ${fn:substring(item.TITLE,0,39)}${'...'}
				           </c:if>
							<c:if test="${fn:length(item.TITLE) <= 40}">
				             ${item.TITLE}
				           </c:if>
						</p></span>
				</c:forEach>
			</div>
			<!--list-->
			<div class="list-box">
				<ul id="appendText">
					<c:forEach items="${dataModel.news}" var="item">
						<!-- 单图模式 -->
						<c:if test="${item.MODEL_TYPE == 0 }">
						<li onclick="goDetailPage('${item.CONTENT_ID}',event);">
							<!--left-->
							<div class="list-left">
								<div style="height: .84rem; overflow: hide;">
									<h1
										style="color: #444444;  font-size: .33rem;  font-weight: normal;">
										<c:if test="${fn:length(item.TITLE) > 22}">
									       ${fn:substring(item.TITLE,0,21)}${'...'}
									   </c:if>
										<c:if test="${fn:length(item.TITLE) <= 22}">
									       ${item.TITLE}
									   </c:if>
									</h1>
								</div>
								<!--icon-->
								<div class="left-box">
								 	<div class="icon1 icon nogo"
										onclick="dianzan(this,'${item.CONTENT_ID}',event);">

										<c:if test='${item.thumb eq 1}'>
											<img data-code="${item.thumb}" src="/img/lydt_yizan@2x.png" />
											<span style="color: #ffb200;">${item.thumbsup}</span>
										</c:if>
										<c:if test='${item.thumb eq 0}'>
											<img data-code="${item.thumb}" src="/img/lydt_weizan@2x.png" />
											<span>${item.thumbsup}</span>
										</c:if>

									</div> 
									<div class="icon2 icon">
										<img src="/img/lydt_liuyan@2x.png" /> <span>${item.comments}</span>
									</div>
								</div>
							</div> <!--right-->
							<div class="list-right">
								<img style="width: 2.34rem; height: 1.4rem;"
									onerror="javascript:this.src='/img/jzsb-wzsy.png';"
									src="${SETTINGPD.IMAGEPATH}${item.T_IMG}" />
							</div>
						</li>
						</c:if>
						<!-- 多图模式   3张-->
						<c:if test="${item.MODEL_TYPE == 1}">
						<li onclick="goDetailPage('${item.CONTENT_ID}',event);">
							<!--left-->
							<div>
								<div style="height: .84rem; overflow: hide;">
									<h1
										style="color: #444444;  font-size: .33rem;  font-weight: normal;">
										<c:if test="${fn:length(item.TITLE) > 20}">
									       ${fn:substring(item.TITLE,0,19)}${'...'}
									   </c:if>
										<c:if test="${fn:length(item.TITLE) <= 20}">
									       ${item.TITLE}
									   </c:if>
									</h1>
								</div>
								 <!--right-->
							<div class="" style="display:inline">
									<c:forEach items="${item.albums}" var="item">
									<img style="width: 2.05rem; height: 1.4rem;display:inline"
									onerror="javascript:this.src='/img/jzsb-wzsy.png';"
									src="${SETTINGPD.IMAGEPATH}${item.original_img}" />
									</c:forEach>
							</div>
							<!--icon-->
								<div class="">
								 	<div class="icon1 icon nogo"
										onclick="dianzan(this,'${item.CONTENT_ID}',event);">

										<c:if test='${item.thumb eq 1}'>
											<img data-code="${item.thumb}" src="/img/lydt_yizan@2x.png" />
											<span style="color: #ffb200;">${item.thumbsup}</span>
										</c:if>
										<c:if test='${item.thumb eq 0}'>
											<img data-code="${item.thumb}" src="/img/lydt_weizan@2x.png" />
											<span>${item.thumbsup}</span>
										</c:if>

									</div> 
									<div class="icon2 icon">
										<img src="/img/lydt_liuyan@2x.png" /> <span>${item.comments}</span>
									</div>
								</div>
							</div>
						</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div id="pullUp">
				<center>
					<span class="pullUpLabel">加载更多...</span>
				</center>
			</div>
		</div>
	</div>
</body>
<%@ include file="common/commJs.jsp"%>
<script src="/js/iscroll/iscroll.js"></script>
<script src="/js/iscroll/easaaScroll.js"></script>
<script type="text/javascript">
	var seachData = {
		currentPage : 1,
		resultLength : 15,
		exclude : '${dataModel.exclude}'
	}
	seachData.resultLength = '${fn:length(dataModel.news)}';
	$("#pullUp").hide();
	$("#pullDown").hide();
	easaaScroll(pullUpAction, pullDownAction, seachData.resultLength);
	function pullUpAction() {
		if (seachData.resultLength < 15) {
			$(".pullUpLabel").text("无更多数据");
		} else {
			seachData.currentPage++;
			Ajax.request("/wx/news/listAjax", {
				"data" : seachData,
				"success" : function(data) {
					if (data.code == 200) {
						seachData.resultLength = data.data.length;
						if (seachData.resultLength == 15) {
							seachData.currentPage++;
						}
						var append = appendHtml(data.data);
						$("#appendText").append(append);
						myScroll.refresh();
					}
				}
			});
		}
		setTimeout(function() {
			$("#pullUp").hide();
			$("#pullDown").hide();
		}, 1000);
		myScroll.refresh();
	}
	function pullDownAction() {
		if (seachData.currentPage != 1) { //如果当前页是第一页 没有必要触发不必要的请求
			seachData.currentPage = 1;
			Ajax.request("/wx/news/listAjax", {
				"data" : seachData,
				"success" : function(data) {
					if (data.code == 200) {
						seachData.resultLength = data.data.length;
						var append = appendHtml(data.data);
						$("#appendText").html(append);
						myScroll.refresh();
					}
				}
			});
		}
		setTimeout(function() {
			$("#pullUp").hide();
			$("#pullDown").hide();
		}, 1000);
		myScroll.refresh();
	}
	function appendHtml(data) {
		var htmlAry = [];
		for (var i = 0; i < data.length; i++) {
			htmlAry
					.push('<li onclick="window.location.href='
							+ "'"
							+ '/wx/news/detail?CONTENT_ID='
							+ data[i].CONTENT_ID
							+ ''
							+ "'"
							+ '"><div class="list-left"><div style="height: 84px;overflow: hide;"><p>'
							+ data[i].TITLE
							+ '</p></div><div class="left-box">');
			htmlAry.push('<div class="icon1 icon"  onclick="dianzan(this,'
					+ data[i].CONTENT_ID + ')">');
			if (data[i].thumb == 1) {
				htmlAry.push('<img src="/img/lydt_yizan@2x.png"/>');
			} else {
				htmlAry.push('<img src="/img/lydt_weizan@2x.png"/>');
			}
			htmlAry
					.push('<span>'
							+ data[i].thumbsup
							+ '</span></div><div class="icon2 icon"><img src="/img/lydt_liuyan@2x.png"/><span>'
							+ data[i].comments + '</span></div></div></div>');
			htmlAry
					.push('<div class="list-right"><img  onerror="javascript:this.src='+"'"+'/img/jzsb-wzsy.png'+"'"+';" src="${SETTINGPD.IMAGEPATH}'+data[i].T_IMG+'"/></div></li>');
		}
		return htmlAry.join("");
	}
/* 	function dianzan(thisObj, CONTENTID, event) {
		event.stopPropagation();
		Ajax.request("/wx/news/thumbsup", {
			"data" : {
				"CONTENT_ID" : CONTENTID
			},
			"success" : function(data) {
				if (data.code == 200) {
					$(thisObj).children().eq(1).text(
							parseInt($(thisObj).children().eq(1).text()) + 1);
					$(thisObj).children().eq(1).css("color", "#ffb200");
					$(thisObj).children().eq(0).attr("src",
							"/img/lydt_yizan@2x.png");
				}
			}
		});
	} */
	function goDetailPage(contentId, e) {
			window.location.href = '/wx/news/detail?CONTENT_ID=' + contentId;
	}
</script>
</html>
