
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
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
<div id="codeImg">
	    <b style="cursor: pointer;" onclick="javascript:this.parentNode.style.display='none';">关闭</b>
		<img border="0" src="/img/duyun/pc/home/qhyscercode.jpg" width="200px" height="200px">
		<p>微信扫一扫，关注我们！</p>
</div>