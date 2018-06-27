# JavaScript 编程规范

### 后端

##### 接口规范（RESTFUL） 表述性状态转移，资源

1. 常见接口请求Method：Get, Put, Post, Delete, Patch, Option
  * Get（获取数据）, Option（通常用于preflight 预请求）
  * Put（修改数据）, Delete（删除数据）, Patch（修改数据）, Post（创建数据）

2. 接口命名和路由，增删改查
  * 请求列表：verb: get, path: 'events', name: 'index|list|search'
  * 请求单个：verb: get, path: 'events/:id', name: 'show'
  * 创建：verb: post, path: 'events', name: 'create'
  * 修改：verb: put, path: 'events/:id', name: 'update'
  * 删除：verb: delete, path: 'events/:id', name: 'destroy'

3. 其他命名规范
  * 避免 get，set 开头来命名函数
  * 路由统一使用下划线

4. 接口数据规范
  * 状态类的表述直接作为一个字段随接口返回， 不要添加很多无谓的接口
  * 永远要检查当前用户是否有权先修改当前数据
  * 不要出现N+1查询

5. 数据库规范
  * MongoDB 是 schema less，尽可能满足单一接口的所有需求
  * embedded documents 只能使用在有限内嵌数据，最多只能容纳16M
  * 合理使用 index
  * 把数据操作的复杂逻辑做成通用方法，写在 model 里面

### 前端

##### 页面组织逻辑

1. 所有的接口是action
2. 所有的接口数据都存在 store，尽可能共用数据
3. 尽量把功能抽象成共用组件，或者某一块功能下的共用组件，也不要过度抽象
4. 尽量少使用外部的库
5. CSS 使用 - 中杠来命名 class，多用class，而不是伪类
6. Javascript 命名规范
  * 常量：`const NAME = 'God';`
  * ES6 class：`class MyComponent` 驼峰形式，首字母大写
  * 变量：驼峰，首字母小写， `var myComponent = new MyComponent()`
  * true ? yes : no
7. 路由同接口类似
