# grub和bios的区别

[https://blog.csdn.net/liao20081228/article/details/81297143](https://blog.csdn.net/liao20081228/article/details/81297143)

BIOS（Basic Input Output System）：基本输入输出系统。它是一组固化到计算机内主板上一个ROM芯片上的程序 ，保存着计算机最重要的基本输入输出的程序、开机后自检程序和系统自启动程序，它可从CMOS中读写系统设置的具体信息。
  BIOS是连接软件与硬件的一座“桥梁”，是计算机的开启时运行的第一个程序，主要功能是为计算机提供最底层的、最直接的硬件设置和控制。

Grub：

GNU GRUB（GRand Unified Bootloader简称“GRUB”）是一个来自GNU项目的多操作系统启动程序。GRUB是多启动规范的实现，它允许用户可以在计算机内同时拥有多个操作系统，并在计算机启动时选择希望运行的操作系统。GRUB可用于选择操作系统分区上的不同内核，也可用于向这些内核传递启动参数。可用来用来引导不同系统，如windows，linux，通常用于linux，毕竟是GNU的嘛。Windows也有类似的工具NTLOADER、Bootmgr；比如我们在机器中安装了Windows 98后，我们再安装一个Windows XP ，在机器启动的会有一个菜单让我们选择进入是进入Windows 98 还是进入Windows XP。

Bootloader：

嵌入式系统的称呼，可以等价于PC上的BIOS+GRUB

总结：

那么自下而上从整个架构上来看，BIOS→GRUB→OS。这也和实际观察相符。