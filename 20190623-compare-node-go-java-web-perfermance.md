# 对比node/go/java等语言web服务器性能

### 性能测试命令

```bash
wrk -t2 -c100 -d10 --latency http://localhost:9000
```

以上命令表示：开启2个线程，保持100个http连接，持续10s时间，最终打印延迟统计信息。

### 测试环境

型号名称：	MacBook Pro
型号标识符：	MacBookPro14,1
处理器名称：	Intel Core i5
处理器速度：	2.3 GHz
处理器数目：	1
核总数：	2
L2 缓存（每个核）：	256 KB
L3 缓存：	4 MB
超线程技术：	已启用
内存：	8 GB

总体来说逻辑核心数为4个。

### node.js

```javascript
const http = require('http');

http.createServer((req, res) => {
  res.end('hello world\n');
}).listen(9000, () => {
  console.log('start web at port 9000');
});
```

```
用 node index.js 的方式启动程序后的测试结果（一个进程）：

Running 10s test @ http://localhost:9000
  2 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.60ms    1.14ms  26.97ms   92.89%
    Req/Sec    14.15k     2.05k   16.11k    81.00%
  Latency Distribution
     50%    3.26ms
     75%    3.63ms
     90%    4.41ms
     99%    7.84ms
  281573 requests in 10.01s, 30.08MB read
Requests/sec:  28138.64
Transfer/sec:      3.01MB

50%请求延时在3.26毫秒。
```

```
用 pm2 start index.js -i 4 的方式启动程序后的测试结果（四个进程）：

Running 10s test @ http://localhost:9000
  2 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.50ms    7.57ms 144.58ms   91.30%
    Req/Sec    19.97k     4.84k   41.89k    82.00%
  Latency Distribution
     50%    1.46ms
     75%    4.97ms
     90%   11.02ms
     99%   35.93ms
  398020 requests in 10.03s, 42.51MB read
Requests/sec:  39685.38
Transfer/sec:      4.24MB

好像开启四个进程的收益没有那么大。且标准差变大了。
```

### go

```go
package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "hello world")
	})
	fmt.Println("start web at port 9001")
	log.Fatal(http.ListenAndServe("localhost:9001", nil))
}
```

```
Running 10s test @ http://localhost:9001
  2 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     6.41ms   14.11ms 229.69ms   89.26%
    Req/Sec    27.53k    15.85k   57.81k    64.36%
  Latency Distribution
     50%    1.01ms
     75%    5.01ms
     90%   21.58ms
     99%   53.90ms
  540458 requests in 10.04s, 66.49MB read
Requests/sec:  53843.81
Transfer/sec:      6.62MB

从数据来看好像不是很稳定，请求延时的标准差较大。不过相对于node的数据来说较好。
```

### spring boot

```java
package hello;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * HomeController
 */
@RestController
public class HomeController {

    @RequestMapping("/")
    public String home() {
        return "hello world\n";
    }
}
```

```
Running 10s test @ http://localhost:8080
  2 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.18ms    1.66ms  29.98ms   86.57%
    Req/Sec    18.07k     3.70k   25.67k    65.50%
  Latency Distribution
     50%    1.94ms
     75%    2.56ms
     90%    3.66ms
     99%    8.46ms
  362340 requests in 10.09s, 43.60MB read
Requests/sec:  35921.99
Transfer/sec:      4.32MB

虽然每秒请求数没有node和go多，但是很稳定，性能也还可以。
```

### 内存占用情况

``` bash
ps aux
```

```
USER               PID  %CPU %MEM      VSZ    RSS   TT  STAT STARTED      TIME COMMAND
liqiang          53065   0.0  0.8  5008640  65284   ??  S     9:16上午   0:19.54 node /Users/liqiang/Desktop/api_performance_test/node/index.js
liqiang          53064   0.0  0.6  5008564  52056   ??  S     9:16上午   0:19.75 node /Users/liqiang/Desktop/api_performance_test/node/index.js
liqiang          53063   0.0  0.6  5008824  48980   ??  S     9:16上午   0:19.66 node /Users/liqiang/Desktop/api_performance_test/node/index.js
liqiang          53062   0.0  0.7  5009236  61088   ??  S     9:16上午   0:19.70 node /Users/liqiang/Desktop/api_performance_test/node/index.js

liqiang          52006   0.0  0.2  4416020  12956 s001  S+    9:08上午   2:52.73 ./main

liqiang          55990   0.0  8.9  8016876 749292 s003  S+   11:57上午   1:11.11 /usr/bin/java -jar build/libs/gs-rest-service-0.1.0.jar

```

运行时
golang占用内存最小，且性能最好，仅占用13M。
node开了四个进程，每个进程占用60M，总240M。
java就比较厉害了，占用了750M内存，同等内存下可以开几十个go程序了。
