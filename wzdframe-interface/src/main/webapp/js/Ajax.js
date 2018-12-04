/*Ajax =
function(){
    function request(url,opt){
        function fn(){}
        var async   = opt.async !== false,
            method  = opt.method    || 'GET',
            data    = opt.data      || null,
            success = opt.success   || fn,
            failure = opt.failure   || fn;
            method  = method.toUpperCase();
        if(method == 'GET' && data){
            url += (url.indexOf('?') == -1 ? '?' : '&') + data;
            data = null;
        }
        var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
        xhr.onreadystatechange = function(){
            _onStateChange(xhr,success,failure);
        };
        xhr.open(method,url,async);
        if(method == 'POST'){
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded;');
        }
        xhr.send(data);
        return xhr;
    }
    function _onStateChange(xhr,success,failure){
        if(xhr.readyState == 4){
            var s = xhr.status;
            if(s>= 200 && s < 300){
                success(JSON.parse(xhr.responseText));
            }else{
                failure(JSON.parse(xhr.responseText));
            }
        }else{}
    }
    return {request:request};  
}();
/**
 * 调用示例
 * 
 *Ajax.request('/school/provinceList.do',{
 *       data : null,
 *       method:'post',
 *       success : function(xhr){
 *      	alert(xhr.result);
 *       },
 *       failure : function(xhr){
 *       }
 *   }
 *  );
 * 
 */
Ajax =
	 function(){
	     function request(url,opt){
	         function fn(){}
	         var async   = opt.async !== false,
	             method  = opt.method    || 'GET',
	             data    = opt.data      || null,
	             success = opt.success   || fn,
	             failure = opt.failure   || fn;
	             method  = method.toUpperCase();
	             $.ajax({
	    	         type: method,
	    	         url: url,
	    	         data: data,
	    	         dataType: "json",
	    	         contentType: "application/x-www-form-urlencoded; charset=utf-8", 
	    	         success: function(data){
	    	        	 if(data.result == "204"){
	    	        		 window.location.href="/user/login.do";
	    	        	 }else{
	    	        		 success(data);
	    	        	 }
	    	         },
	    	         failure : function(data){
	    	        	 failure(data);
	    	        }
	    	     }); 
	     }
	     return {request:request};
}();

var GoBackBtn = {
		pushHistory : function() {
			var state = {
				title : "title",
				url : "#"
			};
			window.history.pushState(state, "title", "#");
		},
		excuteHistory : function(backUrl) {
			GoBackBtn.pushHistory();
			setTimeout(function() {
				window.addEventListener("popstate", function(e) {
					if(backUrl == "close"){
						WeixinJSBridge.call('closeWindow');
					}else{
						window.location.href = backUrl;
					}
				}, false);
			}, 300);
		}
	}
