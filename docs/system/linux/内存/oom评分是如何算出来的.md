



## oom_score



Linux的OOM-Kill策略是为了在内存不足的情况下，杀掉消耗内存最多、优先级最低的任务，从而保障系统不被搞挂。这里有两个取决因素：

1. /proc/<pid>/oom_score内核通过内存消耗计算得出 
2. /proc/<pid>/oom_score_adj允许用于自定义，等同于优先级，优先级越高值越小（-1000 ~1000）。
3. /proc/<pid>/oom_adj里面，取值是-17到+15(为-17此进程不会被杀掉)，取值越高，越容易被杀掉。

当内存紧张的时候，内核通过 oom = oom_score + oom_score_adj 计算出分数最高的进程，向其发送关闭信号。

整个流程怎样的呢？直接上代码（代码位于内核/mm/oom_kill.c）

1、计算oom

```c
//计算oom
unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
			  const nodemask_t *nodemask, unsigned long totalpages)
{

//总内存= 物理内存 + 交换分区
*totalpages = totalram_pages + total_swap_pages;

//累加 常驻内存RSS + 进程页面 +交换内存
points = get_mm_rss(p->mm) + atomic_long_read(&p->mm->nr_ptes) +
		 get_mm_counter(p->mm, MM_SWAPENTS);

//oom_score_adj 归一化
adj *= totalpages / 1000;
//oom = oom_score + oom_score_adj 
points += adj;
```

2、通过循环调用oom_badness找出oom最大的进程

```c
//找出oom最大的进程
static struct task_struct *select_bad_process(unsigned int *ppoints,
		unsigned long totalpages, const nodemask_t *nodemask,
		bool force_kill)
		//循环遍历所有进程
		for_each_process_thread(g, p) {
		//调用上面的oom_badness方法计算oom
		points = oom_badness(p, NULL, nodemask, totalpages);
		
		//选出最大oom进程
		if (!points || points < chosen_points)
			continue;
		if (points == chosen_points && thread_group_leader(chosen))
			continue;
		chosen = p;
		chosen_points = points;
```

3、关闭进程

```c
//发送kill信号关闭进程
oom_kill_process(p, gfp_mask, order, points, totalpages, NULL,
				 nodemask, "Out of memory");
```

如果觉得上面计算oom_score代码看着有点晕，简单来说就是

### oom_score计算方法

**oom_score = 内存消耗/总内存 *1000**

其中

1. 内存消耗包括了：常驻内存RSS + 进程页面 + 交换内存
2. 总内存就简单了：总的物理内存 +交换分区


#### Demo验证

通过下面的脚本可以打印所以oom_score不为0的程序

```bash
#!/bin/bash
# Displays running processes in descending order of OOM score
printf 'PID\tOOM Score\tOOM Adj\tCommand\n'
ps -e -o pid= -o comm= | while read -r pid comm; do [ -f /proc/$pid/oom_score ] && [ $(cat /proc/$pid/oom_score) != 0 ] && printf '%d\t%d\t\t%d\t%s\n' "$pid" "$(cat /proc/$pid/oom_score)" "$(cat /proc/$pid/oom_score_adj)" "$comm"; done  | sort -k 2nr
```

输出如下：

```bash
PID     OOM Score       OOM Adj Command
7859    26              0       java
```

可以看到pid为7859进程的oom_score 为26

```bash
# pidstat  -r -p 7859

05:50:32 PM   UID       PID  minflt/s  majflt/s     VSZ    RSS   %MEM  Command
05:50:32 PM     0      7859      0.15      0.00 10081456 363704   2.21  java
```

程序占用的RSS为：363704KB/1024 = 355.2M

通过下面脚本可以看出swap使用

```bash
$ for i in $(ls /proc | grep "^[0-9]" | awk '$0>100'); do awk '/Swap:/{a=a+$2}END{print '"$i"',a/1024"M"}' /proc/$i/smaps;done 2>/dev/null | sort -k2nr | grep  7859
$ 7859   292.898M
```

考虑到页表本身占用很少，在此忽略了，
```bash
# free -m

              total        used        free      shared  buff/cache   available

Mem:          16040        1878        2095         290       12066       13397
Swap:          8191         969        7222
```

整个机器的内存：16040 + 8191 = 24231 M。

综合上面的数据可以算出： oom_score = (293+355)/24231*1000 约等于26。



### 手动让进程不容易被回收

修改oom_score_adj，可以通过下面的方式

```bash
echo -200 > /proc/进程ID/oom_score_adj
```

### 模拟

在 linux 系统下，内存不足会触发 OOM killer 去杀进程

