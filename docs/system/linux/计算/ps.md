

# ps命令

ps命令来自于英文词组”process status“的缩写，其功能是用于显示当前系统的进程状态。使用ps命令可以查看到进程的所有信息，例如进程的号码、发起者、系统资源使用占比（处理器与内存）、运行状态等等。帮助我们及时的发现哪些进程出现”僵死“或”不可中断“等异常情况。

**语法格式：**ps [参数]

### **常用参数：**﻿

ps接受以下几种选项：

1. UNIX 选项，可以分组，并且前面必须有一个破折号。
2. BSD 选项，可以分组，不能与破折号一起使用。
3. GNU长选项，前面有两个破折号。

不同类型的选项可以自由混合，但也会出现冲突。有一些同义选项。详见https://man7.org/linux/man-pages/man1/ps.1.html

| -a                                      | 显示所有终端机下执行的程序，除了阶段作业领导者之外           |
| --------------------------------------- | ------------------------------------------------------------ |
| a                                       | 显示现行终端机下的所有程序，包括其他用户的程序               |
| -A                                      | 显示所有程序                                                 |
| -c                                      | 显示CLS和PRI栏位                                             |
| c                                       | 列出程序时，显示每个程序真正的指令名称，而不包含路径，选项或常驻服务的标示 |
| -C <指令名称>                           | 指定执行指令的名称，并列出该指令的程序的状况                 |
| -d                                      | 显示所有程序，但不包括阶段作业领导者的程序                   |
| -e                                      | 此选项的效果和指定”A”选项相同                                |
| e                                       | 列出程序时，显示每个程序所使用的环境变量                     |
| -f                                      | 完整格式列表。与-L一起使用时，将添加NLWP（线程数）和LWP（线程ID）列 |
| f                                       | 用ASCII字符显示树状结构，表达程序间的相互关系                |
| -F                                      | 额外完整格式                                                 |
| -g <群组名称>                           | 此选项的效果和指定”-G”选项相同，当亦能使用阶段作业领导者的名称来指定 |
| g                                       | 显示现行终端机下的所有程序，包括群组领导者的程序             |
| -G <群组识别码>                         | 列出属于该群组的程序的状况，也可使用群组名称来指定           |
| h                                       | 不显示标题列                                                 |
| -H                                      | 显示树状结构，表示程序间的相互关系                           |
| -j或j                                   | 采用工作控制的格式显示程序状况                               |
| -l或l 小写L  因为ps没有-i或者-大写i选项 | 采用详细的格式来显示程序状况                                 |
| -L                                      | 显示线程                                                     |
| L                                       | 列出栏位的相关信息                                           |
| -m或m                                   | 显示所有的执行绪                                             |
| n                                       | 以数字来表示USER和WCHAN栏位                                  |
| -N                                      | 显示所有的程序，除了执行ps指令终端机下的程序之外             |
| -p <程序识别码>                         | 指定程序识别码，并列出该程序的状况                           |
| p <程序识别码>                          | 此选项的效果和指定”-p”选项相同，只在列表格式方面稍有差异     |
| r                                       | 只列出现行终端机正在执行中的程序                             |
| -s <阶段作业>                           | 指定阶段作业的程序识别码，并列出隶属该阶段作业的程序的状况   |
| s                                       | 采用程序信号的格式显示程序状况                               |
| S                                       | 列出程序时，包括已中断的子程序资料                           |
| o                                       | 指定用户定义的格式。与-o和--format相同。                     |
| -t <终端机编号>                         | 指定终端机编号，并列出属于该终端机的程序的状况               |
| t <终端机编号>                          | 此选项的效果和指定”-t”选项相同，只在列表格式方面稍有差异     |
| -T                                      | 显示现行终端机下的所有程序                                   |
| -u <用户识别码>                         | 此选项的效果和指定”-U”选项相同                               |
| u                                       | 以用户为主的格式来显示程序状况                               |
| -U <用户识别码>                         | 列出属于该用户的程序的状况，也可使用用户名称来指定           |
| U <用户名称>                            | 列出属于该用户的程序的状况                                   |
| v                                       | 采用虚拟内存的格式显示程序状况                               |
| -V或V                                   | 显示版本信息                                                 |
| -w或w                                   | 采用宽阔的格式来显示程序状况                                 |
| x                                       | 显示所有程序，不以终端机来区分                               |
| X                                       | 采用旧式的Linux i386登陆格式显示程序状况                     |
| -y                                      | 配合选项”-l”使用时，不显示F(flag)栏位，并以RSS栏位取代ADDR栏位 |
| -- <程序识别码>                         | 此选项的效果和指定”p”选项相同                                |
| --cols <每列字符数>                     | 设置每列的最大字符数                                         |
| --columns <每列字符数>                  | 此选项的效果和指定”--cols”选项相同                           |
| --cumulative                            | 此选项的效果和指定”S”选项相同                                |
| --deselect                              | 此选项的效果和指定”-N”选项相同                               |
| --forest                                | 此选项的效果和指定”f”选项相同                                |
| --headers                               | 重复显示标题列                                               |
| --help                                  | 在线帮助                                                     |
| --info                                  | 显示排错信息                                                 |
| --lines <显示列数>                      | 设置显示画面的列数                                           |
| --no-headers                            | 此选项的效果和指定”h”选项相同，只在列表格式方面稍有差异      |
| --group <群组名称>                      | 此选项的效果和指定”-G”选项相同                               |
| --Group <群组识别码>                    | 此选项的效果和指定”-G”选项相同                               |
| --pid <程序识别码>                      | 此选项的效果和指定”-p”选项相同                               |
| --rows <显示列数>                       | 此选项的效果和指定”--lines”选项相同                          |
| --sid <阶段作业>                        | 此选项的效果和指定”-s”选项相同                               |
| -tty <终端机编号>                       | 此选项的效果和指定”-t”选项相同                               |
| --user <用户名称>                       | 此选项的效果和指定”-U”选项相同                               |
| --User <用户识别码>                     | 此选项的效果和指定”-U”选项相同                               |
| --version                               | 此选项的效果和指定”-V”选项相同                               |
| --widty <每列字符数>                    | 此选项的效果和指定”-cols”选项相同                            |

#### 只打印R和D状态的线程

```bash
$ ps -e -L h o state,pid,ppid,ucmd:30,cmd:100,wchan:30  |awk  '{if($1=="R"||$1=="D"){print $0}}'
```

