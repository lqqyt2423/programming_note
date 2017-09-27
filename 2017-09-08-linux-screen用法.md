# linux-screen用法

### 安装

```
yum install screen
```

### 创建会话

```
screen -S name
```

### 隐藏会话快捷键

```
ctrl + a + d
```

### 恢复会话

```
screen -r name
```

### 查看已经创建的会话

```
screen -ls
```

### 其他命令

```
Ctrl + a，d #暂离当前会话
Ctrl + a，c #在当前screen会话中创建一个子会话
Ctrl + a，w #子会话列表
Ctrl + a，p #上一个子会话
Ctrl + a，n #下一个子会话
Ctrl + a，0-9 #在第0窗口至第9子会话间切换
```

### 参考来源

[linux screen的用法](http://www.jianshu.com/p/e91746ef4058)