# load高的原因

## 前言

其实Linux是不区分线程和进程的，在Linux眼里都是进程，Linux为了完成对线程的POSIX标准，引入了LWP，就是轻量级进程，即我们眼中的线程，线程和进程的创建方法在底层是相同的，都是调用do_fork()方法，只是传参不同。就因为这个使得线程和进程的概念混淆了，有人说系统调度单位是进程，又有人说是线程，其实系统调度的单位一直就没有改变，只是后来部分线程和进程的界限模糊了

查看系统所有的LWP和普通进程：

```bash
$ ps -ALFlf 
```

查看系统中所有的普通进程：

```bash
$ ps -ef
```

**下面说的进程都是说普通进程+LWP**

简单来说，平均负载是指单位时间内，系统处于正在运行、可运行状态和不可中断状态的平均进程（普通进程+LWP）数，它和 CPU 使用率并没有直接关系。

再简单可以把load看成`（正在运行的进程数+不可中断状态的进程数+不可中断状态进程数）`或者把 load看成`（R状态的进程+D状态的进程）`，这只是简单的来说，其实load是个拟合值，其中数学算法比较复杂，具体的计算方法在如下代码中。

load数值的计算代码为：https://github.com/torvalds/linux/blob/master/fs/proc/loadavg.c



### 内核代码如何统计load？

内核使用调度器中的 `nr_running` 和 `nr_uninterruptible` 来计算运行队列的总任务数：

`nr_running`：当前 `TASK_RUNNING` 的任务数。

`nr_uninterruptible`：当前 `TASK_UNINTERRUPTIBLE` 的任务数。

在 `get_avenrun` 函数中，负载值是这样统计的：

```c
count = nr_running() + nr_uninterruptible();
```

**`get_avenrun`** 是 Linux 内核中一个核心函数，用于获取系统的负载平均值（Load Average）。它是负载平均值从内核导出到用户空间的关键接口，主要被用于用户态工具（如 `uptime`、`top`、`w` 等）以显示系统的负载信息。



---

### `get_avenrun` 的主要用途
**1.获取系统负载平均值**：

返回 1 分钟、5 分钟和 15 分钟的负载平均值。

这些值是通过 **指数加权移动平均（EWMA）算法** 持续更新的，保存在内核中的 `avenrun[]` 数组。

**2.为用户态工具提供接口**：

用户态工具通过系统调用（如 `/proc/loadavg` 文件）读取这些值，从而显示系统的负载信息。

**3.为其他内核组件服务**：

某些内核模块可能需要负载信息来辅助决策。例如：

1.调整 CPU 频率（动态调频）。

2.配置资源分配策略。

---

### `get_avenrun` 的代码实现
`get_avenrun` 的具体实现如下（省略一些上下文）：

```c
void get_avenrun(unsigned long *loads, unsigned long offset, int shift)
{
    int i;

    for (i = 0; i < 3; i++)
        loads[i] = (avenrun[i] + offset) << shift;
}
```

#### 代码解读：
**1.输入参数**：

`loads`：指向用户空间或其他内核模块的数组，用于存储计算结果。

`offset`：通常是 `FIXED_1/200`，用来调整精度。

`shift`：用于调整负载值的位移，通常是 `0` 或 `FSHIFT`。

**2.核心逻辑**：

遍历 `avenrun[]`，按需求调整值后填充到 `loads[]` 中。

**3.输出结果**：

1 分钟、5 分钟、15 分钟的负载值被写入 `loads[]`，通常以**固定点数（fixed-point）表示**。

---

### 固定点数的表示
负载值在内核中以**固定点数（fixed-point）**表示，而不是普通浮点数：

`avenrun[]` 中的值以 `FSHIFT`（通常为 11）为小数位偏移。

这样可以避免在内核中使用性能开销更大的浮点数运算。

---

### `get_avenrun` 的调用场景
**1.`/proc/loadavg` 文件**：

用户通过读取 `/proc/loadavg` 文件获取负载平均值，系统会调用 `get_avenrun` 提供数据。

相关代码：
```c
static int loadavg_proc_show(struct seq_file *m, void *v)
{
    unsigned long avnrun[3];

    get_avenrun(avnrun, FIXED_1/200, 0);
    seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu\n",
               LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
               LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
               LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]));
    return 0;
}
```

**2.`uptime`、`top`、`w` 等工具**：

这些工具间接读取 `/proc/loadavg` 或调用系统接口，最终依赖 `get_avenrun` 获取负载值。

**3.内核模块**：

动态负载均衡、资源管理、CPU 调频等需要参考系统的历史负载数据。

---

### `get_avenrun` 的关系图
```plaintext
             /proc/loadavg
                   ↓
            `loadavg_proc_show`
                   ↓
             `get_avenrun`
                   ↓
      使用 `avenrun[]` 提供负载值
```

---



查看系统的load值

```bash
$ cat  /proc/loadavg
0.06 0.04 0.05 1/170 4087
#前三个值为显示最近1分钟，5分钟，15分钟的load值
#第四个数字为，分子为当前处于R状态线程数量，分母为当前系统中有多少个LWP
#第五个数字为，最新创建出来的PID为多少
```

