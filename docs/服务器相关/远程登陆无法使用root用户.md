# 远程登陆无法使用root用户

## 修改配置文件

编辑`sudo vim /etc/ssh/sshd_config`文件，将`PermitRootLogin`的值修改为`yes`

## 重启

/etc/init.d/ssh restart

