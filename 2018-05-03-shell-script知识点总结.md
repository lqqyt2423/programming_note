# shell script 知识点总结

`read -p` 可以接受用户的输入

`echo -e` `-e` 设置可以在接下来的字符串中输入换行符等符号

`$(ls)` 此形式接受括号内命令的运行结果

`$((a * b))` 可在双括号内运行加减乘除

## 文件接收自定义参数：

- `${0}` 文件名
- `${1}` 第一个参数
- `${2}` 第二个参数
- ...
- `$#` 参数的个数
- `$@` 所有参数
- `shift` 参数索引偏离

## 条件判断

### `test` 可进行条件判断

- `test -e filename` 判断文件是否存在
- `test -f filename` 判断是否为文件
- `test -d filename` 判断是否为文件夹
- ...

`[ a == b ]` 此为判断符号

### if条件判断式：

```bash
if [ 条件判断 ]; then
  code
fi
```

```bash
if [ 条件判断 ]; then
  code
else
  code
fi
```

```bash
if [ 条件判断 ]; then
  code
elif [ 条件判断 ]; then
  code
else
  code
fi
```

### case条件判断

```bash
case ${1} in
  "hello")
    echo "hello"
    ;;
  "")
    echo "null"
    ;;
  *)
    echo "anything else"
    ;;
esac
```

## function功能

```bash
function fnname() {
  code
}
```

`function` 代码段需放在调用此代码的前面。

## 循环功能

### while do

```bash
while [ condition ]
do
  code
done
```

### until do

```bash
until [ condition ]
do
  code
done
```

### for in

```bash
for var in a b c
do
  code
done
```

### for 表达式

```bash
for (( i=1; i<10; i=i+1 ))
do
  code
done
```
