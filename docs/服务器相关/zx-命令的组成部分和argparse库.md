# 命令的组成部分和argparse库

参考资料：

[https://docs.python.org/zh-cn/3/howto/argparse.html](https://docs.python.org/zh-cn/3/howto/argparse.html)

首先介绍一下一个命令的组成，之后介绍argparse库。

### 一个命令由哪几个部分组成？

---

1. 命令的名字。比如ls，grep等。
2. 位置参数。比如ls pypy；cp SRC DEST

位置参数是一定要写的，但是假如不写也能运行，说明有默认的位置参数。

 3.   可选参数。

可选参数有一个前置，比如-i等

### argparse库怎么用？

---

Argparse相当于把你的python文件变成linux命令的形式。你可以为py文件添加位置参数和可选参数。Py文件的名字相当于命令名字。

`import argparse`

`parser = argparse.ArgumentParser() #创建parser对象`

`parser.add_argument("--verbosity", help="increase output verbosity")`

`args = parser.parse_args()# 进行转换生成，args。`

### argparse细节用法：

---

**Argparse中添加位置参数：**

注意这里echo是参数的名字，你可以添加任意字符串作为echo传入命令。

parser.add_argument("echo", help="echo the string you use here")

参数的类型都是默认字符串，所以其他类型需要指定类型

parser.add_argument("square", help="display a square of a given number",type=int)

**argparse中添加可选参数：**

parser.add_argument(“-v”,"--verbosity", help="increase output verbosity")

注意到可选参数和位置参数相比多了一个或两个-。这个非常重要，这也是两类参数的根本区别，因为我们知道位置参数的参数名在命令中是没有意义的，我们不会输入位置参数的参数名。但是我们想要启用可选参数就必须先输入可选参数的参数名，比如-v xxx。我们也可以设置参数default=xx。