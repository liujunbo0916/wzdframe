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
                        <form action="/sys/goods/goodsBrand/save" method="post" class="form-horizontal m-t" id="commentForm" enctype="multipart/form-data">
                             
							         <input type="hidden" name="brand_id" id="brand_id" value="${dataModel.brand_id}" />
							          <input type="hidden" name="category_id" id="category_id" value="${dataModel.category_id}" />
							<div class="form-group">
    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>品牌名称：</label>
    							<div class="col-sm-8">
                                     <input type="text" name="brand_name" id="brand_name" class="form-control" value="${dataModel.brand_name}"/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>名称首字母：</label>
    							<div class="col-sm-8">
                                     <input type="text" name="brand_firstW" id="brand_firstW" class="form-control" value="${dataModel.brand_firstW}"/>
    							</div>
							</div>
								<div class="form-group" >
    							<label class="col-sm-2 control-label">所属分类：</label>
    							<div class="col-sm-2" id="appendCategory">
       						          <select class="form-control" name="category1_id" id="category1_id">
       						             <option value="">--选择分类--</option>
       						             <c:forEach items="${category1List}" var="first">
       						               <option value="${first.category_id}" <c:if test="${dataModel.category1_id eq first.category_id}">selected='selected'</c:if>>${first.category_name}</option>
       						             </c:forEach>
       						          </select>
    							</div>
    						<c:if test="${not empty category2List}">
    							<div class="col-sm-2" id="categoryAppend2">
       						          <select class="form-control" name="category2_id" id="category2_id">
       						             <option value="">--选择分类--</option>
       						             <c:forEach items="${category2List}" var="second">
       						               <option value="${second.category_id}" <c:if test="${dataModel.category2_id eq second.category_id}">selected='selected'</c:if>>${second.category_name}</option>
       						             </c:forEach>
       						          </select>
    							</div>
    						</c:if>	
    						<c:if test="${not empty category3List}">
    							<div class="col-sm-2" id="categoryAppend3">
       						          <select class="form-control" name="category3_id" id="category3_id">
       						             <option value="">--选择分类--</option>
       						             <c:forEach items="${category3List}" var="thrid">
       						               <option value="${thrid.category_id}" <c:if test="${dataModel.category1_id eq thrid.category_id}">selected='selected'</c:if>>${thrid.category_name}</option>
       						             </c:forEach>
       						          </select>
    							</div>
    						</c:if>		
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">品牌官网：</label>
    							<div class="col-sm-8">
       						          <input type="text" name="brand_url" id="brand_url" class="form-control" value="${dataModel.brand_url}" required/>
    							</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">品牌logo：</label>
    							<div class="col-sm-8">
       						         <div class="fileupload fileupload-new" data-provides="fileupload">
											<div class="fileupload-new thumbnail" style="max-height: 200px;">
												<img src="${SETTINGPD.IMAGEPATH}${dataModel.brand_icon}" onerror="this.src='/statics/img/no-img.jpg'" height="100" width="200">
												<%-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} --%>
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail"
												style="max-height: 200px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-default btn-file"> 
													<span class="fileupload-new">选择文件</span> 
													<span class="fileupload-exists">重选</span> 
													 <input type="file" name="brand_icon" id="brand_icon"/>
												</span> 
												<a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">移除</a>
											</div>
										</div>
    							</div>
							</div>
					<%-- 		<div class="form-group">
    							<label class="col-sm-2 control-label">品牌分类：</label>
    							<div class="col-sm-8">
       								<textarea placeholder="多个分组换行分隔" name="brand_category" id="brand_category" class="form-control">${dataModel.brand_category}</textarea>
    							</div>
							</div>
							 --%>
								<div class="form-group">
    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>排序：</label>
    							<div class="col-sm-4">
    							    <input type="number" name="brand_order" id="brand_order" class="form-control" value="${dataModel.brand_order}"/>
    							</div>
    							<div class="col-sm-4">
    							</div>
							</div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="checkParam();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
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
    <script type="text/javascript" src="/statics/js/user/Category.js"></script>
    <script type="text/javascript">
    $(function(){
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
    
    function checkParam(){
    	 if(!$("#brand_name").val().isNotEmpty()){
  		   bootbox.alert("请输入品牌名字");
  		   return false;
  	   }
  	   if(!$("#brand_order").val().isNotEmpty()){
  		   bootbox.alert("排序数值");
  		   return false;
  	   }
  	   if(!$("#brand_firstW").val().isNotEmpty()){
  		   bootbox.alert("请填写品牌首字母");
		   return false;
  	   }
  	   var reg= /^[A-Za-z]+$/;
  	   if(!reg.test($("#brand_firstW").val()) || $("#brand_firstW").val().length > 1){
  		 bootbox.alert("首字母填写不合法");
		   return false;
  	  }
  	   if($("#brand_order").val() > 500 || $("#brand_order").val() < 0){
  		  bootbox.alert("请输入0--500之前的正整数");
 		  return false;
  	   }
  	   
	   if($("#category3_id").val() && $("#category3_id").val() != '' && $("#category3_id").val()>0){
			   $("#category_id").val($("#category3_id").val());   
		   }else{
			   if($("#category2_id").val() && $("#category2_id").val() != ''&& $("#category2_id").val()>0){
				   $("#category_id").val($("#category2_id").val());
			   }else{
				   if($("#category1_id").val() && $("#category1_id").val() != ''&& $("#category1_id").val()>0){
					   $("#category_id").val($("#category1_id").val());
				   }else{
					   bootbox.alert("请选择商品分类");
					   return false;
				   }
			   }
		   }
		   $("#commentForm").submit();
    }
	//不可删除  避免报错
	function  callBack2Category(thisObj){
	}
	function callBack3Category(thisObj){
		
	}
    </script>
</body>
</html>