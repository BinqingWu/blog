# ubuntu系统升级

昨天把系统从16.04升级到20.04发现其实升级套路是一样的，不过有些系统似乎装的东西多了就很难升级。所以老系统可能还是直接备份重装比较好。

### 步骤：

1.`sudo apt-get update`

这一步就是检查源有没有更新，似乎没什么用

2.`sudo apt-get upgrade`

似乎是把能升级的都升级了？不过要注意这一步是有可能升级microcode的，所以在升级前需要reboot一下。

3.`sudo apt-get dist-upgrade`

磁盘升级？

4.`sudo apt-get autoremove`

不知道有什么用

5.`sudo apt-get install update-manager-core`
安装更新管理软件

6.`reboot`

安全起见，重启一下

7.`sudo do-release-upgrade`

开始升级，中间可能会遇到一些选项，但应该都还好。