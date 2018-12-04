
//地址操作js对象
var Address = {
		data:{
			provs_data:[], 
			citys_data:{},
			dists_data:{}
		},
		address:{
			address_id:'',
			contact_name:'',
			contact_phone:'',
			province_id:0,
			province:'',
			city_id:0,
			city:'',
			area_id:0,
			area:'',
			address:'',
			zip:'',
			is_default:1,
		},
		addrType:1,
		actType:0,
		buytype:'',
		checkAddress:function(){
			Address.address.address_id = $("#address_id").val();
			Address.address.contact_name = $("#contact_name").val();
			Address.address.contact_phone = $("#contact_phone").val();
			var pcaId = $("#value2").val();
			if(Address.address.contact_name.isEmpty()){
				alert("请输入联系人姓名");
				//new Toast({context:$('.body'),message:'请输入联系人姓名',time:5000}).show();
				return false;
			}
			if(Address.address.contact_phone.isEmpty()){
				alert("请输入联系手机");
				//new Toast({context:$('.body'),message:'请输入联系手机',time:5000}).show();
				return false;
			}
			if(!Address.address.contact_phone.isPhone()){
				alert("手机号码格式不正确");
				//new Toast({context:$('.body'),message:'手机号码格式不正确',time:5000}).show();
				return false;
			}
			if(!pcaId){
				alert("请选择省市区");
				//new Toast({context:$('.body'),message:'请选择省市区',time:5000}).show();
				return false;
			}
			pcaId = pcaId.split(",");
			Address.address.province_id = pcaId[0];
			Address.address.city_id =pcaId[1];
			Address.address.area_id = pcaId[2];
			var pcaName = $("#demo2").text();
			if(!pcaName){
				alert("请选择省市区");
				//new Toast({context:$('.body'),message:'请选择省市区'}).show();
				return false;
			}
			pcaName = pcaName.split(",");
			Address.address.province = pcaName[0];
			Address.address.city=pcaName[1];
			Address.address.area = pcaName[2];
			Address.address.address = $("#address").val();
			return true;
		},
		//添加地址
		addAddress:function(){//添加地址
			if(Address.checkAddress()){
				Ajax.request("/wx/duyun/user/docreateAddress",{"data":Address.address,"success":function(data){
					if(data.code == 200){
						window.location.href="/wx/duyun/user/doaddressList?type="+Address.addrType+"&actType="+Address.actType+"&buytype="+Address.buytype;
					}else{
						alert(data.msg);
					}
				}});
			}
		},
		//删除地址
		delAddress:function(addressId){
			if(confirm("确定删除改地址吗？")){
				Ajax.request("/wx/duyun/user/dodelAddress",{"data":{"address_id":addressId},"success":function(data){
					if(data.code == 200){
						window.location.href="/wx/duyun/user/doaddressList?type="+Address.addrType+"&actType="+Address.actType+"&buytype="+Address.buytype;
					}else{
						alert(data.msg);
					}
				}});
			}
		},
		//编辑地址
		editAddress:function(){
			if(Address.checkAddress()){
				Ajax.request("/wx/duyun/user/doeditAddress",{"data":Address.address,"success":function(data){
					if(data.code == 200){
						window.location.href="/wx/duyun/user/doaddressList?type="+Address.addrType+"&actType="+Address.actType+"&buytype="+Address.buytype;
					}else{
						alert(data.msg);
					}
				}});
			}
		},
		//设置默认地址
		setDefaultAddress:function(addressId){
			Ajax.request("/wx/duyun/user/doeditAddress",{"data":{"address_id":addressId,"is_default":1},
				"success":function(data){
					if(data.code == 200){
						if(Address.actType == 1){//折扣单返回
							window.location.href="/wx/order/makeSureOrderByDisCount?addressType="+Address.addrType;
						}else{//普通单返回
							if(Address.addrType == 0){ //如果是从确认订单选择地址页面跳转过来的则 设置完之后还调到确认订单页面
								if(Address.buytype == 'buyNow'){
									window.location.href="/wx/order/makeSureOrderByDirect?addressType="+Address.addrType;
								}else if(Address.buytype == 'cartBuy'){
									window.location.href="/wx/order/makeSureOrder?addressType="+Address.addrType;
								}else{
									alert("系统有误！请退出当前界面！");
								}
							}else{
								window.location.href="/wx/duyun/user/doaddressList";
							}
						}
					}else{
						alert(data.msg);
					}
			}});
		}
}