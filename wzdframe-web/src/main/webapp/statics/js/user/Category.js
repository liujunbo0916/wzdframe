$(function(){
			$("#category1_id").change(function(){
				var pid = $(this).val();
				if(pid != ''){
					$.ajax({
						type : "POST",
						url : "/sys/goods/goodsCategory/queryCategoryByPid?pid="+pid,
						dataType : "json",
						success : function(data) {
							if($("#category2_id").length && $("#category2_id").length > 0){
								$("#category2_id").empty();
								$("#category2_id").append('<option value="-1">--请选择二级分类--</option>')
								if(data.data&&data.data.length&&data.data.length > 0){
									for(var i = 0 ; i < data.data.length ; i++){
										if('${dataModel.category2_id}' == data.data[i]['category_id']){
											 $("#category2_id").append('<option value="'+data.data[i]['category_id']+'" selected ="selected" >'+data.data[i]['category_name']+'</option>')
										}else{
										   $("#category2_id").append('<option value="'+data.data[i]['category_id']+'">'+data.data[i]['category_name']+'</option>');
										}
									}
								}else{
									$("#categoryAppend2").remove();
									$("#categoryAppend3").remove();
								}
							}else{
								var html = '<div class="col-sm-2" id="categoryAppend2"><select name="category2_id" id="category2_id" onchange="category2Change(this,callBack2Category);" class="form-control" > <option value="-1">--请选择二级分类--</option>';
								if(data.data&&data.data.length&&data.data.length > 0){
									for(var i = 0 ; i < data.data.length ; i++){
										if('${dataModel.category2_id}' == data.data[i]['category_id']){
											html+= '<option value="'+data.data[i]['category_id']+'" selected ="selected" >'+data.data[i]['category_name']+'</option>';
										}else{
											html+= '<option value="'+data.data[i]['category_id']+'">'+data.data[i]['category_name']+'</option>';
										}
									}
									$("#appendCategory").after(html);
								}
							}
						},
						error : function(data){
						}
					});
				}
			});
		});
		function category2Change(objThis,callback){
			var pid = $(objThis).val();
			if(pid != ''){
			$.ajax({
				type : "POST",
				url : "/sys/goods/goodsCategory/queryCategoryByPid?pid="+pid,
				dataType : "json",
				success : function(data) {
					if($("#category3_id").length && $("#category3_id").length>0){
						$("#category3_id").empty();
						$("#category3_id").append('<option value="">--请选择三级分类--</option>')
						if(data.data&&data.data.length && data.data.length > 0){
							for(var i = 0 ; i < data.data.length ; i++){
								if('${dataModel.category_id}' == data.data[i]['category_id']){
									 $("#category3_id").append('<option value="'+data.data[i]['category_id']+'" selected ="selected" >'+data.data[i]['category_name']+'</option>')
								}else{
								   $("#category3_id").append('<option value="'+data.data[i]['category_id']+'">'+data.data[i]['category_name']+'</option>');
								}
							}
						}else{
							$("#categoryAppend3").remove();
						}
					}else{
						var html = '<div class="col-sm-2" id="categoryAppend3"><select name="category3_id" id="category3_id" class="form-control" onclick="callBack3Category(this);" > <option value="-1">--请选择二级分类--</option>';
						if(data.data&&data.data.length&&data.data.length > 0){
							for(var i = 0 ; i < data.data.length ; i++){
								if('${dataModel.category3_id}' == data.data[i]['category_id']){
									html += '<option value="'+data.data[i]['category_id']+'" selected ="selected" >'+data.data[i]['category_name']+'</option>';
								}else{
									html += '<option value="'+data.data[i]['category_id']+'">'+data.data[i]['category_name']+'</option>';
								}
							}
							$("#categoryAppend2").after(html);
						}
					}
				},
				error : function(data){
				}
			});
			}
			if(callback){
				callback(objThis);
			}
		}
		
		