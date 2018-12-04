<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
                        <h5><c:if test="${not empty dataModel}">编辑</c:if><c:if test="${empty dataModel}">新增</c:if>商品类型</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/goods/goodsType/save" method="post" class="form-horizontal m-t" id="commentForm">
                             
							<input type="hidden" name="type_id" id="type_id" value="${dataModel.type_id}" />
							<input type="hidden" name="brand_ids" id="brand_ids" value="${dataModel.brand_ids}" />
							 <input type="hidden" name="category_id" id="category_id" value="${dataModel.category_id}" />
							<div class="form-group">
    							<label class="col-sm-2 control-label">类型名称：</label>
    							<div class="col-sm-8">
       						<input type="text" name="type_name" id="type_name" class="form-control" value="${dataModel.type_name}" required/>
    							</div>
							</div>
							<!-- 所属类目 -->
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
							
						    <div class="form-group" >
    							<label class="col-sm-2 control-label">选择品牌：</label>
		    					   <div class="col-sm-1" id="brand_list">
		    					   </div>
									<div class="col-sm-1">
									      <button type="button" onclick='selectBrank();'  class="btn btn-sm btn-block" ><i class="fa fa-mobile-phone"></i> 点击选择品牌</button>
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
    <script type="text/javascript" src="/statics/js/user/Category.js"></script>
<!-- 自定义js -->
</body>
<script type="text/javascript">
	$(function(){
		if($("#brand_ids").val().isNotEmpty()){
			getSelectBrand($("#brand_ids").val());
		}
	});
	function checkParam(){
		if($("#type_name").val().isEmpty()){
			bootbox.alert("类型名字不能为空");
			return;
		}
		   if($("#category3_id").val() && $("#category3_id").val() != '' && $("#category3_id").val() >0){
			   $("#category_id").val($("#category3_id").val());   
		   }else{
			   if($("#category2_id").val() && $("#category2_id").val() != '' && $("#category2_id").val() >0){
				   $("#category_id").val($("#category2_id").val());
			   }else{
				   if($("#category1_id").val() && $("#category1_id").val() != '' && $("#category1_id").val() >0){
					   $("#category_id").val($("#category1_id").val());
				   }else{
					   bootbox.alert("请选择商品分类");
					   return false;
				   }
			   }
		   }
		var data = $("#commentForm").serialize();
		Ajax.request("/sys/goods/goodsType/save",{"data":data,"success":function(data){
			if(data.result == 200){
				window.location.href="/sys/goods/goodsType/listPage";
			}else{
				bootbox.alert(data.msg);
			}
		}});
	}
//打开一个弹出框上传课时
	var index;
	function selectBrank(){
		var title = "选择品牌";
		var url = "/sys/goods/goodsBrand/selectBrand.do?brandIds="+$("#brand_ids").val();
		index = layer.open({
			  type: 2,
			  title: '<font color="gray" size="3px"><strong>选择品牌 </strong></font>',
			  content: url,
			  area: ['800px', '495px'],
			  maxmin: true
			});
		layer.full(index);
	}
	/*获取已选品牌*/
	function getSelectBrand(brandIds){
		xrPage(brandIds);
	}
	function xrPage(brandIds){
		if(brandIds){
			Ajax.request("/sys/goods/goodsBrand/selectByIds?ids="+brandIds,{"success":function(data){
				if(data.data.length > 0){
					$(".brand_flag").remove();
					$("#brand_list").html('');
					for(var i = 0 ; i < data.data.length ; i++){
						if(i == 0){
							$("#brand_list").html('<span class="badge badge-info">'+data.data[i].brand_name+'</span>');
						}else{
						    $("#brand_list").after('<div class="col-sm-1 brand_flag"><span class="badge badge-info">'+data.data[i].brand_name+'</span></div>');
						}
					}
				}
			}});
			$("#brand_ids").val(brandIds);
		}
	}
	//不可删除  避免报错
	function  callBack2Category(thisObj){
	}
	function callBack3Category(thisObj){
		
	}
</script>
</html>