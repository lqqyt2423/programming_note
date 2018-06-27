# 服务器设置SSH 通过密钥登录

通过给Linux 服务器设置密钥登录，可以避免每次登录服务器都输入密码，也会更安全一些。

> 密钥形式登录的原理是：利用密钥生成器制作一对密钥——一只公钥和一只私钥。将公钥添加到服务器的某个账户上，然后在客户端利用私钥即可完成认证并登录。这样一来，没有私钥，任何人都无法通过 SSH 暴力破解你的密码来远程登录到系统。此外，如果将公钥复制到其他账户甚至主机，利用私钥也可以登录。

下面是服务器生成密钥及客户端登录的过程：

## 1. 在服务器上制作密钥对

在`bash` 中输入下面命令，多敲几次回车即可在目录`/root/.ssh/` 中生成`id_rsa` 公钥及`id_rsa.pub` 私钥

```
ssh-keygen
```

## 2. 通过`scp` 将私钥保存下载在自己的客户端电脑上

## 3. 在服务器上安装公钥且修改对应文件的权限

```
cd .ssh
cat id_rsa.pub >> authorized_keys

chmod 600 authorized_keys
chmod 700 ~/.ssh
```

## 4. 编辑SSH 配置文件`/etc/ssh/sshd_config`

- 第三行表示root 用户可以通过SSH 登录
- 第四行表示禁止用密码登录

```
RSAAuthentication yes
PubkeyAuthentication yes
PermitRootLogin yes
PasswordAuthentication no
```

## 5. 重启SSH 服务

```
service sshd restart
```

## 6. 在本地电脑上远程登录即可

```
ssh root@xxx.xx.xx.xx -i ~/ssh_pub.pem
```

> 原文地址：[设置 SSH 通过密钥登录](https://hyjk2000.github.io/2012/03/16/how-to-set-up-ssh-keys/)