下面模拟一下，几秒之后显示被Killed了：

```bash
$ cat oom.c
#include <stdlib.h>
#include <stdio.h>

#define BYTES (8 * 1024 * 1024)

int main(void) 
{
    printf("hello OOM \n");
    while(1)
    {
        char *p = malloc(BYTES);
        if (p == NULL)
        {
            return -1;
        }
    }
    return 0;
}
$ gcc oom.c 
$ ./a.out 
hello OOM 
Killed
$ 
```

用 `dmesg` 命令可以看到相关 log：

```bash
a.out invoked oom-killer: gfp_mask=0x26084c0, order=0, oom_score_adj=0
Out of memory: Kill process 97843 (a.out) score 835 or sacrifice child
```

#### oom_score_adj

上面打印了`oom_score_adj=0`以及`score 835`，OOM killer 给进程打分，把 oom_score 最大的进程先杀死。

打分主要有两部分组成：

系统根据该进程的内存占用情况打分，进程的内存开销是变化的，所以该值也会动态变化。

用户可以设置的 oom_score_adj，范围是 -1000到 1000，定义在：https://elixir.bootlin.com/linux/v5.0/source/include/uapi/linux/oom.h#L9

```c
/*
 * /proc/<pid>/oom_score_adj set to OOM_SCORE_ADJ_MIN disables oom killing for
 * pid.
 */
#define OOM_SCORE_ADJ_MIN   (-1000)
#define OOM_SCORE_ADJ_MAX   1000
```

如果用户将该进程的 oom_score_adj 设定成 -1000，表示禁止OOM killer 杀死该进程（代码在 https://elixir.bootlin.com/linux/v5.0/source/mm/oom_kill.c#L222 ）。比如 sshd 等非常重要的服务可以配置为 -1000。

1. 如果设置为负数，表示分数会打一定的折扣。
2. 如果设置为正数，分数会增加，可以优先杀死该进程。
3. 如果设置为0 ，表示用户不调整分数，0 是默认值。

#### 测试设置 oom_score_adj 对 oom_score 的影响

```c
#include <stdlib.h>
#include <stdio.h>

#define BYTES (8 * 1024 * 1024)
#define N (10240)

int main(void) 
{
    printf("hello OOM \n");
    int i;
    for (i = 0; i < N; i++)
    {
        char *p = malloc(BYTES);
        if (p == NULL)
        {
            return -1;
        }
    }
    printf("while... \n");
    while(1);
    return 0;
}
```

下面是初始的分数：

```bash
$ cat /proc/$(pidof a.out)/oom_score_adj
0
$ cat /proc/$(pidof a.out)/oom_score
62
```

下面修改 oom_score_adj，oom_score 也随之发生了变化：

```bash
$ sudo sh -c "echo -50 > /proc/$(pidof a.out)/oom_score_adj"
$ cat /proc/$(pidof a.out)/oom_score_adj
-50
$ cat /proc/$(pidof a.out)/oom_score
12
$ sudo sh -c "echo -60 > /proc/$(pidof a.out)/oom_score_adj"
$ cat /proc/$(pidof a.out)/oom_score_adj
-60
$ cat /proc/$(pidof a.out)/oom_score
2
$ sudo sh -c "echo -500 > /proc/$(pidof a.out)/oom_score_adj"
$ cat /proc/$(pidof a.out)/oom_score_adj
-500
$ cat /proc/$(pidof a.out)/oom_score
0
```

#### 测试设置 oom_score_adj 设置为-1000 对系统的影响

如果把一个无限申请内存的进程设置为-1000，会发生什么呢：

```
$ sudo sh -c "echo -1000 > /proc/$(pidof a.out)/oom_score_adj"
```

```
$ dmesg | grep "Out of memory"
Out of memory: Kill process 1000 (mysqld) score 67 or sacrifice child
Out of memory: Kill process 891 (vmhgfs-fuse) score 1 or sacrifice child
Out of memory: Kill process 321 (systemd-journal) score 1 or sacrifice child
Out of memory: Kill process 1052 ((sd-pam)) score 1 or sacrifice child
Out of memory: Kill process 1072 (bash) score 0 or sacrifice child
```

因为 bash 挂了，所以 a.out 也挂了。



 如果 ./a.out & 在后台运行，就可以看到用更多进程的 score 是 0 仍然挂掉了，比如 sshd、dhclient、systemd-logind、systemd-timesyn、dbus-daemon 等，所以设置错误的 oom_score_adj 后果比较严重。





https://www.jianshu.com/p/bbaeff371019
https://blog.csdn.net/u010278923/article/details/105688107