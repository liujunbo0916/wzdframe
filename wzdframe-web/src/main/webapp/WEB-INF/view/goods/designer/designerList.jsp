<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../../common/top.jsp"%>
</head>
<body class="gray-bg">
 <div class="wrapper wrapper-content animated fadeInUp">
		<div class="row">
		  <!--   <div class="ibox-title">
					<h5>设计师列表</h5>
					<div class="ibox-tools">
						<a href="/sys/goods/designer/edit" class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
					</div>
			</div>
			<br> -->
		  
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-title">
						<h5>商品品牌</h5>
						<div class="ibox-tools">
							<a href="/sys/goods/designer/edit" class="btn btn-primary btn-xs"><i class="fa fa-plus"></i>&nbsp;新增</a>
						</div>
					</div>
					<div class="ibox-content">
						<form action="/sys/goods/designer/listPage" method="post" name="Form" id="Form">
							<div class="project-list">
 								<table id="simple-table" class="center table table-striped table-bordered table-hover">
								<!-- 	<thead>
										<tr>
											<th>编号</th>
											<th>设计师头像</th>
											<th>设计师名字</th>
											<th>设计师理念</th>
											<th>简述</th>
											<th>创建人</th>
											<th>创建时间</th>
											<th class="center" style="width: 85px">操作</th>
										</tr>
									</thead> -->

									<tbody>
										<!-- 开始循环 -->
										  <c:choose>
											   <c:when test="${not empty varList}">
											     <c:forEach items="${varList}" var="item">
											     <div class="col-sm-4">
									                <div class="contact-box">
									                    <a href="/sys/goods/designer/edit?id=${item.designer_id}">
									                        <div class="col-sm-4">
									                            <div class="text-center">
									                                <img alt="image" class="img-circle m-t-xs img-responsive" src="${SETTINGPD.IMAGEPATH}${item.designer_img}">
									                            </div>
									                        </div>
									                        <div class="col-sm-8">
									                            <h3><strong>${item.designer_name}</strong></h3>
									                            <address>
									                            <strong class="txtNumber"> 设计师理念:${item.designer_concept} </strong><br>
									                                   <p class="txtNum">简述:${item.designer_desc}</p><br>
									                            </address>
									                        </div>
									                        <div class="clearfix"></div>
									                    </a>
									                </div>
									            </div>
									            </c:forEach>
									            </c:when>
									            <c:otherwise>
													<tr class="main_info">
														<td colspan="7" class="center">没有相关数据</td>
													</tr>
												</c:otherwise>
							                </c:choose>
									    </tbody>
										<tfoot>
	                                        <tr>
	                                            <td colspan="8">
	                                               	<div class="dataTables_paginate paging_bootstrap pull-right">
	                                               		${page.pageStr}
													</div>	
	                                            </td>
	                                        </tr>
	                                    </tfoot>
								</table>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../common/foot.jsp"%>
	<script src="/assets/js/content.min.js"></script>
	<script>
        $(document).ready(function () {
            $('.contact-box').each(function () {
                animationHover(this, 'pulse');
            });
        });
        $(function(){
			var num=$(".txtNum").html();				
			if(num.length>74){
				$(".txtNum").html(num.substr(0,74)+"...");  //控制字数
				
			}
			var number=$(".txtNumber").html();				
			if(number.length>15){
				$(".txtNumber").html(number.substr(0,15)+"...");  //控制字数
				
			}	
		});
    </script>
</body>
</html>