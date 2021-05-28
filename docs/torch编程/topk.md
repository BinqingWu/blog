# Top k

```python
supports = torch.rand(3,4)
topk,indices = torch.topk(supports,k=2,dim=0,largest=True)
# topk 取前k个值
# dim 0: 对列，dim 1：对行
zeros = torch.zeros(supports.shape).to(device)
supports = zeros.scatter_(0, indices, topk).to(device)
# scatter 散布
```

