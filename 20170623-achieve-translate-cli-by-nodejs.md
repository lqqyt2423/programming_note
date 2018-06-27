# node命令行程序开发之实现中英翻译功能

平时电脑上执行node 程序时，必须进入此程序目录，然后在终端输入：

```
node index.js
```

才能执行此程序。

但是这样子效率不高，如果可以只输入一个命令单词就可以执行，那就会很高效了。例如就像在终端列出文件的命令这样：

```
ls
```

## 编写最简单的node 命令行程序

从最简单的hello world 程序说起，编写一个文件，文件名为`hello` ，文件内容为：

```javascript
#!/usr/bin/env node
console.log('hello world');
```

我估摸着第一行的意思应该是调用node 的执行环境执行此脚本。

保存文件之后需要修改此文件的权限为755，表示具有执行权限

```
chmod 755 hello
```

> 最近在学习Linux 的相关知识点，在Linux 中，所有文件都会有三个权限分别为：读、写和执行。然后每个权限有自己的代码：读-4，写-2，执行-1。所谓的755权限便是指此文件的拥有者具有三个权限，然后此文件的群组和路人只具有5的权限，即读和执行，没有写的权限。
>
> 总之要执行脚本，最重要是要设置脚本的执行权限。
>
> 可通过`ls -l` 来查看文件的具体信息，权限表示类似这样：`lrwxr-xr-x`。

之后便可以执行此文件了，在终端输入：

```
./hello
```

便可执行此脚本，执行后便会输出`hello world`。`./` 表示相对路径，此路径。

如果在其他路径下也想要执行此脚本，就必须将此脚本加入至环境变量$PATH 中。

下面命令会创建此脚本的符号链接至目录`/usr/local/bin` ，即环境变量的目录：

```
ln -s 绝对路径/hello /usr/local/bin/hello
```

所谓符号链接，即快捷方式，之后打开终端便可以随时执行此脚本了：

```
hello
```

## 翻译脚本命令行程序的实现

```javascript
#!/usr/bin/env node
var http = require('http');
// 接收输入的单词
var word = process.argv.slice(2).join(' ');
word = encodeURIComponent(word);
// 翻译的API
var link = 'http://fanyi.youdao.com/openapi.do?keyfrom=f2ec-org&key=1787962561&type=data&doctype=json&version=1.1&q=' + word;
// 联网翻译
http.get(link, function(res){
	// console.log(res.headers);
	var body = [];
	res.on('data', function(chunk){
		body.push(chunk);
	});
	res.on('end', function(){
		body = Buffer.concat(body).toString();
		body = JSON.parse(body);
		body = JSON.stringify(body, (key, value) => {
			if (key == 'errorCode') {
				return undefined;
			}
			if (key == 'basic') {
				return value.explains;
			}
			if (key == 'traslation') {
				return value.toString();
			}
			if (key == 'web') {
				return value.map((item) => `${item.key} --- ${item.value.join(';')}`);
			}
			return value;
		}, 4);
		// 在终端输出翻译结果
		console.log(body);
	});
});

```

上面即全部的代码，逻辑很简单，终端输入单词，调用翻译API 接口，然后终端输出翻译之后的结果。

`process.argv[2]` 的意思为接收用户输入的第一个参数，为什么后面的数值是2呢，因为0和1都被他们自己的一个属性占用掉了，你可以console 自己测试。

保存上面文件为`translate` 文件，不需要添加后缀名。然后再添加符号链接即快捷方式至环境变量中即可，为了简单，可以使快捷方式文件名为`t` 表示。

之后想要查询单词时，直接在终端输入：

```
t apple
```

即可得到想要的翻译结果，也可翻译中文至英文：

```
t 苹果
```

## 参考网址

- [Node.js 命令行程序开发教程](http://www.ruanyifeng.com/blog/2015/05/command-line-with-node.html)
- [随手找了一个有道翻译API](https://github.com/cloudcome/nodejs-ydr-translate/blob/master/youdao.md)