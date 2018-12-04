var http = require('http'),
	express = require('express');

//初始化
var app = express();
//设置端口
app.set('port', 8080);
//设置express寻找静态资源的位置
app.use(express.static(__dirname + '/html'));
// 设置日志
app.use(express.logger('dev')); // 日志
//解析body
app.use(express.bodyParser());
//创建服务器
http.createServer(app).listen(app.get('port'),
    function(){
    console.log("Show: -->express is up ,the port is ->: " + app.get('port'));
});
///----------- 路由开始-------------------

