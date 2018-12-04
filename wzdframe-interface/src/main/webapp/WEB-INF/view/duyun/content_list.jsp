<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>旅游动态</title>
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<!-- Sets initial viewport load and disables zooming -->
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="email=no" name="format-detection" />
<link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
<link rel="stylesheet" href="/css/duyun/lydt.css">
</head>
<style>
.follow-nums {
	padding-left: 20px;
	background: url("/img/duyun/icons/follow.png") no-repeat;
	background-size: 14px auto;
	background-position: 0 center;
}

.reply-nums {
	margin-left: 20px;
	padding-left: 20px;
	background: url("/img/duyun/icons/reply.png") no-repeat;
	background-size: 14px auto;
	background-position: 0 center;
}
.promotions-type {
  font-family: PingFang-SC-Regular;
  font-size: 12px;
  color: #666666;
  margin-top: 10px;
}

.img-wraps {
  position: relative;
  flex-grow: 1;
  overflow: hidden;
  height: 74px;
}
.img-wraps > span {
  position: absolute;
  top: 0;
  left: 0;
  background-color: #FC9313;
  padding: 0px 5px;
  font-size: 12px;
  height: 18px;
  line-height: 18px;
}
  .content > .table-view:first-child{
         margin-top: 0px;
      }
</style>


