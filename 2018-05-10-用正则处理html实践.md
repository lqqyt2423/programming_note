# 用正则表达式处理html的实践

```javascript
// 清除标签中style属性
function clearStyle(html) {
  return html.replace(/(<[a-zA-Z]+?\s.*?)(style=".*?")(.*?>)/g, (match, first, _, third) => {
    return `${first}${third}`;
  });
}
```

```javascript
// 清除标签中除了src/href外所有的属性
function clearAttr(html) {
  return html.replace(/<([a-zA-Z]+?)\s(.*?)>/g, (match, tag, other) => {
    let attr = '';
    other.replace(/(src|href)=".+?"/, match => {
      attr = ' ' + match;
    });
    return `<${tag}${attr}>`;
  });
}
```

```javascript
// </p>或</div>标签后添加换行符
function addLine(html) {
  return html.replace(/(<\/p>|<\/div>)/g, match => {
    return `${match}\n`;
  });
}
```
