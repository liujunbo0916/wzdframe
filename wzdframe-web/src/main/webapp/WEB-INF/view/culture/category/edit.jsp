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
	<style type="text/css">
		.sel{
		    border: none !important;height: 32px !important;text-align: center!important;
		}
		.input-addon{
			padding: 0px !important; width: 80px !important;
		}
		.curr-val{
		}
	</style>
	<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>编辑类目</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/culture/category/editAction" method="post" class="form-horizontal m-t" id="editForm" enctype="multipart/form-data">
                          <%--  <input type="hidden" name=user_id value="${dataModel.user_id}" />
                          CATEGORY_ICON,CATEGORY_NAME,CATEGORY_TAGS,PARENT_ID,ORDER_BY,DISABLED
                           --%>
                            <input type="hidden" name="id" value="${dataModel.id}" />
							<div class="row">
	                            <div class="col-sm-6 b-r">
                                	<div class="form-group">
		    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>类目名称：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="text" class="form-control" id="culture_category_name" name="culture_category_name" value="${dataModel.culture_category_name}">
				                            </div>
		    							</div>
		    							<div class="col-sm-2">
												<label class="control-label"><font
												color="red" size="3px"
												style="font-size:11px;">2到6个字符&nbsp;</font>
												</label>
								</div>
									</div>
									<div class="form-group">
		    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>选择颜色（前端要显示该名称的字体颜色）：</label>
		    							<div class="col-sm-8">
		       						         <div class="input-group">
				                                <input class="form-control jscolor" name="culture_category_color" value="${empty dataModel.culture_category_color ? 'FFFFFF' : dataModel.culture_category_color}">
				                            </div>
		    							</div>
									</div>
									<div class="form-group">
		    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>ICON：</label>
		    							<div class="col-sm-8">
		       						         	<div class="fileupload fileupload-new" data-provides="fileupload">
													<div class="fileupload-new thumbnail" style="max-height: 200px;">
														<img src="${SETTINGPD.IMAGEPATH}${dataModel.culture_category_logo}" height="100" width="200">
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> 
															<span class="fileupload-new">选择文件</span> 
															<span class="fileupload-exists">重选</span> 
															 <input type="file" name="culture_category_logo" id="culture_category_logo" accept="image/*"/>
														</span> 
														<a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">移除</a>
													</div>
										        </div>
		    							</div>
									</div>
									<div class="form-group">
		    							<label class="col-sm-2 control-label">选择文件类型：</label>
		    							<div class="col-sm-8">
		       						           <select class="form-control" id="culture_category_type" name="culture_category_type">
		       						                <option value="1" <c:if test="${dataModel.culture_category_type eq 1}">selected='selected'</c:if>>视频</option>
		       						                <option value="2" <c:if test="${dataModel.culture_category_type eq 2}">selected='selected'</c:if>>音频</option>
		       						                <option value="3" <c:if test="${dataModel.culture_category_type eq 3}">selected='selected'</c:if>>图片</option>
		       						                <option value="4" <c:if test="${dataModel.culture_category_type eq 4}">selected='selected'</c:if>>文本</option>
		       						           </select>
				                              <%--   <input type="number" class="form-control" name="" value="${dataModel.culture_category_order_by}" /> --%>
				                            </div>
									</div>
									<div class="form-group" id="chooseContentCategory" <c:if test="${dataModel.culture_category_type ne 4}">style="display: none;"</c:if>>
		    							<label class="col-sm-2 control-label">选择内容栏目：</label>
		    							<div class="col-sm-8">
		       						         <c:if test="${empty contentCate}">
		       						            <p>暂时没有类目哦，请先前往<button type="button" class="btn btn-w-m btn-success">内容管理</button>添加类目。</p>
		       						         </c:if>
		       						          <c:if test="${not empty contentCate}">
			       						           <select class="form-control" id="culture_category_content" name="culture_category_content">
			       						            <option value=""  >请选择内容栏目</option>
			       						              <c:forEach items="${contentCate}" var="item">
			       						                 <option value="${item.CATEGORY_CODE}" <c:if test="${dataModel.culture_category_content eq item.CATEGORY_CODE}">selected='selected'</c:if>  >${item.CATEGORY_NAME}</option>
			       						              </c:forEach>
			       						           </select>
		       						           </c:if>
		    							</div>
									</div>
									<!-- 类目状态 -->
								   <div class="form-group">
		    							<label class="col-sm-2 control-label">显示状态：</label>
		    							<div class="col-sm-8">
				                                 <select class="form-control" name="culture_category_status">
				                                    <option value="1" <c:if test="${dataModel.culture_category_status eq 1}">selected='selected'</c:if>>显示</option>
				                                     <option value="2" <c:if test="${dataModel.culture_category_status eq 2}">selected='selected'</c:if>>隐藏</option>
				                                 </select>
		    							</div>
									</div>
									<!-- 排序 -->
									<div class="form-group">
		    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>排序：</label>
		    							<div class="col-sm-6">
		       						         <div class="input-group">
				                                <input type="number" class="form-control" id="culture_category_order_by" name="culture_category_order_by" value="${dataModel.culture_category_order_by}" />
				                            </div>
		    							</div>
		    								<div class="col-sm-2">
												<label class="control-label"><font
												color="red" size="3px"
												style="font-size:11px;">排序100以内&nbsp;</font>
												</label>
											</div>
									</div>
										<!-- 排序 -->
									<div class="form-group">
		    							<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>显示页面：</label>
		    							<div class="col-sm-6">
							            <label class="radio-inline">
							                <input type="radio" <c:if test="${empty dataModel.cultrue_category_position || dataModel.cultrue_category_position eq '0'}">checked="checked"</c:if>  value="0" id="cultrue_category_position1" name="cultrue_category_position">特色文化页面</label>
							            <label class="radio-inline">
							                <input type="radio" <c:if test="${dataModel.cultrue_category_position eq '1'}">checked="checked"</c:if> value="1" id="cultrue_category_position2" name="cultrue_category_position">特色涠洲页面</label>
		    							</div>
									</div>
									 <div class="form-group">
		                                <div class="col-sm-4 col-sm-offset-3">
		                                    <button class="btn btn-primary" type="button" onclick="checkParam();"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
		                                    <button class="btn btn-warning" type="button" onclick="history.go(-1)"><i class="fa fa-close"></i>&nbsp;&nbsp;返   回&nbsp;&nbsp; </button>
		                                </div>
		                            </div>
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
	<script src="/statics/js/color-select/jscolor.js"></script>
	<script type="text/javascript">
    $(function(){
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
	    $(function(){
	    	//如果选择文本  直接弹出关联内容栏目
	    	$("#culture_category_type").change(function(){
	    		if($(this).val() == 4){
	    			$("#chooseContentCategory").show();
	    		}else{
	    			$("#chooseContentCategory").hide();
	    		}
	    	});
	    });
	    function checkParam(){
	    	if($("#culture_category_name").val().isEmpty() || $("#culture_category_name").val().length<2 || $("#culture_category_name").val().length>6){
	    		bootbox.alert("栏目名字2到6个字符");
	    		return;
	    	}
	    	
	    	if($("#culture_category_order_by").val().isEmpty() || parseInt($("#culture_category_order_by").val()) >100 || parseInt($("#culture_category_order_by").val()) < 0){
	    		bootbox.alert("排序为0到100之前的正整数");
	    		return;
	    	}
	    	
	    	if($("#culture_category_type").val() == 4){
	    		if($("#culture_category_content") && $("#culture_category_content").val()){
	    		}else{
	    			bootbox.alert("类型为文本的栏目必须选择内容栏目。");
	    			return;
	    		}
	    	} 
	    	$("#editForm").submit();
	    }
		function submitForm(){
			app.submitForm("editForm",onSuccess,onError);
		}
		function onSuccess(data){
			app.toast("不可思议,居然做对了", "提示!","success");
		}
		function onError(){
			app.toast("你特码的是不是傻!", "老子是个提示!","error");
		}
	</script>
</body>
</html>