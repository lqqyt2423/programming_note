# Linux 开机流程梳理

## 读入`/boot` 目录下的内核文件

## 运行第一个程序`/sbin/init`，作用为初始化系统环境

之间就直接链接至`/etc/init.d` 文件夹，逐一加载启动脚本。

目前`Systemd` 已经取代`initd` 成为系统的第一个进程，PID等于1，其他进程都是它的子进程。

```
lrwxrwxrwx 1 root root 20 Oct 27  2017 /sbin/init -> /lib/systemd/systemd
```

### `Systemd` 开机执行`/etc/systemd/system` 中的配置文件

Systemd 有默认的启动 Target，一般是multi-user.target，所以开机启动的配置项会放在`/etc/systemd/system/multi-user.target.wants` 目录中。

```bash
systemctl enable mongod.service
# Created symlink from /etc/systemd/system/multi-user.target.wants/mongod.service to /lib/systemd/system/mongod.service.
```

如上面命令所示，用`enable` 命令设置开机启动后，会在此目录中添加一个符号链接，指向真正的配置文件。

也可通过命令查看开机启动项：

```bash
systemctl list-unit-files --type=service | grep enabled
```

查看特定程序的开机运行状态可以为：

```bash
systemctl status mongod.service
```

在输出的`Loaded:` 表示是否会开机启动，`Active:` 表示当前的运行状态。

## 参考链接

- [Linux 的启动流程](http://www.ruanyifeng.com/blog/2013/08/linux_boot_process.html)
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
- [Systemd (简体中文) - ArchWiki](https://wiki.archlinux.org/index.php/systemd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
- [systemd 下开机启动的优化，删除无用的systemd服务](https://www.centos.bz/2018/03/systemd-%E4%B8%8B%E5%BC%80%E6%9C%BA%E5%90%AF%E5%8A%A8%E7%9A%84%E4%BC%98%E5%8C%96%EF%BC%8C%E5%88%A0%E9%99%A4%E6%97%A0%E7%94%A8%E7%9A%84systemd%E6%9C%8D%E5%8A%A1/)
