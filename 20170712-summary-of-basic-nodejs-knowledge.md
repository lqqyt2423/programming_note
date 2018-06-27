# Node 基础知识点总结

### 数据库模块

```javascript
var mysql = require('mysql');

// 创建数据库连接
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '0000',
  database: 'phone_weixin'
});

connection.connect();

// 操作数据库返回数据
connection.query('select * from msg', function(error, results, fields){
  if (error) throw error;
  console.log(results);
});

connection.end();
```

### fs 模块

```javascript
readFile()
readFileSync()
// 读取文件
var text = fs.readFileSync('fileNmae.txt','utf8');

writeFile()
writeFileSync()

// 以添加模式写入字符
fs.writeFileSync("fileName","content",{flag: "a"});
```

<!-- more -->

### HTTP

#### 客户端请求时

当出现`ENOTFOUND` 错误时，可以的解决办法是设置：

```javascript
http.globalAgent.maxSockets = 10;
```

下面这段话可能有所解释：

> 默认情况下， Node.js 会使用 `HTTP Agent` 这个类来创建 HTTP 连接，这个类实现了 socket 连接池，每个主机+端口对的连接数默认上限是 5。同时`HTTP Agent` 类发起的请求中默认带上了 `Connection: Keep-Alive`，导致已返回的连接没有及时释放，后面发起的请求只能排队。
>
> 解决办法有三种：
>
> - 禁用 `HTTP Agent`，即在在调用 `get` 方法时额外添加参数 `agent: false`
> - 设置 `http` 对象的全局 socket 数量上限
> - 在请求返回的时候及时主动断开连接
>
> 来源：http://blog.csdn.net/bolg_hero/article/details/49427677

### Child Process 模块

`exec` 方法用于执行bash 命令，它的参数是一个命令字符串。

```javascript
var exec = require('chile_process').exec;

var ls = exec('ls -l', function(error, stdout, stderr){
  if (error) {
    console.log(error);
  }
  console.log(stdout);
});
```

由于标准输出和标准错误都是流对象（stream），**可以监听data事件**，因此上面的代码也可以写成下面这样。

```javascript
var exec = require('child_process').exec;
var child = exec('ls -l');

child.stdout.on('data', function(data){
  console.log('stdout: ' + data);
});
child.stderr.on('data', function(data){
  console.log('stderr: ' + data);
});
child.on('close', function(code){
  console.log('closing code: ' + code);
});
```

### 异步编程

如果数组成员可以并行处理，但后续代码仍然需要所有数组成员处理完毕后才能执行的话，则异步代码会调整成以下形式：

```javascript
(function (i, len, count, callback) {
    for (; i < len; ++i) {
        (function (i) {
            async(arr[i], function (value) {
                arr[i] = value;
                if (++count === len) {
                    callback();
                }
            });
        }(i));
    }
}(0, arr.length, 0, function () {
    // All array items have processed.
}));
```

以上代码并行处理所有数组成员，并通过计数器变量来判断什么时候所有数组成员都处理完毕了。

## HTTP 协议

### 请求报文

规范把 HTTP 请求分为三个部分：状态行、请求头、消息主体。类似于下面这样：

```
<method> <request-URL> <version>
<headers>

<entity-body>
```

### 响应报文

HTTP 响应与 HTTP 请求相似，HTTP响应也由3个部分构成，分别是：

- 状态行
- 响应头(Response Header)
- 响应正文

状态行由协议版本、数字形式的状态代码、及相应的状态描述，各元素之间以空格分隔。

### URL

HTTP URL (URL是一种特殊类型的URI，包含了用于查找某个资源的足够的信息)的格式如下：

```
http://host[":"port][abs_path]
```

- http 表示要通过HTTP 协议来定位网络资源
- host 表示合法的Internet 主机域名或者IP 地址
- port 指定一个端口号，为空则使用缺省端口80
- abs_path 指定请求资源的URI

> 如果URL中没有给出abs_path，那么当它作为请求URI 时，必须以“/”的形式给出，通常这个工作浏览器自动帮我们完成。

### 在浏览器中输入URL 后的流程

1. 浏览器向 DNS 服务器请求解析该 URL 中的域名所对应的 IP 地址
2. 解析出 IP 地址后，根据该 IP 地址和默认端口 80，和服务器建立TCP连接
3. 浏览器发出读取文件（URL 中域名后面部分对应的文件）的HTTP 请求，该请求报文作为TCP 三次握手的第三个报文的数据发送给服务器
4. 服务器对浏览器请求作出响应，并把对应的 html 文本发送给浏览器
5. 释放TCP连接
6. 浏览器得到 html 文本并显示内容

### 参考

7天学会Node.js：http://nqdeng.github.io/7-days-nodejs/