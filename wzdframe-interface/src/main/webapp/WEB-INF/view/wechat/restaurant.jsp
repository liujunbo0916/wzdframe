<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>餐厅</title>
		<link href="/css/reset.css" rel="stylesheet" />
		<link href="/css/cangti.css" rel="stylesheet"/>
		<script src="/js/phone.js"></script>
	</head>
	<body>
		<div class="container">
			<!--banner-->
			<div class="banner">
				<div class="banner-img">
					<img src="/img/shitang.png"/>
				</div>
				<div class="banner-box">
					<!--left-->
					<div class="list-left">
							<h2>杂味食堂</h2>
							<!--icon-->
							<div class="left-box">
								<div class="icon1 icon">
									<img src="/img/lydt_weizan@2x.png"/>
									<span>420</span>
								</div>
								<div class="icon2 icon">
									<img src="/img/lydt_liuyan@2x.png"/>
									<span>342</span>
								</div>
							</div>
						</div>
					<!--right-->
					<div class="right-box">
						<div class="icon3">
							<img src="/img/weizou_dit.png"/>
						</div>
						<p>地图搜寻</p>
					</div>
				</div>
			</div>
			<!--text-box-->
			<div class="text-box">
				<h3>餐厅简介</h3>
				<p>文艺小清新餐馆，老板娘手艺好，可以自带海鲜交给这里烹饪。</p>
				<p>地址：涠洲岛南湾街132号(海鲜市场西侧)</p>
				<p>电话：07796013557 / 13677792587|</p>
				<p>营业时间：9:00-12:00,14:00-17:00</p>
				<div class="tips-box">
					<p>Tips:</p>
					<p>人均消费￥53</p>
					<p>推荐：海鲜加工 台湾卤肉饭 香辣蟹 花甲 红烧牛肉面</p>
				</div>
			</div>
			<!--餐厅照片-->
			<div class="cant-box">
				<h3>餐厅图片</h3>
				<div class="cant">
					<div class="cant-img">
						<img src="/img/shit_list01.png"/>
					</div>
					<ul class="img-list">
						<li>
							<img src="/img/shit_list02.png"/>
						</li>
						<li>
							<img src="/img/shit_list02.png"/>
						</li>
					</ul>
				</div>
			</div>
			<!--游客评论-->
			<div class="pinl-box">
				<div class="title-box">
					<h3>游客评论</h3>
					<span>></span>
				</div>
				<ul class="pinl-list">
					<li>
						<div class="li-con">
							<!--top-->
							<div class="list-top clearfix">
								<div class="pinl-img">
									<img src="/img/toux.png"/>
								</div>
								<div class="pinl-text">
									<p>吴大大</p>
									<p>2月3日</p>
								</div>
							</div>
							<p class="list-bottom">久违的五彩滩，虽然变化很大，但依然很美。</p>
						</div>
					</li>
					<li>
						<div class="li-con">
							<!--top-->
							<div class="list-top clearfix">
								<div class="pinl-img">
									<img src="/img/toux.png"/>
								</div>
								<div class="pinl-text">
									<p>吴大大</p>
									<p>2月3日</p>
								</div>
							</div>
							<p class="list-bottom">久违的五彩滩，虽然变化很大，但依然很美。</p>
						</div>
						<!--fixed-->
						<div class="pinl-fixed clearfix">
							<div class="input">
								<input type="text" placeholder="我有话要说..."/>
							</div>
							<div class="fixed-img">
								<img src="/img/lydt_weizan@2x.png"/>
								<p>1120</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
	</body>
</html>
