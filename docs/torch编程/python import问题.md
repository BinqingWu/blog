# python import 问题

## 报错：ImportError: attempted relative import with no known parent package

在`~/code_demo/dNRI/dnri/training$ ` 下运行

```
python train.py
```

报错：`ImportError: attempted relative import with no known parent package`

报错代码出现在

```python
from . import train_utils
import dnri.utils.misc as misc
```

局部文件树：

```
├── dnri
│   ├── __init__.py
│   ├── training
│   │   ├── evaluate.py
│   │   ├── __init__.py
│   │   ├── __pycache__
│   │   │   └── train_utils.cpython-38.pyc
│   │   ├── train_dynamicvars.py
│   │   ├── train.py
│   │   └── train_utils.py
│   └── utils
│       ├── data_utils.py
│       ├── flags.py
│       ├── __init__.py
│       ├── misc.py
│       └── __pycache__
│           ├── __init__.cpython-38.pyc
│           └── misc.cpython-38.pyc
```

## 尝试解决

把‘`from . import train_utils` 换成 `import train_utils` 不报`ImportError: attempted relative import with no known parent package`的错误了，改报

```
ModuleNotFoundError: No module named 'dnri
```

## 为什么？

我在`~/code_demo/dNRI/dnri/training$`中运行`train.py`，报了导入包的错误，那么先用`sys.path`查看模块搜索路径的字符串列表：

```
~/code_demo/dNRI/dnri/training$ python train.py 
['/home/wbq/code_demo/dNRI/dnri/training', '/home/wbq/anaconda3/lib/python38.zip', '/home/wbq/anaconda3/lib/python3.8', '/home/wbq/anaconda3/lib/python3.8/lib-dynload', '/home/wbq/anaconda3/lib/python3.8/site-packages']
```

发现没有dnri的项目路径。

ps: 那为什么在尝试解决时候，会报不同的错误呢？是因为一个用了相对导入一个用了绝对导入。如果把 `import dnri.utils.misc as misc` 改成`from ..utils import misc as misc` 还是会报这个错`ImportError: attempted relative import with no known parent package`。所以，根本问题还是在于，没有把项目路径代入进去，编译器找不到。

## 解决方法

### 人工添加绝对路径

添加`dnri`这个包所在的路径

```python
import sys
sys.path.insert(0,'/home/wbq/code_demo/dNRI')
```

稍微进阶一点，用个函数判断

```python
parent_path = os.path.dirname(sys.path[0]) #/home/wbq/code_demo/dNRI/dnri
print(parent_path)
if parent_path not in sys.path:
    sys.path.insert(0,parent_path)

import train_utils
import utils.misc as misc    #不能用import dnri.utils.misc as misc,　因为dnri的路径在dNRI下

```

如果用的地方多，可以通过改临时环境变量

```
export PYTHONPATH=$PYTHONPATH:$~/code_demo/dNRI
```



## 关于包的进一步详细解释

1. https://python3-cookbook.readthedocs.io/zh_CN/latest/c10/p03_import_submodules_by_relative_names.html
2. https://blog.csdn.net/sky453589103/article/details/78863050





















