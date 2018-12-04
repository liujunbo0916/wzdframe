<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../common/top.jsp"%>
<!-- 百度上传插件 -->
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/webuploader.css">
<link rel="stylesheet" type="text/css"
	href="/statics/image-upload/style.css">
<link href="/assets/css/plugins/blueimp/css/blueimp-gallery.min.css"
	rel="stylesheet">
	<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
	
	  <link rel="stylesheet" href="/assets/ace/css/bootstrap.css" />
		<link rel="stylesheet" href="/assets/ace/css/font-awesome.css" />
		<link rel="stylesheet" href="/assets/ace/css/ace-fonts.css" />
		<link rel="stylesheet" href="/assets/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<script src="/assets/ace/js/ace-extra.js"></script>
	
	<style type="text/css">
	  .ship-img{
		    position: absolute;
		    left: 15%;
            top: 50%;
		    transform: translate(-50%,-50%);
		    width: 63px;
		}
	</style>
</head>
<body class="gray-bg"> 
	<form action="/sys/culture/resource/uploadVedio" method="post"
						class="form-horizontal" id="commentForm"
						enctype="multipart/form-data">
	<div class="wrapper wrapper-content">
			<div class="row" style="background-color: #fff;">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
						   		<div class="row">
	                            <div class="col-sm-6 b-r">
							  	<div class="form-group">
		    							<label class="col-sm-2 control-label"><font  color="red" size="3px"  style="font-weight: bold; font-style: italic;">*&nbsp;</font>视频标题：</label>
		    							<input type="hidden" class="form-control" id="category_id" name="category_id" value="${pd.category_id}">
		    							<input type="hidden" class="form-control" id="id" name="id" value="${modelData.id}">
		    							<div class="col-sm-8">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="resource_title" name="resource_title" value="${modelData.resource_title}">
				                            </div>
		    							</div>
									</div>
								  	<div class="form-group">
		    							<label class="col-sm-2 control-label"><font  color="red" size="3px"  style="font-weight: bold; font-style: italic;">*&nbsp;</font>视频简述：</label>
		    							<div class="col-sm-8">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" name="resource_desc" id="resource_desc" value="${modelData.resource_desc}">
				                            </div>
		    							</div>
									</div>	
									<div class="form-group">
													<!-- 封面图 -->
									   <label class="col-sm-2 control-label"><font  color="red" size="3px"  style="font-weight: bold; font-style: italic;">*&nbsp;</font>视频文件（不可更改平台只支持mp4格式视频文件 其他格式请转码成mp4）：</label>
													<div class="col-sm-8">
															<c:if test="${not empty modelData}">
															<div>
																   <img onclick="autoPlayVideo('${modelData.id}');" src="${SETTINGPD.IMAGEPATH}${modelData.resource_img}"
																	style="width: 160px; height: 106px;cursor: pointer;">
																	<div class="ship-img">
																		<img onclick="autoPlayVideo('${modelData.id}');" style="width:30px;cursor: pointer;" src="/statics/img/shipingbf.png">
																	</div>
																</div>
																</c:if>
														<c:if test="${empty modelData}">
														<div class="fileupload fileupload-new"
															data-provides="fileupload">
															<div
																class="fileupload-preview fileupload-exists thumbnail"
																style="max-height: 200px; line-height: 20px;">
																</div>
																
															<div>
																<span class="btn btn-default btn-file"> <span
																	class="fileupload-new">选择文件</span> <span
																	class="fileupload-exists">重选</span> <input
																	id="resource_path" name="resource_path" type="file"   accept="audio/mp4,video/mp4">
																</span> <a href="#" class="btn btn-default fileupload-exists"
																	data-dismiss="fileupload">移除</a>
															</div>
														</div>
															</c:if>
													</div>
												</div>
											<div class="form-group">
									            <div class="col-sm-4 col-sm-offset-5">
									                <button class="btn btn-primary" type="button"  onclick="checkParam();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
									                <button class="btn btn-warning" type="button"  onclick="closed();"><i class="fa fa-exchange"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
									            </div>
									         </div>	
									         </div>
									         </div>	
						</div>
					</div>
				</div>
			</div>
	</div>
	</form>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script src="/statics/js/jquery-upload.js"></script>
	<script type="text/javascript">
    $(function(){
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
	  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	  function closed(){
		  parent.layer.close(index);
	   }
	  var submitFlag = false;
	  function checkParam(){
		  if(submitFlag){
			  bootbox.alert("请耐心等待后台程序处理");
			  return;
		  }
		  if($("#resource_title").val().isEmpty()){
			  bootbox.alert("请输入标题");
			  return;
		  }
		  submitFlag = true;
		  $("#commentForm").submit();
	  }
	  //播放视频
	  function autoPlayVideo(id){
		  var index = layer.open({
	            type: 2,
	            title: '视频播放',
	            maxmin: true,
	            shadeClose: true, //点击遮罩关闭层
	            area : ['750px' , '500px'],
	            content: "/sys/culture/resource/autoPlayVideo?id="+id
	        });
	  }
	</script>
</body>
</html>