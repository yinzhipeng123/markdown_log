# 频繁上下文切换导致sys高

#### 前言

CPU 上下文切换是保证 Linux 系统正常工作的一个核心功能，按照不同场景，可以分为进程上下文切换、线程上下文切换和中断上下文切换。

vmstat 是一个常用的系统性能分析工具，主要用来分析系统的内存使用情况，也常用来分析 CPU 上下文切换和中断的次数。

比如，下面就是一个 vmstat 的使用示例：

```bash
# 每隔5秒输出1组数据
$ vmstat 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  0      0 7005360  91564 818900    0    0     0     0   25   33  0  0 100  0  0
```

我们一起来看这个结果，你可以先试着自己解读每列的含义。在这里，我重点强调下，需要特别关注的四列内容：

- cs（context switch）是每秒上下文切换的次数。
- in（interrupt）则是每秒中断的次数。
- r（Running or Runnable）是就绪队列的长度，也就是正在运行和等待 CPU 的进程数。
- b（Blocked）则是处于不可中断睡眠状态的进程数。

可以看到，这个例子中的上下文切换次数 cs 是 33 次，而系统中断次数 in 则是 25 次，而就绪队列长度 r 和不可中断状态进程数 b 都是 0。

vmstat 只给出了系统总体的上下文切换情况，要想查看每个进程的详细情况，就需要使用我们前面提到过的 pidstat 了。给它加上 -w 选项，你就可以查看每个进程上下文切换的情况了。

比如说：

```bash
# 每隔5秒输出1组数据
$ pidstat -w 5
Linux 4.15.0 (ubuntu)  09/23/18  _x86_64_  (2 CPU)

08:18:26      UID       PID   cswch/s nvcswch/s  Command
08:18:31        0         1      0.20      0.00  systemd
08:18:31        0         8      5.40      0.00  rcu_sched
...
```



这个结果中有两列内容是重点关注对象。一个是 cswch ，表示每秒自愿上下文切换（voluntary context switches）的次数，另一个则是 nvcswch ，表示每秒非自愿上下文切换（non voluntary context switches）的次数。

这两个概念一定要牢牢记住，因为它们意味着不同的性能问题：

- 所谓自愿上下文切换，是指进程无法获取所需资源，导致的上下文切换。比如说， I/O、内存等系统资源不足时，就会发生自愿上下文切换。
- 而非自愿上下文切换，则是指进程由于时间片已到等原因，被系统强制调度，进而发生的上下文切换。比如说，大量进程都在争抢 CPU 时，就容易发生非自愿上下文切换。



#### 使用 sysbench 来模拟系统多线程调度切换的情况

- 机器配置：4 CPU，8GB 内存
- 预先安装 sysbench 和 sysstat 包， yum install sysbench sysstat

终端1：

```bash
# 以10个线程运行5分钟的基准测试，模拟多线程切换的问题
[root@centos ~]# sysbench --threads=10 --max-time=300 threads run
```

终端2：

```bash
[root@centos ~]# vmstat -wt 1
procs -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu-------- -----timestamp-----
 r  b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st                 CST
 0  0            0      5903872       257528      1504408    0    0     0    12 1588 3094   0   0 100   0   0 2022-05-20 03:24:36
 0  0            0      5903872       257528      1504408    0    0     0     0 1543 2985   0   0 100   0   0 2022-05-20 03:24:37
 5  0            0      5902564       257528      1504408    0    0     0     0 15689 229995   6  12  82   0   0 2022-05-20 03:24:38
 4  0            0      5902200       257528      1504408    0    0     0     0 39276 959684  35  57   8   0   0 2022-05-20 03:24:39
 4  0            0      5902200       257528      1504408    0    0     0     0 40576 1106457  34  57   9   0   0 2022-05-20 03:24:40
 4  0            0      5902200       257528      1504408    0    0     0     0 39332 1016539  35  57   9   0   0 2022-05-20 03:24:41
 6  0            0      5902200       257528      1504408    0    0     0    12 40197 980060  35  56   9   0   0 2022-05-20 03:24:42
 7  0            0      5902200       257528      1504408    0    0     0     0 39096 1054514  36  56   9   0   0 2022-05-20 03:24:43
 6  0            0      5902200       257528      1504408    0    0     0     0 38769 1049458  35  57   9   0   0 2022-05-20 03:24:44
 6  0            0      5902200       257528      1504408    0    0     0     0 34921 972992  36  56   8   0   0 2022-05-20 03:24:45
```

