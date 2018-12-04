<!doctype html>
<html>
<head>
    <meta charset="utf-8">
   	<title>餐饮美食</title>
    <meta name="author" content=""/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <!-- Sets initial viewport load and disables zooming -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="email=no" name="format-detection" />
    <link href="vendors/ratchet/css/ratchet.css" rel="stylesheet">
    <link rel="stylesheet" href="css/cyms.css">
</head>

<body>
    <div class="content">
        <ul class="table-view">
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/1.jpg"/>
                        <img class="hot" src="img/icons/hot.png" alt=""/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            上锦宴串串香
                            <div class="grade">特别推荐</div>
                        </div>
                        <p class="mark">
                            <span>小吃</span>
                        </p>
                        <p class="moods">2150人去过</p>
                        <p class="price">人均￥55</p>
                    </div>
                    <div class="distance">距离855m</div>
                </a>
            </li>
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/2.jpg"/>
                        <img class="hot" src="img/icons/hot.png" alt=""/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            许记平安特色虾酸牛肉馆
                        </div>
                        <p class="mark">
                            <span>客家菜</span>
                        </p>
                        <p class="moods">12150人去过</p>
                        <p class="price">人均￥100</p>
                    </div>
                    <div class="distance">距离855m</div>
                </a>
            </li>
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/3.jpg"/>
                        <img class="hot" src="img/icons/hot.png" alt=""/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            沈五二酸汤牛肉美食坊...
                        </div>
                        <p class="mark">
                            <span>客家菜</span>
                        </p>
                        <p class="moods">1356人购买</p>
                        <p class="price">人均￥55</p>
                    </div>
                    <div class="distance">距离855m</div>
                </a>
            </li>
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/4.jpg"/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            兴旺大理过桥米线
                            <span class="grade">人气推荐</span>
                        </div>
                        <p class="mark">
                            <span>客家菜</span>
                        </p>
                        <p class="moods">1356人购买</p>
                        <p class="price">人均￥55</p>
                    </div>
                    <div class="distance">距离855m</div>
                </a>
            </li>
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/5.jpg"/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            老字号李记鹅肉粉面
                        </div>
                        <p class="mark">
                            <span>老字号</span>
                        </p>
                        <p class="moods">1356人购买</p>
                        <p class="price">人均￥55</p>
                    </div>
                    <div class="distance">距离855m</div>
                </a>
            </li>
            <li class="table-view-cell media">
                <a class="navigate-right">
                    <div class="img-wrap">
                        <img class="media-object pull-left" src="img/cyms/6.jpg"/>
                    </div>
                    <div class="media-body">
                        <div class="title-name">
                            老字号李记鹅肉粉面
                            <span>特别推荐</span>
                        </div>
                        <p class="mark">
                            <span>咖啡店</span>
                            <span>小吃</span>
                        </p>
                        <p class="moods">1356人购买</p>
                        <p class="price">人均￥55</p>
                    </div>
                    <div class="distance">距离1.5km</div>
                </a>
            </li>
        </ul>
        <div class="load-more">
            <button class="btn btn-block" onclick="loadMore()">加载更多</button>
        </div>
    </div>
    <!--设定预加载效果-->
    <div class="spinner">
        <div class="loading">
            <img src="img/icons/loading.gif" alt=""/>
        </div>
    </div>
    <script type="text/javascript">
        function loadMore() {
            var loadingPanel = document.querySelector('.spinner');
            loadingPanel.style.display = 'flex';
            setTimeout(function () {
                loadingPanel.style.display = 'none';
            }, 3000);
        };
    </script>
</body>
<script src="vendors/ratchet/js/ratchet.js"></script>
</html>