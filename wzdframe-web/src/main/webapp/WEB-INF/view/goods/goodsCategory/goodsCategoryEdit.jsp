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
                        <h5><c:if test="${not empty dataModel}">编辑</c:if><c:if test="${empty dataModel}">新增</c:if>商品分类</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/goods/goodsCategory/save" method="post" class="form-horizontal m-t" id="commentForm" enctype="multipart/form-data">
                             
							<input type="hidden" name="category_id" id="category_id" value="${dataModel.category_id}" />
							<div class="form-group">
    							<label class="col-sm-2 control-label">分类名称：</label>
    							<div class="col-sm-8">
       						<input type="text" name="category_name" id="category_name" class="form-control" value="${dataModel.category_name}" required/>
    							</div>
							</div>
							<c:if test="${not empty dataModel}">
							<div class="form-group">
    							<label class="col-sm-2 control-label">上级类目：</label>
    							<div class="col-sm-8">
       						               <select name="parent_id" class="form-control" required>
       						                        <option value="0">请选择</option>
													<c:forEach var="category" items="${categoryList}">
														<option value="${category.category_id}" <c:if test="${dataModel.parent_id eq category.category_id}"> selected ='selected'</c:if>>${category.category_name}</option>
													</c:forEach>
											</select>
    							</div>
							</div>
								</c:if>
								<c:if test="${empty dataModel}">
								<div class="form-group">
	    							<label class="col-sm-2 control-label">上级类目：</label>
	    							<div class="col-sm-8">
	       						               <select name="parent_id" class="form-control" required>
	       						                        <c:if test="${empty category_id}">
	       						                           <option value="0">顶级类目</option>
	       						                        </c:if>
	       						                        <c:if test="${not empty category_id}">
	       						                          <c:forEach var="category" items="${categoryList}">
															<option value="${category.category_id}" <c:if test="${category_id eq category.category_id}"> selected ='selected'</c:if>>${category.category_name}</option>
														  </c:forEach>
	       						                        </c:if>
												</select>
	    							</div>
								</div>
								</c:if>
						
						
								<div class="form-group">
	    							<label class="col-sm-2 control-label">分类icon：</label>
	    							<div class="col-sm-8">
	       						         <div class="fileupload fileupload-new" data-provides="fileupload">
												<div class="fileupload-new thumbnail" style="max-height: 200px;">
													<img src="${SETTINGPD.IMAGEPATH}${dataModel.category_icon}"  onerror="this.src='/statics/img/no-img.jpg'" height="100" width="200">
													<%-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} --%>
												</div>
												<div class="fileupload-preview fileupload-exists thumbnail"
													style="max-height: 200px; line-height: 20px;"></div>
												<div>
													<span class="btn btn-default btn-file"> 
														<span class="fileupload-new">选择文件</span> 
														<span class="fileupload-exists">重选</span> 
														 <input type="file" name="category_icon" id="category_icon"/>
													</span> 
													<a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">移除</a>
												</div>
											</div>
	    							</div>
								</div>
							
							
							<div class="form-group" style="display: none;">
    							<label class="col-sm-2 control-label">是否显示在搜索栏：</label>
    							<div class="col-sm-8">
       								<label class="radio-inline"><input type="radio"  name="is_show_search" value="1" <c:if test="${dataModel.is_show_search == 1}">checked="checked"</c:if> />是</label>
								    <label class="radio-inline"><input type="radio"  name="is_show_search" value="0" <c:if test="${dataModel.is_show_search == 0}">checked="checked"</c:if> />否</label>
    							</div>
							</div>
							<div class="form-group" style="display: none;">
    							<label class="col-sm-2 control-label">是否作为课程分类：</label>
    							<div class="col-sm-8">
       								<label class="radio-inline"><input type="radio"  name="is_course" value="1" <c:if test="${dataModel.is_course == 1}">checked="checked"</c:if> />是</label>
								    <label class="radio-inline"><input type="radio"  name="is_course" value="0" <c:if test="${empty dataModel.is_course || dataModel.is_course == 0}">checked="checked"</c:if> />否</label>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">排序：</label>
    							<div class="col-sm-3">
    						    	<input type="number" name="category_order" id="category_order" class="form-control" value="${dataModel.category_order}" required/>
    							</div>
    							<div class="col-sm-2">
    							   <span id="categoryOrderDesc">排序在系统前三的顶级分类将会显示在app商城首页</span>
    							</div>
							</div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="valication()"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
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
    <script type="text/javascript">
       $(function(){
    		$(".fileupload-exists").click(function(){
        		$(this).parents(".fileupload").children().eq(0).remove();
        	});
       });
    
        function valication(){
        	
        	if($("#category_name").val().isEmpty()){
        		bootbox.alert("分类名称不能为空");
        		return false;
        	}
        	if($("#category_name").val().length > 50){
        		bootbox.alert("类目名称应该在50个字符以内");
        		return false;
        	}
        	if($("#category_order").val().isEmpty() || $("#category_order").val() < 0 || $("#category_order").val() > 500){
        		bootbox.alert("请输入正确的排序数字");
        		return false;
        	}
        	$("#commentForm").submit();
        }
        $(function(){
        	//抓取回排序名次
        	$("#category_order").blur(function(){
        		Ajax.request("/sys/goods/goodsCategory/selectOrder.do?orderValue="+$(this).val(),{"success":function(data){
        			if(data.result == 200){
        				$("#categoryOrderDesc").text("当前系统最大值"+data.data.maxValue+",当前排名"+data.data.orderValue);
        			}
        		}});
        	});
        });
    </script>
    
    
</body>
</html>