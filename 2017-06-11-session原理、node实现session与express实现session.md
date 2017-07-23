---
title: session原理、node实现session与express实现session
date: 2017-06-11 14:04:05
tags:
- session
- node
- express
---

## 原理

session 存在的意义，是为了解决HTTP 是与状态协议所带来的问题。但是服务端和客户端可以通过cookie 来进行交互，session 的原理便是将session_id 存储在客户端的cookie 中，然后客户端每次请求HTTP 时，便会发送cookie，然后服务端通过session_id 便可将数据关联起来。

## node 原生代码实现逻辑

1. 用户访问网页时，如果cookie 中不存在session_id 字段，则处于没有登录的状态
2. 客户输入用户名和密码登录之后，如果服务端验证成功，则会随机生成一串字符串作为键，值中保留用户名，存在内存中
3. 然后服务端通过`set-cookie` 将session_id 通过cookie 保存在客户端中，如有需要，可以配置过期时间参数
4. 客户端之后访问中，便会将cookie 通过首部传入服务端中，服务端通过识别判断出客户端是处于登录状态，便返回对应登录的信息
5. 如果客户端选择注销登录，那传入服务端后，服务端便删除存储在全局对象的中此键

<!-- more -->

## 简要代码

服务端登录之后生成session_id：

```javascript
var sessions = {};

if (oUser.user in users && oUser.password == users[oUser.user]) {
	var sessionId = Math.random().toString(36).substr(2, 16);
	res.setHeader('set-cookie', 'sessionId=' + sessionId);
	console.log(sessionId);
	sessions[sessionId] = oUser.user;
	res.end('success\n' + oUser.user);
} else {
	res.end('wrong!');
}
```

请求之后，首先可以检查session_id，如果存在，将session_id 添加为request 的一个属性，相当于express 中的一个中间件：

```javascript
var cookie = req.headers.cookie;
var sessionId = '';
if (/sessionId=[a-z0-9]{16}/.test(cookie)) {
	sessionId = /sessionId=([a-z0-9]{16})/.exec(cookie)[1];
	if (sessionId in sessions) {
		req.sessionId = sessionId;
	}
}
```

上面代码就将session_id 与username 绑定在一起了，客户端通过session_id 便可识别用户。

## express 实现session

```javascript
var express = require('express');
var session = require('express-session');
var morgan = require('morgan');

var app = express();
app.listen(8888);

app.use(morgan('dev'));
app.use(session({
	secret: 'random string',
	cookie: { maxAge: null }
}));

app.get('/', function(req, res){
	if (req.session.isVisit) {
		req.session.isVisit++;
		res.send('第' + req.session.isVisit + '次访问');
	}	else {
		req.session.isVisit = 1;
		res.send('第1次访问');
		// console.log(req.session);
	}
});
```

## 参考网址

- [Session原理简述](https://www.pureweber.com/article/how-session-works/)
- [Nodejs使用session、cookie进行登录验证功能的实现](http://www.5941740.cn/2016/06/08/node-authority/index.html)
- [Session原理、安全以及最基本的Express和Redis实现](https://segmentfault.com/a/1190000002630691)
- [cookie 和 session](http://wiki.jikexueyuan.com/project/node-lessons/cookie-session.html)
- [expressjs/session 文档](https://github.com/expressjs/session)