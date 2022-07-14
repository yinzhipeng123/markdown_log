IO调度

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207141525167.png)



IO 调度器的总体目标是减少磁盘的寻道时间（因此调度器都是针对机械硬盘进行优化的），IO 调度器通过两种方式来减少磁盘寻道：合并和排序。

合并即当两个或多个 IO 请求的是相邻的磁盘扇区，那么就将这些请求合并为一个请求。通过合并请求，多个 IO 请求只需要向磁盘发送一个请求指令，减少了磁盘的开销。

排序就是将不能合并的 IO 请求，根据请求磁盘扇区的顺序，在请求队列中进行排序，使得磁头可以按照磁盘的旋转顺序的完成 IO 操作，可以减小磁盘的寻道次数。

调度器的算法和电梯运行的策略相似，因此 IO 调度器也被称作 IO 电梯( IO Elevator )。由于对请求进行了重排，一部分的请求可能会被延迟，以提升整体的性能。

Linux 2.4 只使用了一种通用的 IO 算法。到 Linux 2.6 实现了 4 种 IO 调度模型，其中 anticipatory 在 2.6.33 中被移除。

## I/O调度算法

##### Complete Fair Queuing（CFQ）- fairness-oriented

!!! note

    CFQ 为每个进程分配一个 I/O 请求队列，在每个队列的内部，进行合并和排序的优化。CFQ 以轮询的方式处理这些队列，每次从一个队列中处理特定数量的请求（默认为 4 个）。它试图将 I/O 带宽均匀的分配至每个进程。CFQ 原本针对的是多媒体或桌面应用场景，然而，CFQ 其实在许多场景中内表现的很好。CFQ 对每一个 IO 请求都是公平的。这使得 CFQ 很适合离散读的应用 (eg: OLTP DB)。多数企业发型版选择 CFQ 作为默认的 I/O 调度器。



##### Deadline - latency-oriented

!!! note

    Deadline 调度器是设计用来解决 Linus Elevator 导致的 I/O 饿死的问题。对磁盘上某个区域的大量请求，会无限期的饿死 (starvation) 对磁盘其他区域上的请求。请求饿死的一个特例是 写请求饿死读请求 (writes starving reads)，对于进程来说，当需要进行写操作时，由于需要写的数据在内存的 page cache 中，进程是需要修改对应的内存，向内核发送写请求即可，之后进程可以去进行其他操作，由内核负责将数据同步至磁盘中即可。对于进程来说，写请求是异步操作。而读操作是完全不同的，当进程需要读取数据时，需要向内核发送读请求，内核将数据载入到内存中，由于进程往往需要处理读取的数据，因此进程将处于阻塞状态，直到请求被处理完成。对于进程来说，读请求是同步的操作。写请求延迟对系统的性能影响不大，而读请求延迟对系统性能影响是非常大的，因此两种 IO 请求需要区别对待。
    Dealine 调度器专门针对读请求延迟进行了优化，在 deadline 算法中，每一个请求都有一个过期时间。默认情况下，读请求的过期时间是 500ms，写请求的过期时间是 5s。Dealine 调度器也会对请求队列进行合并和排序操作，这个队列称作排序队列（sorted queue）。当新请求被提交，Deadline将其加入到排序队列中进行合并和排序。同时 Deadline 将这个请求加入到第二种类型的队列中，读请求被加入至读FIFO队列 (Read FIFO queue)，写请求被加入到写FIFO队列 (Write FIFO queue)，这两个队列中，请求完全按照 FIFO 顺序排列，即新请求永远被放入到队列的末尾。这样一来 Dealine 就维护三个队列，正常情况下，Deadline 将排序队列中的请求放入到调度队列 (dispatch queue，即将写入磁盘的队列)中，调度队列把请求发送至磁盘驱动。如果写 FIFO 队列或读 FIFO 队列中的请求发生了超时，Deadline 调度器就不再使用排序队列，而是开始将发生超时的 FIFO 队列的请求放入调度队列，直至队列中没有超时的请求，Deadline 通过这样的方式保证所有的请求都不会长时间超时。
    
    Deadling 防止了请求饿死的出现，由于读请求的超时时间远小于写请求，它同时也避免了出现写请求饿死读请求。
    Deadline 比较适合于MySQL数据库。
    deadline（截止时间调度程序）
    最后期限，预期的时间必须完成。具有实时性， 当有一个I/O请求，一定会在指定时间如5ms之内完成。
    作为虚拟机的物理机(virtualization host)，使用deadline可以让所有的虚拟机得到I/O请求。



