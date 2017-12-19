# elasticsearch 知识点

### 安装中文分词插件

```
https://github.com/medcl/elasticsearch-analysis-ik/
```

### 新建索引

```
curl -XPUT localhost:9200/[index]
```

### 创建映射时的设置

下面`title` 字段表示用`ik` 插件分词，`link` 字段表示不进行任何分词

```
curl -XPOST localhost:9200/[index]/[type]/_mapping -d '{
  "properties": {
    "title": {
      "type": "text",
      "analyzer": "ik_max_word",
      "search_analyzer": "ik_max_word"
    },
    "link": {
      "type": "string",
      "index": "not_analyzed"
    }
  }
}'
```

### 查看分词配置

`pretty` 参数表示格式化查看

```
curl localhost:9200/[index]/_mapping/[type]?pretty
```

### 搜索

#### 多个搜索/过滤条件

```
curl localhost:9200/[index]/[type]/_search?pretty -d '{
  "query": {
    "bool": {
      "filter": [...],
      "should": [...],
      "must": [...],
      "must_not": [...]
    }
  }
}'
```

#### 排序

`_score` 表示搜索相关性打分。

```
curl localhost:9200/[index]/[type]/_search -d '{
  "query": {...},
  "sort": [
    { "_score": "desc" },
    { "weight": "desc" },
    { "price": "asc" }
  ]
}'
```

#### should 时添加最小匹配数量

```javascript
// 最小匹配1个
query.bool.minimum_should_match = 1;
```

#### 限制返回数据字段

```
curl localhost:9200/[index]/[type]/_search -d '{
  "query": {...},
  "_source": ["title", "name"...]
}'
```

#### 控制返回item 数量及分页

```
curl localhost:9200/[index]/[type]/_search -d '{
  "query": {...},
  "size": 20,
  "from": 10
}'
```

#### 多字段索引且提升权重

```
curl localhost:9200/[index]/[type]/_search?pretty -d '{
  "query": {
    "multi_match": {
      "query": "[keyword]",
      "fields": [ "title^3", "content" ]
    }
  }
}'
```

#### function score

- `exp` 线性
- `offset` 内`_score` 相等
- `scale` 衰减率

```
curl localhost:9200/[index]/[type]/_search?pretty -d '{
  "query": {
    "function_score": {
      "query": {...},
      "function": [
        {
          "exp": {
            "createdAt": {
              "offset": "90d",
              "scale": "720d"
            }
          }
        }
      ]
    }
  }
}'
```

### 聚合

```
curl localhost:9200/[index]/[type]/_search -d '{
  "query": {...},
  "aggs": {...}
}'
```

```javascript
// 标签聚合
let aggs = { tags_count: { terms: { field: 'tags', size: 100 } } };
```

### 查看index 数量

```
curl localhost:9200/[index]/[type]/_count
```

### 删除索引

```
curl -XDELETE localhost:9200/[index]
```

### 批量bulk 接口

请求体中，每单个请求放在每行，用换行符`\n` 隔开

```
curl -XPOST localhost:9200/_bulk -d '[body]'
```

example:

```
curl -XPOST 'localhost:9200/_bulk?pretty' -H 'Content-Type: application/json' -d'
{ "index" : { "_index" : "test", "_type" : "type1", "_id" : "1" } }
{ "field1" : "value1" }
{ "delete" : { "_index" : "test", "_type" : "type1", "_id" : "2" } }
{ "create" : { "_index" : "test", "_type" : "type1", "_id" : "3" } }
{ "field1" : "value3" }
{ "update" : {"_id" : "1", "_type" : "type1", "_index" : "test"} }
{ "doc" : {"field2" : "value2"} }
'
```
