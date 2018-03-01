#  检测JavaScript 中各种类型

```javascript
Object.prototype.toString.call({})
// => "[object Object]"

Object.prototype.toString.call('')
// => "[object String]"

Object.prototype.toString.call([])
// => "[object Array]"

Object.prototype.toString.call(1)
// => "[object Number]"

Object.prototype.toString.call(/a/)
// => "[object RegExp]"

Object.prototype.toString.call(new Date())
// => "[object Date]"

Object.prototype.toString.call(new Error())
// => "[object Error]"
```