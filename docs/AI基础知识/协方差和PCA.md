# 协方差与PCA

## 期望、方差、标准差、协方差、相关系数

### 期望

数学期望反应随机变量平均值的大小

### 方差

衡量随机变量和其数学期望（均值）之间的偏离程度（散布度）。是一种特殊的期望。
$$
Var(x) = E((x-E(x))^2)
$$

### 标准差

方差的平方根

### 协方差

衡量变量之间线性相关程度和变量幅度。方差是一种特殊的协方差（X=Y）。
$$
Cov(x,y)=E((x-E(x))(y-E(y)))
$$
如果协方差为正，说明X，Y同向变化，协方差越大说明同向程度越高；如果协方差为负，说明X，Y反向运动，协方差越小说明反向程度越高

### 协方差矩阵

协方差矩阵是一个对称的矩阵，对角线是各个维度上的方差，其他地方是维度之间的协方差。值得注意的是，协方差矩阵算的是维度之间的协方差，而不是样本之间。

### 相关系数

衡量变量之间线性相关程度
$$
Corr(x,y) = \frac{Cov(x,y)}{\sqrt{Var(x)Var(y)}}
$$
相关系数也可以看成协方差：一种剔除了两个变量各自变化幅度影响的特殊协方差。

相关系数的有界性：相关系数的取值范围是 [-1,1]

## 中心化和标准化

当原始数据不同维度上的特征的尺度（单位）不一致时，需要标准化步骤对数据进行预处理，消除指标之间的量纲影响。

### 中心化

变量减去它的均值：数据被移动到原点周围

### 标准化

变量减去它的均值再除以标准差：数据每个维度上的尺度是一致的

## PCA

对原始数据进行降维，希望保留下来的维度间的相关性尽可能小，维度含有的“能量”即方差尽可能大

## 协方差矩阵与PCA

PCA降维即让协方差矩阵中非对角线元素都基本为零。而达成这个目的需要的就是对协方差矩阵进行对角化。对角化后得到的矩阵，其对角线上是协方差矩阵的特征值，它还有两个身份：首先，它还是各个维度上的新方差；其次，它的大小代表了各个维度本身拥有的能量大小。

设协方差矩阵为$S$，对角化：$S = P\Lambda P^{-1}$。选择前$N$大的特征值和对应的特征向量：$\Lambda_1$, $P_1$。

投影后的$S_1 = SP_1$

### python实现

```python
class PCA_self(object):
    def __init__(self,X,N=3):
        self.X = X
        self.N = N
        self.low_dim_S = []
        self.variance_ratio = []
        
    def _fit(self):
        X_mean = np.mean(self.X, axis=0)
        # 将样本进行中心化，即保证每个维度的均值为零
        S = self.X - X_mean
        # 协方差矩阵
        C = np.cov(S, rowvar=False)
        # 特征值和特征向量
        eig_value, eig_vector = np.linalg.eig(np.mat(C))
        # 找到前N大的特征值
        selected_eig_index = np.argsort(eig_value) # 这个返回的是索引
        selected_eig_index = selected_eig_index[-1:-(self.N + 1):-1]
        # print(eig_value,selected_eig_index)
        # 选择N维的特征向量
        selected_eig_vector = eig_vector[:, selected_eig_index]
        # print(selected_eig_vector)
        # 投影变换后的新矩阵
        self.low_dim_S = S * selected_eig_vector
        # 输出每个维度所占的方差百分比
        [self.variance_ratio.append(eig_value[i] / sum(eig_value)) for i in selected_eig_index]
        
        return self.low_dim_S
        
    def fit(self):
        self._fit()
        return self
```

```python
pca=PCA_self(data.data,2)
pca.fit()
print(pca.variance_ratio) # 各个维度所占的方差的百分比（重要度）
print(pca.low_dim_S) # （降度后的数据）
```

## 为什么PCA用中心化而不是标准化

因为PCA想在消除量刚影响的同时，尽量保持各个维度的“能量”（方差）。