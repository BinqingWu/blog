# Attention

## 序列编码

### RNN

RNN要逐步递归才能获得全局信息，而且递归限制了并行能力；顺序计算的过程中信息会丢失，尽管LSTM等门机制的结构一定程度上缓解了长期依赖的问题，但是对于特别长期的依赖现象,LSTM依旧无能为力。

一般要双向RNN才比较好。

- LSTM：https://zhuanlan.zhihu.com/p/32085405
- GRU：https://zhuanlan.zhihu.com/p/32481747

### CNN

CNN事实上只能获取局部信息，需要通过层叠来增大感受野s

### Attention

Attention一步到位获取了全局信息。

$\begin{equation}\boldsymbol{y}_t = f(\boldsymbol{x}_{t},\boldsymbol{A},\boldsymbol{B})\end{equation}$

其中$A,B$是另外一个序列（矩阵）。如果都取$A=B=X$，那么就称为Self Attention，它的意思是直接将$x_t$与原来的每个词进行比较，最后算出$y_t$.

## Attention

核心内容是为输入向量的”每个单词“学习一个权重

### Self-Attention

$$
Z=Attention(\boldsymbol{Q},\boldsymbol{K},\boldsymbol{V}) = softmax\left(\frac{\boldsymbol{Q}\boldsymbol{K}^{\top}}{\sqrt{d_k}}\right)\boldsymbol{V}
$$

<img src="https://pic3.zhimg.com/80/v2-bcd0d108a5b52a991d5d5b5b74d365c6_720w.jpg" alt="img" style="zoom:33%;" />

<img src="https://pic1.zhimg.com/80/v2-be73ba876922cf52df8a00a55f770284_720w.jpg" alt="img" style="zoom:50%;" />

self的体现：Q、 K、V 都通过只通过输入X（比如输入的文本）得到（用X去乘上各自的映射矩阵）。其中因子$\sqrt{d_k}$起到调节作用，使得内积不至于太大（太大的话softmax后就非0即1了，不够“soft”了，也是为了梯度的稳定性）。

> Query，Key，Value的概念取自于信息检索系统，举个简单的搜索的例子来说。当你在某电商平台搜索某件商品（年轻女士冬季穿的红色薄款羽绒服）时，你在搜索引擎上输入的内容便是Query，然后搜索引擎根据Query为你匹配Key（例如商品的种类，颜色，描述等），然后根据Query和Key的相似度得到匹配的内容（Value)。

self-attention中的Q，K，V也是起着类似的作用，在矩阵计算中，点积是计算两个矩阵相似度的方法之一，因此式1中使用了 $QK^T$ 进行相似度的计算。然后用softmax后的相似度去和V相乘，相当于是把V中的各个values加权求和了，权值就是相似度。这边的Z就是一层self-attention的隐藏层输出了。

https://zhuanlan.zhihu.com/p/48508221

自注意力的更直白的解释是在编码某个单词时，将所有单词的表示（值向量）进行加权求和，而权重是通过该词的表示（键向量）与被编码词表示（查询向量）的点积并通过softmax得到

https://mp.weixin.qq.com/s/6RPxTdDcxJ050oAp34Ofdw

### Feed Forward Neural Network

每个位置的单词对应的前馈神经网络都完全一样（另一种解读就是一层窗口为一个单词的一维卷积神经网络）

### Multi-headed Attention

“多头”（Multi-Head），相当于 $h$个不同的self-attention的集成，就是多做几次同样的事情（参数不共享），然后把结果拼接起来。多头注意力机制从两方面提高了注意力层的性能：

1.它扩展了模型专注于不同位置的能力。

2.它给出了注意力层的多个“表示子空间”。