#### 只打印R和D状态的线程并按照线程数量排序

```bash
$ ps -e -L h o state,pid,ppid,ucmd:30,cmd:100,wchan:30  |awk  '{if($1=="R"||$1=="D"){print $0}}' | sort | uniq -c
```

#### 打印所有线程

```bash
$ ps -ALFlf  #这里是小写L,ps没有-i或者-大写i选项
```

打印线程占用CPU排序

```bash
$ ps -Leo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:30,comm | grep -v COMMAND | sort -k8nr
```

#### ps aux的解释

- ps a      显示现行终端机下的所有程序，包括其他用户的程序。
- ps u 　 以用户为主的格式来显示程序状况。
- ps x 　 显示所有程序，不以终端机来区分。

```bash
[root@tianyun ~]# ps aux |less
USER       PID %CPU %MEM    VSZ   RSS TTY     STAT START   TIME COMMAND
root         1     0.0     0.0          2164   648 ?          Ss   08:47     0:00 init [5]  
```

？表示不是终端启动的而是内核启动的进程

1. USER: 	运行进程的用户
2. PID： 	进程ID
3. %CPU:  CPU占用率       //1分钟占用率
4. %MEM: 内存占用率
5. VSZ：	占用虚拟内存
6. RSS:  	占用实际内存 驻留内存
7. TTY： 	进程运行的终端
8. STAT：	进程状态	 man ps (/STATE)
9. START:	进程的启动时间
10. TIME：	进程占用CPU的总时间
11. COMMAND： 进程文件，进程名



##### stat的各种状态含义	

- R 	是 Running 或 Runnable 的缩写，表示进程在 CPU 的就绪队列中，正在运行或者正在等待运行。
- S 	是 Interruptible Sleep 的缩写，也就是可中断状态睡眠，表示进程因为等待某个事件而被系统挂起。当进程等待的事件发生时，它会被唤醒并进入 R 状态。
- D	 是 Disk Sleep 的缩写，也就是不可中断状态睡眠（Uninterruptible Sleep），一般表示进程正在跟硬件交互，并且交互过程不允许被其他进程或中断打断。
- T 	表示进程处于暂停或者跟踪状态。向一个进程发送 SIGSTOP 信号，它就会因响应这个信号变成暂停状态（Stopped）；再向它发送 SIGCONT 信号，进程又会恢复运行（如果进程是终端里直接启动的，则需要你用 fg 命令，恢复到前台运行）。
- Z 	是 Zombie 的缩写，如果你玩过“植物大战僵尸”这款游戏，应该知道它的意思。它表示僵尸进程，也就是进程实际上已经结束了，但是父进程还没有回收它的资源（比如进程的描述符、PID 等）。       //不能有太多，有太多就不正常的
- I      是 Idle 的缩写，也就是空闲状态，用在不可中断睡眠的内核线程上。前面说了，硬件交互导致的不可中断进程用 D 表示，但对某些内核线程来说，它们有可能实际上并没有任何负载，用 Idle 正是为了区分这种情况。要注意，D 状态的进程会导致平均负载升高， I 状态的进程却不会。
- X    死掉的进程
- Ss      s进程的领导者，父进程
- S<     <优先级较高的进程
- SN    N优先级较低的进程
- R+    +表示是前台的进程组
- Sl	  以线程的方式运行      

##### 排序

自定义格式排序

```bash
$ ps -eo pid,user,args --sort user
```

按照标题进行排序（已失效，原因参见下面的man手册中文翻译）

```bash
$ ps aux --sort %cpu             //从低往高排序  
$ ps aux --sort -%cpu            //从高往低排序
$ ps aux --sort rss 
$ ps aux --sort -rss 
$ ps aux --sort %mem
$ ps aux --sort -%mem
```

手动排序

```bash
使用内存前10
$ ps aux | sort -k4nr | head -n 10 
使用CPU前10
$ ps aux | sort -k3nr | head -n 10
```

!!! note

    比如说sort -k 1 -k 2 test.txt，那么就会根据test.txt文件中的第一列和第二列进行排序。
    -n：依照数值的大小排序；
    -r：以相反的顺序来排序



