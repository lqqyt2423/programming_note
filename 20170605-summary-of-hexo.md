#  基于Hexo搭建博客知识点记录

搭建前提：首先安装Node 。

## 安装

打开终端，输入命令，表示全局安装：

```
npm install hexo-cli -g
```

## 初始化

安装好之后，便可以选定文件夹，快速开始了：

```
hexo init blog
cd blog
```

此时等命令行运行完成后，输入：

```
hexo server
```

即可在终端输出提示网址，用浏览器打开此本地网址便可测试成功运行。

## 发布文章

新建文章命令：

```
hexo new "title name"
```

之后便会在`source/_posts` 文件夹中新建文章文件。如需更改默认文件命名，可通过配置`_config.yml` 文件中的`new_post_name` 字段来实现，例如我一开始就是这样配置的：

```
new_post_name: :year-:month-:day-:title.md
```

然后也可配置文章的固定链接，我会修改成下面的格式：

```
permalink: :year-:month-:title.html 
```

编辑好文章之后，可以通过下面命令生成静态文件，之后便可输入上面的`hexo server` 命令本地测试：

```
hexo generate
```

可在输入以上命令之前清除缓存：

```
hexo clean
```

## 配置网站相关

要发布至`GitHub` 上面，还需配置`_config.yml` 文件，在`deploy` 关键词下输入自己的仓库地址：

```
deploy:
  type: git
  repository: https://github.com/lqqyt2423/lqqyt2423.github.io.git
  branch: master
```

前提是需要自己申请好`GitHub` 账号及做好相关配置。

## 发布至远程仓库

最后本地测试成功，可通过下面命令同步至远程仓库中，即发送在自己的博客网站上：

```
hexo deploy
```

## 配置主题

下载主题文件，放在`themes` 文件夹中，然后修改根目录中`_config.yml` 文件中对应`theme` 字段即可，本站用的是next 主题，则文件中对应的配置如下：

```
theme: next
```
## 参考网址

- [Hexo GitHub 主页](https://github.com/hexojs/hexo)
- [教程-HEXO搭建个人博客](http://baixin.io/2015/08/HEXO%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/)
- [Hexo 文档](https://hexo.io/docs/)
- [NexT 主题](http://theme-next.iissnan.com/getting-started.html)
- [创建标签云页面](https://github.com/iissnan/hexo-theme-next/wiki/%E5%88%9B%E5%BB%BA%E6%A0%87%E7%AD%BE%E4%BA%91%E9%A1%B5%E9%9D%A2)