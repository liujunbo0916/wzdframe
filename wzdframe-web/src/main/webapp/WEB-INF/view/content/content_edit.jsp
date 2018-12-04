<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
	<!-- jsp文件头和头部 -->
		<%@ include file="../common/top.jsp"%>
		
		<link rel="stylesheet" href="static/ace/css/font-awesome.css" />
		<!-- page specific plugin styles -->
		<!-- text fonts -->
		<link rel="stylesheet" href="/assets/ace/css/ace-fonts.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="/assets/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="static/ace/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="static/ace/css/ace-ie.css" />
		<![endif]-->
		<!-- inline styles related to this page -->
		<!-- ace settings handler -->
		<script src="/assets/ace/js/ace-extra.js"></script>
		<link href="/assets/css/plugins/jedate1/skin/jedate.css"
	rel="stylesheet" />
		
	<!-- 日期框 -->
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
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
					<form action="/sys/content/${msg}" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="CONTENT_ID" id="CONTENT_ID" value="${pd.CONTENT_ID}"/>
						<input type="hidden" name="CONTENT" id="CONTENT" value=""/>
						<input type="hidden" name="T_IMG" id="T_IMG" value="${pd.T_IMG}"/>
						<input type="hidden" name="C_IMG" id="C_IMG" value="${pd.C_IMG}"/>
						<input type="hidden" name="STATE" id="dataState"/>
						<input type="hidden" name="PUBLISHER_ID" id="PUBLISHER_ID" value="50"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font> 栏目:</td>
								<td>
								 	<select name="CATEGORY_CODE" id="CATEGORY_ID" class="form-control" data-placeholder="文章栏目" style="vertical-align:top;width: 150px;">
									 	<option value="">请选择文章栏目</option>
								 		<c:forEach items="${categoryList}" var="item">
											<option value="${item.CATEGORY_CODE}" <c:if test="${pd.CATEGORY_CODE == item.CATEGORY_CODE }">selected</c:if>>${item.CATEGORY_NAME}</option>
									    </c:forEach>
								  	</select>
								</td>
								<td style="width:85px;text-align: right;padding-top: 13px;">发布时间:</td>
								<td>
									<input type="text" class="form-control date"
																style="width:80%; cursor: pointer; background-color: #fff;"
																name="PUTTIME" id="PUTTIME"
																readonly="readonly"
																value='<fmt:formatDate value="${pd.PUTTIME}" pattern="yyyy-MM-dd hh:mm:ss"
																								/>'>
								</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font> 标题:</td>
								<td><input type="text" class="form-control" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="48" placeholder="这里输入标题" onkeyup="ValidateValue(this)" title="标题" style="width:98%;"/></td>
								<td style="width:85px;text-align: right;padding-top: 13px;">外部链接:</td>
								<td><input type="text" class="form-control" name="LINK" id="LINK" value="${pd.LINK}" maxlength="255" onkeyup="if(!isURL(this.value)) {layer.tips('无效链接', '#LINK');}else{layer.tips('链接可用', '#LINK',{tips: [2, '#78BA32']})}" placeholder="这里输入外部访问链接([https|http|ftp|rtsp|mms]://)" title="外部访问链接" style="width:98%;"/></td>
							</tr>
							 <tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"> 标题简称:</td>
								<td><input type="text" class="form-control" name="SORT_TITLE" id="SORT_TITLE" value="${pd.SORT_TITLE}" maxlength="48" onkeyup="ValidateValue(this)" placeholder="这里输入标题简称" title="标题简称" style="width:98%;"/></td>
								<td style="width:85px;text-align: right;padding-top: 13px;">作者:</td>
								<td><input type="text" name="AUTHOR" id="AUTHOR" class="form-control" value="${pd.AUTHOR}" maxlength="24" onkeyup="ValidateValue(this)" placeholder="这里输入作者" title="作者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"> 摘要:</td>
								<td colspan="3"><input type="text" class="form-control" name="ABSTRACT" id="ABSTRACT" value="${pd.ABSTRACT}" maxlength="500" placeholder="这里输入摘要" title="摘要" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"> Tag标签:</td>
								<td colspan="3">
								<div class="col-sm-10">
								<input type="text" class="form-control" name="TAGS" id="TAGS" value="${pd.TAGS}" maxlength="24" onkeyup="ValidateValue2(this)" placeholder="这里输入Tag标签" title="Tag标签" style="width:90%;"/>
								</div>
								<div class="col-sm-2">
								<span><font color="green">&nbsp;以"|"分隔填入</font></span>
								</div>
								</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;"> 来源:</td>
								<td><input type="text" class="form-control" name="ORGIN" id="ORGIN" value="${pd.ORGIN}" maxlength="24" onkeyup="ValidateValue(this)" onblur="appendX('ORGIN','ORGINURLX')" placeholder="这里输入来源" title="来源" style="width:98%;"/></td>
								<td style="width:85px;text-align: right;padding-top: 13px;">URL:</td>
								<td><input type="text" class="form-control" name="ORGINURL" id="ORGINURL" value="${pd.ORGINURL}" maxlength="255" placeholder="这里输入来源链接([https|http|ftp|rtsp|mms]://)" onkeyup="if(!isURL(this.value)) {layer.tips('无效链接', '#ORGINURL');}else{layer.tips('链接可用', '#ORGINURL',{tips: [2, '#78BA32']})}" title="URL" style="width:98%;"/><span id="ORGINURLX"></span></td>
							</tr>
							
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">专题广告:</td>
									<td colspan="2" class="center">
									<label>是&nbsp;<input type="radio"  id="CTYPE" name="CTYPE" value="1"  <c:if test="${pd.CTYPE == 1}">checked="checked"</c:if> /><span class="lbl"></span></label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<label>否&nbsp;<input type='radio'  id="CTYPE" name="CTYPE" value="0" <c:if test="${empty pd.CTYPE || pd.CTYPE == 0}">checked="checked"</c:if> /><span class="lbl"></span></label>
								</td>
							</tr>
							<tr class="subject_code">
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;"></font>选择专题:</td>
								<td colspan="3">
								 	<select name="SUBJECT_CODE" id="SUBJECT_CODE" class="form-control" data-placeholder="广告专题" style="vertical-align:top;width: 150px;">
									 	<option value="">请选择广告专题</option>
									 	<option value="1" <c:if test="${pd.SUBJECT_CODE == 1 }">selected</c:if>>跟团游旅游推广</option>
									 	<option value="2" <c:if test="${pd.SUBJECT_CODE == 2}">selected</c:if>>普通门票旅游推广</option>
									<%--  	<c:forEach items="${categoryList}" var="item">
											<option value="${item.SUBJECT_ID}" <c:if test="${pd.SUBJECT_CODE == item.SUBJECT_ID }">selected</c:if>>${item.NAME}</option>
										</c:forEach> --%>
								  	</select>
								</td>
							</tr>
								<tr class="subject_code">
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;"></font>专题关联：</td>
								<td colspan="3">
								 	<input type="button" class="btn btn-mini" value="关联门票" onclick="addSubjectId('${pd.SUBJECT_ID}')" />
								 	<div class="subjectId">
								 	<c:if test="${(not empty pd.CTYPE && pd.CTYPE==1) &&( not empty pd.SUBJECT_CODE && pd.SUBJECT_CODE==1) &&(not empty pd.SUBJECT_ID) && (not empty pd.relation && pd.relation!='')}">
								 		<table class="center table table-striped table-bordered table-hover">
										<thead>
											<tr>
											<th>线路名称</th>
											<th>线路图片</th>
											<th>线路价格</th>
											<th>联系电话</th>
											<th>游览天数</th>
											<th>线路销量</th>
											</tr>
										</thead>
										<tbody>
														<tr>
															<input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="${pd.SUBJECT_ID}"></td>
															<td>${pd.relation.grouptour_name}</td>
														<td><img alt="" width="100px" height="100px"
															src="${SETTINGPD.IMAGEPATH}${pd.relation.grouptour_img}"></td>
														<td>${pd.relation.grouptour_price}</td>
														<td>${pd.relation.grouptour_phone}</td>
														<td>${pd.relation.grouptour_day}</td>
														<td>${pd.relation.grouptour_sales}</td>
														</tr>
										</tbody>
									</table>
								 	</c:if>
								 	<c:if test="${(not empty pd.CTYPE && pd.CTYPE==1)&&( not empty pd.SUBJECT_CODE && pd.SUBJECT_CODE==2 )&&( not empty pd.SUBJECT_ID) && (not empty pd.relation && pd.relation != '')}">
								 		<table class="center table table-striped table-bordered table-hover">
												<thead>
													<tr>
											<th>票务系统识别码</th>
											<th>景点名字</th>
											<th>票类名称</th>
											<th>类型</th>
											<th>起售价格</th>
											<th>单票/套票</th>
													</tr>
												</thead>
												<tbody>
														<tr>
														<input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="${pd.SUBJECT_ID}"></td>
														<td>${pd.relation.third_no}</td>
														<td>${pd.relation.scenic_name}</td>
														<td>${pd.relation.ticket_name}</td>
														<td>${pd.relation.cate_name}</td>
														<td>${pd.relation.ticket_price}</td>
														<td><c:if test="${pd.relation.ticket_package_type eq 1}">
																<span class="label label-primary">单票</span>
															</c:if> <c:if test="${pd.relation.ticket_package_type eq 2}">
																<span class="label label-danger">套票</span>
															</c:if></td>
														</tr>
												</tbody>
									</table>
								 	</c:if>
								 	</div>
								 	</td>
							</tr>
							<tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">固顶级别:</td>
								<td><input type="text" name="TOPLV" id="TOPLV" value="${pd.TOPLV}" maxlength="32" onkeyup="var reg=/^\d{1,8}$/; if(!reg.test(this.value)) {layer.tips('只能输入1到8位数字', '#TOPLV'); this.value='';}" onchange="appendX('TOPLV','TOPLVDATEX')" onblur="tipMax(this)" placeholder="这里输入固顶级别" title="固顶级别" style="width:60%;"/></td>
									<td colspan="2" class="center">
									<label>头条:&nbsp;<input type='checkbox'  id="ISHOT" name="ISHOT"  <c:if test="${pd.ISHOT}">checked="checked"</c:if> /><span class="lbl"></span></label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<label>焦点:&nbsp;<input type='checkbox'  id="ISFOCUS" name="ISFOCUS"  <c:if test="${pd.ISFOCUS}">checked="checked"</c:if> /><span class="lbl"></span></label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<label style="display: none;">推荐:&nbsp;<input type='checkbox' class="form-control" id="RECOMMEND" name="RECOMMEND" value="${pd.RECOMMEND}" <c:if test="${pd.RECOMMEND}">checked="checked"</c:if> /><span class="lbl"></span></label>
								</td>
							</tr>
						 	 <tr>
								<td style="width:85px;text-align: right;padding-top: 13px;">內容类型:</td>
									<td colspan="2" class="center">
									<label>单图模式:&nbsp;<input type="radio"  id="MODEL_TYPE" name="MODEL_TYPE" value="0"  <c:if test="${empty pd.MODEL_TYPE || pd.MODEL_TYPE == 0}">checked="checked"</c:if> /><span class="lbl"></span></label>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<label>多图模式:&nbsp;<input type='radio'  id="MODEL_TYPE" name="MODEL_TYPE" value="1" <c:if test="${pd.MODEL_TYPE == 1}">checked="checked"</c:if> /><span class="lbl"></span></label>
								</td>
							</tr> 
							<tr class="albums">
								<td style="width:85px;text-align: right;padding-top: 13px;">相册:</td>
								<td>
								<c:forEach items="${pd.albums}" var="item">
								<a href="${SETTINGPD.IMAGEPATH}${item.original_img}" target="_blank"><img  src="${SETTINGPD.IMAGEPATH}${item.original_img}" style="width: 210px; height: 140px;"/></a>
								</c:forEach>
								<input type="button" class="btn btn-mini" value="选择相册图片" onclick="addResource('${pd.CONTENT_ID}')" /></td>
							</tr>
							<tr class="tImgs">
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font> 列表图:</td>
								<td>
									<span id="showTIMG"></span>
									<c:if test="${pd == null || pd.T_IMG == '' || pd.T_IMG == null }">
										<input type="file" id="TIMG" name="TIMG" onchange="fileType(this,'TIMG','${pd.CATEGORY_TYPE}')" style="width:98%;"/>
									</c:if>
									<c:if test="${pd != null && pd.T_IMG != '' && pd.T_IMG != null }">
										<a href="${SETTINGPD.IMAGEPATH}${pd.T_IMG}" target="_blank"><img src="${SETTINGPD.IMAGEPATH}${pd.T_IMG}" width="210"/></a>
										<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delImg('${pd.CONTENT_ID}','T_IMG');" />
										<input type="hidden" name="TIMGz" id="TIMGz" value="${pd.T_IMG }"/>
									</c:if>
								</td>
								<td style="width:85px;text-align: right;padding-top: 13px;">封面图:</td>
								<td >
									<span id="showCIMG"></span>
									<c:if test="${pd == null || pd.C_IMG == '' || pd.C_IMG == null }">
										<input type="file" id="CIMG" name="CIMG" onchange="fileType(this,'CIMG','${pd.CATEGORY_TYPE}')" style="width:98%;"/>
									</c:if>
									<c:if test="${pd != null && pd.C_IMG != '' && pd.C_IMG != null}">
										<a href="${SETTINGPD.IMAGEPATH}${pd.C_IMG}" target="_blank"><img src="${SETTINGPD.IMAGEPATH}${pd.C_IMG}" width="210"/></a>
										<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delImg('${pd.CONTENT_ID}','C_IMG');" />
										<input type="hidden" name="CIMGz" id="CIMGz" value="${pd.C_IMG }"/>
									</c:if>
								</td>
							</tr>
							<tr id="contents">
								<td style="width:85px;text-align: right;padding-top: 13px;"><font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font> 内容:</td>
								<td colspan="3"><script id="editor" type="text/plain" style="width:100%;height:280px">${pd.CONTENT}</script></td>
							</tr>
							<c:if test="${empty  pd}">	
								<tr>
									<td style="text-align: center;" colspan="10">
											<a class="btn btn-xlg btn-primary" id="save" onclick="Content.submitForm(-1)">保存草稿</a>
											<a class="btn btn-xlg btn-danger" id="saveAndAudit" onclick="Content.submitForm(2);">保存并等待发布</a>
											<a class="btn btn-xlg btn-danger" onclick="closed();">取消</a>
									</td>
								</tr>
							</c:if>
							<c:if test="${not empty pd}">	
								<tr>
									<td style="text-align: center;" colspan="10">
										<c:if test="${pd.STATE eq 2}">
											<a class="btn btn-xlg btn-danger" id="saveAndAudit" onclick="Content.submitForm(2);">保存并等待发布</a>
											<a class="btn btn-xlg btn-primary" id="save" onclick="Content.submitForm(1)">发布上线</a>
											<!-- <a class="btn btn-xlg btn-primary" id="save" onclick="publish(1,1)">发布并通知客户端</a> -->
										</c:if>
										<c:if test="${pd.STATE eq 1}">
											<a class="btn btn-xlg btn-danger" id="saveAndAudit" onclick="Content.submitForm(2);">取消发布</a>
											<a class="btn btn-xlg btn-danger" id="save" onclick="Content.submitForm(1);">保存更改</a>
										</c:if>
										<c:if test="${pd.STATE eq -1}">
											<a class="btn btn-xlg btn-primary" id="save" onclick="Content.submitForm(-1)">保存草稿</a>
											<a class="btn btn-xlg btn-danger" id="saveAndAudit" onclick="Content.submitForm(2);">保存并等待发布</a>
										</c:if>
										<a class="btn btn-xlg btn-danger" onclick="closed();">取消</a>
									</td>
								</tr>
							</c:if>
						</table>
						</div>
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
<!-- /.main-container -->
	<!-- 页面底部js¨ -->
		<%@ include file="../common/foot.jsp"%>
	<!-- 下拉框 -->
	<script type="text/javascript"
		src="/assets/css/plugins/jedate1/jquery.jedate.js"></script>
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
	<!--提示框-->
	<script src="/statics/js/user/Content.js"></script>
	<!--提示框-->
