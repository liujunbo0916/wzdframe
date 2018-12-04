<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/top.jsp"%>
</head>
<style>
.social-footer .social-comment img {
	width: 60px;
	height: 60px;
	margin-right: 10px;
}
</style>
<body class="gray-bg">
	<div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-content text-center">
						<h3 class="m-b-xxs">评论列表</h3>
					</div>
				</div>
				<div class="social-feed-box">
					<c:choose>
						<c:when test="${not empty commentlist}">
							<c:forEach items="${commentlist}" var="comment" varStatus="vs">
								<div class="social-footer">
									<div class="social-comment">
										<a href="" class="pull-left"> <img alt="image"
											src="${SETTINGPD.IMAGEPATH}${comment.headPortrait}">
										</a>
										<div class="media-body">
											<a href="">${comment.nickName} </a> <br>
											评论内容：${comment.content} <br> 星级：${comment.star} <br>
											<small class="text-muted">${comment.createTime}</small> <a
												style="margin-left: 20px"
												<c:if test="${commentType==1}">
												href="javascript:del('${comment.goodsId}','${comment.commentId}')
												</c:if>
												<c:if test="${commentType==2}">
												href="javascript:del('${comment.courseId}','${comment.commentId}')
												</c:if>;" class="btn btn-warning btn-sm" title="删除"> <i
												class="fa fa-trash"></i>
											</a>
										</div>
									</div>
								</div>
							</c:forEach>
							<div class="main_info" style="float: right; margin-top: 10px">
								<td class="center">${page.pageStr}</td>
							</div>
						</c:when>
						<c:otherwise>
							<div class="main_info"margin-top: 10px">
								<td colspan="10" class="center">没有相关数据</td>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../../common/foot.jsp"%>
	<!--统计代码，可删除-->
	<script type="text/javascript">
		function del(goods_id, comment_id) {
			bootbox.confirm("确定删除该评论吗？",
							function(result) {
								var type= '${commentType}';
								if (result) {
									if(type==1){
									window.location.href = "/sys/goods/goods/delGoodsComments?goods_id="
											+ goods_id
											+ "&comment_id="
											+ comment_id;
									}else if(type==2){
										window.location.href = "/sys/goods/goods/delGoodsComments?course_id="
											+ goods_id
											+ "&comment_id="
											+ comment_id;
									}
									
								}
							});
		}
	</script>
</body>
</html>