你应该可以发现，cs 列的上下文切换次数从之前的 2000多 骤然上升到了 110 万。

同时，注意观察其他几个指标：

r 列：就绪队列的长度已经到了 7，远远超过了系统 CPU 的个数 4，所以肯定会有大量的 CPU 竞争。

us（user）和 sy（system）列：这两列的 CPU 使用率加起来上升到了 99%，其中系统 CPU 使用率，也就是 sy 列高达 57%，说明 CPU 主要是被内核占用了。

in 列：中断次数也上升到了 4 万左右，说明中断处理也是个潜在的问题。综合这几个指标，系统的就绪队列过长，也就是正在运行和等待 CPU 的进程数过多，导致了大量的上下文切换，而上下文切换又导致了系统 CPU 的占用率升高。那么到底是什么进程导致了这些问题呢？

终端3：

```bash
$ pidstat -w -u -t 1
Average:      UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
Average:        0      1188         -    0.30    0.60    0.00    0.90     -  rshim
Average:        0         -      1188    0.30    0.60    0.00    0.90     -  |__rshim
Average:        0      8916         -    0.20    0.30    0.00    0.50     -  YDService
Average:        0         -      8919    0.00    0.10    0.00    0.10     -  |__YDService
Average:        0         -     24019    0.10    0.00    0.00    0.10     -  |__YDService
Average:        0      8926         -    0.00    0.10    0.00    0.10     -  YDLive
Average:        0     28048         -    0.00    0.10    0.00    0.10     -  kworker/3:1
Average:        0         -     28048    0.00    0.10    0.00    0.10     -  |__kworker/3:1
Average:        0     28408         -  100.00  100.00    0.00  100.00     -  sysbench
Average:        0         -     28409   14.49   24.28    0.00   38.76     -  |__sysbench
Average:        0         -     28410   14.79   23.88    0.00   38.66     -  |__sysbench
Average:        0         -     28411   14.99   23.78    0.00   38.76     -  |__sysbench
Average:        0         -     28412   14.39   22.48    0.00   36.86     -  |__sysbench
Average:        0         -     28413   14.39   23.58    0.00   37.96     -  |__sysbench
Average:        0         -     28414   14.29   23.88    0.00   38.16     -  |__sysbench
Average:        0         -     28415   14.89   23.88    0.00   38.76     -  |__sysbench
Average:        0         -     28416   14.29   24.38    0.00   38.66     -  |__sysbench
Average:        0         -     28417   13.99   23.28    0.00   37.26     -  |__sysbench
Average:        0         -     28418   15.18   24.18    0.00   39.36     -  |__sysbench
Average:        0     28432         -    0.40    0.90    0.00    1.30     -  pidstat
Average:        0         -     28432    0.40    0.90    0.00    1.30     -  |__pidstat

Average:      UID      TGID       TID   cswch/s nvcswch/s  Command
Average:        0         6         -      4.70      0.00  ksoftirqd/0
Average:        0         -         6      4.70      0.00  |__ksoftirqd/0
Average:        0         9         -     15.08      0.00  rcu_sched
Average:        0         -         9     15.08      0.00  |__rcu_sched
Average:        0         -     28048      3.40      0.00  |__kworker/3:1
Average:        0     28184         -      0.10      0.00  bash
Average:        0         -     28184      0.10      0.00  |__bash
Average:       89     28341         -      0.10      0.00  pickup
Average:       89         -     28341      0.10      0.00  |__pickup
Average:        0     28405         -      0.50      0.00  kworker/3:0
Average:        0         -     28405      0.50      0.00  |__kworker/3:0
Average:        0         -     28409  25990.21  65447.15  |__sysbench
Average:        0         -     28410  25781.02  66814.89  |__sysbench
Average:        0         -     28411  25511.19  64601.10  |__sysbench
Average:        0         -     28412  26991.11  62141.86  |__sysbench
Average:        0         -     28413  26430.07  65891.11  |__sysbench
Average:        0         -     28414  26558.14  64489.21  |__sysbench
Average:        0         -     28415  26396.90  63810.69  |__sysbench
Average:        0         -     28416  26074.23  63148.05  |__sysbench
Average:        0         -     28417  26524.78  67813.79  |__sysbench
Average:        0         -     28418  25621.38  69440.06  |__sysbench
Average:        0     28432         -      1.00      0.90  pidstat
Average:        0         -     28432      1.00      0.90  |__pidstat
```

