---
title: express上传文件中间件Multer的使用方法
date: 2017-06-06 13:24:40
tags:
- express
- multer
---

`Multer` 用于处理`multipart/form-data` 类型的表单数据，主要用于上传文件。

## 安装

```
npm install multer --save
```

## 使用

前端页面代码如下：

```html
<form action="" method="POST" enctype="multipart/form-data">
	Select an image to upload:<br>
	<input type="file" name="image"><br>
	<input type="submit" value="Upload Image">
</form>
```

以下代码为最简单使用方法，即上传文件，然后将文件保存在文件夹中。不过此时的文件名是随机生成且无扩展名。

```javascript
var express = require('express');
var multer = require('multer');

var app = express();
// 上传的文件夹
var upload = multer({ dest: 'uploads/'});

app.post('/upload', upload.single('image'), function(req, res, next){
  // req.file 是 `avatar` 文件的信息
  // req.body 将具有文本域数据, 如果存在的话
  res.send('success');
});
```

如需自定义保存的文件名称，可配置如下：

<!-- more -->

```javascript
var storage = multer.diskStorage({
	destination: function(req, file, cb){
		cb(null, path.join(__dirname, '../public/images/'));
	},
	filename: function(req, file, cb){
		// console.log(file);
		cb(null, file.originalname);
	}
});
var upload = multer({ storage: storage});
```

## 参考

[官方文档](https://github.com/expressjs/multer/blob/master/doc/README-zh-cn.md)