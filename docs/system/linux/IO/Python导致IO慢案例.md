

有个机器对web响应慢，系统执行命令也半天出结果，所以排查下

```bash
$ top 
top - 14:27:02 up 10:30,  1 user,  load average: 1.82, 1.26, 0.76 
Tasks: 129 total,   1 running,  74 sleeping,   0 stopped,   0 zombie 
%Cpu0  :  3.5 us,  2.1 sy,  0.0 ni,  0.0 id, 94.4 wa,  0.0 hi,  0.0 si,  0.0 st 
%Cpu1  :  2.4 us,  0.7 sy,  0.0 ni, 70.4 id, 26.5 wa,  0.0 hi,  0.0 si,  0.0 st 
KiB Mem :  8169300 total,  3323248 free,   436748 used,  4409304 buff/cache 
KiB Swap:        0 total,        0 free,        0 used.  7412556 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND 
12280 root      20   0  103304  28824   7276 S  14.0  0.4   0:08.77 python 
   16 root      20   0       0      0      0 S   0.3  0.0   0:09.22 ksoftirqd/1 
1549 root      20   0  236712  24480   9864 S   0.3  0.3   3:31.38 python3 
```

观察 top 的输出可以发现，两个 CPU 的 iowait 都非常高。特别是 CPU0， iowait 已经高达 94 %，而剩余内存还有 3GB，看起来也是充足的。

再往下看，进程部分有一个 python 进程的 CPU 使用率稍微有点高，达到了 14%。虽然 14% 并不能成为性能瓶颈，不过有点嫌疑——可能跟 iowait 的升高有关。

```bash

$ ps aux | grep app.py 
root     12222  0.4  0.2  96064 23452 pts/0    Ss+  14:37   0:00 python /app.py 
root     12280 13.9  0.3 102424 27904 pts/0    Sl+  14:37   0:09 /usr/local/bin/python /app.py 
```



从 ps 的输出，你可以看到，这个 CPU 使用率较高的进程，。不过先别着急分析 CPU 问题，毕竟 iowait 已经高达 94%， I/O 问题才是我们首要解决的。

接下来，我们在终端一中，运行下面的 iostat 命令，其中:

- -d 选项是指显示出 I/O 的性能指标；
- -x 选项是指显示出扩展统计信息（即显示所有 I/O 指标）。

```bash
$ iostat -d -x 1
Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util 
loop0            0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00 
sda              0.00   71.00      0.00  32912.00     0.00     0.00   0.00   0.00    0.00 18118.31 241.89     0.00   463.55  13.86  98.40 
```



具体观察 iostat 的输出。你可以发现，磁盘 sda 的 I/O 使用率已经达到 98% ，接近饱和了。而且，写请求的响应时间高达 18 秒，每秒的写数据为 32 MB，显然写磁盘碰到了瓶颈。

在终端一中，运行下面的 pidstat 命令，观察进程的 I/O 情况：

```bash

$ pidstat -d 1 
14:39:14      UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command 
14:39:15        0     12280      0.00 335716.00      0.00       0  python 
```

从 pidstat 的输出，我们再次看到了 PID 号为 12280 的结果。这说明，正是案例应用引发 I/O 的性能瓶颈。

到底是不是这样呢？我们不妨来试试。还是在终端一中，执行下面的 strace 命令：

```bash

$ strace -p 12280 
strace: Process 12280 attached 
select(0, NULL, NULL, NULL, {tv_sec=0, tv_usec=567708}) = 0 (Timeout) 
stat("/usr/local/lib/python3.7/importlib/_bootstrap.py", {st_mode=S_IFREG|0644, st_size=39278, ...}) = 0 
stat("/usr/local/lib/python3.7/importlib/_bootstrap.py", {st_mode=S_IFREG|0644, st_size=39278, ...}) = 0 
```

从 strace 中，你可以看到大量的 stat 系统调用，并且大都为 python 的文件，但是，请注意，这里并没有任何 write 系统调用。

由于 strace 的输出比较多，我们可以用 grep ，来过滤一下 write，比如：

```bash

$ strace -p 12280 2>&1 | grep write 
```

遗憾的是，这里仍然没有任何输出。

介绍一个新工具， filetop。它是 bcc 软件包的一部分，基于 Linux 内核的 eBPF（extended Berkeley Packet Filters）机制，主要跟踪内核中文件的读写情况，并输出线程 ID（TID）、读写大小、读写类型以及文件名称。

