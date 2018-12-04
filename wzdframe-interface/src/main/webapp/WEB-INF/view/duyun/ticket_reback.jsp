<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>退款详情</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="/vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/duyun/tkxq.css">
</head>

<body>
    <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
    <div class="content">
        <!--产品信息-->
        <div class="prod-info">
            <div class="title-wrap">
                <div class="type-name">产品信息</div>
            </div>
            <div class="property-wrap">
                <div class="prod-name"></div>
                <div class="property-item">
                    <span>门票类型：</span>
                    <span id="ticket_type"></span>
                </div>
                <div class="property-item">
                    <span>出行日期：</span>
                    <span id="ticket_date"></span>
                </div>
                <div class="property-item">
                    <span>出行人数：</span>
                    <span id="ticket_num"></span>
                </div>
                 <div class="property-item">
                    <span>票类单价：</span>
                    <span id="ticket_price"></span>
                </div>
            </div>
        </div>
         <div class="prod-info">
            <div class="title-wrap">
                <div class="type-name">订单信息</div>
            </div>
            <div class="property-wrap">
                <div class="property-item">
                    <span>订单号：</span>
                    <span id="ticket_orderNo"></span>
                </div>
                <div class="property-item">
                    <span>订单总额：</span>
                    <span id="ticket_total"></span>
                </div>
                <div class="property-item">
                    <span>可退票：</span>
                    <span id="ticket_nouse"></span>
                </div>
            </div>
        </div>
        <!--出行人-->
        <div class="traveller-info">
            <div class="traveller-add">
                <div>出行人</div>
            </div>
			<!-- <div class="traveller-item">
				<div class="item-label" onclick="selectTraveller(event)">
					<img src="/img/duyun/icons/radio.png" alt="" />出行人
				</div>
				<div class="item-content">
					<div class="traveller-name">乌达</div>
					<div class="traveller-code">445895788956845278（成人）</div>
					<div class="traveller-name">445895788956845278（成人）</div>
				</div>
			</div> -->
        </div>
         <ul class="table-view">
            <li class="table-view-cell">
                <a class="ticket-num">
                  	  退款数量
                    <div class="num-adjust">
                        <div class="adjust-minus" onclick="minus()">
                            <img src="/img/duyun/icons/minus.png" alt="" />
                        </div>
                        <div class="adjust-view" >1</div>
                        <div class="adjust-plus" onclick="plus()">
                            <img src="/img/duyun/icons/plus.png" alt="" />
                        </div>
                    </div>
                </a>
            </li>
            <li class="table-view-cell">
                <a class="ticket-num">
                   	 退款金额
                    <div class="amount">
                        ¥ 40
                    </div>
                </a>
            </li>
        </ul>
        <div class="input-row" style="background-color: white; height: 44px;align-items: center; padding-top: 5px;margin-top: 10px; margin-bottom: 55px">
            <label>退款原因</label>
            <input type="text" id="refund_reson" name="refund_reson" placeholder="请输入退款原因">
        </div>
        <div class="btn-wrap">
            <button class="btn btn-block btn-orange">提交</button>
        </div>
    </div>
    <script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>
	<script type="text/javascript" src="/js/BASE64.js"></script>
    <script type="text/javascript">
	    var adjustView = document.querySelector('.adjust-view');
	    var minus = function () {
	        adjustView.innerText = adjustView.innerText - 1 > 0 ? adjustView.innerText - 1 : 1;
	        getTotalrefund();
	    };
	    var plus = function () {
	        adjustView.innerText ++;
	         if(adjustView.innerText > refundInfo.maxQuantity){
	        	adjustView.innerText --;
	        	alert("不能超过最大退票数")
	        } 
	        getTotalrefund();
	    };
        var selectTraveller = function (ev) {
            var postBtn = document.querySelector('.btn-wrap .btn-orange');
            var self =  ev.target;
            var img = self.hasChildNodes() ? self.childNodes[1] : self;
            if(img.src.indexOf('select') < 0){
                img.src = '/img/duyun/icons/radio_selected.png';
                postBtn.removeAttribute('disabled');
            }else{
                img.src = '/img/duyun/icons/radio.png';
                postBtn.setAttribute('disabled', 'true');
            }
        }
        var price='';
        function getTotalrefund(){
        	$(".amount").html("￥"+(adjustView.innerText*price));
        }
        
    	//加载事件
        $(function(){
        	 requestDetail();
        });
    	
        //请求订单详情数据
        function requestDetail(){
        	   Ajax.request("/wx/order/doticketOrderDetail",{"data":{"id":'${pd.id}','type':1},"success":function(data){
        		   if(data.code == 200){
        			  try{
        				 var data = data.data;
        				 if(data.noUseTicket){
        					 refundInfo.maxQuantity = data.noUseTicket;
        				 }
        				 $("#ticket_nouse").html(data.noUseTicket+"  张");
        				 var travelerInfo = data.traverInfo;
        				 var data =data.dataModel;
        				   if(data){
        					   $(".prod-name").html(data.scenicName+"--"+data.ticketName);
        					   $("#ticket_type").html(data.cateName);
        					   $("#ticket_date").html(data.travelDate);
        					   $("#ticket_num").html(data.quantity + "人");
        					   $("#ticket_price").html("￥"+data.settlementPrice);
        					   price=data.settlementPrice;
        					   $("#ticket_total").html("￥"+data.orderMoney);
        					   refundInfo.orderNo=data.orderNo;
        					   refundInfo.isRealName=data.isRealName;
        					   $("#ticket_orderNo").html(data.orderNo);
        					   // 1未退票  2部分退票  3 全部退票  4申请退票  5退票失败
        					   if(data.refundStatus==1 || data.refundStatus==''){
        						   data.refundStatus="未退票";
        					   }
        					   if(data.refundStatus==2){
        						   data.refundStatus="部分退票";
        					   }
        					   if(data.refundStatus==3){
        						   data.refundStatus="全部退票";
        					   }
        					   if(data.refundStatus==4){
        						   data.refundStatus="申请退票";
        					   }
        					   if(data.refundStatus==5){
        						   data.refundStatus="退票失败";
        					   }
        					   $("#ticket_orderStatus").html(data.refundStatus);
        					    if(data.isRealName == 1){
        						   var traveler='';
        						   var nouse=0;
        						   var use=0;
        						   var reback=0;
        						   for (var i = 0;  i < travelerInfo.length;  i++) {
        							   var reStatus='';
        							   var clickhtml='onclick="selectTraveller(event)"';
        							   var imghtml='src="/img/duyun/icons/radio.png"';
        							   if(travelerInfo[i].quantity !=null && travelerInfo[i].quantity == 1){
        								   reStatus="  (待使用)";
        							   }
        							   if(travelerInfo[i].apply_refund_quantity !=null && travelerInfo[i].apply_refund_quantity == 1){
        								   reStatus="  (退票中)";
        								   clickhtml='';
        								   imghtml='';
        							   }
        							   if(travelerInfo[i].refund_quantity !=null && travelerInfo[i].refund_quantity == 1){
        								   reStatus="  (已退票)";
        								   clickhtml='';
        								   imghtml='';
        							   }
        							   travelerInfo[i].to_name=travelerInfo[i].to_name+reStatus;
        							   
        							   traveler+='<div class="traveller-item"><div class="item-label" '+clickhtml+'>'
        								+'<img data-code="'+travelerInfo[i].ticket_code+'" '+imghtml+' alt="" />出行人'
        								+'</div><div class="item-content">'
        								+'<div class="traveller-name">'+travelerInfo[i].to_name+'</div>'
        								+'<div class="traveller-name">'+travelerInfo[i].ticket_code+'</div>'
        								+'<div class="traveller-name">'+travelerInfo[i].id_cardno+'</div></div></div>';
        						   }
        						   if(traveler){
        							   $(".traveller-info").append(traveler);
        						   }else{
        							   $(".traveller-info").hide();
        						   }
        						   $(".table-view").hide();
        					   }else{
        						   $(".traveller-info").hide();
        					   } 
        					    getTotalrefund();
        					    if(refundInfo.maxQuantity == 0){
        					    	$(".table-view").hide();
        					    	$(".input-row").hide();
        					    	$(".btn-wrap").hide();
        					    }
        				   }
        			  }catch(e){
        			  }
        		   }
        	   }});
        }
        var refundInfo = {
     		   ticketCodes:[], //退票人列表
     		   id:'${pd.id}',
     		   orderNo:'',
     		   refund_quantity:0,
     		   refund_reson:'',
     		   maxQuantity:0,
     		   submitFlag:false,
     		   isRealName:'',
     		   opt:"reback"
        }
        function cancleOrder(){
        	refundInfo.ticketCodes=[];
        	refundInfo.refund_reson=$("#refund_reson").val();
        	 if(refundInfo.refund_reson == null || refundInfo.refund_reson == ''){
    			   alert("退票原因不能为空");
    			   return;
    		  }
        	 if(parseInt(refundInfo.isRealName)){
      		   //实名认证退票 查找用户选择哪一个票号
      		   $(".item-label").find("img").each(function(){
      			   if($(this).attr("src").indexOf("radio_selected") != -1){
      				   refundInfo.ticketCodes.push($(this).attr("data-code"));
      			   }
      		   });
      		   refundInfo.refund_quantity = refundInfo.ticketCodes.length;
      		   if(refundInfo.refund_quantity == 0){
      			   alert("请选择需要退的票");
      			   return;
      		   } 
      	   }else{
      		   refundInfo.refund_quantity = adjustView.innerText;
      		   if(refundInfo.maxQuantity < refundInfo.refund_quantity){
      			   alert("退票数量超过未使用的票数量");
      			   return;
      		   }
      	   }
	       if(!confirm("确认申请该订单退票吗？")){
	        	return;
	       }
          	Ajax.request("/logic/ticket/order/opt",{"data":{"paramStr":Base64.encode(JSON.stringify(refundInfo))},"success":function(data){
        		if(data.code == 200){
        			requestDetail();
        		}else{
        			alert(data.msg)
        		}
        	}});
        }
        $(".btn-wrap").on("click",function(){
        	cancleOrder();
        });

    </script>
</body>
<script src="/vendors/ratchet/js/ratchet.js"></script>
</html>