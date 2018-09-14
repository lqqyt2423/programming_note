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
```
