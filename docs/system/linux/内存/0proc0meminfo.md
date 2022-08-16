

# /proc/meminfo



MemTotal	所有可用的 RAM 大小，物理内存减去预留位和内核使用
MemFree	表示系统尚未使用的内存。[MemTotal-MemFree]就是已被用掉的内存。
Buffers	用来给块设备做缓存的大小（文件系统的 metadata, tracking in-flight pages）
Cached	文件的缓冲区大小
SwapCached	已经被交换出来的内存。与 I/O 相关
Active	经常（最近）被使用的内存
Inactive	最近不常使用的内存。这很容易被系统移做他用
Active(anon)	匿名页激活部分
Inactive(anon)	匿名页未激活部分
Active(file):     使用的文件缓存大小
Inactive(file):   未使用的文件缓存大小
SwapTotal	交换空间总和
SwapFree	RAM 暂存在 Swap 中的大小
Dirty	等待写回的数据大小
WriteBack	正在写回的数据大小
Mapped	映射文件大小
AnonPages	映射到用户空间的非文件页表大小
Slab	内核数据结构缓存
SReclaimable	Slab 的一部分。当内存压力大时，可以 reclaim
SUnreclaim	不可以 reclaim 的 Slab
PageTables	最底层的页表的内存空间
NFS_Unstable	已经发给 NFS 服务器、但是尚未被确认（committed）写入到稳定存储的页表
WritebackTmp	Memory used by FUSE for temporary writeback buffers
CommitLimit	CommitLimit = ('vm.overcommit_ratio' * Physical RAM)
Committed_AS	The amount of memory presently allocated on the system.（系统中目前分配了的内存？）
VmallocTotal	vmalloc 内存大小
VmallocUsed	已被使用的虚拟内存大小
VmallocChunk	在 vmalloc 区域中可用的最大的连续内存块的大小



[(45条消息) 曾文斌: /proc/meminfo之谜完全揭秘_Linux阅码场的博客-CSDN博客](https://blog.csdn.net/jus3ve/article/details/79285750)