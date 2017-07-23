# MongoDB和mongoose文本索引知识点

## 文本索引

### 概述

MongoDB支持在字符串内容上执行文本检索的查询操作。为了执行文本检索，MongoDB使用 [*text index*](http://docs.mongoing.com/manual-zh/core/index-text.html#index-feature-text)和 [`$text`](http://docs.mongoing.com/manual-zh/reference/operator/query/text.html#op._S_text) 操作符。

注解

[*Views*](http://docs.mongoing.com/manual-zh/core/views.html) do not support text search.

### 示例

这个示例展示了如何构建一个文本索引并且使用它在给定的唯一文本字段上查找咖啡店。

使用下列文档创建一个 `stores` 集合：

```
db.stores.insert(
   [
     { _id: 1, name: "Java Hut", description: "Coffee and cakes" },
     { _id: 2, name: "Burger Buns", description: "Gourmet hamburgers" },
     { _id: 3, name: "Coffee Shop", description: "Just coffee" },
     { _id: 4, name: "Clothes Clothes Clothes", description: "Discount clothing" },
     { _id: 5, name: "Java Shopping", description: "Indonesian goods" }
   ]
)

```

#### 文本索引

MongoDB提供 [*text indexes*](http://docs.mongoing.com/manual-zh/core/index-text.html#index-feature-text) 支持在字符串内容上的文本检索查询。 `text` 索引可以包括任何值为字符串或者字符串元素数组的字段。

为了执行文本检索查询，您必须在集合上有一个 `text` 索引。一个集合只能拥有 ** 一个 ** 文本检索索引，但是这个索引可以覆盖多个字段。

例如，您可以在 [`mongo`](http://docs.mongoing.com/manual-zh/reference/program/mongo.html#bin.mongo) shell上运行以下命令来启动 `name` 和 `description` 字段上的文本检索。

```
db.stores.createIndex( { name: "text", description: "text" } )

```

#### `$text` 操作

使用 [`$text`](http://docs.mongoing.com/manual-zh/reference/operator/query/text.html#op._S_text) 查询操作符在一个有 [*text index*](http://docs.mongoing.com/manual-zh/core/index-text.html#index-feature-text) 的集合上执行文本检索。

[`$text`](http://docs.mongoing.com/manual-zh/reference/operator/query/text.html#op._S_text) 将会使用空格和标点符号作为分隔符对检索字符串进行分词， 并且对检索字符串中所有的分词结果进行一个逻辑上的 `OR` 操作。

例如，您可以使用下面的查询语句来找到所有包含 “coffee”, “shop”, 以及 “java” 列表中任何词语的商店：

```
db.stores.find( { $text: { $search: "java coffee shop" } } )

```

##### 精确检索

您也可以通过将它们包括在双引号中来进行精确检索。例如，下列的命令将会找到所有包含”java” 或者 “coffee shop” 的文档：

```
db.stores.find( { $text: { $search: "java \"coffee shop\"" } } )

```

##### 词语排除

为了排除一个词语，您可以在前面加上一个 “`-`” 字符。例如，为了找到所有包含 “java” 或者 “shop” 但是不包含 “coffee” 的商店，使用下面的命令：

```
db.stores.find( { $text: { $search: "java shop -coffee" } } )

```

##### 排序

MongoDB默认返回未经排序的结果。然而，文本检索查询将会对每个文档计算一个相关性分数，表明该文档与查询的匹配程度。

为了使用相关性分数进行排序，您必须显式地对 [`$meta`](http://docs.mongoing.com/manual-zh/reference/operator/projection/meta.html#proj._S_meta) [``](http://docs.mongoing.com/manual-zh/text-search.html#id1)textScore``字段进行映射然后基于该字段进行排序。

```
db.stores.find(
   { $text: { $search: "java coffee shop" } },
   { score: { $meta: "textScore" } }
).sort( { score: { $meta: "textScore" } } )

```

文本检索可以在聚合管道中使用。

## Mongodb全文搜索实战

在传统的关系型数据库中，我们通常将数据结构化，通过一系列表关联、聚合来查询我们所需的结果。而在非结构化的数据中，缺少这种预定义的结构，因而如何快速查询定位到我们所需要的结果，不是一件容易的事。

Mongodb作为一种NoSQL数据库，非常适合存储和管理非结构化数据，例如互联网上的各种文本数据。假如我们用Mongodb存储了很多博客文章，那么如何快速找到所有关于“nodejs”这个主题的文章呢？Mongodb内建的全文搜索可以帮助我们完成这个功能。

在本篇博文中，将要介绍的是我使用Mongdb text search的一些经验。

#### Mongodb text search是什么？

Mongodb text search是Mongodb对数据库进行搜索的功能模块，类似于数据库内建的搜索引擎。有些人可能会疑问，查数据库为什么还需要搜索引擎？直接用条件查询不就得了。例如在前面的文章主题搜索中，我们不可能事先提取出每篇文章的主题，然后用专门的字段存储，因此没办法进行条件查询。并且同一个主题词，有多种不同的表达方式，例如”node”、”nodejs”可视为同一个主题。

Mongodb text search可以自动地对大段的文本数据进行分词处理、模糊匹配、同义词匹配，解决文本搜索的问题。

#### 建立文本索引

要使Mongodb能够进行全文搜索，首先要对搜索的字段建立文本索引。建立文本索引的关键字是`text`，我们既可以建立单个字段的文本索引，也可以建立包含多个字段的复合文本索引。**需要注意的是，每个collection只能建立一个文本索引，且只能对String或String数组的字段建立文本索引**。

我们可以通过以下命令，建立一个文本索引：

```
db.collection.createIndex({ subject: "text", content: "text" })
```

在mongoose中我们可以通过以下代码，创建文本索引：

```
schema.index({ subject: "text", content: "text" })
```

需要注意的是，由于每个collection只支持一个文本索引，所以当你需要在schema中添加或删除文本索引字段时，往往不起作用。这时候你需要到数据库中，手动删除已经建立的文本索引。

#### 文本搜索示例

文本搜索的语法为：

```
{
  $text:
    {
      $search: <string>,
      $language: <string>,
      $caseSensitive: <boolean>,
      $diacriticSensitive: <boolean>
    }
}
```

在mongoose中，我们可以通过以下语句进行文本搜索：

```
var query = model.find({ $text: { $search: "hello world" } })
```

`$search`后面的关键词可以有多个，关键词之间的分隔符可以是多种字符，例如空格、下划线、逗号、加号等，但不能是`-`和`\"`，因为这两个符号会有其他用途。搜索的多个关键字是`or`的关系，除非你的关键字包含`-`。例如`hello world`会包含所有匹配`hello`或`world`的文本，而`hello -world`只会匹配包含`hello`且不包含`world`的文本。

`$language`指示搜索的语言类型，在最新的Mongodb 3.2 enterprise版本中，已经增加了对中文文本的搜索。

`$caseSensitive`设置是否区分大小写。

`$diacriticSensitive`设置是否区别发音符号，`CAFÉ`于`Café`是同一语义，只是重音不一样。

我们还可以对搜索的结果按匹配度进行排序：

```
db.posts.find(
   { $text: { $search: "hello world" } },
   { score: { $meta: "textScore" } }
).sort( { score: { $meta: "textScore" } } )
```

#### 注意事项

Mongodb建立文本索引时，会对提取所有文本的关键字建立索引，因而会造成一定的性能问题。所以对于结构化的字段，建议用普通的关系查询，如果需要对大段的文本进行搜索，才考虑用全文搜索。