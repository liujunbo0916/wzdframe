<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
  <link href="/assets/css/plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
    <link href="/assets/css/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							<c:if test="${not empty dataModel}">编辑</c:if>
							<c:if test="${empty dataModel}">新增</c:if>
							节假日
						</h5>
					</div>
					<div class="ibox-content">
						<form action="/sys/scenic/save" method="post"
							class="form-horizontal m-t" id="commentForm"
							enctype="multipart/form-data">
							<div class="panel-body">
								<input type="hidden" name="id" id="id" value="${dataModel.id}" />
								<div class="form-group">
									<label class="col-sm-2 control-label"><font color="red"
										size="3px" style="font-weight: bold; font-style: italic;">*&nbsp;</font>假期名字：</label>
									<div class="col-sm-6">
										<input type="text" name="scenic_name" id="scenic_name"
											class="form-control" value="${dataModel.scenic_name}" />
									</div>
									<div class="col-sm-2">
										<label class="control-label"><font color="red"
											size="3px" style="font-size: 11px;">1到50个字符&nbsp;</font> </label>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label"><font color="red"
										size="3px" style="font-weight: bold; font-style: italic;">*&nbsp;</font>选择日期：</label>
									<div class="col-sm-6">
										<div class="ibox float-e-margins">
											<div class="ibox-content">
												<div id="calendar" class="fc fc-ltr">
													<table class="fc-header" style="width: 100%">
														<tbody>
															<tr>
																<td class="fc-header-left">
																<span id="monthSub" class="fc-button fc-button-prev fc-state-default fc-corner-left" unselectable="on"><span class="fc-text-arrow">‹</span></span>
																	<span id="monthAdd" class="fc-button fc-button-next fc-state-default fc-corner-right"
																	unselectable="on"><span class="fc-text-arrow">›</span></span>
																	</td>
																<td class="fc-header-center" id="monthShow" data-code="8"><span class="fc-header-title"><h2>八月 </h2></span>
																</td>
																<td class="fc-header-right"></td>
															</tr>
														</tbody>
													</table>
													<div class="fc-content" style="position: relative;">
														<div class="fc-view fc-view-month fc-grid"
															style="position: relative" unselectable="on">
															<table class="fc-border-separate" style="width: 100%"
																cellspacing="0">
																<thead>
																	<tr class="fc-first fc-last">
																		<th
																			class="fc-day-header fc-日 fc-widget-header fc-first"
																			style="width: 85px;">日</th>
																		<th class="fc-day-header fc-一 fc-widget-header"
																			style="width: 85px;">一</th>
																		<th class="fc-day-header fc-二 fc-widget-header"
																			style="width: 85px;">二</th>
																		<th class="fc-day-header fc-三 fc-widget-header"
																			style="width: 85px;">三</th>
																		<th class="fc-day-header fc-四 fc-widget-header"
																			style="width: 85px;">四</th>
																		<th class="fc-day-header fc-五 fc-widget-header"
																			style="width: 85px;">五</th>
																		<th style="width: 85px;"
																			class="fc-day-header fc-六 fc-widget-header fc-last">六</th>
																	</tr>
																</thead>
																<tbody>
																	<tr class="fc-week">
																		<td
																			class="fc-day fc-日 fc-widget-content fc-past fc-first"
																			data-date="2017-08-06"><div
																				style="min-height: 83px;">
																				<div class="fc-day-number">6</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;margin-top:15px;">
																					    <span class="badge badge-warning">￥153</span>
																					</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-一 fc-widget-content fc-past"
																			data-date="2017-08-07"><div>
																				<div class="fc-day-number">7</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-二 fc-widget-content fc-past"
																			data-date="2017-08-08"><div>
																				<div class="fc-day-number">8</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-三 fc-widget-content fc-past"
																			data-date="2017-08-09"><div>
																				<div class="fc-day-number">9</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-四 fc-widget-content fc-past"
																			data-date="2017-08-10"><div>
																				<div class="fc-day-number">10</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-五 fc-widget-content fc-past"
																			data-date="2017-08-11"><div>
																				<div class="fc-day-number">11</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-六 fc-widget-content fc-past fc-last"
																			data-date="2017-08-12"><div>
																				<div class="fc-day-number">12</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																	</tr>
																	<tr class="fc-week">
																		<td
																			class="fc-day fc-日 fc-widget-content fc-past fc-first"
																			data-date="2017-08-13"><div
																				style="min-height: 83px;">
																				<div class="fc-day-number">13</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-一 fc-widget-content fc-past"
																			data-date="2017-08-14"><div>
																				<div class="fc-day-number">14</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-二 fc-widget-content fc-past"
																			data-date="2017-08-15"><div>
																				<div class="fc-day-number">15</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-三 fc-widget-content fc-past"
																			data-date="2017-08-16"><div>
																				<div class="fc-day-number">16</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-四 fc-widget-content fc-past"
																			data-date="2017-08-17"><div>
																				<div class="fc-day-number">17</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-五 fc-widget-content fc-past"
																			data-date="2017-08-18"><div>
																				<div class="fc-day-number">18</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-六 fc-widget-content fc-past fc-last"
																			data-date="2017-08-19"><div>
																				<div class="fc-day-number">19</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 28px;">&nbsp;</div>
																				</div>
																			</div></td>
																	</tr>
																	<tr class="fc-week">
																		<td
																			class="fc-day fc-日 fc-widget-content fc-past fc-first"
																			data-date="2017-08-20"><div
																				style="min-height: 83px;">
																				<div class="fc-day-number">20</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-一 fc-widget-content fc-past"
																			data-date="2017-08-21"><div>
																				<div class="fc-day-number">21</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-二 fc-widget-content fc-past"
																			data-date="2017-08-22"><div>
																				<div class="fc-day-number">22</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-三 fc-widget-content fc-past"
																			data-date="2017-08-23"><div>
																				<div class="fc-day-number">23</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-四 fc-widget-content fc-today fc-state-highlight"
																			data-date="2017-08-24"><div>
																				<div class="fc-day-number">24</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-五 fc-widget-content fc-future"
																			data-date="2017-08-25"><div>
																				<div class="fc-day-number">25</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-六 fc-widget-content fc-future fc-last"
																			data-date="2017-08-26"><div>
																				<div class="fc-day-number">26</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																	</tr>
																	<tr class="fc-week">
																		<td
																			class="fc-day fc-日 fc-widget-content fc-future fc-first"
																			data-date="2017-08-27"><div
																				style="min-height: 83px;">
																				<div class="fc-day-number">27</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-一 fc-widget-content fc-future"
																			data-date="2017-08-28"><div>
																				<div class="fc-day-number">28</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-二 fc-widget-content fc-future"
																			data-date="2017-08-29"><div>
																				<div class="fc-day-number">29</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-三 fc-widget-content fc-future"
																			data-date="2017-08-30"><div>
																				<div class="fc-day-number">30</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td class="fc-day fc-四 fc-widget-content fc-future"
																			data-date="2017-08-31"><div>
																				<div class="fc-day-number">31</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-五 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-01"><div>
																				<div class="fc-day-number">1</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-六 fc-widget-content fc-other-month fc-future fc-last"
																			data-date="2017-09-02"><div>
																				<div class="fc-day-number">2</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 56px;">&nbsp;</div>
																				</div>
																			</div></td>
																	</tr>
																	<tr class="fc-week fc-last">
																		<td
																			class="fc-day fc-日 fc-widget-content fc-other-month fc-future fc-first"
																			data-date="2017-09-03"><div
																				style="min-height: 83px;">
																				<div class="fc-day-number">3</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-一 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-04"><div>
																				<div class="fc-day-number">4</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-二 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-05"><div>
																				<div class="fc-day-number">5</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-三 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-06"><div>
																				<div class="fc-day-number">6</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-四 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-07"><div>
																				<div class="fc-day-number">7</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-五 fc-widget-content fc-other-month fc-future"
																			data-date="2017-09-08"><div>
																				<div class="fc-day-number">8</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																		<td
																			class="fc-day fc-六 fc-widget-content fc-other-month fc-future fc-last"
																			data-date="2017-09-09"><div>
																				<div class="fc-day-number">9</div>
																				<div class="fc-day-content">
																					<div style="position: relative; height: 0px;">&nbsp;</div>
																				</div>
																			</div></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-4 col-sm-offset-3">
										<button class="btn btn-primary" type="button"
											onclick="checkForm();">
											<i class="fa fa-check"></i>&nbsp;&nbsp;提 交&nbsp;&nbsp;
										</button>
										<button class="btn btn-warning" onclick="history.go(-1)">
											<i class="fa fa-close"></i>&nbsp;&nbsp;返 回&nbsp;&nbsp;
										</button>
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
	<script type="text/javascript">
	
	    $(function(){
	    	getMonthDay($("#monthShow").attr("data-code"));
	    });
	    function getMonthDay(month){
	    	Ajax.request("/sys/holiday/calMonth",{"data":{"month":month},"success":function(data){
	    		var htmlAry = [];
	    		if(data.result == 200){
	    			var data = data.data;
	    			for(var i = 1 ; i<= data.dayOfMonth.length ; i++){
	    				if(i % 7 == 1){
	    					htmlAry.push();
	    				}
	    			}
	    		}
	    	}});
	    }
	</script>
</body>
</html>