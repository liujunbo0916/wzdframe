<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
  .active{
     color: rgb(243, 133, 15)!important;
     
  }
  .login-text{
    cursor: pointer;
  }
  #codeImg {
    position: fixed;
    width: 150px;
    height: 170px;
    top: 300px;
    right: -8px;
    z-index: 10;
}
#codeImg b {
    font-size: 12px;
}
#codeImg img {
    box-shadow: 1px 1px 6px 2px #BFBFBF;
    width: 125px;
    height: 125px;
}
#codeImg p {
    font-size: 12px;
    color: #38BAFC;
    margin-top: 4px;
}
</style>
<%@ include file="header.jsp"%>
<div class="row nav-container">
    <div class="col-md-1"></div>
    <div class="col-md-1"></div>
    <div class="col-md-2 nav-logo" onclick="window.location.href='/'">
      <img alt="" src="/img/duyun/pc/LOGO.png">
    </div>
    <div class="col-md-2 "></div>
    <div class="col-md-6">
        <nav class="nav">
            <a style="color:#44446E" class="nav-link home-0 <c:if test="${pageType eq 'home'}">active</c:if>" href="/index" onclick="changeNav(0);">首页</a>
            <div class="btn-group home-1" onclick="changeNav(1);">
                <a class="nav-link dropdown-toggle <c:if test="${pageType eq 'ticket' || pageType eq 'route'}">active</c:if>" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">都匀服务</a>
                <div class="dropdown-menu service-dropdown ">
                    <a class="dropdown-item service-item" href="javascript:window.open('http://flights.ctrip.com/booking/BJS-KWE-day-1.html','_blank');">机票预订</a>
                    <a class="dropdown-item service-item" href="javascript:window.location.href='/hotel/list';">酒店预订</a>
                    <a class="dropdown-item service-item" href="javascript:window.location.href='/ticket/list';" >门票预订</a>
                    <a class="dropdown-item service-item" href="javascript:window.location.href='/travel/route';">路线预订</a>
                </div>
            </div>
            <div class="btn-group home-2" onclick="changeNav(2);">
                <a class="nav-link dropdown-toggle <c:if test="${pageType eq 'product' || pageType eq 'store' || pageType eq 'scenic'}">active</c:if>" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">都匀特色</a>
                <div class="dropdown-menu feature-dropdown">
                    <a class="dropdown-item feature-item" href="javascript:window.location.href='/product/list';">都匀特产</a>
                    <a class="dropdown-item feature-item" href="javascript:window.location.href='/store/list';">都匀店铺</a>
                    <a class="dropdown-item feature-item" href="javascript:window.location.href='/scenic/list';">都匀景点</a>
                </div>
            </div>
            <div class="btn-group home-3" onclick="changeNav(3);">
                <a class="nav-link dropdown-toggle <c:if test="${pageType eq 'guide' || pageType eq 'content'}">active</c:if>" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">旅游资讯</a>
                <div class="dropdown-menu feature-dropdown">
                    <a class="dropdown-item feature-item" href="javascript:window.location.href='/guide/list';">都匀攻略</a>
                    <a class="dropdown-item feature-item" href="javascript:window.location.href='/content/list';">实时资讯</a>
                </div>
            </div>
            <a style="color:#44446E" class="nav-link home-4" href="#" onclick="changeNav(4);">关于我们</a>
        </nav>
    </div>
</div>
