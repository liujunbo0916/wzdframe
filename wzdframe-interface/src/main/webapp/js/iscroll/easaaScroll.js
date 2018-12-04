var myScroll,
	   pullDownEl, pullDownOffset,
	   pullUpEl, pullUpOffset,
	   generatedCount = 0;
var easaaScroll = function(pullUpAction,pullDownAction,currentPageLength){
	pullUpAction = pullUpAction || function(){alert("请传入要操作的上啦函数");}
	pullDownAction = pullDownAction || function(){ alert("请传入要操作的下拉函数");};
	window.addEventListener('load', function(){
		loaded(pullUpAction,pullDownAction,currentPageLength);
	}, false);
}
function loaded(pullUp,pullDown,currentPageLength){
	   pullDownEl = document.getElementById('pullDown');
	   pullDownOffset = pullDownEl.offsetHeight;
	   pullUpEl = document.getElementById('pullUp'); 
	   pullUpOffset = pullUpEl.offsetHeight;
	   setTimeout(function () {
		   myScroll = new iScroll('wrapper',{
                mouseWheel: true,
                scrollbars: true,
                topOffset:pullDownOffset,
                onScrollEnd:function(){
                	//这里写自己的加载数据逻辑
                	if (pullDownEl.className.match('flip')) {
						    pullDownEl.className = 'loading';
						    pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';    
						    pullDown(); // Execute custom function (ajax call?)
					} else if (pullUpEl.className.match('flip')) {
						    pullUpEl.className = 'loading';
						    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';    
						    pullUp(); // Execute custom function (ajax call?)
					}
                },
                onScrollMove: function () {
	                   if(currentPageLength > 6 && (this.y > 30 && !pullDownEl.className.match('flip'))){
	                		$("#pullDown").show();
	                   }
	                   if(currentPageLength > 6 && (this.y < (this.maxScrollY - 100) && !pullUpEl.className.match('flip'))){
	                	   $("#pullUp").show();
	                   }
                	   if (this.y > 30 && !pullDownEl.className.match('flip')) {
                	    pullDownEl.className = 'flip';
                	    pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';
                	    this.minScrollY = 0;
                	   } else if (this.y < 30 && pullDownEl.className.match('flip')) {
                	    pullDownEl.className = '';
                	    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                	    this.minScrollY = -pullDownOffset;
                	   } else if (this.y < (this.maxScrollY - 100) && !pullUpEl.className.match('flip')) {
                	    pullUpEl.className = 'flip';
                	    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';
                	    this.maxScrollY = this.maxScrollY;
                	   } else if (this.y > (this.maxScrollY + 100) && pullUpEl.className.match('flip')) {
                	    pullUpEl.className = '';
                	    pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                	    this.maxScrollY = pullUpOffset;
                	   }
                	  },
                onRefresh: function () {
                	   if (pullDownEl.className.match('loading')) {
                	       pullDownEl.className = '';
                	       pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                	   } else if (pullUpEl.className.match('loading')) {
                	       pullUpEl.className = '';
                	       pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                	   }
               }
            });
        }, 100);
   }


