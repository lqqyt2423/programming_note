# Express知识点总结

## 安装

首先使用下面命令创建`package.json` 文件，大多数情况下只需按回车接收缺省值即可：

```
npm init
```
然后下面命令是按照`Express` ，并将其保存在依赖项列表中，即保存在`package.json` 中：

```
npm install express --save
```

也可暂时安装`Express` 不添加至依赖项列表：

```
npm install express
```

## 最简单应用程序 Hello World

在项目根目录，创建`index.js` 文件，写入下面代码：

```javascript
var express = require('express');
var app = express();

app.get('/', function(req, res){
  res.send('Hello World!');
});

app.listen(8000, function(){
  console.log('http://localhost:8000')
});
```

也可写成下面形式：

```javascript
var express = require('express');
var https = require('https');
var http = require('http');
var app = express();

http.createServer(app).listen(80);
https.createServer(options, app).listen(443);
```

## 使用Express 应用生成器

使用前需先全局安装：

```
npm install express-generator -g
```

然后下面命令即可创建名为`myapp` 的`Express` 应用程序：

```
express --view=pug myapp
```

之后运行下面命令启动应用程序：

```
DEBUG=myapp:* npm start
```

参考：[Express 应用生成器](http://expressjs.com/zh-cn/starter/generator.html)

## 运行原理

`Express` 框架建立在`node.js` 内置的`http` 模块之上，实质为对`http` 模块的再包装，等于在`http` 模块之上，加了一个中间层。

`Express` 采用中间件的方式运行程序。

## use方法

`use` 是`express` 注册中间件的方法，它返回一个函数。下面是一个连续调用两个中间件的例子：

```javascript
var express = require('express');
var app = express();

app.use(function(req, res, next){
  console.log(req.method, req.url);
  next()
});

app.get('*', function(req, res){
  res.send('Hello World!');
});

app.listen(8000, function(){
  console.log('http://localhost:8000')
});
```

上面代码使用`app.use` 方法，注册了两个中间件。收到HTTP请求后，先调用第一个中间件，在控制台输出一行信息，然后通过`next` 方法，将执行权传给第二个中间件，输出HTTP回应。由于第二个中间件没有调用`next` 方法，所以request对象就不再向后传递了。

## use 添加路径参数

`use` 方法允许将请求网址写在第一个参数，如下：

```javascript
app.use('/path', someMiddleware);
```

## 模式匹配

```javascript
app.get('/post/:id', function(req, res){
  res.send(req.params.id);
});
```

## 提供静态文件

使用`express.static` 内置中间件函数可加载静态文件。

```javascript
app.use(express.static('public'));
```

以上代码在`public` 目录中提供静态文件。

> Express 相对于静态目录查找文件，因此静态目录的名称不是此 URL 的一部分。

## 使用模板引擎

在 Express 可以呈现模板文件之前，必须设置：

- `views`：模板文件所在目录。例如：`app.set('views', './views')`
- `view engine`：要使用的模板引擎。例如：`app.set('view engine', 'jade')`

然后安装对应的模板引擎 npm 包：

```
$ npm install jade --save
```

当然也可使用其他模板引擎。

参考网址：[使用模板引擎](http://expressjs.com/zh-cn/guide/using-template-engines.html)

## 搭建HTTPS 服务器

```javascript
var express = require('express');
var fs = require('fs');
var https = require('https');

var app = express();

var options = {
  key: fs.readFileSync('./214095122480677.key'),
  cert: fs.readFileSync('./214095122480677.pem')
};

https.createServer(options, app).listen(443);
```

## Router

`Router` 是小型的express应用程序，可挂载至某个路径，为程序带来了更大的灵活性，既可以定义多个路由器实例，也可以为将同一个路由器实例挂载到多个路径。

```javascript
var express = require('express');
var app = express();
var router = express.Router();

router.get('/', function(req, res){
  res.send('hello');
});
router.get('/login', function(req, res){
  res.send('login page');
});

// 同一个Router挂载至两个路径
app.use('/blog', router);
app.use('/', router);

app.listen(8000, function(){
  console.log('http://localhost:8000')
});
```

## 参考链接

- [Express 文档](http://expressjs.com/zh-cn/)
- [Express 4.x API](http://expressjs.com/zh-cn/4x/api.html)
- [阮一峰 - Express 框架](http://javascript.ruanyifeng.com/nodejs/express.html)