<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/duyun/pc/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/css/duyun/pc/strategy-detail.css" type="text/css">
     <meta name="keywords" content="${lineDetail.line_name}">
    <meta name="description" content="${lineDetail.line_name}">
    <title>${lineDetail.line_name}</title>
<style type="text/css">
  .hot-recommend-list{
   cursor: pointer;
  }
  .left-header-one img{
     width: 100%;
  }
</style>
</head>
<body>
<%@ include file="common/navi.jsp"%>
<%@ include file="common/ercode.jsp"%>

<div class="row service-nav">
    <div class="col-md-6"></div>
    <div class="col-md-6">
        <div class="row service-nav-right">
           <div class="col-md-2 service-0 active " style="cursor: pointer;" onclick="window.location.href='/guide/list'">
                旅游攻略
            </div>
            <div class="col-md-2 service-1  " style="cursor: pointer;" onclick="window.location.href='/content/list'">
                实时资讯
            </div>
            <div class="col-md-2 service-2 " style="cursor: pointer;" onclick="onBook(2);">
                旅游资讯
            </div>
        </div>
    </div>
</div>
<div class="body-container">
    <div class="body-img">
        <img src="${SETTINGPD.IMAGEPATH}${lineDetail.line_logo}"  onError="javascript:this.src='/img/no-img/no-img.jpg';"  alt="">
        <div class="img-hover">
            <p class="hover-one">
                ${lineDetail.line_name}
            </p>
            <p class="hover-two">
                发表于：${lineDetail.create_time}
            </p>
        </div>
    </div>
    <div class="row body-content">
        <div class="col-md-8 body-left">
            
            <c:forEach items="${dataModel}" var="item">
	            <div class="left-header-one">
	                <p>
	                   ${item.scenic_name}
	                </p>
	                <div>
	                  ${item.scenic_content}
	                </div>
	            </div>
            </c:forEach>
           <!--  <div class="left-header-one">
                <p>
                     2222
                </p>
                <img src="/img/duyun/pc/router.png" class="header-img" alt="">
            </div> -->
            <!-- <div class="left-header-two">
                <p>
                    今天周五
                </p>
                <p>
                    今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈
                </p>
                <img src="/img/duyun/pc/router.png" class="header-img-one"  alt="">
                <img src="/img/duyun/pc/router.png" class="header-img" alt="">
                <p>
                    今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈
                </p>
            </div> -->
            <!-- <div class="left-header-three">
                <p class="submit-comment">发表评论</p>
                <textarea name="" id="commentContext" cols="85" rows="7" placeholder="评论一下"></textarea>
                <p class="number">
                    <span id="inputConut">0</span><span>/</span><span id="totalCount">500</span>
                </p>
                <p class="button-group">
                    <button type="button" class="btn btn-warning submit-btn">提交</button>
                </p>
            </div> -->
            <!-- <div class="left-header-four">
                <div class="friend-comment">
                    网友评论
                </div>
                <div class="row comment-content">
                    <div class="col-md-2 comment-one">
                        <img src="/img/duyun/pc/router.png" class="comment-img" alt="">
                    </div>
                    <div class="col-md-8">
                        <p class="comment-name">张三</p>
                        <p class="comment-text">哈哈哈哈 </p>
                        <p class="comment-date">发表于2017-08-10 </p>
                    </div>
                    <div class="col-md-2 comment-three">
                        回复
                    </div>
                </div>
                <div class="row comment-content">
                    <div class="col-md-2 comment-one">
                        <img src="./img/router.png" class="comment-img" alt="">
                    </div>
                    <div class="col-md-8">
                        <p class="comment-name">张三</p>
                        <p class="comment-text">哈哈哈哈 </p>
                        <p class="comment-date">发表于2017-08-10 </p>
                    </div>
                    <div class="col-md-2 comment-three">
                        回复
                    </div>
                </div>
                <div class="row comment-content">
                    <div class="col-md-2 comment-one">
                        <img src="./img/router.png" class="comment-img" alt="">
                    </div>
                    <div class="col-md-8">
                        <p class="comment-name">张三</p>
                        <p class="comment-text">哈哈哈哈 </p>
                        <p class="comment-date">发表于2017-08-10 </p>
                    </div>
                    <div class="col-md-2 comment-three">
                        回复
                    </div>
                </div>
                <ul class="pagination footer-pagination">
                    <li><a class="page active" href="#">1</a></li>
                    <li><a class="page" href="#">2</a></li>
                    <li><a class="page" href="#">3</a></li>
                    <li><a class="page" href="#">4</a></li>
                    <li><a class="page" href="#">...</a></li>
                    <li>
                        <a class="next" href="#" aria-label="Next">
                            下一页
                        </a>
                    </li>
                </ul>

            </div> -->
        </div>
        <div class="col-md-4 body-right" id="scenicList">
            <p class="relative-spot">相关景点</p>
            <!-- <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="./img/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="recommend-one">
                        <span class="travel-info-text">安顺</span>
                        <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="recommend-two">
                        今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈

                    </p>
                    <p class="recommend-three">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div> -->
            <!-- <div class="row hot-recommend-list">
                <div class="hot-recommend-image">
                    <img src="./img/router.png" alt="">
                </div>
                <div class="hot-recommend-content">
                    <p class="recommend-one">
                        <span class="travel-info-text">安顺</span>
                          <span class="travel-info-text">荔波</span>
                        <span class="travel-info-text">西双日非</span>
                    </p>
                    <p class="recommend-two">
                        今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈今天周五哈哈哈哈哈哈哈

                    </p>
                    <p class="recommend-three">
                        <span class="list-info-amount">$2250</span>
                        <span class="amount-text"> 起／人</span>
                    </p>
                </div>
            </div> -->
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp"%>
<script src="/js/duyun/pc/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/popper.min.js" type="text/javascript"></script>
<script src="/js/duyun/pc/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/Ajax.js"></script>
<script type="text/javascript">
  $(function(){
	/*   var original = '';
	  $("#commentContext").bind("input propertychange change",function(){
		  var textLength = $(this).val().length;
		  var textVal = $(this).val();
		  if(500-textLength < 0){
			  $(this).val(original);
		  }else{
			  $("#inputConut").text(textLength);
			  $("#totalCount").text(500-textLength);
			  original = textVal;
		  }
	  }); */
	  requestScenicList();
  });
   var imgFiexd = '${SETTINGPD.IMAGEPATH}';
   function requestScenicList(){
	   Ajax.request("/logic/scenicList",{"data":{"limit":2,"line_id":'${lineDetail.id}'},"success":function(data){
		   if(data.code == 200){
			   var data = data.data;
			   var htmlAry = [];
			   for(var i = 0 ; i<data.length ; i++){
				   htmlAry.push('<div class="row hot-recommend-list"><div class="hot-recommend-image">');
				   htmlAry.push('<img src="'+imgFiexd+data[i].scenic_logo+'" onError="javascript:this.src='+"'"+'/img/no-img/no-img.jpg'+"'"+';"  alt=""> </div><div class="hot-recommend-content"> <div class="content-one" style="height:20px;overflow: hidden;">'+data[i].scenic_name+'</div>');
				   htmlAry.push('<div style="height:44px;margin-top:15px;overflow: hidden;" class="content-twp">'+data[i].scenic_desc+'</div><p class="content-three"></p></div></div>')
			   }
			   $("#scenicList").append(htmlAry.join(''));
		   }
	   }});
   }
</script>
</body>
</html>