# iptables相关命令

## 命令

### 带序号显示 INPUT

```bash
iptables -L INPUT -n --line-numbers
```

### 带序号显示 所有

```bash
iptables -L -n --line-numbers
```

### 删除

```bash
iptables -D INPUT 8
```

### 开放对应的端口

```bash
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

### 限制特定的IP开放端口
```bash
iptables -A INPUT -p tcp --dport 80 -j ACCEPT -s 0.0.0.0/0
```

## 参考

- [iptables 命令，Linux iptables 命令详解：Linux上常用的防火墙软件 -  Linux 命令搜索引擎](http://wangchujiang.com/linux-command/c/iptables.html)
- [鸟哥的 Linux 私房菜 -- Linux 防火墙与 NAT 服务器](http://cn.linux.vbird.org/linux_server/0250simple_firewall.php)
