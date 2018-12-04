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
	<%@ include file="../common/top.jsp"%>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>分销功能设置</h5>
                    </div>
                    <div class="ibox-content">
                        <form action="/sys/rebate/saveConfig" method="post" class="form-horizontal m-t" id="editForm">
                            <div class="form-group">
                            <input type="hidden" value="${dataModel.id }" name="id">
								<label class="col-sm-2 control-label">分销功能：</label>
								<div class="col-sm-10">
									<label class="radio-inline"> 
										<input type="radio" value="1"<c:if test="${dataModel.is_open==1}"> checked="checked"</c:if>	name="is_open" id="goods_sale_type">开启
									</label> 
									<label class="radio-inline"> 
										<input type="radio" value="0"<c:if test="${dataModel.is_open==0}"> checked="checked"</c:if> name="is_open" id="goods_sale_type">关闭
									</label> 
								</div>
							</div>
							<div class="hr-line-dashed" style="margin: 10px 0;"></div>
                            <div id="condition" style="">
								<input type="hidden" name="admin_id" value="${dataModel.admin_id}" />
 								<div class="form-group">
									<label class="col-sm-2 control-label">参数设置：</label>
									<div class="col-sm-10">
		 								<table id="simple-table" class="center table table-hover">
											<thead>
												<tr>
													<th width="150px">级别</th>
													<th>现金分成(%)</th>
												<!-- 	<th>积分分成(%)</th> -->
													<!-- <th>晋升模式</th>
													<th>晋升条件</th> -->
												</tr>
											</thead>
		
											<tbody>
												<tr>
													<td>一级</td>
													<td>
														<input type="number" width="150px" name="rebate_1" class="form-control" value="${dataModel.rebate_1}" required />
													</td>
													<%-- <td>
														<input type="number" width="150px" name="points_1" class="form-control" value="${dataModel.points_1}" required />
													</td> 
													<td>
														<select class="form-control" name="sills_type_1">
															<option value="0">不设门槛</option>
															<option value="1">累计购物满</option>
															<option value="2">单笔购物满</option>
															<option value="3">累计充值满</option>
															<option value="4">单笔充值满</option>
														</select>
													</td>
													<td>
														<input type="number" name="sills_value_1" class="form-control" value="${dataModel.sills_value_1}" required />
													</td> --%>
												</tr>
												<tr>
													<td>二级</td>
													<td>
														<input type="number" width="150px" name="rebate_2" class="form-control" value="${dataModel.rebate_2}" required />
													</td>
													<%-- <td>
														<input type="number" width="150px" name="points_2" class="form-control" value="${dataModel.points_2}" required />
													</td> 
													 <td>
														<select class="form-control" name="sills_type_2">
															<option value="0">不设门槛</option>
															<option value="1">累计购物满</option>
															<option value="2">单笔购物满</option>
															<option value="3">累计充值满</option>
															<option value="4">单笔充值满</option>
														</select>
													</td>
													<td>
														<input type="number" name="sills_value_2" class="form-control" value="${dataModel.sills_value_2}" required />
													</td> --%>
												</tr>
												<tr>
													<td>三级</td>
													<td>
														<input type="number" width="150px" name="rebate_3" class="form-control" value="${dataModel.rebate_3}" required />
													</td>
													<%-- <td>
														<input type="number" width="150px" name="points_3" class="form-control" value="${dataModel.points_3}" required />
													</td>
													 	 <td>
														<select class="form-control" name="sills_type_3">
															<option value="0">不设门槛</option>
															<option value="1">累计购物满</option>
															<option value="2">单笔购物满</option>
															<option value="3">累计充值满</option>
															<option value="4">单笔充值满</option>
														</select>
													</td>
													<td>
														<input type="number" name="sills_value_3" class="form-control" value="${dataModel.sills_value_3}" required />
													</td> 
												</tr>--%>
											</tbody>
										</table>
									</div>
									</div>
								</div>	
	                            <div class="form-group">
	                                <div class="col-sm-4 col-sm-offset-3">
	                                    <button class="btn btn-primary" type="button" onclick="submitForm()"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
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
	<%@ include file="../common/foot.jsp"%>
	<script src="/assets/js/bootstrap-fileupload.js"></script>
	
	<script type="text/javascript">
		function submitForm(){
			app.submitForm("editForm",onSuccess,onError);
		}
		function onSuccess(data){
			app.toast("友情提示：", "修改成功!","success");
		}
		function onError(){
			app.toast("友情提示：", "修改失败!","error");
		}
	</script>
	
</body>
</html>