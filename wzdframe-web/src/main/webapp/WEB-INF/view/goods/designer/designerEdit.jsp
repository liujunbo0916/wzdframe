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
	<%@ include file="../../common/top.jsp"%>
	<link href="/assets/css/plugins/summernote/summernote.css" rel="stylesheet">
	<link href="/assets/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
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
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5><c:if test="${not empty dataModel}">编辑</c:if><c:if test="${empty dataModel}">新增</c:if>商品品牌</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/goods/designer/save" method="post" class="form-horizontal m-t" id="commentForm" enctype="multipart/form-data">
                             
							<input type="hidden" name="designer_id" id="designer_id" value="${dataModel.designer_id}" />
							<div class="form-group">
    							<label class="col-sm-2 control-label">设计师头像：</label>
    							<div class="col-sm-8">
       						         <div class="fileupload fileupload-new" data-provides="fileupload">
											<div class="fileupload-new thumbnail" style="max-height: 200px;">
												<img src="${SETTINGPD.IMAGEPATH}${dataModel.designer_img}" height="100" width="200">
												<%-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} --%>
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail"
												style="max-height: 200px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-default btn-file"> 
													<span class="fileupload-new">选择文件</span> 
													<span class="fileupload-exists">重选</span> 
													 <input type="file" name="designer_img" id="designer_img"/>
												</span> 
												<a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">移除</a>
											</div>
										</div>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">设计师名称：</label>
    							<div class="col-sm-8">
       						          <input type="text" name="designer_name" id="designer_name" class="form-control" value="${dataModel.designer_name}" required/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">设计师理念：</label>
    							<div class="col-sm-8">
                                     <input type="text" name="designer_concept" id="designer_concept" class="form-control" value="${dataModel.designer_concept}"/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">简述：</label>
    							<div class="col-sm-8">
       								<textarea placeholder="多个分组换行分隔" name="designer_desc" id="designer_desc" class="form-control">${dataModel.designer_desc}</textarea>
    							</div>
							</div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="submit"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
                                    <button class="btn btn-warning" type="button" onclick="history.go(-1)"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
    <script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
</body>
</html>