从 pidstat 的输出你可以发现，CPU 使用率的升高果然是 sysbench 导致的，它的 CPU 使用率已经达到了 100%。上下文切换罪魁祸首，还是过多的 sysbench 线程。

终端4：

```bash
[root@VM-0-16-centos ~]# watch -n 1 -d cat /proc/interrupts
Every 1.0s: cat /proc/interrupts                                                                                                                                                    Fri May 20 04:03:32 2022

           CPU0       CPU1	 CPU2       CPU3
  0:         88          0          0          0   IO-APIC-edge      timer
  1:         10          0          0          0   IO-APIC-edge      i8042
  4:        387          0          0          0   IO-APIC-edge      serial
  6:          3          0          0          0   IO-APIC-edge      floppy
  8:          0          0          0          0   IO-APIC-edge      rtc0
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 11:          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb1, virtio3
 12:         15          0          0          0   IO-APIC-edge      i8042
 14:    5016380          0          0          0   IO-APIC-edge      ata_piix
 15:          0          0          0          0   IO-APIC-edge      ata_piix
 24:          0          0          0          0   PCI-MSI-edge      virtio1-config
 25:    2810303          0          0          0   PCI-MSI-edge      virtio1-req.0
 26:         10          0          0          0   PCI-MSI-edge      virtio0-config
 27:    4356739          0          0          0   PCI-MSI-edge      virtio0-input.0
 28:          1          0          0          0   PCI-MSI-edge      virtio0-output.0
 29:          1    1136553          0          0   PCI-MSI-edge      virtio0-input.1
 30:          1          0          0          0   PCI-MSI-edge      virtio0-output.1
 31:          0          0          0          0   PCI-MSI-edge      virtio2-config
 32:        343          0          0          0   PCI-MSI-edge      virtio2-req.0
NMI:          0          0          0          0   Non-maskable interrupts
LOC: 1782951044 1786075743 1867019728 1796389760   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          0          0          0   Performance monitoring interrupts
IWI:    1957371    1944591    1726299    1928079   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:  201178492  201387163  198141978  204827265   Rescheduling interrupts
CAL:     157144     725105    2071436    2165417   Function call interrupts
TLB:    2732341    2720775    2684270    2657260   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:	  17122      17122	17122	   17122   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
NPI:          0          0          0          0   Nested posted-interrupt event
PIW:          0          0          0          0   Posted-interrupt wakeup event
```

前面在观察系统指标时，除了上下文切换频率骤然升高，还有一个指标也有很大的变化。是的，正是中断次数。中断次数也上升到了 4 万，但到底是什么类型的中断上升了。既然是中断，它只发生在内核态，而 pidstat 只是一个进程的性能分析工具，并不提供任何关于中断的详细信息，怎样才能知道中断发生的类型呢？那就是从 /proc/interrupts 这个只读文件中读取。/proc 实际上是 Linux 的一个虚拟文件系统，用于内核空间与用户空间之间的通信。/proc/interrupts 就是这种通信机制的一部分，提供了一个只读的中断使用情况。

观察一段时间，你可以发现，变化速度最快的是重调度中断（RES），这个中断类型表示，唤醒空闲状态的 CPU 来调度新的任务运行。这是多处理器系统（SMP）中，调度器用来分散任务到不同 CPU 的机制，通常也被称为处理器间中断（Inter-Processor Interrupts，IPI）。所以，这里的中断升高还是因为过多任务的调度问题，跟前面上下文切换次数的分析结果是一致的。

终端5：

