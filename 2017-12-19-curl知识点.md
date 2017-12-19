# curl 知识点

### curl 默认为 get:

```
curl localhost:9200
```

### curl 请求其他method 时：

```
curl -XPOST localhost:9200
curl -XPUT localhost:9200
curl -XDELETE localhost:9200
```

### curl 带请求body：

```
curl -XPOST [url] -d '[body]'
```

### 请求头为JSON 的body：

```
curl -XPOST -H "Content-Type: application/json" -d '[body]'
```