

# /proc/meminfo



- MemTotal	所有可用的 RAM 大小，物理内存减去预留位和内核使用
- MemFree	表示系统尚未使用的内存。[MemTotal-MemFree]就是已被用掉的内存。
- Buffers	用来给块设备做缓存的大小（文件系统的 metadata, tracking in-flight pages）
- Cached	文件的缓冲区大小
- SwapCached	已经被交换出来的内存。与 I/O 相关
- Active	经常（最近）被使用的内存
- Inactive	最近不常使用的内存。这很容易被系统移做他用
- Active(anon)	匿名页激活部分
- Inactive(anon)	匿名页未激活部分
- Active(file):     使用的文件缓存大小
- Inactive(file):   未使用的文件缓存大小
- SwapTotal	交换空间总和
- SwapFree	RAM 暂存在 Swap 中的大小
- Dirty	等待写回的数据大小
- WriteBack	正在写回的数据大小
- Mapped	映射文件大小
- AnonPages	映射到用户空间的非文件页表大小
- Slab	内核数据结构缓存
- SReclaimable	Slab 的一部分。当内存压力大时，可以 reclaim
- SUnreclaim	不可以 reclaim 的 Slab
- PageTables	最底层的页表的内存空间
- NFS_Unstable	已经发给 NFS 服务器、但是尚未被确认（committed）写入到稳定存储的页表
- WritebackTmp	Memory used by FUSE for temporary writeback buffers
- CommitLimit	CommitLimit = ('vm.overcommit_ratio' * Physical RAM)
- Committed_AS	The amount of memory presently allocated on the system.（系统中目前分配了的内存？）
- VmallocTotal	vmalloc 内存大小
- VmallocUsed	已被使用的虚拟内存大小
- VmallocChunk	在 vmalloc 区域中可用的最大的连续内存块的大小





```bash
cat /proc/meminfo 
MemTotal:       535683440 kB  # 总物理内存大小，单位是 KB（约 511 GB）
MemFree:        13445832 kB   # 空闲的物理内存，单位 KB（约 12.8 GB）
MemAvailable:   20860124 kB   # 可用内存（可立即分配给新进程的内存），单位 KB（约 19.9 GB）
Buffers:          259816 kB   # 用于缓冲块设备的内存，单位 KB（约 254 MB）
Cached:          8715728 kB   # 用于缓存文件数据的内存（包括 SwapCached），单位 KB（约 8.3 GB）
SwapCached:            0 kB   # 交换区缓存的内存（已换出但仍在缓存中，可快速恢复），单位 KB（为 0，说明未使用 swap）
Active:          3592148 kB   # 活跃的内存（经常使用，短时间内不会被回收），单位 KB（约 3.4 GB）
Inactive:        5685060 kB   # 非活跃内存（可以被回收的内存），单位 KB（约 5.4 GB）
Active(anon):     310704 kB   # 活跃的匿名页内存（进程使用的非文件映射内存），单位 KB（约 303 MB）
Inactive(anon):     1144 kB   # 非活跃的匿名页内存，单位 KB（约 1 MB）
Active(file):    3281444 kB   # 活跃的文件缓存内存，单位 KB（约 3.1 GB）
Inactive(file):  5683916 kB   # 非活跃的文件缓存内存，单位 KB（约 5.4 GB）
Unevictable:           0 kB   # 无法被回收的内存，单位 KB（为 0，说明没有锁定的内存）
Mlocked:               0 kB   # 进程锁定的内存（mlock），单位 KB（为 0）
SwapTotal:             0 kB   # 总交换空间（swap）大小，单位 KB（为 0，说明系统未配置 swap）
SwapFree:              0 kB   # 空闲的交换空间大小，单位 KB（为 0，说明没有 swap）
Dirty:              1344 kB   # 等待写入磁盘的脏页内存，单位 KB（约 1.3 MB）
Writeback:            72 kB   # 正在写入磁盘的脏页内存，单位 KB（约 72 KB）
AnonPages:        298744 kB   # 进程使用的匿名页内存，单位 KB（约 292 MB）
Mapped:           159740 kB   # 进程映射的文件或共享内存，单位 KB（约 156 MB）
Shmem:             10256 kB   # 共享内存（进程间通信），单位 KB（约 10 MB）
Slab:            1542104 kB   # 内核数据结构缓存（Slab 分配器），单位 KB（约 1.5 GB）
SReclaimable:     619392 kB   # 可回收的 Slab 内存，单位 KB（约 605 MB）
SUnreclaim:       922712 kB   # 不可回收的 Slab 内存，单位 KB（约 900 MB）
KernelStack:       17152 kB   # 内核栈占用的内存，单位 KB（约 16 MB）
PageTables:        10780 kB   # 页表占用的内存，单位 KB（约 10 MB）
NFS_Unstable:          0 kB   # 通过 NFS 传输但尚未写入存储的内存，单位 KB（为 0）
Bounce:                0 kB   # 需要 bounce buffer（用于 DMA）的内存，单位 KB（为 0）
WritebackTmp:          0 kB   # 临时用于写回的内存，单位 KB（为 0）
CommitLimit:    14086328 kB   # 允许分配的总内存（基于 swap 和物理内存计算），单位 KB（约 13.4 GB）
Committed_AS:    2657928 kB   # 进程已经分配但未实际使用的内存，单位 KB（约 2.5 GB）
VmallocTotal:   34359738367 kB # 虚拟内存地址空间总量（理论最大值），单位 KB（约 32 TB）
VmallocUsed:           0 kB   # 已使用的虚拟内存，单位 KB（为 0）
VmallocChunk:          0 kB   # 最大的连续虚拟内存块大小，单位 KB（为 0）
Percpu:            45824 kB   # 每 CPU 核心分配的内存，单位 KB（约 44 MB）
HardwareCorrupted:     0 kB   # 硬件损坏的内存，单位 KB（为 0）
AnonHugePages:         0 kB   # 使用的匿名大页（HugePages），单位 KB（为 0，未使用）
ShmemHugePages:        0 kB   # 共享内存使用的大页，单位 KB（为 0）
ShmemPmdMapped:        0 kB   # 使用 PMD（Page Middle Directory）映射的共享内存大页，单位 KB（为 0）
HugePages_Total:       0      # 预留的大页总数（HugePages），为 0
HugePages_Free:        0      # 可用的大页数量，为 0
HugePages_Rsvd:        0      # 预留但未分配的大页数量，为 0
HugePages_Surp:        0      # 额外分配的超量大页数量，为 0
Hugepagesize:       2048 kB   # 每个大页的大小，单位 KB（2 MB）
Hugetlb:        507510784 kB  # 为大页预留的内存，单位 KB（约 484 GB）
DirectMap4k:      811544 kB   # 直接映射的 4 KB 页面，单位 KB（约 792 MB）
DirectMap2M:    10633216 kB   # 直接映射的 2 MB 页面，单位 KB（约 10.1 GB）
DirectMap1G:    525336576 kB  # 直接映射的 1 GB 页面，单位 KB（约 501 GB）
```



[(45条消息) 曾文斌: /proc/meminfo之谜完全揭秘_Linux阅码场的博客-CSDN博客](https://blog.csdn.net/jus3ve/article/details/79285750)