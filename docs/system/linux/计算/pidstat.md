# pidstat

语法

```bash
pidstat [ options ] [ <interval> [ <count> ] ]
```

功能

```bash
报告 Linux 任务的统计信息。pidstat命令用于监控单个任务，目前由 Linux 内核管理。
```

选项

- -C comm

  仅显示其命令名包含字符串comm的任务。此字符串可以是正则表达式

- -d 报告I/O统计信息

UID  被监视任务的真实用户标识号

USER  拥有被监视任务的真实用户的名称

PID  正在监视的任务的标识号

kB_rd/s  任务每秒从磁盘读取的kB数

kB_wr/s  任务每秒应该写入或已写入磁盘的kB数

kB_ccwr/s   已取消任务写入磁盘的kB数。当任务截断一些脏页缓存时，可能会发生这种情况。

iodelay 正在监视的任务的块I/O延迟，以时钟周期度量。此度量包括等待同步块I/O完成和转换块I/O完成所花费的延迟。

Command 任务的名字

- --dec={ 0 | 1 | 2 }

  指定要使用的小数位数（0到2，默认值为2）。

- -e program args

  用给定的参数执行程序，并用pidstat监视它。当程序终止时，pidstat停止。

- -G process_name

  仅显示其命令名包含字符串process_name的进程。此字符串可以是正则表达式。如果选项-t与选项-G一起使用，则也会显示属于该进程的线程（即使其命令名不包含字符串process_name）。

- -H 显示时间戳

- -h  在一行上水平显示所有活动，报告末尾没有平均统计信息。这是为了更容易被其他程序解析。

- --human 自动单位转换

- -I 大写i 在SMP环境中，指示任务CPU使用率

- -l  小L显示进程命令名称及其所有参数。

- -p { pid[,...] | SELF | ALL }

  选择要报告统计信息的任务（流程）。pid是进程标识号。SELF关键字表示要为pidstat进程本身报告统计信息，而ALL关键字表示要报告系统管理的所有任务的统计信息。

- -R 

  报告实时优先级和计划策略信息。可能会显示以下值：

  UID  被监视任务的真实用户标识号

  USER 拥有被监视任务的真实用户的名称

  PID 正在监视的任务的标识号

  prio 被监控任务的实时优先级。

  policy 被监控任务的调度策略

  Command 任务的命令名称

- -r  

  报告页面错误和内存利用率，可能会显示以下值：

  UID  被监视任务的真实用户标识号

  USER 拥有被监视任务的真实用户的名称

  PID 正在监视的任务的标识号

  minflt/s 任务每秒发生的轻微错误总数，这些错误不需要从磁盘加载内存页。

  majflt/s 任务每秒发生的主要错误总数，这些错误需要从磁盘加载内存页。

  VSZ   虚拟大小：整个任务的虚拟内存使用量（KB）。

  RSS  常驻集大小：任务使用的非交换物理内存（以KB为单位）。

  %MEM  任务当前使用的可用物理内存的共享。

  Command 任务的命令名称

  报告任务及其所有子任务的全局统计信息时，可能会显示以下值：

  UID  被监视任务的真实用户标识号

  USER 拥有被监视任务的真实用户的名称

  PID 正在监视的任务的标识号

  minflt-nr 任务及其所有子任务在该时间间隔内收集的轻微错误的总数。

  majflt-nr  任务及其所有子任务在间隔期间收集的主要错误总数时间。

  Command 任务的命令名称

- -s 

  报告堆栈利用率。可能会显示以下值：

  UID  被监视任务的真实用户标识号

  USER 拥有被监视任务的真实用户的名称

  PID 正在监视的任务的标识号

  StkSize    以堆栈形式为任务保留但不一定使用的内存量（以KB为单位）。

  StkRef    任务引用的用作堆栈的内存量（以KB为单位）

  Command 任务的命令名称

- -T { TASK | CHILD | ALL }

  此选项指定**pidstat**命令必须监视的内容。**TASK**关键字表示要报告单个任务的统计信息

  （这是默认选项）而**CHILD**关键字表示要全局报告所选任务及其所有子任务的统计信息。

  ALL关键字表示要报告单个任务的统计信息，以及所选任务及其子任务的全局统计信息。

-  -t

  显示与所选任务关联的线程的统计信息。

  TGID	线程组长的标识号。                                                                                                                                                                        TID	被监视线程的标识号。                                                                                         

- -U	[ username ]  

  显示正在监视的任务的真实用户名，而不是UID。如果指定了用户名，则只显示属于指定用户的任务。

- -u 

  报告CPU利用率。

  报告单个任务的统计信息时，可能会显示以下值：

  UID  正在监视的任务的真实用户标识号。

  USER  拥有被监视任务的真实用户的名称。

  PID  正在监视的任务的标识号

  %usr

  %system

  %guest

  %CPU  任务使用的CPU时间的总百分比。

  CPU  任务附加到的处理器号。

  Command   命令

  报告任务及其所有子任务的全局统计信息时，可能会显示以下值：
  UID

  USER                                                                                                                                                             

  PID

  usr-ms   在用户级别（应用程序）执行时，任务及其所有子任务花费的毫秒总数                                                                                                                                                

  system-ms     在系统级（内核）执行时任务及其所有子任务花费的毫秒总数，并在间隔期间收集
  时间。                                                                                                                                      

  guest-ms      任务及其所有子级在虚拟机（运行虚拟处理器）中花费的总毫秒数。                                                                                                                                                  Command   命令

- -V 看版本信息

- -w 

  报告任务切换活动（仅限2.6.23内核和更高版本）。可能会显示以下值：

  UID

  USER

  cswch/s  每秒对任务进行的自愿上下文切换的总数。当任务由于需要资源不可用。

  nvcswch/s 每秒执行任务的非自愿上下文切换总数。当任务在其时间片的持续时间内执行，然后被迫放弃处理器时，会发生非自愿的上下文切换。

  Command  命令





