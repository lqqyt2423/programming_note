# 最近的笔记

## Linux find 命令

正则查找当前目录下的文件或目录：

```bash
find ./ -regex .*txt
find ./ -regex ".*txt"
```

## Fix Mac Launchpad Problems

Rebuild:

```bash
defaults write com.apple.dock ResetLaunchPad -bool true
killall Dock
```

[How to Fix Launchpad Problems on Your Mac](https://www.lifewire.com/fix-launchpad-problems-in-os-x-2259966)

## docker 命令

```bash
docker image ls
docker container ls
docker container ls --all
docker ps
docker container kill id
docker container rm id
docker container exec -it [containerID] /bin/bash
```

## MySQL 相关

```
show variables like 'wait_timeout';
set global wait_timeout=10;
show variables like 'interactive_timeout';
set global interactive_timeout=10;
show variables like '%max_connections%';
```

### Linux 权限相关

```
chown -R ubuntu code
chgrp -R ubuntu code
```

### mongoose update createdAt

use doc.save() other than model.findByIdAndUpdate()