```bash
[root@VM-0-16-centos ~]# cat /proc/interrupts ; sleep 1s ;cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:         88          0          0          0   IO-APIC-edge      timer
  1:         10          0          0          0   IO-APIC-edge      i8042
  4:        387          0          0          0   IO-APIC-edge      serial
  6:          3          0          0          0   IO-APIC-edge      floppy
  8:          0          0          0          0   IO-APIC-edge      rtc0
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 11:          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb1, virtio3
 12:         15          0          0          0   IO-APIC-edge      i8042
 14:    5016252          0          0          0   IO-APIC-edge      ata_piix
 15:          0          0          0          0   IO-APIC-edge      ata_piix
 24:          0          0          0          0   PCI-MSI-edge      virtio1-config
 25:    2810206          0          0          0   PCI-MSI-edge      virtio1-req.0
 26:         10          0          0          0   PCI-MSI-edge      virtio0-config
 27:    4356352          0          0          0   PCI-MSI-edge      virtio0-input.0
 28:          1          0          0          0   PCI-MSI-edge      virtio0-output.0
 29:          1    1136531          0          0   PCI-MSI-edge      virtio0-input.1
 30:          1          0          0          0   PCI-MSI-edge      virtio0-output.1
 31:          0          0          0          0   PCI-MSI-edge      virtio2-config
 32:        343          0          0          0   PCI-MSI-edge      virtio2-req.0
NMI:          0          0          0          0   Non-maskable interrupts
LOC: 1782787996 1785909076 1866856961 1796226528   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          0          0          0   Performance monitoring interrupts
IWI:    1957329    1944532    1726246    1928026   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:  199987693  200087749  197045111  203640135   Rescheduling interrupts
CAL:     157140     725022    2071329    2165308   Function call interrupts
TLB:    2732319    2720756    2684264    2657244   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:      17122      17122      17122      17122   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
NPI:          0          0          0          0   Nested posted-interrupt event
PIW:          0          0          0          0   Posted-interrupt wakeup event
           CPU0       CPU1       CPU2       CPU3       
  0:         88          0          0          0   IO-APIC-edge      timer
  1:         10          0          0          0   IO-APIC-edge      i8042
  4:        387          0          0          0   IO-APIC-edge      serial
  6:          3          0          0          0   IO-APIC-edge      floppy
  8:          0          0          0          0   IO-APIC-edge      rtc0
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 11:          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:usb1, virtio3
 12:         15          0          0          0   IO-APIC-edge      i8042
 14:    5016254          0          0          0   IO-APIC-edge      ata_piix
 15:          0          0          0          0   IO-APIC-edge      ata_piix
 24:          0          0          0          0   PCI-MSI-edge      virtio1-config
 25:    2810206          0          0          0   PCI-MSI-edge      virtio1-req.0
 26:         10          0          0          0   PCI-MSI-edge      virtio0-config
 27:    4356355          0          0          0   PCI-MSI-edge      virtio0-input.0
 28:          1          0          0          0   PCI-MSI-edge      virtio0-output.0
 29:          1    1136531          0          0   PCI-MSI-edge      virtio0-input.1
 30:          1          0          0          0   PCI-MSI-edge      virtio0-output.1
 31:          0          0          0          0   PCI-MSI-edge      virtio2-config
 32:        343          0          0          0   PCI-MSI-edge      virtio2-req.0
NMI:          0          0          0          0   Non-maskable interrupts
LOC: 1782789324 1785910399 1866858200 1796227706   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          0          0          0   Performance monitoring interrupts
IWI:    1957329    1944533    1726247    1928026   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:  199997549  200099900  197051402  203648151   Rescheduling interrupts
CAL:     157140     725022    2071329    2165308   Function call interrupts
TLB:    2732319    2720756    2684264    2657244   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:      17122      17122      17122      17122   Machine check polls
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
NPI:          0          0          0          0   Nested posted-interrupt event
PIW:          0          0          0          0   Posted-interrupt wakeup event
```

从1秒钟的数量变化来计算，RES在4个CPU中断次数变化差  的总和 差不多是 4W

所以，这里的中断升高还是因为过多任务的调度问题，跟前面上下文切换次数的分析结果是一致的。



- 自愿上下文切换变多了，说明进程都在等待资源，有可能发生了 I/O 等其他问题；
- 非自愿上下文切换变多了，说明进程都在被强制调度，也就是都在争抢 CPU，说明 CPU 的确成了瓶颈；
- 中断次数变多了，说明 CPU 被中断处理程序占用，还需要通过查看 /proc/interrupts 文件来分析具体的中断类型。









