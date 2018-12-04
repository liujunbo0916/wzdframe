var AppSdk ={
	/**
	 * 判断app类型
	 */
	browser : function(){
		var u = navigator.userAgent;
		if (!!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)
				|| u.indexOf('iPhone') > -1 || u.indexOf('iPad') > -1) {
			return 1;
		}
		if (u.indexOf('Android') > -1 || u.indexOf('Adr') > -1) {
			return 2;
		}
	},
	
	/**
	 * 获取用户信息
	 */
    getUserInfo : function(){
    	var type = this.browser();
    	if(type == 1){
    		IosObj.getUserInfo();
    	}else if(type == 2){
    		AndroidObj.getUserInfo();
    	}
    },
    
    /**
     * 跳转登录界面
     */
    toLoginPage : function(){
    	var type = this.browser();
    	if(type == 1){
    		IosObj.toLoginPage();
    	}else if(type == 2){
    		AndroidObj.toLoginPage();
    	}
    	
    },
    
    /**
     * 跳转新增地址界面
     */
   toAddress : function(){
    	var type = this.browser();
    	if(type == 1){
    		IosObj.toAddress();
    	}else if(type == 2){
    		AndroidObj.toAddress();
    	}
    },
    
    /**
     * 跳转商品详情
     */
    toGoodsDetail : function(goods_id, goods_name){
    	var type = this.browser();
    	if(type == 1){
    		//商品详情
    		IosObj.toGoodsDetail(goods_id, goods_name);
    	}else if(type == 2){
    		//商品详情
    		AndroidObj.toGoodsDetail(goods_id, goods_name);
    	}
    },
    
    /**
     * 打开新的view
     */
    openView : function(url,title){
    	
    	var type = this.browser();
    	if(type == 1){
    		
    		IosObj.openView(url,title);
    	}else if(type == 2){
    		
    		AndroidObj.openView(url,title);
    	}
    },
    
    
}