$(function(){
			$("#agency_province_code").change(function(){
				var pid = $(this).val();
				if(pid != ''){
					var dataname=$(this).find("option:selected").text();
					$("#agency_province").val(dataname);
					$.ajax({
						type : "POST",
						url : "/sys/travel/getCityArea?province_id="+pid,
						dataType : "json",
						success : function(data) {
							if($("#agency_city_code").length && $("#agency_city_code").length > 0){
								$("#agency_city_code").empty();
								$("#area_code").remove();
								$("#agency_city_code").append('<option value="">--请选择市/县--</option>')
								if(data.data&&data.data.length&&data.data.length > 0){
									for(var i = 0 ; i < data.data.length ; i++){
										if('${dataModel.agency_city_code}' == data.data[i]['region_id']){
											 $("#agency_city_code").append('<option value="'+data.data[i]['region_id']+'"  selected ="selected" >'+data.data[i]['region_name']+'</option>')
										}else{
										   $("#agency_city_code").append('<option value="'+data.data[i]['region_id']+'" >'+data.data[i]['region_name']+'</option>');
										}
									}
								}else{
									$("#city_code").remove();
									$("#area_code").remove();
								}
							}else{
								var html = '<div class="col-sm-2" id="city_code"><select name="agency_city_code" id="agency_city_code" onchange="cityCodeChange(this);" class="form-control" > <option value="">--请选择市/县--</option>';
								if(data.data&&data.data.length&&data.data.length > 0){
									for(var i = 0 ; i < data.data.length ; i++){
										if('${dataModel.agency_city_code}' == data.data[i]['region_id']){
											html+= '<option value="'+data.data[i]['region_id']+'" selected ="selected"  >'+data.data[i]['region_name']+'</option>';
										}else{
											html+= '<option value="'+data.data[i]['region_id']+'"  >'+data.data[i]['region_name']+'</option>';
										}
									}
									$("#province_code").after(html);
								}
							}
						},
						error : function(data){
						}
					});
				}
			});
		});
		function cityCodeChange(objThis){
			var pid = $(objThis).val();
			if(pid != ''){
				var dataname=$(objThis).find("option:selected").text();
				$("#agency_city").val(dataname);
			$.ajax({
				type : "POST",
				url : "/sys/travel/getCityArea?province_id="+pid,
				dataType : "json",
				success : function(data) {
					if($("#agency_area_code").length && $("#agency_area_code").length>0){
						$("#agency_area_code").empty();
						$("#agency_area_code").append('<option value="">--请选择区域--</option>')
						if(data.data&&data.data.length && data.data.length > 0){
							for(var i = 0 ; i < data.data.length ; i++){
								if('${dataModel.agency_area_code}' == data.data[i]['region_id']){
									 $("#agency_area_code").append('<option value="'+data.data[i]['region_id']+'" selected ="selected" >'+data.data[i]['category_name']+'</option>')
								}else{
								   $("#agency_area_code").append('<option value="'+data.data[i]['region_id']+'" >'+data.data[i]['region_name']+'</option>');
								}
							}
						}else{
							$("#area_code").remove();
						}
					}else{
						var html = '<div class="col-sm-2" id="area_code"><select name="agency_area_code" id="agency_area_code" class="form-control" onchange="onAreaChange(this)"> <option value="">--请选择市/县--</option>';
						if(data.data&&data.data.length&&data.data.length > 0){
							for(var i = 0 ; i < data.data.length ; i++){
								if('${dataModel.agency_area_code}' == data.data[i]['region_id']){
									html += '<option value="'+data.data[i]['region_id']+'" selected ="selected" >'+data.data[i]['region_name']+'</option>';
								}else{
									html += '<option value="'+data.data[i]['region_id']+'" >'+data.data[i]['region_name']+'</option>';
								}
							}
							$("#city_code").after(html);
						}
					}
				},
				error : function(data){
				}
			});
			}
		}
		function onAreaChange(objThis){
			var dataname=$(objThis).find("option:selected").text();
			$("#agency_area").val(dataname);
		}
		
		