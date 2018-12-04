<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <form class="form-horizontal m-t"  id="commentForm">
        <div class="row">
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>ftp服务器设置（文件服务器）</h5>
                    </div>
                    <div class="ibox-content">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">ftp服务器地址：</label>
                                <div class="col-sm-7">
                                    <input id="ftp_ip" name="ftp_ip"  value="${config.ftp_ip}"  type="text" class="form-control ftp"  >
                                </div>
                            </div>
                            
                             <div class="form-group">
                                <label class="col-sm-3 control-label">端口号：</label>
                                <div class="col-sm-7">
                                    <input id="ftp_passowrd" type="text"  value="${config.port}" class="form-control ftp" name="port">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户名：</label>
                                <div class="col-sm-7">
                                    <input id="ftp_username" type="text" value="${config.ftp_username}"  class="form-control ftp" name="ftp_username" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-7">
                                    <input id="ftp_passowrd" type="text"  value="${config.ftp_passowrd}" class="form-control ftp" name="ftp_passowrd">
                                </div>
                            </div>
                            <div class="form-group">
                                  <div class="col-sm-4 col-sm-offset-3">
                                      <button class="btn btn-warning" onclick="sysEdit('ftp');" type="button"><i class="fa fa-paste"></i>编辑</button>
                                      <button class="btn btn-primary"  onclick="sysSave('ftp');"  type="button"><i class="fa fa-check"></i>保存</button>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>其它配置设置</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="form-group">
                                <label class="col-sm-3 control-label">系统图片访问前缀：</label>
                                <div class="col-sm-7">
                                    <input id="imageShowPath" type="text" name="imageShowPath"  value="${config.imageShowPath}"  class="form-control other" >
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-3 control-label">系统名称：</label>
                                <div class="col-sm-7">
                                    <input id="system_name" type="text" name="system_name"  value="${config.system_name}"  class="form-control other" >
                                </div>
                            </div>
                            
                                <div class="form-group">
                                <label class="col-sm-3 control-label">远程调用地址设置（web后台对设备操作的一系列接口）：</label>
                                <div class="col-sm-7">
                                    <input id="rmi_name" type="text" name="rmi_name"  value="${config.rmi_name}"  class="form-control other" >
                                </div>
                            </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label">预留设置：</label>
                                <div class="col-sm-7">
                                    <input id="" type="text" name=""  value=""  class="form-control other" >
                                </div>
                            </div>
                                <div class="form-group">	
                                   <div class="col-sm-4 col-sm-offset-3">
                                      <button class="btn btn-warning" onclick="sysEdit('other');" type="button"><i class="fa fa-paste"></i>编辑</button>
                                      <button class="btn btn-primary"  onclick="sysSave('other');"  type="button"><i class="fa fa-check"></i>保存</button>
                                </div>
                            </div>
                         <!-- 内容 -->
                    </div>
                </div>
            </div>
            
            
            
              <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>支付宝支付参数设置</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="form-group">
                                <label class="col-sm-3 control-label">支付宝-PARTNER：</label>
                                <div class="col-sm-7">
                                    <input id="Ali_PARTNER" type="text" name="Ali_PARTNER"  value="${config.Ali_PARTNER}"  class="form-control ali" >
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-3 control-label">支付宝-SELLER：</label>
                                <div class="col-sm-7">
                                    <input id="Ali_SELLER" type="text" name="Ali_SELLER"  value="${config.Ali_SELLER}"  class="form-control ali" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">支付宝-RSA_PRIVATE_KEY：</label>
                                <div class="col-sm-7">
                                    <input id="Ali_RSA_PRIVATE" type="text" name="Ali_RSA_PRIVATE"  value="${config.Ali_RSA_PRIVATE}"  class="form-control ali" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">支付宝-RSA_PUBLICK_KEY：</label>
                                <div class="col-sm-7">
                                    <input id="Ali_RSA_PUBLICK_KEY" type="text" name="Ali_RSA_PUBLICK_KEY"  value="${config.Ali_RSA_PUBLICK_KEY}"  class="form-control ali" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">支付宝支付成功通知地址-NOTIFY_URL：</label>
                                <div class="col-sm-7">
                                    <input id="Ali_NOTIFY_URL" type="text" name="Ali_NOTIFY_URL"  value="${config.Ali_NOTIFY_URL}"  class="form-control ali" >
                                </div>
                            </div>
                            <div class="form-group">	
                                   <div class="col-sm-4 col-sm-offset-3">
                                      <button class="btn btn-warning" onclick="sysEdit('ali');" type="button"><i class="fa fa-paste"></i>编辑</button>
                                      <button class="btn btn-primary"  onclick="sysSave('ali');"  type="button"><i class="fa fa-check"></i>保存</button>
                                </div>
                            </div>
                         <!-- 内容 -->
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>微信支付参数设置</h5>
                    </div>
                    <div class="ibox-content">
                    
                       <div class="form-group">
                                <label class="col-sm-3 control-label">充值title：</label>
                                <div class="col-sm-7">
                                    <input id="zf_title" type="text" name="zf_title"  value="${config.zf_title}"  class="form-control weixin" >
                                </div>
                            </div>
                        <div class="form-group">
                                <label class="col-sm-3 control-label">微信应用ID-wx_appid：</label>
                                <div class="col-sm-7">
                                    <input id="wx_appid" type="text" name="wx_appid"  value="${config.wx_appid}"  class="form-control weixin" >
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-3 control-label">微信商户号-wx_mchid：</label>
                                <div class="col-sm-7">
                                    <input id="wx_mchid" type="text" name="wx_mchid"  value="${config.wx_mchid}"  class="form-control weixin" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">微信-wx_key：</label>
                                <div class="col-sm-7">
                                    <input id="wx_key" type="text" name="wx_key"  value="${config.wx_key}"  class="form-control weixin" >
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">微信-wx_url：</label>
                                <div class="col-sm-7">
                                    <input id="wx_url" type="text" name="wx_url"  value="${config.wx_url}"  class="form-control weixin" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">微信-wx_notity_url：</label>
                                <div class="col-sm-7">
                                    <input id="wx_notity_url" type="text" name="wx_notity_url"  value="${config.wx_notity_url}"  class="form-control weixin" >
                                </div>
                            </div>
                            <div class="form-group">	
                                   <div class="col-sm-4 col-sm-offset-3">
                                      <button class="btn btn-warning" onclick="sysEdit('weixin');" type="button"><i class="fa fa-paste"></i>编辑</button>
                                      <button class="btn btn-primary"  onclick="sysSave('weixin');"  type="button"><i class="fa fa-check"></i>保存</button>
                                </div>
                            </div>
                         <!-- 内容 -->
                    </div>
                </div>
            </div>
        </div>
</form>
    </div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	</body>
	<script>
	    $(function(){
	    	$("input").attr("disabled",true);
	    });
	    function  sysEdit(classTag){
	    	$("."+classTag+"").removeAttr("disabled");
	    }
	    function sysSave(classTag){
	    	/*请求
	    	后台*/
	    	$("input").removeAttr("disabled");
	    	var PostData = $("#commentForm").serialize();
	    	$("input").attr("disabled",true);
	    	Ajax.request("/cfg/update",{"data":PostData,"success":function(data){
	    		    if(data.result != "200"){
	    		        alert(data.msg);
	    		    }
	    	}});
	    }
	    
	</script>
</html>