# free命令



**语法格式：**free [选项]

**常用参数：**﻿

```bash
 -b, --bytes         --以字节为单位显示输出
 -k, --kilo          --以千字节为单位显示输出
 -m, --mega          --以兆字节为单位显示输出
 -g, --giga          --千兆显示输出（GB）
     --tera          --TB为单位显示输出
     --peta          --PB为单位显示输出
 -h, --human         --人类显示人类可读的输出
     --si            --使用1000而非1024的进制
 -l, --lohi          --显示详细的低内存和高内存统计信息
 -t, --total         --显示RAM+交换的总计
 -s N, --seconds N   --每N秒重复打印一次
 -c N, --count N     --重复打印N次，然后退出
 -w, --wide          --宽输出

     --help     	 --显示帮助
 -V, --version  	 --显示版本

```


显示的解释

**total**  内存总和 (MemTotal and SwapTotal in /proc/meminfo)

**used**   已经使用的内存 (通过total - free - buffers - cache 来计算)

**free**   未使用的内存 (MemFree and SwapFree in /proc/meminfo)

**shared**  tmpfs（主要）使用的内存 (Shmem in /proc/meminfo)

**buffers**  Buffers 是内核缓冲区用到的内存，对应的是 /proc/meminfo 中的 Buffers 值。(Buffers in /proc/meminfo)

**cache**   Cache 是内核页缓存和 Slab 用到的内存，对应的是 /proc/meminfo 中的 Cached 与 SReclaimable 之和。(Cached and SReclaimable in /proc/meminfo)

1. 版本：procps-3.2.8-36            cache值等于/proc/meminfo中的”Cached”；
2. 版本：procps-3.3.9-10.1         cache值等于/proc/meminfo的 [Cached + SReclaimable]；
3. 版本：procps-ng-3.3.10-3       cache值等于/proc/meminfo的 [Cached + Slab]。

**buff/cache**   buffers 和 cache 的和

**available**
              启动新应用程序的可用内存量。与“缓存”或“可用”字段提供的数据不同，此字段考虑了页面缓存。在kernels 3.14上对应 MemAvailable in/proc/meminfo，在kernels 2.6.27+上和free相同



- Buffers 是对原始磁盘块的临时存储，也就是用来缓存磁盘的数据，通常不会特别大（20MB 左右）。这样，内核就可以把分散的写集中起来，统一优化磁盘的写入，比如可以把多次小的写合并成单次大的写等等。
- Cached 是从磁盘读取文件的页缓存，也就是用来缓存从文件读取的数据。这样，下次访问这些文件数据时，就可以直接从内存中快速获取，而不需要再次访问缓慢的磁盘。
- SReclaimable 是 Slab 的一部分。Slab 包括两部分，其中的可回收部分，用 SReclaimable 记录；而不可回收部分，用 SUnreclaim 记录。

1. Buffer 既可以用作“将要写入磁盘数据的缓存”，也可以用作“从磁盘读取数据的缓存”。
2. Cache 既可以用作“从文件读取数据的页缓存”，也可以用作“写文件的页缓存”。
3. 简单来说，Buffer 是对磁盘数据的缓存，而 Cache 是文件数据的缓存，它们既会用在读请求中，也会用在写请求中。



1. 释放页缓存:  echo 1 > /proc/sys/vm/drop_caches
2. 释放slab对象 (包含 dentries 和 inodes):  echo 2 > /proc/sys/vm/drop_caches
3. 释放slab对象和页缓存: echo 3 > /proc/sys/vm/drop_caches

由于写入此文件是一种非破坏性操作，且脏对象无法释放，因此用户应先运行sync



https://man7.org/linux/man-pages/man1/free.1.html