##### NOOP(No Operation)

!!! note

    该算法实现了最简单的 FIFO 队列，所有 IO 请求按照大致的先后顺序进行操作。之所以说「大致」，原因是 NOOP 在 FIFO 的基础上还做了相邻 IO 请求的合并，但其不会进行排序操作。
    NOOP 适用于底层硬件自身就具有很强调度控制器的块设备（如某些SAN设备），或者完全随机访问的块设备（如SSD）。
    各个调度器在数据库应用下的性能，可以看出CFQ的性能是比较均衡的
    (电梯式调度程序)
    响应很快，CPU不用费时，低开销，也就是不用调度。适合于SSD磁盘，不用合并。ß
    适合于虚拟机virtualization guests，因为写数据最终是虚拟机管理器（上层）来写，所以虚拟机不需要调度



Anticipatory(AS)

!!! note

    AS 调度器是基于 Deadline 调度器，加上了一个启发式的「预测」，假设系统中有大量的写请求，这时如果夹杂几个读请求，由于读请求的过期时间短，读请求立即在多个写请求的中间产生，这样会导致磁盘的来回寻道，AS 试图减少大量写请求夹杂少量读请求产生的寻道风暴（seek storm）。当一个读请求完成后，AS不会立即返回处理队列中的剩余请求，而是等待一个预测时间（默认为 6ms），如果等待的时间内发生了相邻位置的读请求，那么立即处理这个相邻位置的读请求，再返回处理队列中的请求，这样可以优化多余的寻道时间。
    它可以为连续 IO 请求（如顺序读）进行了一定的优化，但是对于随机读的场景 AS 会产生较大的延迟，对于数据库应用很糟糕，而对于 Web Server 可能会表现的不错。这个算法也可以简单理解为面向低速磁盘的，对于使用了 TCG（Tagged Command Queueing）高性能的磁盘和 RAID，使用 AS 会降低性能。
    在 Linux 2.6 - 2.6.18 AS 是内核默认调度器，然而大多数的企业发行版选择的是 CFQ 调度器。
    到Linux 2.6.33 版本，AS 被从内核中移除，因为可以通过调整其他调度器（如 CFQ）来实现与其相似的功能。





## 查看和设置IO调度算法

### 查看

```bash
[root@tuning ~]# cat /sys/block/sda/queue/scheduler
noop anticipatory deadline [cfq]
```

带中括号的就是当前的调度算法

### 临时修改

```bash
[root@tuning ~]# echo deadline > /sys/block/sda/queue/scheduler
[root@tuning ~]# cat /sys/block/sda/queue/scheduler 
noop anticipatory [deadline] cfq
```

### 永久修改调度算法

修改内核参数，加上elevator=调度算法的名字

```bash
[root@tuning ~]$  /boot/grub/grub.conf 
kernel /vmlinuz-2.6.32-642.el6.x86_64 ro root=UUID=b4ae497b-f17c-4e10-9680-ae73fd033824 vga=791 elevator=deadline
#vga=791  ： 分辨率 1024*768
[root@tuning ~]$ reboot
[root@tuning ~]$ cat /sys/block/sda/queue/scheduler 
noop anticipatory [deadline] cfq
```

## 调度算法的参数

### 适合所有调度算法的参数

[root@tuning ~]# ls /sys/block/sda/queue/

#### a、队列的长度	

nr_requests  

```bash
[root@tuning ~]# cd /sys/block/sda/queue/
[root@tuning queue]# cat nr_requests 
128   即128个请求
```

b、read-ahead 预读

#### b、read-ahead 预读

Linux 把读模式分为随机读和顺序读两大类，并只对顺序读进行预读。这一原则相对保守，但是可以保证很高的预读命中率。
为了保证预读命中率，Linux只对顺序读 (sequential read) 进行预读。内核通过验证如下两个条件来判定一个 read() 是否顺序读：

1. 这是文件被打开后的第一次读，并且读的是文件首部；
2. 当前的读请求与前一（记录的）读请求在文件内的位置是连续的。

