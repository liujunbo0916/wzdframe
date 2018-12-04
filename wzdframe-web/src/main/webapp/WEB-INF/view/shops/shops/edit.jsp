<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<link href="/statics/css/phone.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<form action="/sys/shops/update" method="post"
				class="form-horizontal m-t" id="commentForm" enctype="multipart/form-data">
				<input type="hidden" value="${dataModel.bs_user_id}"
					name="bs_user_id" />
				<div class="col-sm-13">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>
								<c:if test="${not empty dataModel}">编辑</c:if>
								<c:if test="${empty dataModel}">新增</c:if>
								店铺信息
							</h5>
						</div>
						<div class="ibox-content">
							<input type="hidden" name="bs_id" value="${dataModel.bs_id}" />
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1"
									aria-expanded="true">店铺信息</a></li>
									<li class=""><a data-toggle="tab" href="#tab-2"
									aria-expanded="true">位置信息</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-3 control-label">店铺名称：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_name" name="bs_name"
													class="form-control" value="${dataModel.bs_name}" required />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">邮政编码：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_zip" name="bs_zip"
													class="form-control" value="${dataModel.bs_zip}" required />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">商家电话：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_phone" name="bs_phone"
													class="form-control" value="${dataModel.bs_phone}" required />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">人均价格：</label>
											<div class="col-sm-3">
												<input type="number" id="bs_price" name="bs_price"
													class="form-control"
													value="${dataModel.bs_price}" required />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">销量：</label>
											<div class="col-sm-3">
												<input type="number" id="bs_sellnum" name="bs_sellnum"
													class="form-control"
													value="${dataModel.bs_sellnum}" required />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">线路标签：</label>
											<div class="col-sm-4">
												<input type="text" name="bs_tabs" id="bs_tabs"
													class="form-control" value="${dataModel.bs_tabs}">
											</div>
											<div class="col-sm-3">
												<label class="control-label"><font color="red"
													size="3px" style="font-size: 11px;">标签以逗号(",")分隔</font> </label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>店铺头像：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img    onerror="this.src='/statics/img/no-img.jpg'" 
															src="<c:if test="${!empty dataModel.bs_avatar}">${SETTINGPD.IMAGEPATH}${dataModel.bs_avatar}</c:if>"
															height="100" width="200">
														<!-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} -->
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input id="bs_avatar"
															name="bs_avatar" type="file">
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>店铺logo：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img
															src="<c:if test="${!empty dataModel.bs_logo}">${SETTINGPD.IMAGEPATH}${dataModel.bs_logo}</c:if>"
															height="100" width="200">
														<!-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} -->
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input id="bs_logo"
															name="bs_logo" type="file">
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>店铺横幅：</label>
											<div class="col-sm-8">
												<div class="fileupload fileupload-new"
													data-provides="fileupload">
													<div class="fileupload-new thumbnail"
														style="max-height: 200px;">
														<img
															src="<c:if test="${!empty dataModel.bs_banner}">${SETTINGPD.IMAGEPATH}${dataModel.bs_banner}</c:if>"
															height="100" width="200">
														<!-- <%=basePath%>UploadServlet?getthumb=${dataModel.list_img} -->
													</div>
													<div class="fileupload-preview fileupload-exists thumbnail"
														style="max-height: 200px; line-height: 20px;"></div>
													<div>
														<span class="btn btn-default btn-file"> <span
															class="fileupload-new">选择文件</span> <span
															class="fileupload-exists">重选</span> <input id="bs_banner"
															name="bs_banner" type="file">
														</span> <a href="#" class="btn btn-default fileupload-exists"
															data-dismiss="fileupload">移除</a>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">店铺简述（500字内）：</label>
											<div class="col-sm-3">
												<textarea rows="10" cols="50" name="bs_introduction" id="bs_introduction"
													id="hotel_sketch">${dataModel.bs_introduction}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">店铺信用值：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_credit" name="bs_credit"
													class="form-control" value="${dataModel.bs_credit}"
													/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">服务态度分数：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_servicecredit"
													name="bs_servicecredit" class="form-control"
													value="${dataModel.bs_servicecredit}"  />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">发货速度分数：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_deliverycredit"
													name="bs_deliverycredit" class="form-control"
													value="${dataModel.bs_deliverycredit}"  />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">描述相符度分数：</label>
											<div class="col-sm-3">
												<input type="text" id="bs_desccredit"
													name="bs_desccredit" class="form-control"
													value="${dataModel.bs_desccredit}"  />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">是否自营店铺 ：</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													value="1"
													<c:if test="${dataModel.is_own_shop eq 1}">checked="checked"</c:if>
													name="is_own_shop">是
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${empty dataModel.is_own_shop || dataModel.is_own_shop eq 0}">checked="checked"</c:if>
													name="is_own_shop">否
												</label>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-sm-3 control-label">是否推荐</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.is_recommend || dataModel.is_recommend eq 0}">checked="checked"</c:if>
													value="0" name="is_recommend">关闭
												</label> <label class="radio-inline"> <input type="radio"
													value="1"
													<c:if test="${dataModel.is_recommend eq 1}">checked="checked"</c:if>
													name="is_recommend">人气推荐
												</label>
												<label class="radio-inline"> <input type="radio"
													value="2"
													<c:if test="${dataModel.is_recommend eq 2}">checked="checked"</c:if>
													name="is_recommend">特别推荐
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">是否热门</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.is_hot eq 1}">checked="checked"</c:if>
													value="1" name="is_hot">开启
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${empty dataModel.is_hot || dataModel.is_hot eq 0}">checked="checked"</c:if>
													name="is_hot">关闭
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">正品保障</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.bs_zhping || dataModel.bs_zhping eq 1}">checked="checked"</c:if>
													value="1" name="bs_zhping">开启
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${dataModel.bs_zhping eq 0}">checked="checked"</c:if>
													name="bs_zhping">关闭
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">7天退换</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.bs_qtian || dataModel.bs_qtian eq 1}">checked="checked"</c:if>
													value="1" name="bs_qtian">开启
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${dataModel.bs_qtian eq 0}">checked="checked"</c:if>
													name="bs_qtian">关闭
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">退货承诺</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${empty dataModel.bs_tuihuo || dataModel.bs_tuihuo eq 1}">checked="checked"</c:if>
													value="1" name="bs_tuihuo">开启
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${dataModel.bs_tuihuo eq 0}">checked="checked"</c:if>
													name="bs_tuihuo">关闭
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">店铺状态 ：</label>
											<div class="col-sm-9">
												<label class="radio-inline"> <input type="radio"
													<c:if test="${dataModel.bs_state eq 1}">checked="checked"</c:if>
													value="1" name="bs_state">开启
												</label> <label class="radio-inline"> <input type="radio"
													value="0"
													<c:if test="${empty dataModel.bs_state || dataModel.bs_state eq 0}">checked="checked"</c:if>
													name="bs_state">关闭
												</label>
											</div>
										</div>
										<div class="form-group hideOrShow">
											<label class="col-sm-3 control-label">店铺关闭原因：</label>
											<div class="col-sm-3">
												<textarea placeholder="" name="bs_closed_info"
													id="bs_closed_info" class="form-control">${dataModel.bs_closed_info}</textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-8 col-sm-offset-5">
												<button class="btn btn-primary" type="submit">
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div>
									</div>
								</div>
								<div id="tab-2" class="tab-pane">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label"><font
												color="red" size="3px"
												style="font-weight: bold; font-style: italic;">*&nbsp;</font>详细地址：</label>
											<div class="col-sm-4">
												<textarea rows="2" cols="60" name="bs_address"
													id="bs_address" class="form-control"
													placeholder="请输入店铺的详细地址点击一键定位">${dataModel.bs_address}</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"></label> <input
												type="hidden" name="bs_lng" id="bs_lng"
												value="${dataModel.bs_lng}" /> <input type="hidden"
												name="bs_lat" id="bs_lat"
												value="${dataModel.bs_lat}" />
											<div class="col-sm-4" id="map_show_id"
												style="width: 550px; height: 450px; border: 1px solid gray; margin: auto;">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="button"
													id="location_button">
													<i class="fa fa-check"></i>&nbsp;&nbsp;一键定位&nbsp;&nbsp;
												</button>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-4 col-sm-offset-3">
												<button class="btn btn-primary" type="submit" >
													<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
												</button>
												<button class="btn btn-warning" onclick="history.go(-1)">
													<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
		<script src="http://api.map.baidu.com/api?v=1.3"></script>
	<%@ include file="../../common/foot.jsp"%>
	<script src="/statics/js/util/BaiduMap.js"></script>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
		<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/statics/js/uedit/";</script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8"
		src="/statics/js/uedit/lang/zh-cn/zh-cn.js"></script>
	<!-- 自定义js -->
	<script src="/assets/js/plugins/summernote/summernote.min.js"></script>
	<script src="/assets/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
	
    $(function(){
		$(".fileupload-exists").click(function(){
    		$(this).parents(".fileupload").children().eq(0).remove();
    	});
   });
	
	
	
		if ('${dataModel.bs_state}' == '1') {
			$(".hideOrShow").hide();
		}
		if ('${dataModel.bs_state}' == '0' || '${dataModel.bs_state}' == '') {
			$(".hideOrShow").show();
		}
		//店铺开启关闭
		$(":radio[name='bs_state']").click(function() {
			var value = $(this).val();
			if (value == 1) {
				$(".hideOrShow").hide();
			} else {
				$(".hideOrShow").show();
			}
		});
		
		//得到地图对象
		var map = BaiduMap.getMap("map_show_id");
		if ('${dataModel.bs_address}' != '') {
			BaiduMap.searchByPosition(map, {
				keyword : '${dataModel.bs_address}',
				lngId : "bs_lng",
				latId : "bs_lat"
			}, 12);
		} else {
			var point = new BMap.Point(114.069562, 22.555991);
			map.centerAndZoom(point, 12);
		}
		/*  BaiduMap.searchByAddress(map, "深圳市", 12);  */
		$("#location_button").click(function() {
			BaiduMap.searchByPosition(map, {
				keyword : $("#bs_address").val(),
				lngId : "bs_lng",
				latId : "bs_lat"
			}, 12);
		});
		//详细地址栏失去焦点定位
		$("#bs_address").blur(
				function() {
					if ($("#bs_address").val().isNotEmpty()) {
						if (!$("#bs_lng").val().isNotEmpty()
								|| !$("#bs_lat").val().isNotEmpty()) {
							BaiduMap.searchByPosition(map, {
								keyword : $("#bs_address").val(),
								lngId : "bs_lng",
								latId : "bs_lat"
							}, 12);
						} else {
							if (window.confirm('是否重新定位？')) {
								BaiduMap.searchByPosition(map, {
									keyword : $("#bs_address").val(),
									lngId : "bs_lng",
									latId : "bs_lat"
								}, 12);
							}
						}
					}
				});
	</script>
</body>
</html>