---
title: 图神经基础知识
authors:
  - wbq
---

# 图神经基础知识
## 总览
- 线性代数
    - 正定、半正定、对角、对称矩阵，特征值、特征向量、对角化
- 图的基本知识
    - 邻接矩阵、度矩阵、拉普拉斯矩阵
- 傅里叶变换
- 图傅里叶变换
- 图卷积
- GNN的优缺点和变式

## 线性代数
### **实对称、正定、半正定、对角矩阵**
  - **实对称矩阵：** 如果有 $n$ 阶矩阵 $A$，其矩阵的元素都为实数，且矩阵$A$的转置等于其本身（ $a_{ij}=a_{ji}$ ），( $i$ , $j$ 为元素的脚标），则称 $A$ 为实对称矩阵。
    - 对称矩阵一定有 $n$ 个线性无关的特征向量
    - 实对称矩阵都可以对角化
    - 对称矩阵的特征向量相互正交，即所有特征向量构成的矩阵为傅里叶变换
  
  - **正定矩阵:** 给定一个大小为$n \times n$的实对称矩阵 $A$ ,若对于任意长度为 $n$ 的非零向量 $x$ ，有 $x^TAx > 0$ 恒成立，则矩阵 $A$ 是一个正定矩阵。
    - 每个正定阵都是可逆的，它的逆也是正定阵
  
  - **半正定矩阵:** 给定一个大小为 $n \times n$ 的实对称矩阵 $A$ ，若对于任意长度为 $n$ 的非零向量 $x$，有 $x^TAx \geq 0$ 恒成立，则矩阵 $A$ 是一个半正定矩阵。
    - 半正定矩阵的特征值一定非负
  
  - **对角矩阵:** 是一个主对角线之外的元素皆为0的矩阵。
    - 对角矩阵在连乘的时候，计算很方便。
    
    $$
    A = \left[  
        \begin{array}{cccc}
            a & 0 & 0 & 0 \\
            0 & b & 0 & 0 \\
            0 & 0 & c & 0 \\
            0 & 0 & 0 & d
        \end{array}
        \right]
    , A^{100}=\left[
        \begin{array}{cccc}
        a^{100} & 0 & 0 & 0 \\ 
        0 & b^{100} & 0 & 0 \\
        0 & 0 & c^{100} & 0 \\ 
        0 & 0 & 0 & d^{100}
        \end{array}
        \right]
    $$

### 奇异值
[SVD（奇异值分解）小结](https://www.cnblogs.com/endlesscoding/p/10033527.html)

### **特征值和特征向量**  
  $A$是一个矩阵（线性变换），$x$是一个向量。若向量$x$经过线性变换$A$后仍和原向量共线，即满足$Ax = \lambda x$，那么，就称$x$为特征向量，$\lambda$为特征值。注意，$\lambda$为标量，即特征向量的长度在该线性变换下缩放的比例，可为负值。  
  
  - **求解特征值的思路:**   
    
    $$
    \begin{aligned} 
    Ax &= \lambda x \\ 
    Ax-\lambda Ix &= 0 \\ 
    (A-\lambda I)x &= 0
    \end{aligned}
    $$  
    
    如果$x$本身是零向量，等式成立。也就是说，零向量肯定是特征向量。若向量$x$非零，为求解该向量，我们考虑，若一个矩阵与非零向量的乘积为零向量，当且仅当，矩阵代表的变换将空间压缩到更低维度即矩阵非满秩。对应的，该矩阵的行列式为零。因为行列式就是矩阵对应的线性变换对空间的拉伸程度的度量，或者说物体经过变换前后的体积比。特别地，如果矩阵不是满秩的，意味着一个$n$维的空间变换后被压扁了，变成了其中的一个$n-1$维的超平面甚至是维度更低的超直线，所以原来空间中的体积元在变换后体积为0，此时行列式也是0。
    
    $$
    \text{det}(A-\lambda I) = 0
    $$  
    
    求出$\lambda$后再回代到$(A-\lambda I)x = 0$,求出$x$。

### **对角化**
- $X^{-1}AX=\Lambda$,对角化后得到的矩阵为对角矩阵。$A$是原矩阵，$X$是特征向量组成的矩阵
- $X^{-1}AX=\Lambda \Leftrightarrow A = X\Lambda X^{-1}$ 
- 矩阵对角化就是把一组基上的线性变换用另一组基来描述，用后一组基描述时，线性变换只是单纯的伸缩变换,因为是特征向量做基。
- 实对称矩阵$A$必能对角化。且实对称矩阵$A$对应于不同特征值的特征向量必正交 (相乘为零向量)。若一组正交基内的基向量的模长都是单位长度1，则称这组正交基为标准正交基。


 <span id = "ref" style="font-size:20px">Ref</span>

1. [3Blue1Brown, 特征向量与特征值](https://www.bilibili.com/video/BV1ys411472E?p=14)

2. [wiki, 特征值和特征向量](https://zh.wikipedia.org/wiki/%E7%89%B9%E5%BE%81%E5%80%BC%E5%92%8C%E7%89%B9%E5%BE%81%E5%90%91%E9%87%8F)

3. [知乎,浅谈「正定矩阵」和「半正定矩阵」](https://zhuanlan.zhihu.com/p/44860862)


4. [知乎，行列式的意义是什么？](https://www.zhihu.com/question/26294660)

5. [知乎，矩阵对角化与奇异值分解](https://zhuanlan.zhihu.com/p/34281291)

## 图的基本知识
### **邻接矩阵、度矩阵、拉普拉斯算子、拉普拉斯矩阵**
  - **邻接矩阵 $A$:** 表示顶点之间相邻关系的矩阵.若$(v_{i},v_{j})\in E(G)$，$A_{{ij}} = 1$，否则$A_{{ij}} = 0$
    - $A^{n}$的元素 $A_{ij}^{n}$ 可以表示由顶点 $i$ 到顶点 $j$ 长度为 $n$ 的径的数目
    - 度数正规化：$\hat{A} = D^{-\frac{1}{2}}AD^{\frac{1}{2}}$, 使得特征值介于$[-1,1]$，若第二大的特征值小于1，则图联通(无向图，图连通)。<span id = "" style ="color:red">
  - **度矩阵 $D$:** 给定一个图$G=(V,E)$与$|V|=n$，$G$的度数矩阵$D$是一个$n\times n$的对角线矩阵，其定义为
    
    $$
    d_{i, j}:=\left\{\begin{array}{cc}
    \operatorname{deg}\left(v_{i}\right) & \text { if } i=j \\
    0 & \text { otherwise }
    \end{array}\right.
    $$
    
    其中度数$\deg(v_{i})$为这个顶点上的边的条数。

   - **拉普拉斯算子：**$\Delta f=\sum_{i}\frac{\partial^2{f}}{\partial^2{x}}$，即非混合二阶偏导数的和。$f$是拉普拉斯算子作用的函数，求函数各向二阶导数再求和，定义为$f$上的拉普拉斯算子。由于图是一种离散数据，那么其拉普拉斯算子必然要进行离散化。
      - 一维
        
        $$\begin{aligned}
        f^{\prime \prime}(x) &=\frac{\partial^{2} f(x)}{\partial^{2} x} \\
        &=f^{\prime}(x)-f^{\prime}(x-1)=f(x+1)-f(x)-(f(x)-f(x-1)) \\
        &=f(x+1)+f(x-1)-2 f(x) \\
        &=[f(x+1)-f(x)]+[f(x-1)-f(x)]
        \end{aligned}$$
        
        一维函数其自由度可以理解为2，分别是+1方向和-1方向
      
      - 二维

        $$\begin{aligned}
        (\Delta f)_{i} &=\sum_{j} \frac{\partial^{2} f_{i}}{\partial j^{2}} \approx \sum_{j \in N_{i}} a_{i j}\left(f_{i}-f_{j}\right) \\
        &=\sum_{j} a_{i j}\left(f_{i}-f_{j}\right)=\left(\sum_{j} a_{i j}\right) f_{i}-\sum_{j} a_{i j} f_{j} \\
        &=(D f)_{i}-(A f)_{i}=[(D-A) f]_{i}
        \end{aligned}$$
        
        - 拉普拉斯算子就是在所有自由度上进行微小变化后获得的总增益。
  
  - **拉普拉斯矩阵:** $L = D-A$, 正则化的拉普拉斯矩阵：$\hat{L} = D^{-\frac{1}{2}}LD^{\frac{1}{2}} = I-D^{-\frac{1}{2}}AD^{\frac{1}{2}}$
    - 图拉普拉斯算子作用在由图节点信息构成的向量$f$,得到的结果等于图拉普拉斯矩阵和向量$f$的点积
  
### **图相关的矩阵规律**
 - $X$是节点本身的矩阵（考虑一维），$A$是邻接矩阵，$L$是拉普拉斯矩阵
      - $Ax = [\sum_j a_{ij}x_{j}]$, 邻点总和
      - $X^TAX = \sum_i \sum_j a_{ij} x_i x_j$, 点对连乘相加
      - $LX = [\sum_j a_{ij}(x_i-x_j)]$, 邻点与自身差异总和
      - $X^{T} L X=X^{T}(D-A) X=X^{T} D X-X^{T} A X$
        
        $$\begin{aligned}
        X^{T} L X &=\sum_{i=1}^{n} d_{i} x_{i}^{2}-\sum_{i=1}^{n} \sum_{j=1}^{n} a_{i j} x_{i} x_{j} \\
        &=\frac{1}{2}\left(\sum_{i=1}^{n} d_{i} x_{i}^{2}-2 \sum_{i=1}^{n} \sum_{j=1}^{n} a_{i j} x_{i} x_{j}+\sum_{j=1}^{n} d_{j} x_{j}^{2}\right) \\
        &=\frac{1}{2} \sum_{i=1}^{n} \sum_{j=1}^{n}\left(a_{i j} x_{i}^{2}-2 a_{i j} x_{i} x_{j}+a_{i j} x_{i}^{2}\right) \\
        &=\frac{1}{2} \sum_{i=1}^{n} \sum_{j=1}^{n} a_{i j}\left(x_{i}-x_{j}\right)^{2} \geq 0
        \end{aligned}$$

      - 拉普拉斯是半正定矩阵。
  
  - **拉普拉斯矩阵的谱分解：** 拉普拉斯矩阵的谱分解就是特征分解。由于拉普拉斯矩阵是半正定对称矩阵，对其进行对角化处理，$L = V \Lambda V^{-1} = V \Lambda V^{-T}$。根据半正定对称矩阵的特性，$V$中的这些特征向量都是彼此的标准正交基。

<span id = "ref2" style="font-size:20px">Ref</span>

1. [wiki，度矩阵](https://zh.wikipedia.org/zh-hans/%E9%82%BB%E6%8E%A5%E7%9F%A9%E9%98%B5)

2. [ntnu，Graph_Spectrum](http://web.ntnu.edu.tw/~algo/GraphSpectrum.html#2)

3. [xtf615，图卷积神经网络理论基础](http://xtf615.com/2019/02/24/gcn/)

4. http://tkipf.github.io/

## 傅里叶变换
傅里叶变换的公式：　

$$
\hat{g}(f)=\int_{-\infty}^{+\infty} g(t) e^{-2 \pi i t f} d t
$$

  - 一个逆时针旋转360°画成的圆: $e^{2 \pi i }$
  - 表示运动，需要原函数的自变量，时间$t$: $e^{2 \pi it}$
  - 表示旋转速度，需要自变量，频率$f$: $e^{2 \pi itf}$
  - 规定变换的采样方向为顺时针，加负号: $e^{-2 \pi itf}$
  - 乘以原函数缠绕到单位圆并记录(此处使用$g$符号标识原函数)： $g(t)e^{-2 \pi itf}$
  - 为了计算质心特征
    - 取很多个点，求平均$\frac{1}{N} \sum_{k=1}^{N} g\left(t_{k}\right) e^{-2 \pi i f t}$
    - 随着采样点的增加，需要使用积分来求解这个问题: $\frac{1}{t_{2}-t_{1}} \int_{t_{1}}^{t_{2}} g(t) e^{-2 \pi i f t} d t$
    - 忽略系数，积分：$\int_{-\infty}^{+\infty} g(t) e^{-2 \pi i t f} d t$
  - 自变量为频率，写出函数表达式: $\hat{g}(f)=\int_{-\infty}^{+\infty} g(t) e^{-2 \pi i t f} d t$
    - 对于不同的频率$f$，$\hat{g}(f)$即为对应的傅里叶系数，其会有不同的取值。当$\hat{g}(f)$比较大时，对应频率就是所求的单位函数的频率
  
我的理解是，傅里叶变换把复杂函数分解成单位函数（时域变频域）。傅里叶系数本质上在傅里叶基上的一种投影。  

|变换	|时间	|频率|  
| :-----:| :----: | :----: |
|连续傅里叶变换	|连续，非周期性	|连续，非周期性|  
|傅里叶级数	|连续，周期性	|离散，非周期性|  
|**离散时间傅里叶变换**	|**离散，非周期性**	|**连续，周期性**|  
|离散傅里叶变换	|离散，周期性	|离散，周期性|  

函数在时（频）域的离散对应于其像函数在频（时）域的周期性.反之连续则意味着在到达域的信号的非周期性.


<span id = "ref３" style="font-size:20px">Ref</span>  

1. [3blue1brown,形象展示傅里叶变换](https://www.bilibili.com/video/av19141078/)  

2. [charlesliuyx，让你永远忘不了的傅里叶变换解析](https://charlesliuyx.github.io/2018/02/18/%E3%80%90%E7%9B%B4%E8%A7%82%E8%AF%A6%E8%A7%A3%E3%80%91%E8%AE%A9%E4%BD%A0%E6%B0%B8%E8%BF%9C%E5%BF%98%E4%B8%8D%E4%BA%86%E7%9A%84%E5%82%85%E9%87%8C%E5%8F%B6%E5%8F%98%E6%8D%A2%E8%A7%A3%E6%9E%90/)

3. [wiki,傅里叶变换](https://zh.wikipedia.org/wiki/%E5%82%85%E9%87%8C%E5%8F%B6%E5%8F%98%E6%8D%A2)

## GNN
|传统傅里叶变换	|图傅里叶变换|
| :-----:| :----: |
|频率（$f$）|特征值（$λ_k$）|
|正弦函数(傅里叶基)（$e^{−2\pi itf}$）|特征向量(傅里叶基)（$v_k$）|
|转换后的振幅(傅里叶系数) $\hat{g(f)}$|转换后的振幅(傅里叶系数)（$\hat{x_k}$）|

图的傅里叶变换写作：$\hat{x} = V^Tx$.  
图的逆傅里叶变换写作：$x = V\hat{x}$  
其中，$V$为特征向量矩阵，$x$为任意一个在图上的信号(节点信息构成的$n$维向量)。这是一种对图信号的分解，图上的任意一个图信号都可以被表示成基向量的线性加权，具体来说，这边的权重就是图信号在对应傅里叶基上的傅里叶系数。

有了图的傅里叶变换以后，我们就可以改写用于表示图平滑度的总变差（total variation）:  

$$
\begin{aligned}
TV(x) = x^TLx
& = x^TV\Lambda V^Tx = (V\hat{x})^TV\Lambda V^T (V\hat{x}) \\
& = \hat{x}^T V^T V\Lambda V^T V\hat{x} \\
& = \hat{x}^T \Lambda \hat{x} = \sum_{k}^{N}\lambda_k\hat{x_k}^2
\end{aligned}
$$  

这里可以发现，图信号的总变差与图的特征值之间有着非常直接的线性对应关系，总变差是图的所有特征值的一个线性组合，权重是图信号相对应的傅里叶系数的平方。特征值越低，频率越低，对应的傅里叶基就变化越缓慢，相近节点上的信号值趋于一致；特征值越高，频率越高，对应的傅里叶基就变化越剧烈，相近节点上的信号值则非常不一致。图信号在低频分量上的强度越大，该信号的平滑度就越高；相反，图信号在高频分量上的强度越大，该信号平滑度就越低。

图信号所有的傅里叶系数称为该信号的频谱。频谱考虑了图信号本身值的大小，也考虑了图的结构信息。

<span id = "ref4" style="font-size:20px">Ref</span>

1. [xtf615,图卷积神经网络理论基础](http://xtf615.com/2019/02/24/gcn/GNN)

2. [深入浅出图卷积, P86-89]()

## 图滤波器
图滤波器就是对给定图信号的频谱中各个频率分量的强度进行增强或减弱的操作。
假设图滤波器为$H \in R^{N \times N}$，则$H：R^N \rightarrow R^N$, 输出的图信号为$y$:  

$$
\begin{aligned}
y=Hx=\sum_{k=1}^{N}\left(h\left(\lambda_{k}\right) \tilde{x}_{k}\right) \boldsymbol{v}_{k}
& =\left[
  \begin{array}{cccc}
  \vdots & \vdots & \cdots & \vdots \\ 
  v_{1} & v_{2} & \cdots & v_{N} \\ 
  \vdots & \vdots & \cdots & \vdots
  \end{array}
  \right]
  \left[
    \begin{array}{c}
    h\left(\lambda_{1}\right) \tilde{x}_{1} \\ 
    h\left(\lambda_{2}\right) \tilde{x}_{2} \\ 
    \vdots \\ 
    h\left(\lambda_{N}\right) \tilde{x}_{N}
    \end{array}
  \right]
\\ &= V\left[
    \begin{array}{cccc}h\left(\lambda_{1}\right) & & & \\ 
    & h\left(\lambda_{2}\right) & & \\
    & & \ddots & \\ 
    & & & h\left(\lambda_{N}\right)
    \end{array}
    \right]
    \left[\begin{array}{c}\tilde{x}_{1} \\ 
    \tilde{x}_{2} \\ 
    \vdots \\ 
    \tilde{x}_{N}
    \end{array}
    \right]
\\ & = V\left[
  \begin{array}{cccc}h\left(\lambda_{1}\right) & & & \\ 
  & h\left(\lambda_{2}\right) & & \\ 
  & & \ddots & \\ & & & h
  \left(\lambda_{N}\right)
  \end{array}
  \right]
  V^Tx
\end{aligned}
$$

所以，$H = V\left[\begin{array}{cccc}h\left(\lambda_{1}\right) & & & \\ & h\left(\lambda_{2}\right) & & \\ & & \ddots & \\ & & & h\left(\lambda_{N}\right)\end{array}\right]V^T$, $H$是对拉普拉斯矩阵特征值的改动。

通过逼近理论，我们可以运用泰勒展开-多项式逼近函数去近似任意函数，把图滤波器写成拉普拉斯矩阵多项式拓展形式：  

$$
H=h_{0} L^{0}+h_{1} L^{1}+h_{2} L^{2}+\cdots+h_{K} L^{K}=\sum_{k=0}^{K} h_{k} L^{k}
$$

其中$k$是图滤波器$H$的阶数.

### 频域角度理解
- 滤波器:

$$
H=\sum_{k=0}^{K} h_{k} L^{k}
=\sum_{k=0}^{K} h_{k}\left(V \Lambda V^{T}\right)^{k}
=V\left(\sum_{k=0}^{K} h_{k} \Lambda^{k}\right) V^{T} 
= V\left[
  \begin{array}{ccc}\sum_{i=0}^{K} h_{k} \lambda_{1}^{k} & \\ 
  & \ddots \\ 
  & \sum_{k=0}^{K} h_{k} \lambda_{N}^{k}
  \end{array}
  \right] V^{T}
$$

- $H$的频率响应矩阵：$\Lambda_h = \sum_{k=0}^{K} h_{k} \Lambda^{k} = = diag(\Psi \boldsymbol{h})$

$\boldsymbol{h}$为多项式系数$h$构成的向量，$\Psi$ 为范德蒙矩阵
  
$$\left[\begin{array}{cccc}
1 & \lambda_{1} & \cdots & \lambda_{1}^{K} \\
1 & \lambda_{2} & \cdots & \lambda_{2}^{K} \\
\vdots & \vdots & \ddots & \vdots \\
1 & \lambda_{N} & \cdots & \lambda_{N}^{K}
\end{array}\right]$$

我们可以反解得到多项式系数 $\boldsymbol{h}=\Psi^{-1} \operatorname{diag}^{-1}\left(\Lambda_{h}\right)$。 

- 滤波操作: 

    $$
    y = Hx = V\left(\sum_{k=0}^{K} h_{k} \Lambda^{k}\right) V^{T}x
    $$

  - 通过图傅里叶变换，即$V^Tx$将图信号变换到频域空间
  - 通过$\Lambda^{k} = \sum_{k=0}^{K} h_{k} \Lambda^{k}$对频率分量的强度进行调节，得到$\tilde{y}$
  - 通过逆图傅里叶变换，即$V\tilde{y}$将$\tilde{y}$反解成图信号$y$

### 空域角度理解
对于 $y=H x=\sum_{i=0}^{K} h_{k} L^{k} x$，设定
$\boldsymbol{x}^{(k)}=L^{k} \boldsymbol{x}=L \boldsymbol{x}^{(k-1)}$，即 $x^{k–1}$到$x^{k}$的变换只需要所有节点的一阶邻居参与计算.
那么  

$$y=H x=\sum_{i=0}^{K} h^{k} x^{k}$$

总的来看，$x^{k}$的计算只需要所有节点的$k$阶邻居参与。这就体现了图滤波器的局部性。

从空域角度来看，滤波操作具有以下性质：

 - 可通过$K$步迭代式的矩阵向量乘法来完成滤波操作。
 - 具有局部性，每个节点的输出信号值只需要考虑其$K$阶子图；

### 频域与空域比较
- 对矩阵进行特征分解是一个非常耗时的操作，具有$O(N^3)$的时间复杂度，相比空域视角中的矩阵向量乘法而言，有工程上的局限性。
- 频谱方法是空间方法的特例。（有显示空间的就叫谱方法 （用傅里叶变换就是把矩阵投射到拉普拉斯矩阵特征向量张成的空间），没有显示空间的就叫空间方法 [2](#沈华伟) ）
  
 <span id = "ref5" style="font-size:20px">Ref</span>

1. [沈华伟，图卷积神经网络](https://www.bilibili.com/video/BV1ta4y1t7EK)  

2. [深入浅出图卷积, P93-96]()

## 图卷积
GCN的基本思想： 把一个节点在图中的高纬度邻接信息降维到一个低维的向量表示  
GCN的优点： 可以捕捉graph的全局信息，从而很好地表示node的特征。  
GCN的缺点： 

  - Transductive learning的方式，需要把所有节点都参与训练才能得到node embedding，无法快速得到新node的embedding。这样的话，就无法完成inductive任务，即处理动态图问题。inductive任务是指：训练阶段与测试阶段需要处理的graph不同。通常是训练阶段只是在子图（subgraph）上进行，测试阶段需要处理未知的顶点。（unseen node）
  - 处理有向图的瓶颈，不容易实现分配不同的学习权重给不同的neighbor
  - 有过平滑的风险

两组图信号的图卷积运算总能转化为对应形式的图滤波运算，从这个层面上来看，图卷积等价于图滤波。

- 对频率响应矩阵进行参数化 [1](#chebynet)
- 对多项式系数进行参数化 [2](#GCN)
  - 该网络可以有效地对节点的一阶邻居进行处理，而且可以避免复杂的矩阵运算
- 设计固定的图滤波器

### GCN与CNN的比较
- 聚合邻域信息
    - GCN　非结构化数据
    - CNN　结构化数据

- 局部连接
    - 节点下一层的特征计算只依赖于自身领域
    - CNN的卷积核设计了９组权重参数，GCN的退化为一组

- 卷积核的权重处处共享，作用于所有节点
- 感受域随着卷积层的增加而增大

### GCN与基于手工与基于随机游走的方法的比较
图的信息：节点信息、结构信息

- 基于手工：结构特征依赖人工干预。将节点信息和结构信息拼接
  
- 随机游走：将图中节点所满足的关系与结构的性质映射到一个新的向量空间。将节点信息和结构信息拼接

- GCN：迭代式地聚合邻居节点的特征，从而更新当前节点的特征。【端到端】
    - 参数更新及时，节点的特征表示与下游任务之间具有更好的适应性
    - 对结构信息与属性信息的学习同时进行，没有拆分和解构。而这两者往往有很好的互补关系

### GCN是一个低通滤波器
损失函数中的正则项越小，使得相邻节点的分类标签趋于一致，可以使我们更高效地对未标记的数据进行学习。而越减小该项，表示经过模型之后的图信号越平滑，从频域角度看，相当于对图信号做了低通滤波器处理。

- 低通滤波可以对数据进行有效去噪
- 低频的波段已经蕴含了大部分信息

### GCN的过平滑问题
但是GNN不想CNN可以多层堆叠，因为多次对信号进行平滑操作后，信号会越来越趋同，也就丧失了节点特征的多样新，出现“过平滑”问题。
- 频域角度：多次堆叠后，有些特征向量会处处相等，趋同了
- 空域角度：层数过多，每个节点能覆盖到的节点都会收敛到全图节点。这会大大降低每个节点的局部网络的多样性，对于节点自身的特征学习十分不利。

如何解决：

- 自适应聚合半径: 通过增加跳跃连接来聚合模型的每层节点输出，聚合后的节点特征拥有混合的聚合半径


### GCN实战
https://github.com/FighterLYL/GraphNeuralNetwork/tree/master/chapter5


 <span id = "ref5" style="font-size:20px">Ref</span>

1. <span id = "chebynet"></span>[Convolutional Neural Networks on Graphs
with Fast Localized Spectral Filtering](https://arxiv.org/pdf/1606.09375.pdf)

2. [深入浅出图卷积, P97-100]()

3. <span id = "GCN"></span>[Semi-Supervised Classification with Graph Convolutional Networks](https://arxiv.org/abs/1609.02907)

4. [深入浅出图卷积, P112-127]()

5. [[论文笔记]：GraphSAGE：Inductive Representation Learning on Large Graphs](https://blog.csdn.net/yyl424525/article/details/100532849)