安装后，bcc 提供的所有工具，就全部安装到了 /usr/share/bcc/tools 这个目录中。接下来我们就用这个工具，观察一下文件的读写情况。

```bash

# 切换到工具目录 
$ cd /usr/share/bcc/tools 

# -C 选项表示输出新内容时不清空屏幕 
$ ./filetop -C 

TID    COMM             READS  WRITES R_Kb    W_Kb    T FILE 
514    python           0      1      0       2832    R 669.txt 
514    python           0      1      0       2490    R 667.txt 
514    python           0      1      0       2685    R 671.txt 
514    python           0      1      0       2392    R 670.txt 
514    python           0      1      0       2050    R 672.txt 

...

TID    COMM             READS  WRITES R_Kb    W_Kb    T FILE 
514    python           2      0      5957    0       R 651.txt 
514    python           2      0      5371    0       R 112.txt 
514    python           2      0      4785    0       R 861.txt 
514    python           2      0      4736    0       R 213.txt 
514    python           2      0      4443    0       R 45.txt 

```

你会看到，filetop 输出了 8 列内容，分别是线程 ID、线程命令行、读写次数、读写的大小（单位 KB）、文件类型以及读写的文件名称。

这些内容里，会看到很多动态链接库，不过这不是我们的重点，暂且忽略即可。我们的重点，是一个 python 应用，所以要特别关注 python 相关的内容。多观察一会儿，你就会发现，每隔一段时间，线程号为 514 的 python 应用就会先写入大量的 txt 文件，再大量地读。

线程号为 514 的线程，属于哪个进程呢？我们可以用 ps 命令查看。先在终端一中，按下 Ctrl+C ，停止 filetop ；然后，运行下面的 ps 命令。这个输出的第二列内容，就是我们想知道的进程号：

```bash

$ ps -efT | grep 514
root     12280  514 14626 33 14:47 pts/0    00:00:05 /usr/local/bin/python /app.py 
```

我们看到，这个线程正是 12280 的线程。终于可以先松一口气，不过还没完，filetop 只给出了文件名称，却没有文件路径，还得继续找啊。我再介绍一个好用的工具，opensnoop 。它同属于 bcc 软件包，可以动态跟踪内核中的 open 系统调用。这样，我们就可以找出这些 txt 文件的路径。接下来，在终端一中，运行下面的 opensnoop 命令

```bash

$ opensnoop 
12280  python              6   0 /tmp/9046db9e-fe25-11e8-b13f-0242ac110002/650.txt 
12280  python              6   0 /tmp/9046db9e-fe25-11e8-b13f-0242ac110002/651.txt 
12280  python              6   0 /tmp/9046db9e-fe25-11e8-b13f-0242ac110002/652.txt 
```

这次，通过 opensnoop 的输出，你可以看到，这些 txt 路径位于 /tmp 目录下。你还能看到，它打开的文件数量，按照数字编号，从 0.txt 依次增大到 999.txt，这可远多于前面用 filetop 看到的数量。

综合 filetop 和 opensnoop ，我们就可以进一步分析了。我们可以大胆猜测，案例应用在写入 1000 个 txt 文件后，又把这些内容读到内存中进行处理。我们来检查一下，这个目录中是不是真的有 1000 个文件：

```bash

$ ls /tmp/9046db9e-fe25-11e8-b13f-0242ac110002 | wc -l 
ls: cannot access '/tmp/9046db9e-fe25-11e8-b13f-0242ac110002': No such file or directory 
0 
```



操作后却发现，目录居然不存在了。怎么回事呢？我们回到 opensnoop 再观察一会儿：

```bash

$ opensnoop 
12280  python              6   0 /tmp/defee970-fe25-11e8-b13f-0242ac110002/261.txt 
12280  python              6   0 /tmp/defee970-fe25-11e8-b13f-0242ac110002/840.txt 
12280  python              6   0 /tmp/defee970-fe25-11e8-b13f-0242ac110002/136.txt 
```

原来，这时的路径已经变成了另一个目录。这说明，这些目录都是应用程序动态生成的，用完就删了。结合前面的所有分析，我们基本可以判断，案例应用会动态生成一批文件，用来临时存储数据，用完就会删除它们。但不幸的是，正是这些文件读写，引发了 I/O 的性能瓶颈，导致整个处理过程非常慢。