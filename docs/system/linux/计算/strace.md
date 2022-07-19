# strace命令

strace有两种运行模式

### 方式一

通过它启动要跟踪的进程，在原本的命令前加上strace即可。比如要跟踪 `ls -lh /var/log/messages`  这个命令的执行，可以这样：

```bash
strace ls -lh /var/log/messages
```

### 方式二

跟踪已经在运行的进程，-p pid 选项即可，比如，有个在运行的some_server服务，查看pid，然后跟踪

```bash
pidof some_server
17553
strace -p 17553
按ctrl + C 结束strace即可
```


strace有一些选项可以调整其行为，我们这里介绍下其中几个比较常用的，然后通过示例讲解其实际应用效果。

#### 示例命令：

```bash
strace -tt -T -v -f -e trace=file -o /data/log/strace.log -s 1024 -p 23489
查看进程调用了哪些文件
-tt 在每行输出的前面，显示毫秒级别的时间
-T 显示每次系统调用所花费的时间
-v 对于某些相关调用，把完整的环境变量，文件stat结构等打出来。
-f 跟踪目标进程，以及目标进程创建的所有子进程
-e 控制要跟踪的事件和跟踪行为,比如指定要跟踪的系统调用名称
-o 把strace的输出单独写到指定的文件
-s 当系统调用的某个参数是字符串时，最多输出指定长度的内容，默认是32个字节
-p 指定要跟踪的进程pid, 要同时跟踪多个pid, 重复多次-p选项即可。
```

跟踪nginx, 看其启动时都访问了哪些文件

```bash
strace -tt -T -f -e trace=file -o /data/log/strace.log -s 1024 ./nginx
```

不指定记录类型

```
strace -tt -T -f -o /tmp/strace.log -s 1024 -p  进程号
```



#### 系统调用接口查询

https://man7.org/linux/man-pages/man2/syscalls.2.html



### strace参数

```
-c 统计每一系统调用的所执行的时间,次数和出错的次数等. 
-d 输出strace关于标准错误的调试信息. 
-f 跟踪由fork调用所产生的子进程. 
-ff 如果提供-o filename,则所有进程的跟踪结果输出到相应的filename.pid中,pid是各进程的进程号.
常与-o选项一起使用，不同进程(子进程)产生的系统调用输出到filename.PID文 
-F 尝试跟踪vfork调用.在-f时,vfork不被跟踪. 
-h 输出简要的帮助信息. 
-i 输出系统调用的入口指针. 
-q 禁止输出关于脱离的消息. 
-r 打印出相对时间关于,每一个系统调用. 
-t 在输出中的每一行前加上时间信息. 
-tt 在输出中的每一行前加上时间信息,微秒级. 
-ttt 微秒级输出,以秒了表示时间. 
-T 显示每一调用所耗的时间. 
-v 输出所有的系统调用.一些调用关于环境变量,状态,输入输出等调用由于使用频繁,默认不输出. 
-V 输出strace的版本信息. 
-x 以十六进制形式输出非标准字符串 
-xx 所有字符串以十六进制形式输出. 
-a column 
设置返回值的输出位置.默认 为40. 
-e expr 
指定一个表达式,用来控制如何跟踪.格式如下: 
[qualifier=][!]value1[,value2]... 
qualifier只能是 trace,abbrev,verbose,raw,signal,read,write其中之一.value是用来限定的符号或数字.默认的 qualifier是 trace.感叹号是否定符号.例如: 
-eopen等价于 -e trace=open,表示只跟踪open调用.而-etrace!=open表示跟踪除了open以外的其他调用.有两个特殊的符号 all 和 none. 注意有些shell使用!来执行历史记录里的命令,所以要使用\\. 
-e trace= 
只跟踪指定的系统 调用.例如:-e trace=open,close,rean,write表示只跟踪这四个系统调用.默认的为set=all. 
-e trace=file 
只跟踪有关文件操作的系统调用. 
-e trace=process 
只跟踪有关进程控制的系统调用. 
-e trace=network 
跟踪与网络有关的所有系统调用. 
-e strace=signal 
跟踪所有与系统信号有关的 系统调用 
-e trace=ipc 
跟踪所有与进程通讯有关的系统调用 
-e abbrev= 
设定 strace输出的系统调用的结果集.-v 等与 abbrev=none.默认为abbrev=all. 
-e raw= 
将指 定的系统调用的参数以十六进制显示. 
-e signal= 
指定跟踪的系统信号.默认为all.如 signal=!SIGIO(或者signal=!io),表示不跟踪SIGIO信号. 
-e read= 
输出从指定文件中读出 的数据.例如: 
-e read=, 
-e write= 
输出写入到指定文件中的数据. 
-o filename 
将strace的输出写入文件filename 
-p pid 
跟踪指定的进程pid. 
-s strsize 
指定输出的字符串的最大长度.默认为32.文件名一直全部输出. 
-u username 
以username 的UID和GID执行被跟踪的命令 
```

通用的完整用法：

```bash
strace -o output.txt -T -tt -e trace=all -p 28979
```

上面的含义是跟踪28979进程的所有系统调用（-e trace=all），并统计系统调用的花费时间，以及开始时间（并以可视化的时分秒格式显示），最后将记录结果存在output.txt文件里面。

语法

```bash
strace [ -dffhiqrtttTvxx ] [ -acolumn ] [ -eexpr ] ... [ -ofile ] [-ppid ] ... [ -sstrsize ] [ -uusername ] [ -Evar=val ] ... [ -Evar ]... [ command [ arg ... ] ]

strace -c [ -eexpr ] ... [ -Ooverhead ] [ -Ssortby ] [ command [ arg... ] ]
```



### strace统计

-c 统计每一系统调用的所执行的时间,次数和出错的次数等. 

- % time：执行耗时占总时间百分比 
- seconds：执行总时间 
- usecs/call：单个命令执行时间 
- calls：调用次数 
- errors: 出错次数 
- syscall: 系统调用

<img src="https://raw.githubusercontent.com/yinzhipeng123/Picture_Bed/main/202207200135326.png" style="zoom:150%;" />





文章：

https://www.cnblogs.com/machangwei-8/p/10388883.html

https://www.linuxidc.com/Linux/2018-01/150654.htm

https://blog.csdn.net/dianfu2892/article/details/101466665