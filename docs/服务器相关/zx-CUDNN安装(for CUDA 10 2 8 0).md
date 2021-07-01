# CUDNN安装(for CUDA 10.2/8.0)

tar -zxvf cudnn-10.2-linux-x64-v8.0.5.39.tgz

`sudo cp cuda/include/* /usr/local/cuda-10.2/include/
sudo cp cuda/lib64/* /usr/local/cuda-10.2/lib64/
sudo chmod a+r /usr/local/cuda-10.2/include/*
sudo chmod a+r /usr/local/cuda-10.2/lib64/*`