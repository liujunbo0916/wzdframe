<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../common/top.jsp"%>
<style type="text/css">
  .imgItem{
     height:35px;
     float:left;
     margin-left:15px;
     margin-top:3px;
  }
</style>


</head>
<body class="no-skin" >
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<form  name="setStockForm" id="setStockForm" method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:300px;padding-top: 13px;">产品规格:</td>
											<td style="width: 300px;padding-top: 13px;">图片（最多5张 宽高比1：1）:</td>
											<td style="padding-top: 13px;">成本价格:</td>
											<td style="padding-top: 13px;">销售价格:</td>
											<td style="padding-top: 13px;">市场价格:</td>
											<!-- <td style="padding-top: 13px;">物流重量（kg）:</td> -->
											<td style="padding-top: 13px;">库存数:</td>
										</tr>
										<c:forEach items="${stocks}" var="item" varStatus="gas">	
											  <tr>
												 <td style="width:79px;padding-top: 13px;">${item.attr_json}
												    <input type="hidden" name="stocks[${gas.index}].sku_id" value="${item.sku_id}"  />
												    <input type="hidden" name="stocks[${gas.index}].goods_id" value="${item.goods_id}"  />
												 </td>
												  <td id="imgShow${item.sku_id}">
												     <c:if test="${not empty item.img_ary}">
												         <c:set value="${fn:split(item.img_ary,',')}" var="imgAry"></c:set>
													     <c:forEach items="${imgAry}" var="img" varStatus="imgStatus">
													         <div class="imgItem"><img alt="" style="width:50px;height:50px;border:1px solid #e5e6e7;" src="${SETTINGPD.IMAGEPATH}${img}"> </div>
													     </c:forEach>
												     </c:if>
												     <div  class="imgItem" style="width:50px;height:50px;"><button class="btn btn-default" onclick="uploadImg('${item.sku_id}','${item.goods_id}','imgShow${item.sku_id}');" type="button"><span class="bold">相册</span></button></div>
												     <div style="clear:both;"></div>
												  </td>
												 <td>
												    <div class="col-md-6">
			                                            <input type="text" placeholder="成本价格" name="stocks[${gas.index}].cost_price"  value="${item.cost_price}"  class="form-control cbjg">
			                                        </div>
												 </td>
												 <td>
												    <div class="col-md-12">
			                                            <input type="text" placeholder="销售价格" name="stocks[${gas.index}].price"  value="${item.price}"  class="form-control">
			                                        </div>
												 </td>
												 <td>
												 <div class="col-md-12">
			                                            <input type="text" placeholder="市场价格" name="stocks[${gas.index}].market_price"  value="${item.market_price}"  class="form-control">
			                                        </div>
												 </td>
											<%-- 	 <td>
												  <div class="col-md-12">
			                                            <input type="text" placeholder="物流重量" name="stocks[${gas.index}].logistics_weight"  value="${item.logistics_weight}"  class="form-control">
			                                        </div>
												</td> --%>
												 <td>
												  <div class="col-md-12">
			                                            <input  type="number" placeholder="库存量" name="stocks[${gas.index}].stock"  value="${item.stock}"  class="form-control">
			                                        </div>
												 </td>
											  </tr>
										</c:forEach>	
									</table>
								</div>
								<!-- <div id="zhongxin2" class="center" style="display:none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div> -->
								<div class="form-group">
	                                <div class="col-sm-4 col-sm-offset-5">
	                                    <button class="btn btn-primary" type="button"  onclick="save_stock()"><i class="fa fa-check"></i>&nbsp;&nbsp;提   交&nbsp;&nbsp; </button>
	                                    <button class="btn btn-warning" type="button"  onclick="closed()"><i class="fa fa-check"></i>&nbsp;&nbsp;取   消&nbsp;&nbsp; </button>
	                                </div>
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
	<%@ include file="../../common/foot.jsp"%>
</body>
<script type="text/javascript">

   var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
  function closed(){
	  parent.layer.close(index);
   }
	//保存库存
	function save_stock(){
		 $.post( 
				 "/sys/goods/goods/setStock",
				 $("#setStockForm").serialize(),
				 function(data){
		             if(data.result == "200"){
		                 bootbox.alert(data.msg);
		             }else if(data.result == "205"){
		            	 bootbox.alert(data.msg);
		             }
		             //添加数据成功，关闭弹出窗之前，刷新列表页面的数据
		             parent.window.location.href='/sys/goods/goods/listPage';
		             closed();
	         });
	}
	
	function checkInput(){
	   var priceFlag = true,stockNumFlag=true,warning = true;
	   $(".stock_price").each(function(index,item){
	   
	       if(!regular.checkMoney($(this).val())){
	          $(this).tips({
					side:1,
		            msg:'请输入正确的金额',
		            bg:'#AE81FF',
		            time:2
		        });
		        priceFlag = false;
	       }
	   });
		$(".stock_num").each(function(){
		   if(!regular.checkNumber($(this).val())){
		     $(this).tips({
						side:1,
			            msg:'请输入正整数',
			            bg:'#AE81FF',
			            time:2
			        });
			        stockNumFlag = false;
		   } 
		});
		
		$(".stock_warning").each(function(){
		   if(!regular.checkNumber($(this).val())){
		     $(this).tips({
						side:1,
			            msg:'请输入正整数',
			            bg:'#AE81FF',
			            time:2
			        });
			        warning = false;
		   } 
		});
		 return priceFlag&&stockNumFlag&&warning;
	}
	//上传库存商品图片
	function  uploadImg(stockId,goodsId){
		var index = layer.open({
            type: 2,
            title: '上传库存图片',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['850px' , '600px'],
            content: "/sys/goods/goods/toUploadStockImg?sku_id="+stockId
        });
		//layer.full(index);
	}
	//子页面调用方法  参数图片数组
	function doImgShow(imgArys,stuId){
		if(imgArys.length > 0){
			$("#imgShow"+stuId+"").children(".imgItem").remove();
			var html = "";
			for(var i = 0 ; i < imgArys.length ; i++){
				html += '<div class="imgItem"><img alt="" style=" border:1px solid #e5e6e7;" width="50px;" src="${SETTINGPD.IMAGEPATH}'+imgArys[i]+'"> </div>';
		    }
			$("#imgShow"+stuId+"").append(html);
		}
	}
	//子页面回调父页面得方法  用于动态请求  照片数据
	function  callBackChildPage(sku_id){
		Ajax.request("/sys/goods/goods/stockById",{"data":{"sku_id":sku_id},"success":function(data){
			if(data.result == 200){
				var imgs = data.data.img_ary;
				var sku_id = data.data.sku_id;
				if(imgs){
					imgs = imgs.split(",");
					var appendHtmlAry = [];
					for(var i = 0 ; i < imgs.length ; i++){
						appendHtmlAry.push('<div class="imgItem"><img alt="" style="width:50px;height:50px;border:1px solid #e5e6e7;" src="${SETTINGPD.IMAGEPATH}'+imgs[i]+'"> </div>');
					}
					appendHtmlAry.push('<div  class="imgItem" style="width:50px;height:50px;"><button class="btn btn-default" onclick="uploadImg('+sku_id+','+data.data.goods_id+');" type="button"><span class="bold">相册</span></button></div> <div style="clear:both;"></div>');
					$("#imgShow"+sku_id).html(appendHtmlAry.join(""));	
				}
			}
		}});
	}
</script>
</html>