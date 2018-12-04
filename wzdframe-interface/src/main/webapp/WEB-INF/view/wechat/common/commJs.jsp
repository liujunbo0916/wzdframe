	<script src="/js/jquery.min.js"></script>
	<script src="/js/Ajax.js"></script>	
	<script src="/js/InheritString.js"></script>
	<script>
/* 	   $('input').on('focus',function(event){      
	        //自动反弹 输入法高度自适应
	         var target = this;
	         setTimeout(function(){
	        	 document.body.scrollTop = document.body.scrollHeight;
	         },100);
	   });
 */	   function getDevideType(){
		   if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
			   return "ios";
			} else if (/(Android)/i.test(navigator.userAgent)) {
				return "android";
			} else {
				return "pc";
			};
	   }
	</script>
