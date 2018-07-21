# Mongo 性能优化相关

## 组合索引相关

组合索引是顺序相关的，顺序不同的索引对于不同的查询会产生不同的效果。

组合索引支持与索引字段的前缀匹配的查询。

```
db.produces.createIndex({ "item": 1, "stock": 1 })

# 下面两个 query 都会用到此索引：
db.products.find({ item: 'Banana' })
db.products.find({ item: 'Banana', stock: { $gt: 5 } })
```

排序相关

```
db.data.createIndex({ a: 1, b: 1, c: 1, d: 1 })
```

support | used Index Prefix
--- | ---
`db.data.find().sort({ a: 1 })` | `{ a: 1 }`
`db.data.find().sort({ a: -1 })` | `{ a: 1 }`
`db.data.find().sort({ a: 1, b: 1 })` | `{ a: 1, b: 1 }`
`db.data.find().sort({ a: -1, b: -1 })` | `{ a: 1, b: 1 }`
`db.data.find().sort({ a: 1, b: 1, c: 1 })` | `{ a: 1, b: 1, c: 1 }`
`db.data.find({ a: { $gt: 4 } }).sort({ a: 1, b: 1 })` | `{ a: 1, b: 1 }`

support | used Index Prefix
--- | ---
`db.data.find({ a: 5 }).sort({ b: 1, c: 1 })` | `{ a: 1, b: 1, c: 1 }`
`db.data.find({ b: 3, a: 4 }).sort({ c: 1 })` | `{ a: 1, b: 1, c: 1 }`
`db.data.find({ a: 5, b: { $lt: 3 } }).sort({ b: 1 })` | `{ a: 1, b: 1 }`

```
# not support
db.data.find({ a: { $gt: 2 } }).sort({ c: 1 })
db.data.find({ c: 5 }).sort({ c: 1 })
```

## 索引相关操作

列出所有索引

```
db.collection.getIndexes()
```

删除索引

```
db.collection.dropIndex({ a: 1 })
```

删除所有索引

```
db.collection.dropIndexes()
```

查看索引的调用数据

```
db.collection.aggregate([{ $indexStats: {} }])
```

## explain() 返回 query 的详细信息

```
db.collection.explain().<method(...)>

Verbosity Modes:
queryPlanner Mode (default)
executionStats Mode eg: db.users.explain('executionStats').count({})
allPlansExecution Mode
```

[explain results](https://docs.mongodb.com/manual/reference/explain-results/)

## [Database Profile](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/)

```
db.getProfilingStatus()
db.setProfilingLevel(2)
db.setProfilingLevel(1, { slowms: 20 })

# disable
db.setProfilingLevel(0)
```

```
collection: system.profile
```

[database profiler output](https://docs.mongodb.com/manual/reference/database-profiler/)