![img](https://pic3.zhimg.com/80/v2-c2a91ac08b34e73c7f4b415ce823840e_720w.jpg)

### Position Embedding

如果只有Attention，这样的模型并不能捕捉序列的顺序（这和RNN、CNN很不同，这两个都是在编码过程中都是有序的）。换句话说，如果将$K$, $V$按行打乱顺序（相当于句子中的词序打乱），那么Attention的结果还是一样的。对于时间序列来说，尤其是对于NLP中的任务来说，顺序是很重要的信息，它代表着局部甚至是全局的结构，学习不到顺序信息，那么效果将会大打折扣。于是我们需要来对位置信息进行提取。

Position Embedding就将位置向量添加到词嵌入中使得它们在接下来的运算中，能够更好地表达的词与词之间的距离。

构造Position Embedding的公式：
$$
\begin{equation}\left\{\begin{aligned}&PE_{2i}(p)=\sin\Big(p/10000^{2i/{d_{pos}}}\Big)\\ 
&PE_{2i+1}(p)=\cos\Big(p/10000^{2i/{d_{pos}}}\Big) 
\end{aligned}\right.\end{equation}
$$
将id为p的位置映射为一个dpos维的位置向量，这个向量的第i个元素的数值就是PEi(p)。Google在论文中说到他们比较过直接训练出来的位置向量和上述公式计算出来的位置向量，效果是接近的。因此显然我们更乐意使用公式构造的Position Embedding了，我们称之为Sinusoidal形式的Position Embedding。

Position Embedding本身是一个绝对位置的信息，但在语言中，相对位置也很重要，Google选择前述的位置向量公式的一个重要原因是：由于我们有sin(α+β)=sinαcosβ+cosαsinβ以及cos(α+β)=cosαcosβ−sinαsinβ，这表明位置p+k的向量可以表示成位置p的向量的线性变换，这提供了表达相对位置信息的可能性。

为啥这样设计，原理性问题看看这个 https://kexue.fm/archives/8231

能实现相对位置编码、远程衰减（越远关系越弱）

### Add & Norm模块

Add代表了Residual Connection，是为了解决多层神经网络训练困难的问题，通过将前一层的信息无差的传递到下一层，可以有效的仅关注差异部分。

Norm则代表了Layer Normalization，Normalization有很多种，但是它们都有一个共同的目的，那就是把输入转化成均值为0方差为1的数据（？）。而我们在把数据送入激活函数之前进行normalization（归一化），是因为我们不希望输入数据落在激活函数的饱和区。这样做可以加速模型的训练过程，使其更快的收敛。

LN 是在每一个样本上计算均值和方差，而不是BN那种在批方向计算均值和方差。

![img](https://pic3.zhimg.com/80/v2-f92c59f5d94d53b7da60e967531023ca_720w.jpg)

![img](https://pic3.zhimg.com/80/v2-7546bc02fcbe55151dcd336509e3fbd6_720w.jpg)

### Masked multi-head attention

Mask 表示掩码，它对某些值进行掩盖，使其在参数更新时不产生效果。Transformer 模型里面涉及两种 mask，分别是 padding mask 和 sequence mask。其中，padding mask 在所有的 scaled dot-product attention 里面都需要用到，而 sequence mask 只有在 decoder 的 self-attention 里面用到。

https://zhuanlan.zhihu.com/p/63191028

#### Padding Mask

每个批次输入序列长度是不一样的，我们要对输入序列进行对齐。具体来说，就是给较短的序列后面填充 0。如果输入的序列太长，则是截取左边的内容，把多余的直接舍弃。因为这些填充的位置，其实是没什么意义的，我们的attention机制不应该把注意力放在这些位置上，所以我们需要进行一些处理。

具体的做法是，把这些位置的值加上一个非常大的负数(负无穷)，这样的话，经过 softmax，这些位置的概率就会接近0。而我们的 padding mask 实际上是一个张量，每个值都是一个Boolean，值为 false 的地方就是我们要进行处理的地方。

#### Sequence mask

sequence mask 是为了使得 decoder 不能看见未来的信息。也就是对于一个序列，在 time_step 为 t 的时刻，我们的解码输出应该只能依赖于 t 时刻之前的输出，而不能依赖 t 之后的输出。

这里mask是一个下三角矩阵，对角线以及对角线左下都是1，其余都是0。

$Mask \bigotimes (QK^T)$

https://blog.csdn.net/qq_35169059/article/details/101678207

### **最终的线性变换和Softmax层**

<img src="https://mmbiz.qpic.cn/mmbiz_jpg/pu7ghYhibpS9NWMDRS0gDrxmuYhpN8SRYKsfXNQNz6RwQBWiaotj5rmD4RwBe2tWd6aXGFCyib4D0oUaiciaFicxMByA/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1" alt="图片" style="zoom:50%;" />

https://mp.weixin.qq.com/s/6RPxTdDcxJ050oAp34Ofdw