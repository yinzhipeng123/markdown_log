**LXC**，其名称来自Linux软件容器（Linux Containers）的缩写，一种[操作系统层虚拟化](https://zh.wikipedia.org/wiki/作業系統層虛擬化)（Operating system–level virtualization）技术，为[Linux内核](https://zh.wikipedia.org/wiki/Linux内核)容器功能的一个[用户空间](https://zh.wikipedia.org/wiki/用户空间)[接口](https://zh.wikipedia.org/wiki/介面_(程式設計))。它将应用软件系统打包成一个软件容器（Container），内含应用软件本身的代码，以及所需要的操作系统核心和库。透过统一的名字空间和共享[API](https://zh.wikipedia.org/wiki/API)来分配不同软件容器的可用硬件资源，创造出应用程序的独立[沙箱](https://zh.wikipedia.org/wiki/沙盒_(電腦安全))执行环境，使得[Linux](https://zh.wikipedia.org/wiki/Linux)用户可以容易的创建和管理系统或应用容器。

在Linux内核中，提供了[cgroups](https://zh.wikipedia.org/wiki/Cgroups)功能，来达成资源的区隔化。它同时也提供了名称空间区隔化的功能，使应用程序看到的操作系统环境被区隔成独立区间，包括行程树，网络，用户id，以及挂载的文件系统。但是cgroups并不一定需要启动任何虚拟机。

LXC利用cgroups与名称空间的功能，提供应用软件一个独立的操作系统环境。LXC不需要[Hypervisor](https://zh.wikipedia.org/wiki/Hypervisor)这个软件层，软件容器（Container）本身极为轻量化，提升了创建[虚拟机](https://zh.wikipedia.org/wiki/虛擬機器)的速度。软件[Docker](https://zh.wikipedia.org/wiki/Docker_(軟體))被用来管理LXC的环境

[LXC - 维基百科，自由的百科全书 (wikipedia.org)](https://zh.wikipedia.org/wiki/LXC)