<script type="text/javascript">
		$.jeDate("#PUTTIME",{
			format:"YYYY-MM-DD hh:mm:ss",
			isTime:true//isClear:false,
		});
		//实例化编辑器
	    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	    var ue = UE.getEditor('editor');
	    var index = parent.layer.getFrameIndex(window.name);
		function closed(){
			parent.layer.close(index);
		}
		//过滤特殊字符
		function ValidateValue2(textbox)  
        {  
             var IllegalString = "\`~@#;,.!#$%^&*()+{}\\:\"<>?-=/,\'";  
             var textboxvalue = textbox.value;  
             var index = textboxvalue.length - 1;  
             for(var i=index;i>=0;i--){
            	 var s = textbox.value.charAt(i);  
                 
                 if(IllegalString.indexOf(s)>=0)  
                 {  
                    s = textboxvalue.substring(0,i);  
                    textbox.value = s;  
                 }  
             }
        }  
		//过滤特殊字符
		function ValidateValue(textbox)  
        {  
             var IllegalString = "\`~@#;,!#$%^&*()+{}\\:\"<>?=/,\'";  
             var textboxvalue = textbox.value;  
             var index = textboxvalue.length - 1;  
             for(var i=index;i>=0;i--){
            	 var s = textbox.value.charAt(i);  
                 
                 if(IllegalString.indexOf(s)>=0)  
                 {  
                    s = textboxvalue.substring(0,i);  
                    textbox.value = s;  
                 }  
             }
        }  
		//必填字段检测动态追加
		function appendX(id1,id2){
			var value = $("#"+id1).val();
			$("#"+id2).empty();
			if(value !=""){
				$("#"+id2).append('<font color="red" size="3px" style="font-weight:bold;font-style:italic;">*</font>');
			}
		}
	 	
		 if ('${pd.MODEL_TYPE}' == '1') {
			$(".albums").show();
			$(".tImgs").hide();
		}
		if ('${pd.MODEL_TYPE}' == '0' || '${pd.MODEL_TYPE}' == '') {
			$(".albums").hide();
			$(".tImgs").show();
		}
		
		$(":radio[name='MODEL_TYPE']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".albums").show();
				$(".tImgs").hide();
			} else {
				$(".albums").hide();
				$(".tImgs").show();
			}
		});  
		
		if ('${pd.CTYPE}' == '1') {
			$(".subject_code").show();
		}
		if ('${pd.CTYPE}' == '0' || '${pd.CTYPE}' == '') {
			$(".subject_code").hide();
		}
		
		$(":radio[name='CTYPE']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".subject_code").show();
			} else {
				$(".subject_code").hide();
			}
		});
		  function addResource(id){
			      var index = layer.open({
		            type: 2,
		            title: '资源文件',
		            maxmin: true,
		            shadeClose: false, //点击遮罩关闭层 
		            area : ['850px' , '600px'],
		            cancel :false,
		            content: "/sys/content/resource/addPage?content_id="+id,
		        });
				layer.full(index); 
		   }
		
		 function addSubjectId(SUBJECT_ID){
			 var ctype=$("#CTYPE").val();
			 var subject_code=$("#SUBJECT_CODE").val();
			 if(ctype == 0 || subject_code == null || subject_code == '' || subject_code == 0){
				 alert("请选择广告专题");
				 return;
			 }
			 //跟团游旅游推广
			 if(subject_code==1){
				 var index = layer.open({
			            type: 2,
			            title: '跟团游列表',
			            maxmin: true,
			            shadeClose: false, //点击遮罩关闭层 
			            area : ['850px' , '600px'],
			            cancel :false,
			            content: "/sys/content/grouptourList?SUBJECT_ID="+SUBJECT_ID,
			        });
					layer.full(index);
			 }else if(subject_code==2){//普通门票旅游推广
			  var index = layer.open({
		            type: 2,
		            title: '门票列表',
		            maxmin: true,
		            shadeClose: false, //点击遮罩关闭层 
		            area : ['850px' , '600px'],
		            cancel :false,
		            content: "/sys/content/ticketList?SUBJECT_ID="+SUBJECT_ID,
		        });
				layer.full(index); 
			 }
		 }
			function pullGroupTourData(SUBJECT_ID){
				 if(SUBJECT_ID){
					 Ajax.request("/sys/content/pushGrouptourByID",{"data":{"grouptour_id":SUBJECT_ID},"success":function(data){
							if(data.result == 200){
								var data=data.data;
								if(data){
									var html='<table class="center table table-striped table-bordered table-hover">'
										+'<thead><tr><th>线路名称</th><th>线路图片</th><th>线路价格</th><th>联系电话</th><th>游览天数</th><th>线路销量</th></tr></thead>'
										+'<tbody><tr><input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="'+data.grouptour_id+'">'
										+'<td>'+data.grouptour_name+'</td>'
										+'<td><img alt="" width="100px" height="100px" src="${SETTINGPD.IMAGEPATH}'+data.grouptour_img+'"></td>'
										+'<td>'+data.grouptour_price+'</td>'
										+'<td>'+data.grouptour_phone+'</td>'
										+'<td>'+data.grouptour_day+'</td>'
										+'<td>'+data.grouptour_sales+'</td></tr></tbody></table>';
									$(".subjectId").empty().append(html)
								}
							}else{
								alert(data.msg);
							}
						}});
				 }else{
					 alert("系统有误，请联系管理员！")
				 }
			}
			function pullTicketData(SUBJECT_ID){
				 if(SUBJECT_ID){
					 Ajax.request("/sys/content/pushTicketByID",{"data":{"t_id":SUBJECT_ID},"success":function(data){
							if(data.result == 200){
								var data=data.data;
								if(data){
									var html='<table class="center table table-striped table-bordered table-hover">'
										+'<thead><tr><th>票务系统识别码</th><th>景点名字</th><th>票类名称</th><th>类型</th><th>起售价格</th><th>单票/套票</th></tr></thead>'
										+'<tbody><tr><input type="hidden" name="SUBJECT_ID" id="SUBJECT_ID" value="'+data.id+'"></td>'
										+'<td>'+data.third_no+'</td>'
										+'<td>'+data.scenic_name+'</td>'
										+'<td>'+data.ticket_name+'</td>'
										+'<td>'+data.cate_name+'</td>'
										+'<td>'+data.ticket_price+'</td>'
										+'<td>';
										if(data.ticket_package_type == 1){
											html+='<span class="label label-primary">单票</span>';
										}else if(data.ticket_package_type == 2){
											html+='<span class="label label-danger">套票</span>';
										}
										html+='</td></tr></tbody></table>';
									$(".subjectId").empty().append(html)
								}
							}else{
								alert(data.msg);
							}
						}});
				 }else{
					 alert("系统有误，请联系管理员！")
				 }
			}
		  function pushContentAlbumsData(){
			 var contentId = $("#CONTENT_ID").val();
			 if(contentId){
				 Ajax.request("/sys/content/resource/pushContentAlbumsData",{"data":{"CONTENT_ID":contentId},"success":function(data){
						if(data.result == 200){
								var albumsData=data.data;
							if(albumsData){
								//刷新图片数据
								var html='<td style="width:85px;text-align: right;padding-top: 13px;">相册:</td><td>';
								for (var i = 0; i < albumsData.length; i++) {
									html+='<a href="${SETTINGPD.IMAGEPATH}'+albumsData[i].original_img+'" target="_blank"><img  src="${SETTINGPD.IMAGEPATH}'+albumsData[i].original_img+'" style="width: 210px; height: 140px;"/></a>';
								}
								html+='<input type="button" class="btn btn-mini" value="选择相册图片" onclick="addResource('+contentId+')" /></td>';
								$(".albums").empty().append(html);
							}
						}else{
							alert(data.msg);
						}
					}});
			 }else{
				 alert("文章ＩＤ有误，请联系管理员！")
			 }
			 
		  }
		  
		  
		$(function() {
			//上传
			$('#TIMG').ace_file_input({
				no_file:'请选择图片 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'gif|png|jpg|jpeg'
			});
			$('#CIMG').ace_file_input({
				no_file:'请选择图片 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'gif|png|jpg|jpeg'
			});
		});
		//图片过滤类型
		function fileType(obj,tname,type){
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
		    	$("#"+tname).tips({
					side:3,
		            msg:'请上传图片格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#"+tname).val('');
		    	document.getElementById(tname).files[0] = '请选择图片';
		    }else{
				var CONTENT_ID = $("#CONTENT_ID").val();
				var fileSize = getFileSize(obj);
				fileSize=Math.round(fileSize/1024*100)/100; //单位为KB
			    if(fileSize>=3){
			        bootbox.alert("文件最大为3M，请重新上传!");
			        var file = $(obj) 
			        file.after(file.clone().val("")); 
			        file.remove(); 
			        return false;
			    }
				var saveText = $("#save").text();
			    $('#save').text('有文件正在上传中，上传进度见浏览器左下角');
			    $('#save').attr('disabled',"true");
			    $('#saveAndAudit').attr('disabled',"true");
			    /*提交到后台控制器*/
			    $.ajaxFileUpload({  
			        url : '/sys/content/saveImag.do?CONTENT_ID='+CONTENT_ID+'&tname='+tname+'&CATEGORY_TYPE='+type,
			        secureuri : false,  
			        fileElementId : tname,// 上传控件的id  
			        dataType : 'json',  
			        success : function(data, status){
			        	if(data.result == 200){
			        		var data = data.data;
				            var img = '';
			           	    $("#"+data.labname).attr("value",data.path);
			        	    img = "<img src='${SETTINGPD.IMAGEPATH}"+data.path+"' style='width:210px;height:130px'/>";
				            $("#show"+tname).empty();
				            $("#show"+tname).append(img);
						    $('#save').text(saveText);
						    $('#save').removeAttr('disabled');
						    $('#saveAndAudit').removeAttr('disabled');
			        	}else if(data.result != 200){
			        		$("#"+tname).tips({
								side:3,
					            msg:'请检查图片格式',
					            bg:'#AE81FF',
					            time:3
					        });
					    	$("#"+tname).val('');
					    	document.getElementById(tname).files[0] = '请选择图片...';
			        	}
			        },  
			        error : function(data, status, e) {  
			           alert("上传出错");  
			        }  
			    });
		    }
		}
		function clearImg(obj){
			$(obj).remove();
			if($("#showimages").children("div").length==0){
				$("#showimages").empty();
			}
			if($("#showfiles").children("span").length==0){
				$("#showfiles").empty();
			}
		}
		//取文件名不带后缀
        function GetFileNameNoExt(filepath) {
            if (filepath != "") {
                var names = filepath.split("\\");
                var pos = names[names.length - 1].lastIndexOf(".");
                return names[names.length - 1].substring(0, pos);
            }
        }
		//计算文件大小
		function getFileSize(obj){
			var fileSize = 0;
		    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;            
		    if (isIE && !obj.files) {          
		         var filePath = obj.value;            
		         var fileSystem = new ActiveXObject("Scripting.FileSystemObject");   
		         var file = fileSystem.GetFile (filePath);               
		         fileSize = file.Size;         
		    }else {  
		         fileSize = obj.files[0].size;     
		    } 
		    fileSize=Math.round(fileSize/1024*100)/100; //单位为KB
		    return fileSize;
		}
		function delImg(contentId,type){
			Ajax.request("/sys/content/delImg",{"data":{"type":type,"CONTENT_ID":contentId},"success":function(data){
				if(data.result == 200){
					window.location.reload();
				}else{
					alert(data.msg);
				}
			}});
		}
		//查询固顶级别
		function tipMax(obj){
			var column = $("#CATEGORY_ID").val();
			var url = '<%=basePath%>/sys/content/selMaxLv.do'
			$.ajax({type:"post",url:url,dataType:"json",
		           data:{column:column},
		           success:function(data){
		             if("200" == data.result){
		            	 if(data.data.maxlv == 0){
		            		 data.data.maxlv =  $(obj).val();
		            	 }
		            	layer.tips("当前固顶级别最高值："+data.data.maxlv,"#"+obj.id);
		             }else{
		            	layer.msg("获取信息失败");
		             }
		           }
		      });
		}
		
		
		
		</script>
</body>
</html>