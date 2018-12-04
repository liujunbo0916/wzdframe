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
<link href="/assets/css/bootstrap-fileupload.css" rel="stylesheet">
<%@ include file="../../common/top.jsp"%>
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

.btns-al {
	left: 120px;
}

.sanks-lab {
	text-align: left;
	width: 22%;
}

.sank-lab {
	text-align: right;
	width: 28%;
}

.sank-lab span {
	font-weight: 900;
}

.sank {
	width: 100%;
}
 
 table {
	border-collapse: separate;
	border-spacing: 3px;
} 
</style>
</head>

<body class="gray-bg">
	<form action="/sys/order/orders/save" method="post"	class="form-horizontal" id="commentForm">
		<input type="hidden" name="id" id="id" class="form-control" value="${dataModel.order_id}" />
		<div class="wrapper wrapper-content">
			<div class="row">

				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>基本信息</h5>
						</div>
						<div class="ibox-content">
									
						<table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>下单人</th>
                                    <th>订单状态</th>
                                     <th>下单时间</th>
                                    <th>支付方式</th>
                                    <th>支付状态</th>
                                   
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${dataModel.order_sn}</td>
                                    <td>${dataModel.user_name}</td>
                                    <td>
                                                        <c:if test="${dataModel.order_status==0}">
														<span class="label">待付款</span>
														</c:if> 
														<c:if test="${dataModel.order_status==1}">
														<span class="label label-danger">待确认</span>
														</c:if>
														<c:if test="${dataModel.order_status==2}">
														<span class="label label-purple">配货中</span>
														</c:if> 
														<c:if test="${dataModel.order_status==3}">
														 <span class="label label-danger">待发货</span>
														</c:if> 
														<c:if test="${dataModel.order_status==4}">
														<span class="label label-primary">已发货</span>
														</c:if> 
														<c:if test="${dataModel.order_status==5}">
														<span class="label label-primary">已送达</span>
														</c:if> 
														<c:if test="${dataModel.order_status==6}">
														  <span class="label label-success">交易成功</span>
														</c:if> 
														<c:if test="${dataModel.order_status==7}">
														  <span class="label label-warning">已取消</span>
														</c:if> 
												<%-- 		<c:if test="${dataModel.order_status==8}">
														<span class="label badge-pink">已退货</span>
														</c:if> --%>
                                    </td>
                                     <td>${dataModel.create_time}</td>
                                    <td>
	                                    <c:if test="${dataModel.pay_type == 0}">
										   <span class="label">微信</span>
										</c:if>
	                                    <c:if test="${dataModel.pay_type == 1}">
										   <span class="label">支付宝</span>
										</c:if>
										<c:if test="${dataModel.pay_type == 2}">
										   <span class="label">余额支付</span>
										</c:if>
										<c:if test="${dataModel.pay_type == 3}">
										   <span class="label">公众号支付</span>
										</c:if>
										<c:if test="${empty dataModel.pay_type}">
										   <span class="label">订单尚未支付</span>
										</c:if>
                                    </td>
                                    <td>
                                     <c:if test="${empty dataModel.pay_status || dataModel.pay_status eq 0}">
                                            <span class="label label-warning">待付款</span>
                                     </c:if>
                                      <c:if test="${dataModel.pay_status eq 1}">
                                            <span class="label label-success">已付款</span>
                                     </c:if>
                                       <c:if test="${dataModel.pay_status eq 2}">
                                            <span class="label label-success">已取消</span>
                                     </c:if>
                                      <c:if test="${dataModel.pay_status eq 3}">
                                            <span class="label label-success">已退款</span>
                                     </c:if>
                                           <c:if test="${dataModel.pay_status eq 4}">
                                            <span class="label label-success">退款中</span>
                                     </c:if>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>配送方式</th>
                                    <th>返利状态</th>
                                    <th>赠送积分数量</th>
                                    <th>是否需要发票</th>
                                    <th>发票抬头</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${dataModel.shipping_type}</td>
                                    <td>${dataModel.rebate_status}</td>
                                    <td>${dataModel.give_points}</td>
                                     <td>
                                     <c:choose>
                                       <c:when test="${dataModel.is_mer eq 1}"><span class="badge badge-danger">需要</span></c:when>
                                       <c:otherwise><span class="badge badge-primary">不需要</span></c:otherwise>
                                     </c:choose>
                                     </td>
                                    <td>
                                       <c:choose>
	                                       <c:when test="${empty dataModel.mer_title}"><span class="label">空</span></c:when>
	                                       <c:otherwise>${dataModel.mer_title}</c:otherwise>
	                                     </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>收货人信息</h5>
							<div class="ibox-tools">
								<c:if test="${(dataModel.shipping_status eq 0 ||dataModel.shipping_status eq 2||dataModel.shipping_status eq 3)&&(dataModel.order_status eq 0 || dataModel.order_status eq 3 || dataModel.order_status eq 2)}">
								   <a href="/sys/order/orders/edit?id=${dataModel.order_id}&type=personInfoEdit" class="btn btn-primary btn-xs">&nbsp;编辑</a>
								</c:if>	
							</div>
						</div>
						<div class="ibox-content">
								<div>
						<table class="table table-bordered" style="border-spacing: 0px;">
                            <thead>
                                <tr>
                                    <th>收货人</th>
                                    <th>联系手机</th>
                                    <th>收货地址</th>
                                     <th>用户备注</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${dataModel.contact_name}</td>
                                    <td>${dataModel.contact_phone}</td>
                                    <td><span>[${dataModel.province}，
														${dataModel. city}， ${dataModel. area}]${dataModel. address}</span></td>
														   <td>
                                     <c:choose>
                                       <c:when test="${empty dataModel.user_note}"><span class="label">空</span></c:when>
                                       <c:otherwise>${dataModel.user_note}</c:otherwise>
                                     </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>	
								</div>
						</div>
					</div>
				</div>

				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>商品信息</h5>
						</div>
						<div class="ibox-content">
										<table class="table table-bordered" style="border-spacing: 0px;">
                            <thead>
                                <tr>
                                    <th>商品名称 [ 品牌 ]</th>
                                    <th>商品货号</th>
                                    <th>商品数量</th>
                                    <th>商品价格（单价）</th>
                                    <th>商品属性</th>
                                    <th>商品状态</th>
                                    <th>小计</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                     			<c:forEach items="${goodsList}" var="item">
													<tr>
														<td><a href="/sys/goods/goods/listPage?goods_id=${item.goods_id}">${item.goods_name}</a></td>
														<td>${item.goods_sn}</td>
														<td>${item.goods_count}</td>
														<td>${item.goods_price}</td>
												<%-- 		<td>
																<c:if test="${item.is_gift eq 1}">是</c:if>
																<c:if test="${empty item.is_gift || item.is_gift eq 0}">否</c:if>
														</td> --%>
														<td><div align="center">${item.goods_attr}</div></td>
														<td><div align="center">
														<c:choose>
														   <c:when test="${item.is_refund eq 1}"><span class="badge badge-danger">已退货</span></c:when>
														   <c:otherwise><span class="badge badge-info">正常</span></c:otherwise>
														</c:choose>
                                                    </div></td>
														<td><div align="center">${item.goods_price*item.goods_count}</div></td>
														<td>
														<c:if test="${item.is_refund ne 1 && dataModel.order_status eq 5 && (dataModel.shipping_status eq 5 || dataModel.shipping_status eq 6)}">
														   <button type="button" onclick="refundGoods('${item.order_goods_id}','${dataModel.order_id}')" class="btn btn-w-m btn-danger">退货</button>
														</c:if>
														</td>
													</tr>
												</c:forEach>
                            </tbody>
                        </table>	
						</div>
					</div>
				</div>
			  <c:if test="${not empty invoice}">	
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>发货单信息</h5>
								<div class="ibox-tools">
								<c:if test="${(dataModel.shipping_status eq 4 ||dataModel.shipping_status eq 5||dataModel.shipping_status eq 6)&&(dataModel.order_status eq 4 || dataModel.order_status eq 5)}">
								   <a href="javascript:watchTrack('${dataModel.order_id}');" class="btn btn-primary btn-xs">&nbsp;查看物流</a>
								</c:if>	
							</div>
						</div>
						<div class="ibox-content">
							<table class="table table-bordered" style="border-spacing: 0px;">
                                <tbody>
                                <tr>
                                    <td>货运单号：${invoice.bill_no}</td>
                                    <td>配送公司：${invoice.ex_name}</td>
                                    <td>配送金额：${invoice.ex_money}</td>
                                </tr>
                            </tbody>
                        </table>	
						</div>
					</div>
				</div>
				</c:if>
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>费用信息</h5>
							 <div class="ibox-tools">
							 <c:if test="${empty dataModel.pay_status || dataModel.pay_status eq 0 && empty dataModel.order_status ||dataModel.order_status==0}">
								<a
									href="/sys/order/orders/edit?id=${dataModel.order_id}&type=costInfoEdit"
									class="btn btn-primary btn-xs">&nbsp;编辑</a>
							 	</c:if>
							</div>
						</div>
						<div class="ibox-content">
							<div class="panel blank-panel">
								<div>
						<table class="table table-bordered" style="border-spacing: 0px;">
                            <tbody>
                                <tr>
                                    <td><strong>平台</strong></td>
                                    <td>商品总额：${dataModel.goods_money}</td>
                                    <td>公司配送费用：${dataModel.shipping_fee}</td>
                                    <td>分销返利金额：${dataModel.rebate_money}</td>
									<td>支付手续费：${dataModel.pay_fee}</td>
									<td>公司发票费：${dataModel.mer_invoice}</td>
									<td>实际支出：${dataModel.goods_money+
														dataModel.shipping_fee+dataModel.rebate_money+
														dataModel.pay_fee+dataModel.mer_invoice}</td>
                                </tr>
                                <tr>
                                    <td><strong>用户：</strong></td>
                                    <td>商品总额：${dataModel.goods_money}</td>
                                    <td>使用积分支付金额：${dataModel.pay_by_points}</td>
                                    <td>分销返利金额：${dataModel.rebate_money}</td>
									<td>快递费（非免运费商品）：${dataModel.shipping_money}</td>
									<td>订单总金额：${order_money}</td>
									<td>实际待支付金额: ${dataModel.pay_by_money}</td>
                                </tr>
                            </tbody>
                        </table>	
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>操作信息</h5>
					<!-- 	<div class="ibox-tools">
							<a href="" class="btn btn-primary btn-xs">&nbsp;编辑</a>
						</div> -->
					</div>
					<div class="ibox-content">
						<div class="panel blank-panel">
							<div>
								<div class="panel-body">
									<table  class="table table-bordered"  >
										<tbody>
											<tr>
												<td><div align="right">
														<strong>操作备注：</strong>
													</div></td>
												<td colspan="5"><textarea id="action_note"
														name="action_note" cols="80" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>
													<div align="right"></div>
													<div align="right">
														<strong>当前可执行操作：</strong>
													</div>
												</td>
												<td colspan="5" >
													<c:if test="${dataModel.pay_status=='0' && dataModel.shipping_status=='0'&& dataModel.order_status=='0'}">
														<input type="button" onclick="javascript:state('pay');" class="btn btn-primary btn-xs " value="设为已付款">
													</c:if>
													<c:if test="${dataModel.pay_status=='1' && (dataModel.shipping_status=='2'||dataModel.shipping_status=='3')&& (dataModel.order_status=='2' || dataModel.order_status=='3')}">
														<input type="button" class="btn btn-primary btn-xs " onclick="javascript:state('nopay');" value="&nbsp;设为未付款">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='1'&& dataModel.order_status=='1' }">
														<input type="button" onclick="javascript:state('confirmOrder');" class="btn btn-primary btn-xs " value="&nbsp;确认订单">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='2'&& dataModel.order_status=='2'}">
														<input type="button" onclick="javascript:state('finishCargo');" class="btn btn-primary btn-xs " value="&nbsp;配货完成">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='3'&& dataModel.order_status=='3'}">
														<input type="button" onclick="javascript:state('goCargo');" class="btn btn-primary btn-xs " value="&nbsp;去发货">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='4'&& dataModel.order_status=='4'}">
														<input type="button" onclick="javascript:state('cancelCargo');" class="btn btn-primary btn-xs " value="&nbsp;取消发货">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='4'&& dataModel.order_status=='4'}">
														<input type="button" onclick="javascript:state('endDelivery');" class="btn btn-primary btn-xs " value="&nbsp;已送达">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='5'&& dataModel.order_status=='5'}">
														<input type="button" onclick="javascript:state('signFor');" class="btn btn-primary btn-xs " value="&nbsp;签收">
													</c:if> 
													<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='6'&& dataModel.order_status=='5'}">
														<input type="button" onclick="javascript:state('confirmReceipt');" class="btn btn-primary btn-xs " value="&nbsp;确认收货">
													</c:if> 
													<%-- <c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='6'&& dataModel.order_status=='6'}">
														<input type="button" onclick="javascript:state('refundIn');" class="btn btn-primary btn-xs " value="&nbsp;退款中">
													</c:if>  --%>
												<%-- 	<c:if test="${dataModel.pay_status=='4' && dataModel.shipping_status=='6'&& dataModel.order_status=='5'}">
														<a href="/sys/order/orders/selectSingle?id=${dataModel.order_id}" class="btn btn-primary btn-xs ">退款完成</a>
													</c:if>  --%>
												<%-- 	<c:if test="${dataModel.pay_status=='1' && dataModel.shipping_status=='6'&& dataModel.order_status=='5'}">
														<input type="button" onclick="javascript:state('noCargo');" class="btn btn-primary btn-xs " value="&nbsp;退货">
													</c:if>  --%>
													<c:if test="${(dataModel.pay_status=='0'||dataModel.pay_status=='1'||dataModel.pay_status=='2'||dataModel.pay_status=='3') 
																&& (dataModel.shipping_status=='0'|| dataModel.shipping_status=='1' ||dataModel.shipping_status=='2'||dataModel.shipping_status=='3')
																&& (dataModel.order_status=='0'||dataModel.order_status=='1' ||dataModel.order_status=='2'||dataModel.order_status=='3')}">
														<input type="button" onclick="javascript:state('cancelOrder');" class="btn btn-primary btn-xs " value="&nbsp;取消订单">
													</c:if> 
												</td>
											</tr>
											<tr>
												<td><div align="center">
														<strong>操作者：</strong>
													</div></td>
												<td><div align="center">
														<strong>操作时间</strong>
													</div></td>
												<td><div align="center">
														<strong>订单状态</strong>
													</div></td>
												<td><div align="center">
														<strong>付款状态</strong>
													</div></td>
												<td><div align="center">
														<strong>发货状态</strong>
													</div></td>
												<td><div align="center">
														<strong>操作人员备注</strong>
													</div></td>
												<td><div align="center">
														<strong>系统备注</strong>
													</div></td>
											</tr>
											<c:forEach items="${logList}" var="item">
												<tr>
													<td><div align="center">${item.creator}</div></td>
													<td><div align="center">${item.create_time}</div></td>
													<td><div align="center">
														<c:if test="${item.order_status==0}">待付款</c:if>
														<c:if test="${item.order_status==1}">待确认</c:if>
														<c:if test="${item.order_status==2}">配货中</c:if>
														<c:if test="${item.order_status==3}">待发货</c:if>
														<c:if test="${item.order_status==4}">已发货</c:if>
														<c:if test="${item.order_status==5}">已送达</c:if>
														<c:if test="${item.order_status==6}">交易成功</c:if>
														<c:if test="${item.order_status==7}">已取消</c:if>
														<c:if test="${item.order_status==8}">已退货</c:if>
													</div></td>
													<td><div align="center">
														<c:if test="${item.pay_status==0}">待付款</c:if>
														<c:if test="${item.pay_status==1}">已付款</c:if>
														<c:if test="${item.pay_status==2}">已取消</c:if>
														<c:if test="${item.pay_status==3}">已退款</c:if>
														<c:if test="${item.pay_status==4}">退款中</c:if>
													</div></td>
													<td><div align="center">
														<c:if test="${item.shipping_status==0}">待付款</c:if>
														<c:if test="${item.shipping_status==1}">待配货</c:if>
														<c:if test="${item.shipping_status==2}">配货中</c:if>
														<c:if test="${item.shipping_status==3}">待发货</c:if>
														<c:if test="${item.shipping_status==4}">已发货</c:if>
														<c:if test="${item.shipping_status==5}">已送达</c:if>
														<c:if test="${item.shipping_status==6}">已签收</c:if>
														<c:if test="${item.shipping_status==7}">已取消</c:if>
														<c:if test="${item.shipping_status==8}">已退货</c:if>
													</div></td>
													<td><div align="center">${item.auto_note}</div></td>
													<td><div align="center">${item.log_note}</div></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								 <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-5">
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
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script type="text/javascript">
		function state(type) {
			var data = [{"name":"pay","ali_name":"已付款"},{"name":"nopay","ali_name":"未付款"},
			                {"name":"finishCargo","ali_name":"配货完成"},{"name":"goCargo","ali_name":"去发货"},
			                {"name":"cancelCargo","ali_name":"取消发货"}, {"name":"endDelivery","ali_name":"已送达"}
			                , {"name":"signFor","ali_name":"签收"}
			                , {"name":"noCargo","ali_name":"售后"}
			                , {"name":"cancelOrder","ali_name":"取消订单"}
			                ,{"name":"confirmReceipt","ali_name":"确认收货"}
			                ,{"name":"confirmOrder","ali_name":"确认订单"}
			                ];
			var title = "";
			for(var o in data){
				if(data[o].name == type){
					title = data[o].ali_name;
					break;
				}
			}
			var action_note = $("#action_note").val();
			var id = $("#id").val();
			if(type == "goCargo"){
				var index = layer.open({
					  type: 2,
					  title: '<font color="gray" size="3px"><strong>'+title+' </strong></font>',
					  content: "/sys/order/orders/genPage?order_id=${dataModel.order_id}&action_note="+action_note,
					  area: ['800px', '495px'],
					  maxmin: true
					});
			}else{
				bootbox.confirm("您确定"+title+"该订单吗",function(result){
					if(result){
						$.ajax({
							type : "post",
							url : "/sys/order/orders/save?type=" + type + "&action_note="
									+ action_note + "&id=" + id,
							dataType : "json",
							complete : function() {
								window.location.href = "/sys/order/orders/edit?id=" + id;
							}
						});
					}
				});
			}
		}
		
		//查看物流
		function watchTrack(order_id){
			var index = layer.open({
				  type: 2,
				  title: '<font color="gray" size="3px"><strong>物流跟踪 </strong></font>',
				  content: "/sys/order/orders/watchTrack?order_id=${dataModel.order_id}",
				  area: ['800px', '495px'],
				  maxmin: true
		    });
		}
	 function refundGoods(orderGoodsId,orderId){
		 var index = layer.open({
			  type: 2,
			  title: '<font color="gray" size="3px"><strong>退货 </strong></font>',
			  content: "/sys/order/refund/refundMoneyPage?order_id="+orderId+"&order_goods_id="+orderGoodsId,
			  area: ['800px', '495px'],
			  maxmin: true
	    });
	 }	
</script>
</body>
</html>