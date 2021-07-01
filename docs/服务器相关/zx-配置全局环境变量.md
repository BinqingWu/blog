# 配置全局环境变量

两种方法

/etc/profile或者/etc/bash.bashrc

第二种不用重启，那就第二种吧。

### 步骤：

`sudo vi /etc/bash.bashrc`

在最后一行添加：

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

export PATH=/usr/local/cuda/bin:$PATH

export CUDA_HOME=/usr/local/cuda:$CUDA_HOME

之后可以source /etc/bash.bashrc