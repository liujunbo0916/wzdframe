<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
	<%@ include file="../common/top.jsp"%>
	<link href="/assets/css/plugins/codemirror/codemirror.css" rel="stylesheet">
    <link href="/assets/css/plugins/codemirror/ambiance.css" rel="stylesheet">
	
	<style type="text/css">
	.file-pick {
	    font-size: 18px;
	    background: #00b7ee;
	    border-radius: 3px;
	    line-height: 44px;
	    padding: 0 30px;
	    color: #fff;
	    display: inline-block;
	    margin: 0 auto 20px auto;
	    cursor: pointer;
	    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	}
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title" style="min-height:65px">
						<h5>
							代码辅助
						</h5>
						<div class="ibox-tools" >
							<form action="/code/codePage" id="commentForm" class="form-inline form-horizontal">
								<div class="col-md-13">
										<div class="input-group" style="float: left;width: 300px">
											<input type="text" class="form-control" name="moduleName" value="${moduleName}" placeholder="输入模块代码  例如 goods 或者orders">
										</div>
										<div class="input-group" style="float: left;width: 300px">
											<input type="text" class="form-control" name="tableName" id="startUserDate" value="${tableName}" placeholder="输入数据表名称">
										</div>
										<div class="input-group" style="float: left;">
											 <span class="input-group-btn">
											 	<button type="submit" style="height: 34px;border-top-right-radius:3px; border-bottom-right-radius:3px;" class="btn btn-primary">生成</button>
											 </span>
										</div>
								</div>
	                        </form>
						</div>
					</div>
					<div class="ibox-content">
						<div class="panel blank-panel">
							<div class="tabs-left">
								<ul class="nav nav-tabs">
									<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">SQLMapper</a></li>
									<li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="true">Controller</a>
									</li>
									<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="true">Service</a>
									</li>
									<li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="true">DaoMapper</a>
									</li>
								</ul>
								<div class="tab-content ">
										<div id="tab-1" class="tab-pane active">
											<div class="panel-body">
												<div class="ibox-content no-padding">
													<textarea id="code_sql" class="form-control" rows="30">${sql}</textarea>
												</div>
											</div>
										</div>
										<div id="tab-2" class="tab-pane">
											<div class="panel-body">
												<div class="ibox-content no-padding">
													<textarea id="code_ctr" class="form-control" rows="30">${service}</textarea>
												</div>
											</div>
										</div>
										<div id="tab-3" class="tab-pane">
											<div class="panel-body">
												<div class="ibox-content no-padding">
													<textarea id="code_service" class="form-control" rows="30">${ctr}</textarea>
												</div>
											</div>
										</div>
										<div id="tab-4" class="tab-pane">
											<div class="panel-body">
							                    <div class="ibox-content no-padding">
													<textarea id="code_dao" class="form-control" rows="30">${dao}</textarea>
												</div>
											</div>
										</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
    <script src="/assets/js/plugins/codemirror/codemirror.js"></script>
    <script src="/assets/js/plugins/codemirror/mode/javascript/javascript.js"></script>
    <script>
    var editor_sql = CodeMirror.fromTextArea(document.getElementById("code_sql"), {
        lineNumbers: true,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "ambiance",
        height:"500px"
    });
    
    var editor_dao = CodeMirror.fromTextArea(document.getElementById("code_dao"), {
        lineNumbers: true,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "ambiance",
        height:"500px"
    });
    var editor_ctr = CodeMirror.fromTextArea(document.getElementById("code_ctr"), {
        lineNumbers: true,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "ambiance",
        height:"500px"
    });
    var editor_service = CodeMirror.fromTextArea(document.getElementById("code_service"), {
        lineNumbers: true,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "ambiance",
        height:"500px"
    });
    
    
	</script>
</body>
</html>