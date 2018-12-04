<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/top.jsp"%>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>分销奉献列表</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/rebate/giveList" method="post" name="Form"
							id="Form">
							<div class="row">
								<div class="search-condition row">
									<div class="col-md-2">
										<div class="input-group">
											<span class="input-group-addon">下单人</span> <input type="text"
												class="form-control" id="nick_name" name="nick_name" value="${pd.nick_name}">
										</div>
									</div>
									<div class="col-md-2">
										<div class="input-group">
											<span class="input-group-addon">年份：</span> <select id="year"
												name="year" class="form-control input-group">
												<option value=''>----请选择年份----</option>
												<c:forEach items="${months}" var="item">
													<option value="${item}" <c:if test="${pd.year == item}">selected = 'selected'</c:if>>${item}</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-md-2">
										<div class="input-group">
											<span class="input-group-addon">开始月份：</span> <select
												id="startmonth" name="startmonth"
												class="form-control input-group">
												<option value=''>----请选择月份----</option>
												<option value="01" <c:if test="${pd.startmonth == '01'}">selected = 'selected'</c:if>>1月</option>
												<option value="02" <c:if test="${pd.startmonth == '02'}">selected = 'selected'</c:if>>2月</option>
												<option value="03" <c:if test="${pd.startmonth == '03'}">selected = 'selected'</c:if>>3月</option>
												<option value="04" <c:if test="${pd.startmonth == '04'}">selected = 'selected'</c:if>>4月</option>
												<option value="05" <c:if test="${pd.startmonth == '05'}">selected = 'selected'</c:if>>5月</option>
												<option value="06" <c:if test="${pd.startmonth == '06'}">selected = 'selected'</c:if>>6月</option>
												<option value="07" <c:if test="${pd.startmonth == '07'}">selected = 'selected'</c:if>>7月</option>
												<option value="08" <c:if test="${pd.startmonth == '08'}">selected = 'selected'</c:if>>8月</option>
												<option value="09" <c:if test="${pd.startmonth == '09'}">selected = 'selected'</c:if>>9月</option>
												<option value="10" <c:if test="${pd.startmonth == '10'}">selected = 'selected'</c:if>>10月</option>
												<option value="11" <c:if test="${pd.startmonth == '11'}">selected = 'selected'</c:if>>11月</option>
												<option value="12" <c:if test="${pd.startmonth == '12'}">selected = 'selected'</c:if>>12月</option>
											</select>
										</div>
									</div>
									<div class="col-md-2">
										<div  id="endmonthdiv" class="input-group">
											<c:if test="${not empty pd.endmonth}">
											<span class="input-group-addon">结束月份：</span> <select
												id="endmonth" name="endmonth"
												class="form-control input-group">
												<option value=''>----请选择月份----</option>
												<option value="01" <c:if test="${pd.endmonth == '01'}">selected = 'selected'</c:if>>1月</option>
												<option value="02" <c:if test="${pd.endmonth == '02'}">selected = 'selected'</c:if>>2月</option>
												<option value="03" <c:if test="${pd.endmonth == '03'}">selected = 'selected'</c:if>>3月</option>
												<option value="04" <c:if test="${pd.endmonth == '04'}">selected = 'selected'</c:if>>4月</option>
												<option value="05" <c:if test="${pd.endmonth == '05'}">selected = 'selected'</c:if>>5月</option>
												<option value="06" <c:if test="${pd.endmonth == '06'}">selected = 'selected'</c:if>>6月</option>
												<option value="07" <c:if test="${pd.endmonth == '07'}">selected = 'selected'</c:if>>7月</option>
												<option value="08" <c:if test="${pd.endmonth == '08'}">selected = 'selected'</c:if>>8月</option>
												<option value="09" <c:if test="${pd.endmonth == '09'}">selected = 'selected'</c:if>>9月</option>
												<option value="10" <c:if test="${pd.endmonth == '10'}">selected = 'selected'</c:if>>10月</option>
												<option value="11" <c:if test="${pd.endmonth == '11'}">selected = 'selected'</c:if>>11月</option>
												<option value="12" <c:if test="${pd.endmonth == '12'}">selected = 'selected'</c:if>>12月</option>
											</select>
											</c:if>
										</div>
									</div>
									<div class="col-md-2">
										<div class="input-group">
											<button class="btn btn-primary" type="submit">
												<i class="fa fa-search"></i>&nbsp;查询&nbsp;
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="hr-line-dashed" style="margin: 10px 0;"></div>



							<div class="project-list">
								<table id="simple-table"
									class="center table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>下单人</th>
											<th>月份</th>
											<th>奉献现金总额</th>
											<th>奉献上级现金(1|2|3)</th>
											<th>奉献现金总额</th>
											<th>奉献上级积分(1|2|3)</th>
											<th style="width: 150px">更新时间</th>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty dataModel}">
												<c:forEach items="${dataModel}" var="item">
													<tr>
														<td>${item.nick_name}</td>
														<td>${item.month}</td>
														<td>${item.amount}</td>
														<td><c:choose>
																<c:when test="${item.rebate_1 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.rebate_1}
															    </c:otherwise>
															</c:choose> | <c:choose>
																<c:when test="${item.rebate_2 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.rebate_2}
															    </c:otherwise>
															</c:choose> | <c:choose>
																<c:when test="${item.rebate_3 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.rebate_3}
															    </c:otherwise>
															</c:choose></td>
														<td>${item.points_1+item.points_2+item.points_3}</td>
														<td><c:choose>
																<c:when test="${item.points_1 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.points_1}
															    </c:otherwise>
															</c:choose> | <c:choose>
																<c:when test="${item.points_2 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.points_2}
															    </c:otherwise>
															</c:choose> | <c:choose>
																<c:when test="${item.points_3 eq null}">
																	<span class="label label-primary">无</span>
																</c:when>
																<c:otherwise>
															        ${item.points_3}
															    </c:otherwise>
															</c:choose></td>
														<td>${item.last_update}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="7" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="11">
												<div class="dataTables_paginate paging_bootstrap pull-right">
													${page.pageStr}</div>
											</td>
										</tr>
									</tfoot>
								</table>
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
	<!-- 自定义js -->
	<script type="text/javascript">
	$("#startmonth").change(function(){
		var data=$(this).val();
		var html='';
		$("#endmonthdiv").empty();
		if(data=='01'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="02" >2月</option>'+
					'<option value="03" >3月</option>'+
					'<option value="04" >4月</option>'+
					'<option value="05" >5月</option>'+
					'<option value="06" >6月</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='02'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="03" >3月</option>'+
					'<option value="04" >4月</option>'+
					'<option value="05" >5月</option>'+
					'<option value="06" >6月</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='03'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="04" >4月</option>'+
					'<option value="05" >5月</option>'+
					'<option value="06" >6月</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='04'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="05" >5月</option>'+
					'<option value="06" >6月</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='05'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="06" >6月</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='06'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="07" >7月</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='07'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="08" >8月</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='08'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="09" >9月</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='09'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="10" >10月</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='10'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="11" >11月</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		if(data=='11'){
			html='<span class="input-group-addon">结束月份：</span> <select id="endmonth" name="endmonth" class="form-control input-group">'+
					'<option value="">----请选择月份----</option>'+
					'<option value="12" >12月</option>'+
				'</select>';
		}
		$("#endmonthdiv").append(html);
	});
		
	</script>
</body>
</html>