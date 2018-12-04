
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
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<form action="#" method="post" class="form-horizontal" id="commentForm" enctype="multipart/form-data">
						<!-- 库存id -->
						<input type="hidden" value="${pd.sku_id}" id="sku_id">
						<div class="ibox-content">
							<div class="panel blank-panel">
								<div class="tabs-left">
									<div class="tab-content ">
											<div class="panel-body" id="file">
											    <div class="form-group" id="albumFile">
												    <c:if test="${not empty albumModel}">
												        <c:forEach items="${fn:split(albumModel,',')}" var="album">
														     <div style="float: left;text-align: center; margin-right:20px;">
														        <div>
														        <img src="${SETTINGPD.IMAGEPATH}${album}" height="100" width="200">
														        </div>
														        <%-- <br>
														        <label>${album.img_desc}</label><br> --%>
														        <div>
														        <button class="btn btn-primary" type="button" onclick="removeIMG(this,'${album}')">删除</button>
														        </div>
														     </div>
														</c:forEach>
													</c:if>	
											    </div>
												<div class="form-group">
												<!-- 	<div class="col-sm-4">
														   	<label class="col-sm-6 control-label">图片描述：</label>
														   	<input type="text" name="img_desc" class="form-control"/>
													</div> -->
													<div class="col-sm-8">
														<div class="fileupload fileupload-new" data-provides="fileupload">
															<div class="input-group shangchuan">
																<div class="form-control">
																	<i class="fa fa-file fileupload-exists"></i> <span class="fileupload-preview"></span>
																</div>
																<div class="input-group-btn">
																	<a id="yichu" href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">移除</a> 
																	<span class="btn btn-default btn-file"> 
																		<span class="fileupload-new">选择文件</span> 
																		<span class="fileupload-exists">重新选择</span> 
																		<input id="theFile" name="fileupload" type="file">
																	</span>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-4">
													<button class="btn btn-success btn" type="button" id="upload">
														<i class="fa fa-upload"></i>&nbsp;&nbsp;上传图片&nbsp;&nbsp;
													</button>
													<button class="btn btn-success btn" type="button" id="addInput">
														<i class="fa fa-upload"></i>&nbsp;&nbsp;继续添加&nbsp;&nbsp;
													</button>
												</div>
											</div>
											
								<div class="form-group">
									<div class="col-sm-4 col-sm-offset-3">
										<button class="btn btn-primary" type="button" onclick="callParent();" >
											<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
										</button>
										<button class="btn btn-warning" onclick="closed();">
											<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
										</button>
									</div>
								</div>
							</div>
							</div>
							</div>
							</div>
					</form>
				</div>
			</div>
		</div>

	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	<script src="/assets/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	  var index = parent.layer.getFrameIndex(window.name);	
	  function closed(){
			parent.layer.close(index);
		}
	  //保存图片数组
	 var list = new ArrayList();
	  $(document).ready(function() {
			$("#upload").click(function() {
				//var temp = ["fileupload"];  
				var files = "";
				//获取所有 <input type="file" id="fileupload" name="fileupload" /> 的ID属性值   
				$("input[name=fileupload]").each(function() {
					files = files + $(this).attr("id") + ",";
				})
				//将字符最后一逗号(,)截取掉  
				files = files.substring(0, files.length - 1);
				ajaxFileUpload(files);
			});
            //初始化保存图片的数组
            if('${albumModel}' != '' && '${albumModel}' != 'null'){
            	list.toList('${albumModel}'.split(","));
            }
			$("#addInput").click(function() {
				addInputFile();
			});
		});
	//动态添加组件
		function addInputFile() {
			var fileLength = $("input[name=fileupload]").length + 1; //获取name属性相同的数量
			$("#file").append("<div class='form-group shangchuan'>"
					               /*  + "<div class='col-sm-4'>"
									+ "<label class='col-sm-6 control-label'>图片描述：</label><input type='text' name='img_desc' class='form-control'/>"
									+"</div>" */
									+ "<div class='col-sm-8'>"
									+ "<div class='fileupload fileupload-new' data-provides='fileupload'>"
									+ "<div class='input-group'>"
									+ "<div class='form-control'>"
									+ "<i class='fa fa-file fileupload-exists'></i> <span class='fileupload-preview'></span>"
									+ "</div>"
									+ "<div class='input-group-btn'>"
									+ "<a id='yichu' href='#' class='btn btn-default fileupload-exists' data-dismiss='fileupload'>移除</a> "
									+ "<span class='btn btn-default btn-file'> "
									+ "<span class='fileupload-new'>选择文件</span> "
									+ "<span class='fileupload-exists'>重新选择</span> "
									+ "<input id='theFile"+fileLength+"' name='fileupload' type='file'> </span>"
									+ "</div>" + "</div>" + "</div>" + "</div>");
		}
		//上传图片
		function ajaxFileUpload(temp) {
			$.ajaxFileUpload({
				url : '/sys/goods/goods/upload',
				//secureuri:false,  
				fileElementId : temp,
				dataType : 'json', //返回值类型 一般设置为json
				success : function(data) {
					if(data.result == "200"){
						    var album = data.data.split(",");
							for(var i = 0 ; i < album.length ; i++){
								$("#albumFile").append("<div style='float: left;text-align: center;margin-right:20px'>"
								        +"<div><img src='${SETTINGPD.IMAGEPATH}"+album[i]+"' height='100' width='200'><input type='hidden' name='stock_img' value='"+album[i]+"' /></div>"
								       /*  +"<label>${album.img_desc}</label><br>" */
								        +"<div><button class='btn btn-primary' type='button' onclick=removeIMG(this,'"+album[i]+"')>&nbsp;&nbsp;删除&nbsp;&nbsp;"
								        +" </button></div>"
								    +"</div>"); 
								list.add(album[i]);
						    }
							$(".shangchuan").remove();
					}
				},
				error : function(data) {
					alert(data.msg);
				},
			})
		}
		/*
		 移除未上传的商品图册
		*/
		function  removeIMG(thisObj,album){
			$(thisObj).parent().parent().remove();
			 list.removeValue(album);
		}
		function callParent(){
			if(list.size() > 0){
				Ajax.request("/sys/goods/goods/saveStockImg",{"data":{"img_ary":list.toArray().join(","),"sku_id":$("#sku_id").val()},"success":function(data){
					if(data.result == 200){
						if(list.toArray().length > 5){
							bootbox.alert("最多只能上传5张图片");
							return;
						}
						parent.doImgShow(list.toArray(),$("#sku_id").val());
						closed();
					}
				}});
			}
		}
	</script>
</body>
</html>