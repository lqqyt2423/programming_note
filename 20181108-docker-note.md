# Docker 学习笔记

## docker 官方仓库

`https://hub.docker.com/`

## 常用命令

```bash
# 验证是否安装成功
docker version
docker info

# 列出本机所有 image 文件
docker image ls
# 删除 image 文件
docker image rm [imageName]

# 从远程仓库拉取 image 至本地
docker image pull library/hello-world
# docker 官方提供的 image 文件都放在 library 组里面
# 或
docker image pull hello-world

# 运行 image 文件
# 此命令会在本地没有 image 的情况下自动从远程拉取
docker container run hello-world

docker container run -it ubuntu bash

# 列出本机正在运行的容器
docker container ls
# 或
docker ps
# 列出本机所有容器，包括终止运行的容器
docker container ls --all

# 手动终止容器
docker container kill [containerID]

# 删除容器文件
docker container rm [containerID]

# 启动已经生成的容器文件
docker container start [containerID]
# 渐进退出
docker container stop [containerID]

# 查看输出
docker container logs [containerID]

# 进入一个正在运行的 docker 容器
# 适用于 docker run 时没有使用 -it 参数的情况
docker container exec -it [containerID] /bin/bash

# 文件拷贝至本机当前目录
docker container cp [containerID]:[/path/to/file] .
```

## Dockerfile 文件

Dockerfile 是一个文本文件，用来配置 image。

### 示例

```
# 该 image 文件继承官方的 node image，冒号表示标签，这里标签是8.4，即8.4版本的 node
FROM node:8.4
# 将当前目录下的所有文件（除了.dockerignore排除的路径），都拷贝进入 image 文件的/app目录
COPY . /app
# 指定接下来的工作路径为/app
WORKDIR /app
# 在/app目录下，运行npm install命令安装依赖。注意，安装后所有的依赖，都将打包进入 image 文件
RUN npm install --registry=https://registry.npm.taobao.org
# 将容器 3000 端口暴露出来， 允许外部连接这个端口
EXPOSE 3000
```

```bash
# 创建 image 文件
# -t 用来指定 image 文件的名字
# 后面的冒号指定标签，如果不指定，默认为 latest
# 最后的 . 表示 Dockerfile 文件在当前目录
docker image build -t koa-demo .
# 或者
docker image build -t koa-demo:0.0.1 .

# 运行成功后就可以看到新生成的 image 文件了
docker image ls

# 生成容器
# -p 容器的 3000 端口映射至本机的 8000 端口
# -it 容器的 Shell 映射至当前的 Shell
# /bin/bash 容器启动之后，内部第一个执行的命令，这里启动 Bash，保证用户可以使用 Shell
docker container run -p 8000:3000 -it koa-demo /bin/bash
# 或
docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash

# --rm 在容器终止运行后自动删除容器文件
docker container run --rm -p 8000:3000 -it koa-demo /bin/bash
```

### CMD 命令

```
FROM node:8.4
COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 3000

# 容器启动后自动执行 node demos/01.js
CMD node demos/01.js
```

> RUN 命令和 CMD 命令的区别？
> RUN 命令在 image 文件的构建阶段执行，执行结果都会打包进入 image 文件；CMD 命令在容器启动后执行。一个 Dockerfile 可以包含多个 RUN 命令，但是只能有一个 CMD 命令。

```bash
# 因为指定了 CMD 命令，所以就不用附加命令了，否则会覆盖 CMD 命令
docker container run --rm -p 8000:3000 -it koa-demo:0.0.1
```

### 发布

```bash
docker login

# 为本地 image 标注用户名和版本
docker image tag [imageName] [username]/[repository]:[tag]
# 或者重新构建一下 image 文件
docker image build -t [username]/[repository]:[tag]

docker image push [username]/[repository]:[tag]
```

## docker container run 命令参数

```
--name name 定义容器的名字
--volume "$PWD":/var/www/html 将当前目录映射到容器对应的目录
-p 8000:3000 容器的 3000 端口映射至本机的 8000 端口
-d 容器启动后，在后台运行
--env 向容器进程传入一个环境变量
```

## 示例 WordPress

### A

```bash
# php
docker container run \
  -d \
  --rm \
  --name php \
  -p 5000:80 \
  --volume "$PWD":/var/www/html \
  php:5.6-apache

# mysql
docker container run \
  -d \
  --rm \
  --name wpdb \
  --env MYSQL_ROOT_PASSWORD=123456 \
  --env MYSQL_DATABASE=wordpress \
  mysql:5.7
```

```
FROM php:5.6-apache
RUN docker-php-ext-install mysqli
CMD apache2-foreground
```

```bash
docker build -t phpwithmysql .

# --link wpdb:mysql 标识此容器连到 wpdb 容器，冒号表示该容器的别名是 mysql
docker container run \
  -d \
  --rm \
  --name php \
  -p 5000:80 \
  --volume "$PWD":/var/www/html \
  --link wpdb:mysql \
  phpwithmysql
```

### B

```bash
# mysql
docker container run \
  -d \
  --rm \
  --name wpdb \
  --env MYSQL_ROOT_PASSWORD=123456 \
  --env MYSQL_DATABASE=wordpress \
  mysql:5.7

# wordpress
docker container run \
  -d \
  --rm \
  --name wordpress \
  -p 5000:80 \
  --env WORDPRESS_DB_PASSWORD=123456 \
  --link wpdb:mysql \
  --volume "$PWD/wordpress":/var/www/html \
  wordpress
```

### C: Docker Compose

```bash
# 启动所有服务
docker-compose up
# 关闭所有服务
docker-compose stop
# 删除
docker-compose rm

# 看是否安装好
docker-compose --version
```

`docker-compose.yml`

```yml
mysql:
    image: mysql:5.7
    environment:
     - MYSQL_ROOT_PASSWORD=123456
     - MYSQL_DATABASE=wordpress
web:
    image: wordpress
    links:
     - mysql
    environment:
     - WORDPRESS_DB_PASSWORD=123456
    ports:
     - 5000:80
    working_dir: /var/www/html
    volumes:
     - wordpress:/var/www/html
```
