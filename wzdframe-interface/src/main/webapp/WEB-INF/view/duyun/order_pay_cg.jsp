<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
		<title>支付成功</title>
		<link href="/css/reset.css" rel="stylesheet"/>
		<link href="/css/common.css" rel="stylesheet"/>
		<link href="/css/applySucess.css" rel="stylesheet"/>
		<script src="/js/shipei.js"></script>
	</head>
	<body>
		<!--订单支付成功-->
		<div class="content1">
			<img src="/img/chenggong@2x.png"/>
			<h1>支付成功</h1> 
		</div>
		<!--下一步-->
		<div class="btn">			
			<button onclick="window.location.href='${pd.zurl}'" class="butt1 bgc1 ptb mt1">查看订单</button>
		</div>
			  <%@ include file="common/commJs.jsp"%>
			  <script type="text/javascript">
			    function UrlSearch() 
			    {
			       var name,value; 
			       var str=location.href; //取得整个地址栏
			       var num=str.indexOf("wenhao") 
			       str=str.substr(num+1); //取得所有参数   stringvar.substr(start [, length ]

			       var arr=str.split("jiahao"); //各个参数放到数组里
			       for(var i=0;i < arr.length;i++){ 
			        num=arr[i].indexOf("="); 
			        if(num>0){ 
			         name=arr[i].substring(0,num);
			         value=arr[i].substr(num+1);
			         this[name]=value;
			         } 
			        } 
			    }
			     var Request=new UrlSearch(); 
			     //返回按钮控制 redirectType
			      if(Request.redirectType == 'buyNow'){
			          GoBackBtn.excuteHistory("/wx/product/detail?p_id="+Request.p_id+"&optType="+Request.optType+"&pageType=paySuccess");
			      }else if(Request.redirectType == 'shopCart'){
			    	  GoBackBtn.excuteHistory("/wx/cart/shopCart?pageType=paySuccess&optType="+Request.optType);
			      }else if(Request.redirectType == 'orderList'){
			    	  GoBackBtn.excuteHistory("${pd.zurl}");
			      }else if(Request.redirectType == 'ticket'){
			    	  GoBackBtn.excuteHistory("/wx/ticket/index?redirectType=detail&t_id="+Request.t_id); 	
			      }
			  </script>
	</body>
</html>