<body>
	<div class="content">
		<!--旅游动态顶部图片-->
		<ul class="table-view" id="contentlist">
			<li class="top-case"><img class="news-img"
				src="" /> <span></span></li>
			<!--旅游动态  文章单图模式-->
		<!-- 	<li class="travel-follow">
				<div class="follow-item">
					<div class="content-left">
						<div class="news-title">2017全国独竹漂比赛将在贵州都匀开赛</div>
						<div class="follow-operations">
							<span class="follow-num">420</span> <span class="reply-num">342</span>
						</div>
					</div>
					<div class="content-right">
						<img src="/img/duyun/lydt/2.jpg" alt="" />
					</div>
				</div>
			</li> -->
			<!--文章新闻3图模式-->
			<!-- <li class="travel-promotion">
				<div class="promotion-item">
					<div class="promotion-title">“大美黔菜”展示品鉴活动在都匀举行</div>
					<div class="promotion-img">
						<div class="img-wrap">
							<img src="/img/duyun/lydt/3.jpg" alt="" />
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/3.jpg" alt="" />
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/3.jpg" alt="" />
						</div>
					</div>
					<div class="follow-operations" style="margin-top: 10px">
						<span class="follow-nums">420</span> <span class="reply-nums">342</span>
					</div>
				</div>
			</li> -->
			<!--跟团游推广 3图模式-->
		<!-- 	<li class="travel-promotion">
				<div class="promotion-item">
					<div class="promotion-title">[门票] 荔波小七孔（门票+观光车）+卧龙谷漂游...</div>
					<div class="promotion-img">
						<div class="img-wrap">
							<img src="/img/duyun/lydt/4.jpg" alt="" /> <span>跟团游</span>
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/5.jpg" alt="" />
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/6.jpg" alt="" />
						</div>
					</div>
					<div class="promotion-type">旅游推广</div>
				</div>
			</li> -->
			<!--跟团游推广单图模式-->
			<!-- <li class="travel-follow">
				<div class="follow-item">
					<div class="content-left">
						<div class="news-title">[门票] 荔波小七孔（门票+观光车）+卧龙...</div>
						<div class="promotions-type">旅游推广</div>
					</div>
					<div class="content-right img-wraps" style="margin-right: 10px">
							<img height="70px" width="94px" src="/img/duyun/lydt/2.jpg" alt="" /><span>跟团游</span>
					</div>
				</div>
			</li> -->
			<!--普通推广 3图模式-->
			<!-- <li class="travel-promotion">
				<div class="promotion-item">
					<div class="promotion-title">[门票] 茂兰自然保护区</div>
					<div class="promotion-img">
						<div class="img-wrap">
							<img src="/img/duyun/lydt/7.jpg" alt="" />
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/8.jpg" alt="" />
						</div>
						<div class="img-wrap">
							<img src="/img/duyun/lydt/9.jpg" alt="" />
						</div>
					</div>
					<div class="promotion-type">旅游推广</div>
				</div>
			</li> -->
			<!--普通推广单图模式-->
			<!-- <li class="travel-follow">
				<div class="follow-item">
					<div class="content-left">
						<div class="news-title">[门票] 荔波小七孔（门票+观光车）+卧龙...</div>
						<div class="promotions-type">旅游推广</div>
					</div>
					<div class="content-right" style="margin-right: 10px">
							<img height="70px" width="94px" src="/img/duyun/lydt/2.jpg" alt="" />
					</div>
				</div>
			</li> -->

		</ul>
		<div class="load-more">
			<button class="btn btn-block" id="loadMoreBtn" onclick="loadMore()">加载更多</button>
		</div>
	</div>
	<!--设定预加载效果-->
	<div class="spinner">
		<div class="loading">
			<img src="/img/duyun/dstc/loading.gif" alt="" />
		</div>
	</div>
	<script src="/vendors/ratchet/js/ratchet.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script src="/js/RequestDataForPage.js"></script>
	<script type="text/javascript">
		 var showDetailInfo = function() {
			var toggleBtn = document.querySelector('.btn-wrap img');
			var proContent = document.querySelector('.pro-content');
			if (toggleBtn) {
				if (proContent.classList.contains('hidden')) {
					proContent.classList.remove('hidden');
					toggleBtn.setAttribute('src',
							'/img/duyun/icons/arrow_up.png');
				} else {
					proContent.classList.add('hidden');
					toggleBtn.setAttribute('src',
							'/img/duyun/icons/arrow_down.png');
				}
			}
		} 
		var loadingPanel = document.querySelector('.spinner');
		$(function() {
			  loadMore(); 
		});
		var dataParam={
				CTYPE:'${pd.CTYPE}',
				CATEGORY_CODE:'${pd.CATEGORY_CODE}'
		}
		function loadMore() {
			loadingPanel.style.display = 'flex';
			responseData.sendRequest("/wx/content/doList", dataParam, callBack);
		}
		//自定义渲染函数
		function callBack(data) {
			var dataAry = [];
			var prefixImg = data.prefixImg;
			var data = data.resultPd;
			var html = '';
			for (var i = 0; i < data.length; i++) {
				/* if(data[i].TITLE.length > 18){
					data[i].TITLE=data[i].TITLE.substring(0,17)+"...";
				} */
				 if (i == 0) {
					html += '<li class="top-case" onclick="goDetailPage('
							+ data[i].CONTENT_ID
							+ ')"><img class="news-img" src="'+prefixImg+data[i].T_IMG+'" /> <span>'
							+ data[i].TITLE + '</span></li>';
				} else {
					if (data[i].CTYPE == 0 && data[i].SUBJECT_CODE != 1
							&& data[i].SUBJECT_CODE != 2) {
						if(data[i].MODEL_TYPE==0 || data[i].MODEL_TYPE==''){
							html += '<li class="travel-follow" onclick="goDetailPage('
								+ data[i].CONTENT_ID
								+ ')"><div class="follow-item"><div class="content-left">'
								+ '<div class="news-title">'
								+ data[i].TITLE
								+ '</div>'
								+ '<div class="follow-operations">'
								+ '<span class="follow-num">'
								+ data[i].thumbsups
								+ '</span> <span class="reply-num">'
								+ data[i].comments
								+ '</span>'
								+ '</div></div><div class="content-right"><img src="'+prefixImg+data[i].T_IMG+'" alt="" /></div></div></li>';
						}else if(data[i].MODEL_TYPE == 1
								&& data[i].albums.length > 0){
							html +='<li class="travel-promotion" onclick="goDetailPage('
								+ data[i].CONTENT_ID
								+ ')"><div class="promotion-item"><div class="promotion-title">'+data[i].TITLE+'</div><div class="promotion-img">';
							for (var j = 0; j < data[i].albums.length; j++) {
								html += '<div class="img-wrap"><img src="'+prefixImg+data[i].albums[j].original_img+'" alt="" /></div>';
							}
							html += '</div><div class="follow-operations" style="margin-top: 10px"><span class="follow-nums">'
								+ data[i].thumbsups
								+ '</span> <span class="reply-nums">'
								+ data[i].comments
								+ '</span></div></div></li>';
						}
					} else if (data[i].CTYPE == 1 && data[i].SUBJECT_CODE == 1) {
						if (data[i].MODEL_TYPE == 1
								&& data[i].albums.length > 0) {
						html += '<li class="travel-promotion" onclick="doGroupTourDetail(1,'
								+ data[i].SUBJECT_ID
								+ ')"><div class="promotion-item">'
								+ '<div class="promotion-title" style="color:#FC9313"><span style="color:#FC9313">[跟团]</span> '
								+ data[i].TITLE
								+ '</div>'
								+ '<div class="promotion-img">';
							for (var j = 0; j < data[i].albums.length; j++) {
								if (j == 0) {
									html += '<div class="img-wrap"><img src="'+prefixImg+data[i].albums[j].original_img+'" alt="" /><span>跟团游</span></div>';
								} else {
									html += '<div class="img-wrap"><img src="'+prefixImg+data[i].albums[j].original_img+'" alt="" /></div>';
								}
							}
							html += '</div><div class="promotion-type">旅游推广</div></div></li>';
						} else {
							html += '<li class="travel-follow" onclick="doGroupTourDetail(1,'
								+ data[i].SUBJECT_ID
								+ ')"><div class="follow-item"><div class="content-left">'
								+ '<div class="news-title"><span style="color:#FC9313">[跟团]</span>'
								+ data[i].TITLE
								+ '</div><div class="promotions-type">旅游推广</div></div>'
								+ '<div class="content-right img-wraps">'
								+ '<img   src="'+prefixImg+data[i].T_IMG+'" alt="" /><span>跟团游</span>'
								+ '</div></div></li>';
						}
					} else if (data[i].CTYPE == 1 && data[i].SUBJECT_CODE == 2) {
						if (data[i].MODEL_TYPE == 1
								&& data[i].albums.length > 0) {
							html += '<li class="travel-promotion" onclick="doGroupTourDetail(2,'
								+ data[i].SUBJECT_ID
								+ ')"><div class="promotion-item">'
								+ '<div class="promotion-title"><span style="color:#FC9313">[门票]</span>'
								+ data[i].TITLE
								+ '</div>'
								+ '<div class="promotion-img">';
							for (var j = 0; j < data[i].albums.length; j++) {
								if (j == 0) {
									html += '<div class="img-wrap"><img src="'+prefixImg+data[i].albums[j].original_img+'" alt="" /></div>';
								} else {
									html += '<div class="img-wrap"><img src="'+prefixImg+data[i].albums[j].original_img+'" alt="" /></div>';
								}
							}
							html += '</div><div class="promotion-type">旅游推广</div></div></li>';
						} else {
							html += '<li class="travel-follow" onclick="doGroupTourDetail(2,'
								+ data[i].SUBJECT_ID
								+ ')"><div class="follow-item"><div class="content-left">'
								+ '<div class="news-title"><span style="color:#FC9313">[门票]</span> '
								+ data[i].TITLE
								+ '</div><div class="promotions-type">旅游推广</div></div>'
								+ '<div class="content-right" >'
								+ '<img  src="'+prefixImg+data[i].T_IMG+'" alt="" />'
								+ '</div></div></li>';
						}
					}
				}
			}
			$("#contentlist").empty().append(html);
		}

		function goDetailPage(contentId) {
			window.location.href = '/wx/content/dodetail?CONTENT_ID='+ contentId+"&CATEGORY_CODE="+'${pd.CATEGORY_CODE}';
		}
	function doGroupTourDetail(type,groupId){
		if(type==1){//跟团游
			window.location.href='/wx/grouptour/index?resultType=detail&redirectType=content&grouptour_id='+groupId;
		}else if(type==2){//景点门票
			window.location.href='/wx/ticket/index?redirectType=detail&pageType=content&t_id='+groupId;
		}
	}
	GoBackBtn.excuteHistory("close");
	</script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>