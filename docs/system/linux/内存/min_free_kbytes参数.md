# min_free_kbytes参数深入解析及优化



```bash
cat /proc/sys/vm/min_free_kbytes
```



min_free_kbytes这个参数，相信很多同学都听说过。给系统预留的最低内存数。但是这个说法太泛泛了，不能完全说清楚这个参数的实际意义。

内核有一整套的内存管理的系统：

1. 一方面要保证性能（让用户申请内存尽可能快）
2. 一方面要确保稳定（紧急时刻有内存保命）

需要在两者之间做均衡。

内存申请时，有很多种类型，有各种flag描述内存申请的策略，为了更好地描述，这里我简单就归为2类：

1. 可以接受等待，内存不足时，等待内存回收，直到申请到为止。
2. 不可接受等待，内存不足时，直接失败。

普通的用户态程序申请内存都是第一类，当内存不足时，可能会由于需要触发回收而导致申请过程的时间变长影响到性能。

一些内核态紧急的内存申请，常见的如网络收发包阶段，很多内存申请都是不可等待的，一旦内存不足，就报失败，表现就可能是丢包，甚至更加严重。

因此，内核会尽可能确保一部分内存是空闲的，给第二类内存申请使用。确保整个系统稳定。这部分内存就就是min_free_kbytes参数控制的。再想一下，就会有这样的疑问：如何做到将这么多的内存空出来呢？这就涉及到内存的回收策略。

仅依赖空闲内存低于这个值，没有任何的缓冲，来做内存回收肯定是很不靠谱的，很容易被突破。因此肯定需要在min上加一个缓冲，还没到min的时候就需要回收，回到了一定的内存之后，就不在回收了。这里就新增了两个数出来，一个是low（触发回收），一个是high（停止回收）。

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202206132208929.png" style="zoom:150%;" />

有3条虚线，从下到上分别是min/low/high

1到2的区域，也就是达到low之前，都不会触发任何的内存回收。

2到3的区域，在low和min之间，任何的内存申请都会触发kswapd后台回收内存。知道free内存达到high停止回收。

3到4的区域，就分两类了，就是之前提到的2类：

1. 部分特殊高优先级的需求，会直接占用min部分预留的内存。
2. 普通的内存申请，会触发direct reclaim，也就是业务进程直接做内存回收，然后再次试一下申请。这种情况就是 direct reclaim（直接回收）（阻塞新的内存申请，这种情况称为Direct reclaim）。direct reclaim 会比较消耗时间的原因是，如果回收的是 dirty page，就会触发磁盘 IO 的操作



当前的内核，min/low/high都是通过min_free_kbytes控制的：

- min=min_free_kbytes
- low=min_free_kbytes+min_free_kbytes/4
- high=min_free_kbytes+min_free_kbytes/2

通常，我们需要调整这个参数，不外乎就是为了这2个原因：

1、稳定性问题，预留内存少，少数高优先级内存申请失败导致系统不稳定。

2、业务经常遇到direct reclaim导致内存申请慢导致业务抖动。

系统默认的min_free_kbytes一般只有几十MB。对于第一点，比较罕见。以前是5u/6u的机器上，遇到较多，一般都是申请高阶内存失败。高阶内存指的是连续的物理内存。有不同的阶数，阶数越高，连续的越大。在5u/6u的内核由于没有动态的内存碎片整理功能，导致内存碎片化更加严重，高阶内存申请更容易失败。

在7u上，这个问题得到显著的改善。


在7u上，调整min_free_kbytes更多得是降低direct reclaim的概率。现在的机器，内存越来越大，整机性能越来越好，单机跑的业务越来越多。每次空闲内存低于min值时，direct reclaim对于业务的影响也越来越明显。特别是rt敏感型的业务，比如DB，影响更是巨大。

而实际上，降低direct reclaim的概率，这个效果也不是非常好，从前面的分析可以看到，free内存低于min值之后，申请内存都会触发direct reclaim。调大这个参数，也直接让触发direct reclaim的内存水位点提高了。

这个效果很一般，主要的效果来自于每次触发kswapd直接回收时，回收的内存变多了。每次回收大约0.5*min_free_kbytes，设置的越大，回收得越多。


这个的代价也非常昂贵，min以下的内存用户态程序是完全不可用的状态。花了很高的代价，获得微小的收益，非常得划不来。且问题依旧严峻。




未来提升内存的使用率后，内存的水位会急剧升高。且单机的内存量也是持续上升，这个问题亟待解决！

要降低direct reclaim的概率，本质上是需要拉大low和min的差值，提供更多的缓冲给到kswapd，让一段时间内kswapd的回收效率跟得上内存申请的速度。单独提供一个内核参数，专门控制low值，而不涉及min值。看了一下upstream上的内核，发现，这个参数已经存在了。。。
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=795ae7a0de6b834a0cc202aa55c190ef81496665


这个patch在4.9的内核中已经存在。watermark_scale_factor 这个参数用来控制low-min的值。		







### 显示内存水位线的脚本



pages_low=1.25倍pages_min，page_high=1.5倍pages_min，当pages_free < pages_low时，就会触发内存的回收，可以通过/proc/sys/vm/min_free_kbytes设置pages_min来控制kswapd0的回收时机

也可以通过下面脚本获取

```bash
mymin() {
    T=min
    sum=0
    for i in $(cat /proc/zoneinfo | grep $T | awk '{print $NF}'); do
        let sum=$sum+$i
    done
    #echo $sum
    let min=$sum*4/1024
    echo "min=${min} MB"
}

mylow() {
    T=low
    sum=0
    for i in $(cat /proc/zoneinfo | grep $T | awk '{print $NF}'); do
        let sum=$sum+$i
    done
    let low=$sum*4/1024
    echo "low=${low} MB"
}

myhigh() {
    T=high
    sum=0
    for i in $(cat /proc/zoneinfo | grep $T | awk '{print $NF}'); do
        let sum=$sum+$i
    done
    let high=$sum*4/1024
    echo "high=${high} MB"
}

mymin
mylow
myhigh
```


zoneinfo 显示的占用的页个数，一个页为4K