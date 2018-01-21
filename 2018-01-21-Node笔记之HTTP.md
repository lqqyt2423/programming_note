# Node笔记之HTTP Server

## http.Server 类

要创建一个http 服务器，调用`http.createServer([requestListener])` 方法，返回一个新建的`http.Server` 实例。

`requestListener` 是一个函数，会自动被添加至`request`事件。即每次服务器收到新的请求，都会调用此函数。

创建一个简单的服务端如下：

```javascript
const http = require('http');
const server = http.createServer((req, res) => {
  res.end('ok');
});
server.listen(8000);
```

`server.listen()` 为开启HTTP 服务器的监听。常用的参数为`server.listen([port][, host][, backlog][, callback])`。`backlog` 指定待连接队列的最大长度。`callback` 即回调函数。

`server.listening` 返回一个布尔值，表示服务器是否正在监听连接。

当服务端每接收到一个请求时，便会触发`request` 事件。一般即为调用`http.createServer()` 中传入的`requestListener` 函数。

## http.IncomingMessage 类

`requestListener` 函数会被传入两个参数，第一个即为`IncomingMessage` 对象，可用来访问响应状态、消息头和数据等。

`message.headers` 属性返回请求头的对象。此对象已经被处理过，为头信息的名称与值的键值对，且头信息的名称为小写。而接收到的原始请求会存放在`message.rawHeaders` 属性中，是`[key, value, key2, value2, ...]` 的数组，注意是数组，头信息的名称也不会被转换为小写，重复的头信息也不会被合并。

`message.httpVersion` 返回客户端发送的HTTP 版本。

`message.method` 返回一个字符串表示请求的方法，例如：`GET`, `POST`。

`message.url` 返回请求的URL 字符串。注意仅包含HTTP 请求中的URL，即不包含域名等信息。解析时可使用`require('url').parse(message.url, true)`，第二个可选参数`true` 表示从URL 查询字符串中提取参数，相当于`require('querystring').parse`。

## http.ServerResponse 类

该对象在HTTP 服务器内部被创建，作为第二个参数传入`request` 事件。

`response.writeHead(statusCode[, statusMessage][, headers])` 可显式地发送一个响应头给请求。该方法只能在一个请求中调用一次，且需在`response.write()` 与`response.end()` 之前调用。

也可隐式地发送HTTP 头部信息，通过设置`response.statusCode` 属性设置状态码， 通过`response.setHeader(name, value)` 设置响应头。注意如果`setHeader()` 与`writeHead()` 同时存在，则合并响应头，且`writeHead()` 具有较高优先级。

> 头部信息`Content-Length` 是以字节为单位的，可使用`Buffer.byteLength()` 来确定字节长度。

`response.write(chunk[, encoding][, callback])` 此方法会发送一块响应主体，可被多次调用。

`response.end([data][, encoding][, callback])` 表示所有响应头与响应主体已全部发送完毕，每次响应必须包含此方法。之后便会触发`finish` 事件。