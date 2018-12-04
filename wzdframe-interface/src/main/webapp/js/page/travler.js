
//出行人js对象
var Travler = {
		travler:{
			travelers_id:'',
			travelers_name:'',
			travelers_type:'1',
			travelers_no:'',
			travelers_phone:'',
			travelers_gender:'',
		},
		checkTravler:function(){
			Travler.travler.travelers_id = $("#travelers_id").val();
			Travler.travler.travelers_name = $("#travelers_name").val();
			Travler.travler.travelers_phone = $("#travelers_phone").val();
			Travler.travler.travelers_no = $("#travelers_no").val();
			Travler.travler.travelers_gender = $('input[name="travelers_gender"]:checked').val();
			if(!Travler.travler.travelers_name){
				alert("请输入出行人姓名");
				return false;
			}
			if(Travler.travler.travelers_phone.isEmpty()){
				alert("请输入联系手机");
				return false;
			}
			if(!Travler.travler.travelers_phone.isPhone()){
				alert("手机号码格式不正确");
				return false;
			}
			if(Travler.travler.travelers_no.isEmpty()){
				alert("请输入身份证号码");
				return false;
			}
			if(Travler.travler.travelers_gender.isEmpty()){
				alert("请选择性别");
				return false;
			}
			return true;
		},
		//编辑、添加出行人
		editAddTravler:function(){
			if(Travler.checkTravler()){
				Ajax.request("/wx/duyun/user/dotravelerssave",{"data":Travler.travler,"success":function(data){
					if(data.code == 200){
						window.location.href="/wx/duyun/user/dotravelerslist";
					}else{
						alert(data.msg);
					}
				}});
			}
		},
		//删除出行人
		delTravler:function(addressId){
			if(confirm("确定删除该出行人吗？")){
				Ajax.request("/wx/duyun/user/dotravelersdel",{"data":{"travelers_id":travelers_id},"success":function(data){
					if(data.code == 200){
						window.location.href="/wx/duyun/user/dotravelerslist";
					}else{
						alert(data.msg);
					}
				}});
			}
		},
}