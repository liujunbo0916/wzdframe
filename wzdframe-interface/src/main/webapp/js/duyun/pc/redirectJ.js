 function goTravelDetail(travel_id){
	 var travelInfo = {
			 id:travel_id
	 }
	 window.open('/travel/route/detail?paramStr='+Base64.encode(JSON.stringify(travelInfo)));
 }
 function goScenicDetail(scenic_id){
		var scenicInfo = {
				id :scenic_id
		}
	window.open("/scenic/detail?paramStr="+Base64.encode(JSON.stringify(scenicInfo)));
}
 function goGoodsDetail(goodsId){
	  var paramObj = {
			  goodsId:goodsId
	  }
	  window.open('/product/detail?paramStr='+Base64.encode(JSON.stringify(paramObj)));
 }
 function goTicketDetail(id){
	   var ticketPatam = {
			   t_id:id
	   }
	   window.open('/ticket/detail?paramStr='+Base64.encode(JSON.stringify(ticketPatam)));
 }
