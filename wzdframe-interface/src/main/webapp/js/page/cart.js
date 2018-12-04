var Cart = {
		editOrSettle:function(){
			$(".bianji-or-jiesuan").click(function(){
				if($(this).attr("code") == 'bianji'){
					$(".bianji-show").show();
					$(".jiesuan-show").hide();
					$(this).attr("code",'jiesuan');
					$(this).text("完成");
				}else if($(this).attr("code") == 'jiesuan'){
					Cart.computeTotalPrice();
					$(".bianji-show").hide();
					$(".jiesuan-show").show();
					$(this).attr("code",'bianji');
					$(this).text("编辑");
					Cart.optDatabase.batchModify(); //将更改数量提交到数据库
				}
			});
		 },
		 addOrSub:function(){
			//加的效果
				$(".add").click(function(){
					var n=$(this).prev().val();
					var num=parseInt(n)+1;
					if(num==0){return;}
					$(this).prev().val(num);
					$(this).parent().prev().find(".goods-number").text(num);
				});
				//减的效果
				$(".jian").click(function(){
					var n=$(this).next().val();
					var num=parseInt(n)-1;
					if(num==0){return;}
					$(this).next().val(num);
					$(this).parent().prev().find(".goods-number").text(num);
				});
		 },
		 computeTotalPrice:function(){
			 var totalPrice = 0;
			 var  $CheckBox = $(".check-box").find("input[type='checkbox']:checked");
			 for(var i = 0 ; i < $CheckBox.length ; i++){
				 var price = $($CheckBox[i]).parent().next().find(".goods-number").attr("data-price").trim();
				 var number = $($CheckBox[i]).parent().next().find(".goods-number").text().trim();
				 totalPrice += parseFloat(price)*parseFloat(number);
				 
			 }
			 totalPrice = totalPrice.toFixed(2)
			 $("#totalPrice").text(totalPrice);
		 },
		 allChecked:function(){
			 $("#allCheckedInput").click(function(){
				 Cart.doAllChecked($("#allCheckedInput").is(':checked')); 
				 Cart.computeTotalPrice();
			 });
			 $("#allCheckedLable").click(function(){
				 if($("#allCheckedInput").is(":checked")){
					 $("#allCheckedInput").removeAttr("checked");
				 }else{
					 $("#allCheckedInput").prop("checked",true);
				 }
				 Cart.doAllChecked($("#allCheckedInput").is(':checked'));
				 Cart.computeTotalPrice();
			 });
		 },
		 doAllChecked:function(type){
			 var $checkedItem =  $(".checkedItem");
			 for(var i = 0;i < $checkedItem.length ; i++){
				 if(type){
					 if(!$($checkedItem[i]).is(":checked")){
						 $($checkedItem[i]).prop("checked",true);
					 }
				 }else{
					 if($($checkedItem[i]).is(":checked")){
						 $($checkedItem[i]).removeAttr("checked");
					 }
				 }
			 }
		 },
		 checkAllItemChecked:function(){
			 var $checkedItem =  $(".checkedItem");
			 for(var i = 0;i < $checkedItem.length ; i++){
				 if(!$($checkedItem[i]).is(":checked")){
					 return false
				 }
			 }
			 return true;
			 
		 },
		 optDatabase:{
			 createOrder:function(){ //生成订单
				 //请求链接  /wx/order/orderAdd
			 },
			 fzIdNumJson:function(type){
				 var idNumJson = [];
				 var $checkedItem = $(".checkedItem");
				 for(var i = 0 ; i < $checkedItem.length ; i++){
					if(type || $($checkedItem[i]).is(":checked")){
						var idNumItem = {};
						idNumItem.id = $($checkedItem[i]).val();
						idNumItem.num = $($checkedItem[i]).parent().parent().find(".goods-number").text();
						idNumJson.push(idNumItem);
					} 
				 }
				 return idNumJson;
			 },
			 batchDelCart:function(){
				 //将json数组转成  字符
				 var idNumJson = Cart.optDatabase.fzIdNumJson(false);
				 var idsAry = [];
				 for(var i = 0 ;i < idNumJson.length;i++){
					 idsAry.push(idNumJson[i].id);
				 }
				 if(idsAry.length == 0){
					 alert("您还未选择任何商品");
					 return;
				 }
				 Ajax.request("/wx/cart/batchDelete",{"data":{"cart_ids":idsAry.join(",")},"success":function(data){
					 if(data.code == 200){
						 Cart.optDatabase.removeItem(idsAry);
						 if($(".checkedItem").length == 0){
							 window.location.href="/wx/cart/shopCart";
						 }else{
							 alert("成功移除");
						 }
					 }
				 }});
			 },
			 removeItem:function(idsAry){
				 var $checkedItem = $(".checkedItem");
				 for(var j = 0;j<$checkedItem.length;j++){
					 for(var i = 0 ; i < idsAry.length ; i++){
						 if($($checkedItem[j]).val() == idsAry[i]){
							 $($checkedItem[j]).parent().parent().remove();
						 }
					 }
				 }
				 alert($checkedItem.length);
			 },
			 batchModify:function(){
				 var idNumJson = Cart.optDatabase.fzIdNumJson(true);
				 Ajax.request("/wx/cart/batchModify",{"data":{"idsNumJson":JSON.stringify(idNumJson)},"success":function(data){
					 //无任何操作
				 }});
			 },
			 makeSureOrder:function(){
				 var idsAry = [];
				 var idNumJson = Cart.optDatabase.fzIdNumJson(false);
				 for(var i = 0 ;i < idNumJson.length;i++){
					 idsAry.push(idNumJson[i].id);
				 }
				 if(idsAry.length == 0 ){
					alert("您还未选择任何商品");
					 return;
				 }
				 window.location.href="/wx/order/makeSureOrder?type=cartBuy&cartIds="+idsAry.join(",")+"#wechat_redirect";
			 }
		 }
}