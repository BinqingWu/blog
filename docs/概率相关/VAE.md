# VAE

## 为什么要给每个样本构造专属的正态分布$p(Z|X)$

为了能够把从分布$p(Z|X_k)$采样出来的一个$Z_k$还原为$X_k$时，能对应的上。

## 为什么$p(Z|X)$要是标准正态的

- 简单，实践方便，处处不为0.
- 为了保证有生成能力，需要有一定的噪声。所以需要设计方差为1。
- 希望同一类样本encoder出来越接近。所以需要均值为0.

KL loss就是去约束这个的

https://kexue.fm/archives/5343

## 为什么要用ＫＬ散度不用其他散度

### 采样计算vs数值计算

期望：

$\mathbb{E}[x] = \int x p(x)dx\tag{1}$

数值计算：

$\mathbb{E}[x] \approx \sum_{i=1}^n x_i p(x_i) \left(x_i - x_{i-1}\right)\tag{2}$

采样计算：

$\mathbb{E}[x] \approx \frac{1}{n}\sum_{i=1}^n x_i,\quad x_i \sim p(x)\tag{3}$

在采样计算中，$x_i$是从$p(x)$中依概率采样出来的，概率大的$x_i$出现的次数也多，所以可以说采样的结果已经包含了$p(x)$在里边，就不用再乘以$p(x_i)$了。

### KL散度

KL散度主要用来度量两个概率分布$p(x)$和$q(x)$之间的差异

$KL\Big(p(x)\Big\Vert q(x)\Big) = \int p(x)\ln \frac{p(x)}{q(x)} dx=\mathbb{E}_{x\sim p(x)}\left[\ln \frac{p(x)}{q(x)}\right]\tag{5}$

KL散度可以写成期望的形式，这允许我们对其进行采样计算，这使得在实践的过程中可行性比较高。

$\mathbb{E}_{x\sim p(x)}[f(x)] = \int f(x)p(x)dx \approx \frac{1}{n}\sum_{i=1}^n f(x_i),\quad x_i\sim p(x)\tag{4}$

KL散度也不是没有缺点，当$q(x)$在某个区域等于0，而$p(x)$在该区域不等于0，那么KL散度就出现无穷大。这是KL散度的固有问题。用正态分布能规避这个问题，是因为它处处不为0。

最小化KL散度的结果都是两者尽可能相等。这一点的严格证明要用到变分法，而事实上VAE中的V（变分）就是因为VAE的推导就是因为用到了KL散度（进而也包含了变分法）。

https://kexue.fm/archives/5253

## 重参数是啥，为什么要重参数

Encoder计算出 $\mu$ 和方差$\sigma^2$ 之后, 不是直接在这个分布上采样, 而是在另外的一个标准正态分布上采样之后, 乘以$\sigma$  (scale)再加上 $\mu$ (shift). 通过这种方法, 就把不可bp的操作转移到了梯度回传路径外面.

https://zhuanlan.zhihu.com/p/50633055