如果不满足上述顺序性条件，就判定为随机读。任何一个随机读都将终止当前的顺序序列，从而终止预读行为（而不是缩减预读大小）。

**预读窗口**

Linux采用了一个快速的窗口扩张过程

• 首次预读： readahead_size = read_size * 2 // or *4 

预读窗口的初始值是读大小的二到四倍。这意味着在您的程序中使用较大的读粒度（比如32KB）可以稍稍提升I/O效率。

• 后续预读：readahead_size *= 2 

后续的预读窗口将逐次倍增，直到达到系统设定的最大预读大小，其缺省值是 256KB



查看和修改预读窗口 

```bash
$ blockdev --getra device  是/sys/block/$device/queue/read_ahead_kb 的二倍
$ blockdev --setra N device
```

或者直接修改系统参数

```bash
[root@tuning queue]# echo 4096  > /sys/block/sda/queue/read_ahead_kb 
[root@tuning queue]# cat  /sys/block/sda/queue/read_ahead_kb  //其值调成0，关闭了预读机制。
4096	
[root@tuning queue]# blockdev --getra /dev/sda
8192

```

##### blockdev命令

```
[root@localhost ~]# blockdev 

用法：
 blockdev -V
 blockdev --report [设备]
 blockdev [-v|-q] 命令 设备

可用命令有：
 --getsz                   获得 512-字节扇区的大小
 --setro                   设置只读
 --setrw                   设置读写
 --getro                   获得只读
 --getdiscardzeroes        获取 忽略零数据 支持状态
 --getss                   获得逻辑块(扇区)大小
 --getpbsz                 获得物理块(扇区)大小
 --getiomin                获得最小 I/O 大小
 --getioopt                获得最优 I/O 大小
 --getalignoff             获得对齐偏移字节数
 --getmaxsect              获得每次请求的最大扇区数
 --getbsz                  获得块大小
 --setbsz <bytes>          set blocksize on file descriptor opening the block device
 --getsize                 获得 32-bit 扇区数量(已废弃，请使用 --getsz)
 --getsize64               获得字节大小
 --setra <sectors>         设置 readahead
 --getra                   获取 readahead
 --setfra <sectors>        设置文件系统 readahead
 --getfra                  获取文件系统 readahead
 --flushbufs               刷新缓存
 --rereadpt                重新读取分区表
```

​	


​	

## 各个调度算法的参数

Deadline参数

```bash
/sys/block//queue/iosched/writes_starved 
进行一个写操作之前，允许进行多少次读操作
/sys/block//queue/iosched/read_expire 
读请求的过期时间
/sys/block//queue/iosched/read_expire 
写请求的过期时间，默认为 500ms
/sys/block/sda/queue/iosched/front_merges 
是否进行前合并
```

Anticipatory参数

```bash
/sys/block//queue/iosched/antic_expire 
预测等待时长，默认为 6ms
/sys/block//queue/iosched/{write_expire,read_expire} 
读写请求的超时时长
/sys/block//queue/iosched/{write_batch_expire,read_batch_expire} 
读写的批量处理时长
```

CFQ参数

```bash
/sys/block//queue/iosched/slice_idle 
当一个进程的队列被分配到时间片却没有 IO 请求时，调度器在轮询至下一个队列之前的等待时间，以提升 IO 的局部性，对于 SSD 设备，可以将这个值设为 0。
/sys/block//queue/iosched/quantum 
一个进程的队列每次被处理 IO 请求的最大数量，默认为 4，RHEL6 为 8，增大这个值可以提升并行处理 IO 的性能，但可能会造成某些 IO 延迟问题。
/sys/block//queue/iosched/slice_async_rq 
一次处理写请求的最大数
/sys/block//queue/iosched/low_latency 
如果IO延迟的问题很严重，将这个值设为 1
```



CFQ 的进程 IO 优先级和进程 CPU 优先级是独立的。使用 ionice 调整进程优先级，有三种调度类型可以选择



##### 基于分类，优先级队列

Class1(RTreal-time)：实时														

子优级0-7，数字越小0（最高），越大7（最低）

Real time 

这个调度级别的进程产生的IO被优先处理，这个调度类型应小心使用，防止饿死其他进程IO, 它也有8个优先级，数字越大分的的IO时间片越长    	    		    
																					        	
Class2(BE best-effort): 最佳效果，都能访问 默认				    	

