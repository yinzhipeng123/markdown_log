# top命令



### 常用命令选项

```bash
$ top -d 1                          指定刷新屏幕时间间隔
$ top -d 1 -p 10126					查看指定进程的动态信息
$ top -d 1 -p 10126,1               查看多个指定进程的动态信息
$ top -d 1 -u apache				查看指定用户的进程
$ top -d 1 -b -n 2 > top.txt 	    将2次top信息写入到文件
$ top -o %MEM                       按照内存排序，从大到小
$ top -H                            显示线程
```

### 常见标题解释

```bash
$ top
top - 16:23:05 up 68 days, 23:07,  1 user,  load average: 0.00, 0.01, 0.05
Tasks: 116 total,   1 running, 115 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  8008632 total,  4764280 free,   428308 used,  2816044 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  7262552 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                        
 1188 root      20   0   50088   1116    780 S   1.0  0.0   1082:03 rshim                                          
 8916 root      20   0 1095744 158952  19256 S   0.7  2.0 819:23.35 YDService                                      
    1 root      20   0   43700   4044   2600 S   0.0  0.1   1:08.24 systemd                                        
    2 root      20   0       0      0      0 S   0.0  0.0   0:02.46 kthreadd                                       
    4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H                                   
    6 root      20   0       0      0      0 S   0.0  0.0   0:02.74 ksoftirqd/0                                    
    7 root      rt   0       0      0      0 S   0.0  0.0   0:00.37 migration/0                                    
    8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh                                         
    9 root      20   0       0      0      0 S   0.0  0.0   2:37.36 rcu_sched                                      
   10 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain                                  
   11 root      rt   0       0      0      0 S   0.0  0.0   0:13.19 watchdog/0                                     
   12 root      rt   0       0      0      0 S   0.0  0.0   0:11.66 watchdog/1                                     
   13 root      rt   0       0      0      0 S   0.0  0.0   0:00.37 migration/1                                    
   14 root      20   0       0      0      0 S   0.0  0.0   0:01.30 ksoftirqd/1                                    
   16 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H                                   
   17 root      rt   0       0      0      0 S   0.0  0.0   0:11.60 watchdog/2                                     
   18 root      rt   0       0      0      0 S   0.0  0.0   0:00.41 migration/2                                    
   19 root      20   0       0      0      0 S   0.0  0.0   0:00.54 ksoftirqd/2                                    
   21 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/2:0H                                   
   22 root      rt   0       0      0      0 S   0.0  0.0   0:11.20 watchdog/3                                     
   23 root      rt   0       0      0      0 S   0.0  0.0   0:00.36 migration/3                                    
   24 root      20   0       0      0      0 S   0.0  0.0   0:00.53 ksoftirqd/3                                    
   26 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/3:0H                                   
   28 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kdevtmpfs                                      
   29 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 netns                                          
   30 root      20   0       0      0      0 S   0.0  0.0   0:01.39 khungtaskd  
```

1. PID： 	进程ID
2. USER: 	运行进程的用户
3. PR：任务的计划优先级
4. NI：nice值
5. VIRT: 进程虚拟内存大小
6. RES: 进程常驻内存大小，不包括Swap
7. SHR: 共享内存大小
8. %MEM: 进程占用物理内存占系统总内存的百分比
9. TIME+：CPU时间，显示高精度
10. COMMAND：进程名字
11. S：进程状态。下面进程状态其中之一

- D = 不可中断状态
- R = 运行或者可运行状态
- S = 可中断状态睡眠
- T = 暂停或者
- t = 跟踪状态
- Z = 僵尸进程

### 交互命令

```bash
$ top  命令输入后 按f，可配置显示的列
* PID     = Process Id             DATA    = Data+Stack (KiB)    
* USER    = Effective User Name    nMaj    = Major Page Faults   
* PR      = Priority               nMin    = Minor Page Faults   
* NI      = Nice Value             nDRT    = Dirty Pages Count   
* VIRT    = Virtual Image (KiB)    WCHAN   = Sleeping in Function
* RES     = Resident Size (KiB)    Flags   = Task Flags <sched.h>
* SHR     = Shared Memory (KiB)    CGROUPS = Control Groups      
* S       = Process Status         SUPGIDS = Supp Groups IDs     
* %CPU    = CPU Usage              SUPGRPS = Supp Groups Names   
* %MEM    = Memory Usage (RES)     TGID    = Thread Group Id     
* TIME+   = CPU Time, hundredths   ENVIRON = Environment vars    
* COMMAND = Command Name/Line      vMj     = Major Faults delta  
  PPID    = Parent Process pid     vMn     = Minor Faults delta  
  UID     = Effective User Id      USED    = Res+Swap Size (KiB) 
  RUID    = Real User Id           nsIPC   = IPC namespace Inode 
  RUSER   = Real User Name         nsMNT   = MNT namespace Inode 
  SUID    = Saved User Id          nsNET   = NET namespace Inode 
  SUSER   = Saved User Name        nsPID   = PID namespace Inode 
  GID     = Group Id               nsUSER  = USER namespace Inode
  GROUP   = Group Name             nsUTS   = UTS namespace Inode 
  PGRP    = Process Group Id    
  TTY     = Controlling Tty     
  TPGID   = Tty Process Grp Id  
  SID     = Session Id          
  nTH     = Number of Threads   
  P       = Last Used Cpu (SMP) 
  TIME    = CPU Time            
  SWAP    = Swapped Size (KiB)  
  CODE    = Code Size (KiB)  
  
M	按内存的使用排序
P	按CPU使用排序
N	以PID的大小排序
R	对排序进行反转
f	自定义显示字段
1	显示所有CPU的负载
W   对更改进行保存
z   更改主题颜色
Z   对主题颜色进行配置,进入配置界面后，0-7选择颜色，a,w选择显示内容，回车保存
q   返回
e   切换单位
E   切换单位
H   切换线程显示模式
h   查看交互命令帮助
```



[top（1） - Linux 手册页 (man7.org)](https://man7.org/linux/man-pages/man1/top.1.html)