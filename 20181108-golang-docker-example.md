# Golang Docker 示例

## 源代码 hello.go

```go
package main

import "fmt"

func main() {
	fmt.Println("Hello World")
}
```

## Dockerfile

### 一步构建

```Dockerfile
FROM golang:1.11-alpine
WORKDIR /go/src/helloworld
COPY . .
RUN go install -v ./
CMD ["helloworld"]
```

### 多阶段构建

优点是最终生成的 `image` 很小。

```Dockerfile
FROM golang:1.11-alpine
WORKDIR /go/src/helloworld
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root
COPY --from=0 /go/src/helloworld/app .
CMD ["./app"]
```

## 打包命令

```
docker build -t go-helloworld .
```

## 运行实例

```
docker run --rm go-helloworld
```
