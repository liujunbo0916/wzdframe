var responseData = {};

responseData.requestData={
		currentPage:1,
		pageSize:15,
		totalPage:0
}
responseData.buildFtl=function(ftl,dataAry){
	//创建一个新字符串
	var tempFtl = new String(ftl);
	for(var i = 0 ; i < dataAry.length ; i++){
		tempFtl = tempFtl.replace("{{"+i+"}}",dataAry[i]);
	}
	return tempFtl;
}
responseData.sendRequest = function(url,condition,callFun){
	//构建请求条件
	if(condition){
		for(var i in condition){
			var tmpName = i;
			var tmpValue = condition[i];
			responseData.requestData[tmpName] = tmpValue;
		}
	}
	if(responseData.requestData.currentPage == responseData.requestData.totalPage){
		$(".load-more").hide();
		loadingPanel.style.display = 'none';
	}else{
		$(".load-more").show();
	}
	Ajax.request(url,{"data":responseData.requestData,"success":function(data){
		loadingPanel.style.display = 'none';
		if(data.code == 200){
			var data = data.data;
			responseData.requestData.currentPage = data.currentPage;
			responseData.requestData.totalPage = data.totalPage;
		    callFun(data);
		    if(responseData.requestData.totalPage == 1 || responseData.requestData.totalPage == 0){
		    	$(".load-more").hide();
		    }else{
		    	responseData.requestData.currentPage++;
		    }
		}else{
			alert(data.msg);
		}
	}});
}