一般load数字在CPU的逻辑个数的二倍以下为正常值

- 处于 R 状态（Running 或 Runnable）的进程是指 `正在运行`  或者 `可运行并等待CPU执行`的进程， ps -ALFlf  命令在第二列 `S`一列中显示 `R`状态的进程
- 处于D 状态（Uninterruptible Sleep，也称为 Disk Sleep）的进程是指 `不可中断状态` 的进程，这些进程不可打断的。比如最常见的是等待硬件设备的 I/O 响应，或者执行某些关键的系统调用，或者进入锁状态，都是会处于D状态

从上述load的计算原理可以看出，导致load 飙高的原因，说简单也简单，无非就是running+runnable 或者 uninterruptible 的task 增多了。但是说复杂也复杂，因为导致task进入uninterruptible状态的路径非常多







## R多导致load飙高

通过vmstat会发现r这一列的数值会飙高，证明大量线程running或者runnable 

通过ps命令可以查询什么程序有多个R和D，然后通过perf 调查程序为什么会有那么多R的问题。通常是由于业务量的增加导致的，属于正常现象，但也有是业务代码bug导致的，比如长循环甚至死循环

```bash
$ ps -e -L h o state,pid,ppid,ucmd:30,cmd:100,wchan:30  |awk  '{if($1=="R"||$1=="D"){print $0}}' | sort | uniq -c
      9 R  5082  2828 sysbench                       sysbench --threads=20 --max-time=300 threads run                                                     -
      1 R  5082  2828 sysbench                       sysbench --threads=20 --max-time=300 threads run                                                     futex_wait_queue_me
      1 R  5115  1861 ps                             ps -e -L h o state,pid,ppid,ucmd:30,cmd:100,wchan:30                                                 -
      1 R  5116  1861 awk                            awk {if($1=="R"||$1=="D"){print $0}}                                                                 -
      1 R     9     2 rcu_sched                      [rcu_sched] 
```



## D多导致load飙高

### IO原因

通过vmstat会发现b这一列的数值会飙高，证明大量线程因为等待IO而处于D状态。

```bash
$ vmstat -wt 1
procs -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu-------- -----timestamp-----
 r  b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st                 CST
 1  28           0       983824       187652      2400824    0    0     0     5    3   1   10  20  0  70   0 2022-05-21 20:10:06
```

通过iostat -xt 1 可以查看磁盘的await会飙高

```bash
$ iostat -xt 1
Linux 3.10.0-1160.45.1.el7.x86_64 (VM-0-20-centos) 	05/21/2022 	_x86_64_	(2 CPU)
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.62    0.02    1.55     0.65    10.18    13.83     0.00    999.4   0.10   999.3   0.35   0.06
vdb               0.00     0.00    0.00    0.00     0.00     0.00    48.89     0.00    0.45    0.45    0.00   0.33   0.00
```



### 内存原因

- task 在申请内存的时候，可能会触发内存回收，如果触发的是直接内存回收，那对性能的伤害很大。当前task 会被阻塞直到内存回收完成。一般这种只是暂时
- 因为内存的分配是以页进行分配，有的时候，有的程序需要某个大小的页的内存或者连续的内存空间没有，导致分配内存的系统调用处于D状态，后续的内存申请都不能完成，导致大量线程处于D状态等待，从而load高

### 网络原因

如果网卡的大量的丢包或者重传，就会导致程序处于D状态，如果D状态进程太多，就会导致load高

### 锁

一般这种情况，通过vmstat查看系统可以r和b都非常少，但是通过ps命令查询D状态的进程非常多

```bash
$ vmstat -wt 1
procs -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu-------- -----timestamp-----
 r  b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st                 CST
 1  0           0       983824       187652      2400824    0    0     0     5    3   1   0   0   100  0   0 2022-05-21 20:10:06
$ ps -e -L h o state,pid,ppid,ucmd:30,cmd:100,wchan:30  |awk  '{if($1=="R"||$1=="D"){print $0}}' | sort | uniq -c
99 D  5082  2828 sysbench   sysbench --threads=20 --max-time=300 threads run                                              futex_wait_queue_me 
```

当某些程序执行系统调用时。该系统调用处于死锁状态，后续的程序只要运行该系统调用时，就会让程序处于D状态，造成大量进程处于D状态，从而LOAD高

这种就比较棘手，通过上面的PS命令查询处于D状态的进程执行的wchan，可以看到程序执行哪些系统调用进入了死锁状态，也可以查看/proc/${pid}/stat 以及/proc/${pid}/task/${pid}/stat 文件 查看进程在哪些系统调用进入了死锁状态。即使知道哪个系统调用进入死锁，但是也不知道哪个程序导致该系统调用第一个进入死锁状态的，所以需要开发专用的追踪内核程序来分析





https://baijiahao.baidu.com/s?id=1719292352009888378&wfr=spider&for=pc

https://www.isolves.com/it/rj/czxt/linux/2019-08-22/3631.html