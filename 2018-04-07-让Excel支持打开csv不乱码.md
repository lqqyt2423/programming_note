# 让Excel 支持打开CSV 不乱码

当用程序导出`UTF-8` 编码的`CSV` 格式的文件时，通常用`Mac` 中的`Numbers` 打开是正常的，但是用`Excel` 打开时，中文就会变成乱码。

原因如下：

> `Excel` 本身是对应了`UTF-8` 编码的，但当`CSV` 文件是`UTF-8` 编码时，原封不动的双击打开`CSV` 文件时，`Excel` 是无法识别为`UTF-8` 的，而是按照系统默认字符`ANSI` （简体中文`GB2312`、日文`Shift_JIS`）来处理的就乱码了。所以根本原因是`Excel` 字符集识别的问题。

解决办法如下：

在`CSV` 文件头部添加`BOM(Byte order mark)` 即可，添加之后`Excel` 便可以识别此文件是`UTF-8` 编码了。

> 带`BOM` 的文件会比不带`BOM` 的文件多出3个字节，这三个字节是固定的：`0xEF 0xBB 0xBF`，其`Unicode` 为`\uFEFF`。 

`JavaScript` 代码：

```javascript
function addBom(csv) {
  const bom = Buffer.from('\uFEFF');
  const csvBuf = Buffer.from(csv);
  return Buffer.concat([bom, csvBuf]).toString();
}
```

参考：

- [csv 文件打开乱码，有哪些方法可以解决？](https://www.zhihu.com/question/21869078/answer/350728339)
- [Excel打开CSV文件乱码的问题](http://rensanning.iteye.com/blog/2336005)
