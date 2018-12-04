<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>商品评论</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/duyun/wode-fank.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
		<style type="text/css">
			 ul {
			  padding-left: 0;
			  overflow: hidden;
			 }
			 ul li {
			  float: left;
			  list-style: none;
			  width: 27px;
			  height: 27px;
			  background: url(/img/duyun/comment-star.png)
			 }
			 ul li a {
				  display: block;
				  width: 100%;
				  padding-top: 27px;
				  overflow: hidden;
			 }
			 ul li.light {
			    background-position: 0 -29px;
			 }
			 .add-div{
				position: fixed;
			    left: 0;
			    right: 0;
			    bottom: 0;
			    height: 1.2rem;
			    background: #fff;
			 }
			 .add-div button{
			    width: 100%;
			    background: #ab8a54;
			    height: 100%;
			    color: #fff;
			    display: inline-block;
			 }
			 
		</style>
	</head>
	<body style="background-color: #FFF;">
	   <div>
	   <div style="height:10px;"></div>
	    <div style="margin-bottom: 10px;margin-left: 15px;">
	      <div style="float:left;    line-height: 1.7;"> <span class="font-s18">评分</span></div>
	       <div style="float:left;margin-left:10px;">
		         <ul class="starN">
				  <li class="light"><a href="javascript:;">1</a></li>
				  <li style="margin-left:6px;"><a href="javascript:;">2</a></li>
				  <li style="margin-left:6px;"><a href="javascript:;">3</a></li>
				  <li style="margin-left:6px;"><a href="javascript:;">4</a></li>
				  <li style="margin-left:6px;"><a href="javascript:;">5</a></li>
				 </ul>
			 </div>
			 <div style="clear:both;"></div>
			 
	    </div>
		<div class="textarea">
			<textarea rows="10" id="yjfk" placeholder="意见反馈"></textarea>
			<p class="abs"><span id="alreadyWord">0</span>/<span id="noWriteWord">200</span></p>
		</div>
		<div class="add-div">
			<button id="submiOrder" >提交</button>
		</div>
		</div>
		 <%@ include file="common/commJs.jsp"%>
        <script>
			var num=finalnum = tempnum= 0;
			var lis = document.getElementsByTagName("li");
			//num:传入点亮星星的个数
			//finalnum:最终点亮星星的个数
			//tempnum:一个中间值
			function fnShow(num) {
			 finalnum= num || tempnum;//如果传入的num为0，则finalnum取tempnum的值
			 for (var i = 0; i < lis.length; i++) {
			  lis[i].className = i < finalnum? "light" : "";//点亮星星就是加class为light的样式
			 }
			}
			for (var i = 1; i <= lis.length; i++) {
			 lis[i - 1].index = i;
			 lis[i - 1].onmouseover = function() { //鼠标经过点亮星星。
			  fnShow(this.index);//传入的值为正，就是finalnum
			 }
			 lis[i - 1].onmouseout = function() { //鼠标离开时星星变暗
			  fnShow(0);//传入值为0，finalnum为tempnum,初始为0
			 }
			 lis[i - 1].onclick = function() { //鼠标点击,同时会调用onmouseout,改变tempnum值点亮星星
			  tempnum= this.index;
			 }
			}
			$(function(){
				var submitFlag = false;
				$("#submiOrder").click(function(){
					if(!submitFlag){
						if($("#yjfk").val().length > 200){
							alert("字数受限");
							return;
						}
						submitFlag = true;
						Ajax.request("/wx/order/goodsComment",{"data":{"content":$("#yjfk").val(),
							"star":$(".light").length,"setcomment_id":'${pd.goods_id}',
							"order_id":'${pd.order_id}',
							"comment_type":1
						},
						"success":function(data){
								if(data.code == 200){
									window.location.href='/wx/order/myOrder?currentPage=1&type=6&order_status=6';
								}
					   }});
					}
				});
		    	//监听输入框的值变化改变输入框的外边的字数
				$(function(){
		    		$("#yjfk").bind('input propertychange', function() {
		    			if($("#noWriteWord").text() == 0 && $(this).val().length > 200){
		    				$(this).val($(this).val().substring(0,200));
		    			}else{
		    				$("#alreadyWord").text($(this).val().length);
			    			$("#noWriteWord").text(200-$(this).val().length);
		    			}
		    		});
		    	});
			});
</script>
	</body>
</html>
