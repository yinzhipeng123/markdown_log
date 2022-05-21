# vmstat

vmstat命令的含义为显示虚拟内存状态（“Viryual Memor Statics”），但是它可以报告关于进程、内存、I/O等系统整体运行状态。

#### vmstat选项参数

-a：显示活动内页；
-f：显示启动后创建的进程总数；
-m：显示slab信息；
-n：头信息仅显示一次；
-s：以表格方式显示事件计数器和内存状态；
-d：报告磁盘状态；
-p：显示指定的硬盘分区状态；
-S：输出信息的单位。
-w, --wide             详细内容
-t, --timestamp        显示时间戳
-h, --help     显示帮助
-V, --version  显示版本

```bash
[root@VM-0-16-centos ~]# vmstat -wt 1 3
procs -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu-------- -----timestamp-----
 r  b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st                 CST
 1  0            0      6388276       257024      1030324    0    0     0     1    0    2   0   0 100   0   0 2022-05-20 02:03:35
 0  0            0      6388136       257024      1030324    0    0     0    16 1576 3013   0   0 100   0   0 2022-05-20 02:03:36
 0  0            0      6388136       257024      1030324    0    0     0     0 1523 2974   0   0 100   0   0 2022-05-20 02:03:37
```

- "vmstat命令详情"

- "r:运行队列中线程数量,r+b的值，应该小于cpu个数的两倍"
- "b:IO发生阻塞的线程数量，当b数量大于5时，应该排查磁盘或者swap"
- "swpd:使用虚拟内存大小"
- "free:可用内存大小"
- "buff:用于缓冲的内存大小"
- "cache:用于缓存的内存大小"
- "cache是被从磁盘中读出来的，而buff是即将要被写入磁盘的"
- "si:每秒从交换区写到内存的大小，如果这个值大于0，说明内存不足"
- "so:每秒从内存写到交换区的大小"
- "bi:每秒读取的块数"
- "bo:每秒写入的块数"
- "in:每秒的中断数，包括时钟。"
- "cs:每秒上下文切换数,如果cs数字远大于in的数字，说明系统在忙于分配任务，没有忙于在任务上"
- "us:用户进程执行时间"
- "sy:系统进程执行时间"
- "id:空闲时间（包括IO等待时间）"
- "wa:等待IO时间"
- "st:从虚拟机窃取的时间。 在Linux 2.6.11之前，未知"





#### vmstat -a 2 5 

-a 显示活跃和非活跃内存,所显示的内容除增加inact和active

```bash
[root@VM-0-16-centos ~]# vmstat -a 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy id wa st
 3  0      0 6387664 473120 890368    0    0     0     1    0    0  0  0 100  0  0
 0  0      0 6387516 473120 890612    0    0     0     0 1545 2986  0  0 100  0  0
 0  0      0 6387392 473120 890612    0    0     0     0 1556 3026  0  0 100  0  0
 0  0      0 6387268 473120 890612    0    0     0     6 1530 2984  0  0 100  0  0
 1  0      0 6387268 473120 890612    0    0     0     0 1545 3010  0  0 100  0  0
```



#### vmstat -f

显示从系统启动至今的fork数量，linux下创建进程的系统调用是fork

说明：信息是从/proc/stat中的processes字段里取得的

```bash
$ vmstat -f
351164 forks
```



#### vmstat -s

显示内存相关统计信息及多种系统活动数量

说明：这些信息的分别来自于/proc/meminfo，/proc/stat和/proc/vmstat

```bash
[root@VM-0-16-centos ~]# vmstat -s
      8008632 K total memory
       332136 K used memory
       889664 K active memory
       473120 K inactive memory
      6389112 K free memory
       257024 K buffer memory
      1030360 K swap cache
            0 K total swap
            0 K used swap
            0 K free swap
      1556482 non-nice user cpu ticks
          669 nice user cpu ticks
      2101154 system cpu ticks
   2039287171 idle cpu ticks
       108247 IO-wait cpu ticks
            0 IRQ cpu ticks
          846 softirq cpu ticks
            0 stolen cpu ticks
      4931445 pages paged in
     21441536 pages paged out
            0 pages swapped in
            0 pages swapped out
   3703040179 interrupts
   2621374916 CPU context switches
   1647854161 boot time
       351175 forks
[root@VM-0-16-centos ~]# 
```



#### vmstat -d

查看磁盘的读写

说明：这些信息主要来自于/proc/diskstats

```bash
[root@VM-0-16-centos ~]# vmstat -d
disk- ------------reads------------ ------------writes----------- -----IO------
       total merged sectors      ms  total merged sectors      ms    cur    sec
vda    92280    820 9843254  345762 3037845 1006144 42883201 5918518      0   1830
vdb      387      0   18920     188      0      0       0       0      0      0
sr0       99      0     716      18      0      0       0       0      0      0
[root@VM-0-16-centos ~]#
```



#### vmstat -p /dev/vda1

显示指定磁盘分区统计信息

说明：这些信息主要来自于/proc/diskstats.

reads:来自于这个分区的读的次数。

read sectors:来自于这个分区的读扇区的次数。

writes:来自于这个分区的写的次数。

requested writes:来自于这个分区的写请求次数。

```
[root@VM-0-16-centos ~]# vmstat -p /dev/vda1
vda1          reads   read sectors  writes    requested writes
               92247    9840886    3019912   42883513
```



#### vmstat -m

查看系统的slab信息

```bash
[root@VM-0-16-centos ~]# vmstat -m
Cache                       Num  Total   Size  Pages
fuse_request                  0      0    416     19
fuse_inode                    0      0    768     21
isofs_inode_cache            50     50    640     25
mlx_compat_radix_tree_node     28     28    584     28
ext4_groupinfo_4k           420    420    136     30
ext4_inode_cache          32421  32432   1024     16
ext4_xattr                  138    138     88     46
ext4_free_data             1024   1024     64     64
ext4_allocation_context     128    128    128     32
...
```

