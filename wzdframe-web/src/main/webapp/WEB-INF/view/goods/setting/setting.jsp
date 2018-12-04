<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form class="form-horizontal m-t" action="/shopmall/settingAction"
			id="commentForm">
			<div class="row">


				<div class="col-sm-6">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
							<div class="form-group">
								<label class="col-sm-3 control-label">商城积分模式：</label>
								<div class="col-sm-7">
									<c:forEach items="${dataModel}" var="point">
										<c:if test="${point.key eq'00101'}">
											<c:set value="${point.value}" var="pointSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00102'}">
											<c:set value="${point.value}" var="quanSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00103'}">
											<c:set value="${point.value}" var="proportionSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00104'}">
											<c:set value="${point.value}" var="withdrawalsfeeSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00105'}">
											<c:set value="${point.value}" var="withdrawalsdaySet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00106'}">
											<c:set value="${point.value}" var="rechargeSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00107'}">
											<c:set value="${point.value}" var="withdrawalsSet"></c:set>
										</c:if>
										<c:if test="${point.key eq'00108'}">
											<c:set value="${point.value}" var="rechargeratioSet"></c:set>
										</c:if>
											<c:if test="${point.key eq'00109'}">
											<c:set value="${point.value}" var="givePointsSet"></c:set>
										</c:if>
											<c:if test="${point.key eq'00110'}">
											<c:set value="${point.value}" var="limitPayHour"></c:set>
										</c:if>
											<c:if test="${point.key eq'00111'}">
											<c:set value="${point.value}" var="orderCloseTime"></c:set>
										</c:if>
										<c:if test="${point.key eq'00112'}">
											<c:set value="${point.value}" var="servicePhone"></c:set>
										</c:if>
										
									</c:forEach>
									<input type="hidden" value="${pointSet.setting_code}"
										name="point_setting_code" /> <label class="radio-inline">
										<input type="radio"
										<c:if test="${pointSet.setting_value eq 1}">checked="checked"</c:if>
										value="1" name="point_setting_value">开启
									</label> <label class="radio-inline"> <input type="radio"
										value="0"
										<c:if test="${pointSet.setting_value eq 0}">checked="checked"</c:if>
										name="point_setting_value">关闭
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">客服热线（课程咨询，人工服务）：</label>
								<div class="col-sm-7">
									<input type="text" name="servicePhoneValue" id="servicePhoneValue"
										value="${servicePhone.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${servicePhone.setting_code}"
									name="servicePhoneCode" />
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">积分抵扣人民币比例：（人民币：积分）</label>
								<div class="col-sm-2">
									<input type="text" name="proportion_point"
										id="proportion_point"
										value="${fn:split(proportionSet.setting_value,':')[0]}"
										class="form-control">
								</div>
								<input type="hidden" value="${proportionSet.setting_code}"
									name="proportion_setting_code" />
								<div class="col-sm-1">:</div>
								<div class="col-sm-2">
									<input type="text" name="proportion_RMB" id="proportion_RMB"
										value="${fn:split(proportionSet.setting_value,':')[1]}"
										class="form-control">
								</div>
							</div>
								<div class="form-group">
								<label class="col-sm-3 control-label">充值送积分：</label>
								<div class="col-sm-7">
									<input type="hidden" value="${givePointsSet.setting_code}"
										name="givePointsSet_code" /> <label class="radio-inline">
										<input type="radio"
										<c:if test="${givePointsSet.setting_value eq 1}">checked="checked"</c:if>
										value="1" name="givePointsSet_value">开启
									</label> <label class="radio-inline"> <input type="radio"
										value="0"
										<c:if test="${givePointsSet.setting_value eq 0}">checked="checked"</c:if>
										name="givePointsSet_value">关闭
									</label> <input type="hidden" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label">充值送积分比例：（人民币：积分）</label>
								<div class="col-sm-2">
									<input type="text" name="rechargeratio_RMB"
										id="rechargeratio_RMB"
										value="${fn:split(rechargeratioSet.setting_value,':')[0]}"
										class="form-control">
								</div>
								<input type="hidden" value="${rechargeratioSet.setting_code}"
									name="rechargeratio_code" />
								<div class="col-sm-1">:</div>
								<div class="col-sm-2">
									<input type="text" name="rechargeratio_point" id="rechargeratio_point"
										value="${fn:split(rechargeratioSet.setting_value,':')[1]}"
										class="form-control">
								</div>
							
							</div>
								<div class="form-group">
								<label class="col-sm-3 control-label">提现最小金额(元)</label>
								<div class="col-sm-7">
									<input type="text" name="withdrawals" id="withdrawals"
										value="${withdrawalsSet.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${withdrawalsSet.setting_code}"
									name="withdrawals_code" />
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">提现手续费(%)</label>
								<div class="col-sm-7">
									<input type="text" name="withdrawals_fee" id="withdrawals_fee"
										value="${withdrawalsfeeSet.setting_value}" class="form-control">
								</div>
								<input type="hidden" value="${withdrawalsfeeSet.setting_code}"
									name="withdrawalsfee_code" />
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">提现到账时间(天)</label>
								<div class="col-sm-7">
									<input type="number" name="withdrawals_day" id="withdrawals_day"
										value="${withdrawalsdaySet.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${withdrawalsdaySet.setting_code}"
									name="withdrawalsday_code" />
							</div>
								<div class="form-group">
								<label class="col-sm-3 control-label">充值最小金额(元)</label>
								<div class="col-sm-7">
									<input type="text" name="recharge" id="recharge"
										value="${rechargeSet.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${rechargeSet.setting_code}"
									name="recharge_code" />
							<div class="form-group">
								<label class="col-sm-3 control-label">优惠券模式：</label>
								<div class="col-sm-7">
									<input type="hidden" value="${quanSet.setting_code}"
										name="quan_setting_code" /> <label class="radio-inline">
										<input type="radio"
										<c:if test="${quanSet.setting_value eq 1}">checked="checked"</c:if>
										value="1" name="quan_setting_value">开启
									</label> <label class="radio-inline"> <input type="radio"
										value="0"
										<c:if test="${quanSet.setting_value eq 0}">checked="checked"</c:if>
										name="quan_setting_value">关闭
									</label> <input type="hidden" />
								</div>
							</div>
								<div class="form-group">
								<label class="col-sm-3 control-label">下单支付时间（小时）：</label>
								<div class="col-sm-7">
									<input type="number" name="limitPayHour" id="limit_pay_hour"
										value="${limitPayHour.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${limitPayHour.setting_code}"
									name="limitPayHour_code" />
							</div>
							
									<div class="form-group">
								<label class="col-sm-3 control-label">订单关闭时间（天）：</label>
								<div class="col-sm-7">
									<input type="number" name="orderCloseTime" id="order_close_time"
										value="${orderCloseTime.setting_value}"
										class="form-control">
								</div>
								<input type="hidden" value="${orderCloseTime.setting_code}"
									name="orderCloseTime_code" />
							</div>
							
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" onclick="sub();" type="button">
										<i class="fa fa-check"></i>保存
									</button>
								</div>
							</div>
							<!-- 内容 -->
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
</body>
<script type="text/javascript">
	function sub() {
		if (!$("#proportion_point").val().isNumber()
				|| !$("#proportion_RMB").val().isNumber()) {
			bootbox.alert("比例值请输入正整数");
			return;
		}
		$("#commentForm").submit();
	}
</script>
</html>