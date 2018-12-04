var Dictionnaries = {
		del:function(Id){
			bootbox.confirm("确定要删除吗?", function(result){
				if(result){
					var url = "/dictionaries/delete.do?tm="+new Date().getTime();
					var data = {"DICTIONARIES_ID":Id};
					Ajax.request(url,{"data":data,"success":function(item){
						if(item.result == "200"){
							 window.parent.initTree();
							window.location.reload();
						}else{
							bootbox.alert(item.msg);
						}
					}});
				}
			});
		},
		save:function(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
		}
			if($("#NAME_EN").val()==""){
				$("#NAME_EN").tips({
					side:3,
		            msg:'请输入英文',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME_EN").focus();
			return false;
		}
			if($("#BIANMA").val()==""){
				$("#BIANMA").tips({
					side:3,
		            msg:'请输入编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIANMA").focus();
			return false;
		}
			if($("#ORDER_BY").val()==""){
				$("#ORDER_BY").tips({
					side:3,
		            msg:'请输入数字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDER_BY").focus();
			return false;
		}
			var data = $("#Form").serialize();
			Ajax.request($("#Form").attr("action"),{"data":data,"success":function(item){
				if(item.result == "200"){
					 window.parent.initTree();
					 window.location.href="/dictionaries/list?fid="+item.data.PARENT_ID;
				 }else{
					 alert(item.msg);
				 }
			}});
		},
		hasBianma:function(){
			var BIANMA = $.trim($("#BIANMA").val());
			if("" == BIANMA)return;
			Ajax.request("/dictionaries/hasBianma",{"data":{BIANMA:BIANMA,tm:new Date().getTime()},"success":function(data){
				   if(data.result != "200"){
					   $("#BIANMA").tips({
							side:1,
				            msg:'编码'+BIANMA+'已存在,重新输入',
				            bg:'#AE81FF',
				            time:5
				        });
						$('#BIANMA').val('');
				   }
			}});
		}
}