子优级0-7，数字越小0（最高），越大7（最低）

Best-effort 

这个类型共有 8 个优先级，分别为 0-7，数字越低，优先级越高，相同级别的优先级使用轮询的方式处理。适用于普通的进程。

在2.6.26之前，没有指定调度类型的进程使用"none" 调度类型，IO调度器将其视作Best-effort进行处理，这个类别中进程优先级由CPU优先级计算得来：io_priority = (cpu_nice + 20) / 5 

2.6.26之后，没有指定调度类型的进程将从CPU调度类型继承而来，这个类别的优先级仍按照CPU优先级计算而来：io_priority = (cpu_nice + 20) / 5			            
																						        
Class3(idle)：空闲

idle 

只有在没有更高优先级的进程产生 IO 时，idle 才可以使用磁盘 IO，适用于哪些不重要的程序（如 updatedb），让它们在磁盘空闲时再产生 IO					                                            	

在cfq调度算法下，ionice 用于设置或更改分类
```
# ionice -p PID		

# ionice -c3 -p PID

# ionice -c1 -n0 dd if=/dev/sda of=/dev/null
```

实验一：
	1、先准备三个文件

```
[root@tuning iosched]# dd if=/dev/zero of=/bigfile1 bs=1M count=1000
[root@tuning iosched]# dd if=/dev/zero of=/bigfile2 bs=1M count=1000
[root@tuning iosched]# dd if=/dev/zero of=/bigfile3 bs=1M count=1000
[root@tuning iosched]# iotop
rt:    real time
be：   best-effort
idle:  idle

[root@tuning ~]# echo 3 > /proc/sys/vm/drop_caches 
[root@tuning ~]# free -m
终端一：看谁使用磁盘
[root@tuning iosched]# iotop
[root@tuning ~]# useradd user1
[root@tuning ~]# useradd user2
[root@tuning ~]# useradd user3

终端二：用user1    ——  C3没有子优先级
[user1@tuning ~]$ time ionice -c3 dd if=/bigfile3 of=/dev/null
2048000+0 records in
2048000+0 records out
1048576000 bytes (1.0 GB) copied, 26.8628 s, 39.0 MB/s

real	0m26.969s
user	0m0.295s
sys	0m5.140s

终端三：用user2  ——  C2默认，可以不写，默认子优先级是4
[root@tuning ~]# su - user2
[user2@tuning ~]$ time ionice -c2 dd if=/bigfile2 of=/dev/null
2048000+0 records in
2048000+0 records out
1048576000 bytes (1.0 GB) copied, 15.5757 s, 67.3 MB/s

real	0m15.609s
user	0m0.167s
sys	0m7.785s

终端四：root   ——  //默认子优先级为4，c1强势
[root@tuning ~]# time ionice -c1 dd if=/bigfile1 of=/dev/null
real	0m12.610s
user	0m0.252s
sys	0m8.938s
```


实验二：分类相同，优先级不同
	0~7
	终端二：
	[user1@tuning ~]$ time ionice -c2 -n0 dd if=/bigfile3 of=/dev/null
	2048000+0 records in
	2048000+0 records out
	1048576000 bytes (1.0 GB) copied, 15.5433 s, 67.5 MB/s
	
	real	0m15.616s
	user	0m0.159s
	sys	0m6.947s
	终端三：
	[user2@tuning ~]$ time ionice -c2 -n7 dd if=/bigfile2 of=/dev/null
	[user2@tuning ~]$ time ionice -c2 -n7 dd if=/bigfile2 of=/dev/null
	2048000+0 records in
	2048000+0 records out
	1048576000 bytes (1.0 GB) copied, 23.3753 s, 44.9 MB/s
	
	real	0m23.399s
	user	0m0.258s
	sys	0m7.202s



实验三：调整已经运行的进程的io调度算法分类及优先级等

```
标签一：
[root@tuning ~]# dd if=/dev/zero of=/testfile
标签二：
[root@tuning iosched]# iotop
标签三：
[root@tuning ~]#  ps -ef | grep dd
root      3028  2230 31 16:51 pts/3    00:00:09 dd if=/dev/zero of=/testfile
root      3033  2229  0 16:51 pts/1    00:00:00 grep dd
[root@tuning ~]# ionice -c3 -p 3028
```