```
PS(1)                                              用户命令                                             PS(1)

名称
       ps - 报告当前进程的快照。

概要
       ps [选项]

描述
       ps 显示选定的活动进程的信息。如果您希望对选定的信息进行重复更新，请使用 top。

       该版本的 ps 接受几种类型的选项：

       1   UNIX 选项，可以组合使用，并且必须以破折号为前缀。
       2   BSD 选项，可以组合使用，不应使用破折号。
       3   GNU 长选项，以两个破折号为前缀。

       可以自由混合使用不同类型的选项，但可能会出现冲突。由于此 ps 兼容多个标准和 ps 实现，
       因此存在一些功能上相同的同义选项。

       请注意，ps -aux 与 ps aux 是不同的。POSIX 和 UNIX 标准要求 ps -aux 打印出所有由名为 x 
       的用户拥有的进程，以及所有由 -a 选项选择的进程。如果用户 x 不存在，则此 ps 可能会将
       命令解释为 ps aux，并打印警告。此行为旨在帮助过渡旧脚本和习惯。它是脆弱的，可能会
       更改，因此不应依赖此行为。

       默认情况下，ps 选择所有与当前用户拥有相同有效用户 ID (euid=EUID) 并与调用者关联的
       终端相关联的进程。它显示进程 ID (pid=PID)，与进程关联的终端 (tname=TTY)，以
       [DD-]hh:mm:ss 格式累计的 CPU 时间 (time=TIME) 和可执行文件名 (ucmd=CMD)。输出默认
       情况下未排序。

       使用 BSD 风格的选项将添加进程状态 (stat=STAT) 到默认显示，并显示命令参数 (args=COMMAND)
       而不是可执行文件名。您可以通过 PS_FORMAT 环境变量覆盖此设置。使用 BSD 风格的选项还将
       更改进程选择，以包括由您拥有的其他终端 (TTYs) 上的进程；或者，可以将其描述为将选择
       设置为所有进程的集合，过滤掉由其他用户拥有的进程或不在终端上的进程。这些效果在下文
       描述选项时不被视为“相同”，因此 -M 将被视为与 Z 等效。

       除下文所述外，进程选择选项是累加的。默认选择被丢弃，然后将选定的进程添加到要显示的
       进程集中。因此，如果一个进程符合任何给定的选择标准，它将被显示。

示例
       使用标准语法查看系统上的每个进程：
          ps -e
          ps -ef
          ps -eF
          ps -ely

       使用 BSD 语法查看系统上的每个进程：
          ps ax
          ps axu

       打印进程树：
          ps -ejH
          ps axjf

       获取线程信息：
          ps -eLf
          ps axms

       获取安全信息：
          ps -eo euser,ruser,suser,fuser,f,comm,label
          ps axZ
          ps -eM

       以用户格式查看以 root (真实和有效 ID) 运行的每个进程：
          ps -U root -u root u

       查看具有用户定义格式的每个进程：
          ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
          ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
          ps -Ao pid,tt,user,fname,tmout,f,wchan

       仅打印 syslogd 的进程 ID：
          ps -C syslogd -o pid=

       仅打印 PID 42 的名称：
          ps -q 42 -o comm=
简单的进程选择
       a      解除 BSD 风格的“仅你自己”限制，该限制在使用某些 BSD 风格（不带“-”）选项或
              ps 个性设置为 BSD 风格时施加于所有进程集。当以这种方式选择进程时，该进程集将
              被添加到通过其他方式选择的进程集中。另一种描述是，此选项使 ps 列出所有具有
              终端 (tty) 的进程，或与 x 选项一起使用时列出所有进程。

       -A     选择所有进程。与 -e 相同。

       -a     选择所有进程，但会排除会话领导者（参见 getsid(2)）和未与终端关联的进程。

       -d     选择所有进程，但排除会话领导者。

       --deselect
              选择所有不符合指定条件的进程（否定选择）。与 -N 相同。

       -e     选择所有进程。与 -A 相同。

       g      真正所有进程，甚至包括会话领导者。此标志已过时，可能在将来的版本中弃用。
              通常由 a 标志隐含，仅在 sunos4 个性操作时有用。

       -N     选择所有不符合指定条件的进程（否定选择）。与 --deselect 相同。

       T      选择与此终端关联的所有进程。与不带任何参数的 t 选项相同。

       r      将选择限制为仅运行的进程。

       x      解除 BSD 风格的“必须有 tty”限制，该限制在使用某些 BSD 风格（不带“-”）选项
              或 ps 个性设置为 BSD 风格时施加于所有进程集。当以这种方式选择进程时，该
              进程集将被添加到通过其他方式选择的进程集中。另一种描述是，此选项使 ps 列出
              所有您拥有的进程（与 ps 相同的 EUID），或与 a 选项一起使用时列出所有进程。

按列表选择进程
       这些选项接受以空格分隔或逗号分隔的列表形式的单个参数。可以多次使用。例如：
       ps -p "1 2" -p 3,4

       -123   与 --pid 123 相同。

       123    与 --pid 123 相同。

       -C cmdlist
              按命令名称选择。这选择可执行名称在 cmdlist 中给出的进程。注意：命令名称与
              命令行不同。以前版本的 procps 和内核将此命令名称截断为 15 个字符。此限制在
              两者中都不再存在。如果您依赖于匹配仅 15 个字符，您可能不再匹配。

       -G grplist
              按实际组 ID (RGID) 或名称选择。这选择实际组名称或 ID 在 grplist 列表中的
              进程。实际组 ID 标识创建进程的用户的组，请参见 getgid(2)。

       -g grplist
              按会话或有效组名选择。许多标准指定按会话选择，但按有效组选择是其他几个操作
              系统使用的逻辑行为。当列表完全是数字时（因为会话是），此 ps 将按会话选择。
              组 ID 号仅在同时指定一些组名时有效。参见 -s 和 --group 选项。

       --Group grplist
              按实际组 ID (RGID) 或名称选择。与 -G 相同。

       --group grplist
              按有效组 ID (EGID) 或名称选择。这选择有效组名称或 ID 在 grplist 中的进程。
              有效组 ID 描述进程使用的文件访问权限的组（参见 getegid(2)）。-g 选项通常是
              --group 的替代品。

       p pidlist
              按进程 ID 选择。与 -p 和 --pid 相同。

       -p pidlist
              按 PID 选择。这选择进程 ID 号出现在 pidlist 中的进程。与 p 和 --pid 相同。

       --pid pidlist
              按进程 ID 选择。与 -p 和 p 相同。

       --ppid pidlist
              按父进程 ID 选择。这选择父进程 ID 在 pidlist 中的进程。也就是说，它选择
              这些 pidlist 中列出的进程的子进程。

       q pidlist
              按进程 ID 选择（快速模式）。与 -q 和 --quick-pid 相同。

       -q pidlist
              按 PID 选择（快速模式）。这选择进程 ID 号出现在 pidlist 中的进程。在此选项
              下，ps 仅读取 pidlist 中列出的 pid 所需的信息，并且不应用其他过滤规则。
              pid 的顺序是未排序的，并保持不变。在此模式下不允许其他选择选项、排序和森林
              类型列表。与 q 和 --quick-pid 相同。

       --quick-pid pidlist
              按进程 ID 选择（快速模式）。与 -q 和 q 相同。

       -s sesslist
              按会话 ID 选择。这选择会话 ID 指定在 sesslist 中的进程。

       --sid sesslist
              按会话 ID 选择。与 -s 相同。

       t ttylist
              按 tty 选择。几乎与 -t 和 --tty 相同，但也可以与空 ttylist 一起使用以指示
              与 ps 关联的终端。使用 T 选项比使用带空 ttylist 的 t 更干净。

       -t ttylist
              按 tty 选择。这选择与 ttylist 中给定的终端关联的进程。终端（tty，或用于文本
              输出的屏幕）可以以几种形式指定：/dev/ttyS1，ttyS1，S1。可以使用普通的“-”来选择
              未附加到任何终端的进程。

       --tty ttylist
              按终端选择。与 -t 和 t 相同。

       U userlist
              按有效用户 ID (EUID) 或名称选择。这选择有效用户名或 ID 在 userlist 中的进程。
              有效用户 ID 描述进程使用的文件访问权限的用户（参见 geteuid(2)）。与 -u 和
              --user 相同。

       -U userlist
              按实际用户 ID (RUID) 或名称选择。这选择实际用户名或 ID 在 userlist 列表中
              的进程。实际用户 ID 标识创建进程的用户，请参见 getuid(2)。

       -u userlist
              按有效用户 ID (EUID) 或名称选择。这选择有效用户名或 ID 在 userlist 中的进程。
              有效用户 ID 描述进程使用的文件访问权限的用户（参见 geteuid(2)）。与 U 和
              --user 相同。

       --User userlist
              按实际用户 ID (RUID) 或名称选择。与 -U 相同。

       --user userlist
              按有效用户 ID (EUID) 或名称选择。与 -u 和 U 相同。
输出格式控制
       这些选项用于选择 ps 显示的信息。输出可能因个性而异。

       -c     对 -l 选项显示不同的调度器信息。

       --context
              显示安全上下文格式（针对 SELinux）。

       -f     完整格式列表。此选项可以与许多其他 UNIX 风格选项结合使用，以添加额外的列。
              它还会打印命令参数。与 -L 结合使用时，将添加 NLWP（线程数）和 LWP（线程 ID）
              列。参见 c 选项、格式关键字 args 和格式关键字 comm。

       -F     额外完整格式。参见 -f 选项，-F 隐含该选项。

       --format format
              用户定义的格式。与 -o 和 o 相同。

       j      BSD 作业控制格式。

       -j     作业格式。

       l      显示 BSD 长格式。

       -l     长格式。-y 选项通常与此选项一起使用很有用。

       -M     添加一列安全数据。与 Z 相同（针对 SELinux）。

       O format
              预加载的 o（重载）。BSD O 选项可以像 -O（带有一些预定义字段的用户定义输出格式）
              一样运行，也可以用于指定排序顺序。使用启发式方法确定此选项的行为。为了确保
              获得所需的行为（排序或格式），请以其他方式指定选项（例如，使用 -O 或 --sort）。
              当用作格式选项时，它与 -O 相同，带有 BSD 个性。

       -O format
              类似于 -o，但预加载了一些默认列。与 -o pid,format,state,tname,time,command
              或 -o pid,format,tname,time,cmd 相同，参见下文 -o。

       o format
              指定用户定义的格式。与 -o 和 --format 相同。

       -o format
              用户定义的格式。格式是以空格分隔或逗号分隔的列表形式的单个参数，提供一种
              指定单独输出列的方法。标准格式说明符部分中描述了已识别的关键字。可以根据
              需要重命名标题（ps -o pid,ruser=RealUser -o comm=Command）。如果所有列标题都
              是空的（ps -o pid= -o comm=），则不会输出标题行。列宽会根据需要增加，以适应
              宽标题；这可用于加宽诸如 WCHAN（ps -o pid,wchan=WIDE-WCHAN-COLUMN -o comm）
              之类的列。还提供了显式宽度控制（ps opid,wchan:42,cmd）。ps -o pid=X,comm=Y 的
              行为因个性而异；输出可能是一个名为“X,comm=Y”的列，或两个名为“X”和“Y”的列。
              当有疑问时，请使用多个 -o 选项。使用 PS_FORMAT 环境变量指定所需的默认值；
              DefSysV 和 DefBSD 是宏，可用于选择默认的 UNIX 或 BSD 列。

       s      显示信号格式。

       u      显示面向用户的格式。

       v      显示虚拟内存格式。

       X      寄存器格式。

       -y     不显示标志；用 rss 替代 addr。此选项只能与 -l 一起使用。

       Z      添加一列安全数据。与 -M 相同（针对 SELinux）。

输出修饰符
       c      显示真实的命令名称。此名称取自可执行文件的名称，而不是 argv 值。因此，不会
              显示命令参数及其任何修改。此选项实际上将 args 格式关键字转换为 comm 格式关键字；
              它与 -f 格式选项以及通常显示命令参数的各种 BSD 风格格式选项一起使用非常有用。
              参见 -f 选项、格式关键字 args 和格式关键字 comm。

       --cols n
              设置屏幕宽度。

       --columns n
              设置屏幕宽度。

       --cumulative
              包含一些已死亡的子进程数据（作为父进程的总和）。

       e      显示命令后的环境。

       f      ASCII 艺术进程层次结构（森林）。

       --forest
              ASCII 艺术进程树。

       h      无标题。（或者，在 BSD 个性中，每屏幕一个标题）。h 选项存在问题。标准 BSD ps 
              使用此选项在每页输出上打印标题，但旧的 Linux ps 使用此选项完全禁用标题。此版本
              的 ps 遵循 Linux 用法，除非选择了 BSD 个性，否则不会打印标题，在这种情况下，它会
              在每页输出上打印标题。无论当前个性如何，您都可以使用长选项 --headers 和 
              --no-headers 分别启用每页打印标题或完全禁用标题。

       -H     显示进程层次结构（森林）。

       --headers
              重复标题行，每页一行。

       k spec 指定排序顺序。排序语法为[+|-]key[,[+|-]key[,...]]。从标准格式说明符部分中选择
              多字母键。由于默认方向是递增的数字或字母顺序，因此“+”是可选的。与 --sort 相同。

                      示例：
                      ps jaxkuid,-ppid,+pid
                      ps axk comm o comm,args
                      ps kstart_time -ef

       --lines n
              设置屏幕高度。

       n      WCHAN 和 USER（包括所有类型的 UID 和 GID）使用数字输出。

       --no-headers
              完全不打印标题行。--no-heading 是此选项的别名。

       O order
              排序顺序（重载）。BSD O 选项可以像 -O（带有一些预定义字段的用户定义输出格式）
              一样运行，也可以用于指定排序顺序。使用启发式方法确定此选项的行为。为了确保获得
              所需的行为（排序或格式），请以其他方式指定选项（例如，使用 -O 或 --sort）。

              对于排序，过时的 BSD O 选项语法是 O[+|-]k1[,[+|-]k2[,...]]。它根据由一系列
              短键 k1,k2,... 描述的多级排序顺序对进程列表进行排序。"+" 目前是可选的，仅
              重申键上的默认方向，但可以帮助区分 O 排序和 O 格式。"–" 仅在其前面的键上反转方向。

       --rows n
              设置屏幕高度。

       S      汇总一些信息，例如 CPU 使用情况，从已死亡的子进程中汇总到它们的父进程中。这对于
              检查一个父进程重复派生短生命周期子进程进行工作的系统很有用。

       --sort spec
              指定排序顺序。排序语法为[+|-]key[,[+|-]key[,...]]。从标准格式说明符部分中选择多
              字母键。由于默认方向是递增的数字或字母顺序，因此“+”是可选的。与 k 相同。
              例如：ps jax --sort=uid,-ppid,+pid

       w      宽输出。此选项使用两次以获得无限宽度。

       -w     宽输出。此选项使用两次以获得无限宽度。

       --width n
              设置屏幕宽度。

线程显示
       H      显示线程，仿佛它们是进程。

       -L     显示线程，可能带有 LWP 和 NLWP 列。

       m      在进程后显示线程。

       -m     在进程后显示线程。

       -T     显示线程，可能带有 SPID 列。
其他信息
       --help section
              打印帮助信息。section 参数可以是 simple, list, output, threads, misc 或 all 之一。
              参数可以缩写为一个下划线字母，如：s|l|o|t|m|a。

       --info 打印调试信息。

       L      列出所有格式说明符。

       V      打印 procps-ng 版本。

       -V     打印 procps-ng 版本。

       --version
              打印 procps-ng 版本。

注意事项
       该 ps 通过读取 /proc 中的虚拟文件工作。此 ps 不需要设置为 setuid kmem 或具有任何权限即可运行。
       不要给予此 ps 任何特殊权限。

       CPU 使用情况目前表示为进程整个生命周期内运行所花费时间的百分比。这并不理想，
       也不符合 ps 其他方面符合的标准。CPU 使用情况不太可能正好加起来为 100%。

       SIZE 和 RSS 字段不包括进程的一些部分，包括页表、内核堆栈、struct thread_info 和
       struct task_struct。这通常至少占用 20 KiB 的常驻内存。SIZE 是进程的虚拟大小（代码 + 数据 + 栈）。

       标记为 <defunct> 的进程是已死进程（所谓的“僵尸”），因为它们的父进程没有正确销毁它们。
       如果父进程退出，这些进程将由 init(8) 销毁。

       如果用户名的长度超过显示列的长度，则用户名将被截断。请参见 -o 和 -O 格式化选项以自定义长度。

       ps -aux 等命令选项不推荐使用，因为它是两个不同标准的混合。根据 POSIX 和 UNIX 标准，
       上述命令要求显示所有具有 TTY 的进程（通常是用户正在运行的命令）以及所有由名为 x 的用户
       拥有的进程。如果该用户不存在，则 ps 将假设您实际上是指 ps aux。

进程标志
       这些值的总和显示在由标志输出说明符提供的“F”列中：

               1    forked 但没有 exec
               4    使用了超级用户权限

进程状态代码
       这里是 s, stat 和 state 输出说明符（标题为“STAT”或“S”）将显示的不同值，以描述进程的状态：

               D    不可中断睡眠（通常为 I/O）
               I    空闲内核线程
               R    运行或可运行（在运行队列中）
               S    可中断睡眠（等待事件完成）
               T    被作业控制信号停止
               t    在跟踪期间被调试器停止
               W    分页（自 2.6.xx 内核以来无效）
               X    死亡（不应看到）
               Z    僵尸进程，已终止但未被其父进程回收

       对于 BSD 格式和使用 stat 关键字时，可能会显示其他字符：

               <    高优先级（对其他用户不友好）
               N    低优先级（对其他用户友好）
               L    页面锁定到内存中（用于实时和自定义 I/O）
               s    是会话领导
               l    是多线程的（使用 CLONE_THREAD，如 NPTL pthreads）
               +    是前台进程组

过时的排序键
       这些键由 BSD O 选项使用（当它用于排序时）。GNU --sort 选项不使用这些键，
       而是使用标准格式说明符部分中描述的说明符。请注意，用于排序的值是 ps 使用的内部值，
       而不是某些输出格式字段中使用的“加工”值（例如，按 tty 排序将排序为设备号，
       而不是根据显示的终端名称排序）。如果您想按加工值排序，请将 ps 输出管道传输到 sort(1) 命令。

       键    长格式         描述
       c     cmd          可执行文件的简单名称
       C     pcpu         CPU 使用率
       f     flags        标志，如长格式 F 字段
       g     pgrp         进程组 ID
       G     tpgid        控制 tty 的进程组 ID
       j     cutime       累计用户时间
       J     cstime       累计系统时间
       k     utime        用户时间
       m     min_flt      次要页面错误数
       M     maj_flt      主要页面错误数
       n     cmin_flt     累计次要页面错误数
       N     cmaj_flt     累计主要页面错误数
       o     session      会话 ID
       p     pid          进程 ID
       P     ppid         父进程 ID
       r     rss          常驻集大小
       R     resident     常驻页面
       s     size         内存大小（以千字节为单位）
       S     share        共享页面的数量
       t     tty          控制 tty 的设备号
       T     start_time   进程开始时间
       U     uid          用户 ID 号
       u     user         用户名
       v     vsize        总虚拟内存大小（以 KiB 为单位）
       y     priority     内核调度优先级
AIX 格式描述符
       该 ps 支持 AIX 格式描述符，其工作方式类似于 printf(1) 和 printf(3) 的格式代码。
       例如，可以使用此命令生成正常的默认输出：ps -eo "%p %y %x %c"。以下是正常代码的描述。

       代码   正常   标题
       %C     pcpu     %CPU
       %G     group    GROUP
       %P     ppid     PPID
       %U     user     USER
       %a     args     COMMAND
       %c     comm     COMMAND
       %g     rgroup   RGROUP
       %n     nice     NI
       %p     pid      PID
       %r     pgid     PGID
       %t     etime    ELAPSED
       %u     ruser    RUSER
       %x     time     TIME
       %y     tty      TTY
       %z     vsz      VSZ

标准格式说明符
       以下是可用于控制输出格式（例如，使用 -o 选项）或使用 GNU 风格 --sort 选项对选定进程进行排序的不同关键字。

       例如：ps -eo pid,user,args --sort user

       此版本的 ps 尝试识别大多数其他 ps 实现中使用的关键字。

       以下用户定义的格式说明符可能包含空格：args, cmd, comm, command, fname, ucmd, ucomm, lstart, bsdstart, start。

       某些关键字可能不可用于排序。

       代码        标题    描述

       %cpu        %CPU    进程的 CPU 利用率，以“##.#”格式表示。目前，它是进程使用的 CPU 时间除以进程运行的时间（cputime/realtime 比率），以百分比表示。不一定加起来为 100%。（别名 pcpu）。

       %mem        %MEM    进程的常驻集大小与机器物理内存的比率，以百分比表示。（别名 pmem）。

       args        COMMAND 命令及其所有参数作为字符串显示。参数的修改可能会显示在内。此列中的输出可能包含空格。标记为 <defunct> 的进程是部分死亡的，等待父进程完全销毁。有时，进程参数不可用；在这种情况下，ps 将打印可执行文件名，括号中显示。（别名 cmd, command）。参见 comm 格式关键字、-f 选项和 c 选项。
                           当最后指定此列时，该列将延伸到显示的边缘。如果 ps 无法确定显示宽度，例如输出被重定向（管道）到文件或其他命令时，输出宽度未定义（可能为 80，或无限，或由 TERM 变量确定，依此类推）。可以使用 COLUMNS 环境变量或 --cols 选项来准确确定此情况的宽度。w 或 -w 选项也可用于调整宽度。

       blocked     BLOCKED 被阻塞信号的掩码，参见 signal(7)。根据字段的宽度，以 32 或 64 位十六进制格式显示掩码。（别名 sig_block, sigmask）。

       bsdstart    START   命令启动时间。如果进程在过去 24 小时内启动，输出格式为“ HH:MM”，否则为“ Mmm:SS”（其中 Mmm 是月份的三个字母）。参见 lstart、start、start_time 和 stime。

       bsdtime     TIME    累计 CPU 时间，用户 + 系统。显示格式通常为“MMM:SS”，但如果进程使用了超过 999 分钟的 CPU 时间，则可以向右移动。

       c           C       处理器利用率。目前，这是进程生命周期内百分比使用率的整数值。（参见 %cpu）。

       caught      CAUGHT  捕获的信号掩码，参见 signal(7)。根据字段的宽度，以 32 或 64 位十六进制格式显示掩码。（别名 sig_catch, sigcatch）。

       cgname      CGNAME  显示进程所属的控制组名称。

       cgroup      CGROUP  显示进程所属的控制组。

       class       CLS     进程的调度类。（别名 policy, cls）。字段的可能值为：

                                      -   未报告
                                      TS  SCHED_OTHER
                                      FF  SCHED_FIFO
                                      RR  SCHED_RR
                                      B   SCHED_BATCH
                                      ISO SCHED_ISO
                                      IDL SCHED_IDLE
                                      DLN SCHED_DEADLINE
                                      ?   未知值

       cls         CLS     进程的调度类。（别名 policy, cls）。字段的可能值为：

                                      -   未报告
                                      TS  SCHED_OTHER
                                      FF  SCHED_FIFO
                                      RR  SCHED_RR
                                      B   SCHED_BATCH
                                      ISO SCHED_ISO
                                      IDL SCHED_IDLE
                                      DLN SCHED_DEADLINE
                                      ?   未知值

       cmd         CMD     参见 args。（别名 args, command）。

       comm        COMMAND 命令名称（仅可执行文件名）。不会显示命令名称的修改。标记为 <defunct> 的进程是部分死亡的，等待父进程完全销毁。此列中的输出可能包含空格。（别名 ucmd, ucomm）。参见 args 格式关键字、-f 选项和 c 选项。
                           当最后指定此列时，该列将延伸到显示的边缘。如果 ps 无法确定显示宽度，例如输出被重定向（管道）到文件或其他命令时，输出宽度未定义（可能为 80，或无限，或由 TERM 变量确定，依此类推）。可以使用 COLUMNS 环境变量或 --cols 选项来准确确定此情况的宽度。w 或 -w 选项也可用于调整宽度。

       command     COMMAND 参见 args。（别名 args, command）。

       cp          CP      每千 CPU 使用率（百分之一的十分之一）。（参见 %cpu）。

       cputime     TIME    累计 CPU 时间，“[DD-]hh:mm:ss”格式。（别名 time）。

       cputimes    TIME    累计 CPU 时间，以秒为单位（别名 times）。

       drs         DRS     数据常驻集大小，分配给非可执行代码的物理内存量。

       egid        EGID    进程的有效组 ID 号，以十进制整数表示。（别名 gid）。

       egroup      EGROUP  进程的有效组 ID。如果可以获得且字段宽度允许，这将是文本组 ID，否则为十进制表示。（别名 group）。

       eip         EIP     指令指针。

       esp         ESP     栈指针。

       etime       ELAPSED 自进程启动以来的经过时间，格式为 [[DD-]hh:]mm:ss。

       etimes      ELAPSED 自进程启动以来的经过时间，以秒为单位。

       euid        EUID    有效用户 ID（别名 uid）。

       euser       EUSER   有效用户名。如果可以获得且字段宽度允许，这将是文本用户 ID，否则为十进制表示。n 选项可以用于强制十进制表示。（别名 uname, user）。

       exe         EXE     可执行文件的路径。如果路径无法通过 cmd、comm 或 args 格式选项打印，则很有用。

       f           F       与进程关联的标志，参见进程标志部分。（别名 flag, flags）。

       fgid        FGID    文件系统访问组 ID。（别名 fsgid）。

       fgroup      FGROUP  文件系统访问组 ID。如果可以获得且字段宽度允许，这将是文本组 ID，否则为十进制表示。（别名 fsgroup）。

       flag        F       参见 f。（别名 f, flags）。

       flags       F       参见 f。（别名 f, flag）。

       fname       COMMAND 进程可执行文件名称的前 8 个字节。此列中的输出可能包含空格。

       fuid        FUID    文件系统访问用户 ID。（别名 fsuid）。

       fuser       FUSER   文件系统访问用户 ID。如果可以获得且字段宽度允许，这将是文本用户 ID，否则为十进制表示。

       gid         GID     参见 egid。（别名 egid）。

       group       GROUP   参见 egroup。（别名 egroup）。

       ignored     IGNORED 被忽略信号的掩码，参见 signal(7)。根据字段的宽度，以 32 或 64 位十六进制格式显示掩码。（别名 sig_ignore, sigignore）。

       ipcns       IPCNS   描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       label       LABEL   安全标签，最常用于 SELinux 上下文数据。这适用于高安全系统上的强制访问控制（“MAC”）。

       lstart      STARTED 命令启动时间。参见 bsdstart、start、start_time 和 stime。

       lsession    SESSION 显示进程的登录会话标识符（如果包含 systemd 支持）。

       luid        LUID    显示与进程关联的登录 ID。

       lwp         LWP     可调度实体的轻量级进程（线程）ID（别名 spid, tid）。参见 tid 获取其他信息。

       lxc         LXC     显示任务运行所在的 lxc 容器名称。如果进程未在容器内运行，则显示一个破折号（‘-’）。

       machine     MACHINE 显示分配给 VM 或容器的进程的机器名称（如果包含 systemd 支持）。

       maj_flt     MAJFLT  此进程发生的主要页面错误数。

       min_flt     MINFLT  此进程发生的次要页面错误数。

       mntns       MNTNS   描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       netns       NETNS   描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       ni          NI      nice 值。范围从 19（最友好）到 -20（对其他用户不友好），参见 nice(1)。（别名 nice）。

       nice        NI      参见 ni。（别名 ni）。

       nlwp        NLWP    进程中的 lwps（线程）数量。（别名 thcount）。

       numa        NUMA    与最近使用的处理器相关联的节点。-1 表示 NUMA 信息不可用。

       nwchan      WCHAN   进程正在休眠的内核函数的地址（如果您想要内核函数名称，请使用 wchan）。运行中的任务将在此列中显示一个破折号（‘-’）。

       ouid        OWNER   显示进程会话所有者的 Unix 用户标识符（如果包含 systemd 支持）。

       pcpu        %CPU    参见 %cpu。（别名 %cpu）。

       pending     PENDING 挂起信号的掩码。参见 signal(7)。挂起在进程上的信号与挂起在单个线程上的信号不同。使用 m 选项或 -m 选项查看两者。根据字段的宽度，以 32 或 64 位十六进制格式显示掩码。（别名 sig）。

       pgid        PGID    进程组 ID，或相当于进程组领导者的进程 ID。（别名 pgrp）。

       pgrp        PGRP    参见 pgid。（别名 pgid）。

       pid         PID     表示进程 ID 的数字（别名 tgid）。

       pidns       PIDNS   描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       pmem        %MEM    参见 %mem。（别名 %mem）。

       policy      POL     进程的调度类。（别名 class, cls）。可能的值为：

                                      -   未报告
                                      TS  SCHED_OTHER
                                      FF  SCHED_FIFO
                                      RR  SCHED_RR
                                      B   SCHED_BATCH
                                      ISO SCHED_ISO
                                      IDL SCHED_IDLE
                                      DLN SCHED_DEADLINE
                                      ?   未知值

       ppid        PPID    父进程 ID。

       pri         PRI     进程的优先级。数值越高，优先级越低。

       psr         PSR     当前分配给进程的处理器。

       rgid        RGID    实际组 ID。

       rgroup      RGROUP  实际组名。如果可以获得且字段宽度允许，这将是文本组 ID，否则为十进制表示。

       rss         RSS     常驻集大小，任务使用的非交换物理内存（以千字节为单位）。（别名 rssize, rsz）。

       rssize      RSS     参见 rss。（别名 rss, rsz）。

       rsz         RSZ     参见 rss。（别名 rss, rssize）。

       rtprio      RTPRIO  实时优先级。

       ruid        RUID    实际用户 ID。

       ruser       RUSER   实际用户 ID。如果可以获得且字段宽度允许，这将是文本用户 ID，否则为十进制表示。

       s           S       最小状态显示（一个字符）。有关不同值的含义，请参见进程状态代码部分。参见 stat 以显示其他信息。（别名 state）。

       sched       SCH     进程的调度策略。调度策略 SCHED_OTHER (SCHED_NORMAL), SCHED_FIFO, SCHED_RR, SCHED_BATCH, SCHED_ISO, SCHED_IDLE 和 SCHED_DEADLINE 分别显示为 0, 1, 2, 3, 4, 5 和 6。

       seat        SEAT    显示与特定工作区分配的所有硬件设备相关联的标识符（如果包含 systemd 支持）。

       sess        SESS    会话 ID，或相当于会话领导者的进程 ID。（别名 session, sid）。

       sgi_p       P       进程当前正在执行的处理器。显示“*”如果进程当前未运行或不可运行。

       sgid        SGID    保存的组 ID。（别名 svgid）。

       sgroup      SGROUP  保存的组名。如果可以获得且字段宽度允许，这将是文本组 ID，否则为十进制表示。

       sid         SID     参见 sess。（别名 sess, session）。

       sig         PENDING 参见 pending。（别名 pending, sig_pend）。

       sigcatch    CAUGHT  参见 caught。（别名 caught, sig_catch）。

       sigignore   IGNORED 参见 ignored。（别名 ignored, sig_ignore）。

       sigmask     BLOCKED 参见 blocked。（别名 blocked, sig_block）。

       size        SIZE    进程使用的近似交换空间大小（如果进程将所有可写页面弄脏然后被交换出去）。这个数字非常粗略！

       slice       SLICE   显示进程所属的切片单元（如果包含 systemd 支持）。

       spid        SPID    参见 lwp。（别名 lwp, tid）。

       stackp      STACKP  进程栈底（开始）地址。

       start       STARTED 命令启动时间。如果进程在过去 24 小时内启动，输出格式为“HH:MM:SS”，否则为“  Mmm dd”（其中 Mmm 是三字母月份名称）。参见 lstart、bsdstart、start_time 和 stime。

       start_time  START   进程的启动时间或日期。仅当进程未在调用 ps 的同一年启动时，才会显示年份，或“ MmmDD”（如果不是同一天启动），或“HH:MM”（否则）。参见 bsdstart、start、lstart 和 stime。

       stat        STAT    多字符进程状态。有关不同值的含义，请参见进程状态代码部分。参见 s 和 state 如果您只想显示第一个字符。（别名 state）。

       state       S       参见 s。（别名 s）。

       stime       STIME   参见 start_time。（别名 start_time）。

       suid        SUID    保存的用户 ID。（别名 svuid）。

       supgid      SUPGID  补充组的组 ID（如果有）。参见 getgroups(2)。

       supgrp      SUPGRP  补充组的组名（如果有）。参见 getgroups(2)。

       suser       SUSER   保存的用户名。如果可以获得且字段宽度允许，这将是文本用户 ID，否则为十进制表示。（别名 svuser）。

       svgid       SVGID   参见 sgid。（别名 sgid）。

       svuid       SVUID   参见 suid。（别名 suid）。

       sz          SZ      进程的核心映像的物理页面大小。这包括文本、数据和栈空间。设备映射当前被排除；此状况可能会更改。参见 vsz 和 rss。

       tgid        TGID    表示任务所属的线程组的数字（别名 pid）。它是线程组领导者的进程 ID。

       thcount     THCNT   参见 nlwp。（别名 nlwp）。进程拥有的内核线程数量。

       tid         TID     表示可调度实体的唯一编号（别名 lwp, spid）。此值也可能显示为：进程 ID (pid)；进程组 ID (pgrp)；会话 ID（对于会话领导者）(sid)；线程组 ID（对于线程组领导者）(tgid)；以及 tty 进程组 ID（对于进程组领导者）(tpgid)。

       time        TIME    累计 CPU 时间，“[DD-]HH:MM:SS”格式。（别名 cputime）。

       times       TIME    累计 CPU 时间，以秒为单位
       times       TIME    累计 CPU 时间，以秒为单位（别名 cputimes）。

       tname       TTY     控制 tty（终端）。（别名 tt, tty）。

       tpgid       TPGID   连接到 tty（终端）的前台进程组的 ID，如果进程未连接到 tty，则为 -1。

       trs         TRS     文本常驻集大小，分配给可执行代码的物理内存量。

       tt          TT      控制 tty（终端）。（别名 tname, tty）。

       tty         TT      控制 tty（终端）。（别名 tname, tt）。

       ucmd        CMD     参见 comm。（别名 comm, ucomm）。

       ucomm       COMMAND 参见 comm。（别名 comm, ucmd）。

       uid         UID     参见 euid。（别名 euid）。

       uname       USER    参见 euser。（别名 euser, user）。

       unit        UNIT    显示进程所属的单元（如果包含 systemd 支持）。

       user        USER    参见 euser。（别名 euser, uname）。

       userns      USERNS  描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       utsns       UTSNS   描述进程所属的命名空间的唯一 inode 号。参见 namespaces(7)。

       uunit       UUNIT   显示进程所属的用户单元（如果包含 systemd 支持）。

       vsize       VSZ     参见 vsz。（别名 vsz）。

       vsz         VSZ     进程的虚拟内存大小，以 KiB（1024 字节为单位）表示。设备映射当前被排除；此状况可能会更改。（别名 vsize）。

       wchan       WCHAN   进程正在休眠的内核函数名称，如果进程正在运行，则为“-”，如果进程是多线程且 ps 未显示线程，则为“*”。

环境变量
       以下环境变量可能会影响 ps：

       COLUMNS
              覆盖默认显示宽度。

       LINES
              覆盖默认显示高度。

       PS_PERSONALITY
              设置为 posix, old, linux, bsd, sun, digital... 之一（参见下文个性部分）。

       CMD_ENV
              设置为 posix, old, linux, bsd, sun, digital... 之一（参见下文个性部分）。

       I_WANT_A_BROKEN_PS
              强制使用过时的命令行解释。

       LC_TIME
              日期格式。

       PS_COLORS
              当前不支持。

       PS_FORMAT
              默认输出格式覆盖。您可以将其设置为用于 -o 选项的格式字符串。DefSysV 和 DefBSD 值特别有用。

       POSIXLY_CORRECT
              不找借口忽略坏的“特性”。

       POSIX2
              设置为“on”时，表现为 POSIXLY_CORRECT。

       UNIX95
              不找借口忽略坏的“特性”。

       _XPG
              取消 CMD_ENV=irix 的非标准行为。

       一般来说，设置这些变量是个坏主意。唯一的例外是 CMD_ENV 或 PS_PERSONALITY，可以设置为 Linux 以用于正常系统。如果没有该设置，ps 将遵循 Unix98 标准中的无用和不良部分。

个性
       390        类似 OS/390 OpenEdition ps
       aix        类似 AIX ps
       bsd        类似 FreeBSD ps（完全非标准）
       compaq     类似 Digital Unix ps
       debian     类似旧版 Debian ps
       digital    类似 Tru64（曾是 Digital Unix，曾是 OSF/1）ps
       gnu        类似旧版 Debian ps
       hp         类似 HP-UX ps
       hpux       类似 HP-UX ps
       irix       类似 Irix ps
       linux      ***** 推荐 *****
       old        类似原始 Linux ps（完全非标准）
       os390      类似 OS/390 Open Edition ps
       posix      标准
       s390       类似 OS/390 Open Edition ps
       sco        类似 SCO ps
       sgi        类似 Irix ps
       solaris2   类似 Solaris 2+ (SunOS 5) ps
       sunos4     类似 SunOS 4 (Solaris 1) ps（完全非标准）
       svr4       标准
       sysv       标准
       tru64      类似 Tru64（曾是 Digital Unix，曾是 OSF/1）ps
       unix       标准
       unix95     标准
       unix98     标准

另见
       pgrep(1), pstree(1), top(1), proc(5).

标准
       此 ps 符合以下标准：

       1   单一 Unix 规范版本 2
       2   开放组技术标准基础规范，第 6 版
       3   IEEE Std 1003.1, 2004 版
       4   X/Open 系统接口扩展 [UP XSI]
       5   ISO/IEC 9945:2003

作者
       ps 最初由 Branko Lankester ⟨lankeste@fwi.uva.nl⟩ 编写。Michael K. Johnson ⟨johnsonm@redhat.com⟩ 
       进行了重大重写以使用 proc 文件系统，并在此过程中更改了一些内容。Michael Shields ⟨mjshield@nyx.cs.du.edu⟩ 
       添加了 pid 列表功能。Charles Blake ⟨cblake@bbn.com⟩ 添加了多级排序、dirent 风格库、设备名称到编号的映射数据库、
       System.map 上的近似二进制搜索，以及许多代码和文档清理。David Mossberger-Tang 为 psupdate 编写了通用 BFD 支持。
       Albert Cahalan ⟨albert@users.sf.net⟩ 重写了 ps 以完全支持 Unix98 和 BSD，以及一些丑陋的黑客处理过时和外来语法。

       请将错误报告发送到 ⟨procps@freelists.org⟩。无需订阅或建议订阅。

procps-ng                                           2020-06-04                                               PS(1)


```




https://man7.org/linux/man-pages/man1/ps.1.html