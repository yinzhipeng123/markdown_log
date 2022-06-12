# Linux OOM机制

OOM(Out Of Memory)机制为Linux内核中一种自我保护机制，当系统分配不出内存时(触发条件)会触发这个机制，由系统在已有进程中挑选一个占用内存较多，回收内存收益最大的进程杀掉来释放内存。

Linux下允许程序申请比系统可用内存更多的内存(如malloc函数)，这个特性叫Overcommit。这么做是出于优化系统的考虑，因为并不是所有的程序申请了内存就立刻使用，当使用的时候说不定系统已经回收了一些内存资源了。不过当需要真正使用内存资源而系统已经没有多余的内存资源可用时，OOM机制就被触发了。

Linux下有3种Overcommit策略，可以通过/proc/sys/vm/overcommit_memory配置，取0、1和2三个值，默认是0。

1. 取值0：允许利用算法合理的过度分配；
2. 取值1：允许分配比当前内存资源多的内存；
3. 取值2：系统所能分配的内存资源不能超过swap+内存资源*系数(/proc/sys/vm/overcommit_ratio，默认50%，可调整)。如果资源已经用光，再有内存申请请求时，都会返回错误。

### OOM-Kill策略

OOM-Killer策略就是说在发生OOM时，会选择一些进程来杀掉以释放一部分缓存资源。

Linux下每个进程都有一个OOM权重，在/proc/<pid>/oom_adj里面，取值是-17到+15(为-17此进程不会被杀掉)，取值越高，越容易被杀掉。

最终OOM-Killer是通过**/proc/<pid>/oom_score**这个值来决定哪个进程被杀死。这个值是系统综合进程的内存消耗量、CPU时间(utime+stime)、存活时间(utime - start_time)和oom_adj计算出的，消耗内存越多oom_score值越高，存活时间越长值越低。另外，Linux在计算进程的内存消耗的时候，会将子进程所耗内存的一半算到父进程中(有兴趣的话可以查看内核代码mm/oom_kill.c：badness函数)。

总之，OOM-Killer策略是：损失最少的工作，释放最大的内存；同时不伤及无辜的用了很大内存的进程，并且杀掉的进程数尽量少。



### OOM机制实现

内核在触发OOM机制时会调用到out_of_memory函数，此函数的调用顺序如下：

`__alloc_pages`
   ` |-->__alloc_pages_nodemask`
      ` |--> __alloc_pages_slowpath`
          ` |--> __alloc_pages_may_oom`
              `| --> out_of_memory`

以上函数__alloc_pages_may_oom在调用之前会先判断oom_killer_disabled的值，如果有值，则不会触发OOM机制；

Bool型变量oom_killer_disabled定义在文件mm/page_alloc.c中，并没有提供外部接口更改此值，但是在内核中此值默认为0，表示打开OOM-kill。

Linux中内存都是以页的形式管理的，所以不管是怎么申请内存，都会调用alloc_page函数，最终调用到函数out_of_memory，触发OOM机制。

下面简要说明函数**out_of_memory**流程。

函数**out_of_memory**

1.  判断全局变量sysctl_panic_on_oom==2，成立则直接panic
2.  获取/proc/sys/vm/overcommit_memory中的配置的值：
    a)  为2：直接将当前进程杀死；
    b)  为0：判断sysctl_panic_on_oom是否有值，有值直接panic，否则调用`__out_of_memory函数`；
    c)  为1：调用__out_of_memory函数



`__out_of_memory`函数，其流程如下：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202206112223496.png)



以上流程中值得关注的地方有：

1. 变量sysctl_panic_on_oom，此值可以通过/proc/sys/vm/panic_on_oom设置，默认为0；

2. 变量sysctl_oom_kill_allocating_task，此值可以通过/proc/sys/vm/oom_kill_allocating_task设置，默认为0；

3. 当内存资源紧张，同时也没有可以杀死的进程时，系统会panic；

4. 杀死进程需要调用函数oom_kill_process，此函数核心步骤就是先杀死指定进程的子进程p->children，然后杀死指定进程p，具体杀死进程的函数为oom_kill_task。

   

下面简要说明函数**oom_kill_task**  


函数**oom_kill_task**

此函数流程如下：

![](https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202206112245160.png)





以上流程中值得关注的地方有：

1. p->signal->oom_adj的值，此值可以通过/proc/<pid>/oom_adj设置；
2. 变量sysctl_would_have_oomkilled，此值可以通过/proc/sys/vm/would_have_oomkilled设置，默认为0。

总结


通过前面介绍，可以看到Linux中OOM机制是否会触发，与以下几个变量有关：
1.  oom_killer_disabled：此值虽然没有提供外部接口更改，但是可以通过给内核打patch，增加一个外部接口，使此值可动态改变
2.  sysctl_panic_on_oom：此值一般不建议设置，因为如果申请不到内存，系统就panic了；
3.  sysctl_oom_kill_allocating_task：此值设置为1，类似给接口/proc/sys/vm/overcommit_memory，设置值为2，被设置后，某个进程要申请内存失败时直接将该进程杀死；
4.  sysctl_would_have_oomkilled：此值设置为1，也不会真正的去杀死进程
5.  p->signal->oom_adj：此值可以通过接口/proc/<pid>/oom_adj设置值为-17，表示该进程不可被杀死。

### OOM机制的几组测试

#### 测试1 打开OOM机制（默认）

物理机器配置：2G内存，无swap分区

执行命令：20个depmod -a命令

结果：

1.  机器运行一段时间，可以看到/var/log/message中出现out of memory： kill  process信息；
1.  当无进程可杀时，机器panic。

#### 测试2 关闭OOM机制

通过给内核打patch，将oom_killer_disabled值设置为1，另外通过sys接口将sysctl_would_have_oomkilled值设置为1。
1. 有swap分区时
  物理机器配置：2G内存，2G大小swap分区
  执行命令：20个depmod -a命令
  结果：

  a) 机器运行一段时间，/var/log/message中不出现out of memory： kill  process * 字样

  b) free -m -s 1命令观察当前内存使用情况，可以发现内存使用完毕后，开始使用swap分区，当swap分区使用完后，系统会每隔一段时间释放出一段swap分区的空间，此时机器很卡。

2. 无swap分区时
  物理机器配置：2G内存，无swap分区
  执行命令：20个depmod -a命令
  结果：
  a) 机器运行一段时间，/var/log/message中不出现out of memory： kill  process * 字样；

  b) free -m -s 1命令观察当前内存使用情况，可以发现内存使用完毕后，机器很卡，无法操作 ，但是可以ping通。



测试结果分析

关闭OOM机制，虽然不会出现杀进程的现象，但是应用程序在申请内存资源时由于内存资源紧张导致申请不到资源，可能会出现一直循环申请内存，直到申请到为止，在未申请到内存资源之前，会一直占用某个CPU不放，导致机器卡住。

从测试中可以看到，swap分区能够缓解一下内存紧张的情况，如果能够利用好swap分区，并且应用程序不会出现内存泄漏等问题时，可以缓解内存紧张的情况，但还是不能避免机器卡住的现象。另一方面，当机器卡住时，性能已经无法保证。