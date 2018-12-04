<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>订单填写</title>
<link href="/css/reset.css" rel="stylesheet" />
<link href="/css/dingdan.css" rel="stylesheet" />
<script src="/js/shipei.js"></script>
</head>
<body>
	<div class="container">
		<!--title-->
		<!--input-->
		<div class="inpt-box">
			<ul>
				<li><label>出行人数</label> <input type="text" id="person_number" />
				</li>
				<li><label>预约时间</label> <input style="background-color: #FFF;" type="date" id="book_time" /></li>
				<li><label>联系人</label> <input type="text" id="con_name" /></li>
				<li><label>联系手机</label> <input type="number" id="con_phone" />
				</li>
				<li><label>预约地点</label> <input type="text" id="book_address" />
				</li>
			</ul>
		</div>
		<!--预约须知-->
		<div class="text-box">
			<h2>预约须知</h2>
			<div class="text">
				<ul class="cautions-items">
					<li><span>费用包含：都匀景区讲解员服务；1.2米以下儿童免费1.2米以上儿童按1人计费；</span></li>
					<li><span>费用不含：不含任何景点门票，不含任何景点门票；</span></li>
					<li><span>行程时间：3小时；</span></li>
					<li><span>行程内容：景区讲解员推荐或游客DIY的行程。</span></li>
				</ul>
			</div>
		</div>
	</div>
	<!--sumbit-->
	<a class="sumbit" onclick="submitBtn();">提交订单</a>
</body>
<%@ include file="common/commJs.jsp"%>
<script type="text/javascript">
	var isSubmit = false;
	function submitBtn() {
		if (!isSubmit) {
			if ($("#person_number").val().isEmpty()
					|| !$("#person_number").val().isNumber()) {
				alert("请注意出行人数输入正确");
				return;
			}
			if ($("#book_time").val().isEmpty()) {
				alert("预约时间不能为空");
				return;
			}
			if ($("#con_name").val().isEmpty()) {
				alert("请输入联系人");
				return;
			}
			if ($("#con_phone").val().isEmpty()
					|| !$("#con_phone").val().isPhone()) {
				alert("请输入正确的手机号码格式");
				return;
			}
			if ($("#book_address").val().isEmpty()) {
				alert("请输入预约地点");
				return;
			}
			alert($("#book_time").val());
			Ajax.request("/wx/user/bookOrderSub", {
				"data" : {
					"person_number" : $("#person_number").val(),
					"book_time" : $("#book_time").val(),
					"con_name" : $("#con_name").val(),
					"con_phone" : $("#con_phone").val(),
					"book_address" : $("#book_address").val(),
					"guider_id":'${pd.guiderId}'
				},
				"success" : function(data) {
					if (data.code == 200) {
						window.location.href = "/wx/duyun/user/center";
					}else{
						alert(data.msg);
					}
				}
			});
		}
	}
</script>
</html>
