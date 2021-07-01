# CUDA10.2/8.0安装

这两天尝试了20.04装cuda10.2 , 18.04装cuda10.2+cuda8.0

[https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)

其实CUDA安装如果跟着安装文档走的话，一般不会有太大的问题，但是安装文档有一个问题就是假如ubuntu版本不对，那么你需要自己找相关的命令。

### 安装前准备

（1）禁用nouveau（开源驱动）

`sudo vi /etc/modprobe.d/blacklist-nouveau.conf`

填入

blacklist nouveau

options nouveau modeset=0

更新？

`sudo update-initramfs -u`

重启

`reboot`

检查

`lsmod | grep nouveau`

（2）调整runlevel到3

不确定runlevel为5能不能装，但是因为比较方便，所以我都是先调到3再装的

[https://askubuntu.com/questions/788323/how-do-i-change-the-runlevel-on-systemd](https://askubuntu.com/questions/788323/how-do-i-change-the-runlevel-on-systemd)

`sudo systemctl set-default multi-user.target`

`reboot`

检查

`runlevel`

（3）gcc，g++以及相关库的安装

`sudo apt-get install build-essential`

注意这部分在逆版本安装中还需要对gcc，g++做额外处理，因为cuda可能不支持当前gcc版本，这个后续会在另一个page说。

### 开始安装

---

`sudo sh xxxx.run`

这个run安装的话，如果你没安装驱动，也可以帮你安装上去，所以会比较方便。比较关键的选项有

1.是否装驱动 2.是否装toolkit 3.指定toolkit安装目录(默认usr/local/cuda-10.2) 4.是否创建软连接（usr/local/cuda） 5.是否装example

### 安装后

---

之后要做的就是装cudnn，然后给cuda配置全局环境变量，这些也会在其他配置里写的。

环境变量：

`export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH`

`export PATH=/usr/local/cuda/bin:$PATH`

`export CUDA_HOME=/usr/local/cuda:$CUDA_HOME`

注意，notion中似乎不能直接复制，粘贴，会存在不可知的问题。很无语。找到原因了，是空格的问题，notion的空格似乎特殊一点。

另一个本身的问题则是，应该按照添加字符+变量名来赋值，而不是变量名+添加字符？（我也不知道，但总之是应该统一的）不过实测变量名最后有：不影响判别，变量名重复不影响判别。

### 逆版本安装cuda8.0的坑点

[https://blog.csdn.net/xiaoyang19910623/article/details/108407959](https://blog.csdn.net/xiaoyang19910623/article/details/108407959)

我想知道export，systemctl有什么用法？

### 如何一台电脑安装多个cuda版本？

cuda安装的时候是默认可以安装多个版本的，因为它实际保存的目录是cuda-版本号，然后会创建一个cuda的软链接。这样在安装其他版本的时候是不会覆盖原cuda的，最多覆盖掉软链接。

然后关于anaconda虚拟环境中的cuda和电脑裸机中cuda的问题，其实如果是在虚拟环境运行程序的话，用到的应该是 裸机驱动+虚拟环境cuda。所以这时候裸机其实只要安装显卡驱动就行了。

但是昨天师兄的那个虚拟环境居然也要用到裸机的cuda，那这是为什么呢？后续再测试一下。

### 检查

检查驱动是否安装用nvidia-smi

汇总

cuda:

`sudo vi /etc/modprobe.d/blacklist-nouveau.conf`

blacklist nouveau

options nouveau modeset=0

`sudo update-initramfs -u`

`sudo systemctl set-default multi-user.target`

`reboot`

`lsmod | grep nouveau`

`runlevel`

`sudo apt-get install build-essential`

`sudo sh cuda_10.2.89_440.33.01_linux.run`

cudnn:

tar -zxvf cudnn-10.2-linux-x64-v8.0.5.39.tgz

`sudo cp cuda/include/* /usr/local/cuda-10.2/include/
sudo cp cuda/lib64/* /usr/local/cuda-10.2/lib64/
sudo chmod a+r /usr/local/cuda-10.2/include/*
sudo chmod a+r /usr/local/cuda-10.2/lib64/*`