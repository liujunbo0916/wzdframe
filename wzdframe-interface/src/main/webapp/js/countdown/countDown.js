 (function(window,$){
		 var CountDown = function(cutDowns,showType){
			 this.cutDowns = cutDowns;
			 this.days = "00";
			 this.hours = "00";
			 this.minutes = "00";
			 this.seconds = "00";
			 this.intervalId = "";
			 this.calCount = function(elemSelect){
				 var thisObj = this;
				 thisObj.intervalId = window.setInterval(function(){
					 if(thisObj.isStop()){
						 window.clearInterval(intervalId);
					 }
					 thisObj.cutDowns-- ;
					 if(showType == 'showDays'){
						 thisObj.days =  thisObj.formatTime(parseInt(thisObj.cutDowns / (24*3600)));
						 thisObj.hours = thisObj.formatTime(parseInt((thisObj.cutDowns - thisObj.days * 24 * 3600) / 3600));
						 thisObj.minutes = thisObj.formatTime(parseInt((thisObj.cutDowns - thisObj.days * 24 * 3600 - thisObj.hours * 3600) / 60));
						 thisObj.seconds = thisObj.formatTime(thisObj.cutDowns - thisObj.days * 24 * 3600 - thisObj.hours * 3600 - thisObj.minutes * 60);
						 $(elemSelect).find(".days").text(thisObj.days);
					 }else{
						 thisObj.hours = thisObj.formatTime(parseInt(thisObj.cutDowns/3600));
						 thisObj.minutes = thisObj.formatTime(parseInt((thisObj.cutDowns - thisObj.hours*3600)/60));
						 thisObj.seconds = thisObj.formatTime(thisObj.cutDowns - (thisObj.minutes * 60 + thisObj.hours * 3600));
					 }
					 $(elemSelect).find(".hour").text(thisObj.hours);
					 $(elemSelect).find(".minute").text(thisObj.minutes);
					 $(elemSelect).find(".second").text(thisObj.seconds);
				 },1000);
			 };
			 this.isStop = function(){
				 return this.cutDowns == 0;
			 };
			 this.formatTime = function(targetTime){
				 if(targetTime < 10){
					 targetTime = "0"+targetTime;
				 }
				 return targetTime;
			 };
			 this.clearInter=function(){
				 window.clearInterval(this.intervalId);
			 }
	 } 
		 window.CountDown = CountDown;
	 })(window,$);