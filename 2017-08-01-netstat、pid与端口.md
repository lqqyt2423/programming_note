# netstat、pid与端口

查看端口5555所占用的pid

```
netstat -vanp tcp | grep 5555
```

或

```
lsof -nP -iTCP:5555 -sTCP:LISTEN
```

输出该端口占用的pid

```
lsof -nP -iTCP:5555 |grep LISTEN|awk '{print $2;}'
```

Linux:

```
netstat -nlp
```

查看某应用占用的进程：

```
ps aux | grep ruby
```

参考：

[使用 lsof 代替 Mac OS X 中的 netstat 查看占用端口的程序](https://tonydeng.github.io/2016/07/07/use-lsof-to-replace-netstat/)

