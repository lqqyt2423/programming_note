# openssl 生成证书的操作

1、生成密钥

```
openssl genrsa -out key.pem 2048
```

2、创建证书请求（ create a *Certificate Signing Request* (CSR) file）

```
openssl req -new -sha256 -key key.pem -out csr.pem
```

此时需要填写一些信息，`Common Name` 需要填写对应的域名。

> 如果域名与最终访问域名不同，则会出错：证书名称与输入不匹配

3、用 `rootCA.crt` 和 `rootCA.key` 签发证书（根证书需额外生成）

```
openssl x509 -req -days 360 -in csr.pem -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out cert.pem -sha256 -extfile http.ext
```

`http.ext` 文件内容如下：

```
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName=@SubjectAlternativeName

[ SubjectAlternativeName ]
DNS.1=localhost
```

`SubjectAlternativeName` 中的域名需与 `Common Name` 一致。

> 为什么需要 `-extfile http.ext` 呢？因为此可以解决 `Chrome` 中的错误：
>
> NET::ERR_CERT_COMMON_NAME_INVALID
>
> 此服务器无法证实它就是 **localhost** - 它的安全证书没有指定主题备用名称。这可能是因为某项配置有误或某个攻击者拦截了您的连接。

4、通过 `node.js` 代码测试

```javascript
'use strict';

const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('./key.pem'),
  cert: fs.readFileSync('./cert.pem'),
};

https.createServer(options, (req, res) => {
  console.log(req.url);
  res.end('hello world\n');
}).listen(443, () => {
  console.log('server listen at 443');
});
```

运行

```
node index.js
```

浏览器中访问 `https://localhost/` 即可。



参考网址：

- [tls](https://nodejs.org/dist/latest-v12.x/docs/api/tls.html#tls_tls_ssl_concepts)
- [https](https://nodejs.org/dist/latest-v12.x/docs/api/https.html#https_https_createserver_options_requestlistener)
- [解决Chrome中错误相关](https://www.cnblogs.com/will-space/p/11913744.html)