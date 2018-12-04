	<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>	
<html>
	<head>
		<meta charset="UTF-8">
		</head>
		<body>
		<nav>
			<ul>
				<li codeType="sysIndex">
					<a>
						<i class="<c:choose><c:when test="${nav_type eq 'index'}">select_icon_shouy</c:when> <c:otherwise>icon_shouy</c:otherwise> </c:choose> icon"></i>
						<p>首页</p>
					</a>
				</li>
				<li codeType="quanzi">
					<a>
						<i class="<c:choose><c:when test="${nav_type eq 'quanzi'}">select_icon_quanz</c:when> <c:otherwise>icon_quanz</c:otherwise> </c:choose> icon"></i>
						<p>圈子</p>
					</a>
				</li>
				<li codeType="shoppingCart">
					<a>
						<i class="<c:choose><c:when test="${nav_type eq 'gouwuche'}">select_icon_gouwc</c:when> <c:otherwise>icon_gouwc</c:otherwise> </c:choose>  icon"></i>
						<p>购物车</p>
					</a>
				</li>
				<li codeType="userCenter" onclick="window.location.href='/wx/mall/login'">
					<a>
						<i class=" <c:choose><c:when test="${nav_type eq 'usercenter'}">select_icon_wod</c:when> <c:otherwise>icon_wod</c:otherwise> </c:choose> icon"></i>
						<p>我的</p>
					</a>
				</li>
			</ul>
		</nav>
		</body>
		<script type="text/javascript">
			$("nav ul li").click(function(){
		    	//样式改变
		    	$(this).siblings().each(function(){
		    		var classStr = $(this).children().eq(0).children().eq(0).attr("class").replaceAll("select_","");
		    		$(this).children().eq(0).children().eq(0).attr("class",classStr);
		    	});
		    	var thisClass = $(this).children().eq(0).children().eq(0).attr("class");
		    	if(thisClass.indexOf("select_") == -1){
		    		$(this).children().eq(0).children().eq(0).attr("class","select_"+thisClass);
		    	}
		    	//导航栏跳转
		    	var codeType = $(this).attr("codeType");
		    	var url = "/wx/mall/home";
		    	switch(codeType){
			        case "sysIndex":url="/wx/mall/home";break;
			        case "quanzi":url="/wx/circle/index?currentPage=1";break;
			        case "shoppingCart":url="/wx/cart/shopCart";break;
			        case "userCenter":url='/wx/user/userCenter';break;
			        default:"/wx/mall/home";break;
		        }
		    	window.location.href=url;
		    });
		</script>
		</html>