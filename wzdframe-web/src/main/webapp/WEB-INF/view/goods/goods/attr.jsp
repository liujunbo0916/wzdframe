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
	.form-control{
    width: 250px;

    }
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                    <c:choose>
                       <c:when test="${not empty varList}">
                          <c:forEach items="${varList}" var="attr"  varStatus="status">
								<div class="form-group">
								    <input type="hidden" name="goodsAttr[${status.index}].attr_id" id="attr_id" class="form-control" value="${attr.type_attr_id}" required />
	    							<!-- 这主要用作显示 -->
	    							<label class="col-sm-2 control-label">${attr.attr_name}</label>
	    							<!-- 隐藏域用作入库 -->
	    							<input type="hidden" name="goodsAttr[${status.index}].attr_name" id="attr_name" class="form-control" value="${attr.attr_name}" required />
	    							<!-- 隐藏域用作入库 -->
	    							<input type="hidden" name="goodsAttr[${status.index}].attr_sort" id="attr_sort" class="form-control" value="${attr.attr_sort}" required />
	    							<input type="hidden" name="goodsAttr[${status.index}].is_sale" id="is_sale" class="form-control" value="${attr.is_sale}" required />
	    							<div class="col-sm-8">
	    							         <!-- （1单行文本，2多行文本，3单选，4多选） -->
											<c:if test="${attr.attr_input == 1 }">
												<input type="text" name="goodsAttr[${status.index}].attr_value" id="attr_value" class="form-control" value="" required />
											</c:if>
											<c:if test="${attr.attr_input == 2 }">
												<textarea placeholder="多个分组换行分隔" name="goodsAttr[${status.index}].attr_value" id="attr_value" class="form-control">${dataModel.list_img}</textarea>
											</c:if>
											<c:if test="${attr.attr_input == 3 }">
												<select name="goodsAttr[${status.index}].attr_value" id="attr_value" class="form-control" style="width: 250px;">
															<c:forEach  var="val" varStatus="vs" items="${fn:split(attr.attr_values,',')}">
																<option value="${val}">${val}</option>
															</c:forEach>
												</select>
											</c:if>
											<c:if test="${attr.attr_input == 4 }">
											              <!--  <input type="hidden" value="" name="attr_value" id="attr_checkbox"> -->
											               <c:forEach  var="val" varStatus="vs" items="${fn:split(attr.attr_values,',')}">
																<label class="checkbox-inline"><input type="checkbox" value="${val}" name="goodsAttr[${status.index}].attr_value" id="attr_value" onclick="chk()">${val}</label>
															</c:forEach>
															<!-- <input type="button" onclick="chk()" value="提 交" /> -->
											</c:if>
										</div>
								</div>
                          </c:forEach>
                       </c:when>
                       <c:otherwise>
							<tr class="main_info">
								<td colspan="7" class="center">没有相关数据</td>
							</tr>
					   </c:otherwise>
					</c:choose>
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
    <script type="text/javascript">
	   /*  function chk(){ 
	    	var obj=document.getElementsByName('test'); 
	    	//取到对象数组后，我们来循环检测它是不是被选中 
	    	var s=''; 
	    	for(var i=0; i<obj.length; i++){ 
	    	   if(obj[i].checked) 
	    		   s+=obj[i].value+';'; //如果选中，将value添加到变量s中 
	    	} 
	    	alert(s.substr(0,s.length-1)+",");
	    	//给复选框赋值
	    	$("#attr_checkbox").val(s.substr(0,s.length-1)+",");
	    	}  */
    </script>
</body>
</html>