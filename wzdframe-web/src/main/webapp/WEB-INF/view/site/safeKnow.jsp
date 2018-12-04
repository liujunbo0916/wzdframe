<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<base href="<%=basePath%>">
<%@ include file="../common/top.jsp"%>
<!-- jsp文件头和头部 -->
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
								<form action="" name="userForm" id="userForm" method="post">
									<input type="hidden" name="safe_know" id="safe_know" value=""/>
									<input type="hidden" name="id" id="id" value="${site.id}"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr id="contents">
												<td style="width:95px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font> 安全须知:</td>
												<td colspan="3"><script id="safe_know_desc" type="text/plain" style="width:100%;height:280px">${site.safe_know}</script></td>
											</tr>
												<tr id="contents">
												<td style="text-align: center;" colspan="10">
												   <a class="btn btn-xlg btn-primary" id="save" onclick="save()">保存</a>
												</td>
											</tr>
							</table>
							</div>
							  <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
							</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<%@ include file="../common/foot.jsp"%>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 下拉框 -->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/statics/js/uedit/";</script>
	<script type="text/javascript" charset="utf-8" src="/statics/js/uedit/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/statics/js/uedit/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>
    <script src="/assets/ace/js/ace/elements.fileinput.js"></script>
	<script src="/statics/js/jquery-upload.js"></script>
    <!-- ace scripts -->
    <script src="/assets/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
</body>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('safe_know_desc');
		function save(){
		bootbox.confirm("确认保存？",
				function(result){
					if(result){
					    $("#safe_know").val(ue.getContent());
						$.post('/sys/content/sysContentUpdate',$("#userForm").serialize(), function(data) { 
						if(data.result != 200){
						  bootbox.alert("保存失败");
						}else{
						   bootbox.alert("保存成功");
						}
			});
		}
		});
	}
